'use client';

// ============================================================================
// Modern Revision Page (2025/2026 SaaS Glassmorphic Design)
// Central queue for flagged "Study Again" items with revision history
// ============================================================================

import React, { useState } from 'react';
import Link from 'next/link';
import { 
  Bookmark, 
  CheckCircle2, 
  Sparkles, 
  HelpCircle, 
  ArrowRight, 
  FileText, 
  CheckCircle, 
  X,
  MessageSquare,
  History,
  Clock
} from 'lucide-react';
import { useStudy } from '@/lib/store/study-context';
import { useI18n } from '@/lib/i18n/i18n-context';
import { ChecklistItem, Lesson, Unit, StudentProgress } from '@/types';

export default function RevisionPage() {
  const { studyAgainItems, completeRevisionSession, revisionHistory, isLoading, curriculum } = useStudy();
  const { t, lang } = useI18n();

  const [selectedUnit, setSelectedUnit] = useState<string>('all');
  const [selectedUnderstanding, setSelectedUnderstanding] = useState<string>('all');
  const [activeItemForModal, setActiveItemForModal] = useState<{
    item: ChecklistItem;
    lesson: Lesson;
    unit: Unit;
    progress: StudentProgress;
  } | null>(null);
  const [successToast, setSuccessToast] = useState<string | null>(null);

  if (isLoading) {
    return (
      <div className="flex flex-col items-center justify-center min-h-[60vh] gap-3">
        <div className="w-12 h-12 border-4 border-indigo-500/20 border-t-indigo-500 rounded-full animate-spin" />
        <p className="text-sm text-slate-400 font-medium">Loading revision queue...</p>
      </div>
    );
  }

  // Filter items
  const filteredItems = studyAgainItems.filter(({ item, unit, progress }) => {
    const matchesUnit = selectedUnit === 'all' || unit.id === selectedUnit;
    const matchesUnderstanding = selectedUnderstanding === 'all' || progress.understanding_status === selectedUnderstanding;
    return matchesUnit && matchesUnderstanding;
  });

  const handleCompleteRevision = async (stillNeeds: boolean) => {
    if (!activeItemForModal) return;
    const itemCode = activeItemForModal.item.id;
    await completeRevisionSession(itemCode, stillNeeds);

    setActiveItemForModal(null);
    setSuccessToast(t.revision.revisionRecorded);
    setTimeout(() => setSuccessToast(null), 4000);
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-300 max-w-5xl mx-auto">
      {/* Toast Alert */}
      {successToast && (
        <div className="fixed top-20 right-4 left-4 md:left-auto md:max-w-md z-50 bg-emerald-600 text-white p-4 rounded-2xl shadow-2xl flex items-center justify-between gap-3 animate-in slide-in-from-top border border-emerald-400">
          <div className="flex items-center gap-2 text-xs font-bold">
            <CheckCircle2 className="w-4 h-4 shrink-0" />
            <span>{successToast}</span>
          </div>
          <button onClick={() => setSuccessToast(null)} className="text-white/80 hover:text-white cursor-pointer">
            <X className="w-4 h-4" />
          </button>
        </div>
      )}

      {/* 1. Header Banner */}
      <div className="relative overflow-hidden rounded-3xl border border-indigo-500/30 bg-gradient-to-br from-indigo-950/60 via-slate-950 to-[#070b14] p-6 sm:p-8 shadow-2xl backdrop-blur-xl">
        <div className="absolute top-0 right-0 w-80 h-80 bg-indigo-500/10 rounded-full blur-3xl pointer-events-none" />

        <div className="relative z-10">
          <div className="flex items-center gap-2 mb-2">
            <span className="w-2 h-2 rounded-full bg-indigo-400 animate-ping" />
            <span className="text-xs font-extrabold text-indigo-300 uppercase tracking-wider">
              {lang === 'ta' ? 'தேர்வு மறுஆய்வுப் பட்டியல்' : 'Exam Revision Queue'}
            </span>
          </div>
          <h1 className="text-2xl sm:text-4xl font-black text-white tracking-tight flex items-center gap-3">
            <Bookmark className="w-7 h-7 text-indigo-400 fill-indigo-400/30" />
            <span>{t.revision.title} ({studyAgainItems.length})</span>
          </h1>
          <p className="text-xs sm:text-sm text-slate-300 mt-2 max-w-2xl leading-relaxed font-medium">
            {t.revision.subtitle}
          </p>
        </div>
      </div>

      {/* 2. Filters Toolbar */}
      <div className="flex flex-wrap items-center gap-3 glass-panel p-3 rounded-2xl border-white/[0.08]">
        {/* Dynamic Unit Filter */}
        <select
          value={selectedUnit}
          onChange={(e) => setSelectedUnit(e.target.value)}
          className="bg-slate-900 border border-white/[0.1] text-xs font-bold text-slate-200 rounded-xl px-3.5 py-2.5 focus:outline-none focus:border-indigo-500 cursor-pointer"
        >
          <option value="all">{t.revision.filterUnit}</option>
          {curriculum?.units?.map((u) => (
            <option key={u.id} value={u.id}>
              {u.title}
            </option>
          ))}
        </select>

        {/* Understanding Level Filter */}
        <select
          value={selectedUnderstanding}
          onChange={(e) => setSelectedUnderstanding(e.target.value)}
          className="bg-slate-900 border border-white/[0.1] text-xs font-bold text-slate-200 rounded-xl px-3.5 py-2.5 focus:outline-none focus:border-indigo-500 cursor-pointer"
        >
          <option value="all">{t.revision.filterStatus}</option>
          <option value="need_help">{t.status.need_help}</option>
          <option value="partly_understood">{t.status.partly_understood}</option>
          <option value="understood">{t.status.understood}</option>
          <option value="not_assessed">{t.status.not_assessed}</option>
        </select>

        {/* Count */}
        <span className="text-xs text-slate-400 ml-auto font-medium">
          Showing {filteredItems.length} of {studyAgainItems.length} items
        </span>
      </div>

      {/* 3. Empty State */}
      {filteredItems.length === 0 && (
        <div className="glass-panel rounded-3xl p-12 text-center max-w-lg mx-auto border-white/[0.08]">
          <div className="w-16 h-16 rounded-2xl bg-indigo-500/10 text-indigo-400 flex items-center justify-center mx-auto mb-4 border border-indigo-500/25">
            <Bookmark className="w-8 h-8" />
          </div>
          <h2 className="text-lg font-bold text-white mb-2">{t.revision.emptyTitle}</h2>
          <p className="text-xs text-slate-400 leading-relaxed mb-6 font-medium">
            {t.revision.emptyMsg}
          </p>
          <Link
            href="/curriculum"
            className="inline-flex items-center gap-2 px-5 py-2.5 bg-blue-600 hover:bg-blue-500 text-white rounded-2xl text-xs font-bold transition shadow-md shadow-blue-600/20"
          >
            <span>{t.curriculum.startStudying}</span>
            <ArrowRight className="w-4 h-4" />
          </Link>
        </div>
      )}

      {/* 4. List of Revision Cards */}
      <div className="space-y-4">
        {filteredItems.map(({ item, lesson, unit, progress }) => (
          <div
            key={item.id}
            className="glass-panel rounded-3xl p-5 shadow-sm hover:border-indigo-500/50 transition-all duration-200 border-indigo-500/30 flex flex-col justify-between"
          >
            <div>
              {/* Header */}
              <div className="flex flex-wrap items-center justify-between gap-2 mb-2">
                <div className="flex items-center gap-2">
                  <span className="text-[10px] font-bold px-2 py-0.5 rounded-md bg-indigo-500/15 text-indigo-300 border border-indigo-500/30 uppercase">
                    {unit.title}
                  </span>
                  <Link
                    href={`/lesson/${lesson.id}`}
                    className="text-xs font-bold text-slate-300 hover:text-blue-400 transition"
                  >
                    {lesson.title} ({lesson.lesson_type})
                  </Link>
                </div>
                <div className="flex items-center gap-2">
                  <span className={`text-[10px] font-bold px-2 py-0.5 rounded-md ${
                    progress.completion_status === 'completed'
                      ? 'bg-emerald-500/15 text-emerald-400 border border-emerald-500/30'
                      : progress.completion_status === 'in_progress'
                      ? 'bg-amber-500/15 text-amber-400 border border-amber-500/30'
                      : 'bg-slate-800 text-slate-400'
                  }`}>
                    {t.status[progress.completion_status]}
                  </span>

                  <span className={`text-[10px] font-bold px-2 py-0.5 rounded-md ${
                    progress.understanding_status === 'understood'
                      ? 'bg-emerald-500/15 text-emerald-400'
                      : progress.understanding_status === 'partly_understood'
                      ? 'bg-amber-500/15 text-amber-400'
                      : progress.understanding_status === 'need_help'
                      ? 'bg-rose-500/15 text-rose-400'
                      : 'bg-slate-800 text-slate-400'
                  }`}>
                    {t.status[progress.understanding_status]}
                  </span>
                </div>
              </div>

              {/* Title & Section */}
              <h3 className="text-base font-bold text-white mt-1">
                {item.label}
              </h3>
              <p className="text-xs text-slate-400 mt-0.5 font-medium">
                Section: <strong className="text-slate-300">{item.section_name}</strong> • Book p. {item.printed_page} (PDF p. {item.pdf_page})
              </p>

              {/* Personal Notes */}
              {progress.personal_notes && progress.personal_notes.trim().length > 0 && (
                <div className="mt-3 p-3.5 bg-slate-950/80 rounded-2xl border border-white/[0.06] text-xs text-slate-300 flex items-start gap-2.5">
                  <MessageSquare className="w-4 h-4 text-blue-400 shrink-0 mt-0.5" />
                  <div>
                    <span className="font-bold text-slate-400 block text-[11px] mb-0.5">Your Study Notes:</span>
                    <p className="whitespace-pre-wrap font-mono text-[11px] leading-relaxed">{progress.personal_notes}</p>
                  </div>
                </div>
              )}
            </div>

            {/* Actions Row */}
            <div className="mt-4 pt-3 border-t border-white/[0.06] flex items-center justify-between gap-3">
              <Link
                href={`/lesson/${lesson.id}`}
                className="text-xs font-bold text-blue-400 hover:text-blue-300 flex items-center gap-1 transition"
              >
                <span>Open Lesson</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </Link>

              <button
                onClick={() => setActiveItemForModal({ item, lesson, unit, progress })}
                className="px-4 py-2 bg-indigo-600 hover:bg-indigo-500 text-white rounded-xl text-xs font-bold transition shadow-md shadow-indigo-600/20 active:scale-95 cursor-pointer flex items-center gap-1.5"
              >
                <CheckCircle className="w-4 h-4" />
                <span>{t.revision.completeRevision}</span>
              </button>
            </div>
          </div>
        ))}
      </div>

      {/* 5. Revision History Timeline (if entries exist) */}
      {revisionHistory.length > 0 && (
        <div className="glass-panel rounded-3xl p-6 border-white/[0.08] space-y-4">
          <div className="flex items-center gap-2 text-white font-bold text-sm">
            <History className="w-4 h-4 text-indigo-400" />
            <span>Recent Revision History ({revisionHistory.length} sessions)</span>
          </div>

          <div className="space-y-2">
            {revisionHistory.slice(0, 5).map((rev) => (
              <div key={rev.id} className="flex items-center justify-between p-3 rounded-2xl bg-slate-950/60 border border-white/[0.05] text-xs">
                <div className="flex items-center gap-2.5">
                  <Clock className="w-3.5 h-3.5 text-slate-400" />
                  <span className="font-medium text-slate-300">
                    {new Date(rev.revision_date).toLocaleDateString()} at {new Date(rev.revision_date).toLocaleTimeString()}
                  </span>
                </div>
                <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${
                  rev.still_needs_revision
                    ? 'bg-amber-500/15 text-amber-400 border border-amber-500/30'
                    : 'bg-emerald-500/15 text-emerald-400 border border-emerald-500/30'
                }`}>
                  {rev.still_needs_revision ? 'Revision Needed Again' : 'Mastered & Removed'}
                </span>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Complete Revision Modal */}
      {activeItemForModal && (
        <div className="fixed inset-0 bg-black/80 backdrop-blur-md z-50 flex items-center justify-center p-4">
          <div className="glass-panel text-white rounded-3xl p-6 sm:p-8 max-w-md w-full shadow-2xl border-indigo-500/30 animate-in zoom-in-95">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-bold text-white flex items-center gap-2">
                <Bookmark className="w-5 h-5 text-indigo-400" />
                <span>{t.revision.modalTitle}</span>
              </h3>
              <button 
                onClick={() => setActiveItemForModal(null)}
                className="text-slate-400 hover:text-white cursor-pointer"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="space-y-2 mb-6">
              <span className="text-[11px] font-bold text-indigo-400 uppercase tracking-wide">
                {activeItemForModal.unit.title} • {activeItemForModal.lesson.title}
              </span>
              <h4 className="text-base font-bold text-white">
                {activeItemForModal.item.label}
              </h4>
              <p className="text-xs text-slate-400 font-medium">
                Book p. {activeItemForModal.item.printed_page} • Section: {activeItemForModal.item.section_name}
              </p>
            </div>

            <div className="bg-slate-950 p-4 rounded-2xl border border-white/[0.06] mb-6 text-xs text-slate-300">
              <p className="font-semibold text-slate-200 mb-1">
                {t.revision.modalPrompt}
              </p>
              <p className="text-[11px] text-slate-400">
                Recording this revision session will update your revision history without resetting your lesson completion status.
              </p>
            </div>

            {/* Decisions */}
            <div className="space-y-2.5">
              <button
                onClick={() => handleCompleteRevision(false)}
                className="w-full py-3 px-4 bg-emerald-600 hover:bg-emerald-500 text-white font-bold text-xs rounded-xl transition shadow-md flex items-center justify-center gap-2 cursor-pointer active:scale-95"
              >
                <CheckCircle2 className="w-4 h-4" />
                <span>{t.revision.choiceRemove}</span>
              </button>

              <button
                onClick={() => handleCompleteRevision(true)}
                className="w-full py-3 px-4 bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs rounded-xl transition shadow-md flex items-center justify-center gap-2 cursor-pointer active:scale-95"
              >
                <Bookmark className="w-4 h-4 fill-white" />
                <span>{t.revision.choiceKeep}</span>
              </button>

              <button
                onClick={() => setActiveItemForModal(null)}
                className="w-full py-2.5 px-4 bg-slate-800/80 hover:bg-slate-800 text-slate-300 font-semibold text-xs rounded-xl transition cursor-pointer"
              >
                {t.revision.cancel}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
