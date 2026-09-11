'use client';

// ============================================================================
// Affan Offcanvas Sidenav Drawer
// Mobile slide-over navigation with user profile hero, quick links, and settings
// Inspired by Affan PWA HTML5 Template (v2.0.0)
// ============================================================================

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { 
  X, 
  Home, 
  BookOpenCheck, 
  BookmarkCheck, 
  Settings, 
  ShieldAlert, 
  Download, 
  LogOut, 
  UserCircle, 
  Layers, 
  Sparkles,
  ChevronRight,
  Database,
  GraduationCap
} from 'lucide-react';
import { useAuth } from '@/lib/auth/auth-context';
import { useStudy } from '@/lib/store/study-context';
import { useI18n } from '@/lib/i18n/i18n-context';
import { triggerHaptic } from '@/lib/utils/haptics';

export function SidenavDrawer() {
  const [isOpen, setIsOpen] = useState(false);
  const pathname = usePathname();
  const router = useRouter();
  const { user, isAdmin, signOut } = useAuth();
  const { overallStats, activeSubject, availableSubjects } = useStudy();
  const { t } = useI18n();

  // Listen for global open/close/toggle events from Header or buttons
  useEffect(() => {
    if (typeof window === 'undefined') return;

    const handleOpen = () => setIsOpen(true);
    const handleClose = () => setIsOpen(false);
    const handleToggle = () => setIsOpen((prev) => !prev);

    window.addEventListener('open-sidenav', handleOpen);
    window.addEventListener('close-sidenav', handleClose);
    window.addEventListener('toggle-sidenav', handleToggle);

    return () => {
      window.removeEventListener('open-sidenav', handleOpen);
      window.removeEventListener('close-sidenav', handleClose);
      window.removeEventListener('toggle-sidenav', handleToggle);
    };
  }, []);

  // Close drawer on path navigation
  useEffect(() => {
    setIsOpen(false);
  }, [pathname]);

  // Handle escape key
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape' && isOpen) {
        setIsOpen(false);
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [isOpen]);

  const handleClose = () => {
    triggerHaptic('light');
    setIsOpen(false);
  };

  const handleOpenInstall = () => {
    handleClose();
    if (typeof window !== 'undefined') {
      window.dispatchEvent(new CustomEvent('open-pwa-install'));
    }
  };

  const handleLogout = async () => {
    handleClose();
    await signOut();
    router.push('/auth');
  };

  const initials = user?.display_name
    ? user.display_name.slice(0, 2).toUpperCase()
    : 'TN';

  return (
    <>
      {/* Backdrop */}
      {isOpen && (
        <div 
          onClick={handleClose}
          className="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 transition-opacity animate-in fade-in duration-200"
          aria-hidden="true"
        />
      )}

      {/* Drawer Container */}
      <aside
        aria-label="Side Navigation"
        className={`fixed top-0 bottom-0 left-0 w-[300px] sm:w-[320px] max-w-[85vw] bg-slate-950/98 backdrop-blur-2xl border-r border-white/[0.1] z-50 flex flex-col shadow-2xl transition-transform duration-300 ease-out ${
          isOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        {/* Affan Sidenav Profile Hero (Gradient Card) */}
        <div className="relative bg-gradient-to-br from-blue-600 via-indigo-600 to-cyan-600 p-5 text-white overflow-hidden shrink-0">
          {/* Decorative ambient rings */}
          <div className="absolute top-0 right-0 -mr-8 -mt-8 w-32 h-32 bg-white/10 rounded-full blur-xl pointer-events-none" />
          <div className="absolute bottom-0 right-10 -mb-8 w-24 h-24 bg-cyan-400/20 rounded-full blur-xl pointer-events-none" />

          {/* Close Button */}
          <button
            onClick={handleClose}
            className="absolute top-4 right-4 p-1.5 rounded-xl bg-black/20 hover:bg-black/40 text-white/80 hover:text-white transition cursor-pointer"
            aria-label="Close navigation drawer"
          >
            <X className="w-4 h-4" />
          </button>

          {/* User Info Section */}
          <div className="flex items-center gap-3.5 pt-1">
            <div className="relative">
              <div className="w-13 h-13 rounded-2xl bg-white/20 p-0.5 shadow-lg shadow-black/20 backdrop-blur-md">
                <div className="w-full h-full bg-slate-950 rounded-2xl flex items-center justify-center font-black text-blue-400 text-base">
                  {initials}
                </div>
              </div>
              <span className="w-3 h-3 rounded-full bg-emerald-400 border-2 border-slate-950 absolute -bottom-0.5 -right-0.5" />
            </div>

            <div className="min-w-0 flex-1">
              <h3 className="font-bold text-sm text-white truncate leading-tight">
                {user?.display_name || 'Guest Learner'}
              </h3>
              <p className="text-[11px] text-blue-100 font-mono truncate mt-0.5">
                {user?.email || 'admin@tn10.udhees.com'}
              </p>
              <div className="flex items-center gap-1.5 mt-1.5">
                {isAdmin ? (
                  <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-amber-400 text-slate-950 text-[10px] font-black shadow-sm">
                    <ShieldAlert className="w-2.5 h-2.5" />
                    <span>Admin</span>
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-white/20 text-white text-[10px] font-bold">
                    <GraduationCap className="w-2.5 h-2.5" />
                    <span>Class 10</span>
                  </span>
                )}
                <span className="px-2 py-0.5 rounded-full bg-black/20 text-blue-100 text-[10px] font-medium capitalize">
                  {user?.medium_code || 'English'} Medium
                </span>
              </div>
            </div>
          </div>
        </div>

        {/* Drawer Scrollable Navigation Links */}
        <div className="flex-1 overflow-y-auto px-3 py-4 space-y-1 text-xs">
          <div className="px-3 py-1.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
            Menu Navigation
          </div>

          <Link
            href="/dashboard"
            onClick={handleClose}
            className={`flex items-center justify-between px-3.5 py-2.5 rounded-2xl transition font-semibold ${
              pathname === '/dashboard' || pathname === '/'
                ? 'bg-blue-600 text-white shadow-md shadow-blue-600/25 font-bold'
                : 'text-slate-300 hover:text-white hover:bg-slate-900/80'
            }`}
          >
            <div className="flex items-center gap-3">
              <Home className="w-4 h-4" />
              <span>{t.nav.dashboard}</span>
            </div>
            <ChevronRight className="w-3.5 h-3.5 opacity-60" />
          </Link>

          <Link
            href="/curriculum"
            onClick={handleClose}
            className={`flex items-center justify-between px-3.5 py-2.5 rounded-2xl transition font-semibold ${
              pathname.startsWith('/curriculum') || pathname.startsWith('/lesson')
                ? 'bg-blue-600 text-white shadow-md shadow-blue-600/25 font-bold'
                : 'text-slate-300 hover:text-white hover:bg-slate-900/80'
            }`}
          >
            <div className="flex items-center gap-3">
              <BookOpenCheck className="w-4 h-4" />
              <span>{t.nav.curriculum}</span>
            </div>
            <ChevronRight className="w-3.5 h-3.5 opacity-60" />
          </Link>

          <Link
            href="/revision"
            onClick={handleClose}
            className={`flex items-center justify-between px-3.5 py-2.5 rounded-2xl transition font-semibold ${
              pathname === '/revision'
                ? 'bg-blue-600 text-white shadow-md shadow-blue-600/25 font-bold'
                : 'text-slate-300 hover:text-white hover:bg-slate-900/80'
            }`}
          >
            <div className="flex items-center gap-3">
              <BookmarkCheck className="w-4 h-4" />
              <span>{t.nav.revision}</span>
            </div>
            <div className="flex items-center gap-1.5">
              {overallStats.studyAgainCount > 0 && (
                <span className="px-2 py-0.5 rounded-full bg-amber-500 text-slate-950 font-black text-[10px]">
                  {overallStats.studyAgainCount} Due
                </span>
              )}
              <ChevronRight className="w-3.5 h-3.5 opacity-60" />
            </div>
          </Link>

          <Link
            href="/settings"
            onClick={handleClose}
            className={`flex items-center justify-between px-3.5 py-2.5 rounded-2xl transition font-semibold ${
              pathname === '/settings'
                ? 'bg-blue-600 text-white shadow-md shadow-blue-600/25 font-bold'
                : 'text-slate-300 hover:text-white hover:bg-slate-900/80'
            }`}
          >
            <div className="flex items-center gap-3">
              <Settings className="w-4 h-4" />
              <span>{t.nav.settings}</span>
            </div>
            <ChevronRight className="w-3.5 h-3.5 opacity-60" />
          </Link>

          {isAdmin && (
            <Link
              href="/admin"
              onClick={handleClose}
              className={`flex items-center justify-between px-3.5 py-2.5 rounded-2xl transition font-semibold ${
                pathname === '/admin'
                  ? 'bg-purple-600 text-white shadow-md shadow-purple-600/25 font-bold'
                  : 'text-purple-300 hover:text-white hover:bg-purple-950/40 border border-purple-500/20'
              }`}
            >
              <div className="flex items-center gap-3">
                <ShieldAlert className="w-4 h-4 text-purple-400" />
                <span>{t.nav.admin}</span>
              </div>
              <span className="text-[10px] font-bold px-1.5 py-0.2 bg-purple-500/20 rounded">
                Admin
              </span>
            </Link>
          )}

          <div className="pt-3 pb-1">
            <div className="px-3 py-1.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
              Quick Actions
            </div>
          </div>

          {/* Install PWA Button */}
          <button
            onClick={handleOpenInstall}
            className="w-full flex items-center justify-between px-3.5 py-2.5 rounded-2xl text-amber-300 hover:bg-amber-500/10 border border-amber-500/30 transition cursor-pointer font-semibold"
          >
            <div className="flex items-center gap-3">
              <Download className="w-4 h-4 text-amber-400" />
              <span>Install PWA App</span>
            </div>
            <span className="px-2 py-0.5 rounded-full bg-amber-400 text-slate-950 text-[10px] font-black">
              Offline
            </span>
          </button>

          {/* Sign Out / Switch Account */}
          {user ? (
            <button
              onClick={handleLogout}
              className="w-full flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-rose-400 hover:bg-rose-500/10 transition cursor-pointer font-semibold"
            >
              <LogOut className="w-4 h-4 text-rose-400" />
              <span>Sign Out</span>
            </button>
          ) : (
            <Link
              href="/auth"
              onClick={handleClose}
              className="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-blue-400 hover:bg-blue-500/10 transition font-semibold"
            >
              <UserCircle className="w-4 h-4 text-blue-400" />
              <span>Sign In / Register</span>
            </Link>
          )}
        </div>

        {/* Sidenav Footer */}
        <div className="p-4 border-t border-white/[0.08] bg-slate-950/80 text-[11px] text-slate-400 space-y-1 shrink-0">
          <div className="flex items-center justify-between text-slate-300 font-bold">
            <span>TN10 Study PWA</span>
            <span className="px-1.5 py-0.5 bg-blue-500/20 text-blue-300 rounded text-[9px]">
              Affan v2.0
            </span>
          </div>
          <p className="text-[10px] text-slate-500 leading-normal">
            Tamil Nadu State Board Samacheer Kalvi Class 10 (2025/2024 Editions)
          </p>
        </div>
      </aside>
    </>
  );
}
