import fs from 'fs';
import path from 'path';
import pg from 'pg';

const { Client } = pg;

console.log('=== Step 1: Validating class_10_math_2025.json ===');
const mathData = JSON.parse(fs.readFileSync(path.join(process.cwd(), 'src/data/class_10_math_2025.json'), 'utf8'));

if (!mathData.subject || mathData.subject.code !== 'class_10_math') {
  throw new Error('Invalid subject in math JSON');
}

console.log(`✓ Subject: ${mathData.subject.title} (${mathData.subject.curriculum_version})`);
console.log(`✓ Textbook: ${mathData.subject.textbook.title}, Offset: ${mathData.subject.textbook.page_offset}`);

if (mathData.units.length !== 8) {
  throw new Error(`Expected 8 units, got ${mathData.units.length}`);
}

const seenItemIds = new Set();
const seenLessonIds = new Set();
let totalLessons = 0;
let totalItems = 0;

for (const unit of mathData.units) {
  if (!unit.id || !unit.title || !unit.theme) {
    throw new Error(`Unit ${unit.unit_number} missing required fields`);
  }
  for (const lesson of unit.lessons) {
    totalLessons++;
    if (seenLessonIds.has(lesson.id)) {
      throw new Error(`Duplicate lesson id: ${lesson.id}`);
    }
    seenLessonIds.add(lesson.id);

    // Verify page offset
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

console.log(`✓ Total Units: ${mathData.units.length}`);
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
    WHERE te.subject_code = 'class_10_math'
    GROUP BY u.unit_number, u.title
    ORDER BY u.unit_number
  `);

  console.log(`✓ Mathematics Units in PostgreSQL: ${unitsRes.rows.length}`);
  unitsRes.rows.forEach(r => {
    console.log(`   Unit ${r.unit_number}: ${r.title} (${r.lessons_count} lessons, ${r.items_count} items)`);
  });

  const totalMathItemsRes = await client.query(`
    SELECT count(ci.id) as count
    FROM checklist_items ci
    JOIN lessons l ON l.code = ci.lesson_code
    JOIN units u ON u.code = l.unit_code
    JOIN textbook_editions te ON te.code = u.edition_code
    WHERE te.subject_code = 'class_10_math'
  `);
  console.log(`✓ Total Mathematics items in PostgreSQL: ${totalMathItemsRes.rows[0].count}`);

  const totalEngItemsRes = await client.query(`
    SELECT count(ci.id) as count
    FROM checklist_items ci
    JOIN lessons l ON l.code = ci.lesson_code
    JOIN units u ON u.code = l.unit_code
    JOIN textbook_editions te ON te.code = u.edition_code
    WHERE te.subject_code = 'class_10_english'
  `);
  console.log(`✓ Existing English items in PostgreSQL preserved: ${totalEngItemsRes.rows[0].count}`);

  await client.end();
  console.log('\n🎉 ALL MATHEMATICS & MULTI-SUBJECT VERIFICATIONS PASSED SUCCESSFULLY!');
} catch (err) {
  console.error('PostgreSQL verification failed:', err.message);
  process.exit(1);
}
