'use client';

// ============================================================================
// Study Context & Reactive Store
// Tri-Subject Architecture: Science (2024), Mathematics (2025) & English (2024)
// Strictly separates Completion from Understanding and Study Again flags.
// ============================================================================

import React, { createContext, useContext, useEffect, useState, useMemo, useCallback } from 'react';
import englishCurriculumRaw from '@/data/class_10_english_2024.json';
import mathCurriculumRaw from '@/data/class_10_math_2025.json';
import scienceCurriculumRaw from '@/data/class_10_science_2024.json';
import socialScienceCurriculumRaw from '@/data/class_10_social_science_2025.json';
import tamilCurriculumRaw from '@/data/class_10_tamil_2025.json';
import { 
  CurriculumData, 
  Lesson, 
  Unit, 
  ChecklistItem, 
  StudentProgress, 
  CompletionStatus, 
  UnderstandingStatus, 
  RevisionHistoryEntry, 
  SyncStatusState,
  SyncMutation,
  SubjectCode
} from '@/types';
import { useAuth } from '@/lib/auth/auth-context';
import { 
  cacheCurriculum, 
  getCachedCurriculum, 
  getStudentProgressList, 
  saveItemProgressLocal, 
  getStudentRevisionHistory, 
  saveRevisionHistoryEntry, 
  enqueueMutation, 
  getAppMeta, 
  setAppMeta 
} from '@/lib/db/indexeddb';
import { syncManager } from '@/lib/sync/sync-manager';

const englishCurriculum = englishCurriculumRaw as unknown as CurriculumData;
const mathCurriculum = mathCurriculumRaw as unknown as CurriculumData;
const scienceCurriculum = scienceCurriculumRaw as unknown as CurriculumData;
const socialScienceCurriculum = socialScienceCurriculumRaw as unknown as CurriculumData;
const tamilCurriculum = tamilCurriculumRaw as unknown as CurriculumData;

export interface LessonProgressStats {
  total: number;
  completed: number;
  inProgress: number;
  studyAgain: number;
  percentage: number;
}

export interface SubjectOverallStats {
  total: number;
  completed: number;
  inProgress: number;
  notStarted: number;
  percentage: number;
  studyAgainCount: number;
  needHelpCount: number;
  partlyUnderstoodCount: number;
  understoodCount: number;
}

export interface SubjectMeta {
  code: SubjectCode;
  title: string;
  shortTitle: string;
  edition: string;
  icon: string;
  unitsCount: number;
  lessonsCount: number;
  itemsCount: number;
}

interface StudyContextType {
  curriculum: CurriculumData;
  activeSubject: SubjectCode;
  setActiveSubject: (subject: SubjectCode) => void;
  availableSubjects: SubjectMeta[];
  tamilCurriculum: CurriculumData;
  englishCurriculum: CurriculumData;
  mathCurriculum: CurriculumData;
  scienceCurriculum: CurriculumData;
  socialScienceCurriculum: CurriculumData;
  isLoading: boolean;
  progressMap: Record<string, StudentProgress>;
  revisionHistory: RevisionHistoryEntry[];
  lastStudiedLesson: Lesson | null;
  syncStatus: SyncStatusState;
  unsyncedCount: number;
  updateCompletion: (itemCode: string, status: CompletionStatus, lessonId?: string) => Promise<void>;
  updateUnderstanding: (itemCode: string, status: UnderstandingStatus, lessonId?: string) => Promise<void>;
  toggleStudyAgain: (itemCode: string, forcedValue?: boolean, lessonId?: string) => Promise<void>;
  savePersonalNotes: (itemCode: string, notes: string, lessonId?: string) => Promise<void>;
  resolveConflict: (itemCode: string, chosenNote: string) => Promise<void>;
  completeRevisionSession: (itemCode: string, stillNeedsRevision: boolean) => Promise<void>;
  triggerSync: () => Promise<void>;
  getLessonById: (lessonId: string) => Lesson | null;
  getUnitByLessonId: (lessonId: string) => Unit | null;
  getLessonProgress: (lessonId: string) => LessonProgressStats;
  getUnitProgress: (unitId: string) => LessonProgressStats;
  overallStats: SubjectOverallStats;
  subjectStats: Record<SubjectCode, SubjectOverallStats>;
  studyAgainItems: Array<{ item: ChecklistItem; lesson: Lesson; unit: Unit; progress: StudentProgress }>;
}

const StudyContext = createContext<StudyContextType | undefined>(undefined);

export function StudyProvider({ children }: { children: React.ReactNode }) {
  const { user } = useAuth();
  const [activeSubject, setActiveSubjectState] = useState<SubjectCode>('class_10_tamil');
  const [curriculaMap, setCurriculaMap] = useState<Record<SubjectCode, CurriculumData>>({
    class_10_tamil: tamilCurriculum,
    class_10_english: englishCurriculum,
    class_10_math: mathCurriculum,
    class_10_science: scienceCurriculum,
    class_10_social_science: socialScienceCurriculum,
  });

  const [progressMap, setProgressMap] = useState<Record<string, StudentProgress>>({});
  const [revisionHistory, setRevisionHistory] = useState<RevisionHistoryEntry[]>([]);
  const [lastStudiedLessonId, setLastStudiedLessonId] = useState<string | null>(null);
  const [syncStatus, setSyncStatus] = useState<SyncStatusState>('synced');
  const [unsyncedCount, setUnsyncedCount] = useState<number>(0);
  const [isLoading, setIsLoading] = useState(true);

  // Available subjects metadata in canonical Board order: Tamil, English, Mathematics, Science, Social Science
  const availableSubjects: SubjectMeta[] = useMemo(() => [
    {
      code: 'class_10_tamil',
      title: 'Tamil (தமிழ்)',
      shortTitle: 'Tamil',
      edition: '2025 Edition',
      icon: '📜',
      unitsCount: curriculaMap.class_10_tamil.units.length,
      lessonsCount: curriculaMap.class_10_tamil.summary.total_lessons,
      itemsCount: curriculaMap.class_10_tamil.summary.total_checklist_items,
    },
    {
      code: 'class_10_english',
      title: 'English',
      shortTitle: 'English',
      edition: '2024 Edition',
      icon: '📘',
      unitsCount: curriculaMap.class_10_english.units.length,
      lessonsCount: curriculaMap.class_10_english.summary.total_lessons,
      itemsCount: curriculaMap.class_10_english.summary.total_checklist_items,
    },
    {
      code: 'class_10_math',
      title: 'Mathematics',
      shortTitle: 'Math',
      edition: '2025 Edition',
      icon: '📐',
      unitsCount: curriculaMap.class_10_math.units.length,
      lessonsCount: curriculaMap.class_10_math.summary.total_lessons,
      itemsCount: curriculaMap.class_10_math.summary.total_checklist_items,
    },
    {
      code: 'class_10_science',
      title: 'Science',
      shortTitle: 'Science',
      edition: '2024 Edition',
      icon: '🔬',
      unitsCount: curriculaMap.class_10_science.units.length,
      lessonsCount: curriculaMap.class_10_science.summary.total_lessons,
      itemsCount: curriculaMap.class_10_science.summary.total_checklist_items,
    },
    {
      code: 'class_10_social_science',
      title: 'Social Science',
      shortTitle: 'Social',
      edition: '2025 Edition',
      icon: '🌍',
      unitsCount: curriculaMap.class_10_social_science.units.length,
      lessonsCount: curriculaMap.class_10_social_science.summary.total_lessons,
      itemsCount: curriculaMap.class_10_social_science.summary.total_checklist_items,
    },
  ], [curriculaMap]);

  // Active curriculum derived from activeSubject
  const curriculum = useMemo(() => {
    return curriculaMap[activeSubject] || curriculaMap.class_10_tamil || curriculaMap.class_10_social_science;
  }, [curriculaMap, activeSubject]);

  // Set active subject and persist preference
  const setActiveSubject = useCallback((subject: SubjectCode) => {
    setActiveSubjectState(subject);
    if (typeof window !== 'undefined') {
      try {
        localStorage.setItem('tn10_active_subject', subject);
        setAppMeta('active_subject', subject).catch(() => {});
      } catch {}
    }
  }, []);

  // 1. Subscribe to SyncManager status
  useEffect(() => {
    const unsubscribe = syncManager.subscribe((status, count) => {
      setSyncStatus(status);
      setUnsyncedCount(count);
    });
    return unsubscribe;
  }, []);

  // 2. Load Curriculum and Student Data from IndexedDB
  useEffect(() => {
    async function loadData() {
      setIsLoading(true);
      try {
        // Restore active subject preference
        let savedSubject: SubjectCode = 'class_10_tamil';
        try {
          const fromMeta = await getAppMeta('active_subject');
          if (fromMeta === 'class_10_tamil' || fromMeta === 'class_10_social_science' || fromMeta === 'class_10_science' || fromMeta === 'class_10_math' || fromMeta === 'class_10_english') {
            savedSubject = fromMeta as SubjectCode;
          } else {
            const fromStorage = localStorage.getItem('tn10_active_subject');
            if (fromStorage === 'class_10_tamil' || fromStorage === 'class_10_social_science' || fromStorage === 'class_10_science' || fromStorage === 'class_10_math' || fromStorage === 'class_10_english') {
              savedSubject = fromStorage as SubjectCode;
            }
          }
        } catch {}
        setActiveSubjectState(savedSubject);

        // Load or cache all 5 curricula in IndexedDB
        const cachedTamil = await getCachedCurriculum('class_10_tamil');
        const cachedSocial = await getCachedCurriculum('class_10_social_science');
        const cachedScience = await getCachedCurriculum('class_10_science');
        const cachedMath = await getCachedCurriculum('class_10_math');
        const cachedEnglish = await getCachedCurriculum('class_10_english');

        const resolvedTamil = cachedTamil || tamilCurriculum;
        const resolvedSocial = cachedSocial || socialScienceCurriculum;
        const resolvedScience = cachedScience || scienceCurriculum;
        const resolvedMath = cachedMath || mathCurriculum;
        const resolvedEnglish = cachedEnglish || englishCurriculum;

        if (!cachedTamil) await cacheCurriculum(tamilCurriculum, 'class_10_tamil');
        if (!cachedSocial) await cacheCurriculum(socialScienceCurriculum, 'class_10_social_science');
        if (!cachedScience) await cacheCurriculum(scienceCurriculum, 'class_10_science');
        if (!cachedMath) await cacheCurriculum(mathCurriculum, 'class_10_math');
        if (!cachedEnglish) await cacheCurriculum(englishCurriculum, 'class_10_english');

        setCurriculaMap({
          class_10_tamil: resolvedTamil,
          class_10_social_science: resolvedSocial,
          class_10_science: resolvedScience,
          class_10_math: resolvedMath,
          class_10_english: resolvedEnglish,
        });

        // Load student-specific data if logged in
        const currentStudent = user || (typeof window !== 'undefined' ? JSON.parse(localStorage.getItem('app_meta_demo_active_user') || 'null') : null);
        if (currentStudent) {
          syncManager.setStudentId(currentStudent.id);
          const progressList = await getStudentProgressList(currentStudent.id);
          const map: Record<string, StudentProgress> = {};
          progressList.forEach((p) => {
            map[p.item_code] = p;
          });
          setProgressMap(map);

          const history = await getStudentRevisionHistory(currentStudent.id);
          setRevisionHistory(history);

          const savedLastLessonId = await getAppMeta(`last_studied_${currentStudent.id}`);
          if (savedLastLessonId) {
            setLastStudiedLessonId(savedLastLessonId);
          }

          // Asynchronously fetch and merge any cloud records from MongoDB / PostgreSQL
          fetch(`/api/progress?student_id=${encodeURIComponent(currentStudent.id)}`)
            .then((res) => (res.ok ? res.json() : []))
            .then(async (remoteRecords) => {
              if (Array.isArray(remoteRecords) && remoteRecords.length > 0) {
                setProgressMap((prev) => {
                  const merged = { ...prev };
                  remoteRecords.forEach((r: any) => {
                    if (r.item_code) {
                      const fullItem: StudentProgress = {
                        id: `${currentStudent.id}_${r.item_code}`,
                        student_id: currentStudent.id,
                        item_code: r.item_code,
                        completion_status: r.completion_status || 'not_started',
                        understanding_status: r.understanding_status || 'not_assessed',
                        study_again: Boolean(r.study_again),
                        personal_notes: r.personal_notes || '',
                        notes_updated_at: r.notes_updated_at || null,
                        last_studied_at: r.last_studied_at || null,
                        next_revision_date: r.next_revision_date || null,
                        sync_version: r.sync_version || 1,
                        updated_at: r.updated_at || new Date().toISOString(),
                      };
                      if (!merged[r.item_code] || (fullItem.sync_version >= (merged[r.item_code].sync_version || 0))) {
                        merged[r.item_code] = fullItem;
                        saveItemProgressLocal(fullItem).catch(() => {});
                      }
                    }
                  });
                  return merged;
                });
              }
            })
            .catch(() => {});
        } else {
          // Default to empty for guest
          setProgressMap({});
          setRevisionHistory([]);
          setLastStudiedLessonId(null);
        }
      } catch (err) {
        console.error('Error loading study data:', err);
      } finally {
        setIsLoading(false);
      }
    }

    loadData();
  }, [user]);

  // Helper to find lesson across active subject (and fallback to other subjects if needed)
  const getLessonById = useCallback((lessonId: string): Lesson | null => {
    // Search active curriculum first
    for (const unit of curriculum.units) {
      for (const lesson of unit.lessons) {
        if (lesson.id === lessonId) return lesson;
      }
    }
    // Search across all subjects
    const codes: SubjectCode[] = ['class_10_tamil', 'class_10_english', 'class_10_math', 'class_10_science', 'class_10_social_science'];
    for (const c of codes) {
      if (c !== activeSubject && curriculaMap[c]) {
        for (const unit of curriculaMap[c].units) {
          for (const lesson of unit.lessons) {
            if (lesson.id === lessonId) return lesson;
          }
        }
      }
    }
    return null;
  }, [curriculum, curriculaMap, activeSubject]);

  // Helper to find unit by lesson id
  const getUnitByLessonId = useCallback((lessonId: string): Unit | null => {
    for (const unit of curriculum.units) {
      for (const lesson of unit.lessons) {
        if (lesson.id === lessonId) return unit;
      }
    }
    const codes: SubjectCode[] = ['class_10_tamil', 'class_10_english', 'class_10_math', 'class_10_science', 'class_10_social_science'];
    for (const c of codes) {
      if (c !== activeSubject && curriculaMap[c]) {
        for (const unit of curriculaMap[c].units) {
          for (const lesson of unit.lessons) {
            if (lesson.id === lessonId) return unit;
          }
        }
      }
    }
    return null;
  }, [curriculum, curriculaMap, activeSubject]);

  // Resolve last studied lesson
  const lastStudiedLesson = useMemo(() => {
    if (lastStudiedLessonId) {
      const found = getLessonById(lastStudiedLessonId);
      if (found) return found;
    }
    return curriculum.units[0]?.lessons[0] || null;
  }, [lastStudiedLessonId, curriculum, getLessonById]);

  // Helper to persist item progress locally and enqueue sync mutation
  const persistProgress = async (
    itemCode: string, 
    updater: (prev: StudentProgress) => StudentProgress,
    lessonId?: string
  ) => {
    const activeStudentId = user?.id || (typeof window !== 'undefined' ? localStorage.getItem('app_meta_active_student_id') || 'demo-student-001' : 'demo-student-001');

    const current: StudentProgress = progressMap[itemCode] || {
      id: `${activeStudentId}_${itemCode}`,
      student_id: activeStudentId,
      item_code: itemCode,
      completion_status: 'not_started',
      understanding_status: 'not_assessed',
      study_again: false,
      personal_notes: '',
      notes_updated_at: null,
      last_studied_at: null,
      next_revision_date: null,
      sync_version: 0,
      updated_at: new Date().toISOString(),
    };

    const updated = updater(current);
    updated.id = `${activeStudentId}_${itemCode}`;
    updated.student_id = activeStudentId;
    updated.sync_version = (current.sync_version || 0) + 1;
    updated.updated_at = new Date().toISOString();
    updated.last_studied_at = new Date().toISOString();

    // 1. Optimistic React state update immediately (0ms UI latency!)
    setProgressMap((prev) => ({
      ...prev,
      [itemCode]: updated,
    }));

    // Update last studied lesson state
    if (lessonId) {
      setLastStudiedLessonId(lessonId);
    }

    // 2. Persist to IndexedDB in safe non-blocking background task
    try {
      await saveItemProgressLocal(updated);
      if (lessonId) {
        await setAppMeta(`last_studied_${activeStudentId}`, lessonId);
      }
    } catch (saveErr) {
      console.warn('saveItemProgressLocal note:', saveErr);
    }

    // 3. Enqueue mutation for background sync to MongoDB / Docker
    try {
      const mutation: SyncMutation = {
        id: `mut_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
        client_mutation_id: `cl_${activeStudentId}_${itemCode}_${Date.now()}`,
        student_id: activeStudentId,
        action: 'upsert_progress',
        entity_type: 'student_item_progress',
        entity_id: itemCode,
        payload: updated,
        base_version: current.sync_version || 0,
        timestamp: Date.now(),
        attempts: 0,
        status: 'pending',
      };

      await enqueueMutation(mutation);
      syncManager.refreshStatus();
    } catch (queueErr) {
      console.warn('enqueueMutation note:', queueErr);
    }
  };

  // Completion status updater
  const updateCompletion = async (itemCode: string, status: CompletionStatus, lessonId?: string) => {
    await persistProgress(itemCode, (prev) => ({
      ...prev,
      completion_status: status,
    }), lessonId);
  };

  // Understanding status updater
  const updateUnderstanding = async (itemCode: string, status: UnderstandingStatus, lessonId?: string) => {
    await persistProgress(itemCode, (prev) => ({
      ...prev,
      understanding_status: status,
    }), lessonId);
  };

  // Study Again flag toggle
  const toggleStudyAgain = async (itemCode: string, forcedValue?: boolean, lessonId?: string) => {
    await persistProgress(itemCode, (prev) => ({
      ...prev,
      study_again: forcedValue !== undefined ? forcedValue : !prev.study_again,
    }), lessonId);
  };

  // Personal Notes auto-save
  const savePersonalNotes = async (itemCode: string, notes: string, lessonId?: string) => {
    await persistProgress(itemCode, (prev) => ({
      ...prev,
      personal_notes: notes,
      notes_updated_at: new Date().toISOString(),
    }), lessonId);
  };

  // Conflict resolution
  const resolveConflict = async (itemCode: string, chosenNote: string) => {
    await persistProgress(itemCode, (prev) => ({
      ...prev,
      personal_notes: chosenNote,
      conflict_notes: null,
      notes_updated_at: new Date().toISOString(),
    }));
  };

  // Complete Revision Session: logs revision history event and updates study again flag
  // Crucially: lesson completion status is NEVER reset!
  const completeRevisionSession = async (itemCode: string, stillNeedsRevision: boolean) => {
    if (!user) return;

    const currentProg = progressMap[itemCode];
    const notesSnapshot = currentProg?.personal_notes || '';

    const revEntry: RevisionHistoryEntry = {
      id: `rev_${user.id}_${itemCode}_${Date.now()}`,
      student_id: user.id,
      item_code: itemCode,
      revision_date: new Date().toISOString(),
      notes_snapshot: notesSnapshot,
      outcome: stillNeedsRevision ? 'revision_needed_again' : 'revision_completed_mastered',
      still_needs_revision: stillNeedsRevision,
    };

    // Save revision entry locally
    await saveRevisionHistoryEntry(revEntry);
    setRevisionHistory((prev) => [revEntry, ...prev]);

    // Update study_again flag without touching completion_status!
    await persistProgress(itemCode, (prev) => ({
      ...prev,
      study_again: stillNeedsRevision,
    }));

    // Enqueue revision sync mutation
    const mutation: SyncMutation = {
      id: `mut_rev_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
      client_mutation_id: `cl_rev_${user.id}_${itemCode}_${Date.now()}`,
      student_id: user.id,
      action: 'log_revision',
      entity_type: 'revision_history',
      entity_id: revEntry.id,
      payload: revEntry,
      base_version: 1,
      timestamp: Date.now(),
      attempts: 0,
      status: 'pending',
    };
    await enqueueMutation(mutation);
    syncManager.refreshStatus();
  };

  const triggerSync = async () => {
    await syncManager.triggerSync('user_manual_click');
  };

  // Progress metrics calculation for a given lesson
  const getLessonProgress = useCallback((lessonId: string): LessonProgressStats => {
    const lesson = getLessonById(lessonId);
    if (!lesson) return { total: 0, completed: 0, inProgress: 0, studyAgain: 0, percentage: 0 };

    const total = lesson.checklist_items.length;
    let completed = 0;
    let inProgress = 0;
    let studyAgain = 0;

    lesson.checklist_items.forEach((item) => {
      const prog = progressMap[item.id];
      if (prog) {
        if (prog.completion_status === 'completed') completed++;
        else if (prog.completion_status === 'in_progress') inProgress++;
        if (prog.study_again) studyAgain++;
      }
    });

    const percentage = total > 0 ? Math.round((completed / total) * 100) : 0;
    return { total, completed, inProgress, studyAgain, percentage };
  }, [getLessonById, progressMap]);

  // Progress metrics calculation for a given unit
  const getUnitProgress = useCallback((unitId: string): LessonProgressStats => {
    const unit = curriculum.units.find((u) => u.id === unitId) ||
                 curriculaMap.class_10_tamil.units.find((u) => u.id === unitId) ||
                 curriculaMap.class_10_social_science.units.find((u) => u.id === unitId) ||
                 curriculaMap.class_10_science.units.find((u) => u.id === unitId) ||
                 curriculaMap.class_10_math.units.find((u) => u.id === unitId) ||
                 curriculaMap.class_10_english.units.find((u) => u.id === unitId);
    if (!unit) return { total: 0, completed: 0, inProgress: 0, studyAgain: 0, percentage: 0 };

    let total = 0;
    let completed = 0;
    let inProgress = 0;
    let studyAgain = 0;

    unit.lessons.forEach((lesson) => {
      const stats = getLessonProgress(lesson.id);
      total += stats.total;
      completed += stats.completed;
      inProgress += stats.inProgress;
      studyAgain += stats.studyAgain;
    });

    const percentage = total > 0 ? Math.round((completed / total) * 100) : 0;
    return { total, completed, inProgress, studyAgain, percentage };
  }, [curriculum, curriculaMap, getLessonProgress]);

  // Calculate stats for a specific curriculum
  const calculateCurriculumStats = useCallback((curr: CurriculumData): SubjectOverallStats => {
    let total = 0;
    let completed = 0;
    let inProgress = 0;
    let studyAgainCount = 0;
    let needHelpCount = 0;
    let partlyUnderstoodCount = 0;
    let understoodCount = 0;

    curr.units.forEach((unit) => {
      unit.lessons.forEach((lesson) => {
        lesson.checklist_items.forEach((item) => {
          total++;
          const prog = progressMap[item.id];
          if (prog) {
            if (prog.completion_status === 'completed') completed++;
            else if (prog.completion_status === 'in_progress') inProgress++;

            if (prog.study_again) studyAgainCount++;

            if (prog.understanding_status === 'need_help') needHelpCount++;
            else if (prog.understanding_status === 'partly_understood') partlyUnderstoodCount++;
            else if (prog.understanding_status === 'understood') understoodCount++;
          }
        });
      });
    });

    const notStarted = Math.max(0, total - (completed + inProgress));
    const percentage = total > 0 ? Math.round((completed / total) * 100) : 0;

    return {
      total,
      completed,
      inProgress,
      notStarted,
      percentage,
      studyAgainCount,
      needHelpCount,
      partlyUnderstoodCount,
      understoodCount,
    };
  }, [progressMap]);

  // Per-subject statistics for all 5 subjects
  const subjectStats = useMemo<Record<SubjectCode, SubjectOverallStats>>(() => ({
    class_10_tamil: calculateCurriculumStats(curriculaMap.class_10_tamil),
    class_10_english: calculateCurriculumStats(curriculaMap.class_10_english),
    class_10_math: calculateCurriculumStats(curriculaMap.class_10_math),
    class_10_science: calculateCurriculumStats(curriculaMap.class_10_science),
    class_10_social_science: calculateCurriculumStats(curriculaMap.class_10_social_science),
  }), [calculateCurriculumStats, curriculaMap]);

  // Overall metrics for active subject
  const overallStats = useMemo(() => {
    return subjectStats[activeSubject] || subjectStats.class_10_tamil || subjectStats.class_10_social_science;
  }, [subjectStats, activeSubject]);

  // Aggregated study again items for the active subject
  const studyAgainItems = useMemo(() => {
    const items: Array<{ item: ChecklistItem; lesson: Lesson; unit: Unit; progress: StudentProgress }> = [];
    curriculum.units.forEach((unit) => {
      unit.lessons.forEach((lesson) => {
        lesson.checklist_items.forEach((item) => {
          const prog = progressMap[item.id];
          if (prog && prog.study_again) {
            items.push({ item, lesson, unit, progress: prog });
          }
        });
      });
    });
    return items;
  }, [curriculum, progressMap]);

  return (
    <StudyContext.Provider
      value={{
        curriculum,
        activeSubject,
        setActiveSubject,
        availableSubjects,
        tamilCurriculum,
        englishCurriculum,
        mathCurriculum,
        scienceCurriculum,
        socialScienceCurriculum,
        isLoading,
        progressMap,
        revisionHistory,
        lastStudiedLesson,
        syncStatus,
        unsyncedCount,
        updateCompletion,
        updateUnderstanding,
        toggleStudyAgain,
        savePersonalNotes,
        resolveConflict,
        completeRevisionSession,
        triggerSync,
        getLessonById,
        getUnitByLessonId,
        getLessonProgress,
        getUnitProgress,
        overallStats,
        subjectStats,
        studyAgainItems,
      }}
    >
      {children}
    </StudyContext.Provider>
  );
}

export function useStudy() {
  const context = useContext(StudyContext);
  if (!context) {
    throw new Error('useStudy must be used within a StudyProvider');
  }
  return context;
}
