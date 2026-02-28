# Verification

**Feature:** Workflow Simplification
**Group:** Verification
**Status:** ✅ Complete
**Last Updated:** 2026-02-19

---

## 📝 Tasks

### Task 17: Verify standard-project template integrity

**Purpose:** Confirm that standard-project template generates correctly and the new uniform planning structure is consistent.

**Steps:**

1. **Run template validation:**
   ```bash
   bash scripts/validate-templates.sh
   ```
   - Verify all required directories exist
   - Verify all README.md files present
   - Verify documentation links valid

2. **Run template sync validation:**
   ```bash
   bash scripts/validate-template-sync.sh
   ```
   - Verify all files in manifest are in sync between templates

3. **Run existing bats test suite:**
   ```bash
   bats tests/unit/*.bats
   ```
   - All 110+ existing tests must pass (no regressions)

4. **Spot-check new template files:**
   - Verify `implementation-plan.md.tmpl` exists in `scripts/doc-gen/templates/planning/`
   - Verify `task-group.md.tmpl` exists in `scripts/doc-gen/templates/planning/`
   - Verify `examples/example-implementation-plan.md` exists
   - Verify new commands (`task.md`, `plan-review.md`) exist in both templates
   - Verify deprecation stubs (`task-phase.md`, `pre-phase-review.md`) exist in both templates

5. **Verify new planning variables in VARIABLES.md:**
   - `${TASK_COUNT}`, `${GROUP_NAME}`, `${GROUP_INDEX}`, `${SOURCE}` documented

**Pass criteria:** All validation scripts pass, all tests green, all new files present.

---

### Task 18: Verify learning-project template integrity (regression test)

**Purpose:** Ensure learning-project template is unaffected by workflow simplification changes (stage directories, learning-specific structure).

**Steps:**

1. **Run template validation** (covers both templates):
   - Already run in Task 17 — verify learning-project results specifically

2. **Verify learning-specific structure intact:**
   - `templates/learning-project/stage0-fundamentals/` exists
   - `templates/learning-project/stage1-topic/` exists
   - `templates/learning-project/stage2-topic/` exists
   - `templates/learning-project/stage3-topic/` exists
   - `templates/learning-project/practice-apps/` exists
   - `templates/learning-project/reference/` exists

3. **Verify shared commands synced correctly:**
   - All 26 commands present in `templates/learning-project/.cursor/commands/`
   - New commands (`task.md`, `plan-review.md`) present
   - Stubs (`task-phase.md`, `pre-phase-review.md`) present

4. **Verify learning-project planning hub is unmodified:**
   - `templates/learning-project/docs/maintainers/planning/README.md` still has learning-specific content (not overwritten with standard-project content)

**Pass criteria:** All learning-project structure intact, shared commands synced, no cross-template contamination.

---

## 🎯 Goals

- Confirm no regressions from workflow simplification changes
- Validate all new template assets are correctly placed
- Ensure template sync between standard-project and learning-project

---

## ✅ Completion Criteria

- [ ] `validate-templates.sh` passes
- [ ] `validate-template-sync.sh` passes
- [ ] All bats tests pass (110+)
- [ ] New template files present in both templates
- [ ] Learning-project stage structure intact
- [ ] No cross-template contamination

---

## 🔗 Dependencies

- Tasks 17-18 depend on all previous groups being complete

---

**Last Updated:** 2026-02-19
