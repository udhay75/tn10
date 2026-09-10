'use client';

// ============================================================================
// Authentication Page: Student Account Creation, Sign In & Password Reset
// Supports MongoDB (Coolify), Nodemailer SMTP, and Offline PWA operation.
// ============================================================================

import React, { useState, useEffect, Suspense } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
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
  Eye, 
  EyeOff, 
  LogOut, 
  RefreshCw,
  AlertCircle,
  KeyRound
} from 'lucide-react';
import { useAuth } from '@/lib/auth/auth-context';
import { useI18n } from '@/lib/i18n/i18n-context';

function AuthContent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { 
    user, 
    isAdmin, 
    signInWithPassword, 
    signUpWithPassword, 
    resetPassword, 
    confirmPasswordReset, 
    signOut 
  } = useAuth();
  const { t, lang } = useI18n();

  const [mode, setMode] = useState<'signup' | 'signin' | 'reset' | 'reset-confirm'>('signup');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [name, setName] = useState('');
  const [token, setToken] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [resetDirectLink, setResetDirectLink] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const urlToken = searchParams.get('token');
    const urlEmail = searchParams.get('email');
    const isAdminParam = searchParams.get('admin') === 'true';
    const requestedMode = searchParams.get('mode');

    if (urlToken) {
      setMode('reset-confirm');
      setToken(urlToken);
      if (urlEmail) setEmail(urlEmail);
    } else if (isAdminParam) {
      setMode('signin');
      setEmail('admin@tn10.udhees.com');
    } else if (requestedMode === 'signin') {
      setMode('signin');
    } else if (requestedMode === 'signup') {
      setMode('signup');
    } else if (requestedMode === 'reset') {
      setMode('reset');
    }
  }, [searchParams]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setSuccess(null);
    setResetDirectLink(null);
    setLoading(true);

    try {
      if (mode === 'signin') {
        const res = await signInWithPassword(email, password);
        if (res.error) {
          setError(res.error);
        } else {
          const cleanEmail = email.trim().toLowerCase();
          if (cleanEmail === 'admin@tn10.udhees.com' || cleanEmail === 'admin.curriculum@tn10.udhees.com') {
            router.push('/admin');
          } else {
            router.push('/dashboard');
          }
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
          if (res.resetLink) {
            setResetDirectLink(res.resetLink);
          }
        } else {
          setSuccess(res.message || 'Password reset link sent to your email.');
          if (res.resetLink && res.smtpConfigured === false) {
            setResetDirectLink(res.resetLink);
          }
        }
      } else if (mode === 'reset-confirm') {
        if (password !== confirmPassword) {
          setError('Passwords do not match. Please verify and re-type.');
          setLoading(false);
          return;
        }

        const res = await confirmPasswordReset(email, token, password);
        if (res.error) {
          setError(res.error);
        } else {
          setSuccess(res.message || 'Password reset successful! You can now sign in with your new password.');
          setPassword('');
          setConfirmPassword('');
        }
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred during authentication');
    } finally {
      setLoading(false);
    }
  };

  const handleSignOut = async () => {
    setLoading(true);
    try {
      await signOut();
      setEmail('');
      setPassword('');
      setName('');
      setMode('signup');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="relative max-w-lg mx-auto my-6 sm:my-10 animate-in fade-in duration-300 px-4 sm:px-0">
      {/* Ambient background glow orbs */}
      <div className="absolute -top-12 -left-12 w-64 h-64 bg-blue-600/15 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute -bottom-12 -right-12 w-64 h-64 bg-purple-600/15 rounded-full blur-3xl pointer-events-none" />

      <div className="relative glass-panel bg-slate-900/90 backdrop-blur-2xl border border-white/[0.08] rounded-3xl p-6 sm:p-9 shadow-2xl space-y-6">
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
              {mode === 'signup'
                ? 'Create your student account to track progress, save notes & study offline'
                : mode === 'signin'
                ? 'Sign in to continue your revision sprints and study checklist'
                : mode === 'reset'
                ? 'Enter your registered email to receive a password reset link'
                : 'Choose and confirm your new secure password'}
            </p>
          </div>
        </div>

        {/* Canonical 5-Subject Pills Overview (shown on main auth screens) */}
        {mode !== 'reset-confirm' && (
          <div className="bg-slate-950/60 p-3 rounded-2xl border border-white/[0.06] space-y-2">
            <div className="flex items-center justify-between text-[11px] font-semibold text-slate-400 px-1">
              <span className="flex items-center gap-1.5">
                <Layers className="w-3.5 h-3.5 text-blue-400" />
                Canonical Subjects:
              </span>
              <span className="text-[10px] text-slate-500">2025 / 2024</span>
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
        )}

        {/* Current Active Account Card (if logged in) */}
        {user && mode !== 'reset-confirm' && (
          <div className="bg-slate-950/80 border border-emerald-500/30 rounded-2xl p-4 space-y-3">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <div className="w-9 h-9 rounded-xl bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 flex items-center justify-center font-bold text-sm">
                  {user.display_name.charAt(0)}
                </div>
                <div>
                  <div className="flex items-center gap-1.5">
                    <span className="text-xs font-bold text-white block">
                      {user.display_name}
                    </span>
                    {user.is_admin && (
                      <span className="px-1.5 py-0.2 rounded bg-purple-500/20 text-purple-300 border border-purple-500/30 text-[9px] font-bold">
                        Admin
                      </span>
                    )}
                  </div>
                  <span className="text-[10px] text-slate-400 font-mono">
                    {user.email}
                  </span>
                </div>
              </div>
              <span className="text-[10px] text-emerald-400 font-semibold px-2 py-0.5 rounded-full bg-emerald-500/10 border border-emerald-500/20">
                Active Session
              </span>
            </div>

            <div className="flex items-center gap-2 pt-1">
              <button
                type="button"
                onClick={() => router.push(user.is_admin ? '/admin' : '/dashboard')}
                className="flex-1 py-2 px-3 bg-emerald-600 hover:bg-emerald-500 text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 cursor-pointer shadow-md"
              >
                <span>{user.is_admin ? 'Open Admin Console' : 'Continue to Dashboard'}</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </button>
              <button
                type="button"
                disabled={loading}
                onClick={handleSignOut}
                className="py-2 px-3 bg-slate-800 hover:bg-slate-700 text-slate-300 hover:text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 cursor-pointer border border-white/[0.08]"
                title="Sign out of this session to create or sign in with another account"
              >
                <LogOut className="w-3.5 h-3.5" />
                <span>Sign Out</span>
              </button>
            </div>
          </div>
        )}

        {/* Mode Switcher Tabs (shown on standard auth screens) */}
        {mode !== 'reset-confirm' && (
          <div className="flex items-center justify-center bg-slate-950/80 p-1 rounded-2xl border border-white/[0.08]">
            <button
              type="button"
              onClick={() => { setMode('signup'); setError(null); setSuccess(null); }}
              className={`flex-1 py-2.5 text-xs font-bold rounded-xl transition cursor-pointer ${
                mode === 'signup'
                  ? 'bg-blue-600 text-white shadow-md shadow-blue-600/20'
                  : 'text-slate-400 hover:text-white'
              }`}
            >
              Create Student Account
            </button>
            <button
              type="button"
              onClick={() => { setMode('signin'); setError(null); setSuccess(null); }}
              className={`flex-1 py-2.5 text-xs font-bold rounded-xl transition cursor-pointer ${
                mode === 'signin'
                  ? 'bg-blue-600 text-white shadow-md shadow-blue-600/20'
                  : 'text-slate-400 hover:text-white'
              }`}
            >
              Sign In
            </button>
          </div>
        )}

        {/* Mode: Reset Confirmation Banner */}
        {mode === 'reset-confirm' && (
          <div className="bg-blue-950/40 border border-blue-500/30 rounded-2xl p-3.5 flex items-center gap-2.5 text-xs text-blue-200">
            <KeyRound className="w-5 h-5 text-blue-400 shrink-0" />
            <div>
              <span className="font-bold text-white block">Reset Your Account Password</span>
              <span className="text-[11px] text-slate-300">
                Verified reset token active for <span className="font-mono text-blue-300 font-semibold">{email || 'your account'}</span>
              </span>
            </div>
          </div>
        )}

        {/* Administrator Quick Helper Banner in Sign In Mode */}
        {mode === 'signin' && (
          <div className="bg-purple-950/30 border border-purple-500/25 rounded-2xl p-3 flex items-center justify-between text-xs">
            <div className="flex items-center gap-2">
              <ShieldCheck className="w-4 h-4 text-purple-400 shrink-0" />
              <span className="text-slate-300 text-[11px]">
                School Administrator? Use <span className="font-mono text-purple-300 font-semibold">admin@tn10.udhees.com</span>
              </span>
            </div>
            <button
              type="button"
              onClick={() => {
                setEmail('admin@tn10.udhees.com');
                setPassword('');
              }}
              className="text-[10px] text-purple-300 hover:text-purple-200 font-bold underline cursor-pointer shrink-0 ml-2"
            >
              Fill Admin
            </button>
          </div>
        )}

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-4">
          {error && (
            <div className="p-3 bg-rose-500/15 border border-rose-500/30 rounded-xl text-xs text-rose-300 animate-in fade-in space-y-2">
              <div className="flex items-start gap-2">
                <AlertCircle className="w-4 h-4 text-rose-400 shrink-0 mt-0.5" />
                <span className="leading-relaxed">{error}</span>
              </div>
              {resetDirectLink && (
                <div className="pt-2 border-t border-rose-500/20 text-[11px]">
                  <p className="text-slate-300 mb-1.5">Direct Reset Link (while SMTP is being resolved):</p>
                  <a
                    href={resetDirectLink}
                    className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-blue-600 hover:bg-blue-500 text-white rounded-lg font-bold text-[11px] transition shadow-md"
                  >
                    <span>Click Here to Reset Password Now</span>
                    <ArrowRight className="w-3.5 h-3.5" />
                  </a>
                </div>
              )}
            </div>
          )}
          {success && (
            <div className="p-3 bg-emerald-500/15 border border-emerald-500/30 rounded-xl text-xs text-emerald-300 animate-in fade-in space-y-2">
              <div className="flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 shrink-0 text-emerald-400" />
                <span>{success}</span>
              </div>
              {resetDirectLink && (
                <div className="pt-2 border-t border-emerald-500/20 text-[11px]">
                  <p className="text-slate-300 mb-1.5">Direct Reset Link (SMTP unconfigured fallback):</p>
                  <a
                    href={resetDirectLink}
                    className="inline-flex items-center gap-1 px-3 py-1.5 bg-emerald-600 hover:bg-emerald-500 text-white rounded-lg font-bold text-[11px] transition"
                  >
                    <span>Click to Set New Password</span>
                    <ArrowRight className="w-3 h-3" />
                  </a>
                </div>
              )}
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
                  placeholder="e.g. K. Vijay"
                  className="w-full bg-slate-950/80 border border-white/[0.08] rounded-xl pl-10 pr-3 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition"
                />
              </div>
            </div>
          )}

          {mode !== 'reset-confirm' && (
            <div>
              <label className="block text-[11px] font-semibold text-slate-300 mb-1.5">
                {mode === 'signup' ? 'Student Email Address' : 'Email Address'}
              </label>
              <div className="relative">
                <Mail className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  type="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder={mode === 'signup' ? 'student@tn10.udhees.com' : 'your.email@tn10.udhees.com'}
                  className="w-full bg-slate-950/80 border border-white/[0.08] rounded-xl pl-10 pr-3 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition"
                />
              </div>
            </div>
          )}

          {mode !== 'reset' && (
            <div>
              <div className="flex items-center justify-between mb-1.5">
                <label className="text-[11px] font-semibold text-slate-300">
                  {mode === 'reset-confirm' ? 'New Password' : 'Password'}
                </label>
                {mode === 'signin' && (
                  <button
                    type="button"
                    onClick={() => { setMode('reset'); setError(null); setSuccess(null); }}
                    className="text-[10px] text-blue-400 hover:text-blue-300 transition cursor-pointer"
                  >
                    Forgot password?
                  </button>
                )}
              </div>
              <div className="relative">
                <Lock className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder={mode === 'reset-confirm' ? 'At least 6 characters' : '••••••••'}
                  className="w-full bg-slate-950/80 border border-white/[0.08] rounded-xl pl-10 pr-10 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-white transition cursor-pointer"
                  tabIndex={-1}
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
            </div>
          )}

          {mode === 'reset-confirm' && (
            <div>
              <label className="block text-[11px] font-semibold text-slate-300 mb-1.5">Confirm New Password</label>
              <div className="relative">
                <Lock className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  required
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  placeholder="Re-type new password"
                  className="w-full bg-slate-950/80 border border-white/[0.08] rounded-xl pl-10 pr-10 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition"
                />
              </div>
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3.5 bg-gradient-to-r from-blue-600 via-indigo-600 to-blue-500 hover:from-blue-500 hover:to-indigo-500 text-white rounded-xl text-xs font-bold transition shadow-lg shadow-blue-600/25 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50 mt-2"
          >
            {loading ? (
              <>
                <RefreshCw className="w-4 h-4 animate-spin" />
                <span>Processing...</span>
              </>
            ) : (
              <>
                <span>
                  {mode === 'signup'
                    ? 'Create Student Account'
                    : mode === 'signin'
                    ? 'Sign In to Account'
                    : mode === 'reset'
                    ? 'Send Password Reset Link'
                    : 'Set New Password & Sign In'}
                </span>
                <ArrowRight className="w-4 h-4" />
              </>
            )}
          </button>
        </form>

        {/* Footer Navigation */}
        <div className="pt-2 border-t border-white/[0.08] text-center text-xs text-slate-400">
          {mode === 'signup' ? (
            <p>
              Already registered?{' '}
              <button
                type="button"
                onClick={() => { setMode('signin'); setError(null); setSuccess(null); }}
                className="text-blue-400 hover:text-blue-300 font-semibold cursor-pointer ml-1"
              >
                Sign in here
              </button>
            </p>
          ) : mode === 'signin' ? (
            <p>
              First time here?{' '}
              <button
                type="button"
                onClick={() => { setMode('signup'); setError(null); setSuccess(null); }}
                className="text-blue-400 hover:text-blue-300 font-semibold cursor-pointer ml-1"
              >
                Create your student account
              </button>
            </p>
          ) : (
            <button
              type="button"
              onClick={() => { setMode('signin'); setError(null); setSuccess(null); }}
              className="text-blue-400 hover:text-blue-300 font-semibold cursor-pointer inline-flex items-center gap-1"
            >
              <span>Back to sign in</span>
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

export default function AuthPage() {
  return (
    <Suspense fallback={
      <div className="max-w-lg mx-auto my-12 text-center text-slate-400 text-xs">
        <RefreshCw className="w-5 h-5 animate-spin mx-auto mb-2 text-blue-400" />
        Loading authentication console...
      </div>
    }>
      <AuthContent />
    </Suspense>
  );
}
