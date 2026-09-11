'use client';

// ============================================================================
// Modern Application Header (Clean Mobile-First 2025/2026 SaaS Design)
// Streamlined for zero mobile clutter: Subjects live on Dashboard/Curriculum
// ============================================================================

import React from 'react';
import Link from 'next/link';
import { 
  WifiOff, 
  RefreshCw, 
  CheckCircle2, 
  AlertCircle, 
  BookOpen, 
  ShieldCheck, 
  UserCircle,
  Database,
  Download,
  Menu
} from 'lucide-react';
import { useAuth } from '@/lib/auth/auth-context';
import { useStudy } from '@/lib/store/study-context';
import { triggerHaptic } from '@/lib/utils/haptics';

export function Header() {
  const { user, isAdmin } = useAuth();
  const { syncStatus, unsyncedCount, triggerSync, activeSubject } = useStudy();

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

  const handleToggleSidenav = () => {
    triggerHaptic('medium');
    if (typeof window !== 'undefined') {
      window.dispatchEvent(new CustomEvent('toggle-sidenav'));
    }
  };

  return (
    <header className="sticky top-0 z-40 bg-slate-950/85 backdrop-blur-2xl border-b border-white/[0.08] text-white transition-all">
      <div className="max-w-7xl mx-auto px-3 sm:px-6 lg:px-8 h-14 sm:h-16 flex items-center justify-between gap-3">
        {/* Left: Brand Logo & App Identity */}
        <Link href="/dashboard" className="flex items-center gap-2.5 sm:gap-3 group flex-shrink-0">
          <div className="w-9 h-9 sm:w-10 sm:h-10 rounded-2xl bg-gradient-to-tr from-blue-600 via-indigo-500 to-cyan-400 p-[1px] shadow-md shadow-blue-500/20 group-hover:scale-105 transition-transform duration-300">
            <div className="w-full h-full bg-slate-950/95 rounded-2xl flex items-center justify-center">
              <BookOpen className="w-4 h-4 sm:w-5 sm:h-5 text-blue-400 group-hover:text-blue-300 transition-colors" />
            </div>
          </div>
          <div>
            <div className="flex items-center gap-1.5 sm:gap-2">
              <span className="font-black text-sm sm:text-base tracking-tight text-white group-hover:text-blue-300 transition">
                TN Class 10
              </span>
              <span className="bg-blue-500/15 text-blue-300 border border-blue-500/30 text-[10px] font-bold px-1.5 py-0.2 rounded-md">
                {getEditionBadge()}
              </span>
            </div>
            <p className="text-[10px] text-slate-400 font-medium hidden sm:block tracking-wide">
              Tamil Nadu State Board
            </p>
          </div>
        </Link>

        {/* Right: Actions, Sync Status & User Profile */}
        <div className="flex items-center gap-2 sm:gap-3 flex-shrink-0">
          {/* Cloud Database Telemetry Badge (Desktop only to save mobile space) */}
          <span 
            title="Active database: Coolify MongoDB / Local PostgreSQL"
            className="hidden lg:inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[11px] font-medium bg-emerald-500/10 text-emerald-300 border border-emerald-500/25"
          >
            <Database className="w-3 h-3 text-emerald-400" />
            <span>DB Online</span>
            <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse" />
          </span>

          {/* Sync Status Badge */}
          <div className="flex items-center">
            {syncStatus === 'syncing' && (
              <span className="inline-flex items-center gap-1.5 px-2 py-1 rounded-xl text-xs font-medium bg-blue-500/10 text-blue-400 border border-blue-500/20">
                <RefreshCw className="w-3.5 h-3.5 animate-spin" />
                <span className="hidden sm:inline">Syncing</span>
              </span>
            )}

            {syncStatus === 'synced' && (
              <span className="inline-flex items-center gap-1 px-2 py-1 rounded-xl text-xs font-medium text-emerald-400 bg-emerald-500/10 border border-emerald-500/20">
                <CheckCircle2 className="w-3.5 h-3.5" />
                <span className="hidden sm:inline">Synced</span>
              </span>
            )}

            {syncStatus === 'unsynced' && (
              <button
                onClick={triggerSync}
                title="Tap to synchronize offline changes"
                className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl text-xs font-semibold bg-amber-500/15 text-amber-300 border border-amber-500/30 hover:bg-amber-500/25 transition cursor-pointer"
              >
                <RefreshCw className="w-3.5 h-3.5" />
                <span>{unsyncedCount} saved</span>
              </button>
            )}

            {syncStatus === 'offline' && (
              <span className="inline-flex items-center gap-1.5 px-2 py-1 rounded-xl text-xs font-medium bg-slate-900 text-slate-400 border border-slate-800">
                <WifiOff className="w-3.5 h-3.5 text-amber-400" />
                <span className="hidden sm:inline">Offline</span>
              </span>
            )}

            {syncStatus === 'error' && (
              <button
                onClick={triggerSync}
                className="inline-flex items-center gap-1 px-2 py-1 rounded-xl text-xs font-semibold bg-rose-500/15 text-rose-300 border border-rose-500/30 hover:bg-rose-500/25 transition cursor-pointer"
              >
                <AlertCircle className="w-3.5 h-3.5" />
                <span>Retry</span>
              </button>
            )}
          </div>

          {/* Install PWA Quick Action Button (Affan Accent) */}
          <button
            onClick={handleOpenInstall}
            className="inline-flex items-center gap-1.5 px-2.5 sm:px-3 py-1.5 rounded-xl text-xs font-bold bg-amber-500/15 hover:bg-amber-500/25 text-amber-300 border border-amber-500/30 transition active:scale-95 cursor-pointer shadow-sm"
            title="Install Progressive Web App on your device"
            aria-label="Install App"
          >
            <Download className="w-3.5 h-3.5 text-amber-400" />
            <span className="hidden sm:inline">Install App</span>
          </button>

          {/* Auth/Profile Action */}
          {user ? (
            <Link
              href="/settings"
              className="p-1.5 sm:p-2 rounded-xl bg-slate-900/90 hover:bg-slate-800 border border-white/[0.08] text-slate-300 hover:text-white transition flex items-center justify-center shadow-sm"
              title={`Logged in as ${user.display_name} - Open Settings`}
            >
              {isAdmin ? (
                <ShieldCheck className="w-4 h-4 text-amber-400" />
              ) : (
                <div className="w-6 h-6 rounded-lg bg-blue-600/30 text-blue-300 border border-blue-500/30 flex items-center justify-center text-xs font-bold">
                  {user.display_name.charAt(0)}
                </div>
              )}
            </Link>
          ) : (
            <Link
              href="/auth"
              className="px-3 py-1.5 rounded-xl bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold transition shadow-md shadow-blue-600/20 flex items-center gap-1.5 cursor-pointer"
            >
              <UserCircle className="w-3.5 h-3.5" />
              <span>Sign In</span>
            </Link>
          )}

          {/* Affan Sidenav Offcanvas Toggler */}
          <button
            onClick={handleToggleSidenav}
            className="p-2 sm:p-2.5 rounded-xl bg-slate-900/90 hover:bg-slate-800 border border-white/[0.1] text-slate-300 hover:text-white transition flex items-center justify-center cursor-pointer shadow-sm active:scale-95"
            title="Open Menu Drawer"
            aria-label="Open Navigation Drawer"
          >
            <Menu className="w-4 h-4 text-blue-400" />
          </button>
        </div>
      </div>
    </header>
  );
}
