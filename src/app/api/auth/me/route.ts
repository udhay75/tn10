import { NextRequest, NextResponse } from 'next/server';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import { queryPostgres } from '@/lib/db/postgres';
import { StudentProfile } from '@/types';

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const email = searchParams.get('email');
    const id = searchParams.get('id');

    if (!email && !id) {
      return NextResponse.json({ error: 'Missing email or id parameter' }, { status: 400 });
    }

    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();
        const filter: any = {};
        if (id) filter.$or = [{ id }, { _id: id }];
        else if (email) filter.email = email.trim().toLowerCase();

        const userDoc = await db.collection('users').findOne(filter);
        if (userDoc) {
          const profile: StudentProfile = {
            id: userDoc.id || userDoc._id.toString(),
            display_name: userDoc.display_name,
            email: userDoc.email,
            class_code: userDoc.class_code || 'class_10',
            medium_code: userDoc.medium_code || 'english',
            interface_lang: userDoc.interface_lang || 'en',
            created_at: userDoc.created_at || new Date().toISOString(),
            is_admin: Boolean(userDoc.is_admin),
          };
          return NextResponse.json({ success: true, user: profile });
        }
      } catch (err: any) {
        console.warn('MongoDB /api/auth/me lookup error:', err.message);
      }
    }

    if (email) {
      try {
        const res = await queryPostgres(
          `SELECT id, email, display_name, class_code, medium_code, interface_lang, created_at, is_admin 
           FROM student_profiles WHERE email = $1`,
          [email.trim().toLowerCase()]
        );
        if (res.rows.length > 0) {
          return NextResponse.json({ success: true, user: res.rows[0] });
        }
      } catch {}
    }

    return NextResponse.json({ success: false, message: 'User not found' }, { status: 404 });
  } catch (err: any) {
    return NextResponse.json({ error: err.message }, { status: 500 });
  }
}
