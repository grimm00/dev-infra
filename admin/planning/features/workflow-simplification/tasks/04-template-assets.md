# Template Assets

**Feature:** Workflow Simplification
**Group:** Template Assets
**Status:** 🔴 Not Started
**Last Updated:** 2026-02-19

---

## 📝 Tasks

- [ ] Task 10: Create `implementation-plan.md.tmpl` template in `scripts/doc-gen/templates/planning/`.
  - YAML frontmatter with template variables (`${TASK_COUNT}`, `${GROUPS}`)
  - GFM checkbox task list with `<!-- AI: -->` expansion markers
  - Required sections: Overview, Implementation Plan, Definition of Done

- [ ] Task 11: Create `task-group.md.tmpl` template in `scripts/doc-gen/templates/planning/`.
  - Feature and group metadata fields
  - Tasks section with GFM checkboxes
  - Optional dependencies and deliverables sections

- [ ] Task 12: Update `status-and-next-steps.md.tmpl` to remove phase-centric progress table.
  - Replace `| Phase | Name | Status |` with `| Group | Status | Progress | Notes |`
  - Update section heading from "Phase Progress" to "Group Progress" (optional section)

- [ ] Task 13: Replace `examples/example-feature-plan.md` with `examples/example-implementation-plan.md`.
  - Full working example with YAML frontmatter, GFM checkboxes, and group headings
  - Include example `tasks/` directory reference

---

## 🔗 Dependencies

- Tasks 10-11 depend on structure specification (Task 3) for template format
- Task 12 depends on validation rules (Task 2) for accepted table patterns

---

**Last Updated:** 2026-02-19
