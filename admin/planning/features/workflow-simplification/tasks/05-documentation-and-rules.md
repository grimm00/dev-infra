# Documentation & Rules

**Feature:** Workflow Simplification
**Group:** Documentation & Rules
**Status:** ✅ Complete
**Last Updated:** 2026-02-19

---

## 📝 Tasks

### Task 14: Update template planning hub documentation

**Files to update:**

1. `templates/standard-project/docs/maintainers/planning/README.md`
   - Update directory structure diagram: replace `feature-plan.md` + `phase-*.md` with `implementation-plan.md` + `tasks/`
   - Update "Quick Start > Starting a New Feature" steps to reference `implementation-plan.md`
   - Update "Feature Development Lifecycle" to reference tasks/groups instead of phases
   - Keep the `phases/` spoke reference (legacy projects may still use it)

2. `templates/standard-project/docs/maintainers/planning/features/README.md`
   - Update directory structure: replace `feature-plan.md` + `phase-*.md` with `implementation-plan.md` + `tasks/`
   - Update "Feature Development Pattern" to reference task groups instead of phases
   - Update "Feature Planning Checklist" to reference `implementation-plan.md`
   - Update inline templates section to show implementation plan + task group patterns
   - Update status tables: replace "Current Phase" with "Current Group" or "Progress"

3. Sync to `templates/learning-project/` if these files exist there (learning-project has a different planning hub structure -- skip if not applicable)

**Key principle:** Update references from `feature-plan.md` + `phase-N.md` to `implementation-plan.md` + `tasks/NN-group-name.md`. Keep legacy mentions as "(legacy)" where helpful.

---

### Task 15: Update `docs/PHASE-DOCUMENT-TEMPLATE.md`

**File:** `docs/PHASE-DOCUMENT-TEMPLATE.md`

**Changes:**
- Rename to `docs/PLANNING-DOCUMENT-TEMPLATES.md` (or add deprecation note at top)
- Add the uniform structure templates (`implementation-plan.md` format + task group format)
- Keep legacy phase template section with deprecation note
- Update "How to Use" instructions to reference `/transition-plan` setup + expand workflow

**Alternative (simpler):** Add a deprecation header pointing to the doc-gen templates in `scripts/doc-gen/templates/planning/`, since those are now the authoritative templates. This avoids maintaining two copies.

---

### Task 16: Update `.cursor/rules/*.mdc` files

**Files:**

1. `.cursor/rules/main.mdc` (2 references to update)
   - Update "Project Structure" diagram under `admin/planning/features/` to show `implementation-plan.md` + `tasks/`
   - Update "Current Project State" section command references

2. `.cursor/rules/workflow.mdc` (4 references to update)
   - Update "Creating New Template Features > Required Files" list: `feature-plan.md` -> `implementation-plan.md`, `phase-1.md` -> `tasks/`
   - Update "Feature Plan Structure" example to show implementation plan format
   - Update "Pre-Phase Review Workflow" to reference `/plan-review` and `/task`
   - Update any `/task-phase` references to `/task`

3. `.cursor/rules/template.mdc` (no direct phase references to update — already generic)
   - Verify no stale references; update if found

**Sync:** `.cursor/rules/` files are dev-infra specific, not synced to templates. Templates have their own rules generated at project creation.

---

## 🎯 Goals

- All user-facing documentation reflects the new uniform planning structure
- No stale references to `feature-plan.md` + `phase-N.md` pattern in templates
- `.cursor/rules/` files guide AI correctly for the new structure
- Legacy references are clearly marked as legacy where preserved

---

## ✅ Completion Criteria

- [ ] Template planning hubs updated in `standard-project`
- [ ] Phase document template updated or deprecated
- [ ] All three `.cursor/rules/*.mdc` files updated
- [ ] No broken internal references
- [ ] Template sync validation passes (if planning hubs are in sync manifest)

---

## 🔗 Dependencies

- Tasks 14-16 depend on command infrastructure (Group 2) and command logic (Group 3) being complete
- Task 14 depends on template assets (Group 4) for the doc-gen templates being available

---

**Last Updated:** 2026-02-19
