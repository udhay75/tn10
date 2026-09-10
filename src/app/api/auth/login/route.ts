import { NextRequest, NextResponse } from 'next/server';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import { queryPostgres } from '@/lib/db/postgres';
import { verifyPassword, hashPassword } from '@/lib/auth/password';
import { getInMemoryUser, getInMemoryAdminPassword } from '@/lib/auth/in-memory-users';
import { StudentProfile } from '@/types';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email, password } = body;

    if (!email || !password) {
      return NextResponse.json({ error: 'Email and password are required' }, { status: 400 });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const isAdminEmail = 
      normalizedEmail === 'admin@tn10.udhees.com' || 
      normalizedEmail === 'admin.curriculum@tn10.udhees.com';

    // 1. MongoDB Mode (Coolify)
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
            interface_lang: (userDoc.interface_lang as 'en' | 'ta') || 'en',
            created_at: userDoc.created_at || new Date().toISOString(),
            is_admin: Boolean(userDoc.is_admin),
          };

          return NextResponse.json({ 
            success: true, 
            user: userProfile,
            isDefaultPassword: Boolean(userDoc.is_default_password)
          });
        } else {
          // Fresh Install Default Admin Seeding
          if (isAdminEmail) {
            if (password === 'Admin@TN10') {
              const { hash, salt } = hashPassword('Admin@TN10');
              const defaultAdminDoc = {
                id: `admin_${normalizedEmail.replace(/[^a-z0-9]/gi, '_')}`,
                email: normalizedEmail,
                display_name: 'Administrator',
                class_code: 'class_10',
                medium_code: 'english',
                interface_lang: 'en',
                is_admin: true,
                password_hash: hash,
                salt,
                is_default_password: true,
                created_at: new Date().toISOString(),
              };

              await db.collection('users').insertOne(defaultAdminDoc).catch(() => {});

              const adminProfile: StudentProfile = {
                id: defaultAdminDoc.id,
                display_name: defaultAdminDoc.display_name,
                email: defaultAdminDoc.email,
                class_code: defaultAdminDoc.class_code,
                medium_code: defaultAdminDoc.medium_code,
                interface_lang: 'en',
                created_at: defaultAdminDoc.created_at,
                is_admin: true,
              };

              return NextResponse.json({ 
                success: true, 
                user: adminProfile,
                isDefaultPassword: true 
              });
            } else {
              return NextResponse.json({ error: 'Invalid email or password' }, { status: 401 });
            }
          }

          // Non-admin user not found: must create an account
          return NextResponse.json(
            { error: 'No account found with this email. Please create an account first.' }, 
            { status: 401 }
          );
        }
      } catch (mongoErr: any) {
        console.warn('MongoDB auth query error, falling back:', mongoErr.message);
      }
    }

    // 2. PostgreSQL Mode (Local Docker) fallback
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
      // PostgreSQL not connected
    }

    // 3. Fallback for Default Admin in Local / Offline environments
    if (isAdminEmail) {
      const inMemAdmin = getInMemoryAdminPassword();
      let isValidAdmin = false;
      let isDefault = false;

      if (inMemAdmin) {
        isValidAdmin = verifyPassword(password, inMemAdmin.hash, inMemAdmin.salt);
      } else {
        isValidAdmin = password === 'Admin@TN10';
        isDefault = true;
      }

      if (isValidAdmin) {
        const offlineAdmin: StudentProfile = {
          id: 'admin_offline_001',
          display_name: 'Administrator',
          email: normalizedEmail,
          class_code: 'class_10',
          medium_code: 'english',
          interface_lang: 'en',
          created_at: new Date().toISOString(),
          is_admin: true,
        };
        return NextResponse.json({ success: true, user: offlineAdmin, isDefaultPassword: isDefault });
      } else {
        return NextResponse.json({ error: 'Invalid email or password' }, { status: 401 });
      }
    }

    // 4. Fallback for In-Memory Students
    const inMemStudent = getInMemoryUser(normalizedEmail);
    if (inMemStudent) {
      const isValidStudent = verifyPassword(password, inMemStudent.password_hash, inMemStudent.salt);
      if (isValidStudent) {
        const studentProfile: StudentProfile = {
          id: inMemStudent.id,
          display_name: inMemStudent.display_name,
          email: inMemStudent.email,
          class_code: inMemStudent.class_code,
          medium_code: inMemStudent.medium_code,
          interface_lang: inMemStudent.interface_lang,
          created_at: inMemStudent.created_at,
          is_admin: inMemStudent.is_admin,
        };
        return NextResponse.json({ success: true, user: studentProfile });
      } else {
        return NextResponse.json({ error: 'Invalid email or password' }, { status: 401 });
      }
    }

    return NextResponse.json(
      { error: 'Invalid email or password. Please verify your credentials or create an account.' },
      { status: 401 }
    );
  } catch (err: any) {
    console.error('Login error:', err);
    return NextResponse.json({ error: err.message || 'Authentication failed' }, { status: 500 });
  }
}
