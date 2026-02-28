# Command Infrastructure

**Feature:** Workflow Simplification
**Group:** Command Infrastructure
**Status:** ✅ Complete
**Last Updated:** 2026-02-19

---

## 📝 Tasks

### Task 4: Create `/task` command

**File:** `.cursor/commands/task.md` (new)

**Purpose:** Replace `/task-phase` with a hybrid interface that reads the uniform planning structure.

**Three modes:**

1. **`/task next`** — Find the first unchecked task (`- [ ]`) in `implementation-plan.md`, resolve its group file from `tasks/`, and execute it. Sequential flow for "just give me the next thing."
2. **`/task N`** — Execute task number N explicitly (e.g., `/task 5`). Random access for "I want to do this specific thing."
3. **`/task`** (bare) — Display the implementation plan with checkbox status, current progress (X/N tasks), and which group is active. No execution, just status.

**Key behaviors to port from `/task-phase`:**

- **Pre-task branch validation** — Verify we're on the correct feature branch, not `develop` or `main`. Adapted: branch pattern is `feat/[feature]-[desc]` (no phase number).
- **Task grouping** — RED + GREEN TDD tasks are grouped together. When executing a RED task, automatically include the paired GREEN task.
- **Status auto-updates** — When starting the first task in a group, update `status-and-next-steps.md` to mark that group as `🟠 In Progress`. When completing the last task in a group, mark it `✅ Complete`.
- **Docs-only detection** — If all changes in a task are documentation-only, use direct merge workflow (no PR). Port the detection criteria from `/task-phase` lines 167-184.
- **Review-then-commit integration** — After implementing a task, invoke `/review` flow (stage, diff, draft message, STOP). User reviews, then `/commit`.
- **One task group at a time** — Complete the task (or RED+GREEN pair), commit, then STOP. Do not auto-advance to the next task.

**How it reads the plan:**

```
1. Read implementation-plan.md
2. Parse YAML frontmatter → get groups[], tasks_files[]
3. For /task next: scan checkboxes for first "- [ ]", get task number
4. For /task N: locate task N in the checkbox list
5. Determine which group file contains this task (from frontmatter groups[].tasks[])
6. Read the group file from tasks/NN-group-name.md for detailed description
7. Execute the task
```

**Feature detection (adapted from `/task-phase`):**

- Dev-infra: `admin/planning/features/[feature]/implementation-plan.md`
- Template projects: `docs/maintainers/planning/features/[feature]/implementation-plan.md`
- **Legacy fallback:** If `implementation-plan.md` not found, check for `feature-plan.md` + `phase-*.md` and suggest using `/task-phase` or migrating.

**Commit scope change:** `feat(phase-N): ...` becomes `feat([feature]): ...` or `feat([group]): ...`. Phase numbers are dropped from commit messages.

**Options:**

- `--feature [name]` — Specify feature name (overrides auto-detection)
- `--force-pr` — Force PR creation even for docs-only tasks
- `--dry-run` — Show what would be executed without doing it

**Estimated size:** ~600-800 lines (comparable to `task-phase.md` at ~927 lines, but simpler because one code path instead of multiple phase structures).

---

### Task 5: Create `/plan-review` command

**File:** `.cursor/commands/plan-review.md` (new)

**Purpose:** Replace `/pre-phase-review` for the uniform structure. Reviews `implementation-plan.md` + `tasks/` before implementation begins.

**Key behaviors to port from `/pre-phase-review`:**

- **Completeness check** — Verify all tasks have descriptions, goals are defined, dependencies listed.
- **Dependency validation** — Check that task dependencies are satisfiable (no circular deps, prerequisites exist).
- **Estimation sanity** — Flag groups with too many tasks (>8 per group) or too few (<2).
- **Gap identification** — Check for missing sections in task group files (per `task_group` validation rules).
- **Review document output** — Create a review document listing gaps, warnings, and recommendations.

**Adapted interface:**

```
/plan-review [feature]                    — Review entire implementation plan
/plan-review [feature] --group N          — Review specific group only
/plan-review [feature] --check-deps       — Focus on dependency validation
/plan-review [feature] --dry-run          — Show review without creating files
```

**Reads:**
- `implementation-plan.md` (frontmatter + task index)
- All files in `tasks/` directory
- `status-and-next-steps.md` (to check consistency)

**Output:** Review document at `admin/planning/features/[feature]/plan-review-[date].md` (or template-project equivalent).

**Estimated size:** ~400-500 lines (simpler than `pre-phase-review.md` at ~537 lines because uniform structure eliminates phase-detection branching).

---

### Task 6: Create deprecation stubs

**Files:**
- `.cursor/commands/task-phase.md` — Replace entire contents with stub
- `.cursor/commands/pre-phase-review.md` — Replace entire contents with stub

**Stub template:**

```markdown
# [Old Command Name] (Deprecated)

**This command has been renamed.** Use `/[new-command]` instead.

---

## Migration

- **Old:** `/task-phase [phase] [task]`
- **New:** `/task next` or `/task N`

See [Migration Guide](../../docs/MIGRATION-v0.10.md) for details.

---

**Deprecated in:** v0.10.0
**Replacement:** `/task`
```

**Important:** The stub files must remain at the original paths (`.cursor/commands/task-phase.md` and `.cursor/commands/pre-phase-review.md`) because Cursor has no command aliasing (C-5). Users who type `/task-phase` will see the deprecation notice and know to use `/task`.

---

### Task 7: Update template sync manifest

**File:** `scripts/template-sync-manifest.txt`

**Changes:**

1. Add new command files:
   - `.cursor/commands/task.md`
   - `.cursor/commands/plan-review.md`

2. Keep existing entries (they'll become stubs):
   - `.cursor/commands/task-phase.md` (now a deprecation stub)
   - `.cursor/commands/pre-phase-review.md` (now a deprecation stub)

3. Update the comment at top: change count from `24 total` to `26 total` (2 new commands added, 2 existing become stubs but stay in manifest).

**Post-update:** Copy new files to both templates:
```bash
cp .cursor/commands/task.md templates/standard-project/.cursor/commands/task.md
cp .cursor/commands/task.md templates/learning-project/.cursor/commands/task.md
cp .cursor/commands/plan-review.md templates/standard-project/.cursor/commands/plan-review.md
cp .cursor/commands/plan-review.md templates/learning-project/.cursor/commands/plan-review.md
```

Also sync the updated stubs:
```bash
cp .cursor/commands/task-phase.md templates/standard-project/.cursor/commands/task-phase.md
cp .cursor/commands/task-phase.md templates/learning-project/.cursor/commands/task-phase.md
cp .cursor/commands/pre-phase-review.md templates/standard-project/.cursor/commands/pre-phase-review.md
cp .cursor/commands/pre-phase-review.md templates/learning-project/.cursor/commands/pre-phase-review.md
```

---

## 🔗 Dependencies

- Task 4 depends on structure specification (Task 3) for frontmatter parsing contract
- Task 5 depends on Task 4 establishing the plan-reading pattern
- Task 6 depends on Tasks 4-5 being complete (stubs reference the new commands)
- Task 7 depends on Tasks 4-6 being complete (syncs all new/updated files)

## ⚠️ Implementation Notes

- **Task 4 is the critical path.** It's the hub command that unlocks everything else. Build it first, dogfood it on Task 5+.
- **Port, don't rewrite.** The core logic of `/task-phase` (TDD workflow, task grouping, status updates, docs-only detection, review-then-commit) is proven. Adapt it for the new structure rather than redesigning from scratch. ADR-002 validates that ~75% of `/task-phase` logic is reusable (NFR-5).
- **Test with this feature.** After creating `/task`, use it to implement Tasks 5-7. This is the ultimate dogfood test.

---

**Last Updated:** 2026-02-19
