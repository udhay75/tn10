// ============================================================================
// Tamil (2025 Revised Edition) Verification Script
// Verifies JSON structure, page mapping, memoriter flags, and Docker DB integrity.
// ============================================================================

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import pg from 'pg';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '..');

const tamilJsonPath = path.join(rootDir, 'src', 'data', 'class_10_tamil_2025.json');

console.log('--- 1. VERIFYING TAMIL 2025 JSON STRUCTURE ---');
const rawData = fs.readFileSync(tamilJsonPath, 'utf8');
const data = JSON.parse(rawData);

let passed = 0;
let failed = 0;

function assert(condition, message) {
  if (condition) {
    console.log(`  ✅ ${message}`);
    passed++;
  } else {
    console.error(`  ❌ FAIL: ${message}`);
    failed++;
  }
}

// Check Metadata
assert(data.subject.code === 'class_10_tamil', 'Subject code is class_10_tamil');
assert(data.subject.curriculum_version === '2025 Edition', 'Curriculum version is 2025 Edition');
assert(data.subject.textbook.source_file.includes('Class_10_Tamil_2025_Edition'), 'Provenance references 2025 PDF');
assert(data.subject.textbook.page_offset === 10, 'Page offset is 10');

// Check Units Count
assert(data.units.length === 7, `7 Iyals present (actual: ${data.units.length})`);
assert(data.summary.total_units === 7, 'Summary total_units is 7');

// Count lessons and checklist items
let totalLessons = 0;
let totalItems = 0;
let memoriterLessons = 0;
let memoriterItems = 0;
let offsetErrors = 0;

data.units.forEach((unit) => {
  totalLessons += unit.lessons.length;
  unit.lessons.forEach((lesson) => {
    totalItems += lesson.checklist_items.length;
    if (lesson.is_memoriter) memoriterLessons++;
    
    // Validate page offset for lesson
    if (lesson.pdf_page_start !== lesson.printed_page_start + 10 || lesson.pdf_page_end !== lesson.printed_page_end + 10) {
      console.error(`Page offset mismatch in lesson ${lesson.id}: printed ${lesson.printed_page_start}-${lesson.printed_page_end}, pdf ${lesson.pdf_page_start}-${lesson.pdf_page_end}`);
      offsetErrors++;
    }

    lesson.checklist_items.forEach((item) => {
      if (item.pdf_page !== item.printed_page + 10) {
        console.error(`Page offset mismatch in item ${item.id}: printed ${item.printed_page}, pdf ${item.pdf_page}`);
        offsetErrors++;
      }
      if (item.is_memoriter || item.section_name === 'Memoriter' || item.label.includes('மனப்பாட') || lesson.is_memoriter) memoriterItems++;
    });
  });
});

assert(totalLessons === 43, `Total lessons is 43 (actual: ${totalLessons})`);
assert(data.summary.total_lessons === 43, 'Summary total_lessons is 43');
assert(totalItems === 131, `Total checklist items is 131 (actual: ${totalItems})`);
assert(data.summary.total_checklist_items === 131, 'Summary total_checklist_items is 131');
assert(offsetErrors === 0, `All ${totalLessons} lessons & ${totalItems} items obey pdf_page = printed_page + 10`);
assert(memoriterLessons >= 6, `At least 6 memoriter modules found (actual: ${memoriterLessons})`);
assert(memoriterItems >= 6, `At least 6 memoriter checklist items found (actual: ${memoriterItems})`);

// Check Docker PostgreSQL Database
console.log('\n--- 2. VERIFYING DOCKER POSTGRESQL DATABASE ---');
const { Client } = pg;
const dbUrl = process.env.DATABASE_URL || 'postgresql://postgres:postgres@localhost:5432/tn10_study';
const client = new Client({ connectionString: dbUrl });

try {
  await client.connect();
  console.log('  Connected to PostgreSQL container successfully.');

  const subRes = await client.query("SELECT * FROM subjects WHERE code = 'class_10_tamil'");
  assert(subRes.rows.length === 1, "Subject 'class_10_tamil' exists in subjects table");

  const edRes = await client.query("SELECT * FROM textbook_editions WHERE subject_code = 'class_10_tamil'");
  assert(edRes.rows.length === 1, "Textbook edition for 'class_10_tamil' exists");
  if (edRes.rows.length > 0) {
    assert(edRes.rows[0].edition_year === 2025, "Edition year in DB is 2025");
  }

  const unitRes = await client.query("SELECT COUNT(*) FROM units WHERE edition_code = 'tn10_tam_2025_edition'");
  assert(parseInt(unitRes.rows[0].count, 10) === 7, `7 Iyals in DB units table (actual: ${unitRes.rows[0].count})`);

  const lessonRes = await client.query("SELECT COUNT(*) FROM lessons WHERE unit_code LIKE 'tn10_tam%'");
  assert(parseInt(lessonRes.rows[0].count, 10) === 43, `43 Lessons in DB lessons table (actual: ${lessonRes.rows[0].count})`);

  const itemRes = await client.query("SELECT COUNT(*) FROM checklist_items WHERE lesson_code LIKE 'tn10_tam%'");
  assert(parseInt(itemRes.rows[0].count, 10) === 131, `131 Checklist items in DB checklist_items table (actual: ${itemRes.rows[0].count})`);

  // Verify grand totals across all 5 subjects
  const allSubRes = await client.query("SELECT COUNT(*) FROM subjects");
  assert(parseInt(allSubRes.rows[0].count, 10) === 5, `Total 5 subjects in DB (actual: ${allSubRes.rows[0].count})`);

  const allUnitsRes = await client.query("SELECT COUNT(*) FROM units");
  assert(parseInt(allUnitsRes.rows[0].count, 10) === 73, `Total 73 units across all 5 subjects in DB (actual: ${allUnitsRes.rows[0].count})`);

  const allLessonsRes = await client.query("SELECT COUNT(*) FROM lessons");
  assert(parseInt(allLessonsRes.rows[0].count, 10) === 196, `Total 196 lessons across all 5 subjects in DB (actual: ${allLessonsRes.rows[0].count})`);

  const allItemsRes = await client.query("SELECT COUNT(*) FROM checklist_items");
  assert(parseInt(allItemsRes.rows[0].count, 10) === 635, `Total 635 checklist items across all 5 subjects in DB (actual: ${allItemsRes.rows[0].count})`);

  const progressRes = await client.query("SELECT COUNT(*) FROM student_item_progress");
  assert(parseInt(progressRes.rows[0].count, 10) >= 6, `Student progress records preserved (actual: ${progressRes.rows[0].count})`);

  await client.end();
} catch (err) {
  console.error('  Database connection/query error:', err.message);
  failed++;
}

console.log(`\n========================================`);
console.log(`TAMIL VERIFICATION COMPLETE: ${passed} Passed, ${failed} Failed`);
console.log(`========================================`);

if (failed > 0) {
  process.exit(1);
} else {
  console.log('All Tamil 2025 curriculum verifications passed with 100% integrity!');
}
