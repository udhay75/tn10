'use client';

// ============================================================================
// Modern PWA Installation & Service Worker Update Manager (2026 Edition)
// Handles Chromium/Android beforeinstallprompt, Apple Safari visual guide,
// manual trigger via 'open-pwa-install' custom event, and zero-data-loss updates.
// ============================================================================

import React, { useEffect, useState } from 'react';
import { 
  Download, 
  Share2, 
  RefreshCw, 
  X, 
  Sparkles, 
  ShieldCheck, 
  Zap, 
  BookOpen, 
  Check, 
  Smartphone,
  Layers
} from 'lucide-react';
import { useI18n } from '@/lib/i18n/i18n-context';
import { useStudy } from '@/lib/store/study-context';
import { triggerHaptic } from '@/lib/utils/haptics';

export function PwaInstallPrompt() {
  const { t, lang } = useI18n();
  const { unsyncedCount, triggerSync } = useStudy();
  
  const [deferredPrompt, setDeferredPrompt] = useState<any>(null);
  const [isIos, setIsIos] = useState(false);
  const [isStandalone, setIsStandalone] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const [showFloatingBanner, setShowFloatingBanner] = useState(false);
  const [updateAvailable, setUpdateAvailable] = useState(false);
  const [waitingWorker, setWaitingWorker] = useState<ServiceWorker | null>(null);

  useEffect(() => {
    if (typeof window === 'undefined') return;

    // Detect standalone PWA mode
    const isStandaloneMode = 
      window.matchMedia('(display-mode: standalone)').matches || 
      (window.navigator as any).standalone === true;
    setIsStandalone(isStandaloneMode);

    // Detect iOS
    const userAgent = window.navigator.userAgent.toLowerCase();
    const isIosDevice = /iphone|ipad|ipod/.test(userAgent);
    setIsIos(isIosDevice);

    // Handle Chromium beforeinstallprompt
    const handleBeforeInstall = (e: Event) => {
      e.preventDefault();
      setDeferredPrompt(e);
      if (!isStandaloneMode) {
        // Show floating prompt after a friendly delay
        const timer = setTimeout(() => setShowFloatingBanner(true), 2500);
        return () => clearTimeout(timer);
      }
    };
    window.addEventListener('beforeinstallprompt', handleBeforeInstall);

    // Custom event to manually open install dialog from Header or Settings
    const handleManualOpen = () => {
      triggerHaptic('light');
      setShowModal(true);
    };
    window.addEventListener('open-pwa-install', handleManualOpen);

    // Register Service Worker and monitor updates
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.register('/sw.js').then((registration) => {
        registration.addEventListener('updatefound', () => {
          const newWorker = registration.installing;
          if (newWorker) {
            newWorker.addEventListener('statechange', () => {
              if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
                setUpdateAvailable(true);
                setWaitingWorker(newWorker);
              }
            });
          }
        });
      }).catch((err) => {
        console.warn('Service worker registration:', err);
      });

      let refreshing = false;
      navigator.serviceWorker.addEventListener('controllerchange', () => {
        if (!refreshing) {
          refreshing = true;
          window.location.reload();
        }
      });
    }

    return () => {
      window.removeEventListener('beforeinstallprompt', handleBeforeInstall);
      window.removeEventListener('open-pwa-install', handleManualOpen);
    };
  }, []);

  const handleInstallClick = async () => {
    triggerHaptic('medium');
    if (deferredPrompt) {
      deferredPrompt.prompt();
      const { outcome } = await deferredPrompt.userChoice;
      if (outcome === 'accepted') {
        setDeferredPrompt(null);
        setShowFloatingBanner(false);
        setShowModal(false);
      }
    } else {
      setShowModal(true);
    }
  };

  const handleApplyUpdate = async () => {
    triggerHaptic('success');
    if (unsyncedCount > 0) {
      await triggerSync();
    }
    if (waitingWorker) {
      waitingWorker.postMessage({ type: 'SKIP_WAITING' });
    }
  };

  return (
    <>
      {/* 1. Update Ready Floating Toast */}
      {updateAvailable && (
        <aside aria-label="Update notification" className="fixed bottom-20 md:bottom-6 right-4 left-4 md:left-auto md:max-w-md z-50">
          <div className="bg-gradient-to-r from-blue-600 via-indigo-600 to-cyan-600 text-white p-4 rounded-3xl shadow-2xl flex items-center justify-between gap-3 border border-white/20 animate-in slide-in-from-bottom duration-300">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-2xl bg-white/15 flex items-center justify-center shrink-0">
                <RefreshCw className="w-5 h-5 animate-spin text-white" />
              </div>
              <div>
                <p className="text-xs sm:text-sm font-bold">New Curriculum Update Ready!</p>
                <p className="text-[11px] text-blue-100">Reload to get the latest questions and syllabus fixes.</p>
              </div>
            </div>
            <button
              onClick={handleApplyUpdate}
              className="px-3.5 py-2 bg-white hover:bg-slate-100 text-blue-700 text-xs font-black rounded-xl shadow-md transition active:scale-95 cursor-pointer shrink-0"
            >
              Update Now
            </button>
          </div>
        </aside>
      )}

      {/* 2. Floating Bottom Install Mini-Banner (if not installed) */}
      {!isStandalone && showFloatingBanner && (
        <aside aria-label="Install App" className="fixed bottom-20 md:bottom-6 right-4 left-4 md:left-auto md:max-w-sm z-40">
          <div className="glass-panel bg-slate-900/90 backdrop-blur-2xl text-white p-4 rounded-3xl shadow-2xl border border-white/[0.12] flex items-center justify-between gap-3 animate-in slide-in-from-bottom duration-300">
            <div className="flex items-center gap-3 min-w-0">
              <div className="w-11 h-11 rounded-2xl bg-gradient-to-tr from-blue-600 to-indigo-500 p-[2px] shadow-lg shadow-blue-500/25 shrink-0">
                <div className="w-full h-full bg-slate-950 rounded-2xl flex items-center justify-center">
                  <BookOpen className="w-5 h-5 text-blue-400" />
                </div>
              </div>
              <div className="min-w-0">
                <div className="flex items-center gap-1.5">
                  <span className="text-xs font-bold text-white truncate">Install TN10 Study App</span>
                  <span className="bg-emerald-500/20 text-emerald-300 text-[9px] font-bold px-1.5 py-0.2 rounded">PWA</span>
                </div>
                <p className="text-[11px] text-slate-400 truncate">100% offline study with zero data loss</p>
              </div>
            </div>

            <div className="flex items-center gap-2 shrink-0">
              <button
                onClick={handleInstallClick}
                className="px-3.5 py-2 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white text-xs font-bold rounded-xl shadow-md shadow-blue-600/25 transition active:scale-95 cursor-pointer"
              >
                {isIos ? 'Install' : 'Install'}
              </button>
              <button
                onClick={() => setShowFloatingBanner(false)}
                className="p-1.5 text-slate-400 hover:text-white rounded-lg transition cursor-pointer"
                aria-label="Dismiss banner"
              >
                <X className="w-4 h-4" />
              </button>
            </div>
          </div>
        </aside>
      )}

      {/* 3. Comprehensive PWA Installation Modal (Interactive Drawer) */}
      {showModal && (
        <div className="fixed inset-0 bg-black/80 backdrop-blur-md z-50 flex items-end sm:items-center justify-center p-4 animate-in fade-in duration-200">
          <div className="glass-panel bg-slate-900/95 border border-white/[0.12] text-white rounded-3xl p-6 sm:p-8 max-w-md w-full shadow-2xl animate-in zoom-in-95 duration-200 space-y-6">
            {/* Modal Header */}
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-3.5">
                <div className="w-12 h-12 rounded-2xl bg-gradient-to-tr from-blue-600 via-indigo-500 to-cyan-400 p-[2px] shadow-xl shadow-blue-500/20">
                  <div className="w-full h-full bg-slate-950 rounded-2xl flex items-center justify-center">
                    <BookOpen className="w-6 h-6 text-blue-400" />
                  </div>
                </div>
                <div>
                  <div className="flex items-center gap-1.5">
                    <h3 className="text-base font-extrabold text-white">TN Class 10 Study PWA</h3>
                    <span className="text-[10px] bg-blue-500/20 text-blue-300 border border-blue-500/30 px-2 py-0.5 rounded-full font-bold">
                      2025/2026
                    </span>
                  </div>
                  <p className="text-xs text-slate-400">Tamil Nadu State Board Samacheer Kalvi</p>
                </div>
              </div>
              <button
                onClick={() => setShowModal(false)}
                className="p-1.5 rounded-xl bg-slate-800 text-slate-400 hover:text-white transition cursor-pointer"
                aria-label="Close"
              >
                <X className="w-4 h-4" />
              </button>
            </div>

            {/* PWA Benefits Grid */}
            <div className="grid grid-cols-2 gap-2.5 text-xs">
              <div className="bg-slate-950/70 p-3 rounded-2xl border border-white/[0.06] flex items-start gap-2.5">
                <Zap className="w-4 h-4 text-amber-400 shrink-0 mt-0.5" />
                <div>
                  <strong className="text-white block font-bold">100% Offline</strong>
                  <span className="text-[10px] text-slate-400">Full study without internet</span>
                </div>
              </div>
              <div className="bg-slate-950/70 p-3 rounded-2xl border border-white/[0.06] flex items-start gap-2.5">
                <ShieldCheck className="w-4 h-4 text-emerald-400 shrink-0 mt-0.5" />
                <div>
                  <strong className="text-white block font-bold">Zero Data Loss</strong>
                  <span className="text-[10px] text-slate-400">IndexedDB + Docker DB</span>
                </div>
              </div>
              <div className="bg-slate-950/70 p-3 rounded-2xl border border-white/[0.06] flex items-start gap-2.5">
                <Layers className="w-4 h-4 text-blue-400 shrink-0 mt-0.5" />
                <div>
                  <strong className="text-white block font-bold">5 Canonical Subjects</strong>
                  <span className="text-[10px] text-slate-400">Tamil, Eng, Math, Sci, Soc</span>
                </div>
              </div>
              <div className="bg-slate-950/70 p-3 rounded-2xl border border-white/[0.06] flex items-start gap-2.5">
                <Smartphone className="w-4 h-4 text-purple-400 shrink-0 mt-0.5" />
                <div>
                  <strong className="text-white block font-bold">Instant App Launch</strong>
                  <span className="text-[10px] text-slate-400">Standalone full-screen</span>
                </div>
              </div>
            </div>

            {/* Platform Instructions */}
            {isIos ? (
              <div className="bg-slate-950/80 p-4 rounded-2xl border border-white/[0.08] space-y-3">
                <div className="flex items-center gap-2 text-indigo-300 text-xs font-bold">
                  <Share2 className="w-4 h-4" />
                  <span>How to install on iPhone or iPad:</span>
                </div>
                <ol className="text-xs text-slate-300 space-y-2.5 pl-5 list-decimal">
                  <li>
                    Tap the <strong className="text-white">Share</strong> button (box with an arrow pointing up) at the bottom of Safari.
                  </li>
                  <li>
                    Scroll down in the action sheet and select <strong className="text-white">Add to Home Screen</strong>.
                  </li>
                  <li>
                    Tap <strong className="text-blue-400">Add</strong> at the top right corner.
                  </li>
                </ol>
              </div>
            ) : deferredPrompt ? (
              <button
                onClick={handleInstallClick}
                className="w-full py-4 bg-gradient-to-r from-blue-600 via-indigo-600 to-cyan-500 hover:from-blue-500 hover:to-cyan-400 text-white font-extrabold text-sm rounded-2xl transition shadow-xl shadow-blue-600/30 flex items-center justify-center gap-2 cursor-pointer active:scale-95"
              >
                <Download className="w-5 h-5" />
                <span>Install Application Now</span>
              </button>
            ) : (
              <div className="bg-slate-950/80 p-4 rounded-2xl border border-white/[0.08] text-xs space-y-2">
                <div className="flex items-center gap-2 text-blue-300 font-bold">
                  <Download className="w-4 h-4" />
                  <span>Desktop & Android Installation:</span>
                </div>
                <p className="text-slate-400 leading-relaxed">
                  Open your browser menu (⋮ or top right address bar icon) and select <strong>&quot;Install TN10 Study&quot;</strong> or <strong>&quot;Add to Home Screen&quot;</strong>.
                </p>
              </div>
            )}

            <button
              onClick={() => setShowModal(false)}
              className="w-full py-2.5 bg-slate-800/80 hover:bg-slate-800 text-slate-300 text-xs font-semibold rounded-xl transition cursor-pointer"
            >
              Close
            </button>
          </div>
        </div>
      )}
    </>
  );
}
