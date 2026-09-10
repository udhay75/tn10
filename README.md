# Tamil Nadu State Board Class 10 Study Checklist & Notes PWA

A Progressive Web App (PWA) built specifically for Tamil Nadu State Board Class 10 students to track lesson completion, pending work, understanding levels, revision cycles, and personal study notes.

---

## Product Purpose

This app empowers Class 10 students to easily answer four essential study questions:
1. **What have I completed?** (Track all textbook sections and exercises)
2. **What is still pending?** (Instantly filter exercises that haven't been finished)
3. **What did I finish but not fully understand?** (Flag exercises where teacher help or deeper study is needed)
4. **What should I study again?** (Maintain a dedicated revision queue for upcoming board examinations)

### Crucial Architectural Design: Separation of Completion & Understanding
In this application, **Completion** and **Understanding** are strictly separate:
- A student can mark an exercise as **Completed** while simultaneously setting understanding to **Partly Understood** or **Need Help**.
- A student can flag any item for **Study Again** (revision queue) regardless of completion state.
- Conducting a revision session and marking it done increments the student's **Revision History** without resetting the lesson's completion status.

---

## Curriculum Structure & Textbook Source Fidelity

The curriculum is organised strictly as:
$$\text{Board} \rightarrow \text{Class} \rightarrow \text{Subject} \rightarrow \text{Textbook Edition} \rightarrow \text{Unit} \rightarrow \text{Lesson} \rightarrow \text{Checklist Item}$$

### Source Textbook Data
- **Board**: Tamil Nadu State Board of School Education
- **Class**: Standard 10 (Class X)
- **Subject**: English (English Medium & Tamil Medium extensible)
- **Edition**: Revised Edition 2020, 2022, 2023, Reprint 2024 (224 pages, SCERT Tamil Nadu)
- **Source File**: `Class_10_English_2024_Edition.pdf`
- **Page Offset**: $\text{PDF Page} = \text{Printed Textbook Page} + 4$

### Content Breakdown (Verified Against 2024 PDF)
- **7 Units** spanning the entire academic syllabus:
  1. **Unit 1**: Prose: *His First Flight* (Liam O'Flaherty) | Poem: *Life\** (Henry Van Dyke) | Supplementary: *The Tempest* (Charles Lamb)
  2. **Unit 2**: Prose: *The Night the Ghost Got In* (James Thurber) | Poem: *The Grumble Family* (Lucy Maud Montgomery) | Supplementary: *Zigzag* (Asha Nehemiah)
  3. **Unit 3**: Prose: *Empowered Women Navigating the World* | Poem: *I am Every Woman\** (Rakhi Nariani Shirke) | Supplementary: *The Story of Mulan*
  4. **Unit 4**: Prose: *The Attic* (Satyajit Ray) | Poem: *The Ant and the Cricket* (Aesop's Fables) | Supplementary: *The Aged Mother* (Matsuo Basho)
  5. **Unit 5**: Prose: *Tech Bloomers* | Poem: *The Secret of the Machines\** (Rudyard Kipling) | Supplementary: *A day in 2889 of an American Journalist* (Jules Verne)
  6. **Unit 6**: Prose: *The Last Lesson* (Alphonse Daudet) | Poem: *No Men Are Foreign\** (James Falconer Kirkup) | Supplementary: *The Little Hero of Holland* (Mary Mapes Dodge)
  7. **Unit 7**: Prose: *The Dying Detective* (Arthur Conan Doyle) | Poem: *The House on Elm Street* (Nadia Bush) | Supplementary: *A Dilemma* (Silas Weir Mitchell)
- **Total Lessons**: 21 (7 Prose, 7 Poem, 7 Supplementary)
- **Memoriter Poems (\*)**: 4 designated poems for mandatory memorisation (*Life*, *I am Every Woman*, *The Secret of the Machines*, *No Men Are Foreign*).
- **Checklist Activities**: 154 granular, meaningful activity groups covering In-text Questions, Glossary, Comprehension, Vocabulary (Parts of Speech, Affixes, Idioms), Grammar (Modals, Active/Passive Voice, Prepositions, Tenses, Concord, Linkers, Reported Speech, Clauses, Degrees of Comparison), Writing (Ads, Reports, Letters, Notices, Posters), and Listening/Speaking.
- **Source vs App Distinction**: Distinct visual badges for source-based activities vs app-created study tasks ("Read the lesson", "Revise this lesson").

---

## Offline-First Architecture & Sync Engine

The application operates seamlessly offline without requiring continuous internet connectivity:

```
[UI Components] <---> [IndexedDB (TN10_STUDY_DB)] <---> [SyncManager] <---> [Supabase / Cloud Postgres]
                               |                              |
                     (Account-Scoped Store)          (Multi-Trigger Replay)
```

1. **Local IndexedDB Database (`TN10_STUDY_DB`)**:
   - `curriculum`: Cached published curriculum.
   - `student_progress`: Account-scoped progress records indexed by `student_id`, `item_code`, and `study_again`.
   - `revision_history`: Account-scoped timestamped revision logs.
   - `sync_queue`: Persistent queue for offline mutations.
   - `app_meta`: Active student session, last visited lesson, language preference.
2. **Multi-Trigger Sync Engine**:
   - Replays queued mutations automatically when:
     - The app launches.
     - Connectivity returns (`online` event).
     - The window returns to foreground (`visibilitychange` / `focus`).
     - The student taps "Retry Sync" in the header.
3. **Safe Retries & Conflict Preservation**:
   - Safe idempotency using unique mutation identifiers.
   - Notes conflict resolution: If a note was modified on another device while offline, **both versions are preserved** without silent overwrite, and a side-by-side resolution UI allows the student to choose or merge.
4. **Multi-Tenant Account Isolation**:
   - Stored data is partitioned by `student_id`.
   - On sign-out, private records and cache are purged from the device.
   - If unsynced changes exist at sign-out, a warning dialog offers **"Sync & Sign Out"** or **"Discard & Sign Out"**.

---

## Dual Mode: Local Demo Mode vs Production Supabase

### Local Demo Mode (Zero-Config)
If Supabase environment variables are omitted, the app runs automatically in **Local Demo Mode**:
- Fully functional client-side storage powered by IndexedDB.
- Preloaded with the verified 2024 Class 10 English curriculum (all 7 units, 21 lessons, 154 items).
- Instant one-click role switching between **Demo Student** (*Anitha Selvam*) and **Demo Admin** (*K. Ramanathan*).

### Production Supabase Mode
When configured with Supabase credentials:
- **Authentication**: Email/password sign-up, sign-in, and password reset.
- **Database**: PostgreSQL with foreign key constraints, uniqueness constraints, and performance indexes.
- **Row-Level Security (RLS)**:
  - Students can read published curriculum.
  - Students can read and modify only their own progress and revision history.
  - Only authorized administrators (`admin_roles`) can create drafts or modify curriculum.
  - Service-role key is never exposed on the client.

---

## Getting Started

### Prerequisites
- Node.js 18+ or 20+
- npm 9+ or 10+
- Python 3.10+ (for PDF extraction scripts)

### Installation
```bash
# Clone or navigate to the workspace
cd /Applications/MAMP/htdocs/TN10

# Install dependencies
npm install
```

### Running Locally in Demo Mode
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) in your browser. The app will open directly in Local Demo Mode.

## Local Docker Database Setup

The app uses a local **PostgreSQL 16** Docker container (`tn10_postgres`) initialized with all 4 migration and seed scripts:

```bash
# 1. Build and start the PostgreSQL database container
docker compose up -d

# 2. Check database container status & health
docker ps --filter name=tn10_postgres

# 3. Verify curriculum tables and data inside Docker container
docker exec tn10_postgres psql -U postgres -d tn10_study -c "
  SELECT 
    (SELECT count(*) FROM units) as units, 
    (SELECT count(*) FROM lessons) as lessons, 
    (SELECT count(*) FROM checklist_items) as items;
"

# 4. Run the integration test suite against the Docker database
node scripts/test_docker_db.mjs
```

### Docker Container Configuration
- **Container Name**: `tn10_postgres`
- **Image**: `postgres:16-alpine` (with embedded schema migrations in `Dockerfile.db`)
- **Port**: `5432:5432`
- **Database**: `tn10_study`
- **User**: `postgres`
- **Password**: `postgres`
- **Volume**: `tn10_pgdata` (internal Docker named volume for persistent data)
- **API Endpoints**:
  - `GET /api/health` — Checks database health and table counts
  - `GET /api/curriculum` — Reads curriculum directly from Docker PostgreSQL
  - `GET /api/progress?student_id=...` — Reads progress from Docker PostgreSQL
  - `POST /api/progress` — Upserts student progress and notes to Docker PostgreSQL
  - `POST /api/revision` — Inserts revision history into Docker PostgreSQL

---

## Supabase Database Setup & Migrations

To connect a live Supabase production project:

1. Create a new Supabase project at [supabase.com](https://supabase.com).
2. Run the migration scripts in the **SQL Editor** in this order:
   - `supabase/migrations/001_initial_schema.sql` (Tables, constraints, indexes)
   - `supabase/migrations/002_row_level_security.sql` (RLS policies and `is_admin()` function)
   - `supabase/migrations/003_seed_english_2024.sql` (Complete 2024 English curriculum seed)
3. Set your environment variables in `.env.local`:
   ```bash
   NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-public-key
   NEXT_PUBLIC_APP_URL=https://your-domain.com
   NEXT_PUBLIC_ENABLE_DEMO_MODE=false
   ```
4. Assign admin rights to an administrator user:
   ```sql
   INSERT INTO admin_roles (user_id, role)
   VALUES ('USER_UUID_FROM_AUTH_USERS', 'admin')
   ON CONFLICT (user_id) DO NOTHING;
   ```

---

## Reusable PDF Import & Review Workflow

The application includes a repeatable 5-step curriculum import pipeline:

1. **Upload Textbook PDF**:
   - Provide a subject textbook PDF (e.g. `Class_10_English_2024_Edition.pdf`).
2. **Draft Extraction**:
   - Run extraction (`python3 scripts/extract_curriculum.py` or through the `/admin` UI).
   - Generates structured draft JSON with confidence scores.
3. **Flag Uncertain Extractions**:
   - Heuristics automatically flag app tasks or ambiguous activities for administrative review.
4. **Admin Review & Inline Edit**:
   - Access `/admin` as an administrator.
   - Review items, edit labels, reorder, adjust textbook page numbers, and mark approved.
5. **Publish Edition**:
   - Click **"Publish Approved Curriculum"**.
   - Changes are merged into active curriculum using stable UUIDs and slugs.
   - **Existing student progress, revision history, and notes are strictly preserved.**

---

## Progressive Web App (PWA) & Mobile Installation

### Features Included
- **Web App Manifest (`public/manifest.json`)**: Configured with `display: standalone`, `theme_color: #0f172a`, `background_color: #ffffff`.
- **App Icons**: 192x192 PNG, 512x512 PNG, 512x512 maskable PNG (for Android adaptive icons), and high-resolution SVG.
- **Service Worker (`public/sw.js`)**: Network-first navigation with dynamic caching of visited lessons and stale-while-revalidate for assets.
- **Offline Fallback Page (`public/offline.html`)**: Interactive offline status screen.
- **Update Prompt**: Alerts students when a new service worker version is ready, protecting unsynced changes before reloading.

### Installation Instructions
- **Android / Chromium**:
  - A bottom prompt will automatically appear with an **"Install"** button.
  - Or tap browser menu (⋮) $\rightarrow$ **"Install app"** / **"Add to Home screen"**.
- **iPhone / iPad (Safari)**:
  - Tap the **Share** button (square with arrow pointing up).
  - Scroll down and tap **"Add to Home Screen"**.
  - Tap **"Add"** in top right.
- **Desktop (Chrome / Edge)**:
  - Click the install icon in the URL address bar or select menu $\rightarrow$ **"Install TN Class 10 Study PWA"**.

---

## Localization (English & தமிழ்)

The user interface is fully prepared for bilingual operation:
- **English**: Default textbook and instruction language.
- **தமிழ் (Tamil)**: Full localization of dashboard metrics, checklist states, actions, buttons, and system notices.
- Switch languages anytime from the header button or from the **Settings** screen. Textbook titles and exercise source texts remain faithful to the official publication.

---

## Production Build & Deployment

To build the application for production:
```bash
npm run build
npm run start
```
For HTTPS deployment, deploy to Vercel, Netlify, or any Node.js container with HTTPS enabled (mandatory for PWA service worker registration).
