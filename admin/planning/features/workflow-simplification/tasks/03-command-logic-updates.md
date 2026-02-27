# Command Logic Updates

**Feature:** Workflow Simplification
**Group:** Command Logic Updates
**Status:** ✅ Complete
**Last Updated:** 2026-02-19

---

## 📝 Tasks

- [x] Task 8: Update `/transition-plan` to produce uniform structure (`implementation-plan.md` + `tasks/` directory) with YAML frontmatter.
  - **Preserve two-mode pattern** (setup + expand) to stay within context window limits:
    - **Setup mode** (default): Generate `implementation-plan.md` (frontmatter + task *titles* as GFM checkboxes) + `status-and-next-steps.md` (group-based progress table) + `tasks/` directory with *scaffolded* group files (~60-80 lines each: task titles, goals, criteria, dependencies -- but no detailed sub-tasks or TDD steps). Status: `🔴 Scaffolding (needs expansion)`.
    - **Expand mode** (`--expand --group N` or `--expand --group "Group Name"`): Fill one group file at a time with detailed implementation notes, TDD steps, code examples (~200-300 lines). Replaces `--expand --phase N`.
  - Remove tier detection logic; always produce uniform layout
  - Update `--expand --all` to iterate over all group files (use sparingly -- context-heavy)

- [x] Task 9: Update dependent commands (`/pr`, `/post-pr`, `/status`, `/task-improvement`) to read from `implementation-plan.md` instead of phase files.
  - Add dual-path detection: check for `implementation-plan.md` first, fall back to `feature-plan.md`
  - Update PR description formatting to use task/group language
  - Update post-PR status updates to mark tasks (not phases) complete

---

## 🔗 Dependencies

- Task 8 depends on structure specification (Task 3) for output format
- Task 9 depends on Task 4 (`/task` command) establishing the reading pattern

---

**Last Updated:** 2026-02-19
