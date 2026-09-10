'use client';

// ============================================================================
// Modern Lesson Checklist Page (2025/2026 SaaS Bento & Glassmorphic Design)
// Strictly independent Completion, Understanding, Study Again, and Notes
// ============================================================================

import React, { useState, useMemo } from 'react';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { 
  ArrowLeft, 
  Bookmark, 
  CheckCircle2, 
  Clock, 
  HelpCircle, 
  Sparkles, 
  CheckCircle, 
  FileText, 
  MessageSquare, 
  AlertCircle,
  Layers,
  ChevronDown,
  ChevronUp
} from 'lucide-react';
import { useStudy } from '@/lib/store/study-context';
import { useI18n } from '@/lib/i18n/i18n-context';
import { 
  CompletionStatus, 
  UnderstandingStatus, 
  ChecklistItem, 
  StudentProgress 
} from '@/types';
import { triggerHaptic } from '@/lib/utils/haptics';

export default function LessonPage() {
  const params = useParams();
  const lessonId = params?.lessonId as string;
  const { 
    getLessonById, 
    getUnitByLessonId, 
    progressMap, 
    updateCompletion, 
    updateUnderstanding, 
    toggleStudyAgain, 
    savePersonalNotes,
    resolveConflict,
    getLessonProgress,
    isLoading 
  } = useStudy();
  const { t, lang } = useI18n();

  const [activeFilter, setActiveFilter] = useState<'all' | 'pending' | 'study_again' | 'needs_help'>('all');
  const [expandedNotes, setExpandedNotes] = useState<Record<string, boolean>>({});

  const lesson = useMemo(() => getLessonById(lessonId), [lessonId, getLessonById]);
  const unit = useMemo(() => getUnitByLessonId(lessonId), [lessonId, getUnitByLessonId]);
  const lessonStats = useMemo(() => getLessonProgress(lessonId), [lessonId, getLessonProgress]);

  const handleToggleStudyAgain = (itemId: string) => {
    triggerHaptic('medium');
    toggleStudyAgain(itemId, undefined, lesson?.id);
  };

  const handleUpdateCompletion = (itemId: string, status: CompletionStatus) => {
    if (status === 'completed') {
      triggerHaptic('success');
    } else {
      triggerHaptic('light');
    }
    updateCompletion(itemId, status, lesson?.id);
  };

  const handleUpdateUnderstanding = (itemId: string, status: UnderstandingStatus) => {
    triggerHaptic('selection');
    updateUnderstanding(itemId, status, lesson?.id);
  };

  if (isLoading) {
    return (
      <div className="flex flex-col items-center justify-center min-h-[60vh] gap-3">
        <div className="w-12 h-12 border-4 border-blue-500/20 border-t-blue-500 rounded-full animate-spin" />
        <p className="text-sm text-slate-400 font-medium">Loading lesson checklist...</p>
      </div>
    );
  }

  if (!lesson) {
    return (
      <div className="glass-panel rounded-3xl p-8 text-center max-w-lg mx-auto mt-12 border-white/[0.08]">
        <h2 className="text-lg font-bold text-white mb-2">Lesson Not Found</h2>
        <p className="text-sm text-slate-400 mb-4">The requested lesson does not exist in the curriculum.</p>
        <Link href="/curriculum" className="inline-block px-5 py-2.5 bg-blue-600 hover:bg-blue-500 text-white rounded-2xl text-xs font-bold transition">
          Return to Curriculum
        </Link>
      </div>
    );
  }

  // Filter checklist items
  const filteredItems = lesson.checklist_items.filter((item) => {
    const prog = progressMap[item.id];
    if (activeFilter === 'pending') {
      return !prog || prog.completion_status !== 'completed';
    }
    if (activeFilter === 'study_again') {
      return prog && prog.study_again;
    }
    if (activeFilter === 'needs_help') {
      return prog && (prog.understanding_status === 'need_help' || prog.understanding_status === 'partly_understood');
    }
    return true;
  });

  // Group items by section name
  const groupedSections = filteredItems.reduce((acc, item) => {
    const sec = item.section_name || 'General';
    if (!acc[sec]) acc[sec] = [];
    acc[sec].push(item);
    return acc;
  }, {} as Record<string, ChecklistItem[]>);

  const toggleNotesDrawer = (itemId: string) => {
    setExpandedNotes((prev) => ({ ...prev, [itemId]: !prev[itemId] }));
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-300 max-w-5xl mx-auto">
      {/* Back to Curriculum Button */}
      <Link
        href="/curriculum"
        className="inline-flex items-center gap-2 text-xs font-bold text-slate-400 hover:text-white transition group"
      >
        <ArrowLeft className="w-4 h-4 group-hover:-translate-x-1 transition-transform" />
        <span>{t.lesson.backToCurriculum} ({unit?.title})</span>
      </Link>

      {/* 1. Hero Lesson Banner */}
      <div className="relative overflow-hidden rounded-3xl border border-white/[0.08] bg-gradient-to-br from-slate-900 via-slate-950 to-[#070b14] p-6 sm:p-8 shadow-2xl backdrop-blur-xl">
        {/* Decorative ambient glow */}
        <div className="absolute top-0 right-0 w-80 h-80 bg-blue-500/10 rounded-full blur-3xl pointer-events-none" />

        <div className="relative z-10">
          <div className="flex flex-wrap items-center gap-2 mb-3">
            <span className={`text-[11px] font-bold uppercase tracking-wider px-2.5 py-0.5 rounded-md ${
              lesson.lesson_type === 'prose' ? 'bg-blue-500/15 text-blue-300 border border-blue-500/30' :
              lesson.lesson_type === 'poem' ? 'bg-purple-500/15 text-purple-300 border border-purple-500/30' :
              lesson.lesson_type === 'supplementary' ? 'bg-emerald-500/15 text-emerald-300 border border-emerald-500/30' :
              lesson.lesson_type === 'theory' ? 'bg-amber-500/15 text-amber-300 border border-amber-500/30' :
              lesson.lesson_type === 'practical' ? 'bg-amber-500/15 text-amber-300 border border-amber-500/30' :
              lesson.lesson_type === 'review' ? 'bg-indigo-500/15 text-indigo-300 border border-indigo-500/30' :
              'bg-cyan-500/15 text-cyan-300 border border-cyan-500/30'
            }`}>
              {lesson.lesson_type}
            </span>

            {lesson.is_memoriter && (
              <span className="inline-flex items-center gap-1 text-[11px] font-bold bg-amber-500/20 text-amber-300 border border-amber-500/30 px-2 py-0.5 rounded-md">
                <Sparkles className="w-3.5 h-3.5" />
                {t.curriculum.memoriterBadge}
              </span>
            )}

            <span className="text-xs text-slate-400 font-medium">
              {unit?.title} • {unit?.theme}
            </span>
          </div>

          <h1 className="text-2xl sm:text-4xl font-black text-white tracking-tight">
            {lesson.title}
          </h1>
          <p className="text-sm text-slate-300 mt-1 font-medium">
            {lesson.author}
          </p>

          {/* Source References & Page Badges */}
          <div className="flex flex-wrap items-center gap-3 text-xs text-slate-400 mt-4 pt-4 border-t border-white/[0.08]">
            <div className="flex items-center gap-1.5 bg-slate-800/60 px-3 py-1.5 rounded-xl border border-white/[0.05]">
              <FileText className="w-3.5 h-3.5 text-blue-400" />
              <span>Textbook pp. <strong>{lesson.printed_page_start}–{lesson.printed_page_end}</strong></span>
            </div>
            <div className="flex items-center gap-1.5 bg-slate-800/60 px-3 py-1.5 rounded-xl border border-white/[0.05]">
              <FileText className="w-3.5 h-3.5 text-indigo-400" />
              <span>PDF pp. <strong>{lesson.pdf_page_start}–{lesson.pdf_page_end}</strong></span>
            </div>
            <div className="ml-auto flex items-center gap-2">
              <span className="text-xs font-bold text-emerald-400">
                {lessonStats.completed}/{lessonStats.total} {lang === 'ta' ? 'முடிந்தது' : 'Done'} ({lessonStats.percentage}%)
              </span>
            </div>
          </div>

          {/* Progress Bar */}
          <div className="w-full bg-slate-800/80 h-2 rounded-full overflow-hidden mt-3">
            <div 
              className="bg-gradient-to-r from-emerald-500 to-teal-400 h-full rounded-full transition-all duration-300"
              style={{ width: `${lessonStats.percentage}%` }}
            />
          </div>
        </div>
      </div>

      {/* 2. Educational Invariant Callout */}
      <div className="glass-panel rounded-2xl p-4 flex items-start gap-3 text-xs text-blue-200 border-blue-500/25">
        <AlertCircle className="w-4 h-4 text-blue-400 shrink-0 mt-0.5" />
        <div>
          <strong className="text-blue-300 font-semibold">{t.lesson.independentNote}</strong>
        </div>
      </div>

      {/* 3. Filter Tabs */}
      <div className="flex items-center gap-2 overflow-x-auto pb-1">
        <button
          onClick={() => setActiveFilter('all')}
          className={`px-3.5 py-1.5 rounded-xl text-xs font-bold whitespace-nowrap transition cursor-pointer ${
            activeFilter === 'all'
              ? 'bg-blue-600 text-white shadow-md'
              : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
          }`}
        >
          {t.lesson.filterAll} ({lesson.checklist_items.length})
        </button>
        <button
          onClick={() => setActiveFilter('pending')}
          className={`px-3.5 py-1.5 rounded-xl text-xs font-bold whitespace-nowrap transition cursor-pointer ${
            activeFilter === 'pending'
              ? 'bg-amber-600 text-white shadow-md'
              : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
          }`}
        >
          {t.lesson.filterPending} ({lessonStats.total - lessonStats.completed})
        </button>
        <button
          onClick={() => setActiveFilter('study_again')}
          className={`px-3.5 py-1.5 rounded-xl text-xs font-bold whitespace-nowrap transition cursor-pointer ${
            activeFilter === 'study_again'
              ? 'bg-indigo-600 text-white shadow-md'
              : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
          }`}
        >
          {t.lesson.filterStudyAgain} ({lessonStats.studyAgain})
        </button>
        <button
          onClick={() => setActiveFilter('needs_help')}
          className={`px-3.5 py-1.5 rounded-xl text-xs font-bold whitespace-nowrap transition cursor-pointer ${
            activeFilter === 'needs_help'
              ? 'bg-rose-600 text-white shadow-md'
              : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
          }`}
        >
          {t.lesson.filterNeedHelp}
        </button>
      </div>

      {/* 4. Checklist Items Grouped by Section */}
      <div className="space-y-8">
        {Object.entries(groupedSections).map(([sectionName, items]) => (
          <div key={sectionName} className="space-y-3.5">
            {/* Section Header */}
            <div className="flex items-center gap-2 px-1">
              <Layers className="w-4 h-4 text-blue-400" />
              <h2 className="text-sm font-bold text-white uppercase tracking-wider">
                {sectionName}
              </h2>
              <span className="text-xs text-slate-500 font-medium">
                ({items.length} {items.length === 1 ? 'activity' : 'activities'})
              </span>
            </div>

            {/* Items */}
            <div className="space-y-3">
              {items.map((item) => {
                const prog = progressMap[item.id] || {
                  completion_status: 'not_started',
                  understanding_status: 'not_assessed',
                  study_again: false,
                  personal_notes: '',
                };

                const isNotesOpen = expandedNotes[item.id] || (prog.personal_notes && prog.personal_notes.trim().length > 0);
                const hasNotes = Boolean(prog.personal_notes && prog.personal_notes.trim().length > 0);

                return (
                  <div
                    key={item.id}
                    className={`glass-panel rounded-2xl sm:rounded-3xl p-4 sm:p-5 transition-all duration-200 ${
                      prog.study_again 
                        ? 'border-indigo-500/50 shadow-lg shadow-indigo-500/10 ring-1 ring-indigo-500/30' 
                        : 'border-white/[0.08] hover:border-white/[0.14]'
                    }`}
                  >
                    {/* Top Bar: Label, Badge, Page Ref & Study Again Toggle */}
                    <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-2.5 mb-3.5">
                      <div className="space-y-1 max-w-2xl">
                        <div className="flex flex-wrap items-center gap-2">
                          <span className={`text-[10px] font-bold px-2 py-0.5 rounded-md ${
                            item.item_type === 'source_activity'
                              ? 'bg-blue-500/10 text-blue-300 border border-blue-500/25'
                              : 'bg-emerald-500/10 text-emerald-300 border border-emerald-500/25'
                          }`}>
                            {item.item_type === 'source_activity' ? t.lesson.itemTypeSource : t.lesson.itemTypeApp}
                          </span>
                          <span className="text-xs text-slate-400 font-medium bg-slate-800/60 px-2 py-0.5 rounded-md border border-white/[0.04]">
                            {t.lesson.pageRef}: Book p. {item.printed_page} (PDF p. {item.pdf_page})
                          </span>
                        </div>
                        <h3 className="text-sm sm:text-base font-bold text-white pt-0.5">
                          {item.label}
                        </h3>
                        {item.description && (
                          <p className="text-xs text-slate-400 leading-relaxed font-normal">
                            {item.description}
                          </p>
                        )}
                      </div>

                      {/* Independent 'Study Again' Bookmark Toggle Button */}
                      <button
                        onClick={() => handleToggleStudyAgain(item.id)}
                        className={`inline-flex items-center justify-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-bold transition-all duration-200 active:scale-95 cursor-pointer shrink-0 tap-bounce w-full sm:w-auto ${
                          prog.study_again
                            ? 'bg-indigo-600 text-white shadow-lg shadow-indigo-600/30 border border-indigo-400'
                            : 'bg-slate-800/80 text-slate-300 hover:text-white hover:bg-slate-700 border border-white/[0.08]'
                        }`}
                        title="Flag for revision queue without resetting completion"
                      >
                        <Bookmark className={`w-3.5 h-3.5 ${prog.study_again ? 'fill-white' : ''}`} />
                        <span>{prog.study_again ? t.lesson.studyAgainActive : t.lesson.studyAgainToggle}</span>
                      </button>
                    </div>

                    {/* Controls Row: Completion & Understanding (Separated!) */}
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-3.5 pt-3 border-t border-white/[0.06]">
                      {/* Completion 3-State Toggle */}
                      <div>
                        <span className="block text-[11px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">
                          {t.lesson.completionLabel}
                        </span>
                        <div className="grid grid-cols-3 gap-1.5 bg-slate-950 p-1 rounded-xl border border-white/[0.06]">
                          <button
                            onClick={() => handleUpdateCompletion(item.id, 'not_started')}
                            className={`py-2.5 px-1 sm:px-2 rounded-xl text-xs font-bold transition cursor-pointer tap-bounce ${
                              prog.completion_status === 'not_started'
                                ? 'bg-slate-700 text-white shadow-md'
                                : 'text-slate-400 hover:text-slate-200'
                            }`}
                          >
                            {t.status.not_started}
                          </button>
                          <button
                            onClick={() => handleUpdateCompletion(item.id, 'in_progress')}
                            className={`py-2.5 px-1 sm:px-2 rounded-xl text-xs font-bold transition cursor-pointer tap-bounce ${
                              prog.completion_status === 'in_progress'
                                ? 'bg-amber-600 text-white shadow-md'
                                : 'text-slate-400 hover:text-slate-200'
                            }`}
                          >
                            {t.status.in_progress}
                          </button>
                          <button
                            onClick={() => handleUpdateCompletion(item.id, 'completed')}
                            className={`py-2.5 px-1 sm:px-2 rounded-xl text-xs font-bold transition cursor-pointer tap-bounce ${
                              prog.completion_status === 'completed'
                                ? 'bg-emerald-600 text-white shadow-md'
                                : 'text-slate-400 hover:text-slate-200'
                            }`}
                          >
                            {t.status.completed}
                          </button>
                        </div>
                      </div>

                      {/* Understanding 4-State Toggle */}
                      <div>
                        <span className="block text-[11px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">
                          {t.lesson.understandingLabel}
                        </span>
                        <div className="grid grid-cols-4 gap-1 bg-slate-950 p-1 rounded-xl border border-white/[0.06]">
                          <button
                            onClick={() => handleUpdateUnderstanding(item.id, 'not_assessed')}
                            className={`py-2.5 px-0.5 sm:px-1 text-center rounded-xl text-[11px] sm:text-xs font-bold transition cursor-pointer truncate tap-bounce ${
                              prog.understanding_status === 'not_assessed'
                                ? 'bg-slate-700 text-white'
                                : 'text-slate-400 hover:text-slate-200'
                            }`}
                            title={t.status.not_assessed}
                          >
                            {lang === 'ta' ? 'இல்லை' : 'None'}
                          </button>
                          <button
                            onClick={() => handleUpdateUnderstanding(item.id, 'need_help')}
                            className={`py-2.5 px-0.5 sm:px-1 text-center rounded-xl text-[11px] sm:text-xs font-bold transition cursor-pointer truncate tap-bounce ${
                              prog.understanding_status === 'need_help'
                                ? 'bg-rose-600 text-white shadow-sm'
                                : 'text-slate-400 hover:text-slate-200'
                            }`}
                            title={t.status.need_help}
                          >
                            {lang === 'ta' ? 'உதவி' : 'Help'}
                          </button>
                          <button
                            onClick={() => handleUpdateUnderstanding(item.id, 'partly_understood')}
                            className={`py-2.5 px-0.5 sm:px-1 text-center rounded-xl text-[11px] sm:text-xs font-bold transition cursor-pointer truncate tap-bounce ${
                              prog.understanding_status === 'partly_understood'
                                ? 'bg-amber-600 text-white shadow-sm'
                                : 'text-slate-400 hover:text-slate-200'
                            }`}
                            title={t.status.partly_understood}
                          >
                            {lang === 'ta' ? 'ஓரளவு' : 'Partial'}
                          </button>
                          <button
                            onClick={() => handleUpdateUnderstanding(item.id, 'understood')}
                            className={`py-2.5 px-0.5 sm:px-1 text-center rounded-xl text-[11px] sm:text-xs font-bold transition cursor-pointer truncate tap-bounce ${
                              prog.understanding_status === 'understood'
                                ? 'bg-emerald-600 text-white shadow-sm'
                                : 'text-slate-400 hover:text-slate-200'
                            }`}
                            title={t.status.understood}
                          >
                            {lang === 'ta' ? 'புரிந்தது' : 'Mastered'}
                          </button>
                        </div>
                      </div>
                    </div>

                    {/* Conflict Modal/Card */}
                    {prog.conflict_notes && (
                      <div className="mt-4 p-4 rounded-2xl bg-amber-950/40 border border-amber-500/40 text-xs text-amber-200 space-y-3">
                        <div className="flex items-center gap-2 font-bold text-amber-300">
                          <AlertCircle className="w-4 h-4" />
                          <span>{t.lesson.conflictTitle}</span>
                        </div>
                        <p>{t.lesson.conflictMsg}</p>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-3 pt-1">
                          <div className="bg-slate-900/80 p-3 rounded-xl border border-slate-700">
                            <span className="block font-bold text-slate-300 mb-1">Your Local Draft:</span>
                            <p className="text-slate-200 whitespace-pre-wrap">{prog.conflict_notes.local}</p>
                            <button
                              onClick={() => resolveConflict(item.id, prog.conflict_notes!.local)}
                              className="mt-2 px-3 py-1 bg-amber-600 hover:bg-amber-500 text-white font-semibold rounded-xl text-xs transition cursor-pointer"
                            >
                              {t.lesson.keepLocal}
                            </button>
                          </div>
                          <div className="bg-slate-900/80 p-3 rounded-xl border border-slate-700">
                            <span className="block font-bold text-slate-300 mb-1">Remote Server Note:</span>
                            <p className="text-slate-200 whitespace-pre-wrap">{prog.conflict_notes.remote}</p>
                            <button
                              onClick={() => resolveConflict(item.id, prog.conflict_notes!.remote)}
                              className="mt-2 px-3 py-1 bg-blue-600 hover:bg-blue-500 text-white font-semibold rounded-xl text-xs transition cursor-pointer"
                            >
                              {t.lesson.keepRemote}
                            </button>
                          </div>
                        </div>
                      </div>
                    )}

                    {/* Personal Notes Section Drawer */}
                    <div className="mt-4 pt-3 border-t border-white/[0.06]">
                      <button
                        onClick={() => toggleNotesDrawer(item.id)}
                        className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-400 hover:text-white transition cursor-pointer"
                      >
                        <MessageSquare className="w-3.5 h-3.5 text-blue-400" />
                        <span>
                          {hasNotes ? 'Personal Notes' : 'Add Personal Note'}
                        </span>
                        {isNotesOpen ? <ChevronUp className="w-3.5 h-3.5" /> : <ChevronDown className="w-3.5 h-3.5" />}
                      </button>

                      {isNotesOpen && (
                        <div className="mt-3 space-y-2 animate-in fade-in duration-200">
                          <textarea
                            value={prog.personal_notes || ''}
                            onChange={(e) => savePersonalNotes(item.id, e.target.value, lesson.id)}
                            placeholder={t.lesson.notesPlaceholder}
                            rows={3}
                            className="w-full bg-slate-950/80 border border-white/[0.1] rounded-2xl p-3.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500/80 transition resize-y font-mono"
                          />
                          <div className="flex items-center justify-between text-[11px] text-slate-500 px-1 font-medium">
                            <span>
                              {prog.notes_updated_at 
                                ? `${t.lesson.notesSaved} (${new Date(prog.notes_updated_at).toLocaleTimeString()})`
                                : t.lesson.notesSaved}
                            </span>
                            {prog.last_studied_at && (
                              <span>
                                {t.lesson.lastStudied}: {new Date(prog.last_studied_at).toLocaleDateString()}
                              </span>
                            )}
                          </div>
                        </div>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
