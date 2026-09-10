import { NextRequest, NextResponse } from 'next/server';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import { queryPostgres } from '@/lib/db/postgres';
import { verifyPassword } from '@/lib/auth/password';
import { StudentProfile } from '@/types';

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

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email, password, role } = body;

    // 1. Explicit Quick Demo Switch
    if (role === 'student' || email === DEMO_STUDENT.email) {
      return NextResponse.json({ success: true, user: DEMO_STUDENT });
    }
    if (role === 'admin' || email === DEMO_ADMIN.email) {
      return NextResponse.json({ success: true, user: DEMO_ADMIN });
    }

    if (!email || !password) {
      return NextResponse.json({ error: 'Email and password are required' }, { status: 400 });
    }

    const normalizedEmail = email.trim().toLowerCase();

    // 2. MongoDB Mode (Coolify)
    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();
        const userDoc = await db.collection('users').findOne({ email: normalizedEmail });

        if (userDoc) {
          if (userDoc.password_hash && userDoc.salt) {
            const isValid = verifyPassword(password, userDoc.password_hash, userDoc.salt);
            if (!isValid) {
              return NextResponse.json({ error: 'Invalid email or password' }, { status: 401 });
            }
          }

          const userProfile: StudentProfile = {
            id: userDoc.id || userDoc._id.toString(),
            display_name: userDoc.display_name || userDoc.email.split('@')[0],
            email: userDoc.email,
            class_code: userDoc.class_code || 'class_10',
            medium_code: userDoc.medium_code || 'english',
            interface_lang: userDoc.interface_lang || 'en',
            created_at: userDoc.created_at || new Date().toISOString(),
            is_admin: Boolean(userDoc.is_admin),
          };

          return NextResponse.json({ success: true, user: userProfile });
        } else {
          // If user doesn't exist in MongoDB yet, auto-create student account for seamless onboarding
          const isTeacher = normalizedEmail.includes('admin') || normalizedEmail.includes('teacher');
          const cleanId = `student_${normalizedEmail.replace(/[^a-z0-9]/gi, '_')}`;
          const newDoc = {
            id: cleanId,
            email: normalizedEmail,
            display_name: normalizedEmail.split('@')[0],
            class_code: 'class_10',
            medium_code: 'english',
            interface_lang: 'en',
            is_admin: isTeacher,
            created_at: new Date().toISOString(),
          };

          await db.collection('users').insertOne(newDoc).catch(() => {});

          return NextResponse.json({ success: true, user: newDoc });
        }
      } catch (mongoErr: any) {
        console.warn('MongoDB auth query error, falling back:', mongoErr.message);
      }
    }

    // 3. PostgreSQL Mode (Local Docker) fallback
    try {
      const res = await queryPostgres(
        `SELECT id, email, display_name, class_code, medium_code, interface_lang, created_at, is_admin 
         FROM student_profiles WHERE email = $1`,
        [normalizedEmail]
      );
      if (res.rows.length > 0) {
        return NextResponse.json({ success: true, user: res.rows[0] });
      }
    } catch {
      // PostgreSQL not connected, fall through to resilient local demo user
    }

    // 4. Resilient Fallback Profile
    const isTeacher = normalizedEmail.includes('admin') || normalizedEmail.includes('teacher');
    const fallbackUser: StudentProfile = {
      id: `usr_${normalizedEmail.replace(/[^a-z0-9]/gi, '')}`,
      display_name: normalizedEmail.split('@')[0],
      email: normalizedEmail,
      class_code: 'class_10',
      medium_code: 'english',
      interface_lang: 'en',
      created_at: new Date().toISOString(),
      is_admin: isTeacher,
    };

    return NextResponse.json({ success: true, user: fallbackUser });
  } catch (err: any) {
    console.error('Login error:', err);
    return NextResponse.json({ error: err.message || 'Authentication failed' }, { status: 500 });
  }
}
