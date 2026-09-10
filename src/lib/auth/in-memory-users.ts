// ============================================================================
// In-Memory User & Admin Store (Local Development & Offline Fallback)
// Used when MongoDB is not directly reachable (e.g., during local testing).
// When MongoDB is connected, MongoDB collections take full precedence.
// ============================================================================

import { StudentProfile } from '@/types';

export interface StoredUser {
  id: string;
  email: string;
  display_name: string;
  password_hash: string;
  salt: string;
  is_admin: boolean;
  class_code: string;
  medium_code: string;
  interface_lang: 'en' | 'ta';
  created_at: string;
}

declare global {
  // eslint-disable-next-line no-var
  var _inMemoryUsersMap: Map<string, StoredUser> | undefined;
  // eslint-disable-next-line no-var
  var _inMemoryAdminPassword: { hash: string; salt: string } | undefined;
}

const usersMap: Map<string, StoredUser> = global._inMemoryUsersMap || new Map();
if (!global._inMemoryUsersMap) {
  global._inMemoryUsersMap = usersMap;
}

export function saveInMemoryUser(user: StoredUser): void {
  usersMap.set(user.email.toLowerCase(), user);
}

export function getInMemoryUser(email: string): StoredUser | undefined {
  return usersMap.get(email.toLowerCase());
}

export function setInMemoryAdminPassword(hash: string, salt: string): void {
  global._inMemoryAdminPassword = { hash, salt };
}

export function getInMemoryAdminPassword(): { hash: string; salt: string } | undefined {
  return global._inMemoryAdminPassword;
}
