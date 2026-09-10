// ============================================================================
// Sync Manager: Handles multi-trigger offline queue replay, conflict detection,
// safe retry idempotency, and network connectivity state.
// ============================================================================

import { 
  SyncMutation, 
  SyncStatusState, 
  StudentProgress, 
  RevisionHistoryEntry 
} from '@/types';
import { 
  getPendingMutations, 
  removeMutation, 
  updateMutationStatus, 
  saveItemProgressLocal, 
  getItemProgress 
} from '@/lib/db/indexeddb';
import { getSupabaseClient, isSupabaseConfigured } from '@/lib/supabase/client';

type SyncListener = (status: SyncStatusState, unsyncedCount: number) => void;

class SyncManager {
  private listeners: Set<SyncListener> = new Set();
  private isSyncing = false;
  private currentStatus: SyncStatusState = 'synced';
  private currentStudentId: string | null = null;
  private onlineStatus = typeof window !== 'undefined' ? navigator.onLine : true;

  constructor() {
    if (typeof window !== 'undefined') {
      window.addEventListener('online', () => this.handleOnline());
      window.addEventListener('offline', () => this.handleOffline());
      document.addEventListener('visibilitychange', () => {
        if (document.visibilityState === 'visible') {
          this.triggerSync('foreground');
        }
      });
      window.addEventListener('focus', () => this.triggerSync('focus'));
    }
  }

  public setStudentId(id: string | null) {
    this.currentStudentId = id;
    this.refreshStatus();
  }

  public subscribe(listener: SyncListener): () => void {
    this.listeners.add(listener);
    this.notify();
    return () => {
      this.listeners.delete(listener);
    };
  }

  private notify() {
    const unsyncedPromise = this.currentStudentId 
      ? getPendingMutations(this.currentStudentId).then((m) => m.length) 
      : Promise.resolve(0);

    unsyncedPromise.then((count) => {
      this.listeners.forEach((listener) => listener(this.currentStatus, count));
    });
  }

  private handleOnline() {
    this.onlineStatus = true;
    this.triggerSync('network_online');
  }

  private handleOffline() {
    this.onlineStatus = false;
    this.currentStatus = 'offline';
    this.notify();
  }

  public async refreshStatus(): Promise<void> {
    if (!this.onlineStatus) {
      this.currentStatus = 'offline';
      this.notify();
      return;
    }

    if (!this.currentStudentId) {
      this.currentStatus = 'synced';
      this.notify();
      return;
    }

    const pending = await getPendingMutations(this.currentStudentId);
    if (pending.length > 0) {
      this.currentStatus = 'unsynced';
    } else {
      this.currentStatus = 'synced';
    }
    this.notify();
  }

  public async triggerSync(reason: string = 'manual'): Promise<{ success: boolean; error?: string }> {
    if (!this.onlineStatus) {
      this.currentStatus = 'offline';
      this.notify();
      return { success: false, error: 'Device is offline' };
    }

    if (!this.currentStudentId) {
      return { success: true };
    }

    if (this.isSyncing) {
      return { success: true };
    }

    const pending = await getPendingMutations(this.currentStudentId);
    if (pending.length === 0) {
      this.currentStatus = 'synced';
      this.notify();
      return { success: true };
    }

    this.isSyncing = true;
    this.currentStatus = 'syncing';
    this.notify();

    // If Supabase is not configured, sync with local Docker PostgreSQL API endpoints!
    if (!isSupabaseConfigured) {
      try {
        for (const mutation of pending) {
          if (mutation.action === 'upsert_progress') {
            const payload = mutation.payload as StudentProgress;
            const res = await fetch('/api/progress', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(payload),
            });
            if (!res.ok) {
              const errData = await res.json().catch(() => ({}));
              throw new Error(errData.error || `HTTP ${res.status}`);
            }
          } else if (mutation.action === 'log_revision') {
            const payload = mutation.payload as RevisionHistoryEntry;
            const res = await fetch('/api/revision', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(payload),
            });
            if (!res.ok) {
              const errData = await res.json().catch(() => ({}));
              throw new Error(errData.error || `HTTP ${res.status}`);
            }
          }
          await removeMutation(mutation.id);
        }
        this.currentStatus = 'synced';
        this.notify();
        return { success: true };
      } catch (err: any) {
        console.warn('Docker DB sync fallback:', err.message);
        // If offline or local api unreachable, keep in IndexedDB queue
        this.currentStatus = 'unsynced';
        this.notify();
        return { success: false, error: err.message };
      } finally {
        this.isSyncing = false;
      }
    }

    // Supabase production sync
    const supabase = getSupabaseClient();
    if (!supabase) {
      this.currentStatus = 'synced';
      this.notify();
      this.isSyncing = false;
      return { success: true };
    }

    try {
      for (const mutation of pending) {
        await updateMutationStatus(mutation.id, 'syncing');

        if (mutation.action === 'upsert_progress') {
          const payload = mutation.payload as StudentProgress;
          
          // 1. Fetch remote record to verify conflicting note updates
          const { data: remoteRecord, error: fetchErr } = await supabase
            .from('student_item_progress')
            .select('*')
            .eq('student_id', mutation.student_id)
            .eq('item_code', payload.item_code)
            .maybeSingle();

          if (fetchErr) throw fetchErr;

          if (remoteRecord) {
            // Check if remote note was modified after local base version
            const remoteNoteTime = remoteRecord.notes_updated_at ? new Date(remoteRecord.notes_updated_at).getTime() : 0;
            const localBaseTime = mutation.base_version || 0;
            
            if (
              remoteNoteTime > localBaseTime && 
              remoteRecord.personal_notes && 
              payload.personal_notes && 
              remoteRecord.personal_notes !== payload.personal_notes
            ) {
              // Conflict detected! Preserve BOTH versions without silent overwrite.
              const conflictedProgress: StudentProgress = {
                ...payload,
                conflict_notes: {
                  local: payload.personal_notes,
                  remote: remoteRecord.personal_notes,
                  remote_updated_at: remoteRecord.notes_updated_at
                }
              };
              await saveItemProgressLocal(conflictedProgress);
              await updateMutationStatus(mutation.id, 'conflict', 'Note conflict detected with server');
              continue;
            }
          }

          // Idempotent upsert to Supabase
          const { error: upsertErr } = await supabase
            .from('student_item_progress')
            .upsert({
              student_id: payload.student_id,
              item_code: payload.item_code,
              completion_status: payload.completion_status,
              understanding_status: payload.understanding_status,
              study_again: payload.study_again,
              personal_notes: payload.personal_notes,
              notes_updated_at: payload.notes_updated_at,
              last_studied_at: payload.last_studied_at,
              next_revision_date: payload.next_revision_date,
              sync_version: (payload.sync_version || 1) + 1,
              updated_at: new Date().toISOString()
            }, {
              onConflict: 'student_id,item_code'
            });

          if (upsertErr) throw upsertErr;

        } else if (mutation.action === 'log_revision') {
          const payload = mutation.payload as RevisionHistoryEntry;
          const { error: revErr } = await supabase
            .from('revision_history')
            .insert({
              student_id: payload.student_id,
              item_code: payload.item_code,
              revision_date: payload.revision_date,
              notes_snapshot: payload.notes_snapshot,
              outcome: payload.outcome,
              still_needs_revision: payload.still_needs_revision
            });

          if (revErr) throw revErr;
        }

        // Mutation succeeded: remove from persistent queue
        await removeMutation(mutation.id);
      }

      this.currentStatus = 'synced';
      this.notify();
      return { success: true };
    } catch (err: any) {
      console.error('Sync failed:', err);
      this.currentStatus = 'error';
      this.notify();
      return { success: false, error: err.message || 'Sync failed' };
    } finally {
      this.isSyncing = false;
    }
  }
}

export const syncManager = new SyncManager();
