-- ============================================================================
-- 002_row_level_security.sql: Supabase Row-Level Security (RLS) Policies
-- Enforces strict multi-tenant student isolation and admin-only curriculum editing.
-- ============================================================================

-- Helper function: Is current user an admin?
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM admin_roles
        WHERE user_id = auth.uid()
        AND role IN ('admin', 'curriculum_editor')
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 1. Enable RLS on all tables
ALTER TABLE boards ENABLE ROW LEVEL SECURITY;
ALTER TABLE classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE mediums ENABLE ROW LEVEL SECURITY;
ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE textbook_editions ENABLE ROW LEVEL SECURITY;
ALTER TABLE units ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE checklist_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_item_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE revision_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE curriculum_drafts ENABLE ROW LEVEL SECURITY;

-- 2. Curriculum Policies (Read for all, write for admin only)
CREATE POLICY "Public and students can read boards"
    ON boards FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage boards"
    ON boards FOR ALL
    USING (is_admin());

CREATE POLICY "Public and students can read classes"
    ON classes FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage classes"
    ON classes FOR ALL
    USING (is_admin());

CREATE POLICY "Public and students can read mediums"
    ON mediums FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage mediums"
    ON mediums FOR ALL
    USING (is_admin());

CREATE POLICY "Public and students can read subjects"
    ON subjects FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage subjects"
    ON subjects FOR ALL
    USING (is_admin());

CREATE POLICY "Students can read published editions"
    ON textbook_editions FOR SELECT
    USING (is_published = true OR is_admin());

CREATE POLICY "Admins can manage textbook editions"
    ON textbook_editions FOR ALL
    USING (is_admin());

CREATE POLICY "Students can read units"
    ON units FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM textbook_editions
            WHERE textbook_editions.code = units.edition_code
            AND (textbook_editions.is_published = true OR is_admin())
        )
    );

CREATE POLICY "Admins can manage units"
    ON units FOR ALL
    USING (is_admin());

CREATE POLICY "Students can read lessons"
    ON lessons FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM units
            JOIN textbook_editions ON textbook_editions.code = units.edition_code
            WHERE units.code = lessons.unit_code
            AND (textbook_editions.is_published = true OR is_admin())
        )
    );

CREATE POLICY "Admins can manage lessons"
    ON lessons FOR ALL
    USING (is_admin());

CREATE POLICY "Students can read checklist items"
    ON checklist_items FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM lessons
            JOIN units ON units.code = lessons.unit_code
            JOIN textbook_editions ON textbook_editions.code = units.edition_code
            WHERE lessons.code = checklist_items.lesson_code
            AND (textbook_editions.is_published = true OR is_admin())
        )
    );

CREATE POLICY "Admins can manage checklist items"
    ON checklist_items FOR ALL
    USING (is_admin());

-- 3. Student Profile Policies
CREATE POLICY "Students can view their own profile"
    ON student_profiles FOR SELECT
    USING (auth.uid() = id OR is_admin());

CREATE POLICY "Students can insert their own profile"
    ON student_profiles FOR INSERT
    WITH CHECK (auth.uid() = id);

CREATE POLICY "Students can update their own profile"
    ON student_profiles FOR UPDATE
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

-- 4. Student Item Progress Policies (Strict Account Isolation)
CREATE POLICY "Students can view only their own progress"
    ON student_item_progress FOR SELECT
    USING (auth.uid() = student_id);

CREATE POLICY "Students can insert their own progress"
    ON student_item_progress FOR INSERT
    WITH CHECK (auth.uid() = student_id);

CREATE POLICY "Students can update only their own progress"
    ON student_item_progress FOR UPDATE
    USING (auth.uid() = student_id)
    WITH CHECK (auth.uid() = student_id);

CREATE POLICY "Students can delete only their own progress"
    ON student_item_progress FOR DELETE
    USING (auth.uid() = student_id);

-- 5. Revision History Policies
CREATE POLICY "Students can view only their own revision history"
    ON revision_history FOR SELECT
    USING (auth.uid() = student_id);

CREATE POLICY "Students can insert their own revision history"
    ON revision_history FOR INSERT
    WITH CHECK (auth.uid() = student_id);

-- 6. Admin Roles Policies
CREATE POLICY "Users can check their own admin role"
    ON admin_roles FOR SELECT
    USING (auth.uid() = user_id);

-- 7. Curriculum Drafts (Admin-only access)
CREATE POLICY "Admins can access curriculum drafts"
    ON curriculum_drafts FOR ALL
    USING (is_admin());
