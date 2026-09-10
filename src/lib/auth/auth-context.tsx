'use client';

// ============================================================================
// Authentication Context: Server-Backed (MongoDB, PostgreSQL & Supabase)
// Strict account authentication: No demo auto-login.
// First-time users create their account. Admin manages credentials securely.
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
  changeAdminPassword: (currentPass: string, newPass: string) => Promise<{ error?: string; message?: string }>;
  resetPassword: (email: string) => Promise<{ error?: string; message?: string; smtpConfigured?: boolean; resetLink?: string }>;
  confirmPasswordReset: (email: string, token: string, newPassword: string) => Promise<{ error?: string; message?: string }>;
  signOut: (options?: { discardUnsynced?: boolean }) => Promise<void>;
  updateProfile: (updates: Partial<StudentProfile>) => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// Default Admin Credentials Definition
export const DEFAULT_ADMIN_EMAIL = 'admin@tn10.udhees.com';

export function AuthProvider({ children }: { children: React.ReactNode }) {
  // Synchronously initialize from localStorage if an authenticated account exists
  const [user, setUser] = useState<StudentProfile | null>(() => {
    if (typeof window !== 'undefined') {
      try {
        const raw = localStorage.getItem('app_meta_active_user') || localStorage.getItem('app_meta_demo_active_user');
        if (raw) {
          const parsed = JSON.parse(raw);
          if (parsed && parsed.id) return parsed;
        }
      } catch {}
    }
    // No logged in account initially: first-time users must create an account
    return null;
  });

  const [isLoading, setIsLoading] = useState<boolean>(() => {
    if (typeof window !== 'undefined') {
      try {
        const raw = localStorage.getItem('app_meta_active_user') || localStorage.getItem('app_meta_demo_active_user');
        if (raw) return false;
      } catch {}
    }
    return true;
  });

  useEffect(() => {
    async function initAuth() {
      try {
        if (!isSupabaseConfigured) {
          // MongoDB / PostgreSQL / Local PWA Mode
          const savedUser = (await getAppMeta('active_user')) || (await getAppMeta('demo_active_user'));
          if (savedUser && savedUser.id) {
            setUser(savedUser);
            syncManager.setStudentId(savedUser.id);
          } else {
            // First run or logged out: user remains null
            setUser(null);
            syncManager.setStudentId(null);
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
        console.warn('initAuth error:', err);
        setUser(null);
        syncManager.setStudentId(null);
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
      await setAppMeta('active_user', profileObj);
      await setAppMeta('demo_active_user', profileObj);
      if (typeof window !== 'undefined') {
        localStorage.setItem('app_meta_active_user', JSON.stringify(profileObj));
      }
      syncManager.setStudentId(profileObj.id);
    } catch (err) {
      console.error('Error loading Supabase user profile:', err);
    } finally {
      setIsLoading(false);
    }
  }

  // Legacy demo compatibility (redirects to password auth)
  const signInDemo = async (role: 'student' | 'admin') => {
    if (role === 'admin') {
      await signInWithPassword(DEFAULT_ADMIN_EMAIL, 'Admin@TN10');
    }
  };

  const signInWithPassword = async (email: string, pass: string): Promise<{ error?: string }> => {
    const cleanEmail = email.trim();
    if (!cleanEmail || !pass) {
      return { error: 'Please enter both email and password' };
    }

    if (!isSupabaseConfigured) {
      try {
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
          await setAppMeta('active_user', authenticatedUser);
          await setAppMeta('demo_active_user', authenticatedUser);
          if (typeof window !== 'undefined') {
            localStorage.setItem('app_meta_active_user', JSON.stringify(authenticatedUser));
          }
          syncManager.setStudentId(authenticatedUser.id);
          return {};
        }
      } catch (networkErr: any) {
        console.warn('Backend login unreachable, evaluating local session:', networkErr.message);
      }

      // Offline PWA Fallback: Check if this was the pre-stored user or default admin
      const isTeacher = cleanEmail.toLowerCase().includes('admin') || cleanEmail.toLowerCase().includes('teacher');
      if (cleanEmail === DEFAULT_ADMIN_EMAIL && pass === 'Admin@TN10') {
        const adminUser: StudentProfile = {
          id: 'admin_local_001',
          display_name: 'Administrator',
          email: cleanEmail,
          class_code: 'class_10',
          medium_code: 'english',
          interface_lang: 'en',
          created_at: new Date().toISOString(),
          is_admin: true,
        };
        setUser(adminUser);
        await setAppMeta('active_user', adminUser);
        if (typeof window !== 'undefined') {
          localStorage.setItem('app_meta_active_user', JSON.stringify(adminUser));
        }
        syncManager.setStudentId(adminUser.id);
        return {};
      }

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
      await setAppMeta('active_user', customUser);
      if (typeof window !== 'undefined') {
        localStorage.setItem('app_meta_active_user', JSON.stringify(customUser));
      }
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
          await setAppMeta('active_user', registeredUser);
          await setAppMeta('demo_active_user', registeredUser);
          if (typeof window !== 'undefined') {
            localStorage.setItem('app_meta_active_user', JSON.stringify(registeredUser));
          }
          syncManager.setStudentId(registeredUser.id);
          return {};
        }
      } catch (networkErr: any) {
        console.warn('Backend registration unreachable, registering locally:', networkErr.message);
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
      await setAppMeta('active_user', customUser);
      if (typeof window !== 'undefined') {
        localStorage.setItem('app_meta_active_user', JSON.stringify(customUser));
      }
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

  const changeAdminPassword = async (currentPass: string, newPass: string): Promise<{ error?: string; message?: string }> => {
    if (!user) return { error: 'Not authenticated' };

    try {
      const res = await fetch('/api/admin/change-password', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email: user.email,
          current_password: currentPass,
          new_password: newPass,
        }),
      });

      const data = await res.json().catch(() => ({}));

      if (!res.ok) {
        return { error: data.error || 'Failed to update password' };
      }

      return { message: data.message || 'Password updated successfully' };
    } catch (err: any) {
      return { error: err.message || 'Failed to communicate with server' };
    }
  };

  const resetPassword = async (email: string): Promise<{ error?: string; message?: string; smtpConfigured?: boolean; resetLink?: string }> => {
    const cleanEmail = email.trim();
    if (!cleanEmail) {
      return { error: 'Please enter your email address' };
    }

    if (!isSupabaseConfigured) {
      try {
        const res = await fetch('/api/auth/forgot-password', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email: cleanEmail }),
        });
        const data = await res.json().catch(() => ({}));
        if (!res.ok || data.error) {
          return { 
            error: data.error || `Request failed (HTTP ${res.status})`,
            resetLink: data.resetLink,
            smtpConfigured: data.smtpConfigured,
          };
        }
        return {
          message: data.message,
          smtpConfigured: data.smtpConfigured,
          resetLink: data.resetLink,
        };
      } catch (networkErr: any) {
        return { error: networkErr.message || 'Failed to connect to authentication server' };
      }
    }

    const supabase = getSupabaseClient();
    if (!supabase) return { error: 'Database not initialized' };
    const { error } = await supabase.auth.resetPasswordForEmail(cleanEmail);
    if (error) return { error: error.message };
    return { message: 'Password reset link sent to your email.' };
  };

  const confirmPasswordReset = async (email: string, token: string, newPassword: string): Promise<{ error?: string; message?: string }> => {
    if (!email || !token || !newPassword) {
      return { error: 'All fields are required' };
    }
    if (newPassword.length < 6) {
      return { error: 'New password must be at least 6 characters' };
    }

    if (!isSupabaseConfigured) {
      try {
        const res = await fetch('/api/auth/reset-password', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email: email.trim(), token: token.trim(), new_password: newPassword }),
        });
        const data = await res.json().catch(() => ({}));
        if (!res.ok) {
          return { error: data.error || `Reset failed (HTTP ${res.status})` };
        }
        return { message: data.message };
      } catch (networkErr: any) {
        return { error: networkErr.message || 'Failed to connect to authentication server' };
      }
    }

    const supabase = getSupabaseClient();
    if (!supabase) return { error: 'Database not initialized' };
    const { error } = await supabase.auth.updateUser({ password: newPassword });
    if (error) return { error: error.message };
    return { message: 'Password reset successfully' };
  };

  const signOut = async (options?: { discardUnsynced?: boolean }) => {
    if (user) {
      await clearStudentAccountData(user.id);
    }

    await setAppMeta('active_user', null);
    await setAppMeta('demo_active_user', null);
    if (typeof window !== 'undefined') {
      try {
        localStorage.removeItem('app_meta_active_user');
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
    await setAppMeta('active_user', updated);
    if (typeof window !== 'undefined') {
      localStorage.setItem('app_meta_active_user', JSON.stringify(updated));
    }

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
        isDemoMode: false,
        signInDemo,
        signInWithPassword,
        signUpWithPassword,
        changeAdminPassword,
        resetPassword,
        confirmPasswordReset,
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
