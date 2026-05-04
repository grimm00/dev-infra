# Template Assets

**Feature:** Workflow Simplification
**Group:** Template Assets
**Status:** ✅ Complete
**Last Updated:** 2026-02-19

---

## 📝 Tasks

### Task 10: Create `implementation-plan.md.tmpl`

**File:** `scripts/doc-gen/templates/planning/implementation-plan.md.tmpl` (new)

**Purpose:** Doc-gen template for the central plan file. Used by `/transition-plan` setup mode to generate scaffolding.

**Template structure:**

```
---
task_count: ${TASK_COUNT}
groups:
<!-- AI: YAML group entries -->
tasks_files:
<!-- AI: file list -->
---
# Implementation Plan - ${FEATURE_NAME}

**Status:** ${STATUS}
**Created:** ${DATE}
**Last Updated:** ${DATE}
**Source:** ${SOURCE}

---

## 📋 Overview
<!-- AI: feature overview -->

## 🎯 Goals
<!-- AI: goals -->

## 📝 Implementation Plan
<!-- AI: GFM checkbox task list with ### group headings -->

## ✅ Definition of Done
<!-- AI: criteria -->
```

**Key conventions:**
- YAML frontmatter uses `${TASK_COUNT}`, `${GROUPS}` expansion markers
- `<!-- AI: -->` markers tell the generator where to inject content
- GFM checkbox format: `- [ ] Task N: Description`
- Group headings: `### Group Name`

---

### Task 11: Create `task-group.md.tmpl`

**File:** `scripts/doc-gen/templates/planning/task-group.md.tmpl` (new)

**Purpose:** Doc-gen template for individual task group files inside `tasks/`. Used by `/transition-plan` setup mode.

**Template structure:**

```
# ${GROUP_NAME}

**Feature:** ${FEATURE_NAME}
**Group:** ${GROUP_NAME}
**Status:** ${STATUS}
**Last Updated:** ${DATE}

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan ${FEATURE_NAME} --expand --group ${GROUP_INDEX}` to add detailed implementation notes.

<!-- AI: Task list with GFM checkboxes and brief descriptions -->

---

## 🎯 Goals
<!-- AI: Group goals -->

---

## ✅ Completion Criteria
<!-- AI: Completion criteria -->

---

## 🔗 Dependencies
<!-- AI: Dependencies on other groups/tasks -->

---

**Last Updated:** ${DATE}
```

**Variables:** `${GROUP_NAME}`, `${GROUP_INDEX}`, `${FEATURE_NAME}`, `${STATUS}`, `${DATE}`

---

### Task 12: Update `status-and-next-steps.md.tmpl`

**File:** `scripts/doc-gen/templates/planning/status-and-next-steps.md.tmpl` (modify)

**Changes:**
- Replace the phase-centric progress table with a group-based table
- Update section heading from "Phase Progress" to "Progress Summary"
- Keep template backward-compatible via `<!-- AI: -->` markers (the generator fills in whatever structure the plan uses)

**Before:**
```
| Phase | Name | Status | Progress | Notes |
```

**After:**
```
| Group | Status | Progress | Notes |
```

Also update the `README.md.tmpl` to reference `implementation-plan.md` instead of `feature-plan.md` and `tasks/` instead of phase links.

---

### Task 13: Create example implementation plan

**File:** `scripts/doc-gen/templates/planning/examples/example-implementation-plan.md` (new)

**Purpose:** Full working example demonstrating the uniform structure. Referenced by AUTHORING.md and used as a visual reference for template authors.

**Contents:** A realistic example with:
- YAML frontmatter (3 groups, 10 tasks)
- GFM checkbox task list with group headings
- Shows completed and incomplete tasks
- References a `tasks/` directory with group files

**No `examples/` directory currently exists** — create it under `planning/`.

---

## 🔗 Dependencies

- Tasks 10-11 depend on structure specification (Task 3) for template format
- Task 12 depends on validation rules (Task 2) for accepted table patterns
- Task 13 depends on Tasks 10-11 for the template being exemplified

## ⚠️ Implementation Notes

- Keep existing `feature-plan.md.tmpl` and `phase.md.tmpl` — they're still valid for legacy projects. Mark them with a `<!-- DEPRECATED: ... -->` header comment.
- The `README.md.tmpl` needs updating to reference the new files alongside legacy.
- Template variable conventions are documented in `scripts/doc-gen/templates/VARIABLES.md`.

---

**Last Updated:** 2026-02-19
