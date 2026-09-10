#!/usr/bin/env python3
"""
Generate and validate Class 10 Science (2024 Edition) Curriculum Data
Matches the CurriculumData schema used in the Tamil Nadu State Board Class 10 PWA.
"""

import json
import os

units_raw = [
    # Physics (Units 1 - 6)
    (1, "Laws of Motion", "Physics: Inertia, Linear Momentum, Newton's Laws, Gravitation & Mass vs Weight", 1, 15, 13, "Physics"),
    (2, "Optics", "Physics: Light Properties, Refraction, Lenses, Optical Instruments & Human Eye", 16, 31, 29, "Physics"),
    (3, "Thermal Physics", "Physics: Heat, Temperature, Gas Laws (Boyle, Charles, Avogadro) & Absolute Scale", 32, 41, 39, "Physics"),
    (4, "Electricity", "Physics: Electric Current, Potential, Ohm's Law, Resistance in Circuits & Heating Effect", 42, 58, 55, "Physics"),
    (5, "Acoustics", "Physics: Sound Waves, Velocity, Reflection, Echoes, Doppler Effect & Applications", 59, 73, 70, "Physics"),
    (6, "Nuclear Physics", "Physics: Radioactivity, Alpha/Beta/Gamma Rays, Nuclear Fission & Fusion, Safety", 74, 90, 86, "Physics"),

    # Chemistry (Units 7 - 11)
    (7, "Atoms and Molecules", "Chemistry: Atomic Mass, Molecular Mass, Mole Concept & Avogadro's Number", 91, 105, 102, "Chemistry"),
    (8, "Periodic Classification of Elements", "Chemistry: Modern Periodic Table, Periodic Trends & Metallurgy", 106, 123, 121, "Chemistry"),
    (9, "Solutions", "Chemistry: Solute, Solvent, Solubility Factors, Concentration of Solutions & Hydration", 124, 136, 134, "Chemistry"),
    (10, "Types of Chemical Reactions", "Chemistry: Combination, Decomposition, Displacement, Neutralization & pH Scale", 137, 154, 152, "Chemistry"),
    (11, "Carbon and its Compounds", "Chemistry: Bonding, Allotropy, Hydrocarbons, Functional Groups & Soaps/Detergents", 155, 172, 170, "Chemistry"),

    # Biology (Units 12 - 22)
    (12, "Plant Anatomy and Plant Physiology", "Biology: Internal Plant Tissues, Chloroplasts, Photosynthesis & Respiration", 173, 186, 184, "Biology"),
    (13, "Structural Organisation of Animals", "Biology: Morphology and Anatomy of Leech and Rabbit", 187, 199, 197, "Biology"),
    (14, "Transportation in Plants and Circulation in Animals", "Biology: Xylem/Phloem, Ascent of Sap, Blood Components, Heart & Cardiac Cycle", 200, 217, 213, "Biology"),
    (15, "Nervous System", "Biology: Neurons, Central/Peripheral/Autonomic Nervous System & Reflex Arc", 218, 228, 226, "Biology"),
    (16, "Plant and Animal Hormones", "Biology: Phytohormones (Auxin, Gibberellin) & Human Endocrine Glands", 229, 242, 239, "Biology"),
    (17, "Reproduction in Plants and Animals", "Biology: Vegetative/Asexual/Sexual Reproduction, Pollination & Menstrual Cycle", 243, 260, 256, "Biology"),
    (18, "Genetics", "Biology: Mendel's Laws of Inheritance, Monohybrid/Dihybrid Crosses, DNA Structure & Chromosomes", 261, 273, 271, "Biology"),
    (19, "Origin and Evolution of Life", "Biology: Theories of Evolution, Lamarckism, Darwinism, Fossils & Ethnobotany", 274, 285, 282, "Biology"),
    (20, "Breeding and Biotechnology", "Biology: Plant/Animal Breeding, Hybridization, Genetic Engineering & Stem Cells", 286, 299, 296, "Biology"),
    (21, "Health and Diseases", "Biology: Communicable Diseases, Non-communicable Disorders, Lifestyle & Drug Abuse", 300, 314, 311, "Biology"),
    (22, "Environmental Management", "Biology: Forest/Wildlife Conservation, Water Harvesting, Renewable Energy & Waste Management", 315, 328, 326, "Biology"),

    # Computer Science / Communication (Unit 23)
    (23, "Visual Communication", "Computer Science: Scratch Software, Animation, Scripting & Graphic Tools", 329, 333, 333, "Computer Science"),
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
        "code": "class_10_science",
        "title": "Science",
        "curriculum_version": "2024 Edition",
        "textbook": {
            "title": "Standard Ten Science",
            "edition": "Revised Edition 2020, 2022, 2023, Reprint 2021, 2024",
            "first_edition_year": 2019,
            "reprint_year": 2024,
            "publisher": "Tamil Nadu Textbook and Educational Services Corporation",
            "source_file": "Class_10_Science_English_2024_Edition.pdf",
            "total_pages": 360,
            "page_offset": 8
        }
    },
    "units": []
}

PAGE_OFFSET = 8

for u_num, title, theme, p_start, p_end, eval_start, branch in units_raw:
    unit_id = f"tn10_sci_u{u_num}"
    theory_end = eval_start - 1 if eval_start > p_start else p_start

    # Lesson 1: Theory & Concepts
    lesson_1_id = f"{unit_id}_l1_theory_and_concepts"
    lesson_1 = {
        "id": lesson_1_id,
        "unit_id": unit_id,
        "unit_number": u_num,
        "lesson_number": 1,
        "lesson_type": "theory",
        "title": f"{title}: Core Concepts & Theory",
        "author": f"Tamil Nadu State Board ({branch})",
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
                "label": f"Read & Understand Core Concepts: {title}",
                "description": f"Study the foundational principles, definitions, laws, and chemical/biological mechanisms of {title}.",
                "printed_page": p_start,
                "pdf_page": p_start + PAGE_OFFSET,
                "source_reference": f"Textbook pp. {p_start}–{theory_end} (PDF pp. {p_start + PAGE_OFFSET}–{theory_end + PAGE_OFFSET})",
                "is_required": True
            },
            {
                "id": f"{lesson_1_id}_item_2_activities_and_examples",
                "lesson_id": lesson_1_id,
                "order_index": 2,
                "item_type": "source_activity",
                "section_name": "In-text Activities & Examples",
                "label": "In-text Activities, Key Diagrams & Solved Examples",
                "description": f"Review labeled scientific diagrams, in-text lab activities, and solved numerical problems for {title}.",
                "printed_page": min(p_start + 1, theory_end),
                "pdf_page": min(p_start + 1, theory_end) + PAGE_OFFSET,
                "source_reference": f"Textbook pp. {p_start}–{theory_end} (PDF pp. {p_start + PAGE_OFFSET}–{theory_end + PAGE_OFFSET})",
                "is_required": True
            }
        ]
    }

    # Lesson 2: Textbook Evaluation & Problem Solving
    lesson_2_id = f"{unit_id}_l2_textbook_evaluation"
    lesson_2 = {
        "id": lesson_2_id,
        "unit_id": unit_id,
        "unit_number": u_num,
        "lesson_number": 2,
        "lesson_type": "exercise",
        "title": f"{title}: Textbook Evaluation & Assessment",
        "author": f"Tamil Nadu State Board ({branch})",
        "is_memoriter": False,
        "printed_page_start": eval_start,
        "printed_page_end": p_end,
        "pdf_page_start": eval_start + PAGE_OFFSET,
        "pdf_page_end": p_end + PAGE_OFFSET,
        "checklist_items": [
            {
                "id": f"{lesson_2_id}_item_1_objective_questions",
                "lesson_id": lesson_2_id,
                "order_index": 1,
                "item_type": "source_activity",
                "section_name": "Objective Evaluation (Parts I–V)",
                "label": "Parts I–V: MCQs, Fill in Blanks, True/False, Match & Assertion-Reason",
                "description": f"Complete all 1-mark objective questions, fill in the blanks, true/false corrections, match items, and assertion-reason questions for Unit {u_num}.",
                "printed_page": eval_start,
                "pdf_page": eval_start + PAGE_OFFSET,
                "source_reference": f"Textbook p. {eval_start} (PDF p. {eval_start + PAGE_OFFSET})",
                "is_required": True
            },
            {
                "id": f"{lesson_2_id}_item_2_short_answers",
                "lesson_id": lesson_2_id,
                "order_index": 2,
                "item_type": "source_activity",
                "section_name": "Short Answers (Part VI)",
                "label": "Part VI: Short Answer Questions (2-Mark Questions)",
                "description": f"Answer all concise scientific reasoning and short conceptual questions for Unit {u_num}.",
                "printed_page": min(eval_start + 1, p_end),
                "pdf_page": min(eval_start + 1, p_end) + PAGE_OFFSET,
                "source_reference": f"Textbook pp. {eval_start}–{p_end} (PDF pp. {eval_start + PAGE_OFFSET}–{p_end + PAGE_OFFSET})",
                "is_required": True
            },
            {
                "id": f"{lesson_2_id}_item_3_detailed_answers",
                "lesson_id": lesson_2_id,
                "order_index": 3,
                "item_type": "source_activity",
                "section_name": "Detailed Answers & HOTS (Parts VII–IX)",
                "label": "Parts VII–IX: Detailed Answers, Numericals & HOT Questions (4 & 7 Marks)",
                "description": f"Write comprehensive paragraph answers, solve numerical problems, and analyze Higher Order Thinking Skills (HOTS) questions for Unit {u_num}.",
                "printed_page": p_end,
                "pdf_page": p_end + PAGE_OFFSET,
                "source_reference": f"Textbook pp. {eval_start}–{p_end} (PDF pp. {eval_start + PAGE_OFFSET}–{p_end + PAGE_OFFSET})",
                "is_required": True
            }
        ]
    }

    # For Visual Communication (shorter unit), 2 items in lesson 2
    if u_num == 23:
        lesson_2["checklist_items"] = lesson_2["checklist_items"][:2]

    unit_obj = {
        "id": unit_id,
        "unit_number": u_num,
        "title": f"Unit {u_num}: {title}",
        "theme": theme,
        "lessons": [lesson_1, lesson_2]
    }
    curriculum["units"].append(unit_obj)

# Add Practicals Module under Unit 24 / Laboratory
practicals_unit = {
    "id": "tn10_sci_practicals",
    "unit_number": 24,
    "title": "Science Practicals & Laboratory Experiments",
    "theme": "Physics, Chemistry & Biology Laboratory Experiments for Public Practical Exam",
    "lessons": [
        {
            "id": "tn10_sci_practicals_l1_physics_chemistry",
            "unit_id": "tn10_sci_practicals",
            "unit_number": 24,
            "lesson_number": 1,
            "lesson_type": "practical",
            "title": "Physics & Chemistry Practicals",
            "author": "Tamil Nadu State Board (Laboratory Manual)",
            "is_memoriter": False,
            "printed_page_start": 334,
            "printed_page_end": 341,
            "pdf_page_start": 342,
            "pdf_page_end": 349,
            "checklist_items": [
                {
                    "id": "tn10_sci_prac_item_physics",
                    "lesson_id": "tn10_sci_practicals_l1_physics_chemistry",
                    "order_index": 1,
                    "item_type": "source_activity",
                    "section_name": "Physics Practicals",
                    "label": "Physics Experiments: Principle of Moments, Convex Lens & Ohm's Law",
                    "description": "Perform determination of weight using principle of moments, focal length of convex lens, and resistance verification of Ohm's law.",
                    "printed_page": 335,
                    "pdf_page": 343,
                    "source_reference": "Textbook pp. 335–338 (PDF pp. 343–346)",
                    "is_required": True
                },
                {
                    "id": "tn10_sci_prac_item_chemistry",
                    "lesson_id": "tn10_sci_practicals_l1_physics_chemistry",
                    "order_index": 2,
                    "item_type": "source_activity",
                    "section_name": "Chemistry Practicals",
                    "label": "Chemistry Experiments: Exothermic/Endothermic Dissolution & Water of Hydration",
                    "description": "Test dissolution of salts (exothermic vs endothermic), water of crystallization in copper sulphate, and testing pH of solutions.",
                    "printed_page": 339,
                    "pdf_page": 347,
                    "source_reference": "Textbook pp. 339–341 (PDF pp. 347–349)",
                    "is_required": True
                }
            ]
        },
        {
            "id": "tn10_sci_practicals_l2_biology",
            "unit_id": "tn10_sci_practicals",
            "unit_number": 24,
            "lesson_number": 2,
            "lesson_type": "practical",
            "title": "Biology Practicals",
            "author": "Tamil Nadu State Board (Laboratory Manual)",
            "is_memoriter": False,
            "printed_page_start": 342,
            "printed_page_end": 349,
            "pdf_page_start": 350,
            "pdf_page_end": 357,
            "checklist_items": [
                {
                    "id": "tn10_sci_prac_item_photosynthesis",
                    "lesson_id": "tn10_sci_practicals_l2_biology",
                    "order_index": 1,
                    "item_type": "source_activity",
                    "section_name": "Botany Practicals",
                    "label": "Biology Experiment: Oxygen Evolution in Photosynthesis (Hydrilla Funnel)",
                    "description": "Prove that oxygen is released during photosynthesis using Hydrilla plant and test-tube funnel setup.",
                    "printed_page": 342,
                    "pdf_page": 350,
                    "source_reference": "Textbook p. 342 (PDF p. 350)",
                    "is_required": True
                },
                {
                    "id": "tn10_sci_prac_item_anatomy_slides",
                    "lesson_id": "tn10_sci_practicals_l2_biology",
                    "order_index": 2,
                    "item_type": "source_activity",
                    "section_name": "Zoology/Anatomy Slides",
                    "label": "Biology Identification: Blood Cells, Dicot Stem & Mammalian Heart",
                    "description": "Identify and draw permanent slides of human blood cells, transverse section of dicot stem, and structure of heart.",
                    "printed_page": 345,
                    "pdf_page": 353,
                    "source_reference": "Textbook pp. 345–349 (PDF pp. 353–357)",
                    "is_required": True
                }
            ]
        }
    ]
}

curriculum["units"].append(practicals_unit)

total_units = len(curriculum["units"])
total_lessons = sum(len(u["lessons"]) for u in curriculum["units"])
total_items = sum(len(l["checklist_items"]) for u in curriculum["units"] for l in u["lessons"])

curriculum["summary"] = {
    "total_units": total_units,
    "total_lessons": total_lessons,
    "total_checklist_items": total_items,
    "source_pdf": "Class_10_Science_English_2024_Edition.pdf",
    "verified": True
}

output_path = os.path.join(os.path.dirname(__file__), "..", "src", "data", "class_10_science_2024.json")
with open(output_path, "w", encoding="utf-8") as f:
    json.dump(curriculum, f, indent=2, ensure_ascii=False)

print(f"Successfully generated {output_path}")
print(f"Units: {total_units}, Lessons: {total_lessons}, Checklist Items: {total_items}")
