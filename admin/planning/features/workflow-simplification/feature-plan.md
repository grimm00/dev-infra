# Feature Plan - Workflow Simplification

**Status:** 🔴 Not Started
**Created:** 2026-02-19
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

1.  **Predictable Structure:** Every feature looks the same -- no tier detection, no "which structure is this?"
2.  **Progressive Disclosure:** Plan = overview, `tasks/` = details. Works for humans and AI alike.
3.  **Enhance Tooling:** Provide a flexible `/task` command with one code path.
4.  **Clarify Boundary:** Establish dev-infra as a "template factory" (spec owner).

---

## 📝 Implementation Plan

### Group 1: Foundation & Specs
- [ ] Task 1: Create migration guide (`docs/MIGRATION-v0.10.md`) explaining the new structure and adoption strategy.
- [ ] Task 2: Update validation rules (`scripts/doc-gen/validation/planning.yaml`) to accept `implementation_plan` and `task_group` types.
- [ ] Task 3: Create planning configuration (`scripts/doc-gen/config/planning.yaml`) defining the uniform structure and `tasks/` directory contract.

### Group 2: Command Infrastructure
- [ ] Task 4: Create `/task` command (new file) implementing the hybrid interface (`next`/`N`/bare), reading from `implementation-plan.md` and resolving details from `tasks/`.
- [ ] Task 5: Create `/plan-review` command (rename of `/pre-phase-review`) adapted for the new structure.
- [ ] Task 6: Create deprecation stubs for `task-phase.md` and `pre-phase-review.md` pointing to new commands.
- [ ] Task 7: Update `template-sync-manifest.txt` to include new commands and stubs.

### Group 3: Command Logic Updates
- [ ] Task 8: Update `/transition-plan` to produce uniform structure (`implementation-plan.md` + `tasks/` directory) with YAML frontmatter.
- [ ] Task 9: Update dependent commands (`/pr`, `/post-pr`, `/status`, `/task-improvement`) to read from `implementation-plan.md` instead of phase files.

### Group 4: Template Assets
- [ ] Task 10: Create `implementation-plan.md.tmpl` template.
- [ ] Task 11: Create `task-group.md.tmpl` template for files in `tasks/`.
- [ ] Task 12: Update `status-and-next-steps.md.tmpl` to remove phase-centric progress table.
- [ ] Task 13: Replace `examples/example-feature-plan.md` with `examples/example-implementation-plan.md`.

### Group 5: Documentation & Rules
- [ ] Task 14: Update template workflow documentation (`WORKFLOW-*.md`) to reflect the new task-based flow.
- [ ] Task 15: Update planning hub documentation (`planning/README.md`, `planning/features/README.md`) in templates.
- [ ] Task 16: Update `.cursor/rules/*.mdc` (main, workflow, template) to reflect the new structure.

### Group 6: Verification
- [ ] Task 17: Verify standard-project generation and new feature workflow (create feature, plan, implement).
- [ ] Task 18: Verify learning-project generation (regression test to ensure stages are unaffected).

---

## ✅ Definition of Done

- [ ] All tasks complete
- [ ] CI/CD passing
- [ ] Migration guide published
- [ ] Templates updated and synced
- [ ] Documentation updated
