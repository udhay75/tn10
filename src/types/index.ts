// ============================================================================
// Core Domain Types: Curriculum, Student Progress, Revision & Sync
// ============================================================================

export type CompletionStatus = 'not_started' | 'in_progress' | 'completed';

export type UnderstandingStatus = 
  | 'not_assessed' 
  | 'need_help' 
  | 'partly_understood' 
  | 'understood';

export type LessonType = 
  | 'prose' 
  | 'poem' 
  | 'supplementary' 
  | 'theory' 
  | 'exercise' 
  | 'practical' 
  | 'review'
  | 'map_work';

export type SubjectCode = 'class_10_english' | 'class_10_math' | 'class_10_science' | 'class_10_social_science' | 'class_10_tamil';

export type ItemType = 'source_activity' | 'app_task';

export interface ChecklistItem {
  id: string;
  lesson_id: string;
  order_index: number;
  item_type: ItemType;
  section_name: string;
  label: string;
  description: string;
  printed_page: number;
  pdf_page: number;
  source_reference: string;
  is_required: boolean;
}

export interface Lesson {
  id: string;
  unit_id: string;
  unit_number: number;
  lesson_number: number;
  lesson_type: LessonType;
  title: string;
  author: string;
  is_memoriter: boolean;
  printed_page_start: number;
  printed_page_end: number;
  pdf_page_start: number;
  pdf_page_end: number;
  checklist_items: ChecklistItem[];
}

export interface Unit {
  id: string;
  unit_number: number;
  title: string;
  theme: string;
  lessons: Lesson[];
}

export interface TextbookEdition {
  title: string;
  edition: string;
  first_edition_year: number;
  reprint_year: number;
  publisher: string;
  source_file: string;
  total_pages: number;
  page_offset: number;
}

export interface CurriculumData {
  board: {
    code: string;
    name: string;
    state: string;
  };
  class: {
    grade_number: number;
    title: string;
    code: string;
  };
  medium: {
    code: string;
    name: string;
  };
  subject: {
    code: string;
    title: string;
    curriculum_version: string;
    textbook: TextbookEdition;
  };
  units: Unit[];
  summary: {
    total_units: number;
    total_lessons: number;
    total_checklist_items: number;
    source_pdf: string;
    verified: boolean;
  };
}

export interface StudentProgress {
  id: string;
  student_id: string;
  item_code: string;
  completion_status: CompletionStatus;
  understanding_status: UnderstandingStatus;
  study_again: boolean;
  personal_notes: string;
  notes_updated_at: string | null;
  last_studied_at: string | null;
  next_revision_date: string | null;
  sync_version: number;
  updated_at: string;
  conflict_notes?: {
    local: string;
    remote: string;
    remote_updated_at: string;
  } | null;
}

export interface RevisionHistoryEntry {
  id: string;
  student_id: string;
  item_code: string;
  revision_date: string;
  notes_snapshot: string;
  outcome: string;
  still_needs_revision: boolean;
}

export interface StudentProfile {
  id: string;
  display_name: string;
  email: string;
  class_code: string;
  medium_code: string;
  interface_lang: 'en' | 'ta';
  created_at: string;
  is_admin?: boolean;
}

export interface SyncMutation {
  id: string;
  client_mutation_id: string;
  student_id: string;
  action: 'upsert_progress' | 'log_revision' | 'update_profile';
  entity_type: 'student_item_progress' | 'revision_history' | 'student_profiles';
  entity_id: string;
  payload: any;
  base_version: number;
  timestamp: number;
  attempts: number;
  status: 'pending' | 'syncing' | 'failed' | 'conflict';
  error_message?: string;
}

export type SyncStatusState = 
  | 'synced' 
  | 'syncing' 
  | 'offline' 
  | 'unsynced' 
  | 'error';

export interface DraftChecklistItem {
  id: string;
  draft_id: string;
  lesson_id: string;
  section_name: string;
  label: string;
  item_type: ItemType;
  printed_page: number;
  pdf_page: number;
  confidence_score: number;
  needs_review: boolean;
  review_notes?: string;
}

export interface CurriculumDraft {
  id: string;
  edition_code: string;
  status: 'draft' | 'under_review' | 'approved' | 'published';
  raw_extraction: any;
  uncertain_flags: Array<{ item_id: string; reason: string }>;
  created_at: string;
  updated_at: string;
}
