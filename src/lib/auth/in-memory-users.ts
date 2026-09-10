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

export interface StoredResetToken {
  email: string;
  token: string;
  expires_at: number;
}

declare global {
  // eslint-disable-next-line no-var
  var _inMemoryUsersMap: Map<string, StoredUser> | undefined;
  // eslint-disable-next-line no-var
  var _inMemoryAdminPassword: { hash: string; salt: string } | undefined;
  // eslint-disable-next-line no-var
  var _inMemoryResetTokens: Map<string, StoredResetToken> | undefined;
}

const usersMap: Map<string, StoredUser> = global._inMemoryUsersMap || new Map();
if (!global._inMemoryUsersMap) {
  global._inMemoryUsersMap = usersMap;
}

const resetTokensMap: Map<string, StoredResetToken> = global._inMemoryResetTokens || new Map();
if (!global._inMemoryResetTokens) {
  global._inMemoryResetTokens = resetTokensMap;
}

export function saveInMemoryUser(user: StoredUser): void {
  usersMap.set(user.email.toLowerCase(), user);
}

export function getInMemoryUser(email: string): StoredUser | undefined {
  return usersMap.get(email.toLowerCase());
}

export function getAllInMemoryUsers(): StoredUser[] {
  return Array.from(usersMap.values());
}

export function updateInMemoryUserPassword(email: string, password_hash: string, salt: string): boolean {
  const existing = usersMap.get(email.toLowerCase());
  if (!existing) return false;
  existing.password_hash = password_hash;
  existing.salt = salt;
  usersMap.set(email.toLowerCase(), existing);
  return true;
}

export function setInMemoryAdminPassword(hash: string, salt: string): void {
  global._inMemoryAdminPassword = { hash, salt };
}

export function getInMemoryAdminPassword(): { hash: string; salt: string } | undefined {
  return global._inMemoryAdminPassword;
}

export function saveInMemoryResetToken(email: string, token: string, expiresInMs = 3600000): void {
  resetTokensMap.set(token, {
    email: email.toLowerCase(),
    token,
    expires_at: Date.now() + expiresInMs,
  });
}

export function getInMemoryResetToken(token: string): StoredResetToken | undefined {
  const found = resetTokensMap.get(token);
  if (!found) return undefined;
  if (Date.now() > found.expires_at) {
    resetTokensMap.delete(token);
    return undefined;
  }
  return found;
}

export function removeInMemoryResetToken(token: string): void {
  resetTokensMap.delete(token);
}
