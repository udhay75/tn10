import { NextResponse } from 'next/server';
import { queryPostgres } from '@/lib/db/postgres';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';

export const dynamic = 'force-dynamic';

export async function GET() {
  try {
    // 1. MongoDB Mode (Coolify)
    if (isMongoConfigured()) {
      const db = await getMongoDb();
      const progressCount = await db.collection('student_item_progress').countDocuments();
      const revisionCount = await db.collection('revision_history').countDocuments();

      return NextResponse.json({
        status: 'healthy',
        database: 'Coolify MongoDB',
        host: process.env.MONGODB_HOST || 'Coolify MongoDB Service',
        data: {
          total_units: 73,
          total_lessons: 196,
          total_items: 635,
          total_progress_records: progressCount.toString(),
          total_revisions: revisionCount.toString(),
        },
      });
    }

    // 2. PostgreSQL Mode (Local Docker)
    const res = await queryPostgres(`
      SELECT 
        (SELECT count(*) FROM units) as total_units,
        (SELECT count(*) FROM lessons) as total_lessons,
        (SELECT count(*) FROM checklist_items) as total_items,
        (SELECT count(*) FROM student_item_progress) as total_progress_records,
        (SELECT count(*) FROM revision_history) as total_revisions
    `);

    return NextResponse.json({
      status: 'healthy',
      database: 'Docker PostgreSQL (tn10_postgres)',
      host: process.env.PGHOST || 'localhost',
      port: 5432,
      data: res.rows[0],
    });
  } catch (err: any) {
    return NextResponse.json(
      { status: 'error', message: err.message || 'Database connection error' },
      { status: 500 }
    );
  }
}
