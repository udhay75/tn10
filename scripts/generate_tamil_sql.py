#!/usr/bin/env python3
"""
Generate supabase/migrations/007_seed_tamil_2025.sql from src/data/class_10_tamil_2025.json
"""

import json
import os

def escape_sql(text):
    if text is None:
        return 'NULL'
    return "'" + str(text).replace("'", "''") + "'"

with open('src/data/class_10_tamil_2025.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

sql_lines = []
sql_lines.append("-- ==========================================================================")
sql_lines.append("-- 007_seed_tamil_2025.sql: Tamil Nadu State Board Class 10 Tamil Seed")
sql_lines.append("-- Idempotent seed script: safe to run multiple times without duplicates.")
sql_lines.append("-- ==========================================================================")
sql_lines.append("")

# 1. Tamil Subject
sql_lines.append("-- 1. Tamil Subject")
sql_lines.append(f"""INSERT INTO subjects (code, title, class_code, medium_code)
VALUES ('class_10_tamil', 'Tamil (தமிழ்)', 'class_10', 'tamil')
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title;""")
sql_lines.append("")

# 2. Textbook Edition
sql_lines.append("-- 2. Textbook Edition")
sql_lines.append(f"""INSERT INTO textbook_editions (code, subject_code, edition_year, title, source_filename, is_published)
VALUES ('tn10_tam_2025_edition', 'class_10_tamil', 2025, {escape_sql(data['subject']['textbook']['title'] + ' (' + data['subject']['textbook']['edition'] + ')')}, 'Class_10_Tamil_2025_Edition.pdf', true)
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, is_published = EXCLUDED.is_published;""")
sql_lines.append("")

# 3. Units, Lessons, and Checklist Items
sql_lines.append("-- 3. Units, Lessons, and Checklist Items")
for u_idx, unit in enumerate(data['units'], 1):
    sql_lines.append(f"-- Iyal {unit['unit_number']}: {unit['title']}")
    sql_lines.append(f"""INSERT INTO units (code, edition_code, unit_number, title, theme, order_index)
VALUES ({escape_sql(unit['id'])}, 'tn10_tam_2025_edition', {unit['unit_number']}, {escape_sql(unit['title'])}, {escape_sql(unit['theme'])}, {u_idx})
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, theme = EXCLUDED.theme;""")
    sql_lines.append("")

    for l_idx, lesson in enumerate(unit['lessons'], 1):
        sql_lines.append(f"""INSERT INTO lessons (code, unit_code, lesson_number, lesson_type, title, author, is_memoriter, printed_page_start, printed_page_end, pdf_page_start, pdf_page_end, order_index)
VALUES ({escape_sql(lesson['id'])}, {escape_sql(unit['id'])}, {lesson['lesson_number']}, {escape_sql(lesson['lesson_type'])}, {escape_sql(lesson['title'])}, {escape_sql(lesson['author'])}, {'true' if lesson['is_memoriter'] else 'false'}, {lesson['printed_page_start']}, {lesson['printed_page_end']}, {lesson['pdf_page_start']}, {lesson['pdf_page_end']}, {l_idx})
ON CONFLICT (code) DO UPDATE SET title = EXCLUDED.title, author = EXCLUDED.author, is_memoriter = EXCLUDED.is_memoriter, printed_page_start = EXCLUDED.printed_page_start, printed_page_end = EXCLUDED.printed_page_end, pdf_page_start = EXCLUDED.pdf_page_start, pdf_page_end = EXCLUDED.pdf_page_end;""")

        for it_idx, item in enumerate(lesson['checklist_items'], 1):
            sql_lines.append(f"""INSERT INTO checklist_items (code, lesson_code, item_type, section_name, label, description, printed_page, pdf_page, order_index, is_required)
VALUES ({escape_sql(item['id'])}, {escape_sql(lesson['id'])}, {escape_sql(item['item_type'])}, {escape_sql(item['section_name'])}, {escape_sql(item['label'])}, {escape_sql(item['description'])}, {item['printed_page']}, {item['pdf_page']}, {item['order_index']}, {'true' if item['is_required'] else 'false'})
ON CONFLICT (code) DO UPDATE SET label = EXCLUDED.label, description = EXCLUDED.description, printed_page = EXCLUDED.printed_page, pdf_page = EXCLUDED.pdf_page;""")
        sql_lines.append("")

output_sql = 'supabase/migrations/007_seed_tamil_2025.sql'
with open(output_sql, 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql_lines) + '\n')

print(f"Successfully created {output_sql} with {len(sql_lines)} lines")
