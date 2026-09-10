-- ==========================================================================
-- 006_seed_social_science_2025.sql: Tamil Nadu State Board Class 10 Social Science Seed
-- Idempotent seed script: safe to run multiple times without duplicates.
-- ==========================================================================

-- 1. Expand lesson_type check constraint
ALTER TABLE lessons DROP CONSTRAINT IF EXISTS lessons_lesson_type_check;
ALTER TABLE lessons ADD CONSTRAINT lessons_lesson_type_check 
  CHECK (lesson_type IN ('prose', 'poem', 'supplementary', 'theory', 'exercise', 'practical', 'review', 'map_work'));

-- 2. Social Science Subject
INSERT INTO subjects (code, title, class_code, medium_code)
VALUES ('class_10_social_science', 'Social Science', 'class_10', 'english')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;

-- 3. Textbook Edition
INSERT INTO textbook_editions (code, subject_code, edition_year, title, source_filename, is_published)
VALUES ('tn10_soc_2025_edition', 'class_10_social_science', 2025, 'Standard Ten Social Science (Revised Edition 2020, 2022, 2023, 2025, Reprint 2021, 2024)', 'Class_10_Social_Science_English_2025_Edition.pdf', true)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, is_published = EXCLUDED.is_published;

-- 4. Units, Lessons, and Checklist Items
-- Unit 1: Unit 1: Outbreak of World War I and Its Aftermath
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u1', 'tn10_soc_2025_edition', 1, 'Unit 1: Outbreak of World War I and Its Aftermath', 'History: European Imperialism, Balkan Crisis, World War I, Russian Revolution & League of Nations', 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u1_l1_theory_and_concepts', 'tn10_soc_u1', 1, 'theory', 'Outbreak of World War I and Its Aftermath: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 1, 13, 7, 19, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u1_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u1_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Outbreak of World War I and Its Aftermath', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Outbreak of World War I and Its Aftermath.', 1, 7, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u1_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u1_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Outbreak of World War I and Its Aftermath.', 2, 8, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u1_l2_textbook_evaluation', 'tn10_soc_u1', 2, 'exercise', 'Outbreak of World War I and Its Aftermath: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 14, 15, 20, 21, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u1_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u1_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 1.', 14, 20, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u1_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u1_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 1.', 15, 21, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u1_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u1_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 1.', 15, 21, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u1_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u1_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Outbreak of World War I and Its Aftermath', 'Practice marking key exam locations on outline maps: World Map: European belligerents (Britain, France, Germany, Italy, Austria-Hungary), Balkans & Gallipoli; Timeline (1914–1919).', 15, 21, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 2: Unit 2: The World between two World Wars
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u2', 'tn10_soc_2025_edition', 2, 'Unit 2: The World between two World Wars', 'History: Great Depression, Rise of Fascism in Italy (Mussolini), Nazism in Germany (Hitler) & Anti-Colonial Struggle', 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u2_l1_theory_and_concepts', 'tn10_soc_u2', 1, 'theory', 'The World between two World Wars: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 16, 24, 22, 30, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u2_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u2_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: The World between two World Wars', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of The World between two World Wars.', 16, 22, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u2_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u2_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for The World between two World Wars.', 17, 23, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u2_l2_textbook_evaluation', 'tn10_soc_u2', 2, 'exercise', 'The World between two World Wars: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 25, 26, 31, 32, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u2_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u2_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 2.', 25, 31, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u2_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u2_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 2.', 26, 32, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u2_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u2_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 2.', 26, 32, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u2_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u2_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: The World between two World Wars', 'Practice marking key exam locations on outline maps: World Map: Axis & Allied spheres, Germany, Italy, Manchuria & Ethiopia; Timeline (1919–1939).', 26, 32, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 3: Unit 3: World War II
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u3', 'tn10_soc_2025_edition', 3, 'Unit 3: World War II', 'History: Outbreak of WWII, Blitzkrieg, Battle of Stalingrad, Holocaust, Pearl Harbor, Hiroshima-Nagasaki & UNO', 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u3_l1_theory_and_concepts', 'tn10_soc_u3', 1, 'theory', 'World War II: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 27, 36, 33, 42, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u3_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u3_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: World War II', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of World War II.', 27, 33, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u3_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u3_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for World War II.', 28, 34, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u3_l2_textbook_evaluation', 'tn10_soc_u3', 2, 'exercise', 'World War II: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 37, 39, 43, 45, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u3_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u3_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 3.', 37, 43, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u3_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u3_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 3.', 38, 44, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u3_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u3_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 3.', 39, 45, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u3_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u3_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: World War II', 'Practice marking key exam locations on outline maps: World Map: Major Pacific & European battlefronts, Normandy, Pearl Harbor, Hiroshima, Nagasaki; Timeline (1939–1945).', 39, 45, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 4: Unit 4: The World after World War II
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u4', 'tn10_soc_2025_edition', 4, 'Unit 4: The World after World War II', 'History: Cold War, NATO vs Warsaw Pact, Non-Aligned Movement (NAM), Decolonization in Asia/Africa & European Union', 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u4_l1_theory_and_concepts', 'tn10_soc_u4', 1, 'theory', 'The World after World War II: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 40, 49, 46, 55, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u4_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u4_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: The World after World War II', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of The World after World War II.', 40, 46, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u4_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u4_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for The World after World War II.', 41, 47, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u4_l2_textbook_evaluation', 'tn10_soc_u4', 2, 'exercise', 'The World after World War II: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 50, 52, 56, 58, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u4_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u4_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 4.', 50, 56, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u4_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u4_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 4.', 51, 57, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u4_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u4_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 4.', 52, 58, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u4_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u4_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: The World after World War II', 'Practice marking key exam locations on outline maps: World Map: Cold War blocs, NATO members, Warsaw pact, Non-Aligned nations.', 52, 58, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 5: Unit 5: Social and Religious Reform Movements in the 19th Century
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u5', 'tn10_soc_2025_edition', 5, 'Unit 5: Social and Religious Reform Movements in the 19th Century', 'History: Brahmo Samaj, Arya Samaj, Ramakrishna Mission, Theosophical Society, Jyotiba Phule, Narayana Guru & Tamil Reformers', 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u5_l1_theory_and_concepts', 'tn10_soc_u5', 1, 'theory', 'Social and Religious Reform Movements in the 19th Century: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 53, 60, 59, 66, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u5_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u5_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Social and Religious Reform Movements in the 19th Century', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Social and Religious Reform Movements in the 19th Century.', 53, 59, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u5_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u5_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Social and Religious Reform Movements in the 19th Century.', 54, 60, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u5_l2_textbook_evaluation', 'tn10_soc_u5', 2, 'exercise', 'Social and Religious Reform Movements in the 19th Century: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 61, 62, 67, 68, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u5_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u5_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 5.', 61, 67, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u5_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u5_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 5.', 62, 68, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u5_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u5_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 5.', 62, 68, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u5_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u5_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Social and Religious Reform Movements in the 19th Century', 'Practice marking key exam locations on outline maps: India Map: Centers of socio-religious reforms (Calcutta, Bombay, Madras, Poona, Varanasi, Aligarh).', 62, 68, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 6: Unit 6: Early Revolts against British Rule in Tamil Nadu
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u6', 'tn10_soc_2025_edition', 6, 'Unit 6: Early Revolts against British Rule in Tamil Nadu', 'History: Palayakkarar Rebellion, Puli Thevar, Veerapandiya Kattabomman, Velu Nachiyar, Marudu Brothers & Vellore Revolt of 1806', 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u6_l1_theory_and_concepts', 'tn10_soc_u6', 1, 'theory', 'Early Revolts against British Rule in Tamil Nadu: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 63, 72, 69, 78, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u6_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u6_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Early Revolts against British Rule in Tamil Nadu', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Early Revolts against British Rule in Tamil Nadu.', 63, 69, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u6_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u6_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Early Revolts against British Rule in Tamil Nadu.', 64, 70, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u6_l2_textbook_evaluation', 'tn10_soc_u6', 2, 'exercise', 'Early Revolts against British Rule in Tamil Nadu: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 73, 74, 79, 80, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u6_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u6_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 6.', 73, 79, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u6_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u6_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 6.', 74, 80, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u6_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u6_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 6.', 74, 80, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u6_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u6_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Early Revolts against British Rule in Tamil Nadu', 'Practice marking key exam locations on outline maps: Tamil Nadu Map: Palayam centers (Panchalankurichi, Nerkattumseval, Kalakadu, Sivagangai, Vellore Fort).', 74, 80, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 7: Unit 7: Anti-Colonial Movements and the Birth of Nationalism
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u7', 'tn10_soc_2025_edition', 7, 'Unit 7: Anti-Colonial Movements and the Birth of Nationalism', 'History: 1857 Great Rebellion, Peasant & Tribal Uprisings (Santhal, Munda), Foundation of INC, Moderates vs Extremists & Partition of Bengal', 7)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u7_l1_theory_and_concepts', 'tn10_soc_u7', 1, 'theory', 'Anti-Colonial Movements and the Birth of Nationalism: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 75, 85, 81, 91, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u7_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u7_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Anti-Colonial Movements and the Birth of Nationalism', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Anti-Colonial Movements and the Birth of Nationalism.', 75, 81, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u7_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u7_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Anti-Colonial Movements and the Birth of Nationalism.', 76, 82, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u7_l2_textbook_evaluation', 'tn10_soc_u7', 2, 'exercise', 'Anti-Colonial Movements and the Birth of Nationalism: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 86, 88, 92, 94, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u7_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u7_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 7.', 86, 92, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u7_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u7_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 7.', 87, 93, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u7_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u7_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 7.', 88, 94, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u7_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u7_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Anti-Colonial Movements and the Birth of Nationalism', 'Practice marking key exam locations on outline maps: India Map: 1857 revolt centers (Delhi, Meerut, Kanpur, Lucknow, Jhansi, Bareilly, Gwalior).', 88, 94, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 8: Unit 8: Nationalism: Gandhian Phase
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u8', 'tn10_soc_2025_edition', 8, 'Unit 8: Nationalism: Gandhian Phase', 'History: Rowlatt Act, Jallianwala Bagh, Non-Cooperation, Swarajists, Civil Disobedience, Salt Satyagraha (Dandi & Vedaranyam) & Quit India', 8)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u8_l1_theory_and_concepts', 'tn10_soc_u8', 1, 'theory', 'Nationalism: Gandhian Phase: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 89, 101, 95, 107, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u8_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u8_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Nationalism: Gandhian Phase', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Nationalism: Gandhian Phase.', 89, 95, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u8_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u8_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Nationalism: Gandhian Phase.', 90, 96, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u8_l2_textbook_evaluation', 'tn10_soc_u8', 2, 'exercise', 'Nationalism: Gandhian Phase: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 102, 104, 108, 110, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u8_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u8_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 8.', 102, 108, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u8_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u8_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 8.', 103, 109, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u8_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u8_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 8.', 104, 110, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u8_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u8_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Nationalism: Gandhian Phase', 'Practice marking key exam locations on outline maps: India Map & Timeline: Dandi, Vedaranyam, Champaran, Kheda, Chauri Chaura, Sabarmati, Wardha; Timeline (1920–1947).', 104, 110, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 9: Unit 9: Freedom Struggle in Tamil Nadu
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u9', 'tn10_soc_2025_edition', 9, 'Unit 9: Freedom Struggle in Tamil Nadu', 'History: Swadeshi Movement, V.O. Chidambaranar, Subramania Bharati, Non-Brahmin Movement, Justice Party, Rajaji & Kamaraj', 9)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u9_l1_theory_and_concepts', 'tn10_soc_u9', 1, 'theory', 'Freedom Struggle in Tamil Nadu: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 105, 112, 111, 118, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u9_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u9_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Freedom Struggle in Tamil Nadu', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Freedom Struggle in Tamil Nadu.', 105, 111, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u9_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u9_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Freedom Struggle in Tamil Nadu.', 106, 112, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u9_l2_textbook_evaluation', 'tn10_soc_u9', 2, 'exercise', 'Freedom Struggle in Tamil Nadu: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 113, 114, 119, 120, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u9_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u9_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 9.', 113, 119, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u9_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u9_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 9.', 114, 120, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u9_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u9_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 9.', 114, 120, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u9_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u9_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Freedom Struggle in Tamil Nadu', 'Practice marking key exam locations on outline maps: Tamil Nadu Map: Swadeshi Steam Navigation (Tuticorin, Colombo), Vedaranyam Salt March, Tirupur Kumaran memorial.', 114, 120, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 10: Unit 10: Social Transformation in Tamil Nadu
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u10', 'tn10_soc_2025_edition', 10, 'Unit 10: Social Transformation in Tamil Nadu', 'History: Dravidian Movement, South Indian Liberal Federation (Justice Party), Periyar E.V. Ramasamy, Self-Respect Movement & Women Emancipation', 10)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u10_l1_theory_and_concepts', 'tn10_soc_u10', 1, 'theory', 'Social Transformation in Tamil Nadu: Core Concepts & Theory', 'Tamil Nadu State Board (History)', false, 115, 124, 121, 130, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u10_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u10_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Social Transformation in Tamil Nadu', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Social Transformation in Tamil Nadu.', 115, 121, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u10_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u10_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Social Transformation in Tamil Nadu.', 116, 122, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u10_l2_textbook_evaluation', 'tn10_soc_u10', 2, 'exercise', 'Social Transformation in Tamil Nadu: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (History)', false, 125, 127, 131, 133, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u10_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u10_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 10.', 125, 131, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u10_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u10_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 10.', 126, 132, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u10_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u10_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 10.', 127, 133, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u10_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u10_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Social Transformation in Tamil Nadu', 'Practice marking key exam locations on outline maps: Modern Indian History Comprehensive Timeline (1900–1950) & Historical Reform Centers.', 127, 133, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 11: Unit 11: India - Location, Relief and Drainage
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u11', 'tn10_soc_2025_edition', 11, 'Unit 11: India - Location, Relief and Drainage', 'Geography: Strategic Location of India, Himalayan Ranges, Northern Plains, Peninsular Plateau, Coastal Plains & River Systems', 11)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u11_l1_theory_and_concepts', 'tn10_soc_u11', 1, 'theory', 'India - Location, Relief and Drainage: Core Concepts & Theory', 'Tamil Nadu State Board (Geography)', false, 129, 141, 135, 147, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u11_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u11_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: India - Location, Relief and Drainage', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of India - Location, Relief and Drainage.', 129, 135, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u11_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u11_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for India - Location, Relief and Drainage.', 130, 136, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u11_l2_textbook_evaluation', 'tn10_soc_u11', 2, 'exercise', 'India - Location, Relief and Drainage: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Geography)', false, 142, 143, 148, 149, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u11_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u11_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 11.', 142, 148, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u11_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u11_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 11.', 143, 149, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u11_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u11_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 11.', 143, 149, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u11_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u11_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: India - Location, Relief and Drainage', 'Practice marking key exam locations on outline maps: India Map: Mountain ranges (Himalayas, Western/Eastern Ghats, Aravalli), Peaks (K2, Kanchenjunga), Major Rivers (Ganga, Brahmaputra, Godavari, Kaveri).', 143, 149, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 12: Unit 12: Climate and Natural Vegetation of India
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u12', 'tn10_soc_2025_edition', 12, 'Unit 12: Climate and Natural Vegetation of India', 'Geography: Factors Affecting Climate, Southwest & Northeast Monsoons, Rainfall Distribution, Tropical Rainforests & Wildlife Sanctuaries', 12)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u12_l1_theory_and_concepts', 'tn10_soc_u12', 1, 'theory', 'Climate and Natural Vegetation of India: Core Concepts & Theory', 'Tamil Nadu State Board (Geography)', false, 144, 151, 150, 157, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u12_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u12_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Climate and Natural Vegetation of India', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Climate and Natural Vegetation of India.', 144, 150, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u12_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u12_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Climate and Natural Vegetation of India.', 145, 151, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u12_l2_textbook_evaluation', 'tn10_soc_u12', 2, 'exercise', 'Climate and Natural Vegetation of India: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Geography)', false, 152, 153, 158, 159, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u12_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u12_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 12.', 152, 158, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u12_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u12_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 12.', 153, 159, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u12_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u12_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 12.', 153, 159, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u12_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u12_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Climate and Natural Vegetation of India', 'Practice marking key exam locations on outline maps: India Map: Southwest monsoon wind direction, High and low rainfall zones, Forest types & Biosphere reserves (Nilgiri, Gulf of Mannar, Sundarbans).', 153, 159, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 13: Unit 13: India - Agriculture
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u13', 'tn10_soc_2025_edition', 13, 'Unit 13: India - Agriculture', 'Geography: Soil Types (Alluvial, Black, Red, Laterite), Irrigation Schemes, Multipurpose River Valley Projects, Food Crops & Commercial Agriculture', 13)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u13_l1_theory_and_concepts', 'tn10_soc_u13', 1, 'theory', 'India - Agriculture: Core Concepts & Theory', 'Tamil Nadu State Board (Geography)', false, 154, 166, 160, 172, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u13_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u13_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: India - Agriculture', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of India - Agriculture.', 154, 160, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u13_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u13_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for India - Agriculture.', 155, 161, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u13_l2_textbook_evaluation', 'tn10_soc_u13', 2, 'exercise', 'India - Agriculture: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Geography)', false, 167, 169, 173, 175, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u13_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u13_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 13.', 167, 173, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u13_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u13_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 13.', 168, 174, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u13_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u13_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 13.', 169, 175, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u13_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u13_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: India - Agriculture', 'Practice marking key exam locations on outline maps: India Map: Major crop regions (Rice, Wheat, Cotton, Sugarcane, Tea, Coffee) & Multipurpose dams (Bhakra Nangal, Hirakud, Mettur).', 169, 175, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 14: Unit 14: India - Resources and Industries
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u14', 'tn10_soc_2025_edition', 14, 'Unit 14: India - Resources and Industries', 'Geography: Metallic Minerals (Iron ore, Bauxite), Energy Resources (Coal, Petroleum, Nuclear, Solar), Cotton Textiles, Iron & Steel Plants', 14)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u14_l1_theory_and_concepts', 'tn10_soc_u14', 1, 'theory', 'India - Resources and Industries: Core Concepts & Theory', 'Tamil Nadu State Board (Geography)', false, 170, 182, 176, 188, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u14_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u14_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: India - Resources and Industries', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of India - Resources and Industries.', 170, 176, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u14_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u14_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for India - Resources and Industries.', 171, 177, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u14_l2_textbook_evaluation', 'tn10_soc_u14', 2, 'exercise', 'India - Resources and Industries: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Geography)', false, 183, 185, 189, 191, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u14_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u14_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 14.', 183, 189, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u14_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u14_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 14.', 184, 190, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u14_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u14_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 14.', 185, 191, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u14_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u14_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: India - Resources and Industries', 'Practice marking key exam locations on outline maps: India Map: Major mineral belts, Coal fields (Jharia, Raniganj), Oil fields (Mumbai High, Digboi) & Steel plants (Jamshedpur, Bhilai, Salem).', 185, 191, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 15: Unit 15: India - Population, Transport, Communication and Trade
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u15', 'tn10_soc_2025_edition', 15, 'Unit 15: India - Population, Transport, Communication and Trade', 'Geography: Population Density, Urbanization, Golden Quadrilateral, Railway Zones, Major Seaports, International Airports & Trade Balance', 15)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u15_l1_theory_and_concepts', 'tn10_soc_u15', 1, 'theory', 'India - Population, Transport, Communication and Trade: Core Concepts & Theory', 'Tamil Nadu State Board (Geography)', false, 186, 196, 192, 202, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u15_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u15_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: India - Population, Transport, Communication and Trade', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of India - Population, Transport, Communication and Trade.', 186, 192, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u15_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u15_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for India - Population, Transport, Communication and Trade.', 187, 193, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u15_l2_textbook_evaluation', 'tn10_soc_u15', 2, 'exercise', 'India - Population, Transport, Communication and Trade: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Geography)', false, 197, 199, 203, 205, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u15_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u15_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 15.', 197, 203, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u15_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u15_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 15.', 198, 204, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u15_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u15_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 15.', 199, 205, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u15_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u15_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: India - Population, Transport, Communication and Trade', 'Practice marking key exam locations on outline maps: India Map: Golden quadrilateral highway, Major sea ports (Chennai, Mumbai, Kolkata, Kochi, Tuticorin) & International airports.', 199, 205, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 16: Unit 16: Physical Geography of Tamil Nadu
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u16', 'tn10_soc_2025_edition', 16, 'Unit 16: Physical Geography of Tamil Nadu', 'Geography: Location & Boundaries of Tamil Nadu, Western/Eastern Ghats, Plateaus, Coastal Plains, Rivers (Palar, Cauvery, Vaigai) & Climate', 16)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u16_l1_theory_and_concepts', 'tn10_soc_u16', 1, 'theory', 'Physical Geography of Tamil Nadu: Core Concepts & Theory', 'Tamil Nadu State Board (Geography)', false, 200, 215, 206, 221, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u16_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u16_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Physical Geography of Tamil Nadu', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Physical Geography of Tamil Nadu.', 200, 206, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u16_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u16_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Physical Geography of Tamil Nadu.', 201, 207, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u16_l2_textbook_evaluation', 'tn10_soc_u16', 2, 'exercise', 'Physical Geography of Tamil Nadu: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Geography)', false, 216, 218, 222, 224, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u16_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u16_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 16.', 216, 222, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u16_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u16_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 16.', 217, 223, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u16_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u16_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 16.', 218, 224, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u16_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u16_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Physical Geography of Tamil Nadu', 'Practice marking key exam locations on outline maps: Tamil Nadu Map: Doddabetta, Anaimudi, Palani hills, River Cauvery, Vaigai, Coromandel coast, Pichavaram mangrove & Gulf of Mannar.', 218, 224, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 17: Unit 17: Human Geography of Tamil Nadu
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u17', 'tn10_soc_2025_edition', 17, 'Unit 17: Human Geography of Tamil Nadu', 'Geography: Agriculture in TN, Cropping Seasons, Water Resources, Livestock, Fisheries, Industrial Growth, Transport Infrastructure & Disaster Risk', 17)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u17_l1_theory_and_concepts', 'tn10_soc_u17', 1, 'theory', 'Human Geography of Tamil Nadu: Core Concepts & Theory', 'Tamil Nadu State Board (Geography)', false, 219, 234, 225, 240, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u17_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u17_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Human Geography of Tamil Nadu', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Human Geography of Tamil Nadu.', 219, 225, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u17_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u17_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Human Geography of Tamil Nadu.', 220, 226, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u17_l2_textbook_evaluation', 'tn10_soc_u17', 2, 'exercise', 'Human Geography of Tamil Nadu: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Geography)', false, 235, 237, 241, 243, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u17_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u17_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 17.', 235, 241, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u17_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u17_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 17.', 236, 242, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u17_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u17_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 17.', 237, 243, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u17_l2_textbook_evaluation_item_4_map_and_timeline', 'tn10_soc_u17_l2_textbook_evaluation', 'source_activity', 'Board Exam Map & Timeline Skills', 'Board Exam Map Work & Timeline Skills: Human Geography of Tamil Nadu', 'Practice marking key exam locations on outline maps: Tamil Nadu Map: Agro-climatic zones, Major crop areas, Textile clusters (Coimbatore, Tirupur), Ports (Ennore, Chennai, Tuticorin) & NH network.', 237, 243, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 18: Unit 18: Indian Constitution
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u18', 'tn10_soc_2025_edition', 18, 'Unit 18: Indian Constitution', 'Civics: Framing of Constitution, Preamble, Salient Features, Fundamental Rights (Articles 12–35), Directive Principles & Emergency Provisions', 18)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u18_l1_theory_and_concepts', 'tn10_soc_u18', 1, 'theory', 'Indian Constitution: Core Concepts & Theory', 'Tamil Nadu State Board (Civics)', false, 239, 245, 245, 251, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u18_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u18_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Indian Constitution', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Indian Constitution.', 239, 245, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u18_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u18_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Indian Constitution.', 240, 246, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u18_l2_textbook_evaluation', 'tn10_soc_u18', 2, 'exercise', 'Indian Constitution: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Civics)', false, 246, 247, 252, 253, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u18_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u18_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 18.', 246, 252, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u18_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u18_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 18.', 247, 253, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u18_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u18_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 18.', 247, 253, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 19: Unit 19: Central Government
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u19', 'tn10_soc_2025_edition', 19, 'Unit 19: Central Government', 'Civics: President of India, Vice-President, Prime Minister, Council of Ministers, Parliament (Lok Sabha & Rajya Sabha) & Supreme Court', 19)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u19_l1_theory_and_concepts', 'tn10_soc_u19', 1, 'theory', 'Central Government: Core Concepts & Theory', 'Tamil Nadu State Board (Civics)', false, 248, 255, 254, 261, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u19_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u19_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Central Government', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Central Government.', 248, 254, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u19_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u19_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Central Government.', 249, 255, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u19_l2_textbook_evaluation', 'tn10_soc_u19', 2, 'exercise', 'Central Government: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Civics)', false, 256, 258, 262, 264, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u19_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u19_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 19.', 256, 262, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u19_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u19_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 19.', 257, 263, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u19_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u19_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 19.', 258, 264, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 20: Unit 20: State Government
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u20', 'tn10_soc_2025_edition', 20, 'Unit 20: State Government', 'Civics: Governor of Tamil Nadu, Chief Minister, State Council of Ministers, State Legislature (Vidhan Sabha) & High Court Jurisdiction', 20)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u20_l1_theory_and_concepts', 'tn10_soc_u20', 1, 'theory', 'State Government: Core Concepts & Theory', 'Tamil Nadu State Board (Civics)', false, 259, 265, 265, 271, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u20_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u20_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: State Government', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of State Government.', 259, 265, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u20_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u20_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for State Government.', 260, 266, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u20_l2_textbook_evaluation', 'tn10_soc_u20', 2, 'exercise', 'State Government: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Civics)', false, 266, 268, 272, 274, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u20_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u20_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 20.', 266, 272, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u20_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u20_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 20.', 267, 273, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u20_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u20_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 20.', 268, 274, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 21: Unit 21: India’s Foreign Policy
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u21', 'tn10_soc_2025_edition', 21, 'Unit 21: India’s Foreign Policy', 'Civics: Panchsheel Principles, Non-Alignment Policy, Disarmament, Anti-Apartheid, SAARC, Act East Policy & Nuclear Doctrine', 21)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u21_l1_theory_and_concepts', 'tn10_soc_u21', 1, 'theory', 'India’s Foreign Policy: Core Concepts & Theory', 'Tamil Nadu State Board (Civics)', false, 269, 275, 275, 281, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u21_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u21_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: India’s Foreign Policy', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of India’s Foreign Policy.', 269, 275, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u21_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u21_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for India’s Foreign Policy.', 270, 276, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u21_l2_textbook_evaluation', 'tn10_soc_u21', 2, 'exercise', 'India’s Foreign Policy: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Civics)', false, 276, 277, 282, 283, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u21_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u21_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 21.', 276, 282, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u21_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u21_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 21.', 277, 283, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u21_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u21_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 21.', 277, 283, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 22: Unit 22: India’s International Relations
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u22', 'tn10_soc_2025_edition', 22, 'Unit 22: India’s International Relations', 'Civics: Relations with Immediate Neighbors (Pakistan, China, Bangladesh, Sri Lanka, Nepal), BRICS, G20, Look East & Global Partnerships', 22)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u22_l1_theory_and_concepts', 'tn10_soc_u22', 1, 'theory', 'India’s International Relations: Core Concepts & Theory', 'Tamil Nadu State Board (Civics)', false, 278, 287, 284, 293, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u22_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u22_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: India’s International Relations', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of India’s International Relations.', 278, 284, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u22_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u22_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for India’s International Relations.', 279, 285, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u22_l2_textbook_evaluation', 'tn10_soc_u22', 2, 'exercise', 'India’s International Relations: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Civics)', false, 288, 290, 294, 296, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u22_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u22_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 22.', 288, 294, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u22_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u22_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 22.', 289, 295, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u22_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u22_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 22.', 290, 296, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 23: Unit 23: Gross Domestic Product and its Growth: an Introduction
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u23', 'tn10_soc_2025_edition', 23, 'Unit 23: Gross Domestic Product and its Growth: an Introduction', 'Economics: Concept of GDP, NDP, GNP, NNP, Primary/Secondary/Tertiary Sectors, Human Development Index (HDI) & Economic Development', 23)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u23_l1_theory_and_concepts', 'tn10_soc_u23', 1, 'theory', 'Gross Domestic Product and its Growth: an Introduction: Core Concepts & Theory', 'Tamil Nadu State Board (Economics)', false, 292, 299, 298, 305, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u23_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u23_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Gross Domestic Product and its Growth: an Introduction', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Gross Domestic Product and its Growth: an Introduction.', 292, 298, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u23_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u23_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Gross Domestic Product and its Growth: an Introduction.', 293, 299, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u23_l2_textbook_evaluation', 'tn10_soc_u23', 2, 'exercise', 'Gross Domestic Product and its Growth: an Introduction: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Economics)', false, 300, 302, 306, 308, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u23_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u23_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 23.', 300, 306, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u23_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u23_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 23.', 301, 307, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u23_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u23_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 23.', 302, 308, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 24: Unit 24: Globalization and Trade
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u24', 'tn10_soc_2025_edition', 24, 'Unit 24: Globalization and Trade', 'Economics: Historical Background of Trade, Silk Route, Multi-National Corporations (MNCs), GATT, WTO & Impact of Globalization in India', 24)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u24_l1_theory_and_concepts', 'tn10_soc_u24', 1, 'theory', 'Globalization and Trade: Core Concepts & Theory', 'Tamil Nadu State Board (Economics)', false, 303, 308, 309, 314, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u24_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u24_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Globalization and Trade', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Globalization and Trade.', 303, 309, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u24_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u24_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Globalization and Trade.', 304, 310, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u24_l2_textbook_evaluation', 'tn10_soc_u24', 2, 'exercise', 'Globalization and Trade: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Economics)', false, 309, 310, 315, 316, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u24_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u24_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 24.', 309, 315, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u24_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u24_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 24.', 310, 316, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u24_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u24_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 24.', 310, 316, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 25: Unit 25: Food Security and Nutrition
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u25', 'tn10_soc_2025_edition', 25, 'Unit 25: Food Security and Nutrition', 'Economics: Availability, Access & Absorption of Food, Public Distribution System (PDS), Buffer Stock, Green Revolution & Nutrition Schemes in TN', 25)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u25_l1_theory_and_concepts', 'tn10_soc_u25', 1, 'theory', 'Food Security and Nutrition: Core Concepts & Theory', 'Tamil Nadu State Board (Economics)', false, 311, 317, 317, 323, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u25_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u25_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Food Security and Nutrition', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Food Security and Nutrition.', 311, 317, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u25_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u25_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Food Security and Nutrition.', 312, 318, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u25_l2_textbook_evaluation', 'tn10_soc_u25', 2, 'exercise', 'Food Security and Nutrition: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Economics)', false, 318, 320, 324, 326, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u25_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u25_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 25.', 318, 324, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u25_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u25_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 25.', 319, 325, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u25_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u25_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 25.', 320, 326, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 26: Unit 26: Government and Taxes
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u26', 'tn10_soc_2025_edition', 26, 'Unit 26: Government and Taxes', 'Economics: Direct Taxes (Income Tax, Corporate Tax), Indirect Taxes (GST, Customs, Excise), Black Money, Tax Evasion & Public Expenditure', 26)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u26_l1_theory_and_concepts', 'tn10_soc_u26', 1, 'theory', 'Government and Taxes: Core Concepts & Theory', 'Tamil Nadu State Board (Economics)', false, 321, 325, 327, 331, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u26_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u26_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Government and Taxes', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Government and Taxes.', 321, 327, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u26_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u26_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Government and Taxes.', 322, 328, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u26_l2_textbook_evaluation', 'tn10_soc_u26', 2, 'exercise', 'Government and Taxes: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Economics)', false, 326, 327, 332, 333, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u26_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u26_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 26.', 326, 332, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u26_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u26_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 26.', 327, 333, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u26_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u26_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 26.', 327, 333, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Unit 27: Unit 27: Industrial Clusters in Tamil Nadu
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_soc_u27', 'tn10_soc_2025_edition', 27, 'Unit 27: Industrial Clusters in Tamil Nadu', 'Economics: Determinants of Industrial Clusters, Textile Hub (Tirupur, Coimbatore), Leather Hub (Vellore, Ambur), Fireworks (Sivakasi), Auto Hub (Chennai) & SIPCOT/TIDCO', 27)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u27_l1_theory_and_concepts', 'tn10_soc_u27', 1, 'theory', 'Industrial Clusters in Tamil Nadu: Core Concepts & Theory', 'Tamil Nadu State Board (Economics)', false, 328, 335, 334, 341, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u27_l1_theory_and_concepts_item_1_concept_reading', 'tn10_soc_u27_l1_theory_and_concepts', 'source_activity', 'Core Concepts', 'Read & Understand Core Concepts: Industrial Clusters in Tamil Nadu', 'Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of Industrial Clusters in Tamil Nadu.', 328, 334, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u27_l1_theory_and_concepts_item_2_activities_and_case_studies', 'tn10_soc_u27_l1_theory_and_concepts', 'source_activity', 'In-text Figures & Case Studies', 'In-text Activities, Tables, Infographics & Case Studies', 'Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for Industrial Clusters in Tamil Nadu.', 329, 335, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_soc_u27_l2_textbook_evaluation', 'tn10_soc_u27', 2, 'exercise', 'Industrial Clusters in Tamil Nadu: Textbook Evaluation & Assessment', 'Tamil Nadu State Board (Economics)', false, 336, 337, 342, 343, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u27_l2_textbook_evaluation_item_1_objective_questions', 'tn10_soc_u27_l2_textbook_evaluation', 'source_activity', 'Objective Evaluation (Part I)', 'Part I: MCQs, Fill in Blanks, True/False & Match Items', 'Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit 27.', 336, 342, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u27_l2_textbook_evaluation_item_2_short_answers', 'tn10_soc_u27_l2_textbook_evaluation', 'source_activity', 'Short Answers & Distinctions (Part II)', 'Part II: Short Answer Questions & Distinguish Between (2 Marks)', 'Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit 27.', 337, 343, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_soc_u27_l2_textbook_evaluation_item_3_detailed_answers', 'tn10_soc_u27_l2_textbook_evaluation', 'source_activity', 'Detailed Answers & Essays (Part III)', 'Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)', 'Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit 27.', 337, 343, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

