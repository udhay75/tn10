'use client';

// ============================================================================
// Modern Application Navigation (2025/2026 Mobile Floating Dock + Desktop Pills)
// ============================================================================

import React from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { LayoutDashboard, BookOpenCheck, BookmarkCheck, Settings, ShieldAlert } from 'lucide-react';
import { useI18n } from '@/lib/i18n/i18n-context';
import { useStudy } from '@/lib/store/study-context';
import { useAuth } from '@/lib/auth/auth-context';

export function Navigation() {
  const pathname = usePathname();
  const { t } = useI18n();
  const { overallStats } = useStudy();
  const { isAdmin } = useAuth();

  const navItems = [
    {
      href: '/dashboard',
      label: t.nav.dashboard,
      icon: LayoutDashboard,
      active: pathname === '/dashboard' || pathname === '/',
    },
    {
      href: '/curriculum',
      label: t.nav.curriculum,
      icon: BookOpenCheck,
      active: pathname.startsWith('/curriculum') || pathname.startsWith('/lesson'),
    },
    {
      href: '/revision',
      label: t.nav.revision,
      icon: BookmarkCheck,
      active: pathname === '/revision',
      badge: overallStats.studyAgainCount > 0 ? overallStats.studyAgainCount : null,
    },
    {
      href: '/settings',
      label: t.nav.settings,
      icon: Settings,
      active: pathname === '/settings',
    },
  ];

  if (isAdmin) {
    navItems.push({
      href: '/admin',
      label: t.nav.admin,
      icon: ShieldAlert,
      active: pathname === '/admin',
      badge: null,
    });
  }

  return (
    <>
      {/* Mobile Affan Footer Nav (Fixed to bottom, touch-optimized, safe-area-pb) */}
      <nav 
        aria-label="Mobile Navigation"
        className="md:hidden fixed bottom-0 left-0 right-0 z-40 bg-slate-950/95 backdrop-blur-2xl border-t border-white/[0.1] px-2 py-1.5 flex items-center justify-around shadow-2xl safe-area-pb"
      >
        {navItems.map((item) => {
          const Icon = item.icon;
          return (
            <Link
              key={item.href}
              href={item.href}
              onClick={() => {
                if (typeof window !== 'undefined' && 'vibrate' in navigator) {
                  try { navigator.vibrate(8); } catch {}
                }
              }}
              className={`relative flex flex-col items-center justify-center flex-1 min-h-[48px] py-1 px-1 rounded-2xl transition-all duration-200 active:scale-95 ${
                item.active 
                  ? 'bg-blue-600/15 text-blue-400 font-bold border border-blue-500/25 shadow-sm' 
                  : 'text-slate-400 hover:text-slate-200'
              }`}
            >
              <div className="relative">
                <Icon className={`w-5 h-5 ${item.active ? 'stroke-[2.5] text-blue-400' : 'stroke-2'}`} />
                {item.badge !== null && item.badge !== undefined && (
                  <span className="absolute -top-1 -right-2.5 min-w-[17px] h-[17px] px-1 bg-amber-400 text-slate-950 text-[9px] font-black rounded-full flex items-center justify-center shadow-md">
                    {item.badge}
                  </span>
                )}
              </div>
              <span className="text-[10px] mt-0.5 tracking-tight font-medium">{item.label}</span>
              {item.active && (
                <span className="w-1.5 h-1.5 rounded-full bg-blue-400 mt-0.5 shadow-sm shadow-blue-400" />
              )}
            </Link>
          );
        })}
      </nav>

      {/* Desktop Secondary Subheader Navigation */}
      <nav 
        aria-label="Desktop Navigation"
        className="hidden md:block bg-slate-950/60 border-b border-white/[0.06] backdrop-blur-md sticky top-16 z-30"
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex items-center gap-2 h-12">
          {navItems.map((item) => {
            const Icon = item.icon;
            return (
              <Link
                key={item.href}
                href={item.href}
                className={`flex items-center gap-2 px-3.5 py-1.5 rounded-xl text-xs font-semibold transition-all duration-200 ${
                  item.active 
                    ? 'bg-blue-600 text-white shadow-md shadow-blue-600/25 font-bold' 
                    : 'text-slate-400 hover:text-slate-200 hover:bg-slate-800/40'
                }`}
              >
                <Icon className="w-4 h-4" />
                <span>{item.label}</span>
                {item.badge !== null && item.badge !== undefined && (
                  <span className="ml-1 px-1.5 py-0.2 bg-amber-400 text-slate-950 text-[10px] font-black rounded-full">
                    {item.badge}
                  </span>
                )}
              </Link>
            );
          })}
        </div>
      </nav>
    </>
  );
}
