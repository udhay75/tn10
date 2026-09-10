'use client';

// ============================================================================
// Authentication Page: Modern Glassmorphic Login & Role Switcher
// Supports MongoDB (Coolify), PostgreSQL (Docker), and Offline PWA operation.
// ============================================================================

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { 
  BookOpen, 
  User, 
  Lock, 
  Mail, 
  ArrowRight, 
  ShieldCheck, 
  CheckCircle2, 
  Sparkles,
  Layers,
  Database,
  Eye,
  EyeOff,
  LogOut,
  RefreshCw
} from 'lucide-react';
import { useAuth } from '@/lib/auth/auth-context';
import { useI18n } from '@/lib/i18n/i18n-context';

export default function AuthPage() {
  const router = useRouter();
  const { user, isDemoMode, signInDemo, signInWithPassword, signUpWithPassword, resetPassword, signOut } = useAuth();
  const { t, lang } = useI18n();

  const [mode, setMode] = useState<'signin' | 'signup' | 'reset'>('signin');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [name, setName] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setSuccess(null);
    setLoading(true);

    try {
      if (mode === 'signin') {
        const res = await signInWithPassword(email, password);
        if (res.error) {
          setError(res.error);
        } else {
          router.push('/dashboard');
        }
      } else if (mode === 'signup') {
        const res = await signUpWithPassword(email, password, name);
        if (res.error) {
          setError(res.error);
        } else {
          router.push('/dashboard');
        }
      } else if (mode === 'reset') {
        const res = await resetPassword(email);
        if (res.error) {
          setError(res.error);
        } else {
          setSuccess('Password reset link sent to your email address.');
        }
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred during authentication');
    } finally {
      setLoading(false);
    }
  };

  const handleDemoLogin = async (role: 'student' | 'admin') => {
    setLoading(true);
    try {
      await signInDemo(role);
      router.push('/dashboard');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="relative max-w-lg mx-auto my-6 sm:my-12 animate-in fade-in duration-300 px-4 sm:px-0">
      {/* Ambient background glow orbs */}
      <div className="absolute -top-12 -left-12 w-64 h-64 bg-blue-600/15 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute -bottom-12 -right-12 w-64 h-64 bg-purple-600/15 rounded-full blur-3xl pointer-events-none" />

      <div className="relative glass-panel bg-slate-900/85 backdrop-blur-2xl border border-white/[0.08] rounded-3xl p-6 sm:p-9 shadow-2xl space-y-6">
        {/* App Branding & Header */}
        <div className="text-center space-y-3">
          <div className="w-14 h-14 rounded-2xl bg-gradient-to-tr from-blue-600 via-indigo-500 to-cyan-400 p-[2px] mx-auto shadow-xl shadow-blue-500/25">
            <div className="w-full h-full bg-slate-950 rounded-2xl flex items-center justify-center">
              <BookOpen className="w-7 h-7 text-blue-400" />
            </div>
          </div>

          <div>
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 text-[11px] font-semibold mb-2">
              <Sparkles className="w-3 h-3" />
              <span>TN State Board Samacheer Kalvi</span>
            </div>
            <h1 className="text-xl sm:text-2xl font-black text-white tracking-tight">
              {lang === 'ta' ? 'தமிழ்நாடு 10-ஆம் வகுப்பு படிப்பு' : 'TN Class 10 Study PWA'}
            </h1>
            <p className="text-xs text-slate-400 mt-1">
              {mode === 'signin' ? 'Sign in to access your notes, revision sprints & progress' :
               mode === 'signup' ? 'Create a student account with full MongoDB & offline capability' : 'Reset your password to regain access'}
            </p>
          </div>
        </div>

        {/* Canonical 5-Subject Pills Overview */}
        <div className="bg-slate-950/60 p-3 rounded-2xl border border-white/[0.06] space-y-2">
          <div className="flex items-center justify-between text-[11px] font-semibold text-slate-400 px-1">
            <span className="flex items-center gap-1.5">
              <Layers className="w-3.5 h-3.5 text-blue-400" />
              5 Canonical Subjects:
            </span>
            <span className="text-[10px] text-slate-500">2025/2024</span>
          </div>
          <div className="flex items-center justify-between gap-1 text-[11px]">
            <span className="px-2 py-1 bg-amber-500/15 text-amber-300 border border-amber-500/30 rounded-lg font-bold">
              📜 Tamil
            </span>
            <span className="px-2 py-1 bg-indigo-500/15 text-indigo-300 border border-indigo-500/30 rounded-lg font-bold">
              📘 English
            </span>
            <span className="px-2 py-1 bg-cyan-500/15 text-cyan-300 border border-cyan-500/30 rounded-lg font-bold">
              📐 Math
            </span>
            <span className="px-2 py-1 bg-purple-500/15 text-purple-300 border border-purple-500/30 rounded-lg font-bold">
              🔬 Science
            </span>
            <span className="px-2 py-1 bg-emerald-500/15 text-emerald-300 border border-emerald-500/30 rounded-lg font-bold">
              🌍 Social
            </span>
          </div>
        </div>

        {/* Current Active Account Card (if logged in) */}
        {user && (
          <div className="bg-slate-950/80 border border-emerald-500/30 rounded-2xl p-3.5 flex items-center justify-between">
            <div className="flex items-center gap-2.5">
              <div className="w-8 h-8 rounded-xl bg-emerald-500/20 text-emerald-300 flex items-center justify-center font-bold text-xs">
                {user.display_name.charAt(0)}
              </div>
              <div>
                <span className="text-xs font-bold text-white block">
                  Active: {user.display_name}
                </span>
                <span className="text-[10px] text-slate-400 font-mono">
                  {user.email}
                </span>
              </div>
            </div>
            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={() => router.push('/dashboard')}
                className="px-3 py-1.5 bg-emerald-600 hover:bg-emerald-500 text-white rounded-xl text-[11px] font-bold transition flex items-center gap-1 cursor-pointer"
              >
                <span>Continue</span>
                <ArrowRight className="w-3 h-3" />
              </button>
            </div>
          </div>
        )}

        {/* Demo Mode Quick Access Banner */}
        <div className="bg-gradient-to-r from-blue-950/50 to-indigo-950/50 border border-blue-500/25 rounded-2xl p-4 space-y-2.5">
          <div className="flex items-center justify-between">
            <span className="text-[11px] font-bold text-blue-300 uppercase tracking-wider flex items-center gap-1.5">
              <Database className="w-3.5 h-3.5 text-blue-400" />
              Quick 1-Click Access:
            </span>
            <span className="text-[10px] text-emerald-400/90 font-medium">MongoDB & Local Ready</span>
          </div>
          <div className="grid grid-cols-2 gap-2.5">
            <button
              type="button"
              disabled={loading}
              onClick={() => handleDemoLogin('student')}
              className="py-2.5 px-3 bg-blue-600 hover:bg-blue-500 disabled:opacity-50 text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 cursor-pointer shadow-lg shadow-blue-600/20"
            >
              <User className="w-3.5 h-3.5" />
              <span>Demo Student</span>
            </button>
            <button
              type="button"
              disabled={loading}
              onClick={() => handleDemoLogin('admin')}
              className="py-2.5 px-3 bg-purple-600 hover:bg-purple-500 disabled:opacity-50 text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 cursor-pointer shadow-lg shadow-purple-600/20"
            >
              <ShieldCheck className="w-3.5 h-3.5" />
              <span>Demo Admin</span>
            </button>
          </div>
        </div>

        {/* Mode Switcher Tabs */}
        <div className="flex items-center justify-center bg-slate-950/80 p-1 rounded-2xl border border-white/[0.08]">
          <button
            type="button"
            onClick={() => { setMode('signin'); setError(null); setSuccess(null); }}
            className={`flex-1 py-2 text-xs font-bold rounded-xl transition cursor-pointer ${
              mode === 'signin'
                ? 'bg-blue-600 text-white shadow-md'
                : 'text-slate-400 hover:text-white'
            }`}
          >
            Sign In
          </button>
          <button
            type="button"
            onClick={() => { setMode('signup'); setError(null); setSuccess(null); }}
            className={`flex-1 py-2 text-xs font-bold rounded-xl transition cursor-pointer ${
              mode === 'signup'
                ? 'bg-blue-600 text-white shadow-md'
                : 'text-slate-400 hover:text-white'
            }`}
          >
            Create Account
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-4">
          {error && (
            <div className="p-3 bg-rose-500/15 border border-rose-500/30 rounded-xl text-xs text-rose-300 animate-in fade-in flex items-center gap-2">
              <span className="w-1.5 h-1.5 rounded-full bg-rose-400 shrink-0" />
              <span>{error}</span>
            </div>
          )}
          {success && (
            <div className="p-3 bg-emerald-500/15 border border-emerald-500/30 rounded-xl text-xs text-emerald-300 animate-in fade-in flex items-center gap-2">
              <CheckCircle2 className="w-4 h-4 shrink-0 text-emerald-400" />
              <span>{success}</span>
            </div>
          )}

          {mode === 'signup' && (
            <div>
              <label className="block text-[11px] font-semibold text-slate-300 mb-1.5">Student Full Name</label>
              <div className="relative">
                <User className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  type="text"
                  required
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="e.g. Anitha Selvam"
                  className="w-full bg-slate-950/80 border border-white/[0.08] rounded-xl pl-10 pr-3 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition"
                />
              </div>
            </div>
          )}

          <div>
            <label className="block text-[11px] font-semibold text-slate-300 mb-1.5">Email Address</label>
            <div className="relative">
              <Mail className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
              <input
                type="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="student@tn10.udhees.com"
                className="w-full bg-slate-950/80 border border-white/[0.08] rounded-xl pl-10 pr-3 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition"
              />
            </div>
          </div>

          {mode !== 'reset' && (
            <div>
              <label className="block text-[11px] font-semibold text-slate-300 mb-1.5">Password</label>
              <div className="relative">
                <Lock className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  className="w-full bg-slate-950/80 border border-white/[0.08] rounded-xl pl-10 pr-10 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-white transition cursor-pointer"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3.5 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white rounded-xl text-xs font-bold transition shadow-lg shadow-blue-600/25 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50"
          >
            {loading ? (
              <>
                <RefreshCw className="w-4 h-4 animate-spin" />
                <span>Processing...</span>
              </>
            ) : (
              <>
                <span>
                  {mode === 'signin' ? 'Sign In' : mode === 'signup' ? 'Create Student Account' : 'Send Reset Link'}
                </span>
                <ArrowRight className="w-4 h-4" />
              </>
            )}
          </button>
        </form>

        {/* Mode Switcher Links */}
        <div className="pt-2 border-t border-white/[0.08] flex items-center justify-between text-xs text-slate-400">
          {mode === 'signin' ? (
            <>
              <button
                type="button"
                onClick={() => setMode('signup')}
                className="hover:text-blue-400 transition cursor-pointer"
              >
                Need an account? Sign up
              </button>
              <button
                type="button"
                onClick={() => setMode('reset')}
                className="hover:text-slate-200 transition cursor-pointer"
              >
                Forgot password?
              </button>
            </>
          ) : (
            <button
              type="button"
              onClick={() => setMode('signin')}
              className="hover:text-blue-400 transition cursor-pointer mx-auto font-medium"
            >
              Already have an account? Sign in
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
