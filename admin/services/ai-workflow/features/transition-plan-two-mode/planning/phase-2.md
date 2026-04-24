# Transition-Plan Two-Mode - Phase 2: Setup Mode Workflow

**Phase:** 2 - Setup Mode Workflow  
**Duration:** ~1-2 hours  
**Status:** ✅ Complete  
**Completed:** 2025-12-29  
**Merged:** PR #55 (2025-12-29)  
**Prerequisites:** Phase 1 complete

---

## 📋 Overview

Refactor the Step-by-Step Process section to become Setup Mode Workflow, focusing on scaffolding creation only.

**Success Definition:** Setup Mode creates minimal scaffolding (~60-80 lines) instead of full documents.

**Target File:** `.cursor/commands/transition-plan.md`  
**Target Section:** Lines ~79-600 (current "Step-by-Step Process")

---

## 🎯 Goals

1. **Rename section** - Change "Step-by-Step Process" to "Setup Mode Workflow"
2. **Simplify steps** - Focus on scaffolding creation only
3. **Create scaffolding template** - Define ~60-80 line phase template
4. **Add status indicators** - `🔴 Scaffolding (needs expansion)`

---

## 📝 Tasks

### Task 1: Analyze Current Step-by-Step Process

**Purpose:** Understand current structure before simplifying.

- [ ] Read current "Step-by-Step Process" section (lines 79-600+)
- [ ] Identify current steps:
  1. Mode Selection (Artifact/Reflection/ADR)
  2. Identify Artifact File
  3. Determine Transition Type
  4. Parse Artifact Content
  5. Create Transition Planning Documents
  6. Create Phase Documents (detailed)
  7. Update Planning Hubs
  8. Summary Report
- [ ] Note which content creates detailed phase documents (to be moved to Expand Mode)

**Current Flow:**
```
Input → Parse → Create transition-plan.md → Create FULL phase-N.md → Update hubs
                                                    ↑
                                         (This becomes scaffolding only)
```

---

### Task 2: Rename Section Header

**Purpose:** Clear naming for two-mode pattern.

- [ ] Change `## Step-by-Step Process` to `## Setup Mode Workflow`
- [ ] Update any internal references to "Step-by-Step Process"

**Change:**
```markdown
## Setup Mode Workflow

Creates scaffolding documents. For detailed expansion, use `--expand` flag (see Expand Mode Workflow).
```

---

### Task 3: Simplify Mode Selection

**Purpose:** Keep input mode selection, clarify it's for setup.

- [ ] Keep Mode Selection subsection (Artifact/Reflection/ADR)
- [ ] Add note that all input modes produce scaffolding in setup mode
- [ ] Update introduction text

**Content to Add:**
```markdown
### Mode Selection

**Input sources (all produce scaffolding in Setup Mode):**

1. **Artifact Mode:** `/transition-plan --from-artifacts [path]`
2. **Reflection Mode:** `/transition-plan --from-reflection [file]`
3. **ADR Mode:** `/transition-plan --from-adr [path]`

All modes create scaffolding documents. Use `--expand` to add detail.
```

---

### Task 4: Simplify Steps 1-3 (Keep As-Is)

**Purpose:** Input processing doesn't change for two-mode pattern.

- [ ] Keep Step 1: Identify Artifact/Source (no changes needed)
- [ ] Keep Step 2: Determine Transition Type (no changes needed)
- [ ] Keep Step 3: Parse Artifact Content (no changes needed)

**Note:** These steps are about reading input, not about output format.

---

### Task 5: Modify Step 4 - Create Transition Planning Documents

**Purpose:** This step creates transition-plan.md, which is mostly unchanged.

- [ ] Review current transition-plan.md template
- [ ] Keep transition-plan.md creation as-is (it's already appropriate for scaffolding)
- [ ] Add note that phase sections in transition-plan.md are summaries

**Minor Update:**
```markdown
### 4. Create Transition Planning Documents

Creates the main `transition-plan.md` file with phase summaries.

**Note:** Phase details are in separate `phase-N.md` scaffolding files.
```

---

### Task 6: Rewrite Step 5 - Create Phase Scaffolding (Major Change)

**Purpose:** This is the key change - create scaffolding instead of full documents.

- [ ] Rename to "Create Phase Scaffolding Documents"
- [ ] Replace detailed phase template with scaffolding template
- [ ] Add scaffolding template from ADR-002
- [ ] Document status indicator (`🔴 Scaffolding`)
- [ ] Add placeholder message template

**New Content:**
```markdown
### 5. Create Phase Scaffolding Documents

**Purpose:** Create minimal phase documents (~60-80 lines) for human review.

**When to create:**
- For feature transitions (always)
- For CI/CD transitions (treat steps as phases)

**Process:**

1. **Extract phases from source:**
   - Parse transition-plan.md for phase sections
   - Extract: phase number, name, goal, deliverables, prerequisites, effort
   
2. **For each phase, create scaffolding `phase-N.md`:**
   - Use scaffolding template (below)
   - Extract content from source (goals, criteria, dependencies)
   - Do NOT add detailed TDD tasks (that's for Expand Mode)
   - Add status indicator and placeholder message

**Scaffolding Template (~60-80 lines):**

```markdown
# [Feature] - Phase [N]: [Name]

**Phase:** [N] - [Name]  
**Duration:** [Estimate]  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** [From source]

---

## 📋 Overview

[1-2 sentences from ADR/source]

**Success Definition:** [From source criteria]

---

## 🎯 Goals

1. **[Goal 1]** - [From source]
2. **[Goal 2]** - [From source]

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan [topic] --expand --phase [N]` to add detailed TDD tasks.

### Task Categories

- [ ] **[Category 1]** - [Brief description]
- [ ] **[Category 2]** - [Brief description]

---

## ✅ Completion Criteria

- [ ] [Criterion 1 from source]
- [ ] [Criterion 2 from source]

---

## 📦 Deliverables

- [Deliverable 1 from source]
- [Deliverable 2 from source]

---

## 🔗 Dependencies

### Prerequisites

- [Previous phase or requirement]

### Blocks

- [Next phase]

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Previous Phase: Phase N-1](phase-N-1.md)
- [Next Phase: Phase N+1](phase-N+1.md)

---

**Last Updated:** YYYY-MM-DD  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan [topic] --expand --phase [N]`
```

**Target:** ~60-80 lines per phase document

**Checklist:**
- [ ] Phase scaffolding created for each phase
- [ ] Status indicator: `🔴 Scaffolding (needs expansion)`
- [ ] Placeholder message guides to expansion command
- [ ] Goals, criteria, dependencies extracted from source
- [ ] NO detailed TDD tasks (reserved for Expand Mode)
```

---

### Task 7: Simplify Step 6 - Update Planning Hubs

**Purpose:** Hub updates are the same, just note scaffolding status.

- [ ] Keep hub update process
- [ ] Add note about linking to scaffolding documents
- [ ] Update status notation

**Minor Update:**
```markdown
### 6. Update Planning Hubs

**Update hub files with scaffolding links:**

- Feature hub: Add phase scaffolding links with `🔴 Scaffolding` status
- Release hub: Add transition plan link
- CI/CD hub: Add phase links

**Example hub entry:**
```markdown
| Phase | Name | Status |
|-------|------|--------|
| [Phase 1](phase-1.md) | Foundation | 🔴 Scaffolding |
| [Phase 2](phase-2.md) | Implementation | 🔴 Scaffolding |
```
```

---

### Task 8: Update Summary Report

**Purpose:** Summary should reflect scaffolding output.

- [ ] Update summary to mention scaffolding
- [ ] Add next steps for expansion
- [ ] Include phase count and status

**New Content:**
```markdown
### 7. Summary Report

**Present to user:**

```markdown
## Setup Complete - Scaffolding Created

**Source:** [source-file]
**Type:** [Feature/Release/CI-CD]

### Documents Created

- `transition-plan.md` - Transition overview
- `phase-1.md` - Scaffolding (🔴 needs expansion)
- `phase-2.md` - Scaffolding (🔴 needs expansion)
- [etc.]

### Scaffolding Summary

- [N] phase scaffolding documents created
- Each ~60-80 lines (goals, criteria, dependencies)
- Status: 🔴 Scaffolding (needs expansion)

### Next Steps

1. **Review scaffolding** - Verify phase breakdown is correct
2. **Expand phases** - Run `/transition-plan [topic] --expand --phase N` or `--all`
3. **Implement** - Use `/task-phase` after expansion
```
```

---

### Task 9: Remove Detailed Phase Content

**Purpose:** Move detailed phase generation to Expand Mode.

- [ ] Identify sections that create detailed TDD tasks
- [ ] Remove or comment out detailed phase expansion
- [ ] Add reference to "See Expand Mode Workflow"

**Content to Remove/Move:**
- Detailed TDD task ordering logic
- Code example generation
- Implementation notes generation
- Risk assessment generation
- Progress tracking generation

**Add Placeholder:**
```markdown
**Note:** Detailed TDD tasks, code examples, and implementation notes are added in Expand Mode. See "Expand Mode Workflow (`--expand`)" section.
```

---

### Task 10: Verify Changes Against Criteria

**Purpose:** Confirm all completion criteria met.

- [ ] Section renamed to "Setup Mode Workflow"
- [ ] Steps simplified to scaffolding only (6-7 steps)
- [ ] Scaffolding template documented (~60-80 lines)
- [ ] Status indicator `🔴 Scaffolding (needs expansion)` in template
- [ ] Placeholder messages guide users to expansion
- [ ] Detailed content moved to Expand Mode section

---

## ✅ Completion Criteria

- [ ] Section renamed to "Setup Mode Workflow"
- [ ] Steps simplified to scaffolding only (6-7 steps)
- [ ] Scaffolding template documented (~60-80 lines)
- [ ] Status indicator `🔴 Scaffolding (needs expansion)` documented
- [ ] Placeholder messages guide users to expansion
- [ ] No detailed TDD content in Setup Mode

---

## 📦 Deliverables

- Setup Mode Workflow section (~200-250 lines)
- Scaffolding template (~60-80 lines)
- Status indicator documentation
- Summary report template

---

## 🔗 Dependencies

### Prerequisites

- [x] Phase 1: Workflow Overview complete
- [x] ADR-002: Scaffolding Content Boundaries reviewed

### Blocks

- Phase 3 (Expand Mode Workflow)

---

## 📊 Progress Tracking

| Task                                     | Status         | Notes |
| ---------------------------------------- | -------------- | ----- |
| Task 1: Analyze Current                  | ✅ Complete    | Done in Phase 1 |
| Task 2: Rename Section                   | ✅ Complete    |       |
| Task 3: Simplify Mode Selection          | ✅ Complete    |       |
| Task 4: Keep Steps 1-3                   | ✅ Complete    | No changes needed |
| Task 5: Modify Step 4                    | ✅ Complete    |       |
| Task 6: Rewrite Step 5 (Scaffolding)     | ✅ Complete    |       |
| Task 7: Simplify Step 6                  | ✅ Complete    |       |
| Task 8: Update Summary                   | ✅ Complete    |       |
| Task 9: Remove Detailed Content          | ✅ Complete    | Part of Task 6 |
| Task 10: Verify Changes                  | ✅ Complete    |       |

---

## 💡 Implementation Notes

### Key Insight: What Changes vs. What Stays

| Component | Setup Mode | Notes |
|-----------|------------|-------|
| Input processing | ✅ Keep | Same for both modes |
| transition-plan.md | ✅ Keep | Already appropriate |
| Phase scaffolding | ⚠️ New | Replace detailed template |
| TDD task ordering | ❌ Remove | Move to Expand Mode |
| Code examples | ❌ Remove | Move to Expand Mode |
| Implementation notes | ❌ Remove | Move to Expand Mode |

### Scaffolding vs. Full Phase Document

| Section | Scaffolding | Full (After Expand) |
|---------|-------------|---------------------|
| Header | ✅ Yes | ✅ Yes |
| Overview | ✅ Yes (1-2 sentences) | ✅ Yes (expanded) |
| Goals | ✅ Yes (list) | ✅ Yes (same) |
| Tasks | ⚠️ Categories only | ✅ Full TDD detail |
| Criteria | ✅ Yes (list) | ✅ Yes (same) |
| Deliverables | ✅ Yes (list) | ✅ Yes (same) |
| Dependencies | ✅ Yes | ✅ Yes |
| **Lines** | **~60-80** | **~200-300** |

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Previous Phase: Phase 1](phase-1.md)
- [Next Phase: Phase 3](phase-3.md)
- [ADR-002: Scaffolding Content](../../../decisions/transition-plan-two-mode/adr-002-scaffolding-content-boundaries.md)

---

**Last Updated:** 2025-12-29  
**Status:** ✅ Complete  
**Next:** Begin Phase 3 (Expand Mode Workflow)
