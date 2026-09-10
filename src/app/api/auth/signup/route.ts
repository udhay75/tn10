import { NextRequest, NextResponse } from 'next/server';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import { queryPostgres } from '@/lib/db/postgres';
import { hashPassword } from '@/lib/auth/password';
import { saveInMemoryUser } from '@/lib/auth/in-memory-users';
import { StudentProfile } from '@/types';
import crypto from 'crypto';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email, password, name, class_code = 'class_10', medium_code = 'english' } = body;

    if (!email || !password) {
      return NextResponse.json({ error: 'Email and password are required' }, { status: 400 });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const isTeacher = normalizedEmail.includes('admin') || normalizedEmail.includes('teacher');
    const studentUuid = crypto.randomUUID();
    const { hash, salt } = hashPassword(password);

    const userProfile: StudentProfile = {
      id: studentUuid,
      display_name: name?.trim() || normalizedEmail.split('@')[0],
      email: normalizedEmail,
      class_code,
      medium_code,
      interface_lang: 'en',
      created_at: new Date().toISOString(),
      is_admin: isTeacher,
    };

    // 1. MongoDB Mode (Coolify)
    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();
        const existing = await db.collection('users').findOne({ email: normalizedEmail });
        if (existing) {
          // Update password if existing
          await db.collection('users').updateOne(
            { email: normalizedEmail },
            { 
              $set: { 
                password_hash: hash, 
                salt, 
                display_name: userProfile.display_name,
                class_code,
                medium_code,
                updated_at: new Date() 
              } 
            }
          );
          return NextResponse.json({ 
            success: true, 
            user: { 
              ...userProfile, 
              id: existing.id || existing._id.toString(),
              created_at: existing.created_at || userProfile.created_at 
            } 
          });
        }

        await db.collection('users').insertOne({
          ...userProfile,
          password_hash: hash,
          salt,
        });

        return NextResponse.json({ success: true, user: userProfile });
      } catch (mongoErr: any) {
        console.warn('MongoDB signup error, falling back:', mongoErr.message);
      }
    }

    // 2. PostgreSQL Mode (Local Docker) fallback
    try {
      await queryPostgres(
        `INSERT INTO auth.users (id, email) VALUES ($1, $2) ON CONFLICT (id) DO NOTHING`,
        [studentUuid, normalizedEmail]
      );
      await queryPostgres(
        `INSERT INTO student_profiles (id, email, display_name, class_code, medium_code, interface_lang, is_admin)
         VALUES ($1, $2, $3, $4, $5, $6, $7)
         ON CONFLICT (id) DO UPDATE SET display_name = EXCLUDED.display_name`,
        [studentUuid, normalizedEmail, userProfile.display_name, class_code, medium_code, 'en', isTeacher]
      );
    } catch {
      // PostgreSQL not connected, fall through
    }

    // 3. In-Memory Store for fallback
    saveInMemoryUser({
      id: userProfile.id,
      email: normalizedEmail,
      display_name: userProfile.display_name,
      password_hash: hash,
      salt: salt,
      is_admin: Boolean(userProfile.is_admin),
      class_code: userProfile.class_code,
      medium_code: userProfile.medium_code,
      interface_lang: userProfile.interface_lang,
      created_at: userProfile.created_at,
    });

    return NextResponse.json({ success: true, user: userProfile });
  } catch (err: any) {
    console.error('Signup error:', err);
    return NextResponse.json({ error: err.message || 'Registration failed' }, { status: 500 });
  }
}
