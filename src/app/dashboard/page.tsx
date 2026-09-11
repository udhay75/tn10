'use client';

// ============================================================================
// Modern Dashboard Screen (2025/2026 SaaS Bento Grid Architecture)
// Canonical Subject Order: Tamil, English, Mathematics, Science, Social Science
// ============================================================================

import React from 'react';
import Link from 'next/link';
import { 
  CheckCircle2, 
  Clock, 
  Bookmark, 
  ArrowRight, 
  BookOpen, 
  Sparkles, 
  HelpCircle, 
  CheckCircle,
  GraduationCap,
  Flame,
  Layers,
  Zap,
  RotateCcw,
  Compass
} from 'lucide-react';
import { useStudy } from '@/lib/store/study-context';
import { useAuth } from '@/lib/auth/auth-context';
import { useI18n } from '@/lib/i18n/i18n-context';
import { triggerHaptic } from '@/lib/utils/haptics';

function CircularProgress({
  percentage,
  size = 44,
  strokeWidth = 4,
  colorClass = 'text-emerald-400',
  showText = true,
  label
}: {
  percentage: number;
  size?: number;
  strokeWidth?: number;
  colorClass?: string;
  showText?: boolean;
  label?: string;
}) {
  const radius = (size - strokeWidth) / 2;
  const circumference = radius * 2 * Math.PI;
  const offset = circumference - (percentage / 100) * circumference;

  return (
    <div className="relative inline-flex items-center justify-center shrink-0" style={{ width: size, height: size }}>
      <svg width={size} height={size} className="transform -rotate-90">
        <circle
          cx={size / 2}
          cy={size / 2}
          r={radius}
          stroke="currentColor"
          strokeWidth={strokeWidth}
          className="text-slate-800/80"
          fill="transparent"
        />
        <circle
          cx={size / 2}
          cy={size / 2}
          r={radius}
          stroke="currentColor"
          strokeWidth={strokeWidth}
          className={`${colorClass} progress-ring-circle`}
          fill="transparent"
          strokeDasharray={circumference}
          strokeDashoffset={offset}
          strokeLinecap="round"
        />
      </svg>
      {showText && (
        <div className="absolute inset-0 flex flex-col items-center justify-center">
          <span className="text-[11px] font-black text-white leading-none">{percentage}%</span>
          {label && <span className="text-[7px] text-slate-400 font-semibold leading-none mt-0.5 uppercase tracking-wider">{label}</span>}
        </div>
      )}
    </div>
  );
}

export default function DashboardPage() {
  const { 
    curriculum, 
    overallStats, 
    subjectStats, 
    activeSubject, 
    setActiveSubject, 
    availableSubjects, 
    lastStudiedLesson, 
    getUnitProgress, 
    isLoading 
  } = useStudy();
  const { user } = useAuth();
  const { t, lang } = useI18n();

  if (isLoading) {
    return (
      <div className="flex flex-col items-center justify-center min-h-[60vh] gap-3">
        <div className="w-12 h-12 border-4 border-blue-500/20 border-t-blue-500 rounded-full animate-spin" />
        <p className="text-sm text-slate-400 font-medium tracking-wide">Loading study tracker...</p>
      </div>
    );
  }

  const isTamil = activeSubject === 'class_10_tamil';
  const isEnglish = activeSubject === 'class_10_english';
  const isMath = activeSubject === 'class_10_math';
  const isScience = activeSubject === 'class_10_science';
  const isSocial = activeSubject === 'class_10_social_science';

  const getSubjectGlowStyle = (code: string, isSelected: boolean) => {
    switch (code) {
      case 'class_10_tamil':
        return isSelected 
          ? 'bg-gradient-to-br from-amber-950/40 via-slate-900 to-slate-900 border-amber-500/80 shadow-lg shadow-amber-500/10 ring-1 ring-amber-500/40' 
          : 'hover:border-amber-500/40';
      case 'class_10_english':
        return isSelected 
          ? 'bg-gradient-to-br from-indigo-950/40 via-slate-900 to-slate-900 border-indigo-500/80 shadow-lg shadow-indigo-500/10 ring-1 ring-indigo-500/40' 
          : 'hover:border-indigo-500/40';
      case 'class_10_math':
        return isSelected 
          ? 'bg-gradient-to-br from-cyan-950/40 via-slate-900 to-slate-900 border-cyan-500/80 shadow-lg shadow-cyan-500/10 ring-1 ring-cyan-500/40' 
          : 'hover:border-cyan-500/40';
      case 'class_10_science':
        return isSelected 
          ? 'bg-gradient-to-br from-purple-950/40 via-slate-900 to-slate-900 border-purple-500/80 shadow-lg shadow-purple-500/10 ring-1 ring-purple-500/40' 
          : 'hover:border-purple-500/40';
      case 'class_10_social_science':
        return isSelected 
          ? 'bg-gradient-to-br from-emerald-950/40 via-slate-900 to-slate-900 border-emerald-500/80 shadow-lg shadow-emerald-500/10 ring-1 ring-emerald-500/40' 
          : 'hover:border-emerald-500/40';
      default:
        return '';
    }
  };

  const getSubjectRingColor = (code: string) => {
    switch (code) {
      case 'class_10_tamil': return 'text-amber-400';
      case 'class_10_english': return 'text-indigo-400';
      case 'class_10_math': return 'text-cyan-400';
      case 'class_10_science': return 'text-purple-400';
      case 'class_10_social_science': return 'text-emerald-400';
      default: return 'text-blue-400';
    }
  };

  return (
    <div className="space-y-8 animate-in fade-in duration-300">
      {/* 1. Affan Hero Welcome Banner */}
      <div className="relative overflow-hidden rounded-3xl border border-white/[0.1] bg-gradient-to-br from-blue-950/60 via-slate-950 to-[#050814] p-6 sm:p-8 shadow-2xl backdrop-blur-xl">
        {/* Subtle decorative radial light orbs */}
        <div className="absolute top-0 right-1/4 w-96 h-96 bg-blue-500/15 rounded-full blur-3xl pointer-events-none" />
        <div className="absolute bottom-0 right-0 w-80 h-80 bg-indigo-500/10 rounded-full blur-3xl pointer-events-none" />

        <div className="relative z-10 flex flex-col md:flex-row md:items-center md:justify-between gap-6">
          <div className="max-w-2xl">
            {/* Board Badge & Active Subject Pill */}
            <div className="flex flex-wrap items-center gap-2 mb-3">
              <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-blue-500/15 text-blue-300 border border-blue-500/30 text-xs font-bold">
                <GraduationCap className="w-3.5 h-3.5 text-blue-400" />
                <span>TN Board Class 10 SSLC</span>
              </div>
              <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-amber-400/15 text-amber-300 border border-amber-400/30 text-xs font-bold">
                <Flame className="w-3.5 h-3.5 text-amber-400" />
                <span>2025/2026 Edition</span>
              </div>
            </div>

            <h1 className="text-2xl sm:text-4xl font-black text-white tracking-tight leading-tight">
              {lang === 'ta' 
                ? `வணக்கம், ${user?.display_name || 'மாணவரே'}! 👋` 
                : `Welcome back, ${user?.display_name || 'Learner'}! 👋`}
            </h1>
            <p className="text-xs sm:text-sm text-slate-300 mt-2 leading-relaxed max-w-xl font-normal">
              {lang === 'ta'
                ? 'உங்கள் 10-ஆம் வகுப்பு பொதுத்தேர்வு பாடத்திட்ட பட்டியல், கற்றல் நிலை மற்றும் தினசரி மீள்பார்வை கண்காணிப்பகம்.'
                : 'Your comprehensive Tamil Nadu Board exam syllabus tracker, self-assessment checklist, and spaced revision engine.'}
            </p>

            {/* Quick Study Action Buttons (Affan Amber Accent) */}
            <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 mt-5">
              {lastStudiedLesson ? (
                <Link
                  href={`/lesson/${lastStudiedLesson.id}`}
                  onClick={() => triggerHaptic('light')}
                  className="inline-flex items-center justify-between sm:justify-start gap-2.5 px-5 py-3 rounded-2xl bg-gradient-to-r from-amber-400 to-amber-500 hover:from-amber-300 hover:to-amber-400 text-slate-950 font-black text-xs sm:text-sm shadow-lg shadow-amber-500/20 transition-all duration-200 active:scale-95 cursor-pointer"
                >
                  <Zap className="w-4 h-4 fill-slate-950" />
                  <span className="truncate">Resume: <strong>{lastStudiedLesson.title}</strong></span>
                  <ArrowRight className="w-4 h-4 shrink-0" />
                </Link>
              ) : (
                <Link
                  href="/curriculum"
                  onClick={() => triggerHaptic('light')}
                  className="inline-flex items-center justify-between sm:justify-start gap-2.5 px-5 py-3 rounded-2xl bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold text-xs sm:text-sm shadow-lg shadow-blue-600/25 transition-all duration-200 active:scale-95 cursor-pointer"
                >
                  <Compass className="w-4 h-4" />
                  <span>Start Learning Syllabus</span>
                  <ArrowRight className="w-4 h-4 shrink-0" />
                </Link>
              )}

              {overallStats.studyAgainCount > 0 && (
                <Link
                  href="/revision"
                  onClick={() => triggerHaptic('light')}
                  className="inline-flex items-center justify-between sm:justify-start gap-2 px-4 py-3 rounded-2xl bg-indigo-500/15 hover:bg-indigo-500/25 text-indigo-300 border border-indigo-500/30 text-xs sm:text-sm font-bold transition-all duration-200 active:scale-95 cursor-pointer"
                >
                  <span className="flex items-center gap-2">
                    <Bookmark className="w-4 h-4 text-indigo-400 fill-indigo-400/40" />
                    <span>{overallStats.studyAgainCount} {t.dashboard.studyAgainBtn}</span>
                  </span>
                  <ArrowRight className="w-4 h-4 shrink-0 sm:hidden" />
                </Link>
              )}
            </div>
          </div>

          {/* Hero Overall Progress Ring Capsule (Desktop) */}
          <div className="hidden lg:flex flex-col items-center justify-center p-6 rounded-3xl bg-slate-950/70 border border-white/[0.08] shrink-0 shadow-2xl backdrop-blur-md">
            <CircularProgress 
              percentage={overallStats.percentage} 
              size={88} 
              strokeWidth={7} 
              colorClass="text-emerald-400" 
              label="Overall"
            />
            <span className="text-xs font-bold text-white mt-3">
              {overallStats.completed} / {overallStats.total} Done
            </span>
            <span className="text-[10px] text-slate-400 font-medium">
              5 Subjects Unified
            </span>
          </div>
        </div>
      </div>

      {/* 2. Affan Feature Quick Stats Grid (4 Columns) */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
        {/* Card 1: Syllabus Progress */}
        <div className="feature-card bg-slate-900/85 border border-white/[0.08] rounded-2xl p-4 shadow-sm flex items-center justify-between">
          <div>
            <span className="text-[11px] font-bold text-slate-400 uppercase tracking-wide block">Overall Progress</span>
            <span className="text-2xl font-black text-emerald-400 mt-1 block">{overallStats.percentage}%</span>
            <span className="text-[10px] text-slate-500">{overallStats.completed} / {overallStats.total} items done</span>
          </div>
          <CircularProgress 
            percentage={overallStats.percentage} 
            size={42} 
            strokeWidth={4} 
            colorClass="text-emerald-400"
            showText={false}
          />
        </div>

        {/* Card 2: Completed Checklist Activities */}
        <div className="feature-card bg-slate-900/85 border border-white/[0.08] rounded-2xl p-4 shadow-sm flex items-center justify-between">
          <div>
            <span className="text-[11px] font-bold text-slate-400 uppercase tracking-wide block">Activities Done</span>
            <span className="text-2xl font-black text-blue-400 mt-1 block">{overallStats.completed}</span>
            <span className="text-[10px] text-slate-500">of {overallStats.total} textbook exercises</span>
          </div>
          <div className="w-10 h-10 rounded-2xl bg-blue-500/10 text-blue-400 border border-blue-500/20 flex items-center justify-center shrink-0">
            <CheckCircle2 className="w-5 h-5" />
          </div>
        </div>

        {/* Card 3: Revisions Due */}
        <div className="feature-card bg-slate-900/85 border border-white/[0.08] rounded-2xl p-4 shadow-sm flex items-center justify-between">
          <div>
            <span className="text-[11px] font-bold text-slate-400 uppercase tracking-wide block">Spaced Revision</span>
            <span className="text-2xl font-black text-amber-400 mt-1 block">{overallStats.studyAgainCount}</span>
            <span className="text-[10px] text-slate-500">{overallStats.studyAgainCount > 0 ? 'Review due today' : 'Up to date'}</span>
          </div>
          <div className="w-10 h-10 rounded-2xl bg-amber-500/10 text-amber-400 border border-amber-500/20 flex items-center justify-center shrink-0">
            <Bookmark className="w-5 h-5" />
          </div>
        </div>

        {/* Card 4: 5 Board Subjects */}
        <div className="feature-card bg-slate-900/85 border border-white/[0.08] rounded-2xl p-4 shadow-sm flex items-center justify-between">
          <div>
            <span className="text-[11px] font-bold text-slate-400 uppercase tracking-wide block">Board Subjects</span>
            <span className="text-2xl font-black text-indigo-400 mt-1 block">5</span>
            <span className="text-[10px] text-slate-500">Tamil, Eng, Mat, Sci, Soc</span>
          </div>
          <div className="w-10 h-10 rounded-2xl bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 flex items-center justify-center shrink-0">
            <Layers className="w-5 h-5" />
          </div>
        </div>
      </div>

      {/* 3. Affan 5-Subject Quick Switcher Row */}
      <div className="space-y-2">
        <div className="flex items-center justify-between px-1">
          <span className="text-xs font-bold uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
            <Sparkles className="w-3.5 h-3.5 text-blue-400" />
            <span>Switch Board Subject (பாடங்கள்)</span>
          </span>
          <span className="text-[11px] text-slate-500">Tap to view subject details</span>
        </div>

        <div className="grid grid-cols-5 gap-2 sm:gap-3">
          {availableSubjects.map((sub) => {
            const isSelected = activeSubject === sub.code;
            return (
              <button
                key={sub.code}
                onClick={() => {
                  triggerHaptic('selection');
                  setActiveSubject(sub.code);
                }}
                className={`py-2.5 px-2 rounded-2xl border transition-all duration-200 cursor-pointer flex flex-col items-center justify-center gap-1 text-center active:scale-95 ${
                  isSelected
                    ? 'bg-blue-600/20 border-blue-500/80 shadow-md shadow-blue-500/20 ring-1 ring-blue-500/50'
                    : 'bg-slate-900/60 border-white/[0.06] hover:bg-slate-800/80 text-slate-400 hover:text-white'
                }`}
              >
                <span className="text-xl sm:text-2xl">{sub.icon}</span>
                <span className={`text-[11px] sm:text-xs font-bold leading-tight truncate w-full ${isSelected ? 'text-white' : 'text-slate-300'}`}>
                  {sub.title.split(' ')[0]}
                </span>
                <span className={`text-[9px] px-1 rounded font-semibold ${isSelected ? 'bg-blue-500 text-white' : 'bg-slate-800 text-slate-400'}`}>
                  {sub.edition}
                </span>
              </button>
            );
          })}
        </div>
      </div>

      {/* 2. 5-Subject Bento Cards (Strict Canonical Order: Tamil, English, Math, Science, Social) */}
      <div className="space-y-3">
        <div className="flex items-center justify-between px-1">
          <h2 className="text-xs font-bold uppercase tracking-wider text-slate-400 flex items-center gap-2">
            <Layers className="w-3.5 h-3.5 text-blue-400" />
            <span>5 Board Subjects (பாடங்கள்)</span>
          </h2>
          <span className="text-xs text-slate-500 font-medium">Tap card to switch active subject</span>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-3.5">
          {availableSubjects.map((sub) => {
            const stats = subjectStats[sub.code];
            const isSelected = activeSubject === sub.code;
            const glowStyle = getSubjectGlowStyle(sub.code, isSelected);

            return (
              <div
                key={sub.code}
                onClick={() => {
                  triggerHaptic('selection');
                  setActiveSubject(sub.code);
                }}
                className={`p-4 rounded-2xl border transition-all duration-200 cursor-pointer flex flex-col justify-between glass-card tap-bounce ${
                  isSelected
                    ? glowStyle
                    : 'bg-slate-900/60 border-white/[0.06] hover:bg-slate-900/80 hover:border-white/[0.12]'
                }`}
              >
                <div>
                  <div className="flex items-center justify-between mb-3">
                    <div className="flex items-center gap-2.5 min-w-0">
                      <span className="text-2xl p-1 bg-slate-800/60 rounded-xl border border-white/[0.05] shrink-0">{sub.icon}</span>
                      <div className="min-w-0">
                        <h3 className="text-sm font-bold text-white tracking-tight truncate">{sub.title}</h3>
                        <span className="text-[10px] font-semibold text-slate-400">
                          {sub.edition}
                        </span>
                      </div>
                    </div>

                    <CircularProgress 
                      percentage={stats.percentage} 
                      size={40} 
                      strokeWidth={3.5} 
                      colorClass={getSubjectRingColor(sub.code)} 
                    />
                  </div>

                  {/* Progress bar */}
                  <div className="space-y-1 mt-2">
                    <div className="flex items-baseline justify-between text-xs">
                      <span className="text-[11px] text-slate-400 font-medium">Completed</span>
                      <span className="text-xs font-bold text-slate-200">{stats.completed}/{stats.total}</span>
                    </div>
                    <div className="w-full bg-slate-800/80 h-1.5 rounded-full overflow-hidden">
                      <div
                        className="bg-gradient-to-r from-emerald-500 to-teal-400 h-full rounded-full transition-all duration-500"
                        style={{ width: `${stats.percentage}%` }}
                      />
                    </div>
                  </div>
                </div>

                <div className="mt-3 pt-2.5 border-t border-white/[0.06] flex items-center justify-between text-[11px] text-slate-400">
                  <span>{sub.unitsCount} chapters</span>
                  {stats.studyAgainCount > 0 ? (
                    <span className="text-amber-400 font-semibold flex items-center gap-1">
                      <Bookmark className="w-3 h-3 fill-amber-400" />
                      {stats.studyAgainCount} rev
                    </span>
                  ) : isSelected ? (
                    <span className="text-emerald-400 font-semibold">Active</span>
                  ) : null}
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* 3. Metric Bento Hub for Active Subject */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {/* Overall Completion */}
        <div className="glass-card rounded-2xl p-5 flex flex-col justify-between border-emerald-500/20 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-bold uppercase tracking-wider text-slate-400">
              {t.dashboard.overallProgress}
            </span>
            <div className="w-8 h-8 rounded-xl bg-emerald-500/10 text-emerald-400 flex items-center justify-center border border-emerald-500/20">
              <CheckCircle2 className="w-4 h-4" />
            </div>
          </div>
          <div className="flex items-baseline gap-2 my-2">
            <span className="text-3xl font-black text-white">
              {overallStats.percentage}%
            </span>
            <span className="text-xs text-slate-400 font-medium">
              ({overallStats.completed}/{overallStats.total} {lang === 'ta' ? 'செயல்பாடுகள்' : 'tasks'})
            </span>
          </div>
          <div className="w-full bg-slate-800/80 h-2 rounded-full overflow-hidden">
            <div 
              className="bg-emerald-500 h-full rounded-full transition-all duration-500" 
              style={{ width: `${overallStats.percentage}%` }}
            />
          </div>
        </div>

        {/* Pending Work */}
        <div className="glass-card rounded-2xl p-5 flex flex-col justify-between border-amber-500/20 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-bold uppercase tracking-wider text-slate-400">
              {t.dashboard.pendingItems}
            </span>
            <div className="w-8 h-8 rounded-xl bg-amber-500/10 text-amber-400 flex items-center justify-center border border-amber-500/20">
              <Clock className="w-4 h-4" />
            </div>
          </div>
          <div className="flex items-baseline gap-2 my-2">
            <span className="text-3xl font-black text-white">
              {overallStats.notStarted + overallStats.inProgress}
            </span>
            <span className="text-xs text-slate-400 font-medium">
              ({overallStats.inProgress} {lang === 'ta' ? 'நடப்பில்' : 'in progress'})
            </span>
          </div>
          <p className="text-[11px] text-slate-400 font-medium">
            {overallStats.notStarted} {lang === 'ta' ? 'தொடங்கப்படவில்லை' : 'not yet started'}
          </p>
        </div>

        {/* Revision Queue */}
        <div className="glass-card rounded-2xl p-5 flex flex-col justify-between border-indigo-500/20 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-bold uppercase tracking-wider text-slate-400">
              {t.dashboard.revisionQueue}
            </span>
            <div className="w-8 h-8 rounded-xl bg-indigo-500/10 text-indigo-400 flex items-center justify-center border border-indigo-500/20">
              <Bookmark className="w-4 h-4 fill-indigo-400/40" />
            </div>
          </div>
          <div className="flex items-baseline gap-2 my-2">
            <span className="text-3xl font-black text-indigo-400">
              {overallStats.studyAgainCount}
            </span>
            <span className="text-xs text-slate-400 font-medium">
              {lang === 'ta' ? 'பயிற்சிகள்' : 'flagged items'}
            </span>
          </div>
          <p className="text-[11px] text-slate-400 font-medium">
            {lang === 'ta' ? 'தேர்வு மீள்பார்வைக்குக் குறிக்கப்பட்டது' : 'Marked for periodic exam review'}
          </p>
        </div>

        {/* Needs Clarification */}
        <div className="glass-card rounded-2xl p-5 flex flex-col justify-between border-rose-500/20 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-bold uppercase tracking-wider text-slate-400">
              {t.dashboard.needHelpItems}
            </span>
            <div className="w-8 h-8 rounded-xl bg-rose-500/10 text-rose-400 flex items-center justify-center border border-rose-500/20">
              <HelpCircle className="w-4 h-4" />
            </div>
          </div>
          <div className="flex items-baseline gap-2 my-2">
            <span className="text-3xl font-black text-rose-400">
              {overallStats.needHelpCount}
            </span>
            <span className="text-xs text-slate-400 font-medium">
              ({overallStats.partlyUnderstoodCount} {lang === 'ta' ? 'ஓரளவு' : 'partial'})
            </span>
          </div>
          <p className="text-[11px] text-slate-400 font-medium">
            {lang === 'ta' ? 'ஆசிரியர் விளக்கம் தேவை' : 'Marked as needing clarification'}
          </p>
        </div>
      </div>

      {/* 4. Understanding vs Completion Separation Hub */}
      <div className="glass-panel rounded-3xl p-5 border-white/[0.08]">
        <div className="flex items-center justify-between mb-3">
          <h2 className="text-xs font-bold uppercase tracking-wider text-slate-400 flex items-center gap-2">
            <Sparkles className="w-3.5 h-3.5 text-blue-400" />
            <span>{t.dashboard.progressBreakdown} — {curriculum.subject.title}</span>
          </h2>
          <span className="text-[11px] text-slate-500 hidden sm:inline">Completion is separate from Understanding</span>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          <div className="bg-slate-900/80 p-3.5 rounded-2xl border border-emerald-500/20">
            <div className="flex items-center gap-2 text-emerald-400 text-xs font-bold">
              <CheckCircle className="w-3.5 h-3.5" />
              <span>{t.status.understood}</span>
            </div>
            <p className="text-2xl font-black text-white mt-1">{overallStats.understoodCount}</p>
          </div>

          <div className="bg-slate-900/80 p-3.5 rounded-2xl border border-amber-500/20">
            <div className="flex items-center gap-2 text-amber-400 text-xs font-bold">
              <Sparkles className="w-3.5 h-3.5" />
              <span>{t.status.partly_understood}</span>
            </div>
            <p className="text-2xl font-black text-white mt-1">{overallStats.partlyUnderstoodCount}</p>
          </div>

          <div className="bg-slate-900/80 p-3.5 rounded-2xl border border-rose-500/20">
            <div className="flex items-center gap-2 text-rose-400 text-xs font-bold">
              <HelpCircle className="w-3.5 h-3.5" />
              <span>{t.status.need_help}</span>
            </div>
            <p className="text-2xl font-black text-white mt-1">{overallStats.needHelpCount}</p>
          </div>

          <div className="bg-slate-900/80 p-3.5 rounded-2xl border border-indigo-500/20">
            <div className="flex items-center gap-2 text-indigo-400 text-xs font-bold">
              <Bookmark className="w-3.5 h-3.5" />
              <span>{t.lesson.studyAgainToggle}</span>
            </div>
            <p className="text-2xl font-black text-white mt-1">{overallStats.studyAgainCount}</p>
          </div>
        </div>
      </div>

      {/* Affan Spaced Revision Flash Alert (if any items due) */}
      {overallStats.studyAgainCount > 0 && (
        <div className="bg-gradient-to-r from-amber-500/20 via-orange-500/15 to-transparent border border-amber-500/30 rounded-3xl p-5 sm:p-6 shadow-xl flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="flex items-start sm:items-center gap-3.5">
            <div className="w-12 h-12 rounded-2xl bg-amber-400 text-slate-950 flex items-center justify-center font-black shrink-0 shadow-lg shadow-amber-500/25">
              <Bookmark className="w-6 h-6 fill-slate-950" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <span className="text-xs font-black px-2 py-0.5 rounded-full bg-amber-400 text-slate-950 uppercase tracking-wide">
                  Revision Due Today
                </span>
                <span className="text-xs text-amber-300 font-bold">
                  {overallStats.studyAgainCount} Items
                </span>
              </div>
              <h3 className="text-sm sm:text-base font-bold text-white mt-1">
                Keep your memory fresh with Spaced Repetition
              </h3>
              <p className="text-xs text-slate-300 mt-0.5">
                Reviewing marked concepts within 24-48 hours drastically boosts retention for board exams.
              </p>
            </div>
          </div>

          <Link
            href="/revision"
            onClick={() => triggerHaptic('medium')}
            className="px-5 py-3 rounded-2xl bg-amber-400 hover:bg-amber-300 text-slate-950 font-black text-xs transition shadow-lg shadow-amber-500/20 shrink-0 flex items-center justify-center gap-2 cursor-pointer active:scale-95"
          >
            <span>Review {overallStats.studyAgainCount} Items</span>
            <ArrowRight className="w-4 h-4" />
          </Link>
        </div>
      )}

      {/* 5. Chapters & Units Bento Overview */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-base sm:text-lg font-extrabold text-white flex items-center gap-2">
            <BookOpen className="w-5 h-5 text-blue-400" />
            <span>
              {curriculum.subject.title}{' '}
              {isTamil 
                ? 'இயல்கள் கண்ணோட்டம் (Iyals Overview)' 
                : isMath 
                  ? 'Chapters Overview' 
                  : isScience 
                    ? 'Units & Practicals' 
                    : isSocial 
                      ? 'Disciplines Overview' 
                      : t.dashboard.unitsOverview}
            </span>
          </h2>
          <Link href="/curriculum" className="text-xs font-bold text-blue-400 hover:text-blue-300 transition">
            {lang === 'ta' ? 'முழு பாடத்திட்டம் பார்க்க →' : 'View Full Curriculum →'}
          </Link>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {curriculum.units.map((unit) => {
            const stats = getUnitProgress(unit.id);
            return (
              <div 
                key={unit.id}
                className="glass-card rounded-3xl p-5 shadow-sm flex flex-col justify-between hover:border-blue-500/30"
              >
                <div>
                  <div className="flex items-center justify-between mb-2">
                    <span className="text-[11px] font-extrabold text-blue-400 uppercase tracking-wider px-2 py-0.5 rounded-md bg-blue-500/10 border border-blue-500/20">
                      {isTamil ? `இயல் ${unit.unit_number}` : (isMath ? `Chapter ${unit.unit_number}` : (isScience ? (unit.unit_number === 24 ? 'Practicals' : `Unit ${unit.unit_number}`) : (isSocial ? `Unit ${unit.unit_number}` : unit.title)))}
                    </span>
                    <span className="text-xs font-bold text-emerald-400">
                      {stats.percentage}%
                    </span>
                  </div>

                  <h3 className="text-sm font-bold text-white mb-1">
                    {isTamil || isMath || isScience || isSocial ? unit.title : unit.theme}
                  </h3>

                  {(isTamil || isMath || isScience || isSocial) && (
                    <p className="text-xs text-slate-400 line-clamp-1 mb-3" title={unit.theme}>
                      {unit.theme}
                    </p>
                  )}

                  {/* Unit Progress Bar */}
                  <div className="w-full bg-slate-800/80 h-1.5 rounded-full overflow-hidden mb-4">
                    <div 
                      className="bg-gradient-to-r from-emerald-500 to-teal-400 h-full rounded-full transition-all duration-300" 
                      style={{ width: `${stats.percentage}%` }}
                    />
                  </div>

                  {/* Lessons List in Unit */}
                  <div className="space-y-1.5">
                    {unit.lessons.slice(0, 4).map((l) => (
                      <Link
                        key={l.id}
                        href={`/lesson/${l.id}`}
                        className="flex items-center justify-between p-2 rounded-xl hover:bg-slate-800/70 text-xs transition-colors group"
                      >
                        <div className="flex items-center gap-2 truncate">
                          <span className={`w-2 h-2 rounded-full ${
                            l.lesson_type === 'prose' ? 'bg-blue-400' :
                            l.lesson_type === 'poem' ? 'bg-purple-400' :
                            l.lesson_type === 'supplementary' ? 'bg-emerald-400' :
                            l.lesson_type === 'practical' ? 'bg-amber-400' :
                            l.lesson_type === 'review' ? 'bg-indigo-400' : 'bg-teal-400'
                          }`} />
                          <span className="text-slate-300 group-hover:text-white truncate font-medium">
                            {l.title}
                          </span>
                          {l.is_memoriter && (
                            <span className="text-[10px] bg-amber-500/20 text-amber-300 px-1 py-0.2 rounded font-bold" title="நினைவுறுத்தல் செய்யுள் / திருக்குறள் (Memoriter)">★</span>
                          )}
                        </div>
                        <span className="text-slate-500 text-[11px] shrink-0 font-medium">
                          p. {l.printed_page_start}
                        </span>
                      </Link>
                    ))}
                    {unit.lessons.length > 4 && (
                      <Link
                        href="/curriculum"
                        className="block text-center py-1 text-[11px] font-semibold text-blue-400 hover:text-blue-300"
                      >
                        + {unit.lessons.length - 4} more modules
                      </Link>
                    )}
                  </div>
                </div>

                <div className="mt-4 pt-3 border-t border-white/[0.06] flex items-center justify-between text-[11px] text-slate-400">
                  <span>{stats.completed}/{stats.total} {lang === 'ta' ? 'முடிக்கப்பட்டது' : 'done'}</span>
                  {stats.studyAgain > 0 && (
                    <span className="text-indigo-400 font-semibold flex items-center gap-1">
                      <Bookmark className="w-3 h-3 fill-indigo-400" />
                      {stats.studyAgain} {lang === 'ta' ? 'மறுஆய்வு' : 'to revise'}
                    </span>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}
