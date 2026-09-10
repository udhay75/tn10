// ============================================================================
// Docker PostgreSQL Integration Verification Test
// ============================================================================

import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
  host: process.env.PGHOST || 'localhost',
  port: Number(process.env.PGPORT) || 5432,
  user: process.env.PGUSER || 'postgres',
  password: process.env.PGPASSWORD || 'postgres',
  database: process.env.PGDATABASE || 'tn10_study',
  connectionTimeoutMillis: 5000,
});

async function main() {
  console.log('\n========================================================');
  console.log('  Testing Docker PostgreSQL Container (tn10_postgres)   ');
  console.log('========================================================\n');

  try {
    // 1. Check connection and version
    const versionRes = await pool.query('SELECT version()');
    console.log('✓ Connected to PostgreSQL:', versionRes.rows[0].version.split(',')[0]);

    // 2. Verify curriculum table counts
    const countRes = await pool.query(`
      SELECT 
        (SELECT count(*) FROM units) as total_units,
        (SELECT count(*) FROM lessons) as total_lessons,
        (SELECT count(*) FROM checklist_items) as total_items
    `);
    const counts = countRes.rows[0];
    console.log(`✓ Curriculum Records: ${counts.total_units} Units, ${counts.total_lessons} Lessons, ${counts.total_items} Items`);

    if (Number(counts.total_units) !== 7 || Number(counts.total_lessons) !== 21 || Number(counts.total_items) !== 154) {
      throw new Error(`Unexpected curriculum counts: ${JSON.stringify(counts)}`);
    }

    // 3. Test student progress upsert
    const testStudentUuid = 'a0000000-0000-0000-0000-000000000001';
    const testItem = 'tn10_eng_u1_prose_his_first_flight_item_1_read_his_first_flight_text';

    await pool.query(`
      INSERT INTO student_item_progress (
        student_id, item_code, completion_status, understanding_status, study_again,
        personal_notes, notes_updated_at, last_studied_at
      ) VALUES ($1, $2, 'completed', 'partly_understood', true, 'Test notes via Docker container', NOW(), NOW())
      ON CONFLICT (student_id, item_code) DO UPDATE SET
        completion_status = EXCLUDED.completion_status,
        understanding_status = EXCLUDED.understanding_status,
        study_again = EXCLUDED.study_again,
        personal_notes = EXCLUDED.personal_notes,
        updated_at = NOW()
    `, [testStudentUuid, testItem]);
    console.log('✓ Successfully upserted student progress record into Docker PostgreSQL');

    // 4. Verify progress query
    const fetchProg = await pool.query(
      'SELECT * FROM student_item_progress WHERE student_id = $1 AND item_code = $2',
      [testStudentUuid, testItem]
    );
    const prog = fetchProg.rows[0];
    console.log(`✓ Retrieved progress: completion=${prog.completion_status}, understanding=${prog.understanding_status}, study_again=${prog.study_again}`);

    // 5. Test revision history insert
    await pool.query(`
      INSERT INTO revision_history (
        student_id, item_code, revision_date, notes_snapshot, outcome, still_needs_revision
      ) VALUES ($1, $2, NOW(), 'Notes at revision time', 'reviewed', false)
    `, [testStudentUuid, testItem]);
    console.log('✓ Successfully recorded revision history event into Docker PostgreSQL');

    const fetchRev = await pool.query('SELECT count(*) FROM revision_history WHERE student_id = $1', [testStudentUuid]);
    console.log(`✓ Revision history count: ${fetchRev.rows[0].count}`);

    console.log('\n========================================================');
    console.log('  ALL DOCKER POSTGRESQL INTEGRATION TESTS PASSED!       ');
    console.log('========================================================\n');
  } catch (err) {
    console.error('✗ Docker DB Test Failed:', err);
    process.exit(1);
  } finally {
    await pool.end();
  }
}

main();
