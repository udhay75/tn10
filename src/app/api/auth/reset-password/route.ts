import { NextRequest, NextResponse } from 'next/server';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import { hashPassword } from '@/lib/auth/password';
import { 
  getInMemoryResetToken, 
  removeInMemoryResetToken, 
  updateInMemoryUserPassword, 
  setInMemoryAdminPassword 
} from '@/lib/auth/in-memory-users';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email, token, new_password } = body;

    if (!email || !token || !new_password) {
      return NextResponse.json(
        { error: 'Email, reset token, and new password are required' },
        { status: 400 }
      );
    }

    if (new_password.length < 6) {
      return NextResponse.json(
        { error: 'New password must be at least 6 characters long' },
        { status: 400 }
      );
    }

    const normalizedEmail = email.trim().toLowerCase();
    let isTokenValid = false;

    // 1. Verify token in MongoDB
    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();
        const resetRecord = await db.collection('password_resets').findOne({
          email: normalizedEmail,
          token: token.trim(),
        });

        if (resetRecord && new Date(resetRecord.expires_at) > new Date()) {
          isTokenValid = true;
        }
      } catch (mongoErr: any) {
        console.warn('MongoDB reset token verification error:', mongoErr.message);
      }
    }

    // 2. Verify token in fallback store
    if (!isTokenValid) {
      const inMem = getInMemoryResetToken(token.trim());
      if (inMem && inMem.email === normalizedEmail) {
        isTokenValid = true;
      }
    }

    if (!isTokenValid) {
      return NextResponse.json(
        { error: 'Invalid or expired password reset link. Please request a new link.' },
        { status: 400 }
      );
    }

    // 3. Hash new password
    const { hash, salt } = hashPassword(new_password);

    // 4. Update in MongoDB
    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();
        await db.collection('users').updateOne(
          { email: normalizedEmail },
          {
            $set: {
              password_hash: hash,
              salt,
              updated_at: new Date(),
            },
          }
        );

        // Invalidate used reset token
        await db.collection('password_resets').deleteOne({ email: normalizedEmail }).catch(() => {});
      } catch (mongoErr: any) {
        console.error('MongoDB password reset update error:', mongoErr);
        return NextResponse.json(
          { error: `Database update failed: ${mongoErr.message}` },
          { status: 500 }
        );
      }
    }

    // 5. Update in fallback store
    updateInMemoryUserPassword(normalizedEmail, hash, salt);
    if (
      normalizedEmail === 'admin@tn10.udhees.com' ||
      normalizedEmail === 'admin.curriculum@tn10.udhees.com'
    ) {
      setInMemoryAdminPassword(hash, salt);
    }
    removeInMemoryResetToken(token.trim());

    return NextResponse.json({
      success: true,
      message: 'Your password has been reset successfully. You can now sign in with your new password.',
    });
  } catch (err: any) {
    console.error('Reset password error:', err);
    return NextResponse.json({ error: err.message || 'Password reset failed' }, { status: 500 });
  }
}
