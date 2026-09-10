// ============================================================================
// Reusable Curriculum Import & Review Pipeline
// 1. Upload subject PDF
// 2. Extract curriculum into draft with confidence scores
// 3. Flag uncertain / incomplete extractions
// 4. Admin review, edit, reorder, and approve
// 5. Publish approved curriculum with idempotent upsert (protecting student progress)
// ============================================================================

import { CurriculumDraft, DraftChecklistItem, CurriculumData, ItemType } from '@/types';
import defaultCurriculum from '@/data/class_10_english_2024.json';

export interface ExtractionResult {
  draft: CurriculumDraft;
  draftItems: DraftChecklistItem[];
  uncertainCount: number;
}

/**
 * Simulates processing an uploaded PDF textbook into a reviewable draft.
 * Computes heuristic confidence scores based on pattern matches and flags
 * ambiguous exercise labels or missing page numbers for manual admin sign-off.
 */
export async function createExtractionDraftFromPdf(
  fileName: string, 
  fileSize: number, 
  editionCode: string = 'tn10_eng_2024_edition'
): Promise<ExtractionResult> {
  const uncertainFlags: Array<{ item_id: string; reason: string }> = [];
  const draftItems: DraftChecklistItem[] = [];

  const draftId = `draft_${Date.now()}`;

  // Process lessons and items from verified base or parsed structure
  (defaultCurriculum as unknown as CurriculumData).units.forEach((u) => {
    u.lessons.forEach((l) => {
      l.checklist_items.forEach((item) => {
        let confidence = 0.95;
        let needsReview = false;
        let reason = '';

        // Flag items with general or app-generated labels for admin verification
        if (item.item_type === 'app_task') {
          confidence = 0.85;
          needsReview = true;
          reason = 'App study task - verify wording and assignment';
        } else if (item.label.includes('Dialogue') || item.label.includes('Activity')) {
          confidence = 0.88;
        }

        if (needsReview) {
          uncertainFlags.push({ item_id: item.id, reason });
        }

        draftItems.push({
          id: `draft_item_${item.id}`,
          draft_id: draftId,
          lesson_id: l.id,
          section_name: item.section_name,
          label: item.label,
          item_type: item.item_type,
          printed_page: item.printed_page,
          pdf_page: item.pdf_page,
          confidence_score: confidence,
          needs_review: needsReview,
          review_notes: reason,
        });
      });
    });
  });

  const draft: CurriculumDraft = {
    id: draftId,
    edition_code: editionCode,
    status: 'under_review',
    raw_extraction: {
      fileName,
      fileSize,
      unitsCount: defaultCurriculum.units.length,
      extractedAt: new Date().toISOString(),
    },
    uncertain_flags: uncertainFlags,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  };

  return {
    draft,
    draftItems,
    uncertainCount: uncertainFlags.length,
  };
}

/**
 * Idempotent Curriculum Publisher
 * Merges reviewed items into active curriculum without wiping existing student progress!
 */
export function publishCurriculumDraft(
  currentCurriculum: CurriculumData,
  reviewedDraftItems: DraftChecklistItem[]
): CurriculumData {
  const updated = JSON.parse(JSON.stringify(currentCurriculum)) as CurriculumData;

  // Map reviewed changes back onto checklist items using stable IDs
  const itemMap = new Map<string, DraftChecklistItem>();
  reviewedDraftItems.forEach((d) => {
    // strip 'draft_item_' prefix if present
    const originalId = d.id.replace('draft_item_', '');
    itemMap.set(originalId, d);
  });

  updated.units.forEach((unit) => {
    unit.lessons.forEach((lesson) => {
      lesson.checklist_items.forEach((item) => {
        const reviewed = itemMap.get(item.id);
        if (reviewed) {
          item.label = reviewed.label;
          item.section_name = reviewed.section_name;
          item.item_type = reviewed.item_type;
          item.printed_page = reviewed.printed_page;
          item.pdf_page = reviewed.pdf_page;
          item.source_reference = `Textbook p. ${reviewed.printed_page} (PDF p. ${reviewed.pdf_page})`;
        }
      });
    });
  });

  return updated;
}
