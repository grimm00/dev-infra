# Command Infrastructure

**Feature:** Workflow Simplification
**Group:** Command Infrastructure
**Status:** 🔴 Not Started
**Last Updated:** 2026-02-19

---

## 📝 Tasks

- [ ] Task 4: Create `/task` command (new file `.cursor/commands/task.md`) implementing the hybrid interface (`next`/`N`/bare), reading from `implementation-plan.md` and resolving details from `tasks/`.
  - Three modes: `next` (sequential), `N` (explicit), bare (status/list)
  - Reads YAML frontmatter to locate task group files
  - Global task numbering (1 to N across all groups)
  - Integrates review-then-commit workflow

- [ ] Task 5: Create `/plan-review` command (`.cursor/commands/plan-review.md`) as rename of `/pre-phase-review` adapted for the new structure.
  - Reviews `implementation-plan.md` + `tasks/` instead of phase files
  - Identifies gaps, estimation issues, dependency conflicts

- [ ] Task 6: Create deprecation stubs for `task-phase.md` and `pre-phase-review.md` pointing to new commands.
  - Stub content: brief message pointing to `/task` and `/plan-review` respectively
  - Backward compatibility per C-5 (Cursor has no command aliasing)

- [ ] Task 7: Update `template-sync-manifest.txt` to include new commands and stubs.
  - Add: `task.md`, `plan-review.md`, `task-phase.md` (stub), `pre-phase-review.md` (stub)
  - Ensure both standard-project and learning-project receive all new files

---

## 🔗 Dependencies

- Task 4 depends on structure specification (Task 3) for frontmatter parsing contract
- Task 7 depends on Tasks 4-6 being complete

---

**Last Updated:** 2026-02-19
