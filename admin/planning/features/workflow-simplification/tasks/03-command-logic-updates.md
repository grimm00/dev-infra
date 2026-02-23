# Command Logic Updates

**Feature:** Workflow Simplification
**Group:** Command Logic Updates
**Status:** 🔴 Not Started
**Last Updated:** 2026-02-19

---

## 📝 Tasks

- [ ] Task 8: Update `/transition-plan` to produce uniform structure (`implementation-plan.md` + `tasks/` directory) with YAML frontmatter.
  - Generate `implementation-plan.md` with frontmatter (task_count, groups, tasks_files)
  - Generate `tasks/` directory with group files containing GFM checkbox tasks
  - Generate `status-and-next-steps.md` with group-based progress table
  - Remove tier detection logic; always produce uniform layout

- [ ] Task 9: Update dependent commands (`/pr`, `/post-pr`, `/status`, `/task-improvement`) to read from `implementation-plan.md` instead of phase files.
  - Add dual-path detection: check for `implementation-plan.md` first, fall back to `feature-plan.md`
  - Update PR description formatting to use task/group language
  - Update post-PR status updates to mark tasks (not phases) complete

---

## 🔗 Dependencies

- Task 8 depends on structure specification (Task 3) for output format
- Task 9 depends on Task 4 (`/task` command) establishing the reading pattern

---

**Last Updated:** 2026-02-19
