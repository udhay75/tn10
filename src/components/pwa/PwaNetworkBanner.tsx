'use client';

// ============================================================================
// PWA Real-Time Connectivity Banner
// Alerts students when internet drops or reconnects with smooth slide animations
// ============================================================================

import React, { useState, useEffect } from 'react';
import { WifiOff, Wifi, X, Database, RefreshCw } from 'lucide-react';
import { useStudy } from '@/lib/store/study-context';
import { useI18n } from '@/lib/i18n/i18n-context';

export function PwaNetworkBanner() {
  const { lang } = useI18n();
  const { triggerSync, unsyncedCount } = useStudy();
  const [isOnline, setIsOnline] = useState<boolean>(true);
  const [showReconnected, setShowReconnected] = useState<boolean>(false);
  const [dismissed, setDismissed] = useState<boolean>(false);

  useEffect(() => {
    if (typeof window === 'undefined') return;

    setIsOnline(navigator.onLine);

    const handleOnline = () => {
      setIsOnline(true);
      setShowReconnected(true);
      setDismissed(false);
      triggerSync();

      const timer = setTimeout(() => {
        setShowReconnected(false);
      }, 4500);
      return () => clearTimeout(timer);
    };

    const handleOffline = () => {
      setIsOnline(false);
      setShowReconnected(false);
      setDismissed(false);
    };

    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);

    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, [triggerSync]);

  if (dismissed) return null;

  // Offline banner
  if (!isOnline) {
    return (
      <div 
        role="status" 
        className="bg-gradient-to-r from-amber-950/90 via-slate-900/95 to-amber-950/90 border-b border-amber-500/30 text-amber-200 px-4 py-2.5 text-xs shadow-xl backdrop-blur-md sticky top-0 z-50 animate-in slide-in-from-top duration-300"
      >
        <div className="max-w-7xl mx-auto flex items-center justify-between gap-3">
          <div className="flex items-center gap-2.5">
            <div className="w-6 h-6 rounded-full bg-amber-500/20 border border-amber-500/40 flex items-center justify-center shrink-0">
              <WifiOff className="w-3.5 h-3.5 text-amber-400" />
            </div>
            <div>
              <span className="font-bold text-white">
                {lang === 'ta' ? 'இணையம் இல்லை (ஆஃப்லைன் பயன்முறை)' : 'Offline Mode Active'}
              </span>
              <span className="text-amber-300/90 ml-1.5 hidden sm:inline">
                {lang === 'ta' 
                  ? 'IndexedDB உள்ளூர் சேமிப்பு செயல்படுகிறது. உங்கள் குறிப்புகள் மற்றும் மதிப்பெண்கள் பாதுகாப்பாக சேமிக்கப்படும்.' 
                  : 'Studying cached curriculum via IndexedDB. Your notes and checkoffs are safe.'}
              </span>
            </div>
          </div>

          <div className="flex items-center gap-3">
            {unsyncedCount > 0 && (
              <span className="bg-amber-500/20 text-amber-300 border border-amber-500/30 px-2 py-0.5 rounded-full text-[10px] font-bold shrink-0">
                {unsyncedCount} {lang === 'ta' ? 'மாற்றங்கள்' : 'pending sync'}
              </span>
            )}
            <button
              onClick={() => setDismissed(true)}
              className="p-1 hover:bg-white/10 rounded-lg text-amber-300 hover:text-white transition cursor-pointer"
              aria-label="Dismiss offline banner"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          </div>
        </div>
      </div>
    );
  }

  // Back online banner (brief toast)
  if (showReconnected) {
    return (
      <div 
        role="status" 
        className="bg-gradient-to-r from-emerald-950/90 via-slate-900/95 to-emerald-950/90 border-b border-emerald-500/30 text-emerald-200 px-4 py-2 text-xs shadow-xl backdrop-blur-md sticky top-0 z-50 animate-in slide-in-from-top duration-300"
      >
        <div className="max-w-7xl mx-auto flex items-center justify-between gap-3">
          <div className="flex items-center gap-2">
            <Wifi className="w-4 h-4 text-emerald-400 animate-pulse" />
            <span className="font-bold text-white">
              {lang === 'ta' ? 'மீண்டும் இணையத்தில் இணைக்கப்பட்டது' : 'Back Online!'}
            </span>
            <span className="text-emerald-300/90 hidden sm:inline">
              {lang === 'ta' 
                ? 'Docker PostgreSQL தரவுத்தளத்துடன் ஒத்திசைக்கப்படுகிறது...' 
                : 'Synchronizing offline mutations with Docker PostgreSQL...'}
            </span>
          </div>
          <button
            onClick={() => setShowReconnected(false)}
            className="p-1 hover:bg-white/10 rounded-lg text-emerald-300 hover:text-white transition cursor-pointer"
            aria-label="Dismiss"
          >
            <X className="w-3.5 h-3.5" />
          </button>
        </div>
      </div>
    );
  }

  return null;
}
