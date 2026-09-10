'use client';

// ============================================================================
// Admin Curriculum Console & Security Management
// Implements 5-step PDF import workflow + Admin Account & Password Management.
// Enforces strict admin-only access and persistent database updates.
// ============================================================================

import React, { useState, useEffect } from 'react';
import Link from 'next/link';
import { 
  ShieldAlert, 
  Upload, 
  FileCheck, 
  AlertCircle, 
  CheckCircle2, 
  Edit3, 
  Eye, 
  EyeOff,
  RefreshCw, 
  Save, 
  ShieldCheck, 
  BookOpen,
  ArrowRight,
  Sparkles,
  KeyRound,
  Lock,
  Mail,
  Layers,
  Users,
  GraduationCap,
  Activity,
  Database,
  Search,
  X,
  Calendar,
  Filter
} from 'lucide-react';
import { useAuth } from '@/lib/auth/auth-context';
import { useI18n } from '@/lib/i18n/i18n-context';
import { useStudy } from '@/lib/store/study-context';
import { 
  createExtractionDraftFromPdf, 
  publishCurriculumDraft 
} from '@/lib/curriculum/import-workflow';
import { DraftChecklistItem, CurriculumDraft } from '@/types';
import { cacheCurriculum } from '@/lib/db/indexeddb';

export interface AdminUser {
  id: string;
  email: string;
  display_name: string;
  is_admin: boolean;
  class_code: string;
  medium_code: string;
  interface_lang: string;
  completed_activities: number;
  created_at: string;
  updated_at: string | null;
}

export interface PlatformStats {
  totalUsers: number;
  totalStudents: number;
  totalAdmins: number;
  totalCompletedActivities: number;
  totalRevisions: number;
  dbStatus: 'online' | 'offline';
  engine: string;
}

export default function AdminPage() {
  const { user, isAdmin } = useAuth();
  const { t, lang } = useI18n();
  const { curriculum, availableSubjects } = useStudy();

  // Platform Analytics & User Directory State
  const [usersList, setUsersList] = useState<AdminUser[]>([]);
  const [platformStats, setPlatformStats] = useState<PlatformStats | null>(null);
  const [usersLoading, setUsersLoading] = useState<boolean>(true);
  const [usersError, setUsersError] = useState<string | null>(null);
  const [searchUserQuery, setSearchUserQuery] = useState<string>('');
  const [roleFilter, setRoleFilter] = useState<'all' | 'students' | 'admins'>('all');

  const fetchAdminUsers = async () => {
    setUsersLoading(true);
    setUsersError(null);
    try {
      const res = await fetch('/api/admin/users');
      const data = await res.json();
      if (res.ok && data.success) {
        setUsersList(data.users || []);
        setPlatformStats(data.stats || null);
      } else {
        setUsersError(data.error || 'Failed to load user analytics');
      }
    } catch (err: any) {
      setUsersError(err.message || 'Network error fetching user statistics');
    } finally {
      setUsersLoading(false);
    }
  };

  useEffect(() => {
    if (isAdmin) {
      fetchAdminUsers();
    }
  }, [isAdmin]);

  const filteredUsers = usersList.filter((u) => {
    const matchesRole = 
      roleFilter === 'all' 
        ? true 
        : roleFilter === 'admins' 
        ? u.is_admin 
        : !u.is_admin;

    const query = searchUserQuery.trim().toLowerCase();
    const matchesSearch = 
      !query || 
      u.email.toLowerCase().includes(query) || 
      u.display_name.toLowerCase().includes(query) ||
      u.class_code.toLowerCase().includes(query) ||
      u.medium_code.toLowerCase().includes(query);

    return matchesRole && matchesSearch;
  });

  // Admin Password Management State
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPasswords, setShowPasswords] = useState(false);
  const [passwordStatus, setPasswordStatus] = useState<{
    type: 'idle' | 'loading' | 'success' | 'error';
    message: string;
  }>({ type: 'idle', message: '' });

  // Curriculum PDF Import State
  const [activeDraft, setActiveDraft] = useState<CurriculumDraft | null>(null);
  const [draftItems, setDraftItems] = useState<DraftChecklistItem[]>([]);
  const [isExtracting, setIsExtracting] = useState(false);
  const [publishSuccess, setPublishSuccess] = useState(false);
  const [filterNeedsReview, setFilterNeedsReview] = useState(false);
  const [editingItemId, setEditingItemId] = useState<string | null>(null);
  const [editForm, setEditForm] = useState<{ label: string; section_name: string; printed_page: number }>({
    label: '',
    section_name: '',
    printed_page: 0,
  });

  // Handle Admin Password Change
  const handleChangePassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setPasswordStatus({ type: 'idle', message: '' });

    if (!currentPassword || !newPassword || !confirmPassword) {
      setPasswordStatus({ type: 'error', message: 'Please fill in all password fields.' });
      return;
    }

    if (newPassword.length < 6) {
      setPasswordStatus({ type: 'error', message: 'New password must be at least 6 characters.' });
      return;
    }

    if (newPassword !== confirmPassword) {
      setPasswordStatus({ type: 'error', message: 'New passwords do not match. Please re-type.' });
      return;
    }

    setPasswordStatus({ type: 'loading', message: 'Updating password in database...' });

    try {
      const res = await fetch('/api/admin/change-password', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email: user?.email || 'admin@tn10.udhees.com',
          current_password: currentPassword,
          new_password: newPassword,
        }),
      });

      const data = await res.json().catch(() => ({}));

      if (!res.ok) {
        setPasswordStatus({
          type: 'error',
          message: data.error || `Update failed (HTTP ${res.status})`,
        });
        return;
      }

      setPasswordStatus({
        type: 'success',
        message: data.message || 'Administrator password successfully updated in database.',
      });
      setCurrentPassword('');
      setNewPassword('');
      setConfirmPassword('');
    } catch (err: any) {
      setPasswordStatus({
        type: 'error',
        message: err.message || 'Failed to update administrator password',
      });
    }
  };

  // Guard: Admin role required
  if (!isAdmin) {
    return (
      <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-8 max-w-lg mx-auto text-center space-y-5 my-10 shadow-2xl backdrop-blur-xl">
        <div className="w-14 h-14 rounded-2xl bg-purple-500/10 text-purple-400 border border-purple-500/30 flex items-center justify-center mx-auto shadow-lg shadow-purple-500/20">
          <ShieldAlert className="w-7 h-7" />
        </div>
        
        <div>
          <h2 className="text-xl font-bold text-white">Administrator Access Required</h2>
          <p className="text-xs text-slate-400 leading-relaxed mt-1">
            Curriculum management, PDF imports, and edition publishing are restricted to authorized school administrators and textbook coordinators.
          </p>
        </div>

        {/* Default Admin Account Card for Fresh Installs */}
        <div className="bg-slate-950/70 p-4 rounded-2xl border border-white/[0.08] text-left text-xs space-y-2">
          <div className="flex items-center gap-1.5 text-purple-400 font-bold text-[11px] uppercase tracking-wider">
            <KeyRound className="w-3.5 h-3.5" />
            <span>Default Administrator Account</span>
          </div>
          <div className="flex items-center justify-between text-slate-400 text-xs py-1 border-b border-white/[0.05]">
            <span>Email:</span>
            <code className="text-blue-300 font-bold font-mono">admin@tn10.udhees.com</code>
          </div>
          <div className="flex items-center justify-between text-slate-400 text-xs py-1">
            <span>Default Password:</span>
            <code className="text-amber-300 font-bold font-mono">Admin@TN10</code>
          </div>
          <p className="text-[10px] text-slate-500 pt-1 leading-normal">
            💡 Sign in with this default account. You will then be prompted to update your password in the Admin Console.
          </p>
        </div>

        <div className="pt-1">
          <Link
            href="/auth?admin=true"
            className="w-full py-3 px-4 bg-purple-600 hover:bg-purple-500 text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-2 cursor-pointer shadow-lg shadow-purple-600/25"
          >
            <ShieldCheck className="w-4 h-4" />
            <span>Sign In as Administrator</span>
            <ArrowRight className="w-4 h-4" />
          </Link>
        </div>
      </div>
    );
  }

  // Step 1 & 2: PDF extraction draft simulation
  const handleExtractFromPdf = async () => {
    setIsExtracting(true);
    setPublishSuccess(false);
    try {
      const result = await createExtractionDraftFromPdf('Class_10_English_2024_Edition.pdf', 67108864);
      setActiveDraft(result.draft);
      setDraftItems(result.draftItems);
    } catch (err) {
      console.error('Extraction error:', err);
    } finally {
      setIsExtracting(false);
    }
  };

  // Step 4: Inline Edit
  const handleStartEdit = (item: DraftChecklistItem) => {
    setEditingItemId(item.id);
    setEditForm({
      label: item.label,
      section_name: item.section_name,
      printed_page: item.printed_page,
    });
  };

  const handleSaveEdit = (itemId: string) => {
    setDraftItems((prev) =>
      prev.map((item) => {
        if (item.id === itemId) {
          return {
            ...item,
            label: editForm.label,
            section_name: editForm.section_name,
            printed_page: Number(editForm.printed_page),
            pdf_page: Number(editForm.printed_page) + 4,
            needs_review: false,
            confidence_score: 1.0,
          };
        }
        return item;
      })
    );
    setEditingItemId(null);
  };

  // Step 5: Publish Approved Curriculum (preserves student progress)
  const handlePublishCurriculum = async () => {
    if (!activeDraft || draftItems.length === 0) return;
    const updated = publishCurriculumDraft(curriculum, draftItems);
    await cacheCurriculum(updated);
    setPublishSuccess(true);
  };

  const displayItems = filterNeedsReview
    ? draftItems.filter((i) => i.needs_review)
    : draftItems;

  return (
    <div className="space-y-6 animate-in fade-in duration-300 max-w-5xl mx-auto">
      {/* Top Banner: Administrator Console Identity */}
      <div className="bg-gradient-to-r from-purple-950/50 via-slate-900 to-slate-900 border border-purple-500/30 rounded-3xl p-6 sm:p-8 shadow-xl">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <ShieldCheck className="w-5 h-5 text-purple-400" />
            <span className="text-xs font-bold text-purple-300 uppercase tracking-wider">
              Administrator Security & Curriculum Console
            </span>
          </div>
          <span className="px-2.5 py-0.5 rounded-full bg-purple-500/20 text-purple-300 border border-purple-500/30 text-[11px] font-bold">
            Admin Verified
          </span>
        </div>
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight mt-2">
          School Curriculum & System Administration
        </h1>
        <p className="text-xs sm:text-sm text-slate-300 mt-2 max-w-2xl leading-relaxed">
          Logged in as <span className="font-mono text-purple-300 font-bold">{user?.email}</span>. Manage curriculum editions, review PDF extraction drafts, and maintain administrator credentials.
        </p>

        <div className="mt-4 inline-flex items-center gap-2 bg-emerald-500/10 text-emerald-300 border border-emerald-500/30 px-3 py-1.5 rounded-xl text-xs font-semibold">
          <CheckCircle2 className="w-4 h-4" />
          <span>Non-destructive updates: Student marks, understanding scores and revision histories are strictly preserved.</span>
        </div>
      </div>

      {/* SECTION: Platform Telemetry & System Analytics Bento Grid */}
      <div className="space-y-3">
        <div className="flex items-center justify-between px-1">
          <div className="flex items-center gap-2">
            <Activity className="w-4 h-4 text-purple-400" />
            <h2 className="text-sm font-bold text-white uppercase tracking-wider">
              Platform Telemetry & Live Metrics
            </h2>
          </div>
          <button
            onClick={fetchAdminUsers}
            disabled={usersLoading}
            className="inline-flex items-center gap-1.5 text-xs text-purple-400 hover:text-purple-300 font-medium cursor-pointer transition disabled:opacity-50"
            title="Refresh statistics and user list"
          >
            <RefreshCw className={`w-3.5 h-3.5 ${usersLoading ? 'animate-spin' : ''}`} />
            <span>Sync Data</span>
          </button>
        </div>

        <div className="grid grid-cols-2 lg:grid-cols-5 gap-3">
          {/* Card 1: Total Registered Users */}
          <div className="bg-slate-900/90 border border-slate-800 rounded-2xl p-4 shadow-sm relative overflow-hidden group hover:border-slate-700 transition">
            <div className="flex items-center justify-between mb-2">
              <span className="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Total Users</span>
              <div className="w-7 h-7 rounded-lg bg-blue-500/10 text-blue-400 border border-blue-500/20 flex items-center justify-center">
                <Users className="w-3.5 h-3.5" />
              </div>
            </div>
            <div className="text-2xl font-black text-white tracking-tight">
              {usersLoading && !platformStats ? '...' : (platformStats?.totalUsers ?? usersList.length)}
            </div>
            <div className="text-[10px] text-slate-500 mt-1 flex items-center gap-1">
              <span>All registered accounts</span>
            </div>
          </div>

          {/* Card 2: Enrolled Students */}
          <div className="bg-slate-900/90 border border-slate-800 rounded-2xl p-4 shadow-sm relative overflow-hidden group hover:border-slate-700 transition">
            <div className="flex items-center justify-between mb-2">
              <span className="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Students</span>
              <div className="w-7 h-7 rounded-lg bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 flex items-center justify-center">
                <GraduationCap className="w-3.5 h-3.5" />
              </div>
            </div>
            <div className="text-2xl font-black text-white tracking-tight">
              {usersLoading && !platformStats ? '...' : (platformStats?.totalStudents ?? 0)}
            </div>
            <div className="text-[10px] text-emerald-400/80 mt-1 flex items-center gap-1">
              <span>Active learners</span>
            </div>
          </div>

          {/* Card 3: Administrators */}
          <div className="bg-slate-900/90 border border-slate-800 rounded-2xl p-4 shadow-sm relative overflow-hidden group hover:border-slate-700 transition">
            <div className="flex items-center justify-between mb-2">
              <span className="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Admins</span>
              <div className="w-7 h-7 rounded-lg bg-purple-500/10 text-purple-400 border border-purple-500/20 flex items-center justify-center">
                <ShieldCheck className="w-3.5 h-3.5" />
              </div>
            </div>
            <div className="text-2xl font-black text-white tracking-tight">
              {usersLoading && !platformStats ? '...' : (platformStats?.totalAdmins ?? 1)}
            </div>
            <div className="text-[10px] text-purple-400/80 mt-1 flex items-center gap-1">
              <span>Authorized staff</span>
            </div>
          </div>

          {/* Card 4: Learning Activities Completed */}
          <div className="bg-slate-900/90 border border-slate-800 rounded-2xl p-4 shadow-sm relative overflow-hidden group hover:border-slate-700 transition">
            <div className="flex items-center justify-between mb-2">
              <span className="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Activities Done</span>
              <div className="w-7 h-7 rounded-lg bg-amber-500/10 text-amber-400 border border-amber-500/20 flex items-center justify-center">
                <CheckCircle2 className="w-3.5 h-3.5" />
              </div>
            </div>
            <div className="text-2xl font-black text-amber-400 tracking-tight">
              {usersLoading && !platformStats ? '...' : (platformStats?.totalCompletedActivities ?? 0)}
            </div>
            <div className="text-[10px] text-slate-500 mt-1 flex items-center gap-1">
              <span>Across all subjects</span>
            </div>
          </div>

          {/* Card 5: Database Connection & Health */}
          <div className="col-span-2 sm:col-span-1 bg-slate-900/90 border border-slate-800 rounded-2xl p-4 shadow-sm relative overflow-hidden group hover:border-slate-700 transition">
            <div className="flex items-center justify-between mb-2">
              <span className="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Database</span>
              <div className={`w-7 h-7 rounded-lg ${platformStats?.dbStatus === 'online' ? 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20' : 'bg-blue-500/10 text-blue-400 border-blue-500/20'} border flex items-center justify-center`}>
                <Database className="w-3.5 h-3.5" />
              </div>
            </div>
            <div className="flex items-center gap-2">
              <span className={`w-2 h-2 rounded-full ${platformStats?.dbStatus === 'online' ? 'bg-emerald-400' : 'bg-blue-400'} animate-pulse`}></span>
              <span className="text-sm font-bold text-white capitalize">
                {platformStats?.engine === 'mongodb' ? 'MongoDB' : 'In-Memory'}
              </span>
            </div>
            <div className="text-[10px] text-slate-400 mt-1 flex items-center gap-1">
              <span className="truncate">
                {platformStats?.totalRevisions ?? 0} revisions tracked
              </span>
            </div>
          </div>
        </div>
      </div>

      {/* SECTION: Registered Students & User Directory */}
      <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-6 shadow-sm space-y-4">
        {/* Header & Controls */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-800">
          <div>
            <div className="flex items-center gap-2">
              <Users className="w-4 h-4 text-purple-400" />
              <h2 className="text-base font-bold text-white">Learner & User Directory</h2>
              <span className="text-xs px-2 py-0.5 rounded-full bg-purple-500/20 text-purple-300 font-bold border border-purple-500/30">
                {filteredUsers.length}
              </span>
            </div>
            <p className="text-xs text-slate-400 mt-0.5">
              Live accounts registered in the platform database with activity progress and study medium.
            </p>
          </div>

          <div className="flex flex-col sm:flex-row sm:items-center gap-2.5">
            {/* Search Box */}
            <div className="relative">
              <Search className="w-3.5 h-3.5 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
              <input
                type="search"
                inputMode="search"
                autoComplete="off"
                autoCorrect="off"
                autoCapitalize="off"
                spellCheck={false}
                data-lpignore="true"
                data-form-type="other"
                value={searchUserQuery}
                onChange={(e) => setSearchUserQuery(e.target.value)}
                placeholder="Search by name, email..."
                className="w-full sm:w-56 bg-slate-950 border border-white/[0.08] rounded-xl pl-8 pr-8 py-2 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-purple-500 transition"
              />
              {searchUserQuery && (
                <button
                  onClick={() => setSearchUserQuery('')}
                  className="absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-white"
                >
                  <X className="w-3 h-3" />
                </button>
              )}
            </div>

            {/* Filter Tabs */}
            <div className="flex items-center p-1 bg-slate-950 rounded-xl border border-white/[0.06] text-xs">
              <button
                onClick={() => setRoleFilter('all')}
                className={`px-2.5 py-1 rounded-lg font-medium transition cursor-pointer ${
                  roleFilter === 'all'
                    ? 'bg-purple-600 text-white shadow-sm'
                    : 'text-slate-400 hover:text-slate-200'
                }`}
              >
                All ({usersList.length})
              </button>
              <button
                onClick={() => setRoleFilter('students')}
                className={`px-2.5 py-1 rounded-lg font-medium transition cursor-pointer ${
                  roleFilter === 'students'
                    ? 'bg-purple-600 text-white shadow-sm'
                    : 'text-slate-400 hover:text-slate-200'
                }`}
              >
                Students ({platformStats?.totalStudents ?? 0})
              </button>
              <button
                onClick={() => setRoleFilter('admins')}
                className={`px-2.5 py-1 rounded-lg font-medium transition cursor-pointer ${
                  roleFilter === 'admins'
                    ? 'bg-purple-600 text-white shadow-sm'
                    : 'text-slate-400 hover:text-slate-200'
                }`}
              >
                Admins ({platformStats?.totalAdmins ?? 0})
              </button>
            </div>
          </div>
        </div>

        {/* Directory Table */}
        <div className="overflow-x-auto rounded-2xl border border-white/[0.06] bg-slate-950/50">
          <table className="w-full text-left text-xs border-collapse">
            <thead className="bg-slate-950 text-slate-400 sticky top-0 uppercase text-[10px] tracking-wider border-b border-slate-800">
              <tr>
                <th className="p-3.5">User</th>
                <th className="p-3.5">Role</th>
                <th className="p-3.5">Class & Medium</th>
                <th className="p-3.5 text-center">Activities Completed</th>
                <th className="p-3.5">Joined Date</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800/60 font-sans">
              {usersLoading && usersList.length === 0 ? (
                <tr>
                  <td colSpan={5} className="p-8 text-center text-slate-400">
                    <div className="flex flex-col items-center justify-center gap-2">
                      <RefreshCw className="w-5 h-5 text-purple-400 animate-spin" />
                      <span>Loading registered users from database...</span>
                    </div>
                  </td>
                </tr>
              ) : filteredUsers.length === 0 ? (
                <tr>
                  <td colSpan={5} className="p-8 text-center text-slate-400">
                    <div className="flex flex-col items-center justify-center gap-2">
                      <Users className="w-6 h-6 text-slate-600" />
                      <span className="font-semibold text-slate-300">No users found</span>
                      <span className="text-[11px] text-slate-500">
                        {searchUserQuery ? `No user matches "${searchUserQuery}"` : 'No accounts registered yet.'}
                      </span>
                    </div>
                  </td>
                </tr>
              ) : (
                filteredUsers.map((item) => {
                  const initials = (item.display_name || item.email || 'ST')
                    .slice(0, 2)
                    .toUpperCase();
                  const isCurrentAdmin = item.email.toLowerCase() === (user?.email || '').toLowerCase();

                  return (
                    <tr key={item.id || item.email} className="hover:bg-slate-800/40 transition">
                      {/* User Avatar + Details */}
                      <td className="p-3.5">
                        <div className="flex items-center gap-3">
                          <div className={`w-8 h-8 rounded-xl flex items-center justify-center font-bold text-[11px] shrink-0 ${
                            item.is_admin 
                              ? 'bg-purple-600/30 text-purple-300 border border-purple-500/40' 
                              : 'bg-blue-600/20 text-blue-300 border border-blue-500/30'
                          }`}>
                            {initials}
                          </div>
                          <div className="min-w-0">
                            <div className="flex items-center gap-1.5">
                              <span className="font-semibold text-white truncate">{item.display_name}</span>
                              {isCurrentAdmin && (
                                <span className="text-[10px] font-bold px-1.5 py-0.2 rounded bg-purple-500/20 text-purple-300">
                                  You
                                </span>
                              )}
                            </div>
                            <span className="text-[11px] text-slate-400 font-mono block truncate">
                              {item.email}
                            </span>
                          </div>
                        </div>
                      </td>

                      {/* Role Badge */}
                      <td className="p-3.5">
                        {item.is_admin ? (
                          <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg bg-purple-500/15 text-purple-300 border border-purple-500/30 font-bold text-[11px]">
                            <ShieldCheck className="w-3 h-3 text-purple-400" />
                            <span>Administrator</span>
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg bg-blue-500/15 text-blue-300 border border-blue-500/30 font-semibold text-[11px]">
                            <GraduationCap className="w-3 h-3 text-blue-400" />
                            <span>Student</span>
                          </span>
                        )}
                      </td>

                      {/* Class & Medium */}
                      <td className="p-3.5 text-slate-300">
                        <span className="capitalize font-medium block">
                          {item.class_code.replace('_', ' ')}
                        </span>
                        <span className="text-[11px] text-slate-400 capitalize block">
                          {item.medium_code} Medium ({item.interface_lang?.toUpperCase() || 'EN'})
                        </span>
                      </td>

                      {/* Completed Activities */}
                      <td className="p-3.5 text-center">
                        <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-lg font-bold text-[11px] ${
                          item.completed_activities > 0 
                            ? 'bg-emerald-500/15 text-emerald-300 border border-emerald-500/30' 
                            : 'bg-slate-800/80 text-slate-400 border border-slate-700'
                        }`}>
                          <CheckCircle2 className="w-3 h-3" />
                          <span>{item.completed_activities} done</span>
                        </span>
                      </td>

                      {/* Registration Date */}
                      <td className="p-3.5 text-slate-400 text-[11px]">
                        <div className="flex items-center gap-1.5">
                          <Calendar className="w-3.5 h-3.5 text-slate-500 shrink-0" />
                          <span>
                            {item.created_at ? new Date(item.created_at).toLocaleDateString('en-IN', {
                              day: 'numeric',
                              month: 'short',
                              year: 'numeric'
                            }) : 'Default'}
                          </span>
                        </div>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>

        {/* Footer info */}
        <div className="flex items-center justify-between text-[11px] text-slate-500 pt-1">
          <span>Showing {filteredUsers.length} of {usersList.length} total registered accounts</span>
          <span>Automatic sync with Coolify MongoDB</span>
        </div>
      </div>

      {/* SECTION 1: Administrator Password & Account Security */}
      <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-6 shadow-sm space-y-4">
        <div className="flex items-center justify-between pb-3 border-b border-slate-800">
          <div className="flex items-center gap-2.5">
            <div className="w-9 h-9 rounded-xl bg-purple-600/20 text-purple-300 border border-purple-500/30 flex items-center justify-center">
              <KeyRound className="w-4 h-4 text-purple-400" />
            </div>
            <div>
              <h2 className="text-base font-bold text-white">Administrator Account Security</h2>
              <p className="text-xs text-slate-400">
                Change default admin password (`Admin@TN10`) to a secure password saved directly to MongoDB.
              </p>
            </div>
          </div>
        </div>

        {/* Security Warning Banner */}
        <div className="bg-amber-950/30 border border-amber-500/30 rounded-2xl p-3.5 flex items-start gap-3 text-xs text-amber-200">
          <AlertCircle className="w-4 h-4 text-amber-400 shrink-0 mt-0.5" />
          <div>
            <span className="font-bold text-amber-300 block mb-0.5">Deployment Security Notice</span>
            <span>
              If this instance was recently installed, please change the default administrator password immediately. Once updated, the default password is completely deactivated.
            </span>
          </div>
        </div>

        {/* Password Feedback */}
        {passwordStatus.type === 'error' && (
          <div className="p-3 bg-rose-500/15 border border-rose-500/30 rounded-xl text-xs text-rose-300 flex items-center gap-2">
            <AlertCircle className="w-4 h-4 text-rose-400 shrink-0" />
            <span>{passwordStatus.message}</span>
          </div>
        )}
        {passwordStatus.type === 'success' && (
          <div className="p-3 bg-emerald-500/15 border border-emerald-500/30 rounded-xl text-xs text-emerald-300 flex items-center gap-2">
            <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
            <span>{passwordStatus.message}</span>
          </div>
        )}

        {/* Password Form */}
        <form onSubmit={handleChangePassword} className="space-y-4 pt-1">
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
            <div>
              <label className="block text-[11px] font-semibold text-slate-300 mb-1.5">Current Password</label>
              <div className="relative">
                <Lock className="w-3.5 h-3.5 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                <input
                  type={showPasswords ? 'text' : 'password'}
                  required
                  value={currentPassword}
                  onChange={(e) => setCurrentPassword(e.target.value)}
                  placeholder="e.g. Admin@TN10"
                  className="w-full bg-slate-950 border border-white/[0.08] rounded-xl pl-9 pr-3 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-purple-500 transition"
                />
              </div>
            </div>

            <div>
              <label className="block text-[11px] font-semibold text-slate-300 mb-1.5">New Password</label>
              <div className="relative">
                <Lock className="w-3.5 h-3.5 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                <input
                  type={showPasswords ? 'text' : 'password'}
                  required
                  value={newPassword}
                  onChange={(e) => setNewPassword(e.target.value)}
                  placeholder="At least 6 characters"
                  className="w-full bg-slate-950 border border-white/[0.08] rounded-xl pl-9 pr-3 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-purple-500 transition"
                />
              </div>
            </div>

            <div>
              <label className="block text-[11px] font-semibold text-slate-300 mb-1.5">Confirm New Password</label>
              <div className="relative">
                <Lock className="w-3.5 h-3.5 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
                <input
                  type={showPasswords ? 'text' : 'password'}
                  required
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  placeholder="Re-type new password"
                  className="w-full bg-slate-950 border border-white/[0.08] rounded-xl pl-9 pr-3 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-purple-500 transition"
                />
              </div>
            </div>
          </div>

          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-1">
            <button
              type="button"
              onClick={() => setShowPasswords(!showPasswords)}
              className="inline-flex items-center gap-1.5 text-xs text-slate-400 hover:text-slate-200 cursor-pointer"
            >
              {showPasswords ? <EyeOff className="w-3.5 h-3.5" /> : <Eye className="w-3.5 h-3.5" />}
              <span>{showPasswords ? 'Hide password characters' : 'Show password characters'}</span>
            </button>

            <button
              type="submit"
              disabled={passwordStatus.type === 'loading'}
              className="px-5 py-2.5 bg-purple-600 hover:bg-purple-500 disabled:opacity-50 text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-2 cursor-pointer shadow-md shadow-purple-600/20 shrink-0"
            >
              {passwordStatus.type === 'loading' ? (
                <>
                  <RefreshCw className="w-3.5 h-3.5 animate-spin" />
                  <span>Saving...</span>
                </>
              ) : (
                <>
                  <Save className="w-3.5 h-3.5" />
                  <span>Update Admin Password</span>
                </>
              )}
            </button>
          </div>
        </form>
      </div>

      {/* SECTION 2: 5 Canonical Subjects System Overview */}
      <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-6 shadow-sm space-y-3">
        <div className="flex items-center justify-between pb-2 border-b border-slate-800">
          <div className="flex items-center gap-2">
            <Layers className="w-4 h-4 text-blue-400" />
            <h2 className="text-base font-bold text-white">Active Canonical Curriculum Standards</h2>
          </div>
          <span className="text-xs text-slate-400 font-semibold">5 Official Board Subjects</span>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-5 gap-3 pt-1">
          {availableSubjects.map((sub) => (
            <div key={sub.code} className="bg-slate-950/70 p-3.5 rounded-2xl border border-white/[0.06] space-y-1.5">
              <div className="flex items-center justify-between">
                <span className="text-lg">{sub.icon}</span>
                <span className="text-[10px] font-bold px-1.5 py-0.5 rounded bg-blue-500/10 text-blue-300 border border-blue-500/20">
                  {sub.edition}
                </span>
              </div>
              <div>
                <span className="text-xs font-bold text-white block">{sub.title}</span>
                <span className="text-[10px] text-slate-400">
                  {sub.unitsCount} Units • {sub.itemsCount} Activities
                </span>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* SECTION 3: Active Textbook & Extraction */}
      <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-6 shadow-sm flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <span className="text-xs font-bold text-slate-400 uppercase tracking-wide block mb-1">
            {t.admin.currentEdition}
          </span>
          <h2 className="text-lg font-bold text-white">
            {curriculum.subject.title} • {curriculum.subject.textbook.title} ({curriculum.subject.textbook.edition})
          </h2>
          <p className="text-xs text-slate-400 mt-1">
            Source: <code className="text-blue-400">{curriculum.subject.textbook.source_file}</code> • {curriculum.summary.total_units} Units • {curriculum.summary.total_lessons} Lessons • {curriculum.summary.total_checklist_items} Activities
          </p>
        </div>

        <button
          onClick={handleExtractFromPdf}
          disabled={isExtracting}
          className="px-5 py-2.5 bg-blue-600 hover:bg-blue-500 disabled:opacity-50 text-white rounded-xl text-xs font-bold transition flex items-center justify-center gap-2 cursor-pointer shadow-md shrink-0"
        >
          {isExtracting ? (
            <>
              <RefreshCw className="w-4 h-4 animate-spin" />
              <span>Parsing PDF...</span>
            </>
          ) : (
            <>
              <Upload className="w-4 h-4" />
              <span>Run PDF Extraction Draft</span>
            </>
          )}
        </button>
      </div>

      {/* Publish Success Alert */}
      {publishSuccess && (
        <div className="bg-emerald-950/40 border border-emerald-500/40 p-4 rounded-2xl text-xs text-emerald-200 flex items-center justify-between gap-3 animate-in zoom-in-95">
          <div className="flex items-center gap-2 font-bold text-emerald-300">
            <CheckCircle2 className="w-5 h-5" />
            <span>Curriculum successfully approved and published! All student progress preserved.</span>
          </div>
          <Link href="/curriculum" className="text-xs font-bold text-white underline">
            View Live Curriculum
          </Link>
        </div>
      )}

      {/* SECTION 4: Extraction Draft Review Area */}
      {activeDraft && (
        <div className="bg-slate-900/90 border border-slate-800 rounded-3xl p-6 shadow-sm space-y-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-4 border-b border-slate-800">
            <div>
              <div className="flex items-center gap-2">
                <span className="text-xs font-bold px-2 py-0.5 rounded bg-purple-500/10 text-purple-300 border border-purple-500/30 uppercase">
                  Draft #{activeDraft.id.slice(-6)}
                </span>
                <span className="text-xs text-slate-400">
                  Total Items: {draftItems.length}
                </span>
              </div>
              <h3 className="text-base font-bold text-white mt-1">
                Draft Review & Confidence Scoring
              </h3>
            </div>

            <div className="flex items-center gap-2">
              <button
                onClick={() => setFilterNeedsReview(!filterNeedsReview)}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition cursor-pointer border ${
                  filterNeedsReview 
                    ? 'bg-amber-600/20 text-amber-300 border-amber-500/40' 
                    : 'bg-slate-800 text-slate-400 border-slate-700 hover:text-white'
                }`}
              >
                Flagged for Review ({draftItems.filter((i) => i.needs_review).length})
              </button>

              <button
                onClick={handlePublishCurriculum}
                className="px-4 py-1.5 bg-emerald-600 hover:bg-emerald-500 text-white rounded-xl text-xs font-bold transition shadow-md cursor-pointer flex items-center gap-1.5"
              >
                <CheckCircle2 className="w-4 h-4" />
                <span>{t.admin.publishBtn}</span>
              </button>
            </div>
          </div>

          {/* Items Review Table */}
          <div className="overflow-x-auto max-h-[500px] overflow-y-auto">
            <table className="w-full text-left text-xs border-collapse">
              <thead className="bg-slate-950 text-slate-400 sticky top-0 z-10 uppercase text-[10px] tracking-wider border-b border-slate-800">
                <tr>
                  <th className="p-3">Section</th>
                  <th className="p-3">Exercise Label</th>
                  <th className="p-3">Type</th>
                  <th className="p-3">Book Page</th>
                  <th className="p-3">Confidence</th>
                  <th className="p-3 text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800/60 font-sans">
                {displayItems.map((item) => {
                  const isEditing = editingItemId === item.id;

                  return (
                    <tr key={item.id} className="hover:bg-slate-800/40 transition">
                      <td className="p-3 font-semibold text-slate-300">
                        {isEditing ? (
                          <input
                            type="text"
                            autoComplete="off"
                            autoCorrect="off"
                            spellCheck={false}
                            data-lpignore="true"
                            value={editForm.section_name}
                            onChange={(e) => setEditForm({ ...editForm, section_name: e.target.value })}
                            className="bg-slate-950 border border-slate-700 rounded px-2 py-1 text-xs text-white"
                          />
                        ) : (
                          item.section_name
                        )}
                      </td>
                      <td className="p-3 font-medium text-white max-w-xs">
                        {isEditing ? (
                          <input
                            type="text"
                            autoComplete="off"
                            autoCorrect="off"
                            spellCheck={false}
                            data-lpignore="true"
                            value={editForm.label}
                            onChange={(e) => setEditForm({ ...editForm, label: e.target.value })}
                            className="w-full bg-slate-950 border border-slate-700 rounded px-2 py-1 text-xs text-white"
                          />
                        ) : (
                          <div>
                            <span>{item.label}</span>
                            {item.needs_review && (
                              <span className="block text-[10px] text-amber-400 mt-0.5">
                                ⚠ {item.review_notes}
                              </span>
                            )}
                          </div>
                        )}
                      </td>
                      <td className="p-3">
                        <span className={`px-2 py-0.5 rounded text-[10px] font-bold ${
                          item.item_type === 'source_activity'
                            ? 'bg-blue-500/15 text-blue-300'
                            : 'bg-emerald-500/15 text-emerald-300'
                        }`}>
                          {item.item_type}
                        </span>
                      </td>
                      <td className="p-3 text-slate-400">
                        {isEditing ? (
                          <input
                            type="number"
                            autoComplete="off"
                            data-lpignore="true"
                            value={editForm.printed_page}
                            onChange={(e) => setEditForm({ ...editForm, printed_page: Number(e.target.value) })}
                            className="w-16 bg-slate-950 border border-slate-700 rounded px-2 py-1 text-xs text-white"
                          />
                        ) : (
                          <span>p. {item.printed_page} (PDF {item.pdf_page})</span>
                        )}
                      </td>
                      <td className="p-3">
                        <span className={`text-[11px] font-bold ${
                          item.confidence_score >= 0.9 ? 'text-emerald-400' : 'text-amber-400'
                        }`}>
                          {Math.round(item.confidence_score * 100)}%
                        </span>
                      </td>
                      <td className="p-3 text-right">
                        {isEditing ? (
                          <button
                            onClick={() => handleSaveEdit(item.id)}
                            className="px-2.5 py-1 bg-emerald-600 text-white rounded text-[11px] font-bold hover:bg-emerald-500 transition"
                          >
                            Save
                          </button>
                        ) : (
                          <button
                            onClick={() => handleStartEdit(item)}
                            className="p-1.5 text-slate-400 hover:text-blue-400 transition"
                            title="Edit Item"
                          >
                            <Edit3 className="w-3.5 h-3.5" />
                          </button>
                        )}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}
