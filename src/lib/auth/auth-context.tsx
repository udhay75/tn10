'use client';

// ============================================================================
// Authentication Context: Seamless Multi-Engine (MongoDB, PostgreSQL & Supabase)
// Supports Coolify MongoDB, Docker PostgreSQL, and Offline PWA operation.
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

// Default Canonical Accounts
export const DEMO_STUDENT: StudentProfile = {
  id: 'demo-student-001',
  display_name: 'Anitha Selvam',
  email: 'anitha.class10@tn10.udhees.com',
  class_code: 'class_10',
  medium_code: 'english',
  interface_lang: 'en',
  created_at: '2024-06-01T08:00:00Z',
  is_admin: false,
};

export const DEMO_ADMIN: StudentProfile = {
  id: 'demo-admin-001',
  display_name: 'K. Ramanathan (Curriculum Admin)',
  email: 'admin.curriculum@tn10.udhees.com',
  class_code: 'class_10',
  medium_code: 'english',
  interface_lang: 'en',
  created_at: '2024-01-15T09:00:00Z',
  is_admin: true,
};

export function AuthProvider({ children }: { children: React.ReactNode }) {
  // Synchronously initialize from localStorage for instant, non-blocking render
  const [user, setUser] = useState<StudentProfile | null>(() => {
    if (typeof window !== 'undefined') {
      try {
        const raw = localStorage.getItem('app_meta_demo_active_user');
        if (raw) {
          const parsed = JSON.parse(raw);
          if (parsed && parsed.id) return parsed;
        }
      } catch {}
    }
    // Default to student so the app is instantly usable offline without null barrier
    return DEMO_STUDENT;
  });

  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    async function initAuth() {
      try {
        if (!isSupabaseConfigured) {
          // MongoDB / Docker / Local PWA Mode
          const savedDemoUser = await getAppMeta('demo_active_user');
          if (savedDemoUser && savedDemoUser.id) {
            setUser(savedDemoUser);
            syncManager.setStudentId(savedDemoUser.id);
          } else {
            // First run or restored session
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
      } catch (err) {
        console.warn('initAuth error, using active student session:', err);
        setUser(DEMO_STUDENT);
        syncManager.setStudentId(DEMO_STUDENT.id);
        setIsLoading(false);
      }
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
      await setAppMeta('demo_active_user', profileObj);
      syncManager.setStudentId(profileObj.id);
    } catch (err) {
      console.error('Error loading Supabase user profile:', err);
    } finally {
      setIsLoading(false);
    }
  }

  const signInDemo = async (role: 'student' | 'admin') => {
    const selected = role === 'admin' ? DEMO_ADMIN : DEMO_STUDENT;
    setUser(selected);
    await setAppMeta('demo_active_user', selected);
    syncManager.setStudentId(selected.id);

    // Also notify MongoDB backend if reachable
    fetch('/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ role }),
    }).catch(() => {});
  };

  const signInWithPassword = async (email: string, pass: string): Promise<{ error?: string }> => {
    const cleanEmail = email.trim();
    if (!cleanEmail || !pass) {
      return { error: 'Please enter both email and password' };
    }

    if (!isSupabaseConfigured) {
      try {
        // Try backend MongoDB / Docker login
        const res = await fetch('/api/auth/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email: cleanEmail, password: pass }),
        });

        const data = await res.json().catch(() => ({}));

        if (!res.ok) {
          return { error: data.error || `Login failed (HTTP ${res.status})` };
        }

        if (data.success && data.user) {
          const authenticatedUser: StudentProfile = data.user;
          setUser(authenticatedUser);
          await setAppMeta('demo_active_user', authenticatedUser);
          syncManager.setStudentId(authenticatedUser.id);
          return {};
        }
      } catch (networkErr: any) {
        console.warn('Backend login unreachable, falling back to local session:', networkErr.message);
      }

      // Offline PWA Fallback
      const isTeacher = cleanEmail.toLowerCase().includes('admin') || cleanEmail.toLowerCase().includes('teacher');
      const customUser: StudentProfile = {
        id: `usr_${cleanEmail.replace(/[^a-z0-9]/gi, '')}`,
        display_name: cleanEmail.split('@')[0],
        email: cleanEmail,
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

    const { error } = await supabase.auth.signInWithPassword({ email: cleanEmail, password: pass });
    if (error) return { error: error.message };
    return {};
  };

  const signUpWithPassword = async (email: string, pass: string, name: string): Promise<{ error?: string }> => {
    const cleanEmail = email.trim();
    if (!cleanEmail || !pass) {
      return { error: 'Please provide email and password' };
    }

    if (!isSupabaseConfigured) {
      try {
        const res = await fetch('/api/auth/signup', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            email: cleanEmail,
            password: pass,
            name: name?.trim() || cleanEmail.split('@')[0],
          }),
        });

        const data = await res.json().catch(() => ({}));

        if (!res.ok) {
          return { error: data.error || `Registration failed (HTTP ${res.status})` };
        }

        if (data.success && data.user) {
          const registeredUser: StudentProfile = data.user;
          setUser(registeredUser);
          await setAppMeta('demo_active_user', registeredUser);
          syncManager.setStudentId(registeredUser.id);
          return {};
        }
      } catch (networkErr: any) {
        console.warn('Backend registration unreachable, falling back to local user:', networkErr.message);
      }

      // Offline PWA Fallback
      const customUser: StudentProfile = {
        id: `usr_${cleanEmail.replace(/[^a-z0-9]/gi, '')}`,
        display_name: name?.trim() || cleanEmail.split('@')[0],
        email: cleanEmail,
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
      email: cleanEmail,
      password: pass,
      options: {
        data: { display_name: name },
      },
    });

    if (error) return { error: error.message };
    if (data.user) {
      await supabase.from('student_profiles').insert({
        id: data.user.id,
        display_name: name,
        email: cleanEmail,
        class_code: 'class_10',
        medium_code: 'english',
        interface_lang: 'en',
      });
    }

    return {};
  };

  const resetPassword = async (email: string): Promise<{ error?: string }> => {
    if (!isSupabaseConfigured) {
      return {}; // Always succeeds in demo/MongoDB mode
    }
    const supabase = getSupabaseClient();
    if (!supabase) return { error: 'Database not initialized' };
    const { error } = await supabase.auth.resetPasswordForEmail(email);
    if (error) return { error: error.message };
    return {};
  };

  const signOut = async (options?: { discardUnsynced?: boolean }) => {
    if (user) {
      await clearStudentAccountData(user.id);
    }

    await setAppMeta('demo_active_user', null);
    if (typeof window !== 'undefined') {
      try {
        localStorage.removeItem('app_meta_demo_active_user');
      } catch {}
    }

    if (isSupabaseConfigured) {
      const supabase = getSupabaseClient();
      if (supabase) {
        await supabase.auth.signOut();
      }
    }

    setUser(null);
    syncManager.setStudentId(null);
  };

  const updateProfile = async (updates: Partial<StudentProfile>) => {
    if (!user) return;
    const updated = { ...user, ...updates };
    setUser(updated);
    await setAppMeta('demo_active_user', updated);

    // Sync updates to MongoDB / backend
    if (!isSupabaseConfigured) {
      fetch('/api/auth/signup', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email: updated.email,
          password: 'TN10_DEFAULT_SECRET',
          name: updated.display_name,
          class_code: updated.class_code,
          medium_code: updated.medium_code,
        }),
      }).catch(() => {});
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
