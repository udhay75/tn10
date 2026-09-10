-- ==========================================================================
-- 005_seed_science_2024.sql: Tamil Nadu State Board Class 10 Science Seed
-- Idempotent seed script: safe to run multiple times without duplicates.
-- ==========================================================================

-- 1. Science Subject
INSERT INTO subjects (code, title, class_code, medium_code)
VALUES ('class_10_science', 'Science', 'class_10', 'english')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;

-- 2. Textbook Edition
INSERT INTO textbook_editions (code, subject_code, edition_year, title, source_filename, is_published)
VALUES ('tn10_sci_2024_edition', 'class_10_science', 2024, 'Standard Ten Science (Revised Edition 2020, 2022, 2023, Reprint 2021, 2024)', 'Class_10_Science_English_2024_Edition.pdf', true)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, is_published = EXCLUDED.is_published;

-- 3. Units, Lessons, and Checklist Items
-- Unit 1: Unit 1: Laws of Motion
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u1', 'tn10_sci_2024_edition', 1, 'Unit 1: Laws of Motion', 'Physics: Inertia, Linear Momentum, Newton''s Laws, Gravitation & Mass vs Weight', 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u1_l1_theory_and_concepts', 'tn10_sci_u1', 1, 'theory', 'Laws of Motion: Core Concepts & Theory', 'Tamil Nadu State Board (Physics)', false, 1, 12, 9, 20, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u1_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u1_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Laws of Motion', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Laws of Motion.', 1, 9, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u1_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u1_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Laws of Motion.', 2, 10, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u1_l2_textbook_evaluation', 'tn10_sci_u1', 2, 'exercise', 'Laws of Motion: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Physics)', false, 13, 15, 21, 23, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u1_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u1_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 1.', 13, 21, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u1_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u1_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 1.', 14, 22, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u1_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u1_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 1.', 15, 23, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 2: Unit 2: Optics
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u2', 'tn10_sci_2024_edition', 2, 'Unit 2: Optics', 'Physics: Light Properties, Refraction, Lenses, Optical Instruments & Human Eye', 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u2_l1_theory_and_concepts', 'tn10_sci_u2', 1, 'theory', 'Optics: Core Concepts & Theory', 'Tamil Nadu State Board (Physics)', false, 16, 28, 24, 36, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u2_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u2_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Optics', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Optics.', 16, 24, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u2_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u2_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Optics.', 17, 25, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u2_l2_textbook_evaluation', 'tn10_sci_u2', 2, 'exercise', 'Optics: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Physics)', false, 29, 31, 37, 39, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u2_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u2_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 2.', 29, 37, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u2_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u2_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 2.', 30, 38, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u2_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u2_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 2.', 31, 39, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 3: Unit 3: Thermal Physics
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u3', 'tn10_sci_2024_edition', 3, 'Unit 3: Thermal Physics', 'Physics: Heat, Temperature, Gas Laws (Boyle, Charles, Avogadro) & Absolute Scale', 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u3_l1_theory_and_concepts', 'tn10_sci_u3', 1, 'theory', 'Thermal Physics: Core Concepts & Theory', 'Tamil Nadu State Board (Physics)', false, 32, 38, 40, 46, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u3_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u3_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Thermal Physics', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Thermal Physics.', 32, 40, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u3_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u3_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Thermal Physics.', 33, 41, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u3_l2_textbook_evaluation', 'tn10_sci_u3', 2, 'exercise', 'Thermal Physics: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Physics)', false, 39, 41, 47, 49, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u3_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u3_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 3.', 39, 47, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u3_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u3_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 3.', 40, 48, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u3_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u3_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 3.', 41, 49, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 4: Unit 4: Electricity
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u4', 'tn10_sci_2024_edition', 4, 'Unit 4: Electricity', 'Physics: Electric Current, Potential, Ohm''s Law, Resistance in Circuits & Heating Effect', 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u4_l1_theory_and_concepts', 'tn10_sci_u4', 1, 'theory', 'Electricity: Core Concepts & Theory', 'Tamil Nadu State Board (Physics)', false, 42, 54, 50, 62, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u4_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u4_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Electricity', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Electricity.', 42, 50, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u4_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u4_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Electricity.', 43, 51, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u4_l2_textbook_evaluation', 'tn10_sci_u4', 2, 'exercise', 'Electricity: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Physics)', false, 55, 58, 63, 66, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u4_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u4_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 4.', 55, 63, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u4_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u4_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 4.', 56, 64, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u4_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u4_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 4.', 58, 66, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 5: Unit 5: Acoustics
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u5', 'tn10_sci_2024_edition', 5, 'Unit 5: Acoustics', 'Physics: Sound Waves, Velocity, Reflection, Echoes, Doppler Effect & Applications', 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u5_l1_theory_and_concepts', 'tn10_sci_u5', 1, 'theory', 'Acoustics: Core Concepts & Theory', 'Tamil Nadu State Board (Physics)', false, 59, 69, 67, 77, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u5_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u5_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Acoustics', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Acoustics.', 59, 67, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u5_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u5_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Acoustics.', 60, 68, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u5_l2_textbook_evaluation', 'tn10_sci_u5', 2, 'exercise', 'Acoustics: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Physics)', false, 70, 73, 78, 81, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u5_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u5_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 5.', 70, 78, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u5_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u5_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 5.', 71, 79, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u5_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u5_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 5.', 73, 81, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 6: Unit 6: Nuclear Physics
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u6', 'tn10_sci_2024_edition', 6, 'Unit 6: Nuclear Physics', 'Physics: Radioactivity, Alpha/Beta/Gamma Rays, Nuclear Fission & Fusion, Safety', 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u6_l1_theory_and_concepts', 'tn10_sci_u6', 1, 'theory', 'Nuclear Physics: Core Concepts & Theory', 'Tamil Nadu State Board (Physics)', false, 74, 85, 82, 93, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u6_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u6_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Nuclear Physics', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Nuclear Physics.', 74, 82, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u6_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u6_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Nuclear Physics.', 75, 83, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u6_l2_textbook_evaluation', 'tn10_sci_u6', 2, 'exercise', 'Nuclear Physics: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Physics)', false, 86, 90, 94, 98, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u6_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u6_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 6.', 86, 94, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u6_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u6_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 6.', 87, 95, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u6_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u6_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 6.', 90, 98, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 7: Unit 7: Atoms and Molecules
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u7', 'tn10_sci_2024_edition', 7, 'Unit 7: Atoms and Molecules', 'Chemistry: Atomic Mass, Molecular Mass, Mole Concept & Avogadro''s Number', 7)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u7_l1_theory_and_concepts', 'tn10_sci_u7', 1, 'theory', 'Atoms and Molecules: Core Concepts & Theory', 'Tamil Nadu State Board (Chemistry)', false, 91, 101, 99, 109, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u7_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u7_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Atoms and Molecules', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Atoms and Molecules.', 91, 99, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u7_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u7_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Atoms and Molecules.', 92, 100, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u7_l2_textbook_evaluation', 'tn10_sci_u7', 2, 'exercise', 'Atoms and Molecules: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Chemistry)', false, 102, 105, 110, 113, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u7_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u7_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 7.', 102, 110, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u7_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u7_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 7.', 103, 111, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u7_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u7_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 7.', 105, 113, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 8: Unit 8: Periodic Classification of Elements
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u8', 'tn10_sci_2024_edition', 8, 'Unit 8: Periodic Classification of Elements', 'Chemistry: Modern Periodic Table, Periodic Trends & Metallurgy', 8)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u8_l1_theory_and_concepts', 'tn10_sci_u8', 1, 'theory', 'Periodic Classification of Elements: Core Concepts & Theory', 'Tamil Nadu State Board (Chemistry)', false, 106, 120, 114, 128, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u8_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u8_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Periodic Classification of Elements', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Periodic Classification of Elements.', 106, 114, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u8_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u8_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Periodic Classification of Elements.', 107, 115, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u8_l2_textbook_evaluation', 'tn10_sci_u8', 2, 'exercise', 'Periodic Classification of Elements: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Chemistry)', false, 121, 123, 129, 131, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u8_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u8_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 8.', 121, 129, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u8_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u8_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 8.', 122, 130, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u8_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u8_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 8.', 123, 131, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 9: Unit 9: Solutions
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u9', 'tn10_sci_2024_edition', 9, 'Unit 9: Solutions', 'Chemistry: Solute, Solvent, Solubility Factors, Concentration of Solutions & Hydration', 9)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u9_l1_theory_and_concepts', 'tn10_sci_u9', 1, 'theory', 'Solutions: Core Concepts & Theory', 'Tamil Nadu State Board (Chemistry)', false, 124, 133, 132, 141, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u9_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u9_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Solutions', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Solutions.', 124, 132, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u9_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u9_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Solutions.', 125, 133, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u9_l2_textbook_evaluation', 'tn10_sci_u9', 2, 'exercise', 'Solutions: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Chemistry)', false, 134, 136, 142, 144, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u9_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u9_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 9.', 134, 142, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u9_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u9_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 9.', 135, 143, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u9_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u9_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 9.', 136, 144, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 10: Unit 10: Types of Chemical Reactions
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u10', 'tn10_sci_2024_edition', 10, 'Unit 10: Types of Chemical Reactions', 'Chemistry: Combination, Decomposition, Displacement, Neutralization & pH Scale', 10)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u10_l1_theory_and_concepts', 'tn10_sci_u10', 1, 'theory', 'Types of Chemical Reactions: Core Concepts & Theory', 'Tamil Nadu State Board (Chemistry)', false, 137, 151, 145, 159, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u10_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u10_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Types of Chemical Reactions', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Types of Chemical Reactions.', 137, 145, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u10_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u10_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Types of Chemical Reactions.', 138, 146, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u10_l2_textbook_evaluation', 'tn10_sci_u10', 2, 'exercise', 'Types of Chemical Reactions: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Chemistry)', false, 152, 154, 160, 162, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u10_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u10_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 10.', 152, 160, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u10_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u10_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 10.', 153, 161, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u10_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u10_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 10.', 154, 162, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 11: Unit 11: Carbon and its Compounds
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u11', 'tn10_sci_2024_edition', 11, 'Unit 11: Carbon and its Compounds', 'Chemistry: Bonding, Allotropy, Hydrocarbons, Functional Groups & Soaps/Detergents', 11)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u11_l1_theory_and_concepts', 'tn10_sci_u11', 1, 'theory', 'Carbon and its Compounds: Core Concepts & Theory', 'Tamil Nadu State Board (Chemistry)', false, 155, 169, 163, 177, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u11_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u11_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Carbon and its Compounds', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Carbon and its Compounds.', 155, 163, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u11_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u11_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Carbon and its Compounds.', 156, 164, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u11_l2_textbook_evaluation', 'tn10_sci_u11', 2, 'exercise', 'Carbon and its Compounds: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Chemistry)', false, 170, 172, 178, 180, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u11_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u11_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 11.', 170, 178, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u11_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u11_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 11.', 171, 179, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u11_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u11_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 11.', 172, 180, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 12: Unit 12: Plant Anatomy and Plant Physiology
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u12', 'tn10_sci_2024_edition', 12, 'Unit 12: Plant Anatomy and Plant Physiology', 'Biology: Internal Plant Tissues, Chloroplasts, Photosynthesis & Respiration', 12)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u12_l1_theory_and_concepts', 'tn10_sci_u12', 1, 'theory', 'Plant Anatomy and Plant Physiology: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 173, 183, 181, 191, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u12_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u12_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Plant Anatomy and Plant Physiology', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Plant Anatomy and Plant Physiology.', 173, 181, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u12_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u12_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Plant Anatomy and Plant Physiology.', 174, 182, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u12_l2_textbook_evaluation', 'tn10_sci_u12', 2, 'exercise', 'Plant Anatomy and Plant Physiology: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 184, 186, 192, 194, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u12_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u12_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 12.', 184, 192, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u12_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u12_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 12.', 185, 193, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u12_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u12_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 12.', 186, 194, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 13: Unit 13: Structural Organisation of Animals
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u13', 'tn10_sci_2024_edition', 13, 'Unit 13: Structural Organisation of Animals', 'Biology: Morphology and Anatomy of Leech and Rabbit', 13)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u13_l1_theory_and_concepts', 'tn10_sci_u13', 1, 'theory', 'Structural Organisation of Animals: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 187, 196, 195, 204, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u13_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u13_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Structural Organisation of Animals', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Structural Organisation of Animals.', 187, 195, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u13_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u13_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Structural Organisation of Animals.', 188, 196, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u13_l2_textbook_evaluation', 'tn10_sci_u13', 2, 'exercise', 'Structural Organisation of Animals: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 197, 199, 205, 207, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u13_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u13_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 13.', 197, 205, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u13_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u13_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 13.', 198, 206, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u13_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u13_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 13.', 199, 207, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 14: Unit 14: Transportation in Plants and Circulation in Animals
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u14', 'tn10_sci_2024_edition', 14, 'Unit 14: Transportation in Plants and Circulation in Animals', 'Biology: Xylem/Phloem, Ascent of Sap, Blood Components, Heart & Cardiac Cycle', 14)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u14_l1_theory_and_concepts', 'tn10_sci_u14', 1, 'theory', 'Transportation in Plants and Circulation in Animals: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 200, 212, 208, 220, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u14_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u14_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Transportation in Plants and Circulation in Animals', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Transportation in Plants and Circulation in Animals.', 200, 208, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u14_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u14_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Transportation in Plants and Circulation in Animals.', 201, 209, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u14_l2_textbook_evaluation', 'tn10_sci_u14', 2, 'exercise', 'Transportation in Plants and Circulation in Animals: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 213, 217, 221, 225, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u14_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u14_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 14.', 213, 221, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u14_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u14_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 14.', 214, 222, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u14_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u14_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 14.', 217, 225, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 15: Unit 15: Nervous System
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u15', 'tn10_sci_2024_edition', 15, 'Unit 15: Nervous System', 'Biology: Neurons, Central/Peripheral/Autonomic Nervous System & Reflex Arc', 15)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u15_l1_theory_and_concepts', 'tn10_sci_u15', 1, 'theory', 'Nervous System: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 218, 225, 226, 233, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u15_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u15_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Nervous System', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Nervous System.', 218, 226, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u15_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u15_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Nervous System.', 219, 227, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u15_l2_textbook_evaluation', 'tn10_sci_u15', 2, 'exercise', 'Nervous System: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 226, 228, 234, 236, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u15_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u15_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 15.', 226, 234, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u15_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u15_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 15.', 227, 235, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u15_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u15_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 15.', 228, 236, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 16: Unit 16: Plant and Animal Hormones
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u16', 'tn10_sci_2024_edition', 16, 'Unit 16: Plant and Animal Hormones', 'Biology: Phytohormones (Auxin, Gibberellin) & Human Endocrine Glands', 16)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u16_l1_theory_and_concepts', 'tn10_sci_u16', 1, 'theory', 'Plant and Animal Hormones: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 229, 238, 237, 246, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u16_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u16_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Plant and Animal Hormones', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Plant and Animal Hormones.', 229, 237, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u16_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u16_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Plant and Animal Hormones.', 230, 238, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u16_l2_textbook_evaluation', 'tn10_sci_u16', 2, 'exercise', 'Plant and Animal Hormones: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 239, 242, 247, 250, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u16_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u16_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 16.', 239, 247, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u16_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u16_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 16.', 240, 248, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u16_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u16_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 16.', 242, 250, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 17: Unit 17: Reproduction in Plants and Animals
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u17', 'tn10_sci_2024_edition', 17, 'Unit 17: Reproduction in Plants and Animals', 'Biology: Vegetative/Asexual/Sexual Reproduction, Pollination & Menstrual Cycle', 17)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u17_l1_theory_and_concepts', 'tn10_sci_u17', 1, 'theory', 'Reproduction in Plants and Animals: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 243, 255, 251, 263, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u17_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u17_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Reproduction in Plants and Animals', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Reproduction in Plants and Animals.', 243, 251, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u17_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u17_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Reproduction in Plants and Animals.', 244, 252, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u17_l2_textbook_evaluation', 'tn10_sci_u17', 2, 'exercise', 'Reproduction in Plants and Animals: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 256, 260, 264, 268, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u17_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u17_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 17.', 256, 264, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u17_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u17_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 17.', 257, 265, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u17_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u17_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 17.', 260, 268, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 18: Unit 18: Genetics
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u18', 'tn10_sci_2024_edition', 18, 'Unit 18: Genetics', 'Biology: Mendel''s Laws of Inheritance, Monohybrid/Dihybrid Crosses, DNA Structure & Chromosomes', 18)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u18_l1_theory_and_concepts', 'tn10_sci_u18', 1, 'theory', 'Genetics: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 261, 270, 269, 278, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u18_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u18_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Genetics', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Genetics.', 261, 269, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u18_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u18_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Genetics.', 262, 270, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u18_l2_textbook_evaluation', 'tn10_sci_u18', 2, 'exercise', 'Genetics: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 271, 273, 279, 281, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u18_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u18_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 18.', 271, 279, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u18_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u18_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 18.', 272, 280, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u18_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u18_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 18.', 273, 281, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 19: Unit 19: Origin and Evolution of Life
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u19', 'tn10_sci_2024_edition', 19, 'Unit 19: Origin and Evolution of Life', 'Biology: Theories of Evolution, Lamarckism, Darwinism, Fossils & Ethnobotany', 19)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u19_l1_theory_and_concepts', 'tn10_sci_u19', 1, 'theory', 'Origin and Evolution of Life: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 274, 281, 282, 289, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u19_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u19_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Origin and Evolution of Life', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Origin and Evolution of Life.', 274, 282, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u19_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u19_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Origin and Evolution of Life.', 275, 283, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u19_l2_textbook_evaluation', 'tn10_sci_u19', 2, 'exercise', 'Origin and Evolution of Life: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 282, 285, 290, 293, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u19_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u19_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 19.', 282, 290, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u19_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u19_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 19.', 283, 291, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u19_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u19_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 19.', 285, 293, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 20: Unit 20: Breeding and Biotechnology
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u20', 'tn10_sci_2024_edition', 20, 'Unit 20: Breeding and Biotechnology', 'Biology: Plant/Animal Breeding, Hybridization, Genetic Engineering & Stem Cells', 20)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u20_l1_theory_and_concepts', 'tn10_sci_u20', 1, 'theory', 'Breeding and Biotechnology: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 286, 295, 294, 303, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u20_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u20_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Breeding and Biotechnology', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Breeding and Biotechnology.', 286, 294, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u20_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u20_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Breeding and Biotechnology.', 287, 295, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u20_l2_textbook_evaluation', 'tn10_sci_u20', 2, 'exercise', 'Breeding and Biotechnology: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 296, 299, 304, 307, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u20_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u20_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 20.', 296, 304, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u20_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u20_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 20.', 297, 305, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u20_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u20_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 20.', 299, 307, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 21: Unit 21: Health and Diseases
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u21', 'tn10_sci_2024_edition', 21, 'Unit 21: Health and Diseases', 'Biology: Communicable Diseases, Non-communicable Disorders, Lifestyle & Drug Abuse', 21)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u21_l1_theory_and_concepts', 'tn10_sci_u21', 1, 'theory', 'Health and Diseases: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 300, 310, 308, 318, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u21_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u21_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Health and Diseases', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Health and Diseases.', 300, 308, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u21_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u21_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Health and Diseases.', 301, 309, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u21_l2_textbook_evaluation', 'tn10_sci_u21', 2, 'exercise', 'Health and Diseases: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 311, 314, 319, 322, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u21_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u21_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 21.', 311, 319, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u21_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u21_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 21.', 312, 320, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u21_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u21_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 21.', 314, 322, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 22: Unit 22: Environmental Management
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u22', 'tn10_sci_2024_edition', 22, 'Unit 22: Environmental Management', 'Biology: Forest/Wildlife Conservation, Water Harvesting, Renewable Energy & Waste Management', 22)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u22_l1_theory_and_concepts', 'tn10_sci_u22', 1, 'theory', 'Environmental Management: Core Concepts & Theory', 'Tamil Nadu State Board (Biology)', false, 315, 325, 323, 333, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u22_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u22_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Environmental Management', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Environmental Management.', 315, 323, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u22_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u22_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Environmental Management.', 316, 324, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u22_l2_textbook_evaluation', 'tn10_sci_u22', 2, 'exercise', 'Environmental Management: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Biology)', false, 326, 328, 334, 336, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u22_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u22_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 22.', 326, 334, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u22_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u22_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 22.', 327, 335, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u22_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_sci_u22_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & HOTS (Parts VII–IX)', 'Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)', 'Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit 22.', 328, 336, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 23: Unit 23: Visual Communication
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_u23', 'tn10_sci_2024_edition', 23, 'Unit 23: Visual Communication', 'Computer Science: Scratch Software, Animation, Scripting & Graphic Tools', 23)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u23_l1_theory_and_concepts', 'tn10_sci_u23', 1, 'theory', 'Visual Communication: Core Concepts & Theory', 'Tamil Nadu State Board (Computer Science)', false, 329, 332, 337, 340, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u23_l1_theory_and_concepts_item_1_concept_reading', 'tn10_sci_u23_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Visual Communication', 'Study the foundational principles, definitions, laws, and chemical/biological mechanisms of Visual Communication.', 329, 337, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u23_l1_theory_and_concepts_item_2_activities_and_examples', 'tn10_sci_u23_l1_theory_and_concepts', 'source_activity', 'In-text Activities & Examples', 'In-text Activities, Key Diagrams & Solved Examples', 'Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for Visual Communication.', 330, 338, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_u23_l2_textbook_evaluation', 'tn10_sci_u23', 2, 'exercise', 'Visual Communication: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Computer Science)', false, 333, 333, 341, 341, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u23_l2_textbook_evaluation_item_1_objective_questions', 'tn10_sci_u23_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Parts I–V)', 'Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason', 'Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit 23.', 333, 341, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_u23_l2_textbook_evaluation_item_2_short_answers', 'tn10_sci_u23_l2_textbook_evaluation', 'source_activity', 'Short Answers (Part VI)', 'Part VI: Short Answer Questions (2-Mark Questions)', 'Answer all concise scientific reasoning and short conceptual questions for Unit 23.', 333, 341, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 24: Science Practicals & Laboratory Experiments
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_sci_practicals', 'tn10_sci_2024_edition', 24, 'Science Practicals & Laboratory Experiments', 'Physics, Chemistry & Biology Laboratory Experiments for Public Practical Exam', 24)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_practicals_l1_physics_chemistry', 'tn10_sci_practicals', 1, 'practical', 'Physics & Chemistry Practicals', 'Tamil Nadu State Board (Laboratory Manual)', false, 334, 341, 342, 349, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_prac_item_physics', 'tn10_sci_practicals_l1_physics_chemistry', 'source_activity', 'Physics Practicals', 'Physics Experiments: Principle of Moments, Convex Lens & Ohm''s Law', 'Perform determination of weight using principle of moments, focal length of convex lens, and resistance verification of Ohm''s law.', 335, 343, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_prac_item_chemistry', 'tn10_sci_practicals_l1_physics_chemistry', 'source_activity', 'Chemistry Practicals', 'Chemistry Experiments: Exothermic/Endothermic Dissolution & Water of Hydration', 'Test dissolution of salts (exothermic vs endothermic), water of crystallization in copper sulphate, and testing pH of solutions.', 339, 347, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_sci_practicals_l2_biology', 'tn10_sci_practicals', 2, 'practical', 'Biology Practicals', 'Tamil Nadu State Board (Laboratory Manual)', false, 342, 349, 350, 357, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_prac_item_photosynthesis', 'tn10_sci_practicals_l2_biology', 'source_activity', 'Botany Practicals', 'Biology Experiment: Oxygen Evolution in Photosynthesis (Hydrilla Funnel)', 'Prove that oxygen is released during photosynthesis using Hydrilla plant and test-tube funnel setup.', 342, 350, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_sci_prac_item_anatomy_slides', 'tn10_sci_practicals_l2_biology', 'source_activity', 'Zoology/Anatomy Slides', 'Biology Identification: Blood Cells, Dicot Stem & Mammalian Heart', 'Identify and draw permanent slides of human blood cells, transverse section of dicot stem, and structure of heart.', 345, 353, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

