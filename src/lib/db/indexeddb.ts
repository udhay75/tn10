// ============================================================================
// IndexedDB Client Storage Layer for Offline-First Operation
// Using 'idb' wrapper for robust promise-based transaction management.
// ============================================================================

import { openDB, IDBPDatabase } from 'idb';
import { 
  CurriculumData, 
  StudentProgress, 
  RevisionHistoryEntry, 
  SyncMutation 
} from '@/types';

const DB_NAME = 'TN10_STUDY_DB';
const DB_VERSION = 1;

let dbPromise: Promise<IDBPDatabase> | null = null;

export function getDB(): Promise<IDBPDatabase> {
  if (typeof window === 'undefined') {
    return Promise.reject(new Error('IndexedDB is only accessible in browser environment'));
  }

  if (!dbPromise) {
    dbPromise = openDB(DB_NAME, DB_VERSION, {
      upgrade(db) {
        // 1. Curriculum Cache Store
        if (!db.objectStoreNames.contains('curriculum')) {
          db.createObjectStore('curriculum', { keyPath: 'id' });
        }

        // 2. Student Progress Store (Account-Scoped)
        if (!db.objectStoreNames.contains('student_progress')) {
          const progressStore = db.createObjectStore('student_progress', { keyPath: 'id' });
          progressStore.createIndex('student_id', 'student_id', { unique: false });
          progressStore.createIndex('item_code', 'item_code', { unique: false });
          progressStore.createIndex('student_study_again', ['student_id', 'study_again'], { unique: false });
          progressStore.createIndex('student_completion', ['student_id', 'completion_status'], { unique: false });
        }

        // 3. Revision History Store
        if (!db.objectStoreNames.contains('revision_history')) {
          const revStore = db.createObjectStore('revision_history', { keyPath: 'id' });
          revStore.createIndex('student_id', 'student_id', { unique: false });
          revStore.createIndex('item_code', 'item_code', { unique: false });
          revStore.createIndex('revision_date', 'revision_date', { unique: false });
        }

        // 4. Persistent Offline Mutation Queue
        if (!db.objectStoreNames.contains('sync_queue')) {
          const queueStore = db.createObjectStore('sync_queue', { keyPath: 'id' });
          queueStore.createIndex('student_id', 'student_id', { unique: false });
          queueStore.createIndex('status', 'status', { unique: false });
          queueStore.createIndex('timestamp', 'timestamp', { unique: false });
        }

        // 5. App Metadata (session, active account, sync state)
        if (!db.objectStoreNames.contains('app_meta')) {
          db.createObjectStore('app_meta', { keyPath: 'key' });
        }
      },
    });
  }
  return dbPromise;
}

// ----------------------------------------------------------------------------
// Curriculum Cache Helpers
// ----------------------------------------------------------------------------
export async function cacheCurriculum(curriculum: CurriculumData, subjectCode?: string): Promise<void> {
  const db = await getDB();
  const tx = db.transaction('curriculum', 'readwrite');
  const key = subjectCode ? `curriculum_${subjectCode}` : (curriculum.subject?.code ? `curriculum_${curriculum.subject.code}` : 'active_curriculum');
  await tx.store.put({ id: key, data: curriculum, cached_at: Date.now() });
  // Also keep active_curriculum updated for backward compatibility
  await tx.store.put({ id: 'active_curriculum', data: curriculum, cached_at: Date.now() });
  await tx.done;
}

export async function getCachedCurriculum(subjectCode?: string): Promise<CurriculumData | null> {
  const db = await getDB();
  const key = subjectCode ? `curriculum_${subjectCode}` : 'active_curriculum';
  const record = await db.get('curriculum', key);
  return record ? record.data : null;
}

// ----------------------------------------------------------------------------
// Student Progress Helpers (Strict Account Isolation)
// ----------------------------------------------------------------------------
export async function getStudentProgressList(studentId: string): Promise<StudentProgress[]> {
  const db = await getDB();
  const tx = db.transaction('student_progress', 'readonly');
  const index = tx.store.index('student_id');
  return await index.getAll(studentId);
}

export async function getItemProgress(studentId: string, itemCode: string): Promise<StudentProgress | null> {
  const db = await getDB();
  const id = `${studentId}_${itemCode}`;
  const record = await db.get('student_progress', id);
  return record || null;
}

export async function saveItemProgressLocal(progress: StudentProgress): Promise<void> {
  const db = await getDB();
  const tx = db.transaction('student_progress', 'readwrite');
  await tx.store.put(progress);
  await tx.done;
}

// ----------------------------------------------------------------------------
// Revision History Helpers
// ----------------------------------------------------------------------------
export async function getStudentRevisionHistory(studentId: string): Promise<RevisionHistoryEntry[]> {
  const db = await getDB();
  const tx = db.transaction('revision_history', 'readonly');
  const index = tx.store.index('student_id');
  return await index.getAll(studentId);
}

export async function saveRevisionHistoryEntry(entry: RevisionHistoryEntry): Promise<void> {
  const db = await getDB();
  const tx = db.transaction('revision_history', 'readwrite');
  await tx.store.put(entry);
  await tx.done;
}

// ----------------------------------------------------------------------------
// Offline Sync Queue Helpers
// ----------------------------------------------------------------------------
export async function enqueueMutation(mutation: SyncMutation): Promise<void> {
  const db = await getDB();
  const tx = db.transaction('sync_queue', 'readwrite');
  await tx.store.put(mutation);
  await tx.done;
}

export async function getPendingMutations(studentId: string): Promise<SyncMutation[]> {
  const db = await getDB();
  const tx = db.transaction('sync_queue', 'readonly');
  const index = tx.store.index('student_id');
  const all = await index.getAll(studentId);
  return all.filter((m) => m.status === 'pending' || m.status === 'failed');
}

export async function getUnsyncedCount(studentId: string): Promise<number> {
  const pending = await getPendingMutations(studentId);
  return pending.length;
}

export async function updateMutationStatus(
  id: string, 
  status: SyncMutation['status'], 
  errorMessage?: string
): Promise<void> {
  const db = await getDB();
  const tx = db.transaction('sync_queue', 'readwrite');
  const item = await tx.store.get(id);
  if (item) {
    item.status = status;
    item.attempts = (item.attempts || 0) + 1;
    if (errorMessage) item.error_message = errorMessage;
    await tx.store.put(item);
  }
  await tx.done;
}

export async function removeMutation(id: string): Promise<void> {
  const db = await getDB();
  const tx = db.transaction('sync_queue', 'readwrite');
  await tx.store.delete(id);
  await tx.done;
}

// ----------------------------------------------------------------------------
// Account-Scoped Isolation & Cleanup on Logout
// ----------------------------------------------------------------------------
export async function clearStudentAccountData(studentId: string): Promise<void> {
  const db = await getDB();
  
  // 1. Delete student progress records
  const txProgress = db.transaction('student_progress', 'readwrite');
  const progressIndex = txProgress.store.index('student_id');
  let cursorProgress = await progressIndex.openCursor(studentId);
  while (cursorProgress) {
    await cursorProgress.delete();
    cursorProgress = await cursorProgress.continue();
  }
  await txProgress.done;

  // 2. Delete student revision history records
  const txRev = db.transaction('revision_history', 'readwrite');
  const revIndex = txRev.store.index('student_id');
  let cursorRev = await revIndex.openCursor(studentId);
  while (cursorRev) {
    await cursorRev.delete();
    cursorRev = await cursorRev.continue();
  }
  await txRev.done;

  // 3. Clear student sync queue
  const txQueue = db.transaction('sync_queue', 'readwrite');
  const queueIndex = txQueue.store.index('student_id');
  let cursorQueue = await queueIndex.openCursor(studentId);
  while (cursorQueue) {
    await cursorQueue.delete();
    cursorQueue = await cursorQueue.continue();
  }
  await txQueue.done;
}

// ----------------------------------------------------------------------------
// App Metadata Store
// ----------------------------------------------------------------------------
export async function getAppMeta(key: string): Promise<any> {
  try {
    const db = await getDB();
    const record = await db.get('app_meta', key);
    if (record !== undefined && record !== null) {
      return record.value;
    }
  } catch (err) {
    console.warn(`IndexedDB getAppMeta('${key}') note:`, err);
  }

  // Fallback to localStorage
  if (typeof window !== 'undefined') {
    try {
      const stored = localStorage.getItem(`app_meta_${key}`);
      return stored ? JSON.parse(stored) : null;
    } catch {
      return null;
    }
  }
  return null;
}

export async function setAppMeta(key: string, value: any): Promise<void> {
  // Always mirror to localStorage synchronously for instant retrieval
  if (typeof window !== 'undefined') {
    try {
      if (value === null || value === undefined) {
        localStorage.removeItem(`app_meta_${key}`);
      } else {
        localStorage.setItem(`app_meta_${key}`, JSON.stringify(value));
      }
    } catch {}
  }

  try {
    const db = await getDB();
    const tx = db.transaction('app_meta', 'readwrite');
    await tx.store.put({ key, value, updated_at: Date.now() });
    await tx.done;
  } catch (err) {
    console.warn(`IndexedDB setAppMeta('${key}') note:`, err);
  }
}

