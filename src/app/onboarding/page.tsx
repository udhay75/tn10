'use client';

// ============================================================================
// Onboarding Screen: Choose Class, Medium, and Subjects
// ============================================================================

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import { GraduationCap, CheckCircle2, BookOpen, ArrowRight } from 'lucide-react';
import { useAuth } from '@/lib/auth/auth-context';
import { useI18n } from '@/lib/i18n/i18n-context';

export default function OnboardingPage() {
  const router = useRouter();
  const { user, updateProfile } = useAuth();
  const { lang, t } = useI18n();

  const [selectedClass] = useState('class_10');
  const [selectedMedium, setSelectedMedium] = useState('english');
  const [selectedSubject] = useState('class_10_english');

  const handleFinish = async () => {
    await updateProfile({
      class_code: selectedClass,
      medium_code: selectedMedium,
    });
    router.push('/dashboard');
  };

  return (
    <div className="max-w-xl mx-auto my-8 animate-in fade-in duration-300">
      <div className="bg-slate-900 border border-slate-800 rounded-3xl p-6 sm:p-8 shadow-2xl space-y-6">
        <div className="text-center space-y-2">
          <div className="w-14 h-14 rounded-2xl bg-blue-600/20 border border-blue-500/30 flex items-center justify-center mx-auto text-blue-400">
            <GraduationCap className="w-7 h-7" />
          </div>
          <h1 className="text-2xl font-extrabold text-white tracking-tight">
            {lang === 'ta' ? 'வணக்கம்! உங்கள் படிப்பு அமைப்புகள்' : 'Welcome! Set Up Your Curriculum'}
          </h1>
          <p className="text-xs text-slate-400">
            Tamil Nadu State Board Standard 10 Board Exam Preparation
          </p>
        </div>

        {/* Step 1: Board & Class */}
        <div className="space-y-2">
          <label className="block text-xs font-bold text-slate-300 uppercase tracking-wide">
            1. Target Class & Board
          </label>
          <div className="p-4 bg-slate-950 rounded-2xl border border-slate-800 flex items-center justify-between">
            <div>
              <span className="text-sm font-bold text-white block">Standard 10 (Class X)</span>
              <span className="text-xs text-slate-400">Tamil Nadu State Board of School Education</span>
            </div>
            <span className="px-2.5 py-1 bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 text-xs font-semibold rounded-lg flex items-center gap-1">
              <CheckCircle2 className="w-3.5 h-3.5" />
              Active
            </span>
          </div>
        </div>

        {/* Step 2: Medium Selection */}
        <div className="space-y-2">
          <label className="block text-xs font-bold text-slate-300 uppercase tracking-wide">
            2. Choose Study Medium
          </label>
          <div className="grid grid-cols-2 gap-3">
            <button
              type="button"
              onClick={() => setSelectedMedium('english')}
              className={`p-4 rounded-2xl border text-left transition cursor-pointer ${
                selectedMedium === 'english'
                  ? 'bg-blue-600/15 border-blue-500 text-white ring-1 ring-blue-500'
                  : 'bg-slate-950 border-slate-800 text-slate-400 hover:text-white'
              }`}
            >
              <span className="block text-sm font-bold">English Medium</span>
              <span className="block text-[11px] text-slate-400 mt-0.5">Primary instruction language</span>
            </button>
            <button
              type="button"
              onClick={() => setSelectedMedium('tamil')}
              className={`p-4 rounded-2xl border text-left transition cursor-pointer ${
                selectedMedium === 'tamil'
                  ? 'bg-blue-600/15 border-blue-500 text-white ring-1 ring-blue-500'
                  : 'bg-slate-950 border-slate-800 text-slate-400 hover:text-white'
              }`}
            >
              <span className="block text-sm font-bold">தமிழ் வழி (Tamil)</span>
              <span className="block text-[11px] text-slate-400 mt-0.5">தமிழ் வழி பாடத்திட்டம்</span>
            </button>
          </div>
        </div>

        {/* Step 3: Available Subject */}
        <div className="space-y-2">
          <label className="block text-xs font-bold text-slate-300 uppercase tracking-wide">
            3. Subject Textbook
          </label>
          <div className="p-4 bg-slate-950 rounded-2xl border border-slate-800 flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-9 h-9 rounded-xl bg-blue-500/10 text-blue-400 flex items-center justify-center">
                <BookOpen className="w-5 h-5" />
              </div>
              <div>
                <span className="text-sm font-bold text-white block">English (2024 Edition)</span>
                <span className="text-xs text-slate-400">7 Units • 21 Lessons • 154 Activities</span>
              </div>
            </div>
            <span className="text-xs font-bold text-blue-400">Verified</span>
          </div>
        </div>

        {/* Proceed Button */}
        <button
          onClick={handleFinish}
          className="w-full py-3.5 bg-blue-600 hover:bg-blue-500 text-white rounded-xl text-xs font-bold transition shadow-lg shadow-blue-600/25 flex items-center justify-center gap-2 cursor-pointer active:scale-95"
        >
          <span>{lang === 'ta' ? 'முகப்பு பலகைக்குச் செல்' : 'Enter Dashboard & Start Studying'}</span>
          <ArrowRight className="w-4 h-4" />
        </button>
      </div>
    </div>
  );
}
