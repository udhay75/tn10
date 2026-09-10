#!/usr/bin/env python3
"""
Generates idempotent SQL seed for Supabase PostgreSQL database
from src/data/class_10_english_2024.json.
"""

import os
import json

workspace_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
json_path = os.path.join(workspace_dir, 'src', 'data', 'class_10_english_2024.json')
sql_path = os.path.join(workspace_dir, 'supabase', 'migrations', '003_seed_english_2024.sql')

with open(json_path, 'r', encoding='utf-8') as f:
    data = json.load(f)

lines = []
lines.append("-- ==========================================================================")
lines.append("-- 003_seed_english_2024.sql: Tamil Nadu State Board Class 10 English Seed")
lines.append("-- Idempotent seed script: safe to run multiple times without duplicates.")
lines.append("-- ==========================================================================\n")

# 1. Board
b = data["board"]
lines.append(f"""INSERT INTO boards (code, name, state)
VALUES ('{b["code"]}', '{b["name"]}', '{b["state"]}')
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, state = EXCLUDED.state;
""")

# 2. Class
c = data["class"]
lines.append(f"""INSERT INTO classes (code, grade_number, title, board_code)
VALUES ('{c["code"]}', {c["grade_number"]}, '{c["title"]}', '{b["code"]}')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;
""")

# 3. Medium
m = data["medium"]
lines.append(f"""INSERT INTO mediums (code, name)
VALUES ('{m["code"]}', '{m["name"]}')
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name;
""")

# Also add Tamil medium for future extensibility
lines.append("""INSERT INTO mediums (code, name)
VALUES ('tamil', 'Tamil Medium')
ON CONFLICT (code) DO NOTHING;
""")

# 4. Subject
s = data["subject"]
lines.append(f"""INSERT INTO subjects (code, title, class_code, medium_code)
VALUES ('{s["code"]}', '{s["title"]}', '{c["code"]}', '{m["code"]}')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;
""")

# 5. Textbook Edition
tb = s["textbook"]
edition_code = "tn10_eng_2024_edition"
lines.append(f"""INSERT INTO textbook_editions (code, subject_code, edition_year, title, source_filename, is_published)
VALUES ('{edition_code}', '{s["code"]}', {tb["reprint_year"]}, '{tb["title"]} ({tb["edition"]})', '{tb["source_file"]}', true)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, is_published = EXCLUDED.is_published;
""")

# 6. Units, Lessons, and Checklist Items
for u in data["units"]:
    u_id = u["id"]
    u_num = u["unit_number"]
    u_title = u["title"].replace("'", "''")
    u_theme = u["theme"].replace("'", "''")
    lines.append(f"""INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ('{u_id}', '{edition_code}', {u_num}, '{u_title}', '{u_theme}', {u_num})
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;
""")

    for l in u["lessons"]:
        l_id = l["id"]
        l_num = l["lesson_number"]
        l_type = l["lesson_type"]
        l_title = l["title"].replace("'", "''")
        l_author = l["author"].replace("'", "''")
        is_mem = 'true' if l["is_memoriter"] else 'false'
        p_start = l["printed_page_start"]
        p_end = l["printed_page_end"]
        pdf_start = l["pdf_page_start"]
        pdf_end = l["pdf_page_end"]

        lines.append(f"""INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ('{l_id}', '{u_id}', {l_num}, '{l_type}', '{l_title}', '{l_author}', {is_mem}, {p_start}, {p_end}, {pdf_start}, {pdf_end}, {l_num})
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end;
""")

        for it in l["checklist_items"]:
            it_id = it["id"]
            it_ord = it["order_index"]
            it_type = it["item_type"]
            it_sec = it["section_name"].replace("'", "''")
            it_lbl = it["label"].replace("'", "''")
            it_desc = it["description"].replace("'", "''")
            it_p = it["printed_page"]
            it_pdf = it["pdf_page"]

            lines.append(f"""INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ('{it_id}', '{l_id}', '{it_type}', '{it_sec}', '{it_lbl}', '{it_desc}', {it_p}, {it_pdf}, {it_ord}, true)
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;
""")

with open(sql_path, 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))

print(f"Generated idempotent SQL seed at {sql_path} ({len(lines)} lines).")
