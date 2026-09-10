'use client';

// ============================================================================
// Modern Application Header (2025/2026 SaaS Glassmorphism Design)
// Canonical Subject Order: Tamil, English, Mathematics, Science, Social Science
// ============================================================================

import React from 'react';
import Link from 'next/link';
import { 
  WifiOff, 
  RefreshCw, 
  CheckCircle2, 
  AlertCircle, 
  Languages, 
  BookOpen, 
  ShieldCheck, 
  UserCircle,
  Database,
  Download
} from 'lucide-react';
import { useI18n } from '@/lib/i18n/i18n-context';
import { useAuth } from '@/lib/auth/auth-context';
import { useStudy } from '@/lib/store/study-context';
import { triggerHaptic } from '@/lib/utils/haptics';

export function Header() {
  const { lang, toggleLang, t } = useI18n();
  const { user, isDemoMode, isAdmin } = useAuth();
  const { syncStatus, unsyncedCount, triggerSync, activeSubject, setActiveSubject, availableSubjects } = useStudy();

  const getSubjectTheme = (code: string) => {
    switch (code) {
      case 'class_10_tamil':
        return { activeBg: 'bg-amber-500 text-slate-950 font-bold shadow-lg shadow-amber-500/25', hover: 'hover:text-amber-300' };
      case 'class_10_english':
        return { activeBg: 'bg-indigo-500 text-white font-bold shadow-lg shadow-indigo-500/25', hover: 'hover:text-indigo-300' };
      case 'class_10_math':
        return { activeBg: 'bg-cyan-500 text-slate-950 font-bold shadow-lg shadow-cyan-500/25', hover: 'hover:text-cyan-300' };
      case 'class_10_science':
        return { activeBg: 'bg-purple-500 text-white font-bold shadow-lg shadow-purple-500/25', hover: 'hover:text-purple-300' };
      case 'class_10_social_science':
        return { activeBg: 'bg-emerald-500 text-slate-950 font-bold shadow-lg shadow-emerald-500/25', hover: 'hover:text-emerald-300' };
      default:
        return { activeBg: 'bg-blue-600 text-white shadow-md', hover: 'hover:text-white' };
    }
  };

  const getEditionBadge = () => {
    if (activeSubject === 'class_10_tamil' || activeSubject === 'class_10_math' || activeSubject === 'class_10_social_science') {
      return '2025';
    }
    return '2024';
  };

  const handleOpenInstall = () => {
    triggerHaptic('selection');
    if (typeof window !== 'undefined') {
      window.dispatchEvent(new CustomEvent('open-pwa-install'));
    }
  };

  return (
    <header className="sticky top-0 z-40 bg-slate-950/80 backdrop-blur-2xl border-b border-white/[0.08] text-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between gap-2">
        {/* Brand Logo & Board Tag */}
        <Link href="/dashboard" className="flex items-center gap-3 group flex-shrink-0">
          <div className="w-10 h-10 rounded-2xl bg-gradient-to-tr from-blue-600 via-indigo-500 to-cyan-400 p-[1px] shadow-lg shadow-blue-500/20 group-hover:scale-105 transition-transform duration-300">
            <div className="w-full h-full bg-slate-950/90 rounded-2xl flex items-center justify-center">
              <BookOpen className="w-5 h-5 text-blue-400 group-hover:text-blue-300 transition-colors" />
            </div>
          </div>
          <div>
            <div className="flex items-center gap-2">
              <span className="font-extrabold text-base tracking-tight text-white group-hover:text-blue-300 transition">
                {lang === 'ta' ? 'TN 10 படிப்பு' : 'TN Class 10'}
              </span>
              <span className="bg-blue-500/15 text-blue-300 border border-blue-500/30 text-[10px] font-bold px-2 py-0.5 rounded-full">
                {getEditionBadge()}
              </span>
            </div>
            <p className="text-[11px] text-slate-400 font-medium hidden md:block tracking-wide">
              {lang === 'ta' ? 'தமிழ்நாடு அரசுப் பாடத்திட்டம்' : 'Tamil Nadu State Board'}
            </p>
          </div>
        </Link>

        {/* Center: Subject Switcher in Canonical Order: Tamil, English, Math, Science, Social */}
        <div className="flex items-center bg-slate-900/90 p-1 rounded-2xl border border-white/[0.08] shadow-inner overflow-x-auto max-w-[50vw] sm:max-w-none">
          {availableSubjects.map((sub) => {
            const isSelected = activeSubject === sub.code;
            const theme = getSubjectTheme(sub.code);

            return (
              <button
                key={sub.code}
                onClick={() => setActiveSubject(sub.code)}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs transition-all duration-200 cursor-pointer whitespace-nowrap ${
                  isSelected
                    ? theme.activeBg
                    : `text-slate-400 hover:text-slate-200 ${theme.hover} hover:bg-slate-800/50 font-medium`
                }`}
                title={`${sub.title} (${sub.edition})`}
              >
                <span className="text-sm">{sub.icon}</span>
                <span className="hidden lg:inline">{sub.title}</span>
                <span className="lg:hidden">{sub.shortTitle}</span>
              </button>
            );
          })}
        </div>

        {/* Right: Telemetry, Sync & Controls */}
        <div className="flex items-center gap-2 sm:gap-3 flex-shrink-0">
          {/* Docker PostgreSQL Telemetry Badge */}
          {isDemoMode && (
            <span 
              title="PostgreSQL 16 container running at localhost:5432 (tn10_postgres)"
              className="hidden xl:inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[11px] font-medium bg-emerald-500/10 text-emerald-300 border border-emerald-500/25"
            >
              <Database className="w-3 h-3 text-emerald-400" />
              <span>PostgreSQL (5432)</span>
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse" />
            </span>
          )}

          {/* Sync Status Badge */}
          <div className="flex items-center">
            {syncStatus === 'syncing' && (
              <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl text-xs font-medium bg-blue-500/10 text-blue-400 border border-blue-500/20">
                <RefreshCw className="w-3.5 h-3.5 animate-spin" />
                <span className="hidden lg:inline">{t.sync.syncing}</span>
              </span>
            )}

            {syncStatus === 'synced' && (
              <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-xl text-xs font-medium text-emerald-400 bg-emerald-500/10 border border-emerald-500/20">
                <CheckCircle2 className="w-3.5 h-3.5" />
                <span className="hidden lg:inline">{t.sync.synced}</span>
              </span>
            )}

            {syncStatus === 'unsynced' && (
              <button
                onClick={triggerSync}
                title="Tap to synchronize offline changes"
                className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl text-xs font-semibold bg-amber-500/15 text-amber-300 border border-amber-500/30 hover:bg-amber-500/25 transition cursor-pointer"
              >
                <RefreshCw className="w-3.5 h-3.5" />
                <span>{unsyncedCount} {lang === 'ta' ? 'சேமிக்கப்பட்டது' : 'saved'}</span>
              </button>
            )}

            {syncStatus === 'offline' && (
              <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl text-xs font-medium bg-slate-900 text-slate-400 border border-slate-800">
                <WifiOff className="w-3.5 h-3.5 text-amber-400" />
                <span className="hidden lg:inline">{t.sync.offline}</span>
              </span>
            )}

            {syncStatus === 'error' && (
              <button
                onClick={triggerSync}
                className="inline-flex items-center gap-1 px-2.5 py-1 rounded-xl text-xs font-semibold bg-rose-500/15 text-rose-300 border border-rose-500/30 hover:bg-rose-500/25 transition cursor-pointer"
              >
                <AlertCircle className="w-3.5 h-3.5" />
                <span>{t.sync.retryBtn}</span>
              </button>
            )}
          </div>

          {/* Install PWA Quick Action Button */}
          <button
            onClick={handleOpenInstall}
            className="hidden sm:inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold bg-gradient-to-r from-blue-600/20 via-indigo-600/20 to-cyan-500/20 hover:from-blue-600/30 hover:to-indigo-600/30 text-blue-300 border border-blue-500/30 transition active:scale-95 cursor-pointer shadow-sm"
            title="Install Progressive Web App on your device / செயலியை நிறுவுங்கள்"
            aria-label="Install App"
          >
            <Download className="w-3.5 h-3.5 text-blue-400" />
            <span>{lang === 'ta' ? 'நிறுவு' : 'Install App'}</span>
          </button>

          {/* Bilingual Language Switcher */}
          <button
            onClick={toggleLang}
            className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold bg-slate-900/90 hover:bg-slate-800 border border-white/[0.08] text-slate-200 hover:text-white transition active:scale-95 cursor-pointer shadow-sm"
            title="Switch Language / மொழியை மாற்றவும்"
            aria-label="Toggle language"
          >
            <Languages className="w-3.5 h-3.5 text-blue-400" />
            <span>{lang === 'en' ? 'தமிழ்' : 'English'}</span>
          </button>

          {/* Auth/Profile Icon */}
          <Link
            href="/settings"
            className="p-2 rounded-xl bg-slate-900/90 hover:bg-slate-800 border border-white/[0.08] text-slate-300 hover:text-white transition flex items-center justify-center shadow-sm"
            title={user ? user.display_name : 'Settings / Sign In'}
          >
            {isAdmin ? (
              <ShieldCheck className="w-4 h-4 text-amber-400" />
            ) : (
              <UserCircle className="w-4 h-4 text-slate-300" />
            )}
          </Link>
        </div>
      </div>
    </header>
  );
}
