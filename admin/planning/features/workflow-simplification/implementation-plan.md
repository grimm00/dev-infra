---
task_count: 18
groups:
  - name: "Foundation & Specs"
    file: "tasks/01-foundation-and-specs.md"
    tasks: [1, 2, 3]
  - name: "Command Infrastructure"
    file: "tasks/02-command-infrastructure.md"
    tasks: [4, 5, 6, 7]
  - name: "Command Logic Updates"
    file: "tasks/03-command-logic-updates.md"
    tasks: [8, 9]
  - name: "Template Assets"
    file: "tasks/04-template-assets.md"
    tasks: [10, 11, 12, 13]
  - name: "Documentation & Rules"
    file: "tasks/05-documentation-and-rules.md"
    tasks: [14, 15, 16]
  - name: "Verification"
    file: "tasks/06-verification.md"
    tasks: [17, 18]
tasks_files:
  - "tasks/01-foundation-and-specs.md"
  - "tasks/02-command-infrastructure.md"
  - "tasks/03-command-logic-updates.md"
  - "tasks/04-template-assets.md"
  - "tasks/05-documentation-and-rules.md"
  - "tasks/06-verification.md"
---
# Implementation Plan - Workflow Simplification

**Status:** 🟠 In Progress
**Created:** 2026-02-19
**Last Updated:** 2026-02-19
**Source:** [Research Summary](../../../research/workflow-simplification/research-summary.md)

---

## 📋 Overview

Simplify the feature/phase/task hierarchy in dev-infra templates by moving from a multi-file phase structure (`feature-plan.md` + `phase-N.md`) to a uniform `implementation-plan.md` + `tasks/` model. Every feature gets the same predictable layout regardless of size.

**Key Changes:**
- **Uniform Structure:** `implementation-plan.md` + `status-and-next-steps.md` + `tasks/` for every feature.
- **Hybrid Command:** Rename `/task-phase` to `/task` with `next`/`N`/bare modes.
- **Spec-Only Boundary:** Dev-infra owns specs (templates, validation rules), dev-toolkit owns implementation.
- **Migration:** Minor version bump (v0.10.0) with "new features only" adoption.

---

## 🎯 Goals

1. **Predictable Structure:** Every feature looks the same -- no tier detection, no "which structure is this?"
2. **Progressive Disclosure:** Plan = overview, `tasks/` = details. Works for humans and AI alike.
3. **Enhance Tooling:** Provide a flexible `/task` command with one code path.
4. **Clarify Boundary:** Establish dev-infra as a "template factory" (spec owner).

---

## 📝 Implementation Plan

### Foundation & Specs
- [x] Task 1: Create migration guide (`docs/MIGRATION-v0.10.md`)
- [x] Task 2: Update validation rules (`scripts/doc-gen/templates/validation-rules/planning.yaml`)
- [x] Task 3: Add planning structure specification to `planning.yaml`

### Command Infrastructure
- [ ] Task 4: Create `/task` command (hybrid interface: `next`/`N`/bare)
- [ ] Task 5: Create `/plan-review` command (rename of `/pre-phase-review`)
- [ ] Task 6: Create deprecation stubs for `task-phase.md` and `pre-phase-review.md`
- [ ] Task 7: Update `template-sync-manifest.txt` to include new commands and stubs

### Command Logic Updates
- [ ] Task 8: Update `/transition-plan` to produce uniform structure with YAML frontmatter
- [ ] Task 9: Update dependent commands (`/pr`, `/post-pr`, `/status`) to read `implementation-plan.md`

### Template Assets
- [ ] Task 10: Create `implementation-plan.md.tmpl` template
- [ ] Task 11: Create `task-group.md.tmpl` template for `tasks/` files
- [ ] Task 12: Update `status-and-next-steps.md.tmpl` to remove phase-centric progress table
- [ ] Task 13: Replace `examples/example-feature-plan.md` with `examples/example-implementation-plan.md`

### Documentation & Rules
- [ ] Task 14: Update template workflow documentation (`WORKFLOW-*.md`)
- [ ] Task 15: Update planning hub documentation in templates
- [ ] Task 16: Update `.cursor/rules/*.mdc` to reflect new structure

### Verification
- [ ] Task 17: Verify standard-project generation and new feature workflow
- [ ] Task 18: Verify learning-project generation (regression test)

---

## ✅ Definition of Done

- [ ] All tasks complete
- [ ] CI/CD passing
- [ ] Migration guide published
- [ ] Templates updated and synced
- [ ] Documentation updated
