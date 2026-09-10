import { NextRequest, NextResponse } from 'next/server';
import { queryPostgres } from '@/lib/db/postgres';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import crypto from 'crypto';

function toUuid(id: string): string {
  // If already standard UUID format
  if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(id)) {
    return id;
  }
  const hash = crypto.createHash('md5').update(id).digest('hex');
  return `${hash.substring(0, 8)}-${hash.substring(8, 12)}-4${hash.substring(13, 16)}-a${hash.substring(17, 20)}-${hash.substring(20, 32)}`;
}

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const rawStudentId = searchParams.get('student_id');
    if (!rawStudentId) {
      return NextResponse.json({ error: 'Missing student_id parameter' }, { status: 400 });
    }

    const studentUuid = toUuid(rawStudentId);

    // 1. MongoDB Mode (Coolify)
    if (isMongoConfigured()) {
      const db = await getMongoDb();
      const records = await db.collection('student_item_progress')
        .find({ student_id: studentUuid })
        .project({ _id: 0 })
        .toArray();
      return NextResponse.json(records);
    }

    // 2. PostgreSQL Mode (Local Docker)
    const res = await queryPostgres(
      `SELECT item_code, completion_status, understanding_status, study_again,
              personal_notes, notes_updated_at, last_studied_at, next_revision_date,
              sync_version, updated_at
       FROM student_item_progress
       WHERE student_id = $1`,
      [studentUuid]
    );

    return NextResponse.json(res.rows);
  } catch (err: any) {
    return NextResponse.json({ error: err.message }, { status: 500 });
  }
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { 
      student_id, 
      item_code, 
      completion_status, 
      understanding_status, 
      study_again, 
      personal_notes,
      notes_updated_at,
      last_studied_at,
      next_revision_date
    } = body;

    if (!student_id || !item_code) {
      return NextResponse.json({ error: 'student_id and item_code are required' }, { status: 400 });
    }

    const studentUuid = toUuid(student_id);

    // 1. MongoDB Mode (Coolify)
    if (isMongoConfigured()) {
      const db = await getMongoDb();
      const now = new Date();
      const record = {
        student_id: studentUuid,
        item_code,
        completion_status: completion_status || 'not_started',
        understanding_status: understanding_status || 'not_assessed',
        study_again: Boolean(study_again),
        personal_notes: personal_notes || '',
        notes_updated_at: notes_updated_at ? new Date(notes_updated_at) : null,
        last_studied_at: last_studied_at ? new Date(last_studied_at) : now,
        next_revision_date: next_revision_date ? new Date(next_revision_date) : null,
        updated_at: now
      };

      await db.collection('student_item_progress').updateOne(
        { student_id: studentUuid, item_code },
        { 
          $set: record,
          $inc: { sync_version: 1 }
        },
        { upsert: true }
      );

      return NextResponse.json({ success: true, record });
    }

    // 2. PostgreSQL Mode (Local Docker)
    await queryPostgres(
      `INSERT INTO auth.users (id, email) VALUES ($1, $2) ON CONFLICT (id) DO NOTHING`,
      [studentUuid, `${student_id}@tn10.local`]
    );

    const query = `
      INSERT INTO student_item_progress (
        student_id, item_code, completion_status, understanding_status,
        study_again, personal_notes, notes_updated_at, last_studied_at,
        next_revision_date, sync_version, updated_at
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, 1, NOW())
      ON CONFLICT (student_id, item_code) DO UPDATE SET
        completion_status = EXCLUDED.completion_status,
        understanding_status = EXCLUDED.understanding_status,
        study_again = EXCLUDED.study_again,
        personal_notes = EXCLUDED.personal_notes,
        notes_updated_at = EXCLUDED.notes_updated_at,
        last_studied_at = EXCLUDED.last_studied_at,
        next_revision_date = EXCLUDED.next_revision_date,
        sync_version = student_item_progress.sync_version + 1,
        updated_at = NOW()
      RETURNING *;
    `;

    const res = await queryPostgres(query, [
      studentUuid,
      item_code,
      completion_status || 'not_started',
      understanding_status || 'not_assessed',
      Boolean(study_again),
      personal_notes || '',
      notes_updated_at ? new Date(notes_updated_at) : null,
      last_studied_at ? new Date(last_studied_at) : new Date(),
      next_revision_date ? new Date(next_revision_date) : null,
    ]);

    return NextResponse.json({ success: true, record: res.rows[0] });
  } catch (err: any) {
    console.error('Error upserting progress:', err);
    return NextResponse.json({ error: err.message }, { status: 500 });
  }
}
