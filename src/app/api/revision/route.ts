import { NextRequest, NextResponse } from 'next/server';
import { queryPostgres } from '@/lib/db/postgres';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import crypto from 'crypto';

function toUuid(id: string): string {
  if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(id)) {
    return id;
  }
  const hash = crypto.createHash('md5').update(id).digest('hex');
  return `${hash.substring(0, 8)}-${hash.substring(8, 12)}-4${hash.substring(13, 16)}-a${hash.substring(17, 20)}-${hash.substring(20, 32)}`;
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { student_id, item_code, revision_date, notes_snapshot, outcome, still_needs_revision } = body;

    if (!student_id || !item_code) {
      return NextResponse.json({ error: 'student_id and item_code are required' }, { status: 400 });
    }

    const studentUuid = toUuid(student_id);

    // 1. MongoDB Mode (Coolify)
    if (isMongoConfigured()) {
      const db = await getMongoDb();
      const record = {
        student_id: studentUuid,
        item_code,
        revision_date: revision_date ? new Date(revision_date) : new Date(),
        notes_snapshot: notes_snapshot || '',
        outcome: outcome || 'reviewed',
        still_needs_revision: Boolean(still_needs_revision),
        created_at: new Date()
      };

      const result = await db.collection('revision_history').insertOne(record);
      return NextResponse.json({ success: true, record: { ...record, id: result.insertedId } });
    }

    // 2. PostgreSQL Mode (Local Docker)
    await queryPostgres(
      `INSERT INTO auth.users (id, email) VALUES ($1, $2) ON CONFLICT (id) DO NOTHING`,
      [studentUuid, `${student_id}@tn10.local`]
    );

    const query = `
      INSERT INTO revision_history (
        student_id, item_code, revision_date, notes_snapshot, outcome, still_needs_revision
      )
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *;
    `;

    const res = await queryPostgres(query, [
      studentUuid,
      item_code,
      revision_date ? new Date(revision_date) : new Date(),
      notes_snapshot || '',
      outcome || 'reviewed',
      Boolean(still_needs_revision),
    ]);

    return NextResponse.json({ success: true, record: res.rows[0] });
  } catch (err: any) {
    console.error('Error recording revision history:', err);
    return NextResponse.json({ error: err.message }, { status: 500 });
  }
}
