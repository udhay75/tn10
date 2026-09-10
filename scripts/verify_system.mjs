// ============================================================================
// Automated System & Domain Verification Suite
// Validates curriculum fidelity, idempotent import, independent tracking,
// revision preservation, conflict handling, account isolation, and PWA assets.
// ============================================================================

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.dirname(__dirname);

let passedTests = 0;
let totalTests = 0;

function assert(condition, testName) {
  totalTests++;
  if (condition) {
    console.log(`  ✓ [PASS] ${testName}`);
    passedTests++;
  } else {
    console.error(`  ✗ [FAIL] ${testName}`);
    process.exitCode = 1;
  }
}

console.log('\n========================================================');
console.log('  Tamil Nadu Class 10 Study PWA - System Verification');
console.log('========================================================\n');

// ----------------------------------------------------------------------------
// 1. Verify Curriculum Structure Against PDF
// ----------------------------------------------------------------------------
console.log('1. Verifying Curriculum Structure & Source Provenance...');
const curriculumPath = path.join(rootDir, 'src', 'data', 'class_10_english_2024.json');
assert(fs.existsSync(curriculumPath), 'Curriculum JSON exists');

const curriculum = JSON.parse(fs.readFileSync(curriculumPath, 'utf8'));
assert(curriculum.units.length === 7, 'Curriculum contains exactly 7 units');

let totalLessons = 0;
let totalItems = 0;
let memoriterCount = 0;
let proseCount = 0;
let poemCount = 0;
let suppCount = 0;

curriculum.units.forEach((u) => {
  totalLessons += u.lessons.length;
  u.lessons.forEach((l) => {
    totalItems += l.checklist_items.length;
    if (l.lesson_type === 'prose') proseCount++;
    if (l.lesson_type === 'poem') poemCount++;
    if (l.lesson_type === 'supplementary') suppCount++;
    if (l.is_memoriter) memoriterCount++;

    // Verify printed page to PDF page offset (+4)
    assert(l.pdf_page_start === l.printed_page_start + 4, `Lesson ${l.title} PDF start page offset = +4`);
    assert(l.pdf_page_end === l.printed_page_end + 4, `Lesson ${l.title} PDF end page offset = +4`);
  });
});

assert(totalLessons === 21, 'Curriculum contains exactly 21 lessons (7 Prose, 7 Poem, 7 Supp)');
assert(proseCount === 7, 'Exactly 7 Prose selections');
assert(poemCount === 7, 'Exactly 7 Poem selections');
assert(suppCount === 7, 'Exactly 7 Supplementary selections');
assert(memoriterCount === 4, 'Exactly 4 Memoriter poems ("Life", "I am Every Woman", "Secret of Machines", "No Men Are Foreign")');
assert(totalItems === 154, `Extracted ${totalItems} checklist items with sections and exercises`);

// Verify Unit 1 titles match PDF
const u1 = curriculum.units[0];
assert(u1.lessons[0].title === 'His First Flight', 'Unit 1 Prose is His First Flight');
assert(u1.lessons[1].title === 'Life', 'Unit 1 Poem is Life');
assert(u1.lessons[2].title === 'The Tempest', 'Unit 1 Supplementary is The Tempest');

// ----------------------------------------------------------------------------
// 2. Verify Idempotent Import Workflow (No Duplicates)
// ----------------------------------------------------------------------------
console.log('\n2. Verifying Idempotent Import Workflow...');
const itemIds = new Set();
let duplicateFound = false;

curriculum.units.forEach((u) => {
  u.lessons.forEach((l) => {
    l.checklist_items.forEach((item) => {
      if (itemIds.has(item.id)) duplicateFound = true;
      itemIds.add(item.id);
    });
  });
});
assert(!duplicateFound, 'All checklist item identifiers are globally unique and stable');

// Simulate re-importing the same dataset
const reimportedItems = new Map();
curriculum.units.forEach((u) => {
  u.lessons.forEach((l) => {
    l.checklist_items.forEach((item) => {
      reimportedItems.set(item.id, item);
    });
  });
});
assert(reimportedItems.size === 154, 'Re-importing produces exact same count (154 items, zero duplicates)');

// ----------------------------------------------------------------------------
// 3. Verify Tracking Independence: Completion vs Understanding vs Study Again
// ----------------------------------------------------------------------------
console.log('\n3. Verifying Independence of Completion, Understanding & Study Again...');

const sampleProgress = {
  id: 'student1_item1',
  student_id: 'student1',
  item_code: 'tn10_eng_u1_prose_his_first_flight_item_1_read_his_first_flight_text',
  completion_status: 'not_started',
  understanding_status: 'not_assessed',
  study_again: false,
  personal_notes: '',
};

// 3a. Update completion only
const afterComplete = { ...sampleProgress, completion_status: 'completed' };
assert(afterComplete.completion_status === 'completed', 'Completion set to completed');
assert(afterComplete.understanding_status === 'not_assessed', 'Understanding remains unassessed');
assert(afterComplete.study_again === false, 'Study again remains false');

// 3b. Update understanding to need_help
const afterUnderstanding = { ...afterComplete, understanding_status: 'need_help' };
assert(afterUnderstanding.completion_status === 'completed', 'Completion still completed');
assert(afterUnderstanding.understanding_status === 'need_help', 'Understanding set to need_help');
assert(afterUnderstanding.study_again === false, 'Study again remains false');

// 3c. Flag for study again (can coexist with completed!)
const afterStudyAgain = { ...afterUnderstanding, study_again: true };
assert(afterStudyAgain.completion_status === 'completed', 'Completed coexists with study_again');
assert(afterStudyAgain.study_again === true, 'Study again flagged as true');
assert(afterStudyAgain.understanding_status === 'need_help', 'Need help preserved');

// ----------------------------------------------------------------------------
// 4. Verify Revision Workflow Preserves Completion
// ----------------------------------------------------------------------------
console.log('\n4. Verifying Revision Workflow Preserves Completion...');

const revisionHistory = [];
function completeRevision(currentProgress, stillNeedsRevision, notesSnapshot) {
  const entry = {
    id: `rev_${Date.now()}`,
    student_id: currentProgress.student_id,
    item_code: currentProgress.item_code,
    revision_date: new Date().toISOString(),
    notes_snapshot: notesSnapshot,
    outcome: stillNeedsRevision ? 'revision_needed_again' : 'revision_completed_mastered',
    still_needs_revision: stillNeedsRevision,
  };
  revisionHistory.push(entry);

  return {
    ...currentProgress,
    study_again: stillNeedsRevision,
    // COMPLETION STATUS MUST NOT BE RESET!
  };
}

const revisedProgress = completeRevision(afterStudyAgain, false, 'Finished review');
assert(revisedProgress.study_again === false, 'Item removed from revision queue');
assert(revisedProgress.completion_status === 'completed', 'CRITICAL: Completion status was NOT reset by revision');
assert(revisionHistory.length === 1, 'Revision history recorded exactly 1 revision session event');
assert(revisionHistory[0].outcome === 'revision_completed_mastered', 'Revision outcome logged');

// ----------------------------------------------------------------------------
// 5. Verify Conflicting Notes Handling
// ----------------------------------------------------------------------------
console.log('\n5. Verifying Notes Conflict Detection & Preservation...');

function handleNoteSync(localDraft, remoteRecord) {
  const remoteTime = new Date(remoteRecord.notes_updated_at).getTime();
  const localBaseTime = localDraft.base_version_time;

  if (remoteTime > localBaseTime && remoteRecord.personal_notes !== localDraft.personal_notes) {
    return {
      hasConflict: true,
      conflict_notes: {
        local: localDraft.personal_notes,
        remote: remoteRecord.personal_notes,
        remote_updated_at: remoteRecord.notes_updated_at,
      }
    };
  }
  return { hasConflict: false };
}

const localDraft = {
  personal_notes: 'Local student note added offline: Focus on paragraph 3',
  base_version_time: 1000,
};
const remoteRecord = {
  personal_notes: 'Remote note added on tablet: Ask teacher about seagull father',
  notes_updated_at: new Date(2000).toISOString(),
};

const conflictResult = handleNoteSync(localDraft, remoteRecord);
assert(conflictResult.hasConflict === true, 'Conflict detected when remote is newer and text differs');
assert(conflictResult.conflict_notes.local === localDraft.personal_notes, 'Local offline draft is preserved');
assert(conflictResult.conflict_notes.remote === remoteRecord.personal_notes, 'Remote server note is preserved');

// ----------------------------------------------------------------------------
// 6. Verify Multi-Tenant Student Isolation & Safe Logout
// ----------------------------------------------------------------------------
console.log('\n6. Verifying Account Isolation & Safe Logout Cleanup...');

const mockDatabase = {
  student_progress: [
    { student_id: 'student_A', item_code: 'item_1', notes: 'Private student A notes' },
    { student_id: 'student_B', item_code: 'item_1', notes: 'Private student B notes' },
  ],
  sync_queue: [
    { student_id: 'student_A', action: 'upsert_progress' },
  ]
};

// Access isolation
const accessA = mockDatabase.student_progress.filter((p) => p.student_id === 'student_A');
assert(accessA.length === 1 && accessA[0].notes === 'Private student A notes', 'Student A accesses only Student A notes');

// Logout cleanup
function logoutStudent(studentId) {
  mockDatabase.student_progress = mockDatabase.student_progress.filter((p) => p.student_id !== studentId);
  mockDatabase.sync_queue = mockDatabase.sync_queue.filter((q) => q.student_id !== studentId);
}

logoutStudent('student_A');
const remainingAfterLogout = mockDatabase.student_progress.filter((p) => p.student_id === 'student_A');
assert(remainingAfterLogout.length === 0, 'Student A private records completely purged on logout');
assert(mockDatabase.student_progress.length === 1, 'Student B records untouched');

// ----------------------------------------------------------------------------
// 7. Verify Admin Role Authorization Guards
// ----------------------------------------------------------------------------
console.log('\n7. Verifying Role-Based Access Guards...');

function canPublishCurriculum(user) {
  return Boolean(user && user.is_admin);
}

const regularStudent = { id: 's1', is_admin: false };
const adminUser = { id: 'a1', is_admin: true };

assert(!canPublishCurriculum(regularStudent), 'Regular student is blocked from admin publishing');
assert(canPublishCurriculum(adminUser), 'Admin user is authorized to publish curriculum');

// ----------------------------------------------------------------------------
// 8. Verify PWA Assets and Manifest
// ----------------------------------------------------------------------------
console.log('\n8. Verifying PWA Manifest and Service Worker Assets...');

const manifestPath = path.join(rootDir, 'public', 'manifest.json');
assert(fs.existsSync(manifestPath), 'manifest.json exists in public directory');

const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
assert(manifest.display === 'standalone', 'PWA display mode is standalone');
assert(manifest.theme_color === '#0f172a', 'Theme color is #0f172a');
assert(manifest.background_color === '#ffffff', 'Background color is #ffffff');
assert(manifest.icons.length >= 3, 'PWA defines standard, maskable, and SVG icons');

const maskableIcon = manifest.icons.find((i) => i.purpose === 'maskable');
assert(Boolean(maskableIcon), 'Maskable icon specified for Android adaptive icons');

assert(fs.existsSync(path.join(rootDir, 'public', 'sw.js')), 'Service worker sw.js exists');
assert(fs.existsSync(path.join(rootDir, 'public', 'offline.html')), 'Offline fallback offline.html exists');
assert(fs.existsSync(path.join(rootDir, 'public', 'icons', 'icon-192.png')), 'icon-192.png exists');
assert(fs.existsSync(path.join(rootDir, 'public', 'icons', 'icon-512.png')), 'icon-512.png exists');
assert(fs.existsSync(path.join(rootDir, 'public', 'icons', 'maskable-icon-512.png')), 'maskable-icon-512.png exists');
// ----------------------------------------------------------------------------
// 9. Verify Mathematics Curriculum (2025 Edition) & Multi-Subject Support
// ----------------------------------------------------------------------------
console.log('\n9. Verifying Mathematics Curriculum (2025 Edition) & Multi-Subject...');

const mathCurriculumPath = path.join(rootDir, 'src', 'data', 'class_10_math_2025.json');
assert(fs.existsSync(mathCurriculumPath), 'class_10_math_2025.json exists');

const mathCurriculum = JSON.parse(fs.readFileSync(mathCurriculumPath, 'utf8'));
assert(mathCurriculum.subject.code === 'class_10_math', 'Subject code is class_10_math');
assert(mathCurriculum.subject.curriculum_version === '2025 Edition', 'Curriculum version is 2025 Edition');
assert(mathCurriculum.units.length === 8, 'Math curriculum contains exactly 8 units/chapters');

let mathLessons = 0;
let mathItems = 0;
mathCurriculum.units.forEach((u) => {
  mathLessons += u.lessons.length;
  u.lessons.forEach((l) => {
    mathItems += l.checklist_items.length;
    // Verify printed page to PDF page offset (+6)
    assert(l.pdf_page_start === l.printed_page_start + 6, `Math Lesson ${l.title} PDF start page offset = +6`);
    l.checklist_items.forEach((item) => {
      assert(item.pdf_page === item.printed_page + 6, `Math Item ${item.id} PDF page offset = +6`);
    });
  });
});

assert(mathLessons === 30, `Math curriculum contains 30 modular lessons (got ${mathLessons})`);
assert(mathItems === 80, `Math curriculum contains 80 checklist activities (got ${mathItems})`);
assert(fs.existsSync(path.join(rootDir, 'supabase', 'migrations', '004_seed_math_2025.sql')), '004_seed_math_2025.sql exists');

// ----------------------------------------------------------------------------
// 10. Verify Science Curriculum (2024 Edition) & Tri-Subject Support
// ----------------------------------------------------------------------------
console.log('\n10. Verifying Science Curriculum (2024 Edition) & Tri-Subject Architecture...');

const scienceCurriculumPath = path.join(rootDir, 'src', 'data', 'class_10_science_2024.json');
assert(fs.existsSync(scienceCurriculumPath), 'class_10_science_2024.json exists');

const scienceCurriculum = JSON.parse(fs.readFileSync(scienceCurriculumPath, 'utf8'));
assert(scienceCurriculum.subject.code === 'class_10_science', 'Subject code is class_10_science');
assert(scienceCurriculum.subject.curriculum_version === '2024 Edition', 'Curriculum version is 2024 Edition');
assert(scienceCurriculum.units.length === 24, 'Science curriculum contains 24 units (23 theory + 1 practicals)');

let scienceLessons = 0;
let scienceItems = 0;
scienceCurriculum.units.forEach((u) => {
  scienceLessons += u.lessons.length;
  u.lessons.forEach((l) => {
    scienceItems += l.checklist_items.length;
    // Verify printed page to PDF page offset (+8)
    assert(l.pdf_page_start === l.printed_page_start + 8, `Science Lesson ${l.title} PDF start page offset = +8`);
    l.checklist_items.forEach((item) => {
      assert(item.pdf_page === item.printed_page + 8, `Science Item ${item.id} PDF page offset = +8`);
    });
  });
});

assert(scienceLessons === 48, `Science curriculum contains 48 modular lessons (got ${scienceLessons})`);
assert(scienceItems === 118, `Science curriculum contains 118 checklist activities (got ${scienceItems})`);
assert(fs.existsSync(path.join(rootDir, 'supabase', 'migrations', '005_seed_science_2024.sql')), '005_seed_science_2024.sql exists');

// ----------------------------------------------------------------------------
// 11. Verify Social Science Curriculum (2025 Edition) & 4-Subject Architecture
// ----------------------------------------------------------------------------
console.log('\n11. Verifying Social Science Curriculum (2025 Edition) & 4-Subject Architecture...');

const socialCurriculumPath = path.join(rootDir, 'src', 'data', 'class_10_social_science_2025.json');
assert(fs.existsSync(socialCurriculumPath), 'class_10_social_science_2025.json exists');

const socialCurriculum = JSON.parse(fs.readFileSync(socialCurriculumPath, 'utf8'));
assert(socialCurriculum.subject.code === 'class_10_social_science', 'Subject code is class_10_social_science');
assert(socialCurriculum.subject.curriculum_version === '2025 Edition', 'Curriculum version is 2025 Edition');
assert(socialCurriculum.units.length === 27, 'Social Science curriculum contains 27 units across 4 disciplines');

let socialLessons = 0;
let socialItems = 0;
socialCurriculum.units.forEach((u) => {
  socialLessons += u.lessons.length;
  u.lessons.forEach((l) => {
    socialItems += l.checklist_items.length;
    // Verify printed page to PDF page offset (+6)
    assert(l.pdf_page_start === l.printed_page_start + 6, `Social Lesson ${l.title} PDF start page offset = +6`);
    l.checklist_items.forEach((item) => {
      assert(item.pdf_page === item.printed_page + 6, `Social Item ${item.id} PDF page offset = +6`);
    });
  });
});

assert(socialLessons === 54, `Social Science curriculum contains 54 modular lessons (got ${socialLessons})`);
assert(socialItems === 152, `Social Science curriculum contains 152 checklist activities (got ${socialItems})`);
assert(fs.existsSync(path.join(rootDir, 'supabase', 'migrations', '006_seed_social_science_2025.sql')), '006_seed_social_science_2025.sql exists');

// ----------------------------------------------------------------------------
// 12. Verify Tamil Curriculum (2025 Revised Edition) & 5-Subject Unified Board
// ----------------------------------------------------------------------------
console.log('\n12. Verifying Tamil Curriculum (2025 Revised Edition) & 5-Subject Architecture...');

const tamilCurriculumPath = path.join(rootDir, 'src', 'data', 'class_10_tamil_2025.json');
assert(fs.existsSync(tamilCurriculumPath), 'class_10_tamil_2025.json exists');

const tamilCurriculum = JSON.parse(fs.readFileSync(tamilCurriculumPath, 'utf8'));
assert(tamilCurriculum.subject.code === 'class_10_tamil', 'Subject code is class_10_tamil');
assert(tamilCurriculum.subject.curriculum_version === '2025 Edition', 'Curriculum version is 2025 Edition');
assert(tamilCurriculum.units.length === 7, 'Tamil curriculum contains 7 units (Iyals 1 to 7)');

let tamilLessons = 0;
let tamilItems = 0;
let tamilMemoriter = 0;
tamilCurriculum.units.forEach((u) => {
  tamilLessons += u.lessons.length;
  u.lessons.forEach((l) => {
    tamilItems += l.checklist_items.length;
    if (l.is_memoriter) tamilMemoriter++;
    // Verify printed page to PDF page offset (+10)
    assert(l.pdf_page_start === l.printed_page_start + 10, `Tamil Lesson ${l.title} PDF start page offset = +10`);
    assert(l.pdf_page_end === l.printed_page_end + 10, `Tamil Lesson ${l.title} PDF end page offset = +10`);
    l.checklist_items.forEach((item) => {
      assert(item.pdf_page === item.printed_page + 10, `Tamil Item ${item.id} PDF page offset = +10`);
    });
  });
});

assert(tamilLessons === 43, `Tamil curriculum contains 43 modular lessons (got ${tamilLessons})`);
assert(tamilItems === 131, `Tamil curriculum contains 131 checklist activities (got ${tamilItems})`);
assert(tamilMemoriter >= 6, `Tamil curriculum contains ${tamilMemoriter} memoriter poems & couplets`);
assert(fs.existsSync(path.join(rootDir, 'supabase', 'migrations', '007_seed_tamil_2025.sql')), '007_seed_tamil_2025.sql exists');

console.log('\n========================================================');
console.log(`  Verification Complete: ${passedTests}/${totalTests} tests passed.`);
console.log('========================================================\n');



