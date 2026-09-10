'use client';

// ============================================================================
// Admin Curriculum Console
// Implements the 5-step reusable PDF import, draft review, and publishing workflow.
// Enforces admin-only access and idempotent updates preserving student progress.
// ============================================================================

import React, { useState } from 'react';
import Link from 'next/link';
import { 
  ShieldAlert, 
  Upload, 
  FileCheck, 
  AlertCircle, 
  CheckCircle2, 
  Edit3, 
  Eye, 
  RefreshCw, 
  Save, 
  ShieldCheck, 
  BookOpen,
  ArrowRight,
  Sparkles
} from 'lucide-react';
import { useAuth } from '@/lib/auth/auth-context';
import { useI18n } from '@/lib/i18n/i18n-context';
import { useStudy } from '@/lib/store/study-context';
import { 
  createExtractionDraftFromPdf, 
  publishCurriculumDraft 
} from '@/lib/curriculum/import-workflow';
import { DraftChecklistItem, CurriculumDraft } from '@/types';
import { cacheCurriculum } from '@/lib/db/indexeddb';

export default function AdminPage() {
  const { user, isAdmin, signInDemo } = useAuth();
  const { t, lang } = useI18n();
  const { curriculum } = useStudy();

  const [activeDraft, setActiveDraft] = useState<CurriculumDraft | null>(null);
  const [draftItems, setDraftItems] = useState<DraftChecklistItem[]>([]);
  const [isExtracting, setIsExtracting] = useState(false);
  const [publishSuccess, setPublishSuccess] = useState(false);
  const [filterNeedsReview, setFilterNeedsReview] = useState(false);
  const [editingItemId, setEditingItemId] = useState<string | null>(null);
  const [editForm, setEditForm] = useState<{ label: string; section_name: string; printed_page: number }>({
    label: '',
    section_name: '',
    printed_page: 0,
  });

  // Guard: Admin role required
  if (!isAdmin) {
    return (
      <div className="bg-slate-900 border border-slate-800 rounded-3xl p-8 max-w-lg mx-auto text-center space-y-4 my-12">
        <div className="w-14 h-14 rounded-2xl bg-purple-500/10 text-purple-400 border border-purple-500/30 flex items-center justify-center mx-auto">
          <ShieldAlert className="w-7 h-7" />
        </div>
        <h2 className="text-xl font-bold text-white">Administrator Access Required</h2>
        <p className="text-xs text-slate-400 leading-relaxed">
          Curriculum management, PDF imports, and edition publishing are restricted to authorized school administrators and textbook coordinators.
        </p>
        <div className="pt-2">
          <button
            onClick={() => signInDemo('admin')}
            className="px-5 py-2.5 bg-purple-600 hover:bg-purple-500 text-white rounded-xl text-xs font-bold transition cursor-pointer shadow-md"
          >
            Switch to Demo Admin Account
          </button>
        </div>
      </div>
    );
  }

  // Step 1 & 2: Simulate or trigger PDF extraction
  const handleExtractFromPdf = async () => {
    setIsExtracting(true);
    setPublishSuccess(false);
    try {
      const result = await createExtractionDraftFromPdf('Class_10_English_2024_Edition.pdf', 67108864);
      setActiveDraft(result.draft);
      setDraftItems(result.draftItems);
    } catch (err) {
      console.error('Extraction error:', err);
    } finally {
      setIsExtracting(false);
    }
  };

  // Step 4: Inline Edit
  const handleStartEdit = (item: DraftChecklistItem) => {
    setEditingItemId(item.id);
    setEditForm({
      label: item.label,
      section_name: item.section_name,
      printed_page: item.printed_page,
    });
  };

  const handleSaveEdit = (itemId: string) => {
    setDraftItems((prev) =>
      prev.map((item) => {
        if (item.id === itemId) {
          return {
            ...item,
            label: editForm.label,
            section_name: editForm.section_name,
            printed_page: Number(editForm.printed_page),
            pdf_page: Number(editForm.printed_page) + 4,
            needs_review: false,
            confidence_score: 1.0,
          };
        }
        return item;
      })
    );
    setEditingItemId(null);
  };

  // Step 5: Publish Approved Curriculum (preserves student progress)
  const handlePublishCurriculum = async () => {
    if (!activeDraft || draftItems.length === 0) return;
    const updated = publishCurriculumDraft(curriculum, draftItems);
    await cacheCurriculum(updated);
    setPublishSuccess(true);
  };

  const displayItems = filterNeedsReview
    ? draftItems.filter((i) => i.needs_review)
    : draftItems;

  return (
    <div className="space-y-6 animate-in fade-in duration-300 max-w-5xl mx-auto">
      {/* Header */}
      <div className="bg-gradient-to-r from-purple-950/40 via-slate-900 to-slate-900 border border-purple-500/30 rounded-3xl p-6 sm:p-8 shadow-xl">
        <div className="flex items-center gap-2 mb-2">
          <ShieldCheck className="w-4 h-4 text-purple-400" />
          <span className="text-xs font-bold text-purple-300 uppercase tracking-wide">
            {t.admin.title}
          </span>
        </div>
        <h1 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
          Curriculum Import & Review Console
        </h1>
        <p className="text-sm text-slate-300 mt-2 max-w-2xl leading-relaxed">
          {t.admin.subtitle}
        </p>

        <div className="mt-4 inline-flex items-center gap-2 bg-emerald-500/10 text-emerald-300 border border-emerald-500/30 px-3 py-1.5 rounded-xl text-xs font-semibold">
          <CheckCircle2 className="w-4 h-4" />
          <span>{t.admin.safeUpdateNotice}</span>
        </div>
      </div>

      {/* Active Edition Card */}
      <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-6 shadow-sm flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <span className="text-xs font-bold text-slate-400 uppercase tracking-wide block mb-1">
            {t.admin.currentEdition}
          </span>
          <h2 className="text-lg font-bold text-white">
            {curriculum.subject.title} • {curriculum.subject.textbook.title} ({curriculum.subject.textbook.edition})
          </h2>
          <p className="text-xs text-slate-400 mt-1">
            Source: <code className="text-blue-400">{curriculum.subject.textbook.source_file}</code> • {curriculum.summary.total_units} Units • {curriculum.summary.total_lessons} Lessons • {curriculum.summary.total_checklist_items} Activities
          </p>
        </div>

        <button
          onClick={handleExtractFromPdf}
          disabled={isExtracting}
          className="px-5 py-2.5 bg-blue-600 hover:bg-blue-500 disabled:opacity-50 text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-2 cursor-pointer shadow-md shrink-0"
        >
          {isExtracting ? (
            <>
              <RefreshCw className="w-4 h-4 animate-spin" />
              <span>Parsing PDF...</span>
            </>
          ) : (
            <>
              <Upload className="w-4 h-4" />
              <span>Run PDF Extraction Draft</span>
            </>
          )}
        </button>
      </div>

      {/* Publish Success Alert */}
      {publishSuccess && (
        <div className="bg-emerald-950/40 border border-emerald-500/40 p-4 rounded-2xl text-xs text-emerald-200 flex items-center justify-between gap-3 animate-in zoom-in-95">
          <div className="flex items-center gap-2 font-bold text-emerald-300">
            <CheckCircle2 className="w-5 h-5" />
            <span>Curriculum successfully approved and published! All student progress preserved.</span>
          </div>
          <Link href="/curriculum" className="text-xs font-bold text-white underline">
            View Live Curriculum
          </Link>
        </div>
      )}

      {/* Extraction Draft Review Area */}
      {activeDraft && (
        <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-6 shadow-sm space-y-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-4 border-b border-slate-800">
            <div>
              <div className="flex items-center gap-2">
                <span className="text-xs font-bold px-2 py-0.5 rounded bg-purple-500/10 text-purple-300 border border-purple-500/30 uppercase">
                  Draft #{activeDraft.id.slice(-6)}
                </span>
                <span className="text-xs text-slate-400">
                  Total Items: {draftItems.length}
                </span>
              </div>
              <h3 className="text-base font-bold text-white mt-1">
                Draft Review & Confidence Scoring
              </h3>
            </div>

            <div className="flex items-center gap-2">
              <button
                onClick={() => setFilterNeedsReview(!filterNeedsReview)}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition cursor-pointer border ${
                  filterNeedsReview 
                    ? 'bg-amber-600/20 text-amber-300 border-amber-500/40' 
                    : 'bg-slate-800 text-slate-400 border-slate-700 hover:text-white'
                }`}
              >
                Flagged for Review ({draftItems.filter((i) => i.needs_review).length})
              </button>

              <button
                onClick={handlePublishCurriculum}
                className="px-4 py-1.5 bg-emerald-600 hover:bg-emerald-500 text-white rounded-xl text-xs font-bold transition shadow-md cursor-pointer flex items-center gap-1.5"
              >
                <CheckCircle2 className="w-4 h-4" />
                <span>{t.admin.publishBtn}</span>
              </button>
            </div>
          </div>

          {/* Items Review Table */}
          <div className="overflow-x-auto max-h-[500px] overflow-y-auto">
            <table className="w-full text-left text-xs border-collapse">
              <thead className="bg-slate-950 text-slate-400 sticky top-0 z-10 uppercase text-[10px] tracking-wider border-b border-slate-800">
                <tr>
                  <th className="p-3">Section</th>
                  <th className="p-3">Exercise Label</th>
                  <th className="p-3">Type</th>
                  <th className="p-3">Book Page</th>
                  <th className="p-3">Confidence</th>
                  <th className="p-3 text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800/60 font-sans">
                {displayItems.map((item) => {
                  const isEditing = editingItemId === item.id;

                  return (
                    <tr key={item.id} className="hover:bg-slate-800/40 transition">
                      <td className="p-3 font-semibold text-slate-300">
                        {isEditing ? (
                          <input
                            type="text"
                            value={editForm.section_name}
                            onChange={(e) => setEditForm({ ...editForm, section_name: e.target.value })}
                            className="bg-slate-950 border border-slate-700 rounded px-2 py-1 text-xs text-white"
                          />
                        ) : (
                          item.section_name
                        )}
                      </td>
                      <td className="p-3 font-medium text-white max-w-xs">
                        {isEditing ? (
                          <input
                            type="text"
                            value={editForm.label}
                            onChange={(e) => setEditForm({ ...editForm, label: e.target.value })}
                            className="w-full bg-slate-950 border border-slate-700 rounded px-2 py-1 text-xs text-white"
                          />
                        ) : (
                          <div>
                            <span>{item.label}</span>
                            {item.needs_review && (
                              <span className="block text-[10px] text-amber-400 mt-0.5">
                                ⚠ {item.review_notes}
                              </span>
                            )}
                          </div>
                        )}
                      </td>
                      <td className="p-3">
                        <span className={`px-2 py-0.5 rounded text-[10px] font-bold ${
                          item.item_type === 'source_activity'
                            ? 'bg-blue-500/15 text-blue-300'
                            : 'bg-emerald-500/15 text-emerald-300'
                        }`}>
                          {item.item_type}
                        </span>
                      </td>
                      <td className="p-3 text-slate-400">
                        {isEditing ? (
                          <input
                            type="number"
                            value={editForm.printed_page}
                            onChange={(e) => setEditForm({ ...editForm, printed_page: Number(e.target.value) })}
                            className="w-16 bg-slate-950 border border-slate-700 rounded px-2 py-1 text-xs text-white"
                          />
                        ) : (
                          <span>p. {item.printed_page} (PDF {item.pdf_page})</span>
                        )}
                      </td>
                      <td className="p-3">
                        <span className={`text-[11px] font-bold ${
                          item.confidence_score >= 0.9 ? 'text-emerald-400' : 'text-amber-400'
                        }`}>
                          {Math.round(item.confidence_score * 100)}%
                        </span>
                      </td>
                      <td className="p-3 text-right">
                        {isEditing ? (
                          <button
                            onClick={() => handleSaveEdit(item.id)}
                            className="px-2.5 py-1 bg-emerald-600 text-white rounded text-[11px] font-bold hover:bg-emerald-500 transition"
                          >
                            Save
                          </button>
                        ) : (
                          <button
                            onClick={() => handleStartEdit(item)}
                            className="p-1.5 text-slate-400 hover:text-blue-400 transition"
                            title="Edit Item"
                          >
                            <Edit3 className="w-3.5 h-3.5" />
                          </button>
                        )}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}
