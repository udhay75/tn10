-- ==========================================================================
-- 007_seed_tamil_2025.sql: Tamil Nadu State Board Class 10 Tamil Seed
-- Idempotent seed script: safe to run multiple times without duplicates.
-- ==========================================================================

-- 1. Tamil Subject
INSERT INTO subjects (code, title, class_code, medium_code)
VALUES ('class_10_tamil', 'Tamil (தமிழ்)', 'class_10', 'tamil')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;

-- 2. Textbook Edition
INSERT INTO textbook_editions (code, subject_code, edition_year, title, source_filename, is_published)
VALUES ('tn10_tam_2025_edition', 'class_10_tamil', 2025, 'பத்தாம் வகுப்பு தமிழ் (திருத்திய பதிப்பு 2020, 2021, 2022, 2023, 2024, 2025)', 'Class_10_Tamil_2025_Edition.pdf', true)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, is_published = EXCLUDED.is_published;

-- 3. Units, Lessons, and Checklist Items
-- Iyal 1: இயல் 1: அமுதஊற்று
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_tam_u1', 'tn10_tam_2025_edition', 1, 'இயல் 1: அமுதஊற்று', 'மொழி, மனிதன்: தமிழ் மொழியின் பெருமை, கவிதை இன்பம், சொல் வளம் & எழுத்து சொல் இலக்கணம்', 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u1_l1_poem', 'tn10_tam_u1', 1, 'poem', 'அன்னை மொழியே', 'பாவலரேறு பெருஞ்சித்திரனார்', true, 2, 3, 12, 13, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l1_poem_item_1', 'tn10_tam_u1_l1_poem', 'source_activity', 'Core Text', 'செய்யுள் வாசித்தல் & சொல்லும் பொருளும்', 'அன்னை மொழியே பாடலைச் சீர்பிரித்து வாசித்து நயமுணர்தல் மற்றும் சொல்லும் பொருளும் கற்றல்.', 2, 12, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l1_poem_item_2', 'tn10_tam_u1_l1_poem', 'source_activity', 'Explanation', 'பாடலின் பொருள் & தமிழின் சிறப்புகள்', 'செந்தமிழே, செழுந்தேனே, முத்தமிழே எனப் போற்றும் தமிழ் அன்னையின் சிறப்புகளைப் புரிந்துகொள்ளுதல்.', 2, 12, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l1_poem_item_3', 'tn10_tam_u1_l1_poem', 'source_activity', 'Memoriter', 'மனப்பாடப் பகுதி பயிற்சி & ஒப்புவித்தல்', 'சின்னக் குழந்தையின் சிரிப்பும் ஆனவள்... எனத் தொடங்கும் மனப்பாடப் பாடலை மனனம் செய்து பிழையின்றி எழுதுதல்.', 3, 13, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l1_poem_item_4', 'tn10_tam_u1_l1_poem', 'source_activity', 'Assessment', 'கவிதைப் பேழை வினா-விடைகள்', 'அன்னை மொழியே தொடர்பான குறுவினா மற்றும் சிறுவினாக்களுக்கு விடையளித்துப் பழகுதல்.', 3, 13, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u1_l2_prose', 'tn10_tam_u1', 2, 'prose', 'தமிழ்ச்சொல் வளம்', 'தேவநேயப் பாவாணர்', false, 4, 7, 14, 17, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l2_prose_item_1', 'tn10_tam_u1_l2_prose', 'source_activity', 'Core Reading', 'உரைநடை வாசிப்பு & சொல்வளக் கருத்துகள்', 'நாடும் மொழியும் நமதிரு கண்கள் என்ற நோக்கில் தாவரங்களின் உறுப்புப் பெயர்கள் மற்றும் சொல்வளத்தை வாசித்தல்.', 4, 14, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l2_prose_item_2', 'tn10_tam_u1_l2_prose', 'source_activity', 'In-text Analysis', 'அடிவகை, கிளைப்பிரிவுகள் & காய்-கனி வகை', 'தாள், தண்டு, கோல், தூறு மற்றும் கொம்பு, சினை, போத்து, இலை, பிஞ்சு வகைகளின் வேறுபாடுகளை அட்டவணைப்படுத்துதல்.', 5, 15, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l2_prose_item_3', 'tn10_tam_u1_l2_prose', 'source_activity', 'Assessment', 'உரைநடை மதிப்பீட்டு வினாக்கள்', 'தமிழ்ச்சொல் வளம் பாடத்தின் குறுவினா, சிறுவினா மற்றும் நெடுவினாக்களுக்கு விடையெழுதுதல்.', 7, 17, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u1_l3_poem', 'tn10_tam_u1', 3, 'poem', 'காலக்கணிதம்', 'கண்ணதாசன்', true, 8, 9, 18, 19, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l3_poem_item_1', 'tn10_tam_u1_l3_poem', 'source_activity', 'Core Text', 'கவிதை வாசிப்பு & கவிஞனின் உள்ளம்', 'கவிஞன் யானோர் காலக் கணிதம்... என்ற தலைசிறந்த தத்துவக் கவிதையை வாசித்துப் பொருள் அறிதல்.', 8, 18, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l3_poem_item_2', 'tn10_tam_u1_l3_poem', 'source_activity', 'Memoriter', 'மனப்பாடப் பகுதி பயிற்சி & ஒப்புவித்தல்', 'மாற்றம் எனது மானிடத் தத்துவம்... எனத் தொடங்கும் வரிகளை மனப்பாடம் செய்து ஒப்புவித்தல்.', 8, 18, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l3_poem_item_3', 'tn10_tam_u1_l3_poem', 'source_activity', 'Assessment', 'கவிதை நயமும் சிந்தனை வினாக்களும்', 'கண்ணதாசனின் காலக்கணிதப் பாடலின் மையக்கருத்து மற்றும் வினா-விடைகளைப் பயிற்சி செய்தல்.', 9, 19, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u1_l4_supplementary', 'tn10_tam_u1', 4, 'supplementary', 'புயலிலே ஒரு தோணி', 'ப. சிங்காரம்', false, 10, 12, 20, 22, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l4_supplementary_item_1', 'tn10_tam_u1_l4_supplementary', 'source_activity', 'Story Reading', 'விரிவானக் கதை வாசிப்பு', 'தென்கிழக்காசியக் கடலில் புயலில் சிக்கிய தோணியின் தத்ரூபமான வர்ணனைகளை வாசித்து உணர்தல்.', 10, 20, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l4_supplementary_item_2', 'tn10_tam_u1_l4_supplementary', 'source_activity', 'Plot Analysis', 'புயல் காட்சிக் குறிப்புகளும் சொல்லாட்சியும்', 'தொங்கான், கொப்பளிக்கும் கடல், இயற்கைச் சீற்றத்தின் சித்தரிப்புகளைத் தொகுத்து எழுதுதல்.', 11, 21, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l4_supplementary_item_3', 'tn10_tam_u1_l4_supplementary', 'source_activity', 'Essay Writing', 'கதைச்சுருக்கம் & நெடுவினாப் பயிற்சி', 'புயலிலே ஒரு தோணி கதையின் சுருக்கத்தை விவரித்துத் தேர்வுக்கான விரிவான விடையெழுதுதல்.', 12, 22, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u1_l5_theory', 'tn10_tam_u1', 5, 'theory', 'கற்கண்டு: எழுத்து, சொல்', 'தமிழ்நாடு பாடநூல் குழு (இலக்கணம்)', false, 13, 16, 23, 26, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l5_theory_item_1', 'tn10_tam_u1_l5_theory', 'source_activity', 'Grammar Rules', 'சார்பெழுத்துகள் & அளபெடை வகைகள்', 'உயிரளபெடை (செய்யுளிசை, இன்னிசை, சொல்லிசை) மற்றும் ஒற்றளபெடையின் இலக்கண விதிகளைக் கற்றல்.', 13, 23, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l5_theory_item_2', 'tn10_tam_u1_l5_theory', 'source_activity', 'Concepts & Examples', 'சொல் & மூவகை மொழிகள்', 'தனிமொழி, தொடர்மொழி, பொதுமொழி இலக்கணம் மற்றும் தொழிற்பெயர், வினையாலணையும் பெயர் வேறுபாடுகள்.', 15, 25, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l5_theory_item_3', 'tn10_tam_u1_l5_theory', 'source_activity', 'Assessment', 'இலக்கண வினா-விடைகள் & பயிற்சி', 'அளபெடை மற்றும் மூவகை மொழிகளுக்கான இலக்கண வினாக்களுக்கு விடையெழுதுதல்.', 16, 26, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u1_l6_exercise', 'tn10_tam_u1', 6, 'exercise', 'திறன் அறிவோம் & மொழியை ஆள்வோம்', 'தமிழ்நாடு பாடநூல் குழு (பயிற்சிகள்)', false, 17, 23, 27, 33, 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l6_exercise_item_1', 'tn10_tam_u1_l6_exercise', 'source_activity', 'Objective Questions', 'பலவுள் தெரிக & ஒருமதிப்பெண் வினாக்கள்', 'இயல் 1-ன் அனைத்துப் பலவுள் தெரிக வினாக்களுக்கும் சரியான விடையைக் கண்டறிந்து குறித்தல்.', 17, 27, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l6_exercise_item_2', 'tn10_tam_u1_l6_exercise', 'source_activity', 'Short Answers', 'குறுவினா & சிறுவினாப் பயிற்சி', 'வேங்கை என்பதைத் தொடர்மொழியாகவும் பொதுமொழியாகவும் விளக்குக உள்ளிட்ட வினாக்களுக்கு விடையெழுதுதல்.', 18, 28, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l6_exercise_item_3', 'tn10_tam_u1_l6_exercise', 'source_activity', 'Language Skills', 'மொழியை ஆள்வோம் & மொழியாக்கம்', 'மொழிபெயர்ப்புப் பயிற்சி, மரபுத்தொடர் பயன்பாடு மற்றும் கலைச்சொல் அறிவோம் பயிற்சிகளை முடித்தல்.', 20, 30, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u1_l6_exercise_item_4', 'tn10_tam_u1_l6_exercise', 'source_activity', 'Values & Ethics', 'நிற்க அதற்குத் தக & வாழ்வியல் பயிற்சி', 'இன்சொல் பேசுவேன், தாய்மொழியைப் போற்றுவேன் முதலான நெறிகளை வாழ்வில் கடைப்பிடித்தல்.', 22, 32, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Iyal 2: இயல் 2: உயிரின் ஓசை
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_tam_u2', 'tn10_tam_2025_edition', 2, 'இயல் 2: உயிரின் ஓசை', 'இயற்கை, சுற்றுச்சூழல், அறிவியல்: காற்று, வளிமண்டலம், சூழலியல், சங்க இலக்கிய இயற்கை & தொகாநிலைத் தொடர்கள்', 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u2_l1_prose', 'tn10_tam_u2', 1, 'prose', 'கேட்கிறதா என் குரல்!', 'தமிழ்நாடு பாடநூல் குழு (உரைநடை)', false, 24, 27, 34, 37, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l1_prose_item_1', 'tn10_tam_u2_l1_prose', 'source_activity', 'Core Reading', 'உரைநடை வாசிப்பு: காற்றின் சுயசரிதை', 'உயிரின வாழ்வின் அடிப்படை காற்று தன்னைப் பற்றிப் பேசும் உரைநடையை வாசித்தல்.', 24, 34, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l1_prose_item_2', 'tn10_tam_u2_l1_prose', 'source_activity', 'Concepts & Ecology', 'காற்றின் பெயர்கள், பருவக்காற்று & மாசடைதல்', 'வாடை, தென்றல், கொண்டல், கச்சான் பெயர்க்காரணங்களும் காற்று மாசடைதலைத் தடுக்கும் வழிகளும்.', 25, 35, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l1_prose_item_3', 'tn10_tam_u2_l1_prose', 'source_activity', 'Assessment', 'உரைநடை வினா-விடைகள்', 'கேட்கிறதா என் குரல் பாடத்தின் அனைத்து வினாக்களுக்கும் விடைகளை எழுதிப் பழகுதல்.', 27, 37, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u2_l2_poem', 'tn10_tam_u2', 2, 'poem', 'பரிபாடல்', 'கீரந்தையார்', false, 28, 29, 38, 39, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l2_poem_item_1', 'tn10_tam_u2_l2_poem', 'source_activity', 'Poem Reading', 'பரிபாடல் செய்யுள் வாசிப்பு', 'விசும்பில் ஊழி ஊழ்ஊழ் செல்ல... என அண்டப் பெருவெளியின் தோற்றம் கூறும் சங்கப் பாடலை வாசித்தல்.', 28, 38, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l2_poem_item_2', 'tn10_tam_u2_l2_poem', 'source_activity', 'Scientific Analysis', 'பாடலின் பொருள் & அறிவியல் உண்மை', 'ஐம்பூதங்களின் தோற்றம் குறித்த கீரந்தையாரின் சங்க கால அறிவியல் பார்வையைப் புரிந்துகொள்ளுதல்.', 28, 38, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l2_poem_item_3', 'tn10_tam_u2_l2_poem', 'source_activity', 'Assessment', 'பரிபாடல் வினா-விடைகள்', 'பரிபாடல் பாடப்பகுதி வினாக்கள் மற்றும் செய்யுள் நயங்களை எழுதிப் பயிற்சி செய்தல்.', 29, 39, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u2_l3_poem', 'tn10_tam_u2', 3, 'poem', 'மேகம்', 'கவிஞர் சிற்பி பாலசுப்பிரமணியம்', false, 30, 30, 40, 40, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l3_poem_item_1', 'tn10_tam_u2_l3_poem', 'source_activity', 'Poem Reading', 'கவிதை வாசிப்பு & கற்பனை நயம்', 'வானத்து நிலவொளியில் மேகங்களின் அழகியலைச் சித்தரிக்கும் புதுக்கவிதையை வாசித்தல்.', 30, 40, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l3_poem_item_2', 'tn10_tam_u2_l3_poem', 'source_activity', 'Appreciation', 'கவிதை நயமும் சொல்லாட்சியும்', 'கவிதையின் உவமை நயம் மற்றும் கவிஞர் உணர்த்தும் இயற்கை அழகினைப் புரிந்துகொள்ளுதல்.', 30, 40, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u2_l4_supplementary', 'tn10_tam_u2', 4, 'supplementary', 'பிரும்மம்', 'வண்ணதாசன்', false, 31, 34, 41, 44, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l4_supplementary_item_1', 'tn10_tam_u2_l4_supplementary', 'source_activity', 'Story Reading', 'துணைப்பாடக் கதை வாசிப்பு', 'மழைக்கால இயற்கை, சிட்டுக்குருவிகள், மனிதநேய உணர்வுகளை வெளிப்படுத்தும் கதையை வாசித்தல்.', 31, 41, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l4_supplementary_item_2', 'tn10_tam_u2_l4_supplementary', 'source_activity', 'Theme Analysis', 'சுற்றுச்சூழல் விழிப்புணர்வு & கதைக்கரு', 'உயிரினங்களின் இணைந்த வாழ்வு மற்றும் மனிதனின் இயற்கையோடு இயைந்த வாழ்க்கையைப் புரிந்துகொள்ளுதல்.', 33, 43, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l4_supplementary_item_3', 'tn10_tam_u2_l4_supplementary', 'source_activity', 'Essay Writing', 'விரிவான விடை & கதைச்சுருக்கம்', 'பிரும்மம் கதையின் கதாபாத்திரப் பண்புகள் மற்றும் மையக்கருத்தை விளக்கி எழுதுதல்.', 34, 44, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u2_l5_theory', 'tn10_tam_u2', 5, 'theory', 'கற்கண்டு: தொகாநிலைத் தொடர்கள்', 'தமிழ்நாடு பாடநூல் குழு (இலக்கணம்)', false, 35, 38, 45, 48, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l5_theory_item_1', 'tn10_tam_u2_l5_theory', 'source_activity', 'Grammar Rules', 'தொகாநிலைத் தொடர் இலக்கண விதிகள்', 'எழுவாய், விளி, வினைமுற்று, பெயரெச்ச, வினையெச்சத் தொடர்களின் இலக்கண விதிகளைக் கற்றல்.', 35, 45, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l5_theory_item_2', 'tn10_tam_u2_l5_theory', 'source_activity', 'Classifications', 'வேற்றுமை, இடை, உரி, அடுக்குத் தொடர்கள்', 'வேற்றுமைத் தொகாநிலைத் தொடர் முதல் அடுக்குத்தொடர் வரையிலான ஒன்பது வகைகளையும் அறிதல்.', 37, 47, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l5_theory_item_3', 'tn10_tam_u2_l5_theory', 'source_activity', 'Assessment', 'இலக்கணப் பயிற்சிகளும் வினா-விடைகளும்', 'தொகாநிலைத் தொடர்களைக் கண்டறிந்து வகைப்படுத்தும் பயிற்சிகளைச் செய்தல்.', 38, 48, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u2_l6_exercise', 'tn10_tam_u2', 6, 'exercise', 'திறன் அறிவோம் & மொழியை ஆள்வோம்', 'தமிழ்நாடு பாடநூல் குழு (பயிற்சிகள்)', false, 39, 45, 49, 55, 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l6_exercise_item_1', 'tn10_tam_u2_l6_exercise', 'source_activity', 'Objective Questions', 'பலவுள் தெரிக & மொழித்திறன்', 'இயல் 2 பலவுள் தெரிக ஒருமதிப்பெண் வினாக்களுக்கு விடையளித்தல்.', 39, 49, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l6_exercise_item_2', 'tn10_tam_u2_l6_exercise', 'source_activity', 'Short Answers', 'குறுவினா & சிறுவினாப் பயிற்சி', 'உயிராக நான், பலபெயர்களில் நான், இளவேனில்காலக் காற்று ஆகிய வினாக்களுக்கு விடையெழுதுதல்.', 40, 50, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l6_exercise_item_3', 'tn10_tam_u2_l6_exercise', 'source_activity', 'Language Skills', 'மொழியை ஆள்வோம்: பத்தி வினா & மொழியாக்கம்', 'பத்தியைப் படித்து வினாக்களுக்கு விடையளித்தல் மற்றும் சுற்றுச்சூழல் விழிப்புணர்வுக் கலைச்சொற்கள்.', 42, 52, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u2_l6_exercise_item_4', 'tn10_tam_u2_l6_exercise', 'source_activity', 'Action & Ethics', 'நிற்க அதற்குத் தக & மரம் நடுவோம் உறுதிமொழி', 'சுற்றுச்சூழலைப் பாதுகாப்பேன், நெகிழியைக் குறைப்பேன் என உறுதியேற்று நடத்தல்.', 44, 54, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Iyal 3: இயல் 3: கூட்டாஞ்சோறு
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_tam_u3', 'tn10_tam_2025_edition', 3, 'இயல் 3: கூட்டாஞ்சோறு', 'பண்பாடு: விருந்தோம்பல் மரபு, காசிக்காண்டம், பிள்ளைத்தமிழ் இலக்கியம், வட்டார வழக்கு & தொகைநிலைத் தொடர்கள்', 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u3_l1_prose', 'tn10_tam_u3', 1, 'prose', 'விருந்து போற்றுதும்!', 'தமிழ்நாடு பாடநூல் குழு (உரைநடை)', false, 46, 49, 56, 59, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l1_prose_item_1', 'tn10_tam_u3_l1_prose', 'source_activity', 'Core Reading', 'உரைநடை வாசிப்பு: தமிழரின் விருந்தோம்பல்', 'அறவோர்க்கு அளித்தலும் அந்தணர்க்கு ஓம்பலும்... எனத் தொடங்கும் தமிழர் விருந்தோம்பல் மரபை வாசித்தல்.', 46, 56, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l1_prose_item_2', 'tn10_tam_u3_l1_prose', 'source_activity', 'Literary Evidence', 'இல்லற விருந்தும் இலக்கியச் சான்றுகளும்', 'தொல்காப்பியம், சிலப்பதிகாரம், புறநானூறு காட்டும் இல்லக விருந்தோம்பல் சிறப்புகளை அறிதல்.', 47, 57, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l1_prose_item_3', 'tn10_tam_u3_l1_prose', 'source_activity', 'Assessment', 'உரைநடை வினா-விடைகள்', 'விருந்தோம்பல் பண்பு குறித்த குறுவினா, சிறுவினா மற்றும் நெடுவினாக்களை எழுதிப் பயிற்சி செய்தல்.', 49, 59, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u3_l2_poem', 'tn10_tam_u3', 2, 'poem', 'காசிக்காண்டம்', 'அதிவீரராம பாண்டியர்', true, 50, 51, 60, 61, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l2_poem_item_1', 'tn10_tam_u3_l2_poem', 'source_activity', 'Core Reading', 'செய்யுள் வாசிப்பு & விருந்தோம்பல் நெறிகள்', 'விருந்தினனாக ஒருவன் வந்து எதிர் கொள்ளின்... எனத் தொடங்கும் ஒன்பது விருந்தோம்பல் நெறிகளை வாசித்தல்.', 50, 60, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l2_poem_item_2', 'tn10_tam_u3_l2_poem', 'source_activity', 'Memoriter', 'மனப்பாடப் பகுதி ஒப்புவித்தல்', 'விருந்தினர் முகமலர்ச்சி, இன்சொல் பேசுதல், வழியனுப்புதல் முதலான மனப்பாட அடிகளை மனனம் செய்தல்.', 50, 60, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l2_poem_item_3', 'tn10_tam_u3_l2_poem', 'source_activity', 'Assessment', 'காசிக்காண்ட வினா-விடைகள்', 'காசிக்காண்ட விருந்தோம்பல் ஒழுக்கங்கள் குறித்த வினாக்களுக்கு விடையெழுதுதல்.', 51, 61, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u3_l3_poem', 'tn10_tam_u3', 3, 'poem', 'முத்துக்குமாரசாமி பிள்ளைத்தமிழ்', 'குமரகுருபரர்', false, 52, 53, 62, 63, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l3_poem_item_1', 'tn10_tam_u3_l3_poem', 'source_activity', 'Poem Reading', 'செங்கீரைப் பருவச் செய்யுள் வாசிப்பு', 'செம்பொன் அடிச்சிறு கிண்கிணியோடு... என முருகப்பெருமானின் குழந்தைப் பருவக் காட்சியை வாசித்தல்.', 52, 62, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l3_poem_item_2', 'tn10_tam_u3_l3_poem', 'source_activity', 'Literary Terms', 'பிள்ளைத்தமிழ் உறுப்புகளும் பருவங்களும்', 'ஆண்பாற் பிள்ளைத்தமிழ், பெண்பாற் பிள்ளைத்தமிழின் பத்துப் பருவங்களையும் செங்கீரைப் பருவ நயத்தையும் அறிதல்.', 52, 62, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l3_poem_item_3', 'tn10_tam_u3_l3_poem', 'source_activity', 'Assessment', 'செய்யுள் வினா-விடைகள்', 'குமரகுருபரரின் முத்துக்குமாரசாமி பிள்ளைத்தமிழ் வினாக்களுக்கு விடையெழுதுதல்.', 53, 63, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u3_l4_supplementary', 'tn10_tam_u3', 4, 'supplementary', 'கோபல்லபுரத்து மக்கள்', 'கி. ராஜநாராயணன்', false, 54, 58, 64, 68, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l4_supplementary_item_1', 'tn10_tam_u3_l4_supplementary', 'source_activity', 'Story Reading', 'வட்டார வழக்குக் கதை வாசிப்பு', 'கரிசல் நில மக்களின் விருந்தோம்பல் மற்றும் பாச உணர்வை வெளிப்படுத்தும் கதையை வாசித்தல்.', 54, 64, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l4_supplementary_item_2', 'tn10_tam_u3_l4_supplementary', 'source_activity', 'Character Study', 'கரிசல் இலக்கியமும் அன்னமய்யா பண்பும்', 'பசித்த வழிப்போக்கனுக்குக் கஞ்சியூற்றி மகிழும் அன்னமய்யாவின் மனிதநேயப் பண்பை ஆராய்தல்.', 56, 66, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l4_supplementary_item_3', 'tn10_tam_u3_l4_supplementary', 'source_activity', 'Essay Writing', 'விரிவான விடை & கதைச்சுருக்கம்', 'கோபல்லபுரத்து மக்கள் கதையின் வழி அறியலாகும் பண்பாட்டு விழுமியங்களை விவரித்து எழுதுதல்.', 58, 68, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u3_l5_theory', 'tn10_tam_u3', 5, 'theory', 'கற்கண்டு: தொகைநிலைத் தொடர்கள்', 'தமிழ்நாடு பாடநூல் குழு (இலக்கணம்)', false, 59, 61, 69, 71, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l5_theory_item_1', 'tn10_tam_u3_l5_theory', 'source_activity', 'Grammar Rules', 'தொகைநிலைத் தொடர் ஆறு வகைகள்', 'வேற்றுமை, வினை, பண்பு, உவமை, உம்மை, அன்மொழித் தொகைகளின் இலக்கண விதிகளைக் கற்றல்.', 59, 69, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l5_theory_item_2', 'tn10_tam_u3_l5_theory', 'source_activity', 'Classification', 'எடுத்துக்காட்டுகளும் வகைப்பாடும்', 'கரும்பு தின்றான், செந்தாமரை, மலர்க்கை, அண்ணன் தம்பி, சிவப்புச் சட்டை பேசினார் சான்றுகளைப் பகுத்தாய்தல்.', 60, 70, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l5_theory_item_3', 'tn10_tam_u3_l5_theory', 'source_activity', 'Assessment', 'இலக்கணப் பயிற்சிகளும் வினா-விடைகளும்', 'தொகைநிலைத் தொடர்களை இனம் கண்டு பிரித்தெழுதுதல் மற்றும் தேர்வு வினாக்களுக்கு விடையெழுதுதல்.', 61, 71, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u3_l6_exercise', 'tn10_tam_u3', 6, 'exercise', 'திறன் அறிவோம் & மொழியை ஆள்வோம்', 'தமிழ்நாடு பாடநூல் குழு (பயிற்சிகள்)', false, 62, 65, 72, 75, 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l6_exercise_item_1', 'tn10_tam_u3_l6_exercise', 'source_activity', 'Objective Questions', 'பலவுள் தெரிக & மதிப்பீடு', 'இயல் 3 பலவுள் தெரிக ஒருமதிப்பெண் வினாக்களைச் சரியாகத் தேர்ந்தெடுத்து எழுதுதல்.', 62, 72, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l6_exercise_item_2', 'tn10_tam_u3_l6_exercise', 'source_activity', 'Short Answers', 'குறுவினா & சிறுவினாப் பயிற்சி', 'விருந்தினர் முகம் எப்போது வாடும், மருத்துவத்தில் மருந்துடன் விருந்தோம்பல் பங்கு வினாக்களுக்கு விடையெழுதுதல்.', 63, 73, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l6_exercise_item_3', 'tn10_tam_u3_l6_exercise', 'source_activity', 'Language Skills', 'மொழியை ஆள்வோம்: தொடர் மாற்றம் & கலைச்சொல்', 'உவமைத் தொடர்களைப் பயன்படுத்திச் சொற்றொடர் அமைத்தல் மற்றும் பண்பாட்டுக் கலைச்சொற்கள்.', 64, 74, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u3_l7_review', 'tn10_tam_u3', 7, 'review', 'வாழ்வியல்: திருக்குறள்', 'திருவள்ளுவர்', true, 66, 71, 76, 81, 7)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l7_review_item_1', 'tn10_tam_u3_l7_review', 'source_activity', 'Kural Study', 'அறத்துப்பால், பொருட்பால் குறள்கள் வாசிப்பு', 'ஒழுக்கமுடைமை, மெய்யுணர்தல், பெரியாரைத் துணைக்கோடல் அதிகாரக் குறள்களைப் பொருள் விளங்கி வாசித்தல்.', 66, 76, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l7_review_item_2', 'tn10_tam_u3_l7_review', 'source_activity', 'Memoriter', 'மனப்பாடக் குறள்கள் மனனம் & ஒப்புவித்தல்', 'ஒழுக்கம் விழுப்பம் தரலான்... உள்ளிட்ட நட்சத்திரக் குறியிட்ட மனப்பாடக் குறள்களைப் பிழையின்றி எழுதுதல்.', 67, 77, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u3_l7_review_item_3', 'tn10_tam_u3_l7_review', 'source_activity', 'Assessment & Poetics', 'அணி இலக்கணம் & வாழ்வியல் வினாக்கள்', 'சொற்பொருள் பின்வரு நிலையணி, வேற்றுமையணி மற்றும் திருக்குறள் சிந்தனை வினாக்களுக்கு விடையெழுதுதல்.', 70, 80, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Iyal 4: இயல் 4: மணற்கேணி
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_tam_u4', 'tn10_tam_2025_edition', 4, 'இயல் 4: மணற்கேணி', 'கல்வி: மொழிபெயர்ப்புக் கலை, திருவிளையாடற் புராணம், புதிய நம்பிக்கை & பொது இலக்கணம்', 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u4_l1_prose', 'tn10_tam_u4', 1, 'prose', 'மொழிபெயர்ப்புக் கல்வி', 'தமிழ்நாடு பாடநூல் குழு (உரைநடை)', false, 72, 75, 82, 85, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l1_prose_item_1', 'tn10_tam_u4_l1_prose', 'source_activity', 'Core Reading', 'உரைநடை வாசிப்பு: மொழிபெயர்ப்பின் இன்றியமையாமை', 'மொழிபெயர்ப்பு என்றால் என்ன, ஒரு மொழியில் உணர்த்தப்பட்டதை வேறொரு மொழியில் வெளியிடுதல் பற்றி வாசித்தல்.', 72, 82, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l1_prose_item_2', 'tn10_tam_u4_l1_prose', 'source_activity', 'In-depth Study', 'மொழிபெயர்ப்புக் காலமும் பயனும்', 'உலகளாவிய அறிவுப் பரிமாற்றம், அறிவியல் வளர்ச்சி, இலக்கிய வளம் ஆகியவற்றில் மொழிபெயர்ப்பின் பங்கை அறிதல்.', 74, 84, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l1_prose_item_3', 'tn10_tam_u4_l1_prose', 'source_activity', 'Assessment', 'உரைநடை வினா-விடைகள்', 'மொழிபெயர்ப்புக் கல்வி பாடத்தின் குறுவினா, சிறுவினா மற்றும் நெடுவினாக்களை எழுதிப் பழகுதல்.', 75, 85, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u4_l2_poem', 'tn10_tam_u4', 2, 'poem', 'திருவிளையாடற் புராணம்', 'பரஞ்சோதி முனிவர்', true, 76, 79, 86, 89, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l2_poem_item_1', 'tn10_tam_u4_l2_poem', 'source_activity', 'Poem Reading', 'செய்யுள் வாசிப்பு: இடைக்காடன் பிணக்கு', 'குலேச பாண்டியன் அவையில் புலவர் இடைக்காடனார் அவமதிக்கப்பட்டதும் இறைவன் சினந்ததும் வாசித்தல்.', 76, 86, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l2_poem_item_2', 'tn10_tam_u4_l2_poem', 'source_activity', 'Memoriter', 'மனப்பாடப் பகுதி ஒப்புவித்தல்', 'மன்னன் புலவரிடம் மன்னிப்புக் கோரிய காட்சி மற்றும் மனப்பாடப் பாடலடிகளை மனனம் செய்து ஒப்புவித்தல்.', 77, 87, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l2_poem_item_3', 'tn10_tam_u4_l2_poem', 'source_activity', 'Assessment', 'செய்யுள் நயமும் வினா-விடைகளும்', 'புலவர் பெருமை, இறைவனின் திருவிளையாடல் வினாக்களுக்குச் சுவைபட விடையெழுதுதல்.', 79, 89, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u4_l3_supplementary', 'tn10_tam_u4', 3, 'supplementary', 'புதிய நம்பிக்கை', 'கமலாலயன்', false, 80, 83, 90, 93, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l3_supplementary_item_1', 'tn10_tam_u4_l3_supplementary', 'source_activity', 'Biography Reading', 'மேரி மெக்லியோட் பெத்யூன் வாழ்க்கை வாசிப்பு', 'கல்வி மறுக்கப்பட்ட கறுப்பினச் சிறுமி கல்வி கற்றுப் பள்ளி நிறுவிய உண்மை வரலாற்றுப் பின்னணியை வாசித்தல்.', 80, 90, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l3_supplementary_item_2', 'tn10_tam_u4_l3_supplementary', 'source_activity', 'Theme Study', 'கல்வியின் ஆற்றலும் தன்னம்பிக்கையும்', 'ஒரு புத்தகத்தின் முதல் பக்கத்தைத் திறந்ததும் உலகம் திறந்தது என்ற கல்வி விழிப்பை உணர்தல்.', 82, 92, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l3_supplementary_item_3', 'tn10_tam_u4_l3_supplementary', 'source_activity', 'Essay Writing', 'விரிவான விடை & கட்டுரை', 'புதிய நம்பிக்கை கதை தரும் உத்வேகத்தை விளக்கித் தேர்வுக்கான முழுமதிப்பெண் கட்டுரை எழுதுதல்.', 83, 93, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u4_l4_theory', 'tn10_tam_u4', 4, 'theory', 'கற்கண்டு: இலக்கணம் - பொது', 'தமிழ்நாடு பாடநூல் குழு (இலக்கணம்)', false, 84, 87, 94, 97, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l4_theory_item_1', 'tn10_tam_u4_l4_theory', 'source_activity', 'Grammar Rules', 'திணை, பால், இடம் & வழு, வழுவமைதி', 'இருதிணை, ஐம்பால், மூவிடம் மற்றும் வழு, வழாநிலை, வழுவமைதியின் ஐந்து வகைகளை அறிதல்.', 84, 94, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l4_theory_item_2', 'tn10_tam_u4_l4_theory', 'source_activity', 'Analysis', 'வழுவமைதி சான்றுகளும் பயன்பாடும்', 'திணை, பால், இட, கால, மரபு வழுவமைதி சான்றுகளைப் பகுத்தாய்ந்து பிழையின்றிப் பேசக் கற்றல்.', 86, 96, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l4_theory_item_3', 'tn10_tam_u4_l4_theory', 'source_activity', 'Assessment', 'இலக்கண வினா-விடைகள் & பயிற்சி', 'வழுவமைதி மற்றும் இலக்கணப் பொது வினாக்களுக்குத் துல்லியமாக விடையெழுதுதல்.', 87, 97, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u4_l5_exercise', 'tn10_tam_u4', 5, 'exercise', 'திறன் அறிவோம் & மொழியை ஆள்வோம்', 'தமிழ்நாடு பாடநூல் குழு (பயிற்சிகள்)', false, 88, 93, 98, 103, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l5_exercise_item_1', 'tn10_tam_u4_l5_exercise', 'source_activity', 'Objective Questions', 'பலவுள் தெரிக & ஒருமதிப்பெண் வினாக்கள்', 'இயல் 4 பலவுள் தெரிக வினாக்களுக்குத் துல்லியமாக விடையளித்துப் பயிற்சி பெறுதல்.', 88, 98, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l5_exercise_item_2', 'tn10_tam_u4_l5_exercise', 'source_activity', 'Short Answers', 'குறுவினா & சிறுவினாப் பயிற்சி', 'கழிந்த பெரும் கேள்வியினான், வழுவமைதி என்றால் என்ன வினாக்களுக்கு விடையெழுதுதல்.', 89, 99, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l5_exercise_item_3', 'tn10_tam_u4_l5_exercise', 'source_activity', 'Writing & Vocabulary', 'மொழியை ஆள்வோம்: கடிதம் & கலைச்சொல்', 'நூலகத்திற்குப் புத்தகங்கள் கேட்டு விண்ணப்பம் எழுதுதல் மற்றும் கல்விக் கலைச்சொற்கள்.', 91, 101, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u4_l5_exercise_item_4', 'tn10_tam_u4_l5_exercise', 'source_activity', 'Action & Values', 'நிற்க அதற்குத் தக: நூலகம் செல்வோம்', 'நாள்தோறும் நூலகம் செல்வேன், நல்ல புத்தகங்களை வாசிப்பேன் என உறுதிபூணுதல்.', 93, 103, 4, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Iyal 5: இயல் 5: நிலா முற்றம்
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_tam_u5', 'tn10_tam_2025_edition', 5, 'இயல் 5: நிலா முற்றம்', 'கலை, அழகியல், புதுமை: பன்முகக் கலைஞர், கம்பராமாயணக் கவிநயம், பாய்ச்சல் சிறுகதை & அகப்பொருள் இலக்கணம்', 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u5_l1_prose', 'tn10_tam_u5', 1, 'prose', 'பன்முகக் கலைஞர்', 'தமிழ்நாடு பாடநூல் குழு (உரைநடை)', false, 94, 98, 104, 108, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l1_prose_item_1', 'tn10_tam_u5_l1_prose', 'source_activity', 'Core Reading', 'உரைநடை வாசிப்பு: மு. கருணாநிதி கலைப்பணி', 'எழுத்தாளர், கவிஞர், உரையாசிரியர், நாடகாசிரியர், திரைப்பட வசனகர்த்தா பன்முக ஆற்றலை வாசித்தல்.', 94, 104, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l1_prose_item_2', 'tn10_tam_u5_l1_prose', 'source_activity', 'Literary Contribution', 'செம்மொழிப் பங்களிப்பும் கலைப் படைப்புகளும்', 'திருக்குறள் உரை, பூம்புகார், செம்மொழி மாநாடு மற்றும் தமிழ் வளர்ச்சிக்கான வரலாற்றுச் சாதனைகள்.', 96, 106, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l1_prose_item_3', 'tn10_tam_u5_l1_prose', 'source_activity', 'Assessment', 'உரைநடை வினா-விடைகள்', 'பன்முகக் கலைஞர் உரைநடைப் பகுதியின் அனைத்து வினாக்களுக்கும் விடையெழுதுதல்.', 98, 108, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u5_l2_poem', 'tn10_tam_u5', 2, 'poem', 'கம்பராமாயணம்', 'கம்பர்', true, 99, 101, 109, 111, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l2_poem_item_1', 'tn10_tam_u5_l2_poem', 'source_activity', 'Poem Reading', 'கம்பராமாயணச் செய்யுள் வாசிப்பு', 'பால காண்டம், அயோத்தியா காண்டம், ஆரணிய காண்டக் கவிதை நயங்களை வாசித்துப் பொருள் உணர்தல்.', 99, 109, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l2_poem_item_2', 'tn10_tam_u5_l2_poem', 'source_activity', 'Memoriter', 'மனப்பாடப் பாடல் ஒப்புவித்தல்', 'தண்டலை மயில்கள் ஆடத் தாமரை விளக்கம் தாங்க... எனத் தொடங்கும் சந்த நயக் கவிதையை மனனம் செய்தல்.', 100, 110, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l2_poem_item_3', 'tn10_tam_u5_l2_poem', 'source_activity', 'Assessment', 'கம்பரின் உவமை நயமும் வினா-விடைகளும்', 'கம்பன் வீட்டுக் கட்டுத்தறியும் கவிபாடும் என்பதற்கேற்ப கற்பனை நய வினாக்களுக்கு விடையெழுதுதல்.', 101, 111, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u5_l3_supplementary', 'tn10_tam_u5', 3, 'supplementary', 'பாய்ச்சல்', 'சா. கந்தசாமி', false, 102, 105, 112, 115, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l3_supplementary_item_1', 'tn10_tam_u5_l3_supplementary', 'source_activity', 'Story Reading', 'நாட்டுப்புறக் கலைக்கதை வாசிப்பு', 'தெருக்கூத்து மற்றும் கரகாட்டக் கலைஞரின் அசாத்தியமான ஆட்டப் பாய்ச்சலைச் சுவைபட வாசித்தல்.', 102, 112, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l3_supplementary_item_2', 'tn10_tam_u5_l3_supplementary', 'source_activity', 'Art & Aesthetics', 'கலைஞனின் அர்ப்பணிப்பும் அழகியலும்', 'ஆட்டக் கலையில் தன்னை மறந்து இயங்கும் கலைஞனின் உணர்வுகளைப் பகுத்தாய்தல்.', 104, 114, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l3_supplementary_item_3', 'tn10_tam_u5_l3_supplementary', 'source_activity', 'Essay Writing', 'விரிவான விடை & கதைச்சுருக்கம்', 'பாய்ச்சல் கதையின் நயங்கள் மற்றும் கலை வளர்ச்சி வினாக்களுக்குக் கட்டுரை வடிவில் விடையெழுதுதல்.', 105, 115, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u5_l4_theory', 'tn10_tam_u5', 4, 'theory', 'கற்கண்டு: அகப்பொருள் இலக்கணம்', 'தமிழ்நாடு பாடநூல் குழு (இலக்கணம்)', false, 106, 109, 116, 119, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l4_theory_item_1', 'tn10_tam_u5_l4_theory', 'source_activity', 'Grammar Rules', 'ஐந்திணைகளும் முதற்பொருளும்', 'குறிஞ்சி, முல்லை, மருதம், நெய்தல், பாலை நிலங்களும் பொழுதுகளும் (சிறுபொழுது, பெரும்பொழுது) அறிதல்.', 106, 116, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l4_theory_item_2', 'tn10_tam_u5_l4_theory', 'source_activity', 'Classification', 'கருப்பொருளும் உரிப்பொருளும்', 'ஐவகை நிலத்திற்குரிய தெய்வம், மக்கள், தொழில், பண் மற்றும் புணர்தல், பிரிதல் உரிப்பொருள்களை அட்டவணைப்படுத்துதல்.', 108, 118, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l4_theory_item_3', 'tn10_tam_u5_l4_theory', 'source_activity', 'Assessment', 'அகப்பொருள் வினா-விடைகள்', 'அகப்பொருள் இலக்கண வினாக்களுக்குத் துல்லியமாக விடையெழுதுதல்.', 109, 119, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u5_l5_exercise', 'tn10_tam_u5', 5, 'exercise', 'திறன் அறிவோம் & மொழியை ஆள்வோம்', 'தமிழ்நாடு பாடநூல் குழு (பயிற்சிகள்)', false, 110, 115, 120, 125, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l5_exercise_item_1', 'tn10_tam_u5_l5_exercise', 'source_activity', 'Objective Questions', 'பலவுள் தெரிக & மதிப்பீடு', 'இயல் 5 பலவுள் தெரிக ஒருமதிப்பெண் வினாக்களுக்குச் சரியான விடையைக் குறித்தல்.', 110, 120, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l5_exercise_item_2', 'tn10_tam_u5_l5_exercise', 'source_activity', 'Short Answers', 'குறுவினா & சிறுவினாப் பயிற்சி', 'கலைஞரின் எழுத்தாற்றல், அகப்பொருள் திணைகள் குறித்த வினாக்களுக்கு விடையெழுதுதல்.', 111, 121, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l5_exercise_item_3', 'tn10_tam_u5_l5_exercise', 'source_activity', 'Vocabulary & Games', 'மொழியோடு விளையாடு & கலைச்சொல்', 'கலைச்சொல் அறிவோம் (Aesthetics, Modernism, Metaphor) மற்றும் தொடரமைப்புப் பயிற்சிகள்.', 113, 123, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u5_l6_review', 'tn10_tam_u5', 6, 'review', 'வாழ்வியல்: திருக்குறள்', 'திருவள்ளுவர்', true, 116, 121, 126, 131, 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l6_review_item_1', 'tn10_tam_u5_l6_review', 'source_activity', 'Kural Study', 'பொருட்பால் குறள்கள் வாசிப்பு', 'அமைச்சு, பொருள்செயல்வகை, கூடாநட்பு அதிகாரக் குறள்களைப் பொருள்விளங்கி வாசித்தல்.', 116, 126, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l6_review_item_2', 'tn10_tam_u5_l6_review', 'source_activity', 'Memoriter', 'மனப்பாடக் குறள்கள் மனனம் & ஒப்புவித்தல்', 'கருவியும் காலமும் செய்கையும்... எனத் தொடங்கும் மனப்பாடக் குறள்களைப் பிழையின்றி எழுதுதல்.', 117, 127, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u5_l6_review_item_3', 'tn10_tam_u5_l6_review', 'source_activity', 'Assessment', 'திருக்குறள் வினா-விடைகளும் பொருளுணர்வும்', 'அமைச்சருக்குரிய தகுதிகள், பொருளின் இன்றியமையாமை வினாக்களுக்கு விடையெழுதுதல்.', 120, 130, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Iyal 6: இயல் 6: விதை நெல்
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_tam_u6', 'tn10_tam_2025_edition', 6, 'இயல் 6: விதை நெல்', 'நாகரிகம், நாடு, சமூகம்: சிற்பக்கலை, சிலப்பதிகாரம், முத்தொள்ளாயிரம், சாதனைப் பெண்கள் & புறப்பொருள் இலக்கணம்', 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u6_l1_prose', 'tn10_tam_u6', 1, 'prose', 'சிற்பக்கலை ஒளி', 'தமிழ்நாடு பாடநூல் குழு (உரைநடை)', false, 122, 125, 132, 135, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l1_prose_item_1', 'tn10_tam_u6_l1_prose', 'source_activity', 'Core Reading', 'உரைநடை வாசிப்பு: தமிழரின் சிற்பக் கலை மரபு', 'பல்லவர், சோழர், பாண்டியர், நாயக்கர் காலச் சிற்பங்களின் தனித்துவங்களை வாசித்தல்.', 122, 132, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l1_prose_item_2', 'tn10_tam_u6_l1_prose', 'source_activity', 'Art History', 'மாமல்லபுரம், தஞ்சைப் பெருங்கோயில் நுணுக்கங்கள்', 'சுதைச் சிற்பங்கள், கற்றளிகள், உலோகத் திருமேனிகள், புடைப்புச் சிற்ப நுட்பங்களைப் புரிந்துகொள்ளுதல்.', 124, 134, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l1_prose_item_3', 'tn10_tam_u6_l1_prose', 'source_activity', 'Assessment', 'உரைநடை வினா-விடைகள்', 'சிற்பக்கலை பாடத்தின் குறுவினா, சிறுவினா மற்றும் நெடுவினாக்களை எழுதிப் பயிற்சி செய்தல்.', 125, 135, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u6_l2_poem', 'tn10_tam_u6', 2, 'poem', 'சிலப்பதிகாரம்', 'இளங்கோவடிகள்', true, 126, 128, 136, 138, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l2_poem_item_1', 'tn10_tam_u6_l2_poem', 'source_activity', 'Poem Reading', 'புகார்க் காண்டச் செய்யுள் வாசிப்பு', 'மருவூர்ப்பாக்கத்தின் அங்காடிக் காட்சிகள், வணிகத் தெருக்களின் வளத்தைச் சித்தரிக்கும் பாடலை வாசித்தல்.', 126, 136, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l2_poem_item_2', 'tn10_tam_u6_l2_poem', 'source_activity', 'Memoriter', 'மனப்பாடப் பாடல் ஒப்புவித்தல்', 'தூசும் துகிரும் ஆரமும் அகிலும்... எனத் தொடங்கும் மருவூர்ப்பாக்க மனப்பாடப் பாடலை மனனம் செய்தல்.', 127, 137, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l2_poem_item_3', 'tn10_tam_u6_l2_poem', 'source_activity', 'Assessment', 'சிலப்பதிகார நயமும் வினா-விடைகளும்', 'பண்டைத் தமிழக வணிகச் சிறப்பு, கண்ணகியின் வீரம் குறித்த வினாக்களுக்கு விடையெழுதுதல்.', 128, 138, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u6_l3_poem', 'tn10_tam_u6', 3, 'poem', 'முத்தொள்ளாயிரம்', 'ஆசிரியர் பெயர் அறியப்படவில்லை', true, 129, 130, 139, 140, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l3_poem_item_1', 'tn10_tam_u6_l3_poem', 'source_activity', 'Poem Reading', 'மூவேந்தர் புகழ்பாடும் பாடல்கள் வாசிப்பு', 'சேர, சோழ, பாண்டிய மன்னர்களின் நாடு, யானைப்படை, போர்வீரத்தை வருணிக்கும் பாடல்களை வாசித்தல்.', 129, 139, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l3_poem_item_2', 'tn10_tam_u6_l3_poem', 'source_activity', 'Memoriter', 'மனப்பாடப் பாடல் பயிற்சி', 'அல்லல் பழனத்து அரக்காம்பல் வாய்அவிழ... பாடலை மனப்பாடம் செய்து பிழையின்றி எழுதுதல்.', 129, 139, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l3_poem_item_3', 'tn10_tam_u6_l3_poem', 'source_activity', 'Assessment', 'முத்தொள்ளாயிர வினா-விடைகள்', 'முத்தொள்ளாயிரத்தின் சந்த நயம் மற்றும் அரசர்களின் கொடைத்தன்மை வினாக்களுக்கு விடையெழுதுதல்.', 130, 140, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u6_l4_supplementary', 'tn10_tam_u6', 4, 'supplementary', 'மங்கையராய்ப் பிறப்பதற்கே...', 'தமிழ்நாடு பாடநூல் குழு (விரிவானம்)', false, 131, 134, 141, 144, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l4_supplementary_item_1', 'tn10_tam_u6_l4_supplementary', 'source_activity', 'Biography Reading', 'சாதனைப் பெண்கள் வாழ்க்கை வாசிப்பு', 'எம்.எஸ். சுப்புலட்சுமி, பாலசரஸ்வதி, கிருஷ்ணம்மாள் ஜெகந்நாதன், சின்னப்பிள்ளை முதலானோரின் சாதனைகளை வாசித்தல்.', 131, 141, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l4_supplementary_item_2', 'tn10_tam_u6_l4_supplementary', 'source_activity', 'Social Impact', 'பெண் விடுதலை & சமூகப் பங்களிப்பு', 'இசை, நாட்டியம், பூமிதான இயக்கம், மகளிர் சுயஉதவிக் குழுக்கள் வழியான சமூக மாற்றத்தை அறிதல்.', 133, 143, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l4_supplementary_item_3', 'tn10_tam_u6_l4_supplementary', 'source_activity', 'Essay Writing', 'விரிவான விடை & கட்டுரை', 'சாதனைப் பெண்களின் தன்னலமற்ற உழைப்பினை விளக்கித் தேர்வுக்கான கட்டுரை எழுதுதல்.', 134, 144, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u6_l5_theory', 'tn10_tam_u6', 5, 'theory', 'கற்கண்டு: புறப்பொருள் இலக்கணம்', 'தமிழ்நாடு பாடநூல் குழு (இலக்கணம்)', false, 135, 137, 145, 147, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l5_theory_item_1', 'tn10_tam_u6_l5_theory', 'source_activity', 'Grammar Rules', 'பன்னிரு புறத்திணைகள்', 'வெட்சி, கரந்தை, வஞ்சி, காஞ்சி, உழிஞை, நொச்சி, தும்பை, வாகை, பாடாண், பொதுவியல், கைக்கிளை, பெருந்திணை அறிதல்.', 135, 145, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l5_theory_item_2', 'tn10_tam_u6_l5_theory', 'source_activity', 'Classification', 'போர் நெறிகளும் திணை விளக்கங்களும்', 'நிரை கவர்தல் முதல் வெற்றி சூடுதல் வரையிலான புறப்பொருள் நெறிகளை எடுத்துக்காட்டுடன் கற்றல்.', 136, 146, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l5_theory_item_3', 'tn10_tam_u6_l5_theory', 'source_activity', 'Assessment', 'புறப்பொருள் வினா-விடைகள்', 'புறத்திணைகளை இனம் காணும் வினாக்களுக்குத் துல்லியமாக விடையெழுதுதல்.', 137, 147, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u6_l6_exercise', 'tn10_tam_u6', 6, 'exercise', 'திறன் அறிவோம் & மொழியை ஆள்வோம்', 'தமிழ்நாடு பாடநூல் குழு (பயிற்சிகள்)', false, 138, 143, 148, 153, 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l6_exercise_item_1', 'tn10_tam_u6_l6_exercise', 'source_activity', 'Objective Questions', 'பலவுள் தெரிக & மதிப்பீடு', 'இயல் 6 பலவுள் தெரிக ஒருமதிப்பெண் வினாக்களுக்குச் சரியான விடையைக் குறித்தல்.', 138, 148, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l6_exercise_item_2', 'tn10_tam_u6_l6_exercise', 'source_activity', 'Short Answers', 'குறுவினா & சிறுவினாப் பயிற்சி', 'மருவூர்ப்பாக்க வணிக வீதிகள், புறத்திணைகள் குறித்த வினாக்களுக்கு விடையெழுதுதல்.', 139, 149, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u6_l6_exercise_item_3', 'tn10_tam_u6_l6_exercise', 'source_activity', 'Creative Writing', 'மொழியை ஆள்வோம்: விளம்பரம் தயாரித்தல்', 'நிகழ்ச்சி நிரல் தயாரித்தல், விளம்பரம் உருவாக்குதல் மற்றும் கலைச்சொற்கள் அறிதல்.', 141, 151, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

-- Iyal 7: இயல் 7: பெருவழி
INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('tn10_tam_u7', 'tn10_tam_2025_edition', 7, 'இயல் 7: பெருவழி', 'அறம், தத்துவம், சிந்தனை: சங்க இலக்கிய அறம், தேம்பாவணி, அக்கறை, இராமானுசர் நாடகம் & பா வகை அலகிடுதல்', 7)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u7_l1_prose', 'tn10_tam_u7', 1, 'prose', 'சங்க இலக்கியத்தில் அறம்', 'முனைவர் ஆ. பூவண்ணன்', false, 144, 147, 154, 157, 1)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l1_prose_item_1', 'tn10_tam_u7_l1_prose', 'source_activity', 'Core Reading', 'உரைநடை வாசிப்பு: சங்க கால அறநெறி', 'அரசியல் அறம், போர் அறம், வணிக அறம் மற்றும் கொடை மடம் படாமை பண்புகளை வாசித்தல்.', 144, 154, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l1_prose_item_2', 'tn10_tam_u7_l1_prose', 'source_activity', 'Philosophical Values', 'இம்மை செய்தது மறுமைக்கு எனும் அறம்', 'பயன் கருதாது பிறருக்கு உதவும் சங்க காலத் தமிழரின் உயர்ந்த அறச் சிந்தனைகளைப் புரிந்துகொள்ளுதல்.', 146, 156, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l1_prose_item_3', 'tn10_tam_u7_l1_prose', 'source_activity', 'Assessment', 'உரைநடை வினா-விடைகள்', 'சங்க இலக்கியத்தில் அறம் பாடத்தின் அனைத்து வினாக்களுக்கும் விடையெழுதுதல்.', 147, 157, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u7_l2_poem', 'tn10_tam_u7', 2, 'poem', 'தேம்பாவணி', 'வீரமாமுனிவர்', true, 148, 151, 158, 161, 2)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l2_poem_item_1', 'tn10_tam_u7_l2_poem', 'source_activity', 'Poem Reading', 'செய்யுள் வாசிப்பு: வளன் துயரம்', 'தாய் இறந்து தனித்து நிற்கும் சூசையப்பரின் (வளன்) சோகத்தை வருணிக்கும் பாடலை வாசித்தல்.', 148, 158, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l2_poem_item_2', 'tn10_tam_u7_l2_poem', 'source_activity', 'Memoriter', 'மனப்பாடப் பாடல் ஒப்புவித்தல்', 'நவமணி வடக்கயில் போல்... எனத் தொடங்கும் மனப்பாடப் பாடலை மனனம் செய்து பிழையின்றி எழுதுதல்.', 149, 159, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l2_poem_item_3', 'tn10_tam_u7_l2_poem', 'source_activity', 'Assessment', 'தேம்பாவணி நயமும் வினா-விடைகளும்', 'இயற்கை கூட அழுது இரங்கிய உருக்கமான காட்சி வினாக்களுக்கு விடையெழுதுதல்.', 151, 161, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u7_l3_poem', 'tn10_tam_u7', 3, 'poem', 'அக்கறை', 'கல்யாண்ஜி', false, 152, 152, 162, 162, 3)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l3_poem_item_1', 'tn10_tam_u7_l3_poem', 'source_activity', 'Poem Reading', 'புதுக்கவிதை வாசிப்பு & சமுதாய அக்கறை', 'சைக்கிளில் தக்காளிப் பழங்கள் உருண்டோடிய காட்சியை விவரிக்கும் நவீனக் கவிதையை வாசித்தல்.', 152, 162, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l3_poem_item_2', 'tn10_tam_u7_l3_poem', 'source_activity', 'Appreciation', 'கவிதைக் குறியீடும் மனிதநேயமும்', 'பிறர் துன்பத்தில் பங்கெடுக்கும் அக்கறையற்ற மனித மனங்களைச் சாடும் கவிநயத்தை அறிதல்.', 152, 162, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u7_l4_supplementary', 'tn10_tam_u7', 4, 'supplementary', 'இராமானுசர் - நாடகம்', 'இந்திரா பார்த்தசாரதி', false, 153, 155, 163, 165, 4)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l4_supplementary_item_1', 'tn10_tam_u7_l4_supplementary', 'source_activity', 'Drama Reading', 'நாடக வாசிப்பு: திருக்கோட்டியூர் மாமுனி', 'ஓம் நமோ நாராயணாய மந்திரத்தை திருக்கோட்டியூர் கோபுரத்தின் மீதேறி உலகிற்கு அருளிய காட்சியை வாசித்தல்.', 153, 163, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l4_supplementary_item_2', 'tn10_tam_u7_l4_supplementary', 'source_activity', 'Character Analysis', 'சமத்துவப் புரட்சியும் மனிதநேயமும்', 'தான் நரகம் புகினும் உலக மக்கள் நற்கதி பெற வேண்டும் என்ற இராமானுசரின் தியாக நெறியைப் போற்றுதல்.', 154, 164, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l4_supplementary_item_3', 'tn10_tam_u7_l4_supplementary', 'source_activity', 'Essay Writing', 'விரிவான விடை & நாடகச் சுருக்கம்', 'இராமானுசர் நாடகத்தின் மையக்கருத்தையும் நாடக நுணுக்கங்களையும் விளக்கி எழுதுதல்.', 155, 165, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u7_l5_theory', 'tn10_tam_u7', 5, 'theory', 'கற்கண்டு: பா வகை, அலகிடுதல்', 'தமிழ்நாடு பாடநூல் குழு (இலக்கணம்)', false, 156, 157, 166, 167, 5)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l5_theory_item_1', 'tn10_tam_u7_l5_theory', 'source_activity', 'Poetic Metres', 'பா வகைகள் & ஓசைகள்', 'வெண்பா (செப்பலோசை), ஆசிரியப்பா (அகவலோசை), கலிப்பா (துள்ளலோசை), வஞ்சிப்பா (தூங்கலோசை) அறிதல்.', 156, 166, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l5_theory_item_2', 'tn10_tam_u7_l5_theory', 'source_activity', 'Scansion Practice', 'நேர், நிரை அசை பிரித்தலும் வாய்பாடும்', 'ஈரசைச்சீர், மூவசைச்சீர் மற்றும் ஈற்றுச்சீர் வாய்பாடுகளைக் கொண்டு திருக்குறளை அலகிட்டு வாய்பாடு கூறுதல்.', 156, 166, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l5_theory_item_3', 'tn10_tam_u7_l5_theory', 'source_activity', 'Assessment', 'அலகிடுதல் வினா-விடைகள் & பயிற்சி', 'தேர்வுக்கான செய்யுளடிகளை அலகிட்டு வாய்ப்பாடு எழுதும் பயிற்சிகளைச் செய்து முடித்தல்.', 157, 167, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u7_l6_exercise', 'tn10_tam_u7', 6, 'exercise', 'திறன் அறிவோம் & மொழியை ஆள்வோம்', 'தமிழ்நாடு பாடநூல் குழு (பயிற்சிகள்)', false, 158, 165, 168, 175, 6)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l6_exercise_item_1', 'tn10_tam_u7_l6_exercise', 'source_activity', 'Objective Questions', 'பலவுள் தெரிக & மதிப்பீடு', 'இயல் 7 பலவுள் தெரிக வினாக்களுக்குச் சரியான விடையைக் கண்டறிந்து குறித்தல்.', 158, 168, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l6_exercise_item_2', 'tn10_tam_u7_l6_exercise', 'source_activity', 'Short Answers', 'குறுவினா & சிறுவினாப் பயிற்சி', 'பா வகைகள், சங்க கால அறநெறி வினாக்களுக்கு விடையெழுதுதல்.', 159, 169, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l6_exercise_item_3', 'tn10_tam_u7_l6_exercise', 'source_activity', 'Language Skills', 'மொழியை ஆள்வோம்: தொடர் மாற்றம் & அகராதி', 'கலைச்சொல் அறிவோம், அகராதியில் பொருள் காண்க, நயம் பாராட்டல் பயிற்சிகள்.', 161, 171, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('tn10_tam_u7_l7_review', 'tn10_tam_u7', 7, 'review', 'வாழ்வியல்: திருக்குறள்', 'திருவள்ளுவர்', true, 166, 173, 176, 183, 7)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l7_review_item_1', 'tn10_tam_u7_l7_review', 'source_activity', 'Kural Study', 'பொருட்பால், காமத்துப்பால் குறள்கள் வாசிப்பு', 'பகைத்திறந்தெரிதல், குடிசெயல்வகை, நல்குரவு, இரவு, கயமை அதிகாரக் குறள்களைப் பொருள் விளங்கி வாசித்தல்.', 166, 176, 1, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l7_review_item_2', 'tn10_tam_u7_l7_review', 'source_activity', 'Memoriter', 'மனப்பாடக் குறள்கள் மனனம் & ஒப்புவித்தல்', 'இன்மையின் இன்னாதது யாதெனின்... முதலான நட்சத்திரக் குறியிட்ட மனப்பாடக் குறள்களை மனனம் செய்தல்.', 168, 178, 2, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('tn10_tam_u7_l7_review_item_3', 'tn10_tam_u7_l7_review', 'source_activity', 'Assessment', 'குறள் கருத்தும் வாழ்வியல் சிந்தனைகளும்', 'குடிமக்கள் கடமை, கயவர் குணம், வறுமையின் கொடுமை குறித்த சிந்தனை வினாக்களுக்கு விடையெழுதுதல்.', 171, 181, 3, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;

