import { NextRequest, NextResponse } from 'next/server';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import { queryPostgres } from '@/lib/db/postgres';
import { hashPassword, verifyPassword } from '@/lib/auth/password';
import { getInMemoryAdminPassword, setInMemoryAdminPassword } from '@/lib/auth/in-memory-users';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email, current_password, new_password } = body;

    if (!email || !current_password || !new_password) {
      return NextResponse.json(
        { error: 'Email, current password, and new password are required' },
        { status: 400 }
      );
    }

    const normalizedEmail = email.trim().toLowerCase();

    if (new_password.length < 6) {
      return NextResponse.json(
        { error: 'New password must be at least 6 characters long' },
        { status: 400 }
      );
    }

    // 1. Check MongoDB (Coolify)
    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();
        const userDoc = await db.collection('users').findOne({ email: normalizedEmail });

        let isCurrentValid = false;

        if (userDoc && userDoc.password_hash && userDoc.salt) {
          isCurrentValid = verifyPassword(current_password, userDoc.password_hash, userDoc.salt);
        } else if (
          normalizedEmail === 'admin@tn10.udhees.com' || 
          normalizedEmail === 'admin.curriculum@tn10.udhees.com'
        ) {
          // Fresh install default password fallback
          isCurrentValid = current_password === 'Admin@TN10';
        }

        if (!isCurrentValid) {
          return NextResponse.json(
            { error: 'Current password is incorrect' },
            { status: 400 }
          );
        }

        // Hash new password
        const { hash, salt } = hashPassword(new_password);

        await db.collection('users').updateOne(
          { email: normalizedEmail },
          {
            $set: {
              password_hash: hash,
              salt: salt,
              is_admin: true,
              is_default_password: false,
              updated_at: new Date(),
            },
            $setOnInsert: {
              id: `admin_${normalizedEmail.replace(/[^a-z0-9]/gi, '_')}`,
              email: normalizedEmail,
              display_name: 'Administrator',
              class_code: 'class_10',
              medium_code: 'english',
              interface_lang: 'en',
              created_at: new Date().toISOString(),
            },
          },
          { upsert: true }
        );

        return NextResponse.json({
          success: true,
          message: 'Admin password updated successfully. Please use your new password for future logins.',
        });
      } catch (mongoErr: any) {
        console.error('MongoDB change-password error:', mongoErr);
        return NextResponse.json(
          { error: `Database update failed: ${mongoErr.message}` },
          { status: 500 }
        );
      }
    }

    // 2. Fallback Mode (Local / In-Memory when MongoDB is offline)
    const inMemAdmin = getInMemoryAdminPassword();
    let isCurrentValid = false;
    if (inMemAdmin) {
      isCurrentValid = verifyPassword(current_password, inMemAdmin.hash, inMemAdmin.salt);
    } else {
      isCurrentValid = current_password === 'Admin@TN10';
    }

    if (!isCurrentValid) {
      return NextResponse.json(
        { error: 'Current password is incorrect' },
        { status: 400 }
      );
    }

    const { hash, salt } = hashPassword(new_password);
    setInMemoryAdminPassword(hash, salt);

    try {
      await queryPostgres(
        `UPDATE student_profiles SET is_admin = true WHERE email = $1`,
        [normalizedEmail]
      ).catch(() => {});
    } catch {}

    return NextResponse.json({
      success: true,
      message: 'Admin password updated successfully.',
    });
  } catch (err: any) {
    console.error('Change password route error:', err);
    return NextResponse.json(
      { error: err.message || 'Password update failed' },
      { status: 500 }
    );
  }
}
