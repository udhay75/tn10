'use client';

// ============================================================================
// Client-Side Authentication Guard
// Guides first-time visitors to create their student account on /auth.
// Restores instant access for returning students and administrators.
// ============================================================================

import React, { useEffect } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import { useAuth } from '@/lib/auth/auth-context';

export function AuthGuard({ children }: { children: React.ReactNode }) {
  const { user, isLoading } = useAuth();
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    // Routes that can be viewed without a student login
    const isPublicRoute = pathname === '/auth' || pathname === '/admin';

    if (!isLoading && !user && !isPublicRoute) {
      router.replace('/auth');
    }
  }, [user, isLoading, pathname, router]);

  return <>{children}</>;
}
