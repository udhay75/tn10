-- ==========================================================================
-- 003_seed_english_2024.sql: Tamil Nadu State Board Class 10 English Seed
-- Idempotent seed script: safe to run multiple times without duplicates.
-- ==========================================================================

INSERT INTO boards (code, name, state)
VALUES ('tn_state_board', 'Tamil Nadu State Board of School Education', 'Tamil Nadu')
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, state = EXCLUDED.state;

INSERT INTO classes (code, grade_number, title, board_code)
VALUES ('class_10', 10, 'Standard 10', 'tn_state_board')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;

INSERT INTO mediums (code, name)
VALUES ('english', 'English Medium')
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO mediums (code, name)
VALUES ('tamil', 'Tamil Medium')
ON CONFLICT (code) DO NOTHING;

INSERT INTO subjects (code, title, class_code, medium_code)
VALUES ('class_10_english', 'English', 'class_10', 'english')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;

INSERT INTO textbook_editions (code, subject_code, edition_year, title, source_filename, is_published)
VALUES ('tn10_eng_2024_edition', 'class_10_english', 2024, 'Standard Ten English (Revised Edition 2020, 2022, 2023, Reprint 2024)', 'Class_10_English_2024_Edition.pdf', true)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, is_published = EXCLUDED.is_published;

INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_eng_u1', 'tn10_eng_2024_edition', 1, 'Unit 1', 'Courage, Adventurous Journey, Bravery & Nature', 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u1_prose_his_first_flight', 'tn10_eng_u1', 1, 'prose', 'His First Flight', 'Liam O''Flaherty', false, 2, 16, 6, 20, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_1_read_his_first_flight_text', 'tn10_eng_u1_prose_his_first_flight', 'app_task', 'Reading', 'Read ''His First Flight'' text', 'Read the story of the young seagull overcoming fear to fly.', 2, 6, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_2_in_text_comprehension_questions_a_g', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'In-text Questions', 'In-text Comprehension Questions (a - g)', 'Answer questions on the seagull''s siblings, parents, first catch, and fear.', 3, 7, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_3_study_glossary_key_words', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Glossary', 'Study Glossary & Key Words', 'Learn meanings of ledge, shrilly, herring, devour, cackle, mackerel, whet, preening, plaintively, swoop, monstrous.', 5, 9, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_4_comprehension_a_answer_in_1_2_sentences_', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Comprehension Questions', 'Comprehension A: Answer in 1-2 sentences (Questions 1 to 6)', 'Short answer questions on young seagull''s struggles, parents'' coaxing, and first flight.', 5, 9, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_5_comprehension_b_paragraph_questions_ques', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Comprehension Questions', 'Comprehension B: Paragraph Questions (Questions 1 & 2)', 'Detailed paragraph responses on overcoming fear and parental discipline.', 6, 10, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_6_vocabulary_parts_of_speech_sets_1_2', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Vocabulary', 'Vocabulary: Parts of Speech (Sets 1 & 2)', 'Identify adjectives, nouns, and adverbs derived from story words.', 6, 10, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_7_vocabulary_d_change_form_of_underlined_w', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Vocabulary', 'Vocabulary D: Change Form of Underlined Words', 'Convert word forms into adjectives, adverbs, nouns, and verbs.', 7, 11, 7, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_8_vocabulary_e_construct_sentences', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Vocabulary', 'Vocabulary E: Construct Sentences', 'Make sentences with coward, gradual, praise, courageous, starvation.', 7, 11, 8, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_9_listening_activity_f_travelogue_comprehe', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Listening & Speaking', 'Listening Activity F: Travelogue Comprehension', 'Listen to travelogue excerpt and answer related questions.', 7, 11, 9, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_10_speaking_activity_g_dialogue_continuatio', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Listening & Speaking', 'Speaking Activity G: Dialogue Continuation', 'Continue Mary and Father dialogue planning a trip to the forest.', 8, 12, 10, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_11_reading_comprehension_h_bungee_jumping_p', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Reading', 'Reading Comprehension H: Bungee Jumping Passage', 'Read adventure travel passage and answer questions 1 to 6.', 8, 12, 11, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_12_writing_activity_i_prepare_advertisement', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Writing', 'Writing Activity I: Prepare Advertisements', 'Draft attractive commercial ads using provided hints for Home appliances & Mobile Galaxy.', 10, 14, 12, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_13_writing_activity_j_report_writing', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Writing', 'Writing Activity J: Report Writing', 'Write 100-120 word reports on Educational Development Day or Literary Association.', 11, 15, 13, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_14_grammar_modals_semi_modals_exercises_a_e', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Grammar', 'Grammar: Modals & Semi-Modals (Exercises A - E)', 'Practice modal verbs (can, could, may, might, must, should, would) in dialogues and sentences.', 12, 16, 14, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_15_grammar_active_and_passive_voice_exercis', 'tn10_eng_u1_prose_his_first_flight', 'source_activity', 'Grammar', 'Grammar: Active and Passive Voice (Exercises F - K)', 'Convert active voice into passive voice, commands, requests, recipes, and event reports.', 14, 18, 15, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_prose_his_first_flight_item_16_revise_his_first_flight_grammar_concepts', 'tn10_eng_u1_prose_his_first_flight', 'app_task', 'Revision', 'Revise His First Flight & Grammar Concepts', 'Comprehensive revision of questions, vocabulary, modals, and voice.', 2, 6, 16, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u1_poem_life', 'tn10_eng_u1', 2, 'poem', 'Life', 'Henry Van Dyke', true, 17, 20, 21, 24, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_poem_life_item_1_recite_memorise_life_poem', 'tn10_eng_u1_poem_life', 'app_task', 'Memoriter', 'Recite & Memorise ''Life'' Poem', 'Memorise the 14-line sonnet with forward face and unreluctant soul.', 17, 21, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_poem_life_item_2_study_poem_glossary', 'tn10_eng_u1_poem_life', 'source_activity', 'Glossary', 'Study Poem Glossary', 'Learn meanings of mourning, veils, crown, quest, unreluctant.', 18, 22, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_poem_life_item_3_poem_comprehension_a_stanza_questions_1_', 'tn10_eng_u1_poem_life', 'source_activity', 'Comprehension Questions', 'Poem Comprehension A: Stanza Questions (1 to 5)', 'Rhyme scheme, poetic devices, and analytical questions on stanzas.', 18, 22, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_poem_life_item_4_poem_comprehension_b_paragraph_question', 'tn10_eng_u1_poem_life', 'source_activity', 'Comprehension Questions', 'Poem Comprehension B: Paragraph Question', 'Write an 80-100 word essay describing the poet''s positive journey through life.', 19, 23, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_poem_life_item_5_poem_activity_c_complete_summary_passage', 'tn10_eng_u1_poem_life', 'source_activity', 'Poem Activities', 'Poem Activity C: Complete Summary Passage', 'Fill in the missing keywords to complete the poem summary.', 19, 23, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_poem_life_item_6_read_enjoy_sea_fever_by_john_masefield', 'tn10_eng_u1_poem_life', 'source_activity', 'Poem Activities', 'Read & Enjoy: ''Sea Fever'' by John Masefield', 'Appreciation of adventurous seafaring poetry.', 20, 24, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u1_supplementary_the_tempest', 'tn10_eng_u1', 3, 'supplementary', 'The Tempest', 'Charles Lamb (Tales From Shakespeare)', false, 21, 29, 25, 33, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_supplementary_the_tempest_item_1_read_the_tempest_tale', 'tn10_eng_u1_supplementary_the_tempest', 'app_task', 'Reading', 'Read ''The Tempest'' Tale', 'Read the story of Prospero, Miranda, Ariel, Caliban, and Ferdinand on the enchanted island.', 21, 25, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_supplementary_the_tempest_item_2_study_supplementary_glossary', 'tn10_eng_u1_supplementary_the_tempest', 'source_activity', 'Glossary', 'Study Supplementary Glossary', 'Learn tormenting, dreadful, duke, deprive, familiar.', 26, 30, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_supplementary_the_tempest_item_3_exercise_a_choose_the_correct_answer', 'tn10_eng_u1_supplementary_the_tempest', 'source_activity', 'Exercises', 'Exercise A: Choose the Correct Answer', 'Multiple-choice comprehension questions on the plot and characters.', 26, 30, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_supplementary_the_tempest_item_4_exercise_b_identify_the_character_or_spe', 'tn10_eng_u1_supplementary_the_tempest', 'source_activity', 'Exercises', 'Exercise B: Identify the Character or Speaker', 'Recognize character quotes from Prospero, Miranda, Ferdinand, and Ariel.', 26, 30, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_supplementary_the_tempest_item_5_exercise_c_answer_in_1_2_sentences', 'tn10_eng_u1_supplementary_the_tempest', 'source_activity', 'Exercises', 'Exercise C: Answer in 1-2 Sentences', 'Brief questions about Prospero''s magical spells, brother''s betrayal, and forgiveness.', 27, 31, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_supplementary_the_tempest_item_6_exercise_d_rearrange_the_jumbled_sentenc', 'tn10_eng_u1_supplementary_the_tempest', 'source_activity', 'Exercises', 'Exercise D: Rearrange the Jumbled Sentences', 'Put the story events into correct chronological sequence.', 27, 31, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u1_supplementary_the_tempest_item_7_exercise_e_paragraph_questions_1_2', 'tn10_eng_u1_supplementary_the_tempest', 'source_activity', 'Exercises', 'Exercise E: Paragraph Questions (1 & 2)', 'Character sketches and thematic analysis of forgiveness and reconciliation.', 28, 32, 7, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_eng_u2', 'tn10_eng_2024_edition', 2, 'Unit 2', 'Humour, Family Quirks & Pets', 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in', 'tn10_eng_u2', 1, 'prose', 'The Night the Ghost Got In', 'James Thurber', false, 30, 44, 34, 48, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_1_read_the_night_the_ghost_got_in', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'app_task', 'Reading', 'Read ''The Night the Ghost Got In''', 'Read James Thurber''s comic memoir of midnight chaos and mistaken burglars.', 30, 34, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_2_in_text_comprehension_questions_a_g', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'In-text Questions', 'In-text Comprehension Questions (a - g)', 'Questions on strange sounds, grandfather''s behaviour, and mother''s shoe throwing.', 31, 35, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_3_study_glossary', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'Glossary', 'Study Glossary', 'Learn hullabaloo, bevelled, hysterical, creaking, indignant.', 33, 37, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_4_comprehension_a_answer_in_1_2_sentences', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'Comprehension Questions', 'Comprehension A: Answer in 1-2 Sentences', 'Short answer questions on the misunderstanding between police, grandfather, and narrator.', 34, 38, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_5_comprehension_b_paragraph_questions', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'Comprehension Questions', 'Comprehension B: Paragraph Questions', 'Describe the humorous sequence of events that unfolded in the house.', 35, 39, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_6_vocabulary_slang_informal_expressions_a_', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'Vocabulary', 'Vocabulary: Slang & Informal Expressions (A - D)', 'Explore colloquial words, idioms, and figurative usage.', 35, 39, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_7_listening_speaking_activities_e_g', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'Listening & Speaking', 'Listening & Speaking Activities (E - G)', 'Listening comprehension and humorous storytelling practice.', 38, 42, 7, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_8_writing_notice_writing_message_writing', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'Writing', 'Writing: Notice Writing & Message Writing', 'Format and compose school notices and telephone messages.', 39, 43, 8, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_9_grammar_articles_determiners_exercises_a', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'Grammar', 'Grammar: Articles & Determiners (Exercises A - E)', 'Definite and indefinite articles, quantifiers, demonstratives, and possessives.', 41, 45, 9, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_10_grammar_prepositions_prepositional_phras', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'source_activity', 'Grammar', 'Grammar: Prepositions & Prepositional Phrases (F - I)', 'Prepositions of time, place, direction, and phrasal prepositions.', 43, 47, 10, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_prose_the_night_the_ghost_got_in_item_11_revise_unit_2_grammar_vocabulary', 'tn10_eng_u2_prose_the_night_the_ghost_got_in', 'app_task', 'Revision', 'Revise Unit 2 Grammar & Vocabulary', 'Review articles, prepositions, notices, and story themes.', 30, 34, 11, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u2_poem_the_grumble_family', 'tn10_eng_u2', 2, 'poem', 'The Grumble Family', 'Lucy Maud Montgomery', false, 45, 49, 49, 53, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_poem_the_grumble_family_item_1_read_the_grumble_family', 'tn10_eng_u2_poem_the_grumble_family', 'app_task', 'Reading', 'Read ''The Grumble Family''', 'Read about Complaining Street, River of Discontent, and avoiding chronic grumbling.', 45, 49, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_poem_the_grumble_family_item_2_study_poem_glossary', 'tn10_eng_u2_poem_the_grumble_family', 'source_activity', 'Glossary', 'Study Poem Glossary', 'Learn discontent, amiss, growl, grumble, gloom.', 46, 50, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_poem_the_grumble_family_item_3_poem_comprehension_a_stanza_questions', 'tn10_eng_u2_poem_the_grumble_family', 'source_activity', 'Comprehension Questions', 'Poem Comprehension A: Stanza Questions', 'Questions analyzing the satirical portrayal of chronic fault-finders.', 47, 51, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_poem_the_grumble_family_item_4_poem_comprehension_b_paragraph_question', 'tn10_eng_u2_poem_the_grumble_family', 'source_activity', 'Comprehension Questions', 'Poem Comprehension B: Paragraph Question', 'Discuss the moral lesson of staying cheerful and avoiding the Grumble family''s habits.', 48, 52, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_poem_the_grumble_family_item_5_poem_activities_appreciation', 'tn10_eng_u2_poem_the_grumble_family', 'source_activity', 'Poem Activities', 'Poem Activities & Appreciation', 'Rhyme scheme and figures of speech (personification, hyperbole).', 48, 52, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u2_supplementary_zigzag', 'tn10_eng_u2', 3, 'supplementary', 'Zigzag', 'Asha Nehemiah', false, 50, 59, 54, 63, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_supplementary_zigzag_item_1_read_zigzag_tale', 'tn10_eng_u2_supplementary_zigzag', 'app_task', 'Reading', 'Read ''Zigzag'' Tale', 'Enjoy the tale of Dr. Krishnan''s family and the peculiar multi-lingual African bird.', 50, 54, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_supplementary_zigzag_item_2_study_supplementary_glossary', 'tn10_eng_u2_supplementary_zigzag', 'source_activity', 'Glossary', 'Study Supplementary Glossary', 'Learn commotion, eavesdrop, squawk, snoring, pandemonium.', 55, 59, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_supplementary_zigzag_item_3_exercise_a_identify_speaker_or_character', 'tn10_eng_u2_supplementary_zigzag', 'source_activity', 'Exercises', 'Exercise A: Identify Speaker or Character', 'Who said what to whom in the clinic and household.', 56, 60, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_supplementary_zigzag_item_4_exercise_b_multiple_choice_sequencing', 'tn10_eng_u2_supplementary_zigzag', 'source_activity', 'Exercises', 'Exercise B: Multiple-Choice & Sequencing', 'Test comprehension of Zigzag''s snoring and surprise transformation in the clinic.', 56, 60, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_supplementary_zigzag_item_5_exercise_c_answer_in_1_2_sentences', 'tn10_eng_u2_supplementary_zigzag', 'source_activity', 'Exercises', 'Exercise C: Answer in 1-2 Sentences', 'Questions on how Zigzag changed from a nuisance into a clinic helper.', 57, 61, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u2_supplementary_zigzag_item_6_exercise_d_paragraph_questions', 'tn10_eng_u2_supplementary_zigzag', 'source_activity', 'Exercises', 'Exercise D: Paragraph Questions', 'Write a summary of the chaos caused by Zigzag and Mrs. Krishnan''s ruined painting.', 58, 62, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_eng_u3', 'tn10_eng_2024_edition', 3, 'Unit 3', 'Women Empowerment, Maritime Expedition & Bravery', 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world', 'tn10_eng_u3', 1, 'prose', 'Empowered Women Navigating the World', 'Editorial / Navika Sagar Parikrama', false, 60, 83, 64, 87, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_1_read_empowered_women_navigating_the_worl', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'app_task', 'Reading', 'Read ''Empowered Women Navigating the World''', 'Learn about the all-woman Indian Navy crew circum-navigating the globe in INSV Tarini.', 60, 64, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_2_in_text_questions_a_j', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'In-text Questions', 'In-text Questions (a - j)', 'Questions on INSV Tarini, training of the six officers, challenges, and team bonding.', 62, 66, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_3_study_glossary', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'Glossary', 'Study Glossary', 'Learn auxiliary, indigenous, circumnavigation, skipper, appraisal.', 65, 69, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_4_comprehension_a_answer_in_1_2_sentences', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'Comprehension Questions', 'Comprehension A: Answer in 1-2 Sentences', 'Short answers on Lt Cdr Vartika Joshi and the crew''s achievements.', 65, 69, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_5_comprehension_b_paragraph_questions', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'Comprehension Questions', 'Comprehension B: Paragraph Questions', 'Paragraph responses highlighting grit, resilience, and women empowerment.', 66, 70, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_6_vocabulary_idioms_phrasal_verbs_nautical', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'Vocabulary', 'Vocabulary: Idioms, Phrasal Verbs & Nautical Terms (A - E)', 'Idioms related to water, sea journeys, and phrasal verbs.', 67, 71, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_7_listening_speaking_activities_f_i', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'Listening & Speaking', 'Listening & Speaking Activities (F - I)', 'Interview simulation and maritime weather reports.', 71, 75, 7, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_8_writing_formal_letter_email_writing', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'Writing', 'Writing: Formal Letter & Email Writing', 'Write letters of complaint, appreciation, and professional emails.', 74, 78, 8, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_9_grammar_tenses_present_past_future_exerc', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'Grammar', 'Grammar: Tenses (Present, Past, Future) (Exercises A - G)', 'Master simple, continuous, perfect, and perfect continuous tense structures.', 77, 81, 9, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_10_grammar_subject_verb_agreement_concord_h', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'source_activity', 'Grammar', 'Grammar: Subject-Verb Agreement (Concord) (H - J)', 'Rules of concord with singular/plural subjects and collective nouns.', 81, 85, 10, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_prose_empowered_women_navigating_the_world_item_11_revise_unit_3_tenses_concord', 'tn10_eng_u3_prose_empowered_women_navigating_the_world', 'app_task', 'Revision', 'Revise Unit 3 Tenses & Concord', 'Review tense timeline rules and subject-verb concord rules.', 60, 64, 11, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u3_poem_i_am_every_woman', 'tn10_eng_u3', 2, 'poem', 'I am Every Woman', 'Rakhi Nariani Shirke', true, 84, 87, 88, 91, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_poem_i_am_every_woman_item_1_recite_memorise_i_am_every_woman', 'tn10_eng_u3_poem_i_am_every_woman', 'app_task', 'Memoriter', 'Recite & Memorise ''I am Every Woman''', 'Memorise the inspirational poem celebrating the strength, dignity, and tenacity of modern women.', 84, 88, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_poem_i_am_every_woman_item_2_study_poem_glossary', 'tn10_eng_u3_poem_i_am_every_woman', 'source_activity', 'Glossary', 'Study Poem Glossary', 'Learn innate, stake, persistence, prank, ferocious.', 85, 89, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_poem_i_am_every_woman_item_3_poem_comprehension_a_stanza_questions', 'tn10_eng_u3_poem_i_am_every_woman', 'source_activity', 'Comprehension Questions', 'Poem Comprehension A: Stanza Questions', 'Analyze tone, metaphors (lioness), and questions on each stanza.', 85, 89, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_poem_i_am_every_woman_item_4_poem_comprehension_b_paragraph_question', 'tn10_eng_u3_poem_i_am_every_woman', 'source_activity', 'Comprehension Questions', 'Poem Comprehension B: Paragraph Question', 'Discuss how women face challenges today without fear or compromise.', 86, 90, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_poem_i_am_every_woman_item_5_poem_activities_appreciation', 'tn10_eng_u3_poem_i_am_every_woman', 'source_activity', 'Poem Activities', 'Poem Activities & Appreciation', 'Figures of speech: Metaphor, Alliteration, Rhyme.', 86, 90, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u3_supplementary_the_story_of_mulan', 'tn10_eng_u3', 3, 'supplementary', 'The Story of Mulan', 'Chinese Legend', false, 88, 93, 92, 97, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_supplementary_the_story_of_mulan_item_1_read_the_story_of_mulan', 'tn10_eng_u3_supplementary_the_story_of_mulan', 'app_task', 'Reading', 'Read ''The Story of Mulan''', 'Read the heroic legend of Hua Mulan disguising as a man to save her aging father.', 88, 92, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_supplementary_the_story_of_mulan_item_2_study_supplementary_glossary', 'tn10_eng_u3_supplementary_the_story_of_mulan', 'source_activity', 'Glossary', 'Study Supplementary Glossary', 'Learn carve, robe, general, soldier, emperor.', 91, 95, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_supplementary_the_story_of_mulan_item_3_exercise_a_choose_the_best_option', 'tn10_eng_u3_supplementary_the_story_of_mulan', 'source_activity', 'Exercises', 'Exercise A: Choose the Best Option', 'Comprehension checks on why Mulan joined the army and how she saved China.', 91, 95, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_supplementary_the_story_of_mulan_item_4_exercise_b_identify_the_speaker', 'tn10_eng_u3_supplementary_the_story_of_mulan', 'source_activity', 'Exercises', 'Exercise B: Identify the Speaker', 'Match quotes with Mulan, Emperor, and Father.', 91, 95, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_supplementary_the_story_of_mulan_item_5_exercise_c_answer_in_1_2_sentences', 'tn10_eng_u3_supplementary_the_story_of_mulan', 'source_activity', 'Exercises', 'Exercise C: Answer in 1-2 Sentences', 'Questions on Mulan''s military battles and reward rejection.', 92, 96, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u3_supplementary_the_story_of_mulan_item_6_exercise_d_paragraph_question', 'tn10_eng_u3_supplementary_the_story_of_mulan', 'source_activity', 'Exercises', 'Exercise D: Paragraph Question', 'Evaluate Mulan''s patriotism, filial piety, and courage in detail.', 93, 97, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_eng_u4', 'tn10_eng_2024_edition', 4, 'Unit 4', 'Nostalgia, Human Relationships & Repentance', 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u4_prose_the_attic', 'tn10_eng_u4', 1, 'prose', 'The Attic', 'Satyajit Ray', false, 94, 114, 98, 118, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_1_read_the_attic', 'tn10_eng_u4_prose_the_attic', 'app_task', 'Reading', 'Read ''The Attic''', 'Satyajit Ray''s touching story of Aditya visiting his ancestral home to right an old wrong.', 94, 98, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_2_in_text_questions_a_h', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'In-text Questions', 'In-text Questions (a - h)', 'Questions on the tea shop, Sasanka Sanyal, the silver medal, and the attic visit.', 96, 100, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_3_study_glossary', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'Glossary', 'Study Glossary', 'Learn bifurcated, revive, soothing, rustic, vent.', 99, 103, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_4_comprehension_a_answer_in_1_2_sentences', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'Comprehension Questions', 'Comprehension A: Answer in 1-2 Sentences', 'Short answer questions on Sanyal''s recitation of Tagore''s poem and Aditya''s regret.', 100, 104, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_5_comprehension_b_paragraph_questions', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'Comprehension Questions', 'Comprehension B: Paragraph Questions', 'Paragraph responses on restitution, conscience, and childhood friendship.', 101, 105, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_6_vocabulary_affixes_prefixes_suffixes_a_d', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'Vocabulary', 'Vocabulary: Affixes, Prefixes & Suffixes (A - D)', 'Word building using prefixes and suffixes to form nouns and adjectives.', 102, 106, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_7_listening_speaking_audio_roleplay_e_g', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'Listening & Speaking', 'Listening & Speaking: Audio & Roleplay (E - G)', 'Listening to audio story and enacting scenes between Aditya and Sanyal.', 105, 109, 7, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_8_writing_article_writing_speech_writing', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'Writing', 'Writing: Article Writing & Speech Writing', 'Structure articles for school magazines and formal school assembly speeches.', 107, 111, 8, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_9_grammar_connectors_linkers_exercises_a_d', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'Grammar', 'Grammar: Connectors & Linkers (Exercises A - D)', 'Coordinating, subordinating, and correlative conjunctions.', 109, 113, 9, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_10_grammar_nominalisation_e_g', 'tn10_eng_u4_prose_the_attic', 'source_activity', 'Grammar', 'Grammar: Nominalisation (E - G)', 'Transforming verbs and adjectives into formal abstract nouns.', 112, 116, 10, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_prose_the_attic_item_11_revise_unit_4_connectors_word_forms', 'tn10_eng_u4_prose_the_attic', 'app_task', 'Revision', 'Revise Unit 4 Connectors & Word Forms', 'Review connectors, linkers, nominalisation, and comprehension.', 94, 98, 11, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u4_poem_the_ant_and_the_cricket', 'tn10_eng_u4', 2, 'poem', 'The Ant and the Cricket', 'Adapted from Aesop''s Fables', false, 115, 119, 119, 123, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_poem_the_ant_and_the_cricket_item_1_read_the_ant_and_the_cricket', 'tn10_eng_u4_poem_the_ant_and_the_cricket', 'app_task', 'Reading', 'Read ''The Ant and the Cricket''', 'Read the timeless fable on the importance of diligence, forethought, and hard work.', 115, 119, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_poem_the_ant_and_the_cricket_item_2_study_poem_glossary', 'tn10_eng_u4_poem_the_ant_and_the_cricket', 'source_activity', 'Glossary', 'Study Poem Glossary', 'Learn accustom, famine, miserly, quoth, warrant.', 116, 120, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_poem_the_ant_and_the_cricket_item_3_poem_comprehension_a_stanza_questions', 'tn10_eng_u4_poem_the_ant_and_the_cricket', 'source_activity', 'Comprehension Questions', 'Poem Comprehension A: Stanza Questions', 'Rhyme scheme, character contrasts between ant and cricket.', 117, 121, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_poem_the_ant_and_the_cricket_item_4_poem_comprehension_b_paragraph_question', 'tn10_eng_u4_poem_the_ant_and_the_cricket', 'source_activity', 'Comprehension Questions', 'Poem Comprehension B: Paragraph Question', 'Explain the fable''s moral: ''Work hard today to enjoy tomorrow.''', 118, 122, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_poem_the_ant_and_the_cricket_item_5_poem_appreciation_parallel_reading', 'tn10_eng_u4_poem_the_ant_and_the_cricket', 'source_activity', 'Poem Activities', 'Poem Appreciation & Parallel Reading', 'Compare with contemporary stories of thrift and planning.', 118, 122, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u4_supplementary_the_aged_mother', 'tn10_eng_u4', 3, 'supplementary', 'The Aged Mother', 'Matsuo Basho', false, 120, 125, 124, 129, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_supplementary_the_aged_mother_item_1_read_the_aged_mother', 'tn10_eng_u4_supplementary_the_aged_mother', 'app_task', 'Reading', 'Read ''The Aged Mother''', 'A Japanese folk tale illustrating the wisdom of elders in saving a province.', 120, 124, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_supplementary_the_aged_mother_item_2_study_supplementary_glossary', 'tn10_eng_u4_supplementary_the_aged_mother', 'source_activity', 'Glossary', 'Study Supplementary Glossary', 'Learn despotic, mandate, summit, twilight, ashes.', 123, 127, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_supplementary_the_aged_mother_item_3_exercise_a_match_true_false', 'tn10_eng_u4_supplementary_the_aged_mother', 'source_activity', 'Exercises', 'Exercise A: Match & True/False', 'Identify the tyrannical governor''s decree and the son''s devotion.', 123, 127, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_supplementary_the_aged_mother_item_4_exercise_b_answer_in_1_2_sentences', 'tn10_eng_u4_supplementary_the_aged_mother', 'source_activity', 'Exercises', 'Exercise B: Answer in 1-2 Sentences', 'Questions on the rope of ashes and the mother''s twigs dropped on the trail.', 124, 128, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u4_supplementary_the_aged_mother_item_5_exercise_c_paragraph_question', 'tn10_eng_u4_supplementary_the_aged_mother', 'source_activity', 'Exercises', 'Exercise C: Paragraph Question', 'Discuss the theme: ''With the crown of snow, there cometh wisdom.''', 125, 129, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_eng_u5', 'tn10_eng_2024_edition', 5, 'Unit 5', 'Technology, Assistive Devices & Future Innovation', 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u5_prose_tech_bloomers', 'tn10_eng_u5', 1, 'prose', 'Tech Bloomers', 'Informational / Technology Feature', false, 126, 147, 130, 151, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_1_read_tech_bloomers', 'tn10_eng_u5_prose_tech_bloomers', 'app_task', 'Reading', 'Read ''Tech Bloomers''', 'Discover how assistive technology empowers differently-abled individuals like Alisha and David.', 126, 130, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_2_in_text_questions_a_g', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'In-text Questions', 'In-text Questions (a - g)', 'Questions on dragon dictate, eye gaze technology, and assistive communication.', 128, 132, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_3_study_glossary', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'Glossary', 'Study Glossary', 'Learn debilitating, inclusions, impaired, prodigy, AAC.', 131, 135, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_4_comprehension_a_answer_in_1_2_sentences', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'Comprehension Questions', 'Comprehension A: Answer in 1-2 Sentences', 'How technology broke barriers for differently-abled students.', 131, 135, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_5_comprehension_b_paragraph_questions', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'Comprehension Questions', 'Comprehension B: Paragraph Questions', 'Detailed account of Kim''s Assistive Technology research and real-life impact.', 132, 136, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_6_vocabulary_compound_words_tech_acronyms_', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'Vocabulary', 'Vocabulary: Compound Words & Tech Acronyms (A - E)', 'Compound nouns, abbreviations, acronyms, and tech terminology.', 133, 137, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_7_listening_speaking_tech_debates_f_h', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'Listening & Speaking', 'Listening & Speaking: Tech Debates (F - H)', 'Speaking debate on artificial intelligence and assistive technology.', 136, 140, 7, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_8_writing_process_description_formal_email', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'Writing', 'Writing: Process Description & Formal Emails', 'Writing step-by-step instructions and technical explanations.', 138, 142, 8, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_9_grammar_pronouns_personal_relative_demon', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'Grammar', 'Grammar: Pronouns (Personal, Relative, Demonstrative) (A - D)', 'Relative clauses (who, which, that, whom, whose) and antecedents.', 140, 144, 9, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_10_grammar_reported_speech_direct_to_indire', 'tn10_eng_u5_prose_tech_bloomers', 'source_activity', 'Grammar', 'Grammar: Reported Speech (Direct to Indirect) (E - I)', 'Rules for statements, questions, imperatives, and exclamations.', 143, 147, 10, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_prose_tech_bloomers_item_11_revise_unit_5_reported_speech_relative_c', 'tn10_eng_u5_prose_tech_bloomers', 'app_task', 'Revision', 'Revise Unit 5 Reported Speech & Relative Clauses', 'Review reported speech transformation rules and exercises.', 126, 130, 11, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u5_poem_the_secret_of_the_machines', 'tn10_eng_u5', 2, 'poem', 'The Secret of the Machines', 'Rudyard Kipling', true, 148, 152, 152, 156, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_poem_the_secret_of_the_machines_item_1_recite_memorise_the_secret_of_the_machin', 'tn10_eng_u5_poem_the_secret_of_the_machines', 'app_task', 'Memoriter', 'Recite & Memorise ''The Secret of the Machines''', 'Memorise Kipling''s powerful poem on the power and limitations of industrial machines.', 148, 152, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_poem_the_secret_of_the_machines_item_2_study_poem_glossary', 'tn10_eng_u5_poem_the_secret_of_the_machines', 'source_activity', 'Glossary', 'Study Poem Glossary', 'Learn ore-bed, furnace, wrought, gauged, monster.', 150, 154, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_poem_the_secret_of_the_machines_item_3_poem_comprehension_a_stanza_questions', 'tn10_eng_u5_poem_the_secret_of_the_machines', 'source_activity', 'Comprehension Questions', 'Poem Comprehension A: Stanza Questions', 'Questions analyzing machine capabilities vs lack of human feelings and morality.', 150, 154, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_poem_the_secret_of_the_machines_item_4_poem_comprehension_b_paragraph_question', 'tn10_eng_u5_poem_the_secret_of_the_machines', 'source_activity', 'Comprehension Questions', 'Poem Comprehension B: Paragraph Question', 'Explain why machines are ''nothing more than children of your brain.''', 151, 155, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_poem_the_secret_of_the_machines_item_5_poem_appreciation_rhyme_imagery', 'tn10_eng_u5_poem_the_secret_of_the_machines', 'source_activity', 'Poem Activities', 'Poem Appreciation: Rhyme & Imagery', 'Hyperbole, personification, and mechanical rhythm.', 151, 155, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist', 'tn10_eng_u5', 3, 'supplementary', 'A day in 2889 of an American Journalist', 'Jules Verne', false, 153, 161, 157, 165, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist_item_1_read_a_day_in_2889_of_an_american_journa', 'tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist', 'app_task', 'Reading', 'Read ''A day in 2889 of an American Journalist''', 'Jules Verne''s visionary sci-fi story of Earth Chronicle editor Fritz Napoleon Smith in the year 2889.', 153, 157, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist_item_2_study_supplementary_glossary', 'tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist', 'source_activity', 'Glossary', 'Study Supplementary Glossary', 'Learn telephote, phonotelephote, aero-car, incubator, subterranean.', 158, 162, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist_item_3_exercise_a_identify_speaker_true_false', 'tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist', 'source_activity', 'Exercises', 'Exercise A: Identify Speaker & True/False', 'Distinguish futuristic inventions predicted by Jules Verne.', 159, 163, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist_item_4_exercise_b_answer_in_1_2_sentences', 'tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist', 'source_activity', 'Exercises', 'Exercise B: Answer in 1-2 Sentences', 'Questions on advertisements projected on clouds and fast tube travel.', 159, 163, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist_item_5_exercise_c_paragraph_question', 'tn10_eng_u5_supplementary_a_day_in_2889_of_an_american_journalist', 'source_activity', 'Exercises', 'Exercise C: Paragraph Question', 'Analyze Verne''s uncanny predictions that have become reality today.', 160, 164, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_eng_u6', 'tn10_eng_2024_edition', 6, 'Unit 6', 'Language Pride, Patriotism & Universal Brotherhood', 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u6_prose_the_last_lesson', 'tn10_eng_u6', 1, 'prose', 'The Last Lesson', 'Alphonse Daudet', false, 162, 178, 166, 182, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_1_read_the_last_lesson', 'tn10_eng_u6_prose_the_last_lesson', 'app_task', 'Reading', 'Read ''The Last Lesson''', 'Read Franz''s awakening to the value of his native mother tongue in Alsace-Lorraine.', 162, 166, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_2_in_text_questions_a_g', 'tn10_eng_u6_prose_the_last_lesson', 'source_activity', 'In-text Questions', 'In-text Questions (a - g)', 'Questions on M. Hamel''s green coat, villagers sitting on back benches, and the Prussian order.', 164, 168, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_3_study_glossary', 'tn10_eng_u6_prose_the_last_lesson', 'source_activity', 'Glossary', 'Study Glossary', 'Learn dread, commotion, gravely, reproach, vivat.', 167, 171, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_4_comprehension_a_answer_in_1_2_sentences', 'tn10_eng_u6_prose_the_last_lesson', 'source_activity', 'Comprehension Questions', 'Comprehension A: Answer in 1-2 Sentences', 'Why was Franz afraid of being questioned on participles?', 167, 171, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_5_comprehension_b_paragraph_questions', 'tn10_eng_u6_prose_the_last_lesson', 'source_activity', 'Comprehension Questions', 'Comprehension B: Paragraph Questions', 'M. Hamel''s tribute to the French language as the most beautiful, clear, and logical key to freedom.', 168, 172, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_6_vocabulary_foreign_words_expressions_a_d', 'tn10_eng_u6_prose_the_last_lesson', 'source_activity', 'Vocabulary', 'Vocabulary: Foreign Words & Expressions (A - D)', 'Latin and French loan words commonly used in English.', 169, 173, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_7_listening_speaking_patriotic_speeches', 'tn10_eng_u6_prose_the_last_lesson', 'source_activity', 'Listening & Speaking', 'Listening & Speaking: Patriotic Speeches', 'Deliver a speech on linguistic diversity and mother tongue pride.', 172, 176, 7, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_8_writing_poster_making_slogan_writing', 'tn10_eng_u6_prose_the_last_lesson', 'source_activity', 'Writing', 'Writing: Poster Making & Slogan Writing', 'Design informative and eye-catching posters with catchy slogans.', 173, 177, 8, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_9_grammar_simple_compound_and_complex_sent', 'tn10_eng_u6_prose_the_last_lesson', 'source_activity', 'Grammar', 'Grammar: Simple, Compound, and Complex Sentences (A - E)', 'Main clauses, subordinate clauses, and transformation of sentence types.', 175, 179, 9, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_prose_the_last_lesson_item_10_revise_unit_6_clause_transformation', 'tn10_eng_u6_prose_the_last_lesson', 'app_task', 'Revision', 'Revise Unit 6 Clause Transformation', 'Review simple, compound, and complex sentence transformations.', 162, 166, 10, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u6_poem_no_men_are_foreign', 'tn10_eng_u6', 2, 'poem', 'No Men Are Foreign', 'James Falconer Kirkup', true, 179, 182, 183, 186, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_poem_no_men_are_foreign_item_1_recite_memorise_no_men_are_foreign', 'tn10_eng_u6_poem_no_men_are_foreign', 'app_task', 'Memoriter', 'Recite & Memorise ''No Men Are Foreign''', 'Memorise the universal humanitarian poem condemning warfare and preaching world peace.', 179, 183, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_poem_no_men_are_foreign_item_2_study_poem_glossary', 'tn10_eng_u6_poem_no_men_are_foreign', 'source_activity', 'Glossary', 'Study Poem Glossary', 'Learn dispossess, betray, condemn, defile, outrage.', 180, 184, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_poem_no_men_are_foreign_item_3_poem_comprehension_a_stanza_questions', 'tn10_eng_u6_poem_no_men_are_foreign', 'source_activity', 'Comprehension Questions', 'Poem Comprehension A: Stanza Questions', 'Common human anatomy, harvests, and shared earth across countries.', 181, 185, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_poem_no_men_are_foreign_item_4_poem_comprehension_b_paragraph_question', 'tn10_eng_u6_poem_no_men_are_foreign', 'source_activity', 'Comprehension Questions', 'Poem Comprehension B: Paragraph Question', 'How does Kirkup prove that all human beings are brothers under the sun?', 181, 185, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_poem_no_men_are_foreign_item_5_poem_activities_appreciation', 'tn10_eng_u6_poem_no_men_are_foreign', 'source_activity', 'Poem Activities', 'Poem Activities & Appreciation', 'Universal brotherhood reflections and poetic devices.', 182, 186, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u6_supplementary_the_little_hero_of_holland', 'tn10_eng_u6', 3, 'supplementary', 'The Little Hero of Holland', 'Mary Mapes Dodge', false, 183, 188, 187, 192, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_supplementary_the_little_hero_of_holland_item_1_read_the_little_hero_of_holland', 'tn10_eng_u6_supplementary_the_little_hero_of_holland', 'app_task', 'Reading', 'Read ''The Little Hero of Holland''', 'The courageous tale of 8-year-old Peter holding back the North Sea leak with his finger through the night.', 183, 187, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_supplementary_the_little_hero_of_holland_item_2_study_supplementary_glossary', 'tn10_eng_u6_supplementary_the_little_hero_of_holland', 'source_activity', 'Glossary', 'Study Supplementary Glossary', 'Learn dike, trickle, sluice, numb, vigil.', 186, 190, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_supplementary_the_little_hero_of_holland_item_3_exercise_a_match_true_false', 'tn10_eng_u6_supplementary_the_little_hero_of_holland', 'source_activity', 'Exercises', 'Exercise A: Match & True/False', 'Check key milestones of Peter''s vigil at the dike.', 186, 190, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_supplementary_the_little_hero_of_holland_item_4_exercise_b_answer_in_1_2_sentences', 'tn10_eng_u6_supplementary_the_little_hero_of_holland', 'source_activity', 'Exercises', 'Exercise B: Answer in 1-2 Sentences', 'Peter''s sense of duty to his town and parents.', 187, 191, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u6_supplementary_the_little_hero_of_holland_item_5_exercise_c_paragraph_question', 'tn10_eng_u6_supplementary_the_little_hero_of_holland', 'source_activity', 'Exercises', 'Exercise C: Paragraph Question', 'Narrate Peter''s determination and how his alertness saved Holland from inundation.', 188, 192, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_eng_u7', 'tn10_eng_2024_edition', 7, 'Unit 7', 'Mystery, Detection, Wisdom & Human Dilemmas', 7)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u7_prose_the_dying_detective', 'tn10_eng_u7', 1, 'prose', 'The Dying Detective', 'Arthur Conan Doyle', false, 189, 201, 193, 205, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_1_read_the_dying_detective', 'tn10_eng_u7_prose_the_dying_detective', 'app_task', 'Reading', 'Read ''The Dying Detective''', 'Sherlock Holmes'' theatrical ruse to entrap Culverton Smith for Victor Savage''s murder.', 189, 193, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_2_in_text_questions_a_g', 'tn10_eng_u7_prose_the_dying_detective', 'source_activity', 'In-text Questions', 'In-text Questions (a - g)', 'Questions on Holmes'' fake fever, Dr. Watson''s concern, and the ivory box.', 191, 195, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_3_study_glossary', 'tn10_eng_u7_prose_the_dying_detective', 'source_activity', 'Glossary', 'Study Glossary', 'Learn delirious, gaunt, listless, ruse, vindictive.', 194, 198, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_4_comprehension_a_answer_in_1_2_sentences', 'tn10_eng_u7_prose_the_dying_detective', 'source_activity', 'Comprehension Questions', 'Comprehension A: Answer in 1-2 Sentences', 'Why did Holmes forbid Watson from examining him or touching his things?', 195, 199, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_5_comprehension_b_paragraph_questions', 'tn10_eng_u7_prose_the_dying_detective', 'source_activity', 'Comprehension Questions', 'Comprehension B: Paragraph Questions', 'Explain how Holmes outwitted Culverton Smith with the help of Inspector Morton.', 196, 200, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_6_vocabulary_homophones_confusables_britis', 'tn10_eng_u7_prose_the_dying_detective', 'source_activity', 'Vocabulary', 'Vocabulary: Homophones, Confusables & British/American English (A - E)', 'Distinguish tricky word pairs and American vs British spellings.', 196, 200, 6, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_7_listening_speaking_detective_clues_inter', 'tn10_eng_u7_prose_the_dying_detective', 'source_activity', 'Listening & Speaking', 'Listening & Speaking: Detective Clues & Interrogation', 'Simulate deductive reasoning dialogue and mystery clues.', 198, 202, 7, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_8_writing_pamphlet_making_story_writing', 'tn10_eng_u7_prose_the_dying_detective', 'source_activity', 'Writing', 'Writing: Pamphlet Making & Story Writing', 'Creating awareness pamphlets and continuing mystery stories.', 199, 203, 8, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_9_grammar_degrees_of_comparison_a_e', 'tn10_eng_u7_prose_the_dying_detective', 'source_activity', 'Grammar', 'Grammar: Degrees of Comparison (A - E)', 'Positive, Comparative, and Superlative degree transformations.', 200, 204, 9, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_prose_the_dying_detective_item_10_revise_unit_7_degrees_of_comparison', 'tn10_eng_u7_prose_the_dying_detective', 'app_task', 'Revision', 'Revise Unit 7 Degrees of Comparison', 'Review degrees of comparison rules and mystery story elements.', 189, 193, 10, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u7_poem_the_house_on_elm_street', 'tn10_eng_u7', 2, 'poem', 'The House on Elm Street', 'Nadia Bush', false, 202, 204, 206, 208, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_poem_the_house_on_elm_street_item_1_read_the_house_on_elm_street', 'tn10_eng_u7_poem_the_house_on_elm_street', 'app_task', 'Reading', 'Read ''The House on Elm Street''', 'Atmospheric poem capturing the suspense and ghostly rumors of an abandoned house.', 202, 206, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_poem_the_house_on_elm_street_item_2_study_poem_glossary', 'tn10_eng_u7_poem_the_house_on_elm_street', 'source_activity', 'Glossary', 'Study Poem Glossary', 'Learn dread, eerie, bare, fade, mystery.', 203, 207, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_poem_the_house_on_elm_street_item_3_poem_comprehension_a_stanza_questions', 'tn10_eng_u7_poem_the_house_on_elm_street', 'source_activity', 'Comprehension Questions', 'Poem Comprehension A: Stanza Questions', 'Poetic devices, imagery of the house that remains a mystery.', 203, 207, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_poem_the_house_on_elm_street_item_4_poem_comprehension_b_paragraph_question', 'tn10_eng_u7_poem_the_house_on_elm_street', 'source_activity', 'Comprehension Questions', 'Poem Comprehension B: Paragraph Question', 'Describe the eerie atmosphere and supernatural aura created by the poet.', 204, 208, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_eng_u7_supplementary_a_dilemma', 'tn10_eng_u7', 3, 'supplementary', 'A Dilemma', 'Silas Weir Mitchell', false, 205, 212, 209, 216, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_supplementary_a_dilemma_item_1_read_a_dilemma', 'tn10_eng_u7_supplementary_a_dilemma', 'app_task', 'Reading', 'Read ''A Dilemma''', 'Uncle Philip''s iron box bequest stuffed with priceless gems and dynamite trigger.', 205, 209, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_supplementary_a_dilemma_item_2_study_supplementary_glossary', 'tn10_eng_u7_supplementary_a_dilemma', 'source_activity', 'Glossary', 'Study Supplementary Glossary', 'Learn eccentricity, malice, bequeath, contrivance, dilemma.', 209, 213, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_supplementary_a_dilemma_item_3_exercise_a_match_true_false', 'tn10_eng_u7_supplementary_a_dilemma', 'source_activity', 'Exercises', 'Exercise A: Match & True/False', 'Comprehension check on Tom''s inheritance and the warning letter.', 210, 214, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_supplementary_a_dilemma_item_4_exercise_b_answer_in_1_2_sentences', 'tn10_eng_u7_supplementary_a_dilemma', 'source_activity', 'Exercises', 'Exercise B: Answer in 1-2 Sentences', 'Tom''s sleepless attempts, consultations with professors and dynamiters.', 210, 214, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_eng_u7_supplementary_a_dilemma_item_5_exercise_c_paragraph_question', 'tn10_eng_u7_supplementary_a_dilemma', 'source_activity', 'Exercises', 'Exercise C: Paragraph Question', 'Detail Tom''s psychological torment and his final bequest to the Smithsonian Institute.', 211, 215, 5, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
