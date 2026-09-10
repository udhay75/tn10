import fs from 'fs';
import path from 'path';
import pg from 'pg';

const { Client } = pg;

console.log('=== Step 1: Validating class_10_social_science_2025.json ===');
const socialData = JSON.parse(fs.readFileSync(path.join(process.cwd(), 'src/data/class_10_social_science_2025.json'), 'utf8'));

if (!socialData.subject || socialData.subject.code !== 'class_10_social_science') {
  throw new Error('Invalid subject in social science JSON');
}

console.log(`✓ Subject: ${socialData.subject.title} (${socialData.subject.curriculum_version})`);
console.log(`✓ Textbook: ${socialData.subject.textbook.title}, Offset: ${socialData.subject.textbook.page_offset}`);

if (socialData.units.length !== 27) {
  throw new Error(`Expected 27 units, got ${socialData.units.length}`);
}

const seenItemIds = new Set();
const seenLessonIds = new Set();
let totalLessons = 0;
let totalItems = 0;

for (const unit of socialData.units) {
  if (!unit.id || !unit.title || !unit.theme) {
    throw new Error(`Unit ${unit.unit_number} missing required fields`);
  }
  for (const lesson of unit.lessons) {
    totalLessons++;
    if (seenLessonIds.has(lesson.id)) {
      throw new Error(`Duplicate lesson id: ${lesson.id}`);
    }
    seenLessonIds.add(lesson.id);

    // Verify page offset (+6)
    if (lesson.pdf_page_start !== lesson.printed_page_start + 6) {
      throw new Error(`Lesson ${lesson.id} has incorrect start page offset: printed ${lesson.printed_page_start}, pdf ${lesson.pdf_page_start}`);
    }

    for (const item of lesson.checklist_items) {
      totalItems++;
      if (seenItemIds.has(item.id)) {
        throw new Error(`Duplicate item id: ${item.id}`);
      }
      seenItemIds.add(item.id);

      if (!item.label || !item.description || !item.section_name) {
        throw new Error(`Item ${item.id} missing text fields`);
      }
      if (item.pdf_page !== item.printed_page + 6) {
        throw new Error(`Item ${item.id} has incorrect page offset: printed ${item.printed_page}, pdf ${item.pdf_page}`);
      }
    }
  }
}

console.log(`✓ Total Units: ${socialData.units.length}`);
console.log(`✓ Total Lessons: ${totalLessons}`);
console.log(`✓ Total Checklist Items: ${totalItems}`);
console.log(`✓ Page alignment (offset = 6) verified on all ${totalItems} items!`);

console.log('\n=== Step 2: Validating Docker PostgreSQL Database (tn10_postgres) ===');
const client = new Client({
  connectionString: process.env.DATABASE_URL || 'postgresql://postgres:postgres@localhost:5432/tn10_study',
  connectionTimeoutMillis: 5000,
});

try {
  await client.connect();
  console.log('✓ Connected to PostgreSQL at localhost:5432');

  const subRes = await client.query('SELECT code, title FROM subjects ORDER BY code');
  console.log(`✓ Subjects in DB: ${subRes.rows.map(r => `${r.title} (${r.code})`).join(', ')}`);

  const unitsRes = await client.query(`
    SELECT u.unit_number, u.title, count(l.id) as lessons_count, count(ci.id) as items_count
    FROM units u
    JOIN textbook_editions te ON te.code = u.edition_code
    LEFT JOIN lessons l ON l.unit_code = u.code
    LEFT JOIN checklist_items ci ON ci.lesson_code = l.code
    WHERE te.subject_code = 'class_10_social_science'
    GROUP BY u.unit_number, u.title
    ORDER BY u.unit_number
  `);

  console.log(`✓ Social Science Units in PostgreSQL: ${unitsRes.rows.length}`);

  const totalSocialItemsRes = await client.query(`
    SELECT count(ci.id) as count
    FROM checklist_items ci
    JOIN lessons l ON l.code = ci.lesson_code
    JOIN units u ON u.code = l.unit_code
    JOIN textbook_editions te ON te.code = u.edition_code
    WHERE te.subject_code = 'class_10_social_science'
  `);

  console.log(`✓ Total Social Science Checklist Items in DB: ${totalSocialItemsRes.rows[0].count}`);

  if (parseInt(totalSocialItemsRes.rows[0].count, 10) !== totalItems) {
    throw new Error(`Database item count mismatch: expected ${totalItems}, got ${totalSocialItemsRes.rows[0].count}`);
  }

  // Cross-Subject Summary Check across all 4 subjects
  const crossSub = await client.query(`
    SELECT s.code, s.title, count(DISTINCT u.id) as units_count, count(DISTINCT l.id) as lessons_count, count(ci.id) as items_count
    FROM subjects s
    JOIN textbook_editions te ON te.subject_code = s.code
    JOIN units u ON u.edition_code = te.code
    JOIN lessons l ON l.unit_code = u.code
    JOIN checklist_items ci ON ci.lesson_code = l.code
    GROUP BY s.code, s.title
    ORDER BY s.code
  `);

  console.log('\n=== Multi-Subject DB Verification Summary ===');
  crossSub.rows.forEach(row => {
    console.log(`✓ ${row.title} (${row.code}): ${row.units_count} Units, ${row.lessons_count} Lessons, ${row.items_count} Items`);
  });

  const progRes = await client.query('SELECT count(*) FROM student_item_progress');
  console.log(`✓ Preserved student progress records: ${progRes.rows[0].count}`);

  console.log('\n🎉 ALL SOCIAL SCIENCE CURRICULUM VERIFICATIONS PASSED SUCCESSFULLY!');
} catch (err) {
  console.error('Database connection or query failed:', err.message);
  process.exit(1);
} finally {
  await client.end();
}
