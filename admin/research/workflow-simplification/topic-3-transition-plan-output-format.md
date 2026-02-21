# Topic 3: Transition Plan Output Format - Research Document

**Purpose:** Determine if the transition plan can produce an ordered work breakdown (flat list) instead of a phase hierarchy  
**Status:** ✅ Complete  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-14

---

## 📋 Quick Links

- **[Workflow Simplification Research Hub](README.md)** - Parent research hub
- **[Research Topics](../../explorations/workflow-simplification/research-topics.md)** - All 5 topics
- **[Topic 1: Feature Plan Structure Usage](topic-1-feature-plan-usage.md)** - Foundation for simplification
- **[Topic 2: Task Command Interface Design](topic-2-task-command-interface-design.md)** - What format does `/task` need?

---

## 🎯 Research Goal

**Key Question:** Can the transition plan produce an ordered work breakdown (flat list) instead of a phase hierarchy, and what does that template look like?

**Context:** The transition plan currently produces `feature-plan.md` + `phase-N.md` files. If the hierarchy flattens (Theme 2), the transition plan should produce a single document with an ordered task list. This document becomes the single planning artifact between `/decision` and `/task`.

---

## 🔍 Research Goals

- [x] Goal 1: Design 2-3 candidate document formats for the single planning document
- [x] Goal 2: Test each format against a small feature (3-5 tasks) and a large feature (10-15 tasks)
- [x] Goal 3: Determine if optional grouping (sections/headings) feels natural within a flat document
- [x] Goal 4: Prototype how `/task` would parse and update progress in each format
- [x] Goal 5: Research industry patterns for single-document implementation plans

---

## 📚 Research Methodology

**Sources:**

- [x] Web search: Markdown task list and work breakdown structure formats
- [x] Web search: Single-document implementation plan templates in real projects
- [x] Codebase: Openverse implementation plan template (used by WordPress/Openverse project)
- [x] Codebase: TODO.md format (GitHub open-source standard)
- [x] Codebase: SpecWeave tasks.md format (BDD-integrated task checklist)
- [x] Codebase: GitHub spec-kit plan-template.md (GitHub's own internal template)
- [x] Codebase: Current `/transition-plan` command output (phase-N.md scaffolding)
- [x] Codebase: Existing completed features (command-simplification, release-readiness, worktree)

---

## 📊 Findings

### Finding 1: Three Distinct Industry Formats for Single-Document Planning

Research identified three real-world patterns for single-document implementation plans:

| Format | Example | Complexity | Machine-Parseable | Grouping |
|--------|---------|------------|-------------------|----------|
| **Flat Checkbox** | TODO.md, GFM task lists | Low | ✅ Easy (`- [ ]` / `- [x]`) | Optional headings |
| **Rich Task Entries** | SpecWeave tasks.md | High | ✅ With YAML frontmatter | Per-task sections (`## T-001`) |
| **Step-by-Step Plan** | Openverse, GitHub spec-kit | Medium | ⚠️ Varies (headings + prose) | Section headings |

**TODO.md pattern** (261+ stars): Sections as columns, tasks as `- [ ]` checkboxes, optional metadata (estimates, tags, dates) at end of task title. Designed for GitHub rendering with automatic progress calculation.

**SpecWeave pattern**: Each task is a full section (`## T-001: Title`) with embedded BDD test plans, status tracking, implementation notes, and dependency declarations. Rich but heavyweight.

**Openverse/spec-kit pattern**: `## Step-by-step plan` section with prose descriptions per step. Less structured for machine parsing but readable for humans.

**Source:** Web research: TODO.md format, SpecWeave docs, Openverse implementation template, GitHub spec-kit

**Relevance:** Our use case needs machine-parseability (FR-4) with optional grouping (FR-3). The TODO.md pattern is closest to our needs but too minimal for TDD context. SpecWeave is too heavyweight. A middle ground is optimal.

---

### Finding 2: Three Candidate Formats Designed and Tested

Based on industry patterns and our requirements (FR-1, FR-3, FR-4, FR-11), designed three candidate formats:

#### Format A: Pure Flat Checkbox List

```markdown
# Implementation Plan: [Feature Name]

## Context
[Brief description, link to ADR/decision]

## Tasks

- [ ] Task 1: Create ADR for commands-as-guides philosophy
- [ ] Task 2: Add /status command to standard-project template
- [ ] Task 3: Add /status command to learning-project template
- [ ] Task 4: Update template-sync-manifest.txt
- [ ] Task 5: Remove experimental-only stability docs
- [ ] Task 6: Merge experimental-project into standard-project
- [ ] Task 7: Update new-project.sh generator (2 types only)
- [ ] Task 8: Update CI validation workflows
```

**Pros:** Simplest possible. Easy to parse (every `- [ ]` line is a task). GitHub renders progress bars.
**Cons:** No context grouping. Large features (15+ tasks) become a wall of checkboxes. No metadata (effort, dependencies).

#### Format B: Grouped Checkbox List with Section Headings

```markdown
# Implementation Plan: [Feature Name]

**Source:** [Link to ADR/decision]
**Status:** 🟠 In Progress (3/8 tasks)
**Created:** YYYY-MM-DD

---

## Overview
[1-2 sentences from ADR, success criteria]

---

## Tasks

### Foundation
- [x] Task 1: Create ADR for commands-as-guides philosophy
- [x] Task 2: Mark graduation ADR as superseded

### Template Updates
- [x] Task 3: Add /status to standard-project
- [ ] Task 4: Add /status to learning-project
- [ ] Task 5: Update template-sync-manifest.txt

### Cleanup
- [ ] Task 6: Remove experimental-only stability docs
- [ ] Task 7: Merge experimental-project into standard
- [ ] Task 8: Update CI validation workflows

---

## Notes
[Implementation notes, decisions made during work]
```

**Pros:** Optional grouping via `###` headings. Tasks still parseable by checkboxes. Groups provide human context without mandating structure. Scales to large features.
**Cons:** Group headings are informational only (not functional). Slightly more structure than Format A.

#### Format C: Rich Task Entries (SpecWeave-Inspired)

```markdown
# Implementation Plan: [Feature Name]

## T-001: Create ADR
**Status:** [x] complete
**Group:** Foundation
**Effort:** 30 min
**Dependencies:** None
**Implementation:** Create admin/decisions/command-simplification/adr-001-commands-as-guides.md

## T-002: Add /status to standard-project
**Status:** [ ] pending
**Group:** Template Updates
**Effort:** 15 min
**Dependencies:** T-001
**Implementation:** Copy .cursor/commands/status.md to standard-project template
```

**Pros:** Rich metadata per task. Explicit dependencies. Effort tracking.
**Cons:** Heavyweight -- each task is ~6 lines instead of 1. A 15-task feature would be 90+ lines of tasks alone. `/task` parsing is more complex (parse `**Status:**` fields). Doesn't use standard GFM checkboxes (GitHub won't render progress bars).

**Source:** Format design based on FR-1, FR-3, FR-4, FR-11 from Topics 1 and 2; industry pattern analysis

**Relevance:** Format B is the sweet spot -- it satisfies all requirements while keeping the format lightweight and compatible with standard GFM rendering.

---

### Finding 3: Format Testing Against Real Features

#### Small Feature: Command Simplification (4 phases, ~8 tasks)

**Current structure:** `feature-plan.md` with phases inline (no phase files). ~215 lines.

**Format A rendering:**

```markdown
## Tasks
- [ ] Task 1: Create ADR (commands-as-guides philosophy)
- [ ] Task 2: Mark ADR-004 superseded
- [ ] Task 3: Add /status to standard-project
- [ ] Task 4: Add /status to learning-project
- [ ] Task 5: Update template-sync-manifest.txt
- [ ] Task 6: Remove STABILITY-LEVELS.md, GRADUATION-CHECKLIST.md, EXPERIMENTAL.md
- [ ] Task 7: Remove experimental-project template directory
- [ ] Task 8: Update new-project.sh (2 template types)
```

**Verdict:** Works well for 8 tasks. All visible at a glance. No grouping needed.

**Format B rendering:**

```markdown
### ADR & Documentation
- [ ] Task 1: Create ADR (commands-as-guides philosophy)
- [ ] Task 2: Mark ADR-004 superseded

### Template Updates
- [ ] Task 3: Add /status to standard-project
- [ ] Task 4: Add /status to learning-project
- [ ] Task 5: Update template-sync-manifest.txt

### Template Consolidation
- [ ] Task 6: Remove STABILITY-LEVELS.md, GRADUATION-CHECKLIST.md, EXPERIMENTAL.md
- [ ] Task 7: Remove experimental-project directory

### CI & Validation
- [ ] Task 8: Update new-project.sh and CI workflows
```

**Verdict:** Groups add natural structure. Each group maps to what was previously a "phase." Optional -- could remove headings and it still works.

**Format C rendering:** 48+ lines for 8 tasks. Excessive for this size feature.

---

#### Large Feature: Release Readiness (5 phases, 15+ tasks)

**Current structure:** `feature-plan.md` + 5 `phase-N.md` files. Phase-1 alone has ~12 tasks; Phase-2 has ~10 tasks. Total: ~40+ tasks across 5 phases.

**Format A rendering (40 tasks):**

```markdown
## Tasks
- [ ] Task 1: Research existing release readiness tools
- [ ] Task 2: Define readiness criteria structure
- [ ] Task 3: Create check-release-readiness.sh skeleton
...
- [ ] Task 38: Test full release workflow
- [ ] Task 39: Update CHANGELOG.md
- [ ] Task 40: Final documentation review
```

**Verdict:** Wall of checkboxes. Hard to navigate. No sense of progress milestones. `/task 27` has no context about what area of work it belongs to.

**Format B rendering (40 tasks, 5 groups):**

```markdown
### Phase 1: Assessment Script
- [ ] Task 1: Research existing release readiness tools
- [ ] Task 2: Define readiness criteria (YAML frontmatter)
- [ ] Task 3: Create check-release-readiness.sh skeleton
- [ ] Task 4: Implement Git analysis checks
...

### Phase 2: Branch Creation Script
- [ ] Task 9: Design create-release-branch.sh interface
- [ ] Task 10: Implement branch validation
...

### Phase 3: Historical Analysis
- [ ] Task 17: Create analyze-releases.sh
...

### Phase 4: Integration Testing
- [ ] Task 25: End-to-end release workflow test
...

### Phase 5: Documentation & Polish
- [ ] Task 33: Release process guide
...
```

**Verdict:** Groups restore navigability. Each group is a logical milestone. `/task 27` can be contextualized by its group heading. Progress visible per group. Still parseable by checkboxes.

**Format C rendering:** 240+ lines for 40 tasks. Unmanageable.

**Source:** Prototyping against `admin/planning/features/command-simplification/feature-plan.md` and `admin/planning/features/release-readiness/`

**Relevance:** Format B is the only format that works well at both scales. Format A breaks down for large features; Format C is too verbose for any size.

---

### Finding 4: `/task` Command Parsing Is Straightforward for Format B

Analysis of how `/task` would parse Format B:

**Task detection algorithm:**

1. Scan document for lines matching `- [ ] Task N:` or `- [x] Task N:` (checkbox pattern)
2. Each matching line is a task. Number is extracted from `Task N:` prefix.
3. Group headings (`### Group Name`) are captured as context but don't affect task numbering
4. `/task next` → find first line matching `- [ ] Task` (unchecked)
5. `/task 7` → find line matching `- [ ] Task 7:` or `- [x] Task 7:`
6. `/task` (bare) → count checked vs unchecked, display progress per group

**Task completion update:**

```
Before: - [ ] Task 7: Implement CRUD endpoints
After:  - [x] Task 7: Implement CRUD endpoints
```

Single character change (`[ ]` → `[x]`). `/task` command uses `StrReplace` on the planning document -- same mechanism already used in `/task-phase` for phase doc checkboxes.

**Group-aware progress display (bare `/task`):**

```
Implementation Plan: Auth System (5/12 tasks complete)

### Foundation (2/2 ✅)
- [x] Task 1: Create database schema
- [x] Task 2: Create base API models

### Core Implementation (3/6 🟠)
- [x] Task 3: Implement CRUD endpoints
- [x] Task 4: Add authentication middleware
- [x] Task 5: Implement session management
- [ ] Task 6: Add rate limiting          ← /task next
- [ ] Task 7: Error handling middleware
- [ ] Task 8: Input validation

### Testing & Polish (0/4 🔴)
- [ ] Task 9: Unit tests
...
```

**Source:** Extrapolation from FR-4, FR-10, FR-11; analysis of `/task-phase` task detection logic

**Relevance:** Format B is trivially parseable. The `/task` command's task detection is actually simpler than `/task-phase`'s current approach (which must locate the correct `phase-N.md` file first, then find the task within it).

---

### Finding 5: Current `/transition-plan` Output Maps Cleanly to Format B

The current `/transition-plan` command produces:

| Current Output | Lines | New Output (Format B) |
|----------------|-------|----------------------|
| `transition-plan.md` (overview) | ~100 | Absorbed into single doc header (Overview, Goals, Definition of Done) |
| `feature-plan.md` (context) | ~80 | Absorbed into single doc Context section |
| `phase-1.md` (scaffolding) | ~70 | Becomes `### Phase 1: [Name]` group heading + task list |
| `phase-2.md` (scaffolding) | ~70 | Becomes `### Phase 2: [Name]` group heading + task list |
| `phase-N.md` (scaffolding) | ~70 | Becomes `### Phase N: [Name]` group heading + task list |
| **Total: 3+ files, ~390+ lines** | | **Total: 1 file, ~120-180 lines** |

**The mapping is:**

```
Current: transition-plan.md → Overview, Goals
Current: feature-plan.md → Context (optional, may already exist)
Current: phase-N.md Tasks section → ### Group heading + - [ ] Task items
Current: phase-N.md Completion Criteria → Definition of Done section
Current: phase-N.md Dependencies → (implicit via task order)
```

**What's preserved:**
- Task ordering (numbered task items)
- Grouping context (group headings replace phase names)
- Completion criteria (consolidated into one Definition of Done section)
- Dependencies (task order; explicit note for non-sequential deps)

**What's lost (intentionally):**
- Per-phase status fields (replaced by checkbox progress)
- Per-phase scaffolding/expansion workflow (no longer needed -- single document)
- Phase-level deliverables list (absorbed into task descriptions)
- Phase-level prerequisites (implicit via task numbering)

**Source:** Analysis of `/transition-plan` command (`.cursor/commands/transition-plan.md`, 1778 lines), current phase-N.md scaffolding template

**Relevance:** The current transition-plan output maps cleanly to Format B. The `/transition-plan` command's setup mode would produce one file instead of N+2 files. The expand mode may become unnecessary (tasks are already in the document).

---

### Finding 6: Status Tracking Role in the New Format

Topic 1 found that `status-and-next-steps.md` is consistently the most valuable planning artifact (14 commits in release-readiness, 9 in worktree). Two options for its role:

**Option 1: Keep `status-and-next-steps.md` as a separate file**

```
feature-dir/
├── implementation-plan.md    ← Tasks (from /transition-plan)
└── status-and-next-steps.md  ← Runtime tracking (updated during work)
```

**Pros:** Separation of concerns -- plan is static, status is dynamic. Status file can track things beyond tasks (PR references, fix batches, handoff notes, milestone dates).
**Cons:** Two files instead of one (though still far fewer than current N+3 files).

**Option 2: Merge status tracking into the planning document**

```
feature-dir/
└── implementation-plan.md    ← Tasks + Status + Notes (single file)
```

**Pros:** True single-document model (FR-1). All context in one place.
**Cons:** File grows over time as notes accumulate. Task section and status section may conflict (both being edited). Risk of the document becoming unwieldy for very long features.

**Assessment:** The `status-and-next-steps.md` content from analyzed features includes:
- Completion checkboxes (overlaps with task checkboxes in plan)
- PR references and merge dates (runtime tracking)
- Fix batch tracking (Sourcery review follow-ups)
- Deferred items (not part of the plan)
- Milestone summaries (retrospective)

Much of this is **runtime tracking** that accumulates during work. Keeping it separate preserves a clean planning document that the `/task` command parses, while the status file captures the messy reality of implementation.

**Source:** Analysis of `status-and-next-steps.md` content across features (from Topic 1 findings), FR-1, FR-2

**Relevance:** Recommend Option 1 (keep separate). The planning document stays parseable and clean; the status file captures runtime context. This reduces current N+3 files to exactly 2 files per feature.

---

### Finding 7: The "Expand Mode" Question

The current `/transition-plan` has two modes:
- **Setup Mode:** Creates scaffolding (~60-80 lines per phase, placeholder tasks)
- **Expand Mode:** Fills scaffolding with TDD detail (~200-300 lines per phase)

With a single planning document, is expand mode still needed?

**Analysis:** The expand mode currently adds:
- Detailed TDD tasks (RED → GREEN → REFACTOR steps)
- Code examples and implementation notes
- Specific file paths and test commands

In the new format, these details would go directly into the task descriptions:

```markdown
### Core Implementation
- [ ] Task 3: Implement CRUD endpoints
  - RED: Write test for GET /api/items endpoint
  - GREEN: Implement handler, return mock data
  - REFACTOR: Extract service layer
  - Files: src/api/items.ts, tests/api/items.test.ts
```

**Two approaches:**

| Approach | Setup Mode | Expand Mode |
|----------|-----------|-------------|
| **A: Keep two modes** | Produce tasks with brief descriptions | Expand tasks with TDD sub-steps |
| **B: Single mode** | Produce tasks with brief descriptions | No expand -- `/task` adds TDD detail when implementing |

Approach B is simpler. The `/task` command already manages the TDD workflow (RED/GREEN/REFACTOR) at runtime. Pre-expanding tasks with TDD steps is redundant with what `/task` does during implementation.

**However:** The expand mode serves a human review purpose -- letting the user verify the TDD approach before implementation starts. This is the value of `/pre-phase-review`.

**Compromise:** The planning document includes task descriptions (what, not how). The `/task` command handles TDD detail at runtime. If the user wants to pre-review the approach, they use a modified `/pre-review` command (renamed from `/pre-phase-review`) that analyzes the planning document and produces a review.

**Source:** Analysis of `/transition-plan` setup/expand workflow, `/task-phase` TDD workflow

**Relevance:** Simplify to a single output mode. The planning document has tasks with descriptions; TDD execution detail is managed by `/task` at runtime.

---

### Finding 8: Single-File Bias Reassessment (Amendment)

Post-research review identified several underweighted tradeoffs in the single-file recommendation:

**Concerns with single-file for complex features (15+ tasks):**

| Concern | Impact | Severity |
|---------|--------|----------|
| **AI context waste** | `/task 27` reads entire 180+ line file; only needs ~10 lines for the current task. Phase files (~70 lines) were more focused. | HIGH -- affects every `/task` invocation |
| **Progressive disclosure violation** | This project's hub-and-spoke pattern exists because flat documents don't scale for human navigation. A 40-task single file breaks this principle. | MEDIUM -- humans can use search/fold |
| **Concurrent editing** | `/task` checking boxes, user adding notes, `/review` staging changes -- all in one file. Separate files isolate concerns. | MEDIUM -- mitigated by status-file separation |
| **File growth** | Completed tasks accumulate sub-notes; clean 180-line document could grow to 300+ during implementation. | LOW-MEDIUM -- disciplined usage helps |
| **Handoff clarity** | "You're on task 27 of a 200-line file" is worse context than "you're in foundation/task-3." | LOW -- `/task next` can report context |
| **NFR-7 is circular** | "Split the feature if >300 lines" is a constraint imposed to make the model work, not derived from evidence. | LOW -- but intellectually dishonest |

**Proposed tiered approach:**

| Tier | Task Count | Structure | `/transition-plan` Output |
|------|-----------|-----------|--------------------------|
| **Simple** | 1-8 tasks | Single `implementation-plan.md` | 1 file, no groups needed |
| **Medium** | 9-15 tasks | Single `implementation-plan.md` with `###` groups | 1 file, groups recommended |
| **Complex** | 16+ tasks | Hub `implementation-plan.md` + group files (`tasks/[group].md`) | Hub + N group files |

**The "blueprint" question:** The tier decision must be explicit and codified, not discretionary. `/transition-plan` needs a way to:
1. Count/estimate tasks from the ADR and requirements
2. Determine the appropriate tier
3. Produce the right structure
4. Record the decision in the output (so `/task` knows what structure to expect)

This suggests an intermediate artifact -- a **feature blueprint** -- that captures the sizing decision before files are created. The blueprint could be:
- A YAML frontmatter block in `implementation-plan.md` (machine-readable)
- A separate `blueprint.md` file (human-reviewable)
- Inline metadata in the ADR (avoids a new file)

**Source:** Post-research review prompted by human challenge: "have we weighed the pros and cons of squashing everything into one file?"

**Relevance:** The original recommendation (always single file) was biased by small-feature evidence. A tiered approach preserves simplicity for simple features while respecting AI context efficiency and human navigation for complex ones. The tier determination mechanism is a design question for the decision phase.

---

### Finding 9: Doc-Gen Templates and Dev-Toolkit Integration (Amendment)

The existing doc-gen system in `scripts/doc-gen/templates/` and dev-toolkit's `dt-doc-gen`/`dt-workflow` tools provide the infrastructure to implement the tiered blueprint approach programmatically rather than relying on AI discretion.

**Current doc-gen planning templates (to be replaced):**

| Template | Variables | Purpose |
|----------|-----------|---------|
| `feature-plan.md.tmpl` | `${FEATURE_NAME}`, `${STATUS}`, `${DATE}` | Feature overview + phases |
| `phase.md.tmpl` | `${PHASE_NUMBER}`, `${PHASE_NAME}`, `${FEATURE_NAME}` | Per-phase goals, tasks, criteria |
| `status-and-next-steps.md.tmpl` | `${FEATURE_NAME}`, `${STATUS}`, `${DATE}` | Phase-based progress table |
| `README.md.tmpl` | `${FEATURE_NAME}`, `${TOPIC_NAME}` | Hub linking to feature-plan + phases |

**Proposed replacement templates:**

| Template | New Variables | Tier |
|----------|--------------|------|
| `implementation-plan.md.tmpl` | `${TIER}`, `${TASK_COUNT}`, `${GROUP_COUNT}`, `${STRUCTURE}` | Simple/Medium |
| `implementation-plan-hub.md.tmpl` | Same + `${GROUP_FILES}` | Complex |
| `task-group.md.tmpl` | `${GROUP_NAME}`, `${TASK_RANGE}`, `${FEATURE_NAME}` | Complex |
| `status-and-next-steps.md.tmpl` (updated) | Remove phase table, add task progress | All |
| `README.md.tmpl` (updated) | Remove phase links, add tier-aware links | All |

**Validation rule updates (`planning.yaml`):**

Current subtypes (`feature_plan`, `phase`, `status_and_next_steps`, `planning_hub`) would be replaced/updated:
- `implementation_plan` -- validates Format B structure, YAML frontmatter with tier metadata
- `task_group` -- validates group file structure (replaces `phase`)
- `status_and_next_steps` -- updated validation (task-based progress, not phase-based)
- `planning_hub` -- updated links and structure

**Two-way dev-infra ↔ dev-toolkit integration:**

```
dev-infra (standards keeper)              dev-toolkit (CLI implementation)
──────────────────────────────            ──────────────────────────────
scripts/doc-gen/templates/planning/  ──→  dt-doc-gen discovers via DT_TEMPLATES_PATH
  implementation-plan.md.tmpl             dt_render_template() with envsubst
  implementation-plan-hub.md.tmpl
  task-group.md.tmpl
  status-and-next-steps.md.tmpl

validation-rules/planning.yaml       ──→  Compiled to .bash rules for dt-doc-validate

scripts/scaffold-feature.sh          ──→  Basis for dt-workflow transition-plan logic
  (tier determination)                    dt-workflow wraps and extends
  (file structure generation)
  (blueprint production)

                                     ←──  dt-workflow patterns inform script design
                                          L1/L2/L3 validation tiers
                                          Context profiles
                                          Handoff file contracts
```

**The scaffolding script (`scripts/scaffold-feature.sh`):**

This is the key new artifact. A shell script that:
1. Accepts: feature name, task count (or derives from requirements), optional `--tier` override
2. Applies tier thresholds (1-8 simple, 9-15 medium, 16+ complex)
3. Renders the appropriate templates via `envsubst` with tier-specific variables
4. Produces the feature directory with the right structure
5. Is callable from both Cursor commands (`/transition-plan`) and dev-toolkit (`dt-workflow`)

This script acts as the single source of truth for tier logic, ensuring consistency between IDE-driven and CLI-driven workflows.

**Source:** Analysis of `scripts/doc-gen/templates/planning/`, dev-toolkit `bin/dt-doc-gen`, `bin/dt-workflow`, and `lib/doc-gen/templates.sh`

**Relevance:** The blueprint/tier system isn't just a document format -- it's a scaffolding contract that spans three layers: templates (dev-infra), scripts (dev-infra, consumable by both), and CLI tools (dev-toolkit). Getting this right means tier decisions are enforced identically regardless of whether the user invokes `/transition-plan` in Cursor or `dt-workflow transition-plan` on the command line.

---

## 🔍 Analysis

### Key Insights

- [x] **Insight 1: Format B (grouped checkbox list) is the clear winner.** It satisfies all requirements (FR-1, FR-3, FR-4, FR-11), works for both small (8 tasks) and large (40+ tasks) features, is trivially machine-parseable, and renders correctly on GitHub with progress indicators.

- [x] **Insight 2: The transition from N+3 files to 2 files is substantial for simple/medium features.** Currently: `feature-plan.md` + `transition-plan.md` + N `phase-N.md` + `status-and-next-steps.md`. Proposed simple: `implementation-plan.md` + `status-and-next-steps.md`. For a 5-phase feature, this is 8 files → 2 files (simple) or → hub + group files (complex).

- [x] **Insight 3: Group headings are optional context, not functional structure.** The `/task` command parses checkboxes (`- [ ]` / `- [x]`), ignoring headings. Groups help humans navigate but aren't required. A 3-task feature can skip grouping entirely. This satisfies FR-3 (optional grouping) and NFR-1 (scale from simple to complex).

- [x] **Insight 4: Status tracking should remain a separate file.** `status-and-next-steps.md` captures runtime information (PR refs, fix batches, handoff notes) that doesn't belong in the planning document. Keeping it separate preserves parseability of the plan and allows the status file to grow organically.

- [x] **Insight 5: Expand mode can be eliminated.** TDD detail is managed by `/task` at runtime, not pre-planned in the document. The planning document has "what" (tasks), `/task` adds "how" (TDD steps). `/pre-review` serves the human review purpose.

- [x] **Insight 6: Task numbering should be continuous across groups.** Not per-group (Task 1, Task 1) but global (Task 1, Task 2, ... Task N). This enables `/task 7` to unambiguously reference a task regardless of which group it's in.

- [x] **Insight 7: Single-file has real tradeoffs for complex features.** AI context waste (~150 unused lines per `/task` invocation), progressive disclosure violation, and concurrent editing risk are legitimate concerns for 16+ task features. The tiered approach (simple → single file, complex → hub + group files) addresses this without adding boilerplate for small features.

- [x] **Insight 8: Tier determination must be codified, not discretionary.** "Use your judgment" leads to inconsistency across features and between AI assistants. The tier decision needs a concrete input (task count, group count from ADR) and a documented output (blueprint/metadata in the planning document).

- [x] **Insight 9: Doc-gen templates + scaffolding script = the blueprint implementation.** The existing `scripts/doc-gen/` system provides the infrastructure (envsubst rendering, validation YAML, template discovery). A new `scaffold-feature.sh` script implements tier logic and is callable from both Cursor commands and dev-toolkit. Dev-infra as standards keeper means templates, validation rules, and tier logic all live here -- dev-toolkit consumes them.

- [x] **Insight 10: Current planning templates need replacement, not patching.** `feature-plan.md.tmpl` and `phase.md.tmpl` encode the old phase hierarchy. The replacement set (`implementation-plan.md.tmpl`, `implementation-plan-hub.md.tmpl`, `task-group.md.tmpl`) must carry the YAML frontmatter blueprint and tier-specific structure. This is a breaking change in the doc-gen system.

---

## 💡 Recommendations

- [x] **Recommendation 1: Adopt Format B (grouped checkbox list) as the core planning format.** Header with metadata (source, status, dates), Overview section, Tasks section with optional `###` group headings and `- [ ] Task N:` checkboxes, Definition of Done section, Notes section. Format B applies at all tiers.

- [x] **Recommendation 2: Name the document `implementation-plan.md`.** Replaces the current `feature-plan.md` + `transition-plan.md` + `phase-N.md` trio. The name reflects its role: the implementation work breakdown.

- [x] **Recommendation 3: Keep `status-and-next-steps.md` as a separate file.** Runtime tracking stays distinct from the plan at all tiers.

- [x] **Recommendation 4 (AMENDED): Use a tiered structure based on task count.** Simple (1-8 tasks): single `implementation-plan.md`. Medium (9-15 tasks): single file with `###` groups. Complex (16+ tasks): hub `implementation-plan.md` + separate group task files (`tasks/[group].md`). This replaces the original "always single file" recommendation.

- [x] **Recommendation 5: Task numbering is global and continuous.** `Task 1` through `Task N`, not reset per group. `/task 7` always means the 7th task in the document (or hub).

- [x] **Recommendation 6: Use `### Group Name` headings as the grouping mechanism.** At simple/medium tiers, these are inline in the single file. At complex tier, each group becomes a separate file under `tasks/`.

- [x] **Recommendation 7: `/transition-plan` must produce a feature blueprint with explicit tier determination.** The blueprint captures: task count, group count, tier decision, and resulting file structure. This can be YAML frontmatter in `implementation-plan.md` or a separate metadata block. The blueprint is the contract between `/transition-plan` (producer) and `/task` (consumer).

- [x] **Recommendation 8: Tier thresholds should be codified in the command, not left to discretion.** `/transition-plan` counts tasks from the ADR/requirements, applies the threshold table, and produces the appropriate structure. The user can override with a `--tier` flag if needed.

- [x] **Recommendation 9: Implement tier logic as a `scripts/scaffold-feature.sh` script in dev-infra.** This script is the single source of truth for tier determination and file scaffolding. It uses the doc-gen template system (`envsubst`, `<!-- AI: -->` markers), applies tier thresholds, and produces the feature directory. Both `/transition-plan` (Cursor command) and `dt-workflow` (dev-toolkit CLI) call this script, ensuring consistency. The script also serves as the prototype for eventual dev-toolkit integration.

- [x] **Recommendation 10: Replace current planning templates with tier-aware templates.** `feature-plan.md.tmpl` + `phase.md.tmpl` → `implementation-plan.md.tmpl` + `implementation-plan-hub.md.tmpl` + `task-group.md.tmpl`. Update `planning.yaml` validation rules accordingly. Update `status-and-next-steps.md.tmpl` to remove phase-centric progress table.

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] **FR-15 (AMENDED): Tiered implementation plan structure.** `/transition-plan` must produce structure based on task count: Simple (1-8 tasks) → single `implementation-plan.md`; Medium (9-15 tasks) → single file with `###` groups; Complex (16+ tasks) → hub `implementation-plan.md` + `tasks/[group].md` files. All tiers use Format B (GFM checkboxes).
- [x] **FR-16: Global continuous task numbering.** Tasks are numbered sequentially across the entire document or hub (Task 1 through Task N), not restarted per group. This ensures `/task N` is unambiguous.
- [x] **FR-17: Group headings as optional context.** `### Group Name` headings provide human-readable structure but are not parsed or required by `/task`. Small features may omit groups entirely. At complex tier, groups become separate files.
- [x] **FR-18 (AMENDED): `/transition-plan` produces a feature blueprint.** The command reads ADR/requirements, counts tasks and groups, determines the tier (simple/medium/complex), and produces the appropriate file structure. Replaces the current setup + expand two-step workflow.
- [x] **FR-19 (AMENDED): Feature directory structure scales by tier.** Simple: `implementation-plan.md` + `status-and-next-steps.md` (2 files). Medium: same 2 files. Complex: `implementation-plan.md` (hub) + `tasks/[group].md` files + `status-and-next-steps.md` (3+ files).
- [x] **FR-20: Feature blueprint with explicit tier metadata.** `implementation-plan.md` must include machine-readable metadata (YAML frontmatter or structured header) declaring: tier (simple/medium/complex), task count, group count, and file structure. This is the contract between `/transition-plan` and `/task`.
- [x] **FR-21: Codified tier thresholds.** `/transition-plan` must apply documented thresholds (1-8 = simple, 9-15 = medium, 16+ = complex) automatically. User can override with `--tier` flag. Thresholds are configurable but have sensible defaults.

### Non-Functional Requirements

- [x] **NFR-6: Document should render correctly in GitHub.** GFM task list checkboxes (`- [ ]` / `- [x]`) enable GitHub's automatic progress bars and interactive checkbox toggling. The format must use standard GFM syntax.
- [x] **NFR-7 (AMENDED): AI context efficiency.** At simple/medium tiers, `/task` reads one file. At complex tier, `/task` reads the hub (for task index) then only the relevant group file (for task detail). This keeps context consumption proportional to the work being done, not the total feature size.

### Constraints

- [x] **C-6: `/task` command parsing depends on document format.** The `- [ ] Task N: Description` pattern is the contract between `/transition-plan` (producer) and `/task` (consumer). Any format change must update both commands.
- [x] **C-7: `/task` must handle both single-file and hub+group structures.** The command reads the blueprint metadata to determine which structure it's dealing with, then resolves the correct file for the requested task.

### Assumptions

- [x] **A-5: TDD detail is a runtime concern, not a planning concern.** The planning document describes "what" (tasks); the `/task` command manages "how" (TDD RED/GREEN/REFACTOR execution). This eliminates the need for expand mode.
- [x] **A-6: Group headings will informally correspond to previous "phases."** Teams moving from phase-N.md files will naturally use groups that match their former phases. This is acceptable and expected behavior, not a design requirement.
- [x] **A-7: Task count is knowable at planning time.** The ADR and requirements provide enough information for `/transition-plan` to estimate the number of tasks and groups. The count doesn't need to be exact -- it drives a tier decision, not a precise structure.

---

## 📐 Proposed Templates

### Simple/Medium Tier: Single `implementation-plan.md`

```markdown
---
tier: simple  # simple | medium | complex
tasks: 6
groups: 2
structure: single-file
---

# Implementation Plan: [Feature Name]

**Source:** [Link to ADR or decision document]  
**Status:** 🔴 Not Started | 🟠 In Progress (N/M tasks) | ✅ Complete  
**Created:** YYYY-MM-DD  
**Last Updated:** YYYY-MM-DD

---

## Overview

[1-3 sentences: what this feature does and why, extracted from ADR/decision]

**Success Criteria:**
- [Criterion 1 from ADR]
- [Criterion 2 from ADR]

---

## Tasks

### [Group 1 Name] (optional heading for medium tier)
- [ ] Task 1: [Description]
- [ ] Task 2: [Description]

### [Group 2 Name]
- [ ] Task 3: [Description]
- [ ] Task 4: [Description]
- [ ] Task 5: [Description]
- [ ] Task 6: [Description]

---

## Definition of Done

- [ ] All tasks complete
- [ ] Tests passing
- [ ] Documentation updated
- [ ] PR approved and merged

---

## Notes

[Implementation notes, decisions made during work, links to relevant PRs]

---

**Last Updated:** YYYY-MM-DD
```

### Complex Tier: Hub `implementation-plan.md` + Group Files

**Hub file (`implementation-plan.md`):**

```markdown
---
tier: complex
tasks: 28
groups: 4
structure: hub-and-groups
group_files:
  - tasks/foundation.md
  - tasks/core-implementation.md
  - tasks/integration.md
  - tasks/documentation.md
---

# Implementation Plan: [Feature Name]

**Source:** [Link to ADR or decision document]  
**Status:** 🟠 In Progress (12/28 tasks)  
**Created:** YYYY-MM-DD  
**Last Updated:** YYYY-MM-DD

---

## Overview

[1-3 sentences from ADR/decision]

**Success Criteria:**
- [Criterion 1]
- [Criterion 2]

---

## Task Index

| Group | File | Tasks | Status |
|-------|------|-------|--------|
| Foundation | [tasks/foundation.md](tasks/foundation.md) | 1-7 | ✅ Complete (7/7) |
| Core Implementation | [tasks/core-implementation.md](tasks/core-implementation.md) | 8-18 | 🟠 In Progress (5/11) |
| Integration | [tasks/integration.md](tasks/integration.md) | 19-24 | 🔴 Not Started (0/6) |
| Documentation | [tasks/documentation.md](tasks/documentation.md) | 25-28 | 🔴 Not Started (0/4) |

---

## Definition of Done

- [ ] All tasks complete
- [ ] Tests passing
- [ ] Documentation updated
- [ ] PR approved and merged

---

**Last Updated:** YYYY-MM-DD
```

**Group file (`tasks/core-implementation.md`):**

```markdown
# Core Implementation

**Group:** Core Implementation (Tasks 8-18)  
**Parent:** [Implementation Plan](../implementation-plan.md)

---

- [x] Task 8: Implement user model
- [x] Task 9: Create database migrations
- [x] Task 10: Implement CRUD endpoints
- [x] Task 11: Add input validation
- [x] Task 12: Implement authentication middleware
- [ ] Task 13: Add rate limiting
- [ ] Task 14: Implement session management
- [ ] Task 15: Add error handling middleware
- [ ] Task 16: Create service layer
- [ ] Task 17: Implement caching
- [ ] Task 18: Add logging

---

**Last Updated:** YYYY-MM-DD
```

**Target lengths:**
- Simple tier: ~60-80 lines (single file)
- Medium tier: ~100-150 lines (single file with groups)
- Complex tier: ~60 lines (hub) + ~30-40 lines per group file

---

## 🔗 Related

- **[Topic 1: Feature Plan Structure Usage](topic-1-feature-plan-usage.md)** — What's lost by flattening?
- **[Topic 2: Task Command Interface Design](topic-2-task-command-interface-design.md)** — How would `/task` parse each format?
- **[Topic 4: Template Impact Assessment](topic-4-template-impact-assessment.md)** — Template changes for new format

---

**Last Updated:** 2026-02-14  
**Status:** ✅ Complete  
**Next:** Topic 4 (Template Impact Assessment) -- implementation planning for all changes
