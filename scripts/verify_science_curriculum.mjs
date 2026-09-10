import fs from 'fs';
import path from 'path';
import pg from 'pg';

const { Client } = pg;

console.log('=== Step 1: Validating class_10_science_2024.json ===');
const scienceData = JSON.parse(fs.readFileSync(path.join(process.cwd(), 'src/data/class_10_science_2024.json'), 'utf8'));

if (!scienceData.subject || scienceData.subject.code !== 'class_10_science') {
  throw new Error('Invalid subject in science JSON');
}

console.log(`✓ Subject: ${scienceData.subject.title} (${scienceData.subject.curriculum_version})`);
console.log(`✓ Textbook: ${scienceData.subject.textbook.title}, Offset: ${scienceData.subject.textbook.page_offset}`);

if (scienceData.units.length !== 24) {
  throw new Error(`Expected 24 units (23 theory + 1 practicals), got ${scienceData.units.length}`);
}

const seenItemIds = new Set();
const seenLessonIds = new Set();
let totalLessons = 0;
let totalItems = 0;

for (const unit of scienceData.units) {
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
    if (lesson.pdf_page_start !== lesson.printed_page_start + 8) {
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
      if (item.pdf_page !== item.printed_page + 8) {
        throw new Error(`Item ${item.id} has incorrect page offset: printed ${item.printed_page}, pdf ${item.pdf_page}`);
      }
    }
  }
}

console.log(`✓ Total Units: ${scienceData.units.length}`);
console.log(`✓ Total Lessons: ${totalLessons}`);
console.log(`✓ Total Checklist Items: ${totalItems}`);
console.log(`✓ Page alignment (offset = 8) verified on all ${totalItems} items!`);

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
    WHERE te.subject_code = 'class_10_science'
    GROUP BY u.unit_number, u.title
    ORDER BY u.unit_number
  `);

  console.log(`✓ Science Units in PostgreSQL: ${unitsRes.rows.length}`);
  unitsRes.rows.forEach(r => {
    console.log(`   Unit ${r.unit_number}: ${r.title} (${r.lessons_count} lessons, ${r.items_count} items)`);
  });

  const totalScienceItemsRes = await client.query(`
    SELECT count(ci.id) as count
    FROM checklist_items ci
    JOIN lessons l ON l.code = ci.lesson_code
    JOIN units u ON u.code = l.unit_code
    JOIN textbook_editions te ON te.code = u.edition_code
    WHERE te.subject_code = 'class_10_science'
  `);

  console.log(`✓ Total Science Checklist Items in DB: ${totalScienceItemsRes.rows[0].count}`);

  if (parseInt(totalScienceItemsRes.rows[0].count, 10) !== totalItems) {
    throw new Error(`Database item count mismatch: expected ${totalItems}, got ${totalScienceItemsRes.rows[0].count}`);
  }

  // Cross-Subject Summary Check
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

  console.log('\n🎉 ALL SCIENCE CURRICULUM VERIFICATIONS PASSED SUCCESSFULLY!');
} catch (err) {
  console.error('Database connection or query failed:', err.message);
  process.exit(1);
} finally {
  await client.end();
}
