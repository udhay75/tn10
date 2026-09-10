-- ==========================================================================
-- 004_seed_math_2025.sql: Tamil Nadu State Board Class 10 Mathematics Seed
-- Idempotent seed script: safe to run multiple times without duplicates.
-- ==========================================================================

-- 1. Expand lesson_type check constraint for multi-subject support
ALTER TABLE lessons DROP CONSTRAINT IF EXISTS lessons_lesson_type_check;
ALTER TABLE lessons ADD CONSTRAINT lessons_lesson_type_check 
  CHECK (lesson_type IN ('prose', 'poem', 'supplementary', 'theory', 'exercise', 'practical', 'review'));

-- 2. Mathematics Subject
INSERT INTO subjects (code, title, class_code, medium_code)
VALUES ('class_10_math', 'Mathematics', 'class_10', 'english')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;

-- 3. Textbook Edition
INSERT INTO textbook_editions (code, subject_code, edition_year, title, source_filename, is_published)
VALUES ('tn10_math_2025_edition', 'class_10_math', 2025, 'Standard Ten Mathematics (Revised Edition 2020, 2021, 2022, 2023, 2025 Reprint 2024)', 'Class_10_Mathematics_English_2025_Edition.pdf', true)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, is_published = EXCLUDED.is_published;

-- 4. Units, Lessons, and Checklist Items
-- Unit 1: Relations and Functions
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_math_u1', 'tn10_math_2025_edition', 1, 'Relations and Functions', 'Ordered Pairs, Cartesian Products, Relations & Function Mappings', 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u1_l1_cartesian_and_relations', 'tn10_math_u1', 1, 'exercise', 'Cartesian Products & Relations', 'Department of School Education, Tamil Nadu', false, 1, 10, 7, 16, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u1_l1_item_ex_1_1', 'tn10_math_u1_l1_cartesian_and_relations', 'source_activity', 'Exercise 1.1', 'Exercise 1.1: Cartesian Products & Ordered Pairs', 'Find A x B, A x A, B x A, non-empty subsets, and verify distributive properties of Cartesian product (Questions 1 to 7).', 6, 12, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u1_l1_item_ex_1_2', 'tn10_math_u1_l1_cartesian_and_relations', 'source_activity', 'Exercise 1.2', 'Exercise 1.2: Relations & Representations', 'Determine whether given relations are subsets of A x B; arrow diagrams, roster form, domain and range (Questions 1 to 5).', 9, 15, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u1_l2_functions_and_types', 'tn10_math_u1', 2, 'exercise', 'Functions & Types of Functions', 'Department of School Education, Tamil Nadu', false, 10, 26, 16, 32, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u1_l2_item_ex_1_3', 'tn10_math_u1_l2_functions_and_types', 'source_activity', 'Exercise 1.3', 'Exercise 1.3: Functions, Domain & Mapping', 'Identify functions, evaluate function values f(x), determine domain and range from algebraic and word formulations (Questions 1 to 10).', 13, 19, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u1_l2_item_ex_1_4', 'tn10_math_u1_l2_functions_and_types', 'source_activity', 'Exercise 1.4', 'Exercise 1.4: Types of Functions & Vertical Line Test', 'Classify one-one, onto, bijection, identity, constant functions; use vertical & horizontal line tests (Questions 1 to 12).', 24, 30, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u1_l3_composition_of_functions', 'tn10_math_u1', 3, 'exercise', 'Composition of Functions & Graphs', 'Department of School Education, Tamil Nadu', false, 26, 31, 32, 37, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u1_l3_item_ex_1_5', 'tn10_math_u1_l3_composition_of_functions', 'source_activity', 'Exercise 1.5', 'Exercise 1.5: Composition of Functions (f o g & g o f)', 'Calculate composite functions f o g and g o f, verify associativity f o (g o h) = (f o g) o h, solve for unknowns (Questions 1 to 10).', 31, 37, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u1_l4_unit_review', 'tn10_math_u1', 4, 'review', 'Unit 1 Review & Assessment', 'Department of School Education, Tamil Nadu', false, 32, 35, 38, 41, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u1_l4_item_ex_1_6_mcq', 'tn10_math_u1_l4_unit_review', 'source_activity', 'Exercise 1.6 (MCQ)', 'Exercise 1.6: Multiple Choice Questions', 'Practice 15 board exam-style objective questions covering relations and functions (Questions 1 to 15).', 32, 38, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u1_l4_item_unit_ex_1', 'tn10_math_u1_l4_unit_review', 'source_activity', 'Unit Exercise 1', 'Unit Exercise - 1: Comprehensive Review Problems', 'High-order thinking skills and comprehensive revision problems for Unit 1 (Questions 1 to 15).', 33, 39, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u1_l4_item_points_to_remember', 'tn10_math_u1_l4_unit_review', 'app_task', 'Points to Remember', 'Points to Remember & Definitions Summary', 'Review key definitions: Cartesian product, relation, function, types of mappings, and composition properties.', 34, 40, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 2: Numbers and Sequences
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_math_u2', 'tn10_math_2025_edition', 2, 'Numbers and Sequences', 'Euclid''s Lemma, Fundamental Theorem of Arithmetic, AP, GP & Special Series', 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u2_l1_euclid_and_fta', 'tn10_math_u2', 1, 'exercise', 'Euclid''s Division & Fundamental Theorem of Arithmetic', 'Department of School Education, Tamil Nadu', false, 36, 46, 42, 52, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l1_item_ex_2_1', 'tn10_math_u2_l1_euclid_and_fta', 'source_activity', 'Exercise 2.1', 'Exercise 2.1: Euclid''s Division Lemma & Algorithm', 'Apply a = bq + r (0 <= r < b) to find HCF and prove properties of positive integers (Questions 1 to 10).', 42, 48, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l1_item_ex_2_2', 'tn10_math_u2_l1_euclid_and_fta', 'source_activity', 'Exercise 2.2', 'Exercise 2.2: Fundamental Theorem of Arithmetic', 'Prime factorizations, finding LCM and HCF, and resolving exponential divisibility questions (Questions 1 to 9).', 46, 52, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u2_l2_modular_and_sequences', 'tn10_math_u2', 2, 'exercise', 'Modular Arithmetic & Sequences', 'Department of School Education, Tamil Nadu', false, 46, 55, 52, 61, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l2_item_ex_2_3', 'tn10_math_u2_l2_modular_and_sequences', 'source_activity', 'Exercise 2.3', 'Exercise 2.3: Modular Arithmetic & Congruence Modulo', 'Solve congruences a ≡ b (mod n), find least positive values of x, and solve time/clock arithmetic (Questions 1 to 9).', 51, 57, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l2_item_ex_2_4', 'tn10_math_u2_l2_modular_and_sequences', 'source_activity', 'Exercise 2.4', 'Exercise 2.4: Sequences & nth Terms', 'Generate terms of sequences, find nth term from recurrence relations and piecewise rules (Questions 1 to 6).', 55, 61, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u2_l3_arithmetic_progression', 'tn10_math_u2', 3, 'exercise', 'Arithmetic Progression & Series (AP)', 'Department of School Education, Tamil Nadu', false, 55, 67, 61, 73, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l3_item_ex_2_5', 'tn10_math_u2_l3_arithmetic_progression', 'source_activity', 'Exercise 2.5', 'Exercise 2.5: Arithmetic Progression (nth term tn = a + (n-1)d)', 'Determine whether sequences are in AP, find first term, common difference, general term tn, and consecutive terms (Questions 1 to 14).', 61, 67, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l3_item_ex_2_6', 'tn10_math_u2_l3_arithmetic_progression', 'source_activity', 'Exercise 2.6', 'Exercise 2.6: Sum of n terms of an AP (Sn)', 'Calculate sum of AP using Sn = n/2(2a + (n-1)d) and Sn = n/2(a + l); solve real-life applied problems (Questions 1 to 12).', 67, 73, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u2_l4_geometric_and_special_series', 'tn10_math_u2', 4, 'exercise', 'Geometric Progression & Special Series', 'Department of School Education, Tamil Nadu', false, 67, 81, 73, 87, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l4_item_ex_2_7', 'tn10_math_u2_l4_geometric_and_special_series', 'source_activity', 'Exercise 2.7', 'Exercise 2.7: Geometric Progression (tn = a*r^(n-1))', 'Identify GP, common ratio r, find general term, solve for terms in continued proportion (Questions 1 to 12).', 72, 78, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l4_item_ex_2_8', 'tn10_math_u2_l4_geometric_and_special_series', 'source_activity', 'Exercise 2.8', 'Exercise 2.8: Sum to n terms of a GP (Sn)', 'Calculate sum of finite and infinite GP series using Sn = a(r^n - 1)/(r - 1) and S∞ = a/(1 - r) (Questions 1 to 10).', 76, 82, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l4_item_ex_2_9', 'tn10_math_u2_l4_geometric_and_special_series', 'source_activity', 'Exercise 2.9', 'Exercise 2.9: Special Series (Sum of n, n², n³)', 'Compute sums of first n natural numbers, odd numbers, squares ∑k², and cubes ∑k³ (Questions 1 to 7).', 81, 87, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u2_l5_unit_review', 'tn10_math_u2', 5, 'review', 'Unit 2 Review & Assessment', 'Department of School Education, Tamil Nadu', false, 82, 84, 88, 90, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l5_item_ex_2_10_mcq', 'tn10_math_u2_l5_unit_review', 'source_activity', 'Exercise 2.10 (MCQ)', 'Exercise 2.10: Multiple Choice Questions', '15 objective questions on Euclid''s lemma, modular arithmetic, AP, GP, and series (Questions 1 to 15).', 82, 88, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l5_item_unit_ex_2', 'tn10_math_u2_l5_unit_review', 'source_activity', 'Unit Exercise 2', 'Unit Exercise - 2: Comprehensive Review Problems', 'Challenging review questions on numbers, progressions, and series (Questions 1 to 15).', 83, 89, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u2_l5_item_points_to_remember', 'tn10_math_u2_l5_unit_review', 'app_task', 'Points to Remember', 'Points to Remember: Progression Formulas', 'Memorize and review key formulas for AP (tn, Sn), GP (tn, Sn, S∞), and special summation identities.', 83, 89, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 3: Algebra
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_math_u3', 'tn10_math_2025_edition', 3, 'Algebra', 'Linear Systems, GCD/LCM, Rational Expressions, Quadratic Equations, Variations & Matrices', 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u3_l1_linear_and_polynomials', 'tn10_math_u3', 1, 'exercise', 'Linear Systems, GCD & LCM of Polynomials', 'Department of School Education, Tamil Nadu', false, 85, 98, 91, 104, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l1_item_ex_3_1', 'tn10_math_u3_l1_linear_and_polynomials', 'source_activity', 'Exercise 3.1', 'Exercise 3.1: Simultaneous Linear Equations in Three Variables', 'Solve systems of linear equations in three variables using elimination and classify nature of solutions (Questions 1 to 3).', 92, 98, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l1_item_ex_3_2', 'tn10_math_u3_l1_linear_and_polynomials', 'source_activity', 'Exercise 3.2', 'Exercise 3.2: GCD of Polynomials by Long Division', 'Find Greatest Common Divisor (GCD) of polynomials using long division algorithm (Questions 1 to 2).', 96, 102, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l1_item_ex_3_3', 'tn10_math_u3_l1_linear_and_polynomials', 'source_activity', 'Exercise 3.3', 'Exercise 3.3: LCM and Relationship between LCM & GCD', 'Find LCM of polynomials and verify f(x) * g(x) = LCM * GCD (Questions 1 to 4).', 97, 103, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u3_l2_rational_expressions', 'tn10_math_u3', 2, 'exercise', 'Rational Expressions & Square Root of Polynomials', 'Department of School Education, Tamil Nadu', false, 98, 106, 104, 112, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l2_item_ex_3_4', 'tn10_math_u3_l2_rational_expressions', 'source_activity', 'Exercise 3.4', 'Exercise 3.4: Reduction & Excluded Values of Rational Expressions', 'Reduce rational expressions to lowest terms and find excluded values where denominator is zero (Questions 1 to 2).', 99, 105, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l2_item_ex_3_5', 'tn10_math_u3_l2_rational_expressions', 'source_activity', 'Exercise 3.5', 'Exercise 3.5: Multiplication & Division of Rational Expressions', 'Perform multiplication and division on rational algebraic fractions (Questions 1 to 5).', 101, 107, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l2_item_ex_3_6', 'tn10_math_u3_l2_rational_expressions', 'source_activity', 'Exercise 3.6', 'Exercise 3.6: Addition & Subtraction of Rational Expressions', 'Add and subtract rational expressions with like and unlike denominators (Questions 1 to 8).', 103, 109, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l2_item_ex_3_7', 'tn10_math_u3_l2_rational_expressions', 'source_activity', 'Exercise 3.7', 'Exercise 3.7: Square Root of Polynomials by Factorization', 'Find square root of expressions and trinomials using factorization identities (Questions 1 to 2).', 105, 111, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l2_item_ex_3_8', 'tn10_math_u3_l2_rational_expressions', 'source_activity', 'Exercise 3.8', 'Exercise 3.8: Square Root by Division Method (5-Mark Essential)', 'Find square root of 4th degree polynomials using division algorithm and determine unknown coefficients (Questions 1 to 3).', 106, 112, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u3_l3_quadratic_equations', 'tn10_math_u3', 3, 'exercise', 'Quadratic Equations: Methods, Roots & Applied Problems', 'Department of School Education, Tamil Nadu', false, 106, 123, 112, 129, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l3_item_ex_3_9', 'tn10_math_u3_l3_quadratic_equations', 'source_activity', 'Exercise 3.9', 'Exercise 3.9: Formation of Quadratic Equations', 'Form quadratic equations given sum and product of roots x² - (Sum)x + Product = 0 (Questions 1 to 2).', 109, 115, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l3_item_ex_3_10', 'tn10_math_u3_l3_quadratic_equations', 'source_activity', 'Exercise 3.10', 'Exercise 3.10: Solving Quadratic Equations by Factorization', 'Solve quadratic equations by factoring into linear binomials (Questions 1 to 2).', 111, 117, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l3_item_ex_3_11', 'tn10_math_u3_l3_quadratic_equations', 'source_activity', 'Exercise 3.11', 'Exercise 3.11: Completing the Square & Quadratic Formula', 'Solve using method of completing the square and quadratic formula x = (-b ± √(b² - 4ac)) / (2a) (Questions 1 to 3).', 114, 120, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l3_item_ex_3_12', 'tn10_math_u3_l3_quadratic_equations', 'source_activity', 'Exercise 3.12', 'Exercise 3.12: Applied Word Problems on Quadratic Equations', 'Solve real-life word problems involving numbers, speed-distance-time, geometry, and age (Questions 1 to 9).', 116, 122, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l3_item_ex_3_13', 'tn10_math_u3_l3_quadratic_equations', 'source_activity', 'Exercise 3.13', 'Exercise 3.13: Nature of Roots (Discriminant Δ = b² - 4ac)', 'Classify roots as real and unequal, real and equal, or no real roots; solve for unknown parameters (Questions 1 to 5).', 119, 125, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l3_item_ex_3_14', 'tn10_math_u3_l3_quadratic_equations', 'source_activity', 'Exercise 3.14', 'Exercise 3.14: Relation between Roots and Coefficients', 'Evaluate symmetric expressions in α and β (α² + β², α/β + β/α) and construct new quadratic equations (Questions 1 to 6).', 122, 128, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u3_l4_graph_of_variations', 'tn10_math_u3', 4, 'practical', 'Practical Graphs (8-Mark Board Exam Section)', 'Department of School Education, Tamil Nadu', false, 123, 137, 129, 143, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l4_item_ex_3_15', 'tn10_math_u3_l4_graph_of_variations', 'source_activity', 'Exercise 3.15', 'Exercise 3.15: Graph of Variations (Direct & Inverse Variation)', 'Draw graphs of direct variation (y = kx) and inverse variation (xy = k), find constant of variation and interpolate values (Questions 1 to 6).', 129, 135, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l4_item_ex_3_16', 'tn10_math_u3_l4_graph_of_variations', 'source_activity', 'Exercise 3.16', 'Exercise 3.16: Quadratic Graphs & Intersections (Parabolas)', 'Draw graphs of parabolas y = ax² + bx + c and determine roots graphically by solving simultaneously with straight lines (Questions 1 to 8).', 137, 143, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u3_l5_matrices', 'tn10_math_u3', 5, 'exercise', 'Matrices: Order, Operations & Multiplication', 'Department of School Education, Tamil Nadu', false, 137, 154, 143, 160, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l5_item_ex_3_17', 'tn10_math_u3_l5_matrices', 'source_activity', 'Exercise 3.17', 'Exercise 3.17: Matrix Types, Order & Transpose', 'Identify order of matrices, construct matrices from general rules aij, and compute matrix transposes (Questions 1 to 7).', 144, 150, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l5_item_ex_3_18', 'tn10_math_u3_l5_matrices', 'source_activity', 'Exercise 3.18', 'Exercise 3.18: Matrix Addition, Subtraction & Scalar Operations', 'Perform addition and subtraction of conformable matrices, solve matrix equations for X (Questions 1 to 8).', 148, 154, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l5_item_ex_3_19', 'tn10_math_u3_l5_matrices', 'source_activity', 'Exercise 3.19', 'Exercise 3.19: Matrix Multiplication & Properties', 'Verify matrix multiplication compatibility, associative property A(BC) = (AB)C, distributive property, and (AB)ᵀ = BᵀAᵀ (Questions 1 to 13).', 153, 159, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u3_l6_unit_review', 'tn10_math_u3', 6, 'review', 'Unit 3 Review & Assessment', 'Department of School Education, Tamil Nadu', false, 154, 160, 160, 166, 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l6_item_ex_3_20_mcq', 'tn10_math_u3_l6_unit_review', 'source_activity', 'Exercise 3.20 (MCQ)', 'Exercise 3.20: Multiple Choice Questions', '20 high-yield board exam multiple choice questions covering the entire algebra syllabus (Questions 1 to 20).', 154, 160, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l6_item_unit_ex_3', 'tn10_math_u3_l6_unit_review', 'source_activity', 'Unit Exercise 3', 'Unit Exercise - 3: Comprehensive Review Problems', 'Advanced problem-solving across linear systems, rational expressions, quadratic equations, and matrices (Questions 1 to 20).', 156, 162, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u3_l6_item_points_to_remember', 'tn10_math_u3_l6_unit_review', 'app_task', 'Points to Remember', 'Points to Remember: Algebra Formulas & Theorems', 'Consolidated summary of quadratic formulas, discriminant conditions, variation rules, and matrix properties.', 158, 164, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 4: Geometry
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_math_u4', 'tn10_math_2025_edition', 4, 'Geometry', 'Similarity, Thales Theorem, Pythagoras Theorem, Circles, Tangents & Concurrency', 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u4_l1_similarity_and_theorems', 'tn10_math_u4', 1, 'exercise', 'Similarity, Thales Theorem & Angle Bisector Theorem', 'Department of School Education, Tamil Nadu', false, 161, 183, 167, 189, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l1_item_ex_4_1', 'tn10_math_u4_l1_similarity_and_theorems', 'source_activity', 'Exercise 4.1', 'Exercise 4.1: Similarity of Triangles & Criteria', 'Establish similarity using AAA, SAS, SSS criteria; ratio of areas of similar triangles (Questions 1 to 13).', 170, 176, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l1_item_thales_bpt_proof', 'tn10_math_u4_l1_similarity_and_theorems', 'app_task', 'Theorem Study', 'Theorem 1 & 3 Proofs: Thales (BPT) & Angle Bisector Theorems', 'Master statement and formal proofs for Basic Proportionality Theorem (BPT) and Angle Bisector Theorem.', 172, 178, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l1_item_ex_4_2', 'tn10_math_u4_l1_similarity_and_theorems', 'source_activity', 'Exercise 4.2', 'Exercise 4.2: Applications of Thales & Angle Bisector Theorems', 'Apply Thales theorem, converse of Thales theorem, and Angle Bisector theorem to compute unknown lengths (Questions 1 to 14).', 181, 187, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u4_l2_pythagoras_and_circles', 'tn10_math_u4', 2, 'exercise', 'Pythagoras Theorem, Circles & Tangents', 'Department of School Education, Tamil Nadu', false, 183, 198, 189, 204, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l2_item_pythagoras_proof', 'tn10_math_u4_l2_pythagoras_and_circles', 'app_task', 'Theorem Study', 'Theorem 5 Proof: Pythagoras Theorem (Baudhayana Theorem)', 'Learn and memorize the formal proof of Pythagoras Theorem and its converse.', 184, 190, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l2_item_ex_4_3', 'tn10_math_u4_l2_pythagoras_and_circles', 'source_activity', 'Exercise 4.3', 'Exercise 4.3: Applications of Pythagoras Theorem', 'Solve geometrical right-triangle problems, ladders, distances, and prove geometric relations (Questions 1 to 8).', 187, 193, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l2_item_alternate_segment_proof', 'tn10_math_u4_l2_pythagoras_and_circles', 'app_task', 'Theorem Study', 'Theorem 6, Ceva & Menelaus: Tangent & Concurrency Theorems', 'Master Alternate Segment Theorem, chord-tangent power theorems, and concurrency conditions (Ceva & Menelaus).', 190, 196, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l2_item_ex_4_4', 'tn10_math_u4_l2_pythagoras_and_circles', 'source_activity', 'Exercise 4.4', 'Exercise 4.4: Circles, Tangents & Alternate Segment Theorem', 'Calculate tangent lengths, angles in alternate segment, chord intersections, and concurrency (Questions 1 to 16).', 198, 204, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u4_l3_unit_review', 'tn10_math_u4', 3, 'review', 'Unit 4 Review & Practical Geometry Check', 'Department of School Education, Tamil Nadu', false, 199, 202, 205, 208, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l3_item_ex_4_5_mcq', 'tn10_math_u4_l3_unit_review', 'source_activity', 'Exercise 4.5 (MCQ)', 'Exercise 4.5: Multiple Choice Questions', '16 objective geometry questions on similarity, circles, tangents, and theorems (Questions 1 to 16).', 199, 205, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l3_item_unit_ex_4', 'tn10_math_u4_l3_unit_review', 'source_activity', 'Unit Exercise 4', 'Unit Exercise - 4: Comprehensive Geometry Problems', 'Challenging geometric proofs and computations (Questions 1 to 15).', 200, 206, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u4_l3_item_points_to_remember', 'tn10_math_u4_l3_unit_review', 'app_task', 'Points to Remember', 'Points to Remember: Geometric Theorems Summary', 'Review statements of BPT, Angle Bisector, Pythagoras, Alternate Segment, Ceva, and Menelaus theorems.', 201, 207, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 5: Coordinate Geometry
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_math_u5', 'tn10_math_2025_edition', 5, 'Coordinate Geometry', 'Area of Figures, Slope of Lines & Straight Line Equations', 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u5_l1_area_and_collinearity', 'tn10_math_u5', 1, 'exercise', 'Area of Triangle & Quadrilateral', 'Department of School Education, Tamil Nadu', false, 203, 212, 209, 218, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u5_l1_item_ex_5_1', 'tn10_math_u5_l1_area_and_collinearity', 'source_activity', 'Exercise 5.1', 'Exercise 5.1: Area of Triangle, Quadrilateral & Collinearity', 'Calculate area of triangle 1/2[(x1(y2-y3)+...], prove collinearity of three points, and find quadrilateral area (Questions 1 to 11).', 211, 217, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u5_l2_slope_and_straight_lines', 'tn10_math_u5', 2, 'exercise', 'Slope, Inclination & Straight Line Equations', 'Department of School Education, Tamil Nadu', false, 212, 235, 218, 241, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u5_l2_item_ex_5_2', 'tn10_math_u5_l2_slope_and_straight_lines', 'source_activity', 'Exercise 5.2', 'Exercise 5.2: Slope (m = tan θ = (y2-y1)/(x2-x1)), Parallel & Perpendicular Lines', 'Compute slope of lines, use condition for parallel lines (m1 = m2) and perpendicular lines (m1 * m2 = -1) (Questions 1 to 13).', 220, 226, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u5_l2_item_ex_5_3', 'tn10_math_u5_l2_slope_and_straight_lines', 'source_activity', 'Exercise 5.3', 'Exercise 5.3: Straight Line Equations (Forms: Slope-Intercept, Point-Slope, Two-Point, Intercept)', 'Derive line equations using y = mx + c, y - y1 = m(x - x1), (y - y1)/(y2 - y1) = (x - x1)/(x2 - x1), x/a + y/b = 1 (Questions 1 to 14).', 229, 235, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u5_l2_item_ex_5_4', 'tn10_math_u5_l2_slope_and_straight_lines', 'source_activity', 'Exercise 5.4', 'Exercise 5.4: General Form of Straight Line (ax + by + c = 0)', 'Find slope -a/b, y-intercept -c/b, equation of lines parallel (ax+by+k=0) and perpendicular (bx-ay+k=0), and intersection points (Questions 1 to 12).', 235, 241, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u5_l3_unit_review', 'tn10_math_u5', 3, 'review', 'Unit 5 Review & Assessment', 'Department of School Education, Tamil Nadu', false, 235, 238, 241, 244, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u5_l3_item_ex_5_5_mcq', 'tn10_math_u5_l3_unit_review', 'source_activity', 'Exercise 5.5 (MCQ)', 'Exercise 5.5: Multiple Choice Questions', '15 board exam multiple choice questions on area, slopes, and straight line forms (Questions 1 to 15).', 235, 241, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u5_l3_item_unit_ex_5', 'tn10_math_u5_l3_unit_review', 'source_activity', 'Unit Exercise 5', 'Unit Exercise - 5: Coordinate Geometry Problems', 'Comprehensive review questions on triangles, quadrilaterals, medians, altitudes, and straight lines (Questions 1 to 10).', 237, 243, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u5_l3_item_points_to_remember', 'tn10_math_u5_l3_unit_review', 'app_task', 'Points to Remember', 'Points to Remember: Coordinate Geometry Formulas', 'Quick reference for area formulas, slope formulas, line equation forms, and concurrency relations.', 237, 243, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 6: Trigonometry
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_math_u6', 'tn10_math_2025_edition', 6, 'Trigonometry', 'Trigonometric Identities, Heights and Distances', 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u6_l1_identities', 'tn10_math_u6', 1, 'exercise', 'Trigonometric Identities', 'Department of School Education, Tamil Nadu', false, 239, 250, 245, 256, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u6_l1_item_ex_6_1', 'tn10_math_u6_l1_identities', 'source_activity', 'Exercise 6.1', 'Exercise 6.1: Proving Trigonometric Identities', 'Prove trigonometric identities using sin²θ + cos²θ = 1, 1 + tan²θ = sec²θ, 1 + cot²θ = cosec²θ (Questions 1 to 10).', 249, 255, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u6_l2_heights_and_distances', 'tn10_math_u6', 2, 'exercise', 'Heights and Distances (Elevation & Depression)', 'Department of School Education, Tamil Nadu', false, 250, 265, 256, 271, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u6_l2_item_ex_6_2', 'tn10_math_u6_l2_heights_and_distances', 'source_activity', 'Exercise 6.2', 'Exercise 6.2: Angle of Elevation Applications', 'Solve heights and distances problems involving towers, trees, buildings, and kites with angle of elevation (Questions 1 to 6).', 257, 263, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u6_l2_item_ex_6_3', 'tn10_math_u6_l2_heights_and_distances', 'source_activity', 'Exercise 6.3', 'Exercise 6.3: Angle of Depression Applications', 'Calculate heights, depths, and distances using line of sight and angle of depression (Questions 1 to 6).', 261, 267, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u6_l2_item_ex_6_4', 'tn10_math_u6_l2_heights_and_distances', 'source_activity', 'Exercise 6.4', 'Exercise 6.4: Combined Elevation & Depression Problems', 'Solve complex real-life scenarios with both elevation and depression from different observation points (Questions 1 to 5).', 264, 270, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u6_l3_unit_review', 'tn10_math_u6', 3, 'review', 'Unit 6 Review & Assessment', 'Department of School Education, Tamil Nadu', false, 265, 268, 271, 274, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u6_l3_item_ex_6_5_mcq', 'tn10_math_u6_l3_unit_review', 'source_activity', 'Exercise 6.5 (MCQ)', 'Exercise 6.5: Multiple Choice Questions', '14 objective questions on trigonometric identities, angles, and heights and distances (Questions 1 to 14).', 265, 271, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u6_l3_item_unit_ex_6', 'tn10_math_u6_l3_unit_review', 'source_activity', 'Unit Exercise 6', 'Unit Exercise - 6: Trigonometric Review Problems', 'Challenging identity proofs and multi-step height and distance problems (Questions 1 to 15).', 267, 273, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u6_l3_item_points_to_remember', 'tn10_math_u6_l3_unit_review', 'app_task', 'Points to Remember', 'Points to Remember: Trigonometry Values & Identities', 'Memorize trigonometric ratios of standard angles (0°, 30°, 45°, 60°, 90°) and fundamental identities.', 268, 274, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 7: Mensuration
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_math_u7', 'tn10_math_2025_edition', 7, 'Mensuration', 'Surface Area & Volume of Solids, Combined Solids & Conversion of Shapes', 7)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u7_l1_surface_area', 'tn10_math_u7', 1, 'exercise', 'Surface Area of Solids & Frustum', 'Department of School Education, Tamil Nadu', false, 269, 283, 275, 289, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u7_l1_item_ex_7_1', 'tn10_math_u7_l1_surface_area', 'source_activity', 'Exercise 7.1', 'Exercise 7.1: CSA & TSA of Cylinder, Hollow Cylinder, Cone, Sphere, Hemisphere & Frustum', 'Calculate Curved Surface Area (CSA) and Total Surface Area (TSA) of standard 3D solids and frustums (Questions 1 to 10).', 282, 288, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u7_l2_volume_and_combinations', 'tn10_math_u7', 2, 'exercise', 'Volume of Solids, Combined Solids & Conversion', 'Department of School Education, Tamil Nadu', false, 283, 297, 289, 303, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u7_l2_item_ex_7_2', 'tn10_math_u7_l2_volume_and_combinations', 'source_activity', 'Exercise 7.2', 'Exercise 7.2: Volume of Cylinder, Cone, Sphere, Hemisphere & Frustum', 'Compute volume of cylinders, hollow cylinders, cones, spheres, hemispheres, and frustums (Questions 1 to 10).', 290, 296, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u7_l2_item_ex_7_3', 'tn10_math_u7_l2_volume_and_combinations', 'source_activity', 'Exercise 7.3', 'Exercise 7.3: Volume & Surface Area of Combined Solids', 'Solve problems of composite shapes: cylinder surmounted by cone/hemisphere, capsule, tent (Questions 1 to 7).', 294, 300, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u7_l2_item_ex_7_4', 'tn10_math_u7_l2_volume_and_combinations', 'source_activity', 'Exercise 7.4', 'Exercise 7.4: Conversion of Solids from One Shape to Another', 'Calculate dimensions, number of objects formed when melting and recasting solids with unchanged volume (Questions 1 to 8).', 296, 302, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u7_l3_unit_review', 'tn10_math_u7', 3, 'review', 'Unit 7 Review & Assessment', 'Department of School Education, Tamil Nadu', false, 297, 300, 303, 306, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u7_l3_item_ex_7_5_mcq', 'tn10_math_u7_l3_unit_review', 'source_activity', 'Exercise 7.5 (MCQ)', 'Exercise 7.5: Multiple Choice Questions', '15 objective questions on surface areas, volumes, combined solids, and conversion (Questions 1 to 15).', 297, 303, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u7_l3_item_unit_ex_7', 'tn10_math_u7_l3_unit_review', 'source_activity', 'Unit Exercise 7', 'Unit Exercise - 7: Mensuration Word Problems', 'Applied word problems on cost of painting, water rate flowing through pipes, and melting solids (Questions 1 to 15).', 298, 304, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u7_l3_item_points_to_remember', 'tn10_math_u7_l3_unit_review', 'app_task', 'Points to Remember', 'Points to Remember: Mensuration Formulas Table', 'Memorize complete table of CSA, TSA, and Volume formulas for cylinder, cone, sphere, hemisphere, and frustum.', 299, 305, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 8: Statistics and Probability
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_math_u8', 'tn10_math_2025_edition', 8, 'Statistics and Probability', 'Measures of Dispersion, Coefficient of Variation & Probability Theorems', 8)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u8_l1_measures_of_dispersion', 'tn10_math_u8', 1, 'exercise', 'Measures of Dispersion & Coefficient of Variation', 'Department of School Education, Tamil Nadu', false, 301, 316, 307, 322, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u8_l1_item_ex_8_1', 'tn10_math_u8_l1_measures_of_dispersion', 'source_activity', 'Exercise 8.1', 'Exercise 8.1: Range, Standard Deviation (σ) & Variance', 'Calculate range L - S, coefficient of range, standard deviation σ by direct, assumed mean, step deviation methods (Questions 1 to 15).', 313, 319, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u8_l1_item_ex_8_2', 'tn10_math_u8_l1_measures_of_dispersion', 'source_activity', 'Exercise 8.2', 'Exercise 8.2: Coefficient of Variation (C.V. = σ/x̄ * 100%)', 'Compute Coefficient of Variation (C.V.) to compare consistency and stability between data sets (Questions 1 to 8).', 316, 322, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u8_l2_probability', 'tn10_math_u8', 2, 'exercise', 'Probability & Addition Theorem', 'Department of School Education, Tamil Nadu', false, 316, 330, 322, 336, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u8_l2_item_ex_8_3', 'tn10_math_u8_l2_probability', 'source_activity', 'Exercise 8.3', 'Exercise 8.3: Basic Probability, Sample Space & Events', 'Calculate probabilities for tossing coins, rolling dice, pack of cards, and calendar leap year questions (Questions 1 to 13).', 322, 328, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u8_l2_item_ex_8_4', 'tn10_math_u8_l2_probability', 'source_activity', 'Exercise 8.4', 'Exercise 8.4: Addition Theorem of Probability', 'Apply P(A ∪ B) = P(A) + P(B) - P(A ∩ B) and P(A ∪ B ∪ C); mutually exclusive and independent events (Questions 1 to 13).', 329, 335, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_math_u8_l3_unit_review', 'tn10_math_u8', 3, 'review', 'Unit 8 Review & Assessment', 'Department of School Education, Tamil Nadu', false, 330, 333, 336, 339, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u8_l3_item_ex_8_5_mcq', 'tn10_math_u8_l3_unit_review', 'source_activity', 'Exercise 8.5 (MCQ)', 'Exercise 8.5: Multiple Choice Questions', '15 objective questions on standard deviation, variance, coefficient of variation, and probability (Questions 1 to 15).', 330, 336, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u8_l3_item_unit_ex_8', 'tn10_math_u8_l3_unit_review', 'source_activity', 'Unit Exercise 8', 'Unit Exercise - 8: Statistics & Probability Problems', 'Comprehensive problems on variance of altered data, combining groups, and multi-event probabilities (Questions 1 to 15).', 331, 337, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_math_u8_l3_item_points_to_remember', 'tn10_math_u8_l3_unit_review', 'app_task', 'Points to Remember', 'Points to Remember: Statistics & Probability Laws', 'Summary of formulas for standard deviation, variance, C.V., and Addition Theorems of Probability.', 332, 338, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

