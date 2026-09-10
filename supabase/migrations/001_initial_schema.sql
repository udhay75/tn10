-- ============================================================================
-- 001_initial_schema.sql: Tamil Nadu State Board Class 10 Study PWA
-- Full Relational Schema with Uniqueness Constraints, Foreign Keys & Indexes
-- ============================================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Shared Curriculum Hierarchy
-- Board -> Class -> Medium -> Subject -> Textbook Edition -> Unit -> Lesson -> Checklist Item

CREATE TABLE IF NOT EXISTS boards (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(64) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    state VARCHAR(128) NOT NULL DEFAULT 'Tamil Nadu',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS classes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(64) UNIQUE NOT NULL,
    grade_number INT NOT NULL,
    title VARCHAR(128) NOT NULL,
    board_code VARCHAR(64) NOT NULL REFERENCES boards(code) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS mediums (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(64) UNIQUE NOT NULL,
    name VARCHAR(128) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS subjects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(64) UNIQUE NOT NULL,
    title VARCHAR(128) NOT NULL,
    class_code VARCHAR(64) NOT NULL REFERENCES classes(code) ON DELETE CASCADE,
    medium_code VARCHAR(64) NOT NULL REFERENCES mediums(code) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS textbook_editions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(64) UNIQUE NOT NULL,
    subject_code VARCHAR(64) NOT NULL REFERENCES subjects(code) ON DELETE CASCADE,
    edition_year INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    source_filename VARCHAR(255),
    is_published BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS units (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(64) UNIQUE NOT NULL,
    edition_code VARCHAR(64) NOT NULL REFERENCES textbook_editions(code) ON DELETE CASCADE,
    unit_number INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    theme TEXT,
    order_index INT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_edition_unit_number UNIQUE (edition_code, unit_number)
);

CREATE TABLE IF NOT EXISTS lessons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(128) UNIQUE NOT NULL,
    unit_code VARCHAR(64) NOT NULL REFERENCES units(code) ON DELETE CASCADE,
    lesson_number INT NOT NULL,
    lesson_type VARCHAR(32) NOT NULL CHECK (lesson_type IN ('prose', 'poem', 'supplementary')),
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    is_memoriter BOOLEAN NOT NULL DEFAULT false,
    printed_page_start INT,
    printed_page_end INT,
    pdf_page_start INT,
    pdf_page_end INT,
    order_index INT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_unit_lesson_order UNIQUE (unit_code, order_index)
);

CREATE TABLE IF NOT EXISTS checklist_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(128) UNIQUE NOT NULL,
    lesson_code VARCHAR(128) NOT NULL REFERENCES lessons(code) ON DELETE CASCADE,
    item_type VARCHAR(32) NOT NULL CHECK (item_type IN ('source_activity', 'app_task')),
    section_name VARCHAR(128) NOT NULL,
    label VARCHAR(255) NOT NULL,
    description TEXT,
    printed_page INT,
    pdf_page INT,
    order_index INT NOT NULL,
    is_required BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_lesson_item_order UNIQUE (lesson_code, order_index)
);

-- 2. Student Accounts & Profiles
CREATE TABLE IF NOT EXISTS student_profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    display_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    class_code VARCHAR(64) REFERENCES classes(code) DEFAULT 'class_10',
    medium_code VARCHAR(64) REFERENCES mediums(code) DEFAULT 'english',
    interface_lang VARCHAR(8) NOT NULL DEFAULT 'en' CHECK (interface_lang IN ('en', 'ta')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 3. Student Item Progress & Notes
-- Strictly independent completion, understanding, study again, and notes
CREATE TABLE IF NOT EXISTS student_item_progress (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    item_code VARCHAR(128) NOT NULL REFERENCES checklist_items(code) ON DELETE CASCADE,
    completion_status VARCHAR(32) NOT NULL DEFAULT 'not_started' 
        CHECK (completion_status IN ('not_started', 'in_progress', 'completed')),
    understanding_status VARCHAR(32) NOT NULL DEFAULT 'not_assessed' 
        CHECK (understanding_status IN ('not_assessed', 'need_help', 'partly_understood', 'understood')),
    study_again BOOLEAN NOT NULL DEFAULT false,
    personal_notes TEXT,
    notes_updated_at TIMESTAMPTZ,
    last_studied_at TIMESTAMPTZ,
    next_revision_date DATE,
    sync_version INT NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_student_item UNIQUE (student_id, item_code)
);

-- 4. Revision History Log
-- Records every completed revision session without resetting completion status
CREATE TABLE IF NOT EXISTS revision_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    item_code VARCHAR(128) NOT NULL REFERENCES checklist_items(code) ON DELETE CASCADE,
    revision_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    notes_snapshot TEXT,
    outcome VARCHAR(64) DEFAULT 'reviewed',
    still_needs_revision BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 5. Admin Roles & Curriculum Import Drafts
CREATE TABLE IF NOT EXISTS admin_roles (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    role VARCHAR(32) NOT NULL DEFAULT 'admin' CHECK (role IN ('admin', 'curriculum_editor')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS curriculum_drafts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    edition_code VARCHAR(64) NOT NULL REFERENCES textbook_editions(code) ON DELETE CASCADE,
    status VARCHAR(32) NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'under_review', 'approved', 'published')),
    raw_extraction_json JSONB NOT NULL,
    uncertain_flags_json JSONB DEFAULT '[]'::jsonb,
    created_by UUID REFERENCES auth.users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 6. Performance Indexes
CREATE INDEX IF NOT EXISTS idx_units_edition ON units(edition_code);
CREATE INDEX IF NOT EXISTS idx_lessons_unit ON lessons(unit_code);
CREATE INDEX IF NOT EXISTS idx_items_lesson ON checklist_items(lesson_code);
CREATE INDEX IF NOT EXISTS idx_student_progress_student ON student_item_progress(student_id);
CREATE INDEX IF NOT EXISTS idx_student_progress_study_again ON student_item_progress(student_id, study_again);
CREATE INDEX IF NOT EXISTS idx_student_progress_completion ON student_item_progress(student_id, completion_status);
CREATE INDEX IF NOT EXISTS idx_revision_history_student ON revision_history(student_id, item_code);
