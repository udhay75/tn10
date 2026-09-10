import { NextRequest, NextResponse } from 'next/server';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import { getAllInMemoryUsers } from '@/lib/auth/in-memory-users';
import crypto from 'crypto';

export const dynamic = 'force-dynamic';
export const revalidate = 0;

function toUuid(id: string): string {
  if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(id)) {
    return id;
  }
  const hash = crypto.createHash('md5').update(id).digest('hex');
  return `${hash.substring(0, 8)}-${hash.substring(8, 12)}-4${hash.substring(13, 16)}-a${hash.substring(17, 20)}-${hash.substring(20, 32)}`;
}

export interface SanitizedAdminUser {
  id: string;
  email: string;
  display_name: string;
  is_admin: boolean;
  class_code: string;
  medium_code: string;
  interface_lang: string;
  completed_activities: number;
  created_at: string;
  updated_at: string | null;
}

export async function GET(req: NextRequest) {
  try {
    // 1. Check MongoDB (Coolify deployment)
    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();

        // Fetch users excluding sensitive credentials
        const rawUsers = await db
          .collection('users')
          .find({}, { projection: { password_hash: 0, salt: 0 } })
          .sort({ created_at: -1 })
          .toArray();

        // Fetch completed activities count per student
        const progressAgg = await db.collection('student_item_progress').aggregate([
          { $match: { completion_status: 'completed' } },
          {
            $group: {
              _id: '$student_id',
              count: { $sum: 1 },
              raw_ids: { $addToSet: '$raw_student_id' }
            }
          }
        ]).toArray();

        const progressMap = new Map<string, number>();
        progressAgg.forEach((entry: any) => {
          if (entry._id) progressMap.set(String(entry._id), entry.count);
          if (Array.isArray(entry.raw_ids)) {
            entry.raw_ids.forEach((rid: string) => {
              if (rid) progressMap.set(String(rid), entry.count);
            });
          }
        });

        // Fetch total platform completed activities
        const totalCompletedActivities = await db
          .collection('student_item_progress')
          .countDocuments({ completion_status: 'completed' })
          .catch(() => 0);

        // Fetch total platform revision records
        const totalRevisions = await db
          .collection('revision_history')
          .countDocuments()
          .catch(() => 0);

        let userList: SanitizedAdminUser[] = rawUsers.map((doc: any) => {
          const docId = doc.id || doc._id?.toString() || '';
          const docUuid = docId ? toUuid(docId) : '';
          const email = (doc.email || '').toLowerCase();

          const completedCount = 
            progressMap.get(docId) || 
            progressMap.get(docUuid) || 
            progressMap.get(email) || 
            0;

          return {
            id: docId,
            email: doc.email || '',
            display_name: doc.display_name || doc.email?.split('@')[0] || 'Student',
            is_admin: Boolean(doc.is_admin),
            class_code: doc.class_code || 'class_10',
            medium_code: doc.medium_code || 'english',
            interface_lang: doc.interface_lang || 'en',
            completed_activities: completedCount,
            created_at: doc.created_at ? new Date(doc.created_at).toISOString() : new Date().toISOString(),
            updated_at: doc.updated_at ? new Date(doc.updated_at).toISOString() : null,
          };
        });

        // Ensure default admin is represented if not yet logged in / inserted
        const hasAdmin = userList.some((u) => u.is_admin || u.email === 'admin@tn10.udhees.com');
        if (!hasAdmin) {
          userList.unshift({
            id: 'admin_default_01',
            email: 'admin@tn10.udhees.com',
            display_name: 'Administrator',
            is_admin: true,
            class_code: 'class_10',
            medium_code: 'english',
            interface_lang: 'en',
            completed_activities: 0,
            created_at: new Date().toISOString(),
            updated_at: null,
          });
        }

        const totalUsers = userList.length;
        const totalAdmins = userList.filter((u) => u.is_admin).length;
        const totalStudents = totalUsers - totalAdmins;

        return NextResponse.json({
          success: true,
          stats: {
            totalUsers,
            totalStudents,
            totalAdmins,
            totalCompletedActivities,
            totalRevisions,
            dbStatus: 'online',
            engine: 'mongodb',
          },
          users: userList,
        });
      } catch (mongoErr: any) {
        console.warn('MongoDB query warning in GET /api/admin/users, falling back:', mongoErr.message);
      }
    }

    // 2. Fallback Mode (Local / In-Memory when MongoDB is offline)
    const inMem = getAllInMemoryUsers();
    let userList: SanitizedAdminUser[] = inMem.map((u) => ({
      id: u.id,
      email: u.email,
      display_name: u.display_name,
      is_admin: u.is_admin,
      class_code: u.class_code,
      medium_code: u.medium_code,
      interface_lang: u.interface_lang,
      completed_activities: 0,
      created_at: u.created_at,
      updated_at: null,
    }));

    // Ensure default admin in fallback list
    if (!userList.some((u) => u.is_admin || u.email === 'admin@tn10.udhees.com')) {
      userList.unshift({
        id: 'admin_default_01',
        email: 'admin@tn10.udhees.com',
        display_name: 'Administrator',
        is_admin: true,
        class_code: 'class_10',
        medium_code: 'english',
        interface_lang: 'en',
        completed_activities: 0,
        created_at: new Date().toISOString(),
        updated_at: null,
      });
    }

    const totalUsers = userList.length;
    const totalAdmins = userList.filter((u) => u.is_admin).length;
    const totalStudents = totalUsers - totalAdmins;

    return NextResponse.json({
      success: true,
      stats: {
        totalUsers,
        totalStudents,
        totalAdmins,
        totalCompletedActivities: 0,
        totalRevisions: 0,
        dbStatus: 'offline',
        engine: 'in-memory',
      },
      users: userList,
    });
  } catch (err: any) {
    console.error('Error in GET /api/admin/users:', err);
    return NextResponse.json(
      { error: err.message || 'Failed to retrieve administrative users data' },
      { status: 500 }
    );
  }
}
