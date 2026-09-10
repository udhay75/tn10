'use client';

// ============================================================================
// Modern Settings Page: Profile, Telemetry, 5-Subject Info, Language & PWA
// Design: 2025/2026 Bento Grid Glassmorphism with PostgreSQL & IndexedDB Telemetry
// ============================================================================

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { 
  User, 
  Languages, 
  RefreshCw, 
  LogOut, 
  ShieldCheck, 
  Smartphone, 
  CheckCircle2, 
  AlertTriangle,
  Database,
  Server,
  Sparkles,
  Layers,
  ArrowRight,
  ExternalLink,
  Laptop
} from 'lucide-react';
import { useAuth } from '@/lib/auth/auth-context';
import { useI18n } from '@/lib/i18n/i18n-context';
import { useStudy } from '@/lib/store/study-context';

export default function SettingsPage() {
  const router = useRouter();
  const { user, isDemoMode, isAdmin, signInDemo, signOut } = useAuth();
  const { lang, setLang, t } = useI18n();
  const { syncStatus, unsyncedCount, triggerSync, availableSubjects, activeSubject, setActiveSubject } = useStudy();

  const [showLogoutModal, setShowLogoutModal] = useState(false);
  const [syncingNow, setSyncingNow] = useState(false);

  const handleManualSync = async () => {
    setSyncingNow(true);
    await triggerSync();
    setSyncingNow(false);
  };

  const handleLogoutConfirm = async (discard: boolean) => {
    if (!discard && unsyncedCount > 0) {
      await triggerSync();
    }
    await signOut({ discardUnsynced: discard });
    setShowLogoutModal(false);
    router.push('/auth');
  };

  return (
    <div className="space-y-8 animate-in fade-in duration-300 max-w-4xl mx-auto pb-12">
      {/* Page Header Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-slate-900 via-slate-900/90 to-blue-950/40 p-6 sm:p-8 border border-white/[0.08] shadow-2xl">
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-64 h-64 bg-blue-500/10 rounded-full blur-3xl pointer-events-none" />
        <div className="absolute bottom-0 left-1/3 -mb-16 w-56 h-56 bg-indigo-500/10 rounded-full blur-3xl pointer-events-none" />
        
        <div className="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div>
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 text-xs font-semibold mb-3">
              <Sparkles className="w-3.5 h-3.5" />
              <span>SaaS Student System • 2025/2026 Edition</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              {t.settings.title}
            </h1>
            <p className="text-sm text-slate-400 mt-1.5 max-w-xl">
              Configure your student profile, database telemetry, language preferences, and offline PWA storage.
            </p>
          </div>

          <div className="flex items-center gap-3">
            <span className="flex h-3 w-3 relative">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
              <span className="relative inline-flex rounded-full h-3 w-3 bg-emerald-500"></span>
            </span>
            <span className="text-xs font-semibold text-emerald-300 bg-emerald-950/40 border border-emerald-500/30 px-3 py-1.5 rounded-full">
              Cloud Database Connected
            </span>
          </div>
        </div>
      </div>

      {/* Bento Grid: User Profile & Database Telemetry */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* Bento Cell 1: Student Profile (2 cols) */}
        <div className="md:col-span-2 glass-panel p-6 rounded-3xl space-y-5 border border-white/[0.08] bg-slate-900/60 backdrop-blur-xl">
          <div className="flex items-start justify-between">
            <div className="flex items-center gap-4">
              <div className="relative">
                <div className="w-14 h-14 rounded-2xl bg-gradient-to-tr from-blue-600 to-indigo-500 p-[2px] shadow-lg shadow-blue-500/20">
                  <div className="w-full h-full bg-slate-950 rounded-2xl flex items-center justify-center text-blue-400 text-xl font-bold">
                    {user?.display_name ? user.display_name.charAt(0) : <User className="w-7 h-7" />}
                  </div>
                </div>
                <div className="absolute -bottom-1 -right-1 w-5 h-5 bg-emerald-500 rounded-full border-2 border-slate-900 flex items-center justify-center" title="Active">
                  <CheckCircle2 className="w-3.5 h-3.5 text-slate-950" />
                </div>
              </div>
              <div>
                <div className="flex items-center gap-2">
                  <h2 className="text-base sm:text-lg font-bold text-white">
                    {user?.display_name || 'Guest Student'}
                  </h2>
                  {isAdmin ? (
                    <span className="text-[10px] bg-purple-500/20 text-purple-300 border border-purple-500/30 px-2.5 py-0.5 rounded-full font-bold">
                      Admin
                    </span>
                  ) : (
                    <span className="text-[10px] bg-blue-500/20 text-blue-300 border border-blue-500/30 px-2.5 py-0.5 rounded-full font-bold">
                      Student
                    </span>
                  )}
                </div>
                <p className="text-xs text-slate-400 font-mono mt-0.5">{user?.email || 'student@school.tn.gov.in'}</p>
                
                <div className="pt-2">
                  <Link
                    href="/auth"
                    className="inline-flex items-center gap-1.5 px-3 py-1 rounded-xl bg-blue-600/20 hover:bg-blue-600/30 text-blue-300 border border-blue-500/30 text-xs font-semibold transition"
                  >
                    <User className="w-3 h-3" />
                    <span>{user ? 'Switch Account / Sign In' : 'Sign In to Account'}</span>
                    <ArrowRight className="w-3 h-3" />
                  </Link>
                </div>
              </div>
            </div>

            {/* Quick Demo Switcher */}
            {isDemoMode && (
              <div className="hidden sm:flex flex-col items-end gap-1.5">
                <span className="text-[10px] text-slate-400 uppercase tracking-wider font-semibold">Switch Role:</span>
                <div className="inline-flex rounded-xl bg-slate-950/80 p-1 border border-white/[0.08]">
                  <button
                    onClick={() => signInDemo('student')}
                    className={`px-3 py-1 rounded-lg text-xs font-bold transition cursor-pointer ${
                      !isAdmin ? 'bg-blue-600 text-white shadow-md' : 'text-slate-400 hover:text-white'
                    }`}
                  >
                    Student
                  </button>
                  <button
                    onClick={() => signInDemo('admin')}
                    className={`px-3 py-1 rounded-lg text-xs font-bold transition cursor-pointer ${
                      isAdmin ? 'bg-purple-600 text-white shadow-md' : 'text-slate-400 hover:text-white'
                    }`}
                  >
                    Admin
                  </button>
                </div>
              </div>
            )}
          </div>

          {/* Curriculum Authority & Standards */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-2 text-xs">
            <div className="bg-slate-950/60 p-4 rounded-2xl border border-white/[0.06]">
              <span className="text-slate-400 block text-[11px] font-medium">Class & Curriculum Medium</span>
              <span className="font-bold text-white mt-1 block text-sm">Class 10 (SSLC) • English / Tamil Medium</span>
              <span className="text-[10px] text-blue-400 mt-1 block">TN State Board Samacheer Kalvi</span>
            </div>
            <div className="bg-slate-950/60 p-4 rounded-2xl border border-white/[0.06]">
              <span className="text-slate-400 block text-[11px] font-medium">Textbook Edition Standard</span>
              <span className="font-bold text-white mt-1 block text-sm">2025 / 2024 Revised Editions</span>
              <span className="text-[10px] text-emerald-400 mt-1 block">5 Canonical Subjects Synchronized</span>
            </div>
          </div>
        </div>

        {/* Bento Cell 2: Live Database & Engine Telemetry */}
        <div className="glass-panel p-6 rounded-3xl space-y-4 border border-white/[0.08] bg-slate-900/60 backdrop-blur-xl flex flex-col justify-between">
          <div className="space-y-3">
            <div className="flex items-center gap-2">
              <Server className="w-5 h-5 text-emerald-400" />
              <h2 className="text-sm font-bold text-white uppercase tracking-wider">Engine Telemetry</h2>
            </div>

            <div className="space-y-2.5 text-xs">
              <div className="bg-slate-950/70 p-3 rounded-xl border border-white/[0.06] flex items-center justify-between">
                <div>
                  <span className="text-slate-400 text-[11px] block">Database Server</span>
                  <span className="text-slate-200 font-mono font-bold">MongoDB / PostgreSQL</span>
                </div>
                <span className="text-[10px] bg-emerald-500/10 text-emerald-400 border border-emerald-500/30 px-2 py-0.5 rounded-full font-bold">
                  Live
                </span>
              </div>

              <div className="bg-slate-950/70 p-3 rounded-xl border border-white/[0.06] flex items-center justify-between">
                <div>
                  <span className="text-slate-400 text-[11px] block">Local Storage</span>
                  <span className="text-slate-200 font-mono font-bold">IndexedDB Client</span>
                </div>
                <span className="text-[10px] bg-blue-500/10 text-blue-400 border border-blue-500/30 px-2 py-0.5 rounded-full font-bold">
                  Offline Ready
                </span>
              </div>

              <div className="bg-slate-950/70 p-3 rounded-xl border border-white/[0.06] flex items-center justify-between">
                <div>
                  <span className="text-slate-400 text-[11px] block">Sync Status</span>
                  <span className="text-slate-200 font-medium">
                    {unsyncedCount > 0 ? `${unsyncedCount} pending mutations` : '100% synchronized'}
                  </span>
                </div>
                <span className={`text-[10px] px-2 py-0.5 rounded-full font-bold ${
                  unsyncedCount > 0 
                    ? 'bg-amber-500/15 text-amber-300 border border-amber-500/30' 
                    : 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30'
                }`}>
                  {t.sync[syncStatus] || syncStatus}
                </span>
              </div>
            </div>
          </div>

          <button
            onClick={handleManualSync}
            disabled={syncingNow}
            className="w-full py-2.5 px-4 bg-blue-600 hover:bg-blue-500 disabled:opacity-50 text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-2 cursor-pointer shadow-md shadow-blue-600/20"
          >
            <RefreshCw className={`w-3.5 h-3.5 ${syncingNow ? 'animate-spin' : ''}`} />
            <span>{syncingNow ? 'Synchronizing...' : t.sync.retryBtn}</span>
          </button>
        </div>
      </div>

      {/* Canonical 5-Subject Ordering Overview Bento */}
      <div className="glass-panel p-6 rounded-3xl space-y-4 border border-white/[0.08] bg-slate-900/60 backdrop-blur-xl">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Layers className="w-5 h-5 text-indigo-400" />
            <h2 className="text-base font-bold text-white">Canonical 5-Subject Hierarchy</h2>
          </div>
          <span className="text-[11px] font-semibold text-slate-400 bg-slate-950/60 px-3 py-1 rounded-full border border-white/[0.06]">
            Strict Board Order Enforced
          </span>
        </div>
        <p className="text-xs text-slate-400 leading-relaxed">
          The curriculum and progress metrics follow the mandatory Tamil Nadu State Board sequence:
        </p>

        <div className="grid grid-cols-1 sm:grid-cols-5 gap-3 pt-1">
          {availableSubjects.map((sub, idx) => {
            const isSelected = activeSubject === sub.code;
            return (
              <button
                key={sub.code}
                onClick={() => setActiveSubject(sub.code)}
                className={`p-3.5 rounded-2xl border text-left transition-all duration-200 cursor-pointer flex flex-col justify-between ${
                  isSelected 
                    ? 'bg-slate-800/90 border-blue-500 ring-2 ring-blue-500/30 shadow-lg' 
                    : 'bg-slate-950/60 border-white/[0.06] hover:bg-slate-800/40 hover:border-slate-700'
                }`}
              >
                <div>
                  <div className="flex items-center justify-between text-slate-400 mb-2">
                    <span className="text-xs font-mono font-bold text-slate-500">0{idx + 1}</span>
                    <span className="text-lg">{sub.icon}</span>
                  </div>
                  <h3 className="font-bold text-white text-xs leading-tight mb-1">{sub.title}</h3>
                  <p className="text-[10px] text-slate-400">{sub.edition} Edition</p>
                </div>
                <div className="mt-3 pt-2 border-t border-white/[0.06] flex items-center justify-between">
                  <span className="text-[10px] text-blue-400 font-semibold">{sub.unitsCount} Units</span>
                  {isSelected && <span className="text-[9px] bg-blue-500/20 text-blue-300 px-1.5 py-0.5 rounded font-bold">Active</span>}
                </div>
              </button>
            );
          })}
        </div>
      </div>

      {/* Language Preferences Card */}
      <div className="glass-panel p-6 rounded-3xl space-y-4 border border-white/[0.08] bg-slate-900/60 backdrop-blur-xl">
        <div className="flex items-center gap-2">
          <Languages className="w-5 h-5 text-blue-400" />
          <h2 className="text-base font-bold text-white">{t.settings.interfaceLang}</h2>
        </div>
        <p className="text-xs text-slate-400">
          Choose between English and தமிழ் (Tamil) for navigation, directions, and metrics.
        </p>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-1">
          <button
            onClick={() => setLang('en')}
            className={`p-4 rounded-2xl border text-left transition-all duration-200 cursor-pointer ${
              lang === 'en'
                ? 'bg-blue-600/15 border-blue-500 text-white ring-1 ring-blue-500/40 shadow-lg shadow-blue-500/10'
                : 'bg-slate-950/60 border-white/[0.06] text-slate-400 hover:text-white hover:bg-slate-800/30'
            }`}
          >
            <div className="flex items-center justify-between">
              <span className="text-sm font-bold text-white">English</span>
              {lang === 'en' && <CheckCircle2 className="w-4 h-4 text-blue-400" />}
            </div>
            <span className="block text-[11px] text-slate-400 mt-1">Default textbook and examination language</span>
          </button>
          <button
            onClick={() => setLang('ta')}
            className={`p-4 rounded-2xl border text-left transition-all duration-200 cursor-pointer ${
              lang === 'ta'
                ? 'bg-blue-600/15 border-blue-500 text-white ring-1 ring-blue-500/40 shadow-lg shadow-blue-500/10'
                : 'bg-slate-950/60 border-white/[0.06] text-slate-400 hover:text-white hover:bg-slate-800/30'
            }`}
          >
            <div className="flex items-center justify-between">
              <span className="text-sm font-bold text-white">தமிழ் (Tamil)</span>
              {lang === 'ta' && <CheckCircle2 className="w-4 h-4 text-blue-400" />}
            </div>
            <span className="block text-[11px] text-slate-400 mt-1">தமிழ் இடைமுகம் மற்றும் மனப்பாடப் பாடல்கள்</span>
          </button>
        </div>
      </div>

      {/* PWA Installation & Mobile Help */}
      <div className="glass-panel p-6 rounded-3xl space-y-4 border border-white/[0.08] bg-slate-900/60 backdrop-blur-xl">
        <div className="flex items-center gap-2">
          <Smartphone className="w-5 h-5 text-indigo-400" />
          <h2 className="text-base font-bold text-white">{t.settings.pwaTitle}</h2>
        </div>
        <p className="text-xs text-slate-400 leading-relaxed">
          {t.settings.pwaDesc}
        </p>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 pt-1">
          <div className="bg-slate-950/60 p-4 rounded-2xl border border-white/[0.06] space-y-2 text-xs">
            <div className="flex items-center gap-2">
              <div className="w-7 h-7 rounded-lg bg-indigo-500/10 text-indigo-400 flex items-center justify-center font-bold">
                iOS
              </div>
              <strong className="text-indigo-300 font-semibold">Safari on iPhone / iPad</strong>
            </div>
            <p className="text-[11px] leading-relaxed text-slate-400">
              {t.settings.iosInstructions}
            </p>
          </div>

          <div className="bg-slate-950/60 p-4 rounded-2xl border border-white/[0.06] space-y-2 text-xs">
            <div className="flex items-center gap-2">
              <div className="w-7 h-7 rounded-lg bg-blue-500/10 text-blue-400 flex items-center justify-center font-bold">
                And
              </div>
              <strong className="text-blue-300 font-semibold">Chrome on Android / PC</strong>
            </div>
            <p className="text-[11px] leading-relaxed text-slate-400">
              Tap browser menu (⋮) and select <strong>&quot;Install app&quot;</strong> or <strong>&quot;Add to Home Screen&quot;</strong> for instant standalone launch.
            </p>
          </div>
        </div>
      </div>

      {/* Logout Action */}
      <div className="pt-2">
        <button
          onClick={() => setShowLogoutModal(true)}
          className="w-full py-4 bg-rose-600/10 hover:bg-rose-600/20 text-rose-400 border border-rose-500/30 rounded-2xl text-xs font-bold transition flex items-center justify-center gap-2 cursor-pointer shadow-lg shadow-rose-900/10"
        >
          <LogOut className="w-4 h-4" />
          <span>{t.nav.logout}</span>
        </button>
      </div>

      {/* Safe Logout Confirmation Modal */}
      {showLogoutModal && (
        <div className="fixed inset-0 bg-black/80 backdrop-blur-md z-50 flex items-center justify-center p-4 animate-in fade-in">
          <div className="bg-slate-900 border border-slate-700 text-white rounded-3xl p-6 sm:p-8 max-w-md w-full shadow-2xl animate-in zoom-in-95">
            <div className="w-12 h-12 rounded-2xl bg-rose-500/15 text-rose-400 flex items-center justify-center mb-4 border border-rose-500/30">
              <AlertTriangle className="w-6 h-6" />
            </div>

            <h3 className="text-lg font-bold text-white mb-2">
              {t.settings.confirmLogout}
            </h3>

            {unsyncedCount > 0 ? (
              <p className="text-xs text-amber-300 bg-amber-950/40 p-3 rounded-xl border border-amber-500/30 mb-6 leading-relaxed">
                {t.settings.unsyncedWarning} ({unsyncedCount} unsynced items)
              </p>
            ) : (
              <p className="text-xs text-slate-400 mb-6 leading-relaxed">
                Signing out clears your private progress records from this device so the next student cannot access them.
              </p>
            )}

            <div className="space-y-2.5">
              {unsyncedCount > 0 && (
                <button
                  onClick={() => handleLogoutConfirm(false)}
                  className="w-full py-3 px-4 bg-blue-600 hover:bg-blue-500 text-white font-bold text-xs rounded-xl transition cursor-pointer"
                >
                  {t.settings.syncAndLogout}
                </button>
              )}

              <button
                onClick={() => handleLogoutConfirm(true)}
                className="w-full py-3 px-4 bg-rose-600 hover:bg-rose-500 text-white font-bold text-xs rounded-xl transition cursor-pointer"
              >
                {t.settings.discardAndLogout}
              </button>

              <button
                onClick={() => setShowLogoutModal(false)}
                className="w-full py-2.5 px-4 bg-slate-800 hover:bg-slate-700 text-slate-300 font-semibold text-xs rounded-xl transition cursor-pointer"
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
