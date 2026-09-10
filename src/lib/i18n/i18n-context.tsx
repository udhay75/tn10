'use client';

// ============================================================================
// I18n Context: Bilingual Support (English & தமிழ்)
// ============================================================================

import React, { createContext, useContext, useState, useEffect } from 'react';
import { SupportedLang, translations } from './translations';
import { useAuth } from '@/lib/auth/auth-context';

interface I18nContextType {
  lang: SupportedLang;
  setLang: (lang: SupportedLang) => void;
  t: typeof translations['en'];
  toggleLang: () => void;
}

const I18nContext = createContext<I18nContextType | undefined>(undefined);

export function I18nProvider({ children }: { children: React.ReactNode }) {
  const { user, updateProfile } = useAuth();
  const [lang, setLangState] = useState<SupportedLang>('en');

  useEffect(() => {
    if (user?.interface_lang) {
      setLangState(user.interface_lang);
    } else if (typeof window !== 'undefined') {
      const saved = localStorage.getItem('tn10_lang') as SupportedLang;
      if (saved === 'en' || saved === 'ta') {
        setLangState(saved);
      }
    }
  }, [user]);

  const setLang = (newLang: SupportedLang) => {
    setLangState(newLang);
    if (typeof window !== 'undefined') {
      localStorage.setItem('tn10_lang', newLang);
    }
    if (user) {
      updateProfile({ interface_lang: newLang });
    }
  };

  const toggleLang = () => {
    setLang(lang === 'en' ? 'ta' : 'en');
  };

  const t = translations[lang] || translations.en;

  return (
    <I18nContext.Provider value={{ lang, setLang, t, toggleLang }}>
      {children}
    </I18nContext.Provider>
  );
}

export function useI18n() {
  const context = useContext(I18nContext);
  if (!context) {
    throw new Error('useI18n must be used within an I18nProvider');
  }
  return context;
}
