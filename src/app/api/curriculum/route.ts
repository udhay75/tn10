import { NextRequest, NextResponse } from 'next/server';
import { queryPostgres } from '@/lib/db/postgres';
import englishCurriculum from '@/data/class_10_english_2024.json';
import mathCurriculum from '@/data/class_10_math_2025.json';
import scienceCurriculum from '@/data/class_10_science_2024.json';
import socialScienceCurriculum from '@/data/class_10_social_science_2025.json';
import tamilCurriculum from '@/data/class_10_tamil_2025.json';

export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const subject = searchParams.get('subject') || 'class_10_tamil';

  let fallbackCurriculum: any = tamilCurriculum;
  let targetEdition = 'tn10_tam_2025_edition';

  if (subject === 'class_10_social_science') {
    fallbackCurriculum = socialScienceCurriculum;
    targetEdition = 'tn10_soc_2025_edition';
  } else if (subject === 'class_10_science') {
    fallbackCurriculum = scienceCurriculum;
    targetEdition = 'tn10_sci_2024_edition';
  } else if (subject === 'class_10_math') {
    fallbackCurriculum = mathCurriculum;
    targetEdition = 'tn10_math_2025_edition';
  } else if (subject === 'class_10_english') {
    fallbackCurriculum = englishCurriculum;
    targetEdition = 'tn10_eng_2024_edition';
  }

  try {
    const unitsRes = await queryPostgres(`
      SELECT code, unit_number, title, theme, order_index
      FROM units
      WHERE edition_code = $1
      ORDER BY order_index ASC
    `, [targetEdition]);

    const lessonsRes = await queryPostgres(`
      SELECT l.code, l.unit_code, l.lesson_number, l.lesson_type, l.title, l.author, l.is_memoriter,
             l.printed_page_start, l.printed_page_end, l.pdf_page_start, l.pdf_page_end, l.order_index
      FROM lessons l
      JOIN units u ON u.code = l.unit_code
      WHERE u.edition_code = $1
      ORDER BY u.order_index ASC, l.order_index ASC
    `, [targetEdition]);

    const itemsRes = await queryPostgres(`
      SELECT ci.code, ci.lesson_code, ci.item_type, ci.section_name, ci.label, ci.description,
             ci.printed_page, ci.pdf_page, ci.order_index, ci.is_required
      FROM checklist_items ci
      JOIN lessons l ON l.code = ci.lesson_code
      JOIN units u ON u.code = l.unit_code
      WHERE u.edition_code = $1
      ORDER BY l.order_index ASC, ci.order_index ASC
    `, [targetEdition]);

    if (unitsRes.rows.length === 0) {
      return NextResponse.json(fallbackCurriculum);
    }

    // Group items by lesson
    const itemsByLesson: Record<string, any[]> = {};
    itemsRes.rows.forEach((it) => {
      if (!itemsByLesson[it.lesson_code]) itemsByLesson[it.lesson_code] = [];
      itemsByLesson[it.lesson_code].push({
        id: it.code,
        lesson_id: it.lesson_code,
        order_index: it.order_index,
        item_type: it.item_type,
        section_name: it.section_name,
        label: it.label,
        description: it.description,
        printed_page: it.printed_page,
        pdf_page: it.pdf_page,
        source_reference: `Textbook p. ${it.printed_page} (PDF p. ${it.pdf_page})`,
        is_required: it.is_required,
      });
    });

    const lessonsByUnit: Record<string, any[]> = {};
    lessonsRes.rows.forEach((l) => {
      if (!lessonsByUnit[l.unit_code]) lessonsByUnit[l.unit_code] = [];
      lessonsByUnit[l.unit_code].push({
        id: l.code,
        unit_id: l.unit_code,
        lesson_number: l.lesson_number,
        lesson_type: l.lesson_type,
        title: l.title,
        author: l.author,
        is_memoriter: l.is_memoriter,
        printed_page_start: l.printed_page_start,
        printed_page_end: l.printed_page_end,
        pdf_page_start: l.pdf_page_start,
        pdf_page_end: l.pdf_page_end,
        checklist_items: itemsByLesson[l.code] || [],
      });
    });

    const units = unitsRes.rows.map((u) => ({
      id: u.code,
      unit_number: u.unit_number,
      title: u.title,
      theme: u.theme,
      lessons: lessonsByUnit[u.code] || [],
    }));

    return NextResponse.json({
      ...fallbackCurriculum,
      units,
      summary: {
        ...fallbackCurriculum.summary,
        total_units: units.length,
        total_lessons: lessonsRes.rows.length,
        total_checklist_items: itemsRes.rows.length,
      },
      source: 'Docker PostgreSQL Database (tn10_study)',
    });
  } catch (err: any) {
    console.warn(`Fallback to local JSON curriculum (${subject}):`, err.message);
    return NextResponse.json(fallbackCurriculum);
  }
}
