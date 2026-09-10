'use client';

// ============================================================================
// Modern Curriculum Browser (2025/2026 Glassmorphic Multi-Subject Explorer)
// Canonical Subject Order: Tamil, English, Mathematics, Science, Social Science
// ============================================================================

import React, { useState } from 'react';
import Link from 'next/link';
import { 
  BookOpen, 
  Sparkles, 
  Search, 
  ChevronRight, 
  Bookmark, 
  CheckCircle2, 
  FileText,
  Layers,
  X
} from 'lucide-react';
import { useStudy } from '@/lib/store/study-context';
import { useI18n } from '@/lib/i18n/i18n-context';
import { LessonType } from '@/types';

export default function CurriculumPage() {
  const { curriculum, getLessonProgress, getUnitProgress, isLoading, activeSubject, setActiveSubject, availableSubjects } = useStudy();
  const { t, lang } = useI18n();
  const [selectedType, setSelectedType] = useState<'all' | LessonType | 'history' | 'geography' | 'civics' | 'economics' | 'map_work'>('all');
  const [searchQuery, setSearchQuery] = useState('');

  if (isLoading) {
    return (
      <div className="flex flex-col items-center justify-center min-h-[60vh] gap-3">
        <div className="w-12 h-12 border-4 border-blue-500/20 border-t-blue-500 rounded-full animate-spin" />
        <p className="text-sm text-slate-400 font-medium">Loading curriculum...</p>
      </div>
    );
  }

  const isTamil = activeSubject === 'class_10_tamil';
  const isEnglish = activeSubject === 'class_10_english';
  const isMath = activeSubject === 'class_10_math';
  const isScience = activeSubject === 'class_10_science';
  const isSocial = activeSubject === 'class_10_social_science';

  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      {/* 1. Subject Switcher & Search Bar in Canonical Order */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-3.5 glass-panel rounded-3xl p-3 sm:p-4 shadow-xl">
        {/* Canonical Subject Pills */}
        <div className="flex items-center gap-1.5 overflow-x-auto pb-1 md:pb-0">
          {availableSubjects.map((sub) => {
            const isSelected = activeSubject === sub.code;
            return (
              <button
                key={sub.code}
                onClick={() => {
                  setActiveSubject(sub.code);
                  setSelectedType('all');
                }}
                className={`flex items-center gap-2 px-3.5 py-2 rounded-2xl text-xs font-bold whitespace-nowrap transition-all duration-200 cursor-pointer ${
                  isSelected
                    ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/25 scale-[1.02]'
                    : 'bg-slate-900/60 text-slate-400 hover:text-white hover:bg-slate-800/80 border border-white/[0.05]'
                }`}
              >
                <span>{sub.icon}</span>
                <span>{sub.title}</span>
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold ${isSelected ? 'bg-blue-700/80 text-white' : 'bg-slate-800 text-slate-400'}`}>
                  {sub.edition}
                </span>
              </button>
            );
          })}
        </div>

        {/* Search Bar */}
        <div className="relative w-full md:w-72">
          <Search className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder={lang === 'ta' ? 'பாடங்களை தேடுக...' : 'Search lessons or topics...'}
            className="w-full pl-9 pr-8 py-2 bg-slate-950/80 border border-white/[0.1] rounded-2xl text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500/80 transition-colors"
          />
          {searchQuery && (
            <button 
              onClick={() => setSearchQuery('')}
              className="absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-white p-1"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          )}
        </div>
      </div>

      {/* 2. Page Header & Filter Tabs */}
      <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight flex items-center gap-2.5">
            <span>{curriculum.subject.title}</span>
            <span className="text-xs font-bold text-blue-400 bg-blue-500/10 px-3 py-1 rounded-full border border-blue-500/25">
              {curriculum.subject.curriculum_version}
            </span>
          </h1>
          <p className="text-xs sm:text-sm text-slate-400 mt-1 font-medium">
            {curriculum.summary.total_units} {lang === 'ta' ? 'இயல்கள்/அலகுகள்' : 'Chapters/Units'} • {curriculum.summary.total_lessons} {lang === 'ta' ? 'பாடங்கள்' : 'Modules'} • {curriculum.summary.total_checklist_items} {lang === 'ta' ? 'பயிற்சி செயல்பாடுகள்' : 'Activities'}
          </p>
        </div>

        {/* Filter Pills */}
        <div className="flex items-center gap-1.5 overflow-x-auto pb-1">
          <button
            onClick={() => setSelectedType('all')}
            className={`px-3.5 py-1.5 rounded-xl text-xs font-bold whitespace-nowrap transition cursor-pointer ${
              selectedType === 'all'
                ? 'bg-blue-600 text-white shadow-md'
                : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
            }`}
          >
            {t.curriculum.filterAll}
          </button>

          {isTamil ? (
            <>
              <button
                onClick={() => setSelectedType('prose')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'prose' ? 'bg-blue-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'உரைநடை' : 'Prose'}
              </button>
              <button
                onClick={() => setSelectedType('poem')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'poem' ? 'bg-purple-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'கவிதைப் பேழை' : 'Poetry'}
              </button>
              <button
                onClick={() => setSelectedType('supplementary')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'supplementary' ? 'bg-emerald-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'விரிவானம்' : 'Supplementary'}
              </button>
              <button
                onClick={() => setSelectedType('theory')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'theory' ? 'bg-amber-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'கற்கண்டு (இலக்கணம்)' : 'Grammar'}
              </button>
              <button
                onClick={() => setSelectedType('exercise')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'exercise' ? 'bg-cyan-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'மொழிப்பயிற்சி' : 'Activities'}
              </button>
              <button
                onClick={() => setSelectedType('review')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'review' ? 'bg-indigo-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'வாழ்வியல் / திருக்குறள்' : 'Thirukkural'}
              </button>
            </>
          ) : isSocial ? (
            <>
              <button
                onClick={() => setSelectedType('history')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'history' ? 'bg-amber-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'வரலாறு' : 'History'}
              </button>
              <button
                onClick={() => setSelectedType('geography')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'geography' ? 'bg-emerald-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'புவியியல்' : 'Geography'}
              </button>
              <button
                onClick={() => setSelectedType('civics')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'civics' ? 'bg-blue-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'குடிமையியல்' : 'Civics'}
              </button>
              <button
                onClick={() => setSelectedType('economics')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'economics' ? 'bg-purple-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'பொருளியல்' : 'Economics'}
              </button>
              <button
                onClick={() => setSelectedType('map_work')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'map_work' ? 'bg-rose-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'வரைபடம்' : 'Map & Timeline'}
              </button>
            </>
          ) : isScience ? (
            <>
              <button
                onClick={() => setSelectedType('theory')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'theory' ? 'bg-emerald-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'பாடக் கருத்துக்கள்' : 'Theory'}
              </button>
              <button
                onClick={() => setSelectedType('exercise')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'exercise' ? 'bg-cyan-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'பாட மதிப்பீடு' : 'Evaluation'}
              </button>
              <button
                onClick={() => setSelectedType('practical')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'practical' ? 'bg-amber-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'செய்முறைப் பயிற்சி' : 'Practicals'}
              </button>
            </>
          ) : isMath ? (
            <>
              <button
                onClick={() => setSelectedType('exercise')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'exercise' ? 'bg-cyan-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'பயிற்சிகள்' : 'Exercises'}
              </button>
              <button
                onClick={() => setSelectedType('practical')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'practical' ? 'bg-amber-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'வரைபடங்கள்' : 'Practical Geometry/Graphs'}
              </button>
              <button
                onClick={() => setSelectedType('review')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'review' ? 'bg-indigo-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {lang === 'ta' ? 'மீள்பார்வை / MCQs' : 'Reviews & MCQs'}
              </button>
            </>
          ) : (
            <>
              <button
                onClick={() => setSelectedType('prose')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'prose' ? 'bg-blue-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {t.curriculum.filterProse}
              </button>
              <button
                onClick={() => setSelectedType('poem')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'poem' ? 'bg-purple-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {t.curriculum.filterPoem}
              </button>
              <button
                onClick={() => setSelectedType('supplementary')}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition cursor-pointer ${
                  selectedType === 'supplementary' ? 'bg-emerald-600 text-white' : 'bg-slate-900 text-slate-400 hover:text-white border border-white/[0.08]'
                }`}
              >
                {t.curriculum.filterSupplementary}
              </button>
            </>
          )}
        </div>
      </div>

      {/* 3. Units Breakdown Cards */}
      <div className="space-y-6">
        {curriculum.units.map((unit) => {
          const unitStats = getUnitProgress(unit.id);
          const filteredLessons = unit.lessons.filter((l) => {
            const matchesType = 
              selectedType === 'all' || 
              l.lesson_type === selectedType ||
              (selectedType === 'history' && unit.theme.startsWith('History')) ||
              (selectedType === 'geography' && unit.theme.startsWith('Geography')) ||
              (selectedType === 'civics' && unit.theme.startsWith('Civics')) ||
              (selectedType === 'economics' && unit.theme.startsWith('Economics')) ||
              (selectedType === 'map_work' && l.checklist_items.some(ci => ci.section_name.includes('Map') || ci.section_name.includes('Timeline')));

            const matchesSearch = searchQuery === '' || 
              l.title.toLowerCase().includes(searchQuery.toLowerCase()) || 
              l.author.toLowerCase().includes(searchQuery.toLowerCase());
            return matchesType && matchesSearch;
          });

          if (filteredLessons.length === 0) return null;

          return (
            <div 
              key={unit.id}
              className="glass-panel rounded-3xl p-6 shadow-xl border-white/[0.08]"
            >
              {/* Unit Header */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-4 mb-4 border-b border-white/[0.08]">
                <div>
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-bold px-2.5 py-0.5 rounded-lg bg-blue-500/15 text-blue-400 border border-blue-500/30 uppercase tracking-wider">
                      {isTamil ? `இயல் ${unit.unit_number}` : (isMath ? `Chapter ${unit.unit_number}` : unit.title.split(':')[0])}
                    </span>
                    <h2 className="text-base sm:text-lg font-bold text-white">
                      {isTamil ? unit.title : (isMath ? unit.title : (unit.title.includes(':') ? unit.title.split(':')[1].trim() : unit.title))}
                    </h2>
                  </div>
                  <p className="text-xs text-slate-400 mt-1 font-medium">
                    {unit.theme}
                  </p>
                </div>

                <div className="flex items-center gap-3">
                  <div className="text-right">
                    <span className="text-xs font-bold text-emerald-400">
                      {unitStats.percentage}% {lang === 'ta' ? 'முடிந்தது' : 'Done'}
                    </span>
                    <p className="text-[11px] text-slate-400">
                      {unitStats.completed}/{unitStats.total} {lang === 'ta' ? 'பணிகள்' : 'tasks'}
                    </p>
                  </div>
                  <div className="w-20 sm:w-28 bg-slate-800/80 h-2 rounded-full overflow-hidden">
                    <div 
                      className="bg-gradient-to-r from-emerald-500 to-teal-400 h-full rounded-full transition-all duration-300" 
                      style={{ width: `${unitStats.percentage}%` }}
                    />
                  </div>
                </div>
              </div>

              {/* Lessons Grid */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {filteredLessons.map((lesson) => {
                  const lessonStats = getLessonProgress(lesson.id);
                  const isCompleted = lessonStats.percentage === 100;
                  const isInProgress = lessonStats.completed > 0 && lessonStats.percentage < 100;

                  return (
                    <Link
                      key={lesson.id}
                      href={`/lesson/${lesson.id}`}
                      className="glass-card rounded-2xl p-4 transition-all duration-200 flex flex-col justify-between group shadow-sm hover:border-blue-500/40"
                    >
                      <div>
                        {/* Type pill & memoriter badge */}
                        <div className="flex items-center justify-between gap-2 mb-2">
                          <span className={`text-[10px] font-bold uppercase tracking-wider px-2 py-0.5 rounded-md ${
                            lesson.lesson_type === 'prose' ? 'bg-blue-500/15 text-blue-300 border border-blue-500/30' :
                            lesson.lesson_type === 'poem' ? 'bg-purple-500/15 text-purple-300 border border-purple-500/30' :
                            lesson.lesson_type === 'supplementary' ? 'bg-emerald-500/15 text-emerald-300 border border-emerald-500/30' :
                            lesson.lesson_type === 'theory' ? 'bg-amber-500/15 text-amber-300 border border-amber-500/30' :
                            lesson.lesson_type === 'practical' ? 'bg-amber-500/15 text-amber-300 border border-amber-500/30' :
                            lesson.lesson_type === 'review' ? 'bg-indigo-500/15 text-indigo-300 border border-indigo-500/30' :
                            'bg-cyan-500/15 text-cyan-300 border border-cyan-500/30'
                          }`}>
                            {isTamil ? (
                              lesson.lesson_type === 'prose' ? 'உரைநடை' :
                              lesson.lesson_type === 'poem' ? 'கவிதை' :
                              lesson.lesson_type === 'supplementary' ? 'விரிவானம்' :
                              lesson.lesson_type === 'theory' ? 'இலக்கணம்' :
                              lesson.lesson_type === 'review' ? 'திருக்குறள்' : 'பயிற்சி'
                            ) : lesson.lesson_type}
                          </span>

                          {lesson.is_memoriter && (
                            <span 
                              title="Memoriter poem / couplet"
                              className="inline-flex items-center gap-1 text-[10px] font-bold bg-amber-500/20 text-amber-300 border border-amber-500/30 px-1.5 py-0.5 rounded-md"
                            >
                              <Sparkles className="w-3 h-3" />
                              {lang === 'ta' ? 'மனப்பாடம்' : 'Memoriter'}
                            </span>
                          )}
                        </div>

                        {/* Title & Description */}
                        <h3 className="text-sm font-bold text-white group-hover:text-blue-300 transition-colors line-clamp-2">
                          {lesson.title}
                        </h3>
                        <p className="text-xs text-slate-400 mt-1 line-clamp-1 font-medium">
                          {lesson.author}
                        </p>

                        {/* Page Numbers */}
                        <div className="flex items-center gap-2 text-[11px] text-slate-500 mt-3 font-medium">
                          <FileText className="w-3 h-3" />
                          <span>Book p. {lesson.printed_page_start}–{lesson.printed_page_end}</span>
                          <span>•</span>
                          <span>PDF p. {lesson.pdf_page_start}–{lesson.pdf_page_end}</span>
                        </div>
                      </div>

                      {/* Footer Progress */}
                      <div className="mt-4 pt-3 border-t border-white/[0.06] flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          {isCompleted ? (
                            <span className="inline-flex items-center gap-1 text-[11px] font-bold text-emerald-400">
                              <CheckCircle2 className="w-3.5 h-3.5" />
                              {t.curriculum.completedBadge}
                            </span>
                          ) : isInProgress ? (
                            <span className="text-[11px] font-bold text-amber-400">
                              {lessonStats.percentage}% {t.curriculum.inProgressBadge}
                            </span>
                          ) : (
                            <span className="text-[11px] text-slate-500 font-medium">
                              {lessonStats.total} {lang === 'ta' ? 'பணிகள்' : 'tasks'}
                            </span>
                          )}

                          {lessonStats.studyAgain > 0 && (
                            <span className="inline-flex items-center gap-0.5 text-[10px] text-indigo-400 bg-indigo-500/15 px-1.5 py-0.5 rounded font-bold">
                              <Bookmark className="w-2.5 h-2.5 fill-indigo-400" />
                              {lessonStats.studyAgain}
                            </span>
                          )}
                        </div>

                        <ChevronRight className="w-4 h-4 text-slate-500 group-hover:text-blue-400 transition-transform group-hover:translate-x-1" />
                      </div>
                    </Link>
                  );
                })}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
