# Feature Plan - Workflow Simplification

**Status:** 🔴 Not Started
**Tier:** Medium (Single file with groups)
**Created:** 2026-02-19
**Source:** [Research Summary](../../../research/workflow-simplification/research-summary.md)

---

## 📋 Overview

Simplify the feature/phase/task hierarchy in dev-infra templates by moving from a multi-file phase structure (`feature-plan.md` + `phase-N.md`) to a tiered `implementation-plan.md` model. This reduces overhead for small features while maintaining scalability for large ones.

**Key Changes:**
- **Tiered Structure:** Simple (1-8 tasks), Medium (9-15 tasks), Complex (16+ tasks).
- **Hybrid Command:** Rename `/task-phase` to `/task` with `next`/`N`/bare modes.
- **Spec-Only Boundary:** Dev-infra owns specs (templates, validation rules), dev-toolkit owns implementation.
- **Migration:** Minor version bump (v0.10.0) with "new features only" adoption.

---

## 🎯 Goals

1.  **Reduce Ceremony:** Eliminate phase files for simple features.
2.  **Improve Scalability:** Support complex features with hub-and-spoke structure.
3.  **Enhance Tooling:** Provide a flexible `/task` command that works for all tiers.
4.  **Clarify Boundary:** Establish dev-infra as a "template factory" (spec owner).

---

## 📝 Implementation Plan

### Group 1: Foundation & Specs
- [ ] Task 1: Create migration guide (`docs/MIGRATION-v0.10.md`) explaining the new structure and adoption strategy.
- [ ] Task 2: Update validation rules (`scripts/doc-gen/validation/planning.yaml`) to accept `implementation_plan` and `task_group` types.
- [ ] Task 3: Create tier configuration (`scripts/doc-gen/config/tier-config.yaml`) defining thresholds and file structures.

### Group 2: Command Infrastructure
- [ ] Task 4: Create `/task` command (new file) implementing the hybrid interface (`next`/`N`/bare) and reading from `implementation-plan.md`.
- [ ] Task 5: Create `/plan-review` command (rename of `/pre-phase-review`) adapted for the new structure.
- [ ] Task 6: Create deprecation stubs for `task-phase.md` and `pre-phase-review.md` pointing to new commands.
- [ ] Task 7: Update `template-sync-manifest.txt` to include new commands and stubs.

### Group 3: Command Logic Updates
- [ ] Task 8: Update `/transition-plan` to implement tier logic (simple/medium/complex) and generate blueprint metadata.
- [ ] Task 9: Update dependent commands (`/pr`, `/post-pr`, `/status`, `/task-improvement`) to read from `implementation-plan.md` instead of phase files.
- [ ] Task 10: Update `/task` to fully support blueprint reading and hub traversal for complex tiers.

### Group 4: Template Assets
- [ ] Task 11: Create `implementation-plan.md.tmpl` (for simple/medium tiers).
- [ ] Task 12: Create `implementation-plan-hub.md.tmpl` and `task-group.md.tmpl` (for complex tier).
- [ ] Task 13: Update `status-and-next-steps.md.tmpl` to remove phase-centric progress table.
- [ ] Task 14: Replace `examples/example-feature-plan.md` with `examples/example-implementation-plan.md`.

### Group 5: Documentation & Rules
- [ ] Task 15: Update template workflow documentation (`WORKFLOW-*.md`) to reflect the new task-based flow.
- [ ] Task 16: Update planning hub documentation (`planning/README.md`, `planning/features/README.md`) in templates.
- [ ] Task 17: Update `.cursor/rules/*.mdc` (main, workflow, template) to reflect the new structure.

### Group 6: Verification
- [ ] Task 18: Verify standard-project generation and new feature workflow (create feature, plan, implement).
- [ ] Task 19: Verify learning-project generation (regression test to ensure stages are unaffected).

---

## ✅ Definition of Done

- [ ] All tasks complete
- [ ] CI/CD passing
- [ ] Migration guide published
- [ ] Templates updated and synced
- [ ] Documentation updated
