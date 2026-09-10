#!/usr/bin/env python3
"""
Generate and validate Class 10 Social Science (2025 Revised Edition) Curriculum Data
Matches the CurriculumData schema used in the Tamil Nadu State Board Class 10 PWA.
"""

import json
import os

PAGE_OFFSET = 6

units_raw = [
    # -------------------------------------------------------------------------
    # History (Units 1 - 10)
    # -------------------------------------------------------------------------
    (
        1, "History", "Unit 1: Outbreak of World War I and Its Aftermath",
        "History: European Imperialism, Balkan Crisis, World War I, Russian Revolution & League of Nations",
        1, 15, 14,
        "World Map: European belligerents (Britain, France, Germany, Italy, Austria-Hungary), Balkans & Gallipoli; Timeline (1914–1919)"
    ),
    (
        2, "History", "Unit 2: The World between two World Wars",
        "History: Great Depression, Rise of Fascism in Italy (Mussolini), Nazism in Germany (Hitler) & Anti-Colonial Struggle",
        16, 26, 25,
        "World Map: Axis & Allied spheres, Germany, Italy, Manchuria & Ethiopia; Timeline (1919–1939)"
    ),
    (
        3, "History", "Unit 3: World War II",
        "History: Outbreak of WWII, Blitzkrieg, Battle of Stalingrad, Holocaust, Pearl Harbor, Hiroshima-Nagasaki & UNO",
        27, 39, 37,
        "World Map: Major Pacific & European battlefronts, Normandy, Pearl Harbor, Hiroshima, Nagasaki; Timeline (1939–1945)"
    ),
    (
        4, "History", "Unit 4: The World after World War II",
        "History: Cold War, NATO vs Warsaw Pact, Non-Aligned Movement (NAM), Decolonization in Asia/Africa & European Union",
        40, 52, 50,
        "World Map: Cold War blocs, NATO members, Warsaw pact, Non-Aligned nations"
    ),
    (
        5, "History", "Unit 5: Social and Religious Reform Movements in the 19th Century",
        "History: Brahmo Samaj, Arya Samaj, Ramakrishna Mission, Theosophical Society, Jyotiba Phule, Narayana Guru & Tamil Reformers",
        53, 62, 61,
        "India Map: Centers of socio-religious reforms (Calcutta, Bombay, Madras, Poona, Varanasi, Aligarh)"
    ),
    (
        6, "History", "Unit 6: Early Revolts against British Rule in Tamil Nadu",
        "History: Palayakkarar Rebellion, Puli Thevar, Veerapandiya Kattabomman, Velu Nachiyar, Marudu Brothers & Vellore Revolt of 1806",
        63, 74, 73,
        "Tamil Nadu Map: Palayam centers (Panchalankurichi, Nerkattumseval, Kalakadu, Sivagangai, Vellore Fort)"
    ),
    (
        7, "History", "Unit 7: Anti-Colonial Movements and the Birth of Nationalism",
        "History: 1857 Great Rebellion, Peasant & Tribal Uprisings (Santhal, Munda), Foundation of INC, Moderates vs Extremists & Partition of Bengal",
        75, 88, 86,
        "India Map: 1857 revolt centers (Delhi, Meerut, Kanpur, Lucknow, Jhansi, Bareilly, Gwalior)"
    ),
    (
        8, "History", "Unit 8: Nationalism: Gandhian Phase",
        "History: Rowlatt Act, Jallianwala Bagh, Non-Cooperation, Swarajists, Civil Disobedience, Salt Satyagraha (Dandi & Vedaranyam) & Quit India",
        89, 104, 102,
        "India Map & Timeline: Dandi, Vedaranyam, Champaran, Kheda, Chauri Chaura, Sabarmati, Wardha; Timeline (1920–1947)"
    ),
    (
        9, "History", "Unit 9: Freedom Struggle in Tamil Nadu",
        "History: Swadeshi Movement, V.O. Chidambaranar, Subramania Bharati, Non-Brahmin Movement, Justice Party, Rajaji & Kamaraj",
        105, 114, 113,
        "Tamil Nadu Map: Swadeshi Steam Navigation (Tuticorin, Colombo), Vedaranyam Salt March, Tirupur Kumaran memorial"
    ),
    (
        10, "History", "Unit 10: Social Transformation in Tamil Nadu",
        "History: Dravidian Movement, South Indian Liberal Federation (Justice Party), Periyar E.V. Ramasamy, Self-Respect Movement & Women Emancipation",
        115, 127, 125,
        "Modern Indian History Comprehensive Timeline (1900–1950) & Historical Reform Centers"
    ),

    # -------------------------------------------------------------------------
    # Geography (Units 11 - 17)
    # -------------------------------------------------------------------------
    (
        11, "Geography", "Unit 11: India - Location, Relief and Drainage",
        "Geography: Strategic Location of India, Himalayan Ranges, Northern Plains, Peninsular Plateau, Coastal Plains & River Systems",
        129, 143, 142,
        "India Map: Mountain ranges (Himalayas, Western/Eastern Ghats, Aravalli), Peaks (K2, Kanchenjunga), Major Rivers (Ganga, Brahmaputra, Godavari, Kaveri)"
    ),
    (
        12, "Geography", "Unit 12: Climate and Natural Vegetation of India",
        "Geography: Factors Affecting Climate, Southwest & Northeast Monsoons, Rainfall Distribution, Tropical Rainforests & Wildlife Sanctuaries",
        144, 153, 152,
        "India Map: Southwest monsoon wind direction, High and low rainfall zones, Forest types & Biosphere reserves (Nilgiri, Gulf of Mannar, Sundarbans)"
    ),
    (
        13, "Geography", "Unit 13: India - Agriculture",
        "Geography: Soil Types (Alluvial, Black, Red, Laterite), Irrigation Schemes, Multipurpose River Valley Projects, Food Crops & Commercial Agriculture",
        154, 169, 167,
        "India Map: Major crop regions (Rice, Wheat, Cotton, Sugarcane, Tea, Coffee) & Multipurpose dams (Bhakra Nangal, Hirakud, Mettur)"
    ),
    (
        14, "Geography", "Unit 14: India - Resources and Industries",
        "Geography: Metallic Minerals (Iron ore, Bauxite), Energy Resources (Coal, Petroleum, Nuclear, Solar), Cotton Textiles, Iron & Steel Plants",
        170, 185, 183,
        "India Map: Major mineral belts, Coal fields (Jharia, Raniganj), Oil fields (Mumbai High, Digboi) & Steel plants (Jamshedpur, Bhilai, Salem)"
    ),
    (
        15, "Geography", "Unit 15: India - Population, Transport, Communication and Trade",
        "Geography: Population Density, Urbanization, Golden Quadrilateral, Railway Zones, Major Seaports, International Airports & Trade Balance",
        186, 199, 197,
        "India Map: Golden quadrilateral highway, Major sea ports (Chennai, Mumbai, Kolkata, Kochi, Tuticorin) & International airports"
    ),
    (
        16, "Geography", "Unit 16: Physical Geography of Tamil Nadu",
        "Geography: Location & Boundaries of Tamil Nadu, Western/Eastern Ghats, Plateaus, Coastal Plains, Rivers (Palar, Cauvery, Vaigai) & Climate",
        200, 218, 216,
        "Tamil Nadu Map: Doddabetta, Anaimudi, Palani hills, River Cauvery, Vaigai, Coromandel coast, Pichavaram mangrove & Gulf of Mannar"
    ),
    (
        17, "Geography", "Unit 17: Human Geography of Tamil Nadu",
        "Geography: Agriculture in TN, Cropping Seasons, Water Resources, Livestock, Fisheries, Industrial Growth, Transport Infrastructure & Disaster Risk",
        219, 237, 235,
        "Tamil Nadu Map: Agro-climatic zones, Major crop areas, Textile clusters (Coimbatore, Tirupur), Ports (Ennore, Chennai, Tuticorin) & NH network"
    ),

    # -------------------------------------------------------------------------
    # Civics (Units 18 - 22)
    # -------------------------------------------------------------------------
    (
        18, "Civics", "Unit 18: Indian Constitution",
        "Civics: Framing of Constitution, Preamble, Salient Features, Fundamental Rights (Articles 12–35), Directive Principles & Emergency Provisions",
        239, 247, 246,
        None
    ),
    (
        19, "Civics", "Unit 19: Central Government",
        "Civics: President of India, Vice-President, Prime Minister, Council of Ministers, Parliament (Lok Sabha & Rajya Sabha) & Supreme Court",
        248, 258, 256,
        None
    ),
    (
        20, "Civics", "Unit 20: State Government",
        "Civics: Governor of Tamil Nadu, Chief Minister, State Council of Ministers, State Legislature (Vidhan Sabha) & High Court Jurisdiction",
        259, 268, 266,
        None
    ),
    (
        21, "Civics", "Unit 21: India’s Foreign Policy",
        "Civics: Panchsheel Principles, Non-Alignment Policy, Disarmament, Anti-Apartheid, SAARC, Act East Policy & Nuclear Doctrine",
        269, 277, 276,
        None
    ),
    (
        22, "Civics", "Unit 22: India’s International Relations",
        "Civics: Relations with Immediate Neighbors (Pakistan, China, Bangladesh, Sri Lanka, Nepal), BRICS, G20, Look East & Global Partnerships",
        278, 290, 288,
        None
    ),

    # -------------------------------------------------------------------------
    # Economics (Units 23 - 27)
    # -------------------------------------------------------------------------
    (
        23, "Economics", "Unit 23: Gross Domestic Product and its Growth: an Introduction",
        "Economics: Concept of GDP, NDP, GNP, NNP, Primary/Secondary/Tertiary Sectors, Human Development Index (HDI) & Economic Development",
        292, 302, 300,
        None
    ),
    (
        24, "Economics", "Unit 24: Globalization and Trade",
        "Economics: Historical Background of Trade, Silk Route, Multi-National Corporations (MNCs), GATT, WTO & Impact of Globalization in India",
        303, 310, 309,
        None
    ),
    (
        25, "Economics", "Unit 25: Food Security and Nutrition",
        "Economics: Availability, Access & Absorption of Food, Public Distribution System (PDS), Buffer Stock, Green Revolution & Nutrition Schemes in TN",
        311, 320, 318,
        None
    ),
    (
        26, "Economics", "Unit 26: Government and Taxes",
        "Economics: Direct Taxes (Income Tax, Corporate Tax), Indirect Taxes (GST, Customs, Excise), Black Money, Tax Evasion & Public Expenditure",
        321, 327, 326,
        None
    ),
    (
        27, "Economics", "Unit 27: Industrial Clusters in Tamil Nadu",
        "Economics: Determinants of Industrial Clusters, Textile Hub (Tirupur, Coimbatore), Leather Hub (Vellore, Ambur), Fireworks (Sivakasi), Auto Hub (Chennai) & SIPCOT/TIDCO",
        328, 337, 336,
        None
    ),
]

curriculum = {
    "board": {
        "code": "tn_state_board",
        "name": "Tamil Nadu State Board of School Education",
        "state": "Tamil Nadu"
    },
    "class": {
        "grade_number": 10,
        "title": "Standard 10",
        "code": "class_10"
    },
    "medium": {
        "code": "english",
        "name": "English Medium"
    },
    "subject": {
        "code": "class_10_social_science",
        "title": "Social Science",
        "curriculum_version": "2025 Edition",
        "textbook": {
            "title": "Standard Ten Social Science",
            "edition": "Revised Edition 2020, 2022, 2023, 2025, Reprint 2021, 2024",
            "first_edition_year": 2019,
            "reprint_year": 2025,
            "publisher": "Tamil Nadu Textbook and Educational Services Corporation",
            "source_file": "Class_10_Social_Science_English_2025_Edition.pdf",
            "total_pages": 344,
            "page_offset": PAGE_OFFSET
        }
    },
    "units": []
}

total_lessons = 0
total_items = 0

for u_num, discipline, title, theme, p_start, p_end, eval_start, map_work_desc in units_raw:
    unit_id = f"tn10_soc_u{u_num}"
    theory_end = eval_start - 1 if eval_start > p_start else p_start

    # Clean display title
    clean_title = title.split(": ", 1)[1] if ": " in title else title

    # Lesson 1: Core Concepts & Historical/Geographical Theory
    lesson_1_id = f"{unit_id}_l1_theory_and_concepts"
    lesson_1 = {
        "id": lesson_1_id,
        "unit_id": unit_id,
        "unit_number": u_num,
        "lesson_number": 1,
        "lesson_type": "theory",
        "title": f"{clean_title}: Core Concepts & Theory",
        "author": f"Tamil Nadu State Board ({discipline})",
        "is_memoriter": False,
        "printed_page_start": p_start,
        "printed_page_end": theory_end,
        "pdf_page_start": p_start + PAGE_OFFSET,
        "pdf_page_end": theory_end + PAGE_OFFSET,
        "checklist_items": [
            {
                "id": f"{lesson_1_id}_item_1_concept_reading",
                "lesson_id": lesson_1_id,
                "order_index": 1,
                "item_type": "source_activity",
                "section_name": "Core Concepts",
                "label": f"Read & Understand Core Concepts: {clean_title}",
                "description": f"Read foundational principles, key events, definitions, constitutional articles, and core mechanisms of {clean_title}.",
                "printed_page": p_start,
                "pdf_page": p_start + PAGE_OFFSET,
                "source_reference": f"Standard Ten Social Science ({discipline}), pp. {p_start}–{theory_end}",
                "is_required": True
            },
            {
                "id": f"{lesson_1_id}_item_2_activities_and_case_studies",
                "lesson_id": lesson_1_id,
                "order_index": 2,
                "item_type": "source_activity",
                "section_name": "In-text Figures & Case Studies",
                "label": "In-text Activities, Tables, Infographics & Case Studies",
                "description": f"Review illustrated diagrams, statistical charts, comparative tables, and in-text case studies for {clean_title}.",
                "printed_page": p_start + 1 if p_start + 1 <= theory_end else p_start,
                "pdf_page": (p_start + 1 if p_start + 1 <= theory_end else p_start) + PAGE_OFFSET,
                "source_reference": f"Standard Ten Social Science ({discipline}), In-text features",
                "is_required": True
            }
        ]
    }
    total_lessons += 1
    total_items += len(lesson_1["checklist_items"])

    # Lesson 2: Textbook Evaluation & Assessment
    lesson_2_id = f"{unit_id}_l2_textbook_evaluation"
    checklist_eval = [
        {
            "id": f"{lesson_2_id}_item_1_objective_questions",
            "lesson_id": lesson_2_id,
            "order_index": 1,
            "item_type": "source_activity",
            "section_name": "Objective Evaluation (Part I)",
            "label": "Part I: MCQs, Fill in Blanks, True/False & Match Items",
            "description": f"Complete all 1-mark multiple choice questions, fill in the blanks, matching pairs, and assertion-reason questions for Unit {u_num}.",
            "printed_page": eval_start,
            "pdf_page": eval_start + PAGE_OFFSET,
            "source_reference": f"Standard Ten Social Science, Unit {u_num} Evaluation, Part I",
            "is_required": True
        },
        {
            "id": f"{lesson_2_id}_item_2_short_answers",
            "lesson_id": lesson_2_id,
            "order_index": 2,
            "item_type": "source_activity",
            "section_name": "Short Answers & Distinctions (Part II)",
            "label": "Part II: Short Answer Questions & Distinguish Between (2 Marks)",
            "description": f"Answer all concise 2-mark conceptual questions, distinguish between pairs, and give reasons for Unit {u_num}.",
            "printed_page": min(eval_start + 1, p_end),
            "pdf_page": min(eval_start + 1, p_end) + PAGE_OFFSET,
            "source_reference": f"Standard Ten Social Science, Unit {u_num} Evaluation, Part II",
            "is_required": True
        },
        {
            "id": f"{lesson_2_id}_item_3_detailed_answers",
            "lesson_id": lesson_2_id,
            "order_index": 3,
            "item_type": "source_activity",
            "section_name": "Detailed Answers & Essays (Part III)",
            "label": "Part III: Detailed Answers, Essays & HOTS (5 & 8 Marks)",
            "description": f"Write comprehensive paragraph/essay answers, historical event analyses, and Higher Order Thinking Questions for Unit {u_num}.",
            "printed_page": p_end,
            "pdf_page": p_end + PAGE_OFFSET,
            "source_reference": f"Standard Ten Social Science, Unit {u_num} Evaluation, Part III",
            "is_required": True
        }
    ]

    # Map Work / Timeline item if applicable
    if map_work_desc:
        checklist_eval.append({
            "id": f"{lesson_2_id}_item_4_map_and_timeline",
            "lesson_id": lesson_2_id,
            "order_index": 4,
            "item_type": "source_activity",
            "section_name": "Board Exam Map & Timeline Skills",
            "label": f"Board Exam Map Work & Timeline Skills: {clean_title}",
            "description": f"Practice marking key exam locations on outline maps: {map_work_desc}.",
            "printed_page": p_end,
            "pdf_page": p_end + PAGE_OFFSET,
            "source_reference": f"Standard Ten Social Science, Unit {u_num} Map / Timeline Exercise",
            "is_required": True
        })

    lesson_2 = {
        "id": lesson_2_id,
        "unit_id": unit_id,
        "unit_number": u_num,
        "lesson_number": 2,
        "lesson_type": "exercise",
        "title": f"{clean_title}: Textbook Evaluation & Assessment",
        "author": f"Tamil Nadu State Board ({discipline})",
        "is_memoriter": False,
        "printed_page_start": eval_start,
        "printed_page_end": p_end,
        "pdf_page_start": eval_start + PAGE_OFFSET,
        "pdf_page_end": p_end + PAGE_OFFSET,
        "checklist_items": checklist_eval
    }
    total_lessons += 1
    total_items += len(checklist_eval)

    curriculum["units"].append({
        "id": unit_id,
        "unit_number": u_num,
        "title": title,
        "theme": theme,
        "lessons": [lesson_1, lesson_2]
    })

curriculum["summary"] = {
    "total_units": len(curriculum["units"]),
    "total_lessons": total_lessons,
    "total_checklist_items": total_items
}

workspace_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
out_path = os.path.join(workspace_dir, "src", "data", "class_10_social_science_2025.json")

with open(out_path, "w", encoding="utf-8") as f:
    json.dump(curriculum, f, indent=2, ensure_ascii=False)

print(f"✓ Generated {out_path}")
print(f"✓ Total Units: {len(curriculum['units'])}")
print(f"✓ Total Lessons: {total_lessons}")
print(f"✓ Total Checklist Items: {total_items}")
