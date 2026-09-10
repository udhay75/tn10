'use client';

// ============================================================================
// Authentication Context: Seamless Dual Mode (Supabase Auth & Local Demo Auth)
// Isolates user accounts and securely handles sign-in, sign-up, role management,
// and safe logout data purging.
// ============================================================================

import React, { createContext, useContext, useEffect, useState } from 'react';
import { StudentProfile } from '@/types';
import { getSupabaseClient, isSupabaseConfigured } from '@/lib/supabase/client';
import { clearStudentAccountData, getAppMeta, setAppMeta } from '@/lib/db/indexeddb';
import { syncManager } from '@/lib/sync/sync-manager';

interface AuthContextType {
  user: StudentProfile | null;
  isLoading: boolean;
  isAdmin: boolean;
  isDemoMode: boolean;
  signInDemo: (role: 'student' | 'admin') => Promise<void>;
  signInWithPassword: (email: string, pass: string) => Promise<{ error?: string }>;
  signUpWithPassword: (email: string, pass: string, name: string) => Promise<{ error?: string }>;
  resetPassword: (email: string) => Promise<{ error?: string }>;
  signOut: (options?: { discardUnsynced?: boolean }) => Promise<void>;
  updateProfile: (updates: Partial<StudentProfile>) => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// Default Demo Accounts
const DEMO_STUDENT: StudentProfile = {
  id: 'demo-student-001',
  display_name: 'Anitha Selvam',
  email: 'anitha.class10@tnschools.gov.in',
  class_code: 'class_10',
  medium_code: 'english',
  interface_lang: 'en',
  created_at: '2024-06-01T08:00:00Z',
  is_admin: false,
};

const DEMO_ADMIN: StudentProfile = {
  id: 'demo-admin-001',
  display_name: 'K. Ramanathan (Curriculum Admin)',
  email: 'admin.curriculum@tnschools.gov.in',
  class_code: 'class_10',
  medium_code: 'english',
  interface_lang: 'en',
  created_at: '2024-01-15T09:00:00Z',
  is_admin: true,
};

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<StudentProfile | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    async function initAuth() {
      if (!isSupabaseConfigured) {
        // Local Demo Mode
        const savedDemoUser = await getAppMeta('demo_active_user');
        if (savedDemoUser) {
          setUser(savedDemoUser);
          syncManager.setStudentId(savedDemoUser.id);
        } else {
          // Default to student on first boot
          setUser(DEMO_STUDENT);
          await setAppMeta('demo_active_user', DEMO_STUDENT);
          syncManager.setStudentId(DEMO_STUDENT.id);
        }
        setIsLoading(false);
        return;
      }

      // Supabase Mode
      const supabase = getSupabaseClient();
      if (!supabase) {
        setIsLoading(false);
        return;
      }

      const { data: { session } } = await supabase.auth.getSession();
      if (session?.user) {
        await loadSupabaseProfile(session.user.id, session.user.email || '');
      } else {
        setUser(null);
        syncManager.setStudentId(null);
        setIsLoading(false);
      }

      const { data: authListener } = supabase.auth.onAuthStateChange(async (event, session) => {
        if (session?.user) {
          await loadSupabaseProfile(session.user.id, session.user.email || '');
        } else {
          setUser(null);
          syncManager.setStudentId(null);
          setIsLoading(false);
        }
      });

      return () => {
        authListener.subscription.unsubscribe();
      };
    }

    initAuth();
  }, []);

  async function loadSupabaseProfile(userId: string, email: string) {
    const supabase = getSupabaseClient();
    if (!supabase) return;

    try {
      const { data: profile } = await supabase
        .from('student_profiles')
        .select('*')
        .eq('id', userId)
        .single();

      const { data: adminRole } = await supabase
        .from('admin_roles')
        .select('role')
        .eq('user_id', userId)
        .maybeSingle();

      const profileObj: StudentProfile = {
        id: userId,
        display_name: profile?.display_name || email.split('@')[0],
        email: email,
        class_code: profile?.class_code || 'class_10',
        medium_code: profile?.medium_code || 'english',
        interface_lang: profile?.interface_lang || 'en',
        created_at: profile?.created_at || new Date().toISOString(),
        is_admin: Boolean(adminRole),
      };

      setUser(profileObj);
      syncManager.setStudentId(profileObj.id);
    } catch (err) {
      console.error('Error loading user profile:', err);
    } finally {
      setIsLoading(false);
    }
  }

  const signInDemo = async (role: 'student' | 'admin') => {
    const selected = role === 'admin' ? DEMO_ADMIN : DEMO_STUDENT;
    setUser(selected);
    await setAppMeta('demo_active_user', selected);
    syncManager.setStudentId(selected.id);
  };

  const signInWithPassword = async (email: string, pass: string): Promise<{ error?: string }> => {
    if (!isSupabaseConfigured) {
      // Demo authentication simulation
      const isTeacher = email.toLowerCase().includes('admin') || email.toLowerCase().includes('teacher');
      const customUser: StudentProfile = {
        id: `demo-user-${email.replace(/[^a-z0-9]/gi, '')}`,
        display_name: email.split('@')[0],
        email,
        class_code: 'class_10',
        medium_code: 'english',
        interface_lang: 'en',
        created_at: new Date().toISOString(),
        is_admin: isTeacher,
      };
      setUser(customUser);
      await setAppMeta('demo_active_user', customUser);
      syncManager.setStudentId(customUser.id);
      return {};
    }

    const supabase = getSupabaseClient();
    if (!supabase) return { error: 'Database not initialized' };

    const { error } = await supabase.auth.signInWithPassword({ email, password: pass });
    if (error) return { error: error.message };
    return {};
  };

  const signUpWithPassword = async (email: string, pass: string, name: string): Promise<{ error?: string }> => {
    if (!isSupabaseConfigured) {
      const customUser: StudentProfile = {
        id: `demo-user-${email.replace(/[^a-z0-9]/gi, '')}`,
        display_name: name || email.split('@')[0],
        email,
        class_code: 'class_10',
        medium_code: 'english',
        interface_lang: 'en',
        created_at: new Date().toISOString(),
        is_admin: false,
      };
      setUser(customUser);
      await setAppMeta('demo_active_user', customUser);
      syncManager.setStudentId(customUser.id);
      return {};
    }

    const supabase = getSupabaseClient();
    if (!supabase) return { error: 'Database not initialized' };

    const { data, error } = await supabase.auth.signUp({
      email,
      password: pass,
      options: {
        data: { display_name: name },
      },
    });

    if (error) return { error: error.message };
    if (data.user) {
      // Create student profile record
      await supabase.from('student_profiles').insert({
        id: data.user.id,
        display_name: name,
        email: email,
        class_code: 'class_10',
        medium_code: 'english',
        interface_lang: 'en',
      });
    }

    return {};
  };

  const resetPassword = async (email: string): Promise<{ error?: string }> => {
    if (!isSupabaseConfigured) {
      return {}; // Always succeeds in demo mode
    }
    const supabase = getSupabaseClient();
    if (!supabase) return { error: 'Database not initialized' };
    const { error } = await supabase.auth.resetPasswordForEmail(email);
    if (error) return { error: error.message };
    return {};
  };

  const signOut = async (options?: { discardUnsynced?: boolean }) => {
    if (user) {
      // Strict Account Isolation: Purge local cache and sync queue for this account
      await clearStudentAccountData(user.id);
    }

    if (!isSupabaseConfigured) {
      await setAppMeta('demo_active_user', null);
      setUser(null);
      syncManager.setStudentId(null);
      return;
    }

    const supabase = getSupabaseClient();
    if (supabase) {
      await supabase.auth.signOut();
    }
    setUser(null);
    syncManager.setStudentId(null);
  };

  const updateProfile = async (updates: Partial<StudentProfile>) => {
    if (!user) return;
    const updated = { ...user, ...updates };
    setUser(updated);

    if (!isSupabaseConfigured) {
      await setAppMeta('demo_active_user', updated);
      return;
    }

    const supabase = getSupabaseClient();
    if (supabase) {
      await supabase
        .from('student_profiles')
        .update({
          display_name: updated.display_name,
          interface_lang: updated.interface_lang,
          class_code: updated.class_code,
          medium_code: updated.medium_code,
          updated_at: new Date().toISOString(),
        })
        .eq('id', user.id);
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        isLoading,
        isAdmin: Boolean(user?.is_admin),
        isDemoMode: !isSupabaseConfigured,
        signInDemo,
        signInWithPassword,
        signUpWithPassword,
        resetPassword,
        signOut,
        updateProfile,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
