# Decisions Summary - Workflow Simplification

**Purpose:** Summary of all decisions made for workflow simplification
**Status:** 🔴 Pending
**Created:** 2026-02-19
**Last Updated:** 2026-02-19

---

## 📋 Decisions Overview

We are moving from a rigid, multi-file phase structure (feature-plan + phase-N files) to a flexible, tiered implementation-plan model. This simplifies the workflow for small features (single file) while preserving scalability for large ones (hub + groups). We are also renaming `/task-phase` to `/task` with a hybrid interface and clarifying the dev-infra/dev-toolkit boundary.

**Decision Points:** 4 decisions
**Status:** 🔴 Pending

---

## 🎯 Key Decisions

### Decision 1: Tiered Planning Structure

**Decision:** Adopt a tiered structure based on task count:
- **Simple (1-8 tasks):** Single `implementation-plan.md` file.
- **Medium (9-15 tasks):** Single file with `### Group` headings.
- **Complex (16+ tasks):** Hub `implementation-plan.md` + `tasks/[group].md` files.

**Status:** Proposed

**ADR:** [adr-001-tiered-planning-structure.md](adr-001-tiered-planning-structure.md)

---

### Decision 2: Hybrid Task Command Interface

**Decision:** Rename `/task-phase` to `/task` and support three modes:
- **`next`:** Sequential flow (finds first unchecked task).
- **`N`:** Explicit task selection (e.g., `/task 5`).
- **Bare:** Status/list view.

**Status:** Proposed

**ADR:** [adr-002-hybrid-task-command-interface.md](adr-002-hybrid-task-command-interface.md)

---

### Decision 3: Spec-Only Dev-Infra Boundary

**Decision:** Dev-infra owns specifications (templates, validation rules, tier config) but NOT executable scripts for generated projects. Dev-toolkit implements the CLI that consumes these specs.

**Status:** Proposed

**ADR:** [adr-003-spec-only-dev-infra-boundary.md](adr-003-spec-only-dev-infra-boundary.md)

---

### Decision 4: Migration Strategy

**Decision:** Treat as a minor version bump (v0.10.0). Support "new features only" adoption for existing projects (old features keep old structure). Provide a migration guide.

**Status:** Proposed

**ADR:** [adr-004-migration-strategy.md](adr-004-migration-strategy.md)

---

## 📋 Requirements Impact

**Functional Requirements (20 of 25 covered; remaining 5 are implementation tasks):**
- **ADR-001:** FR-1, FR-2, FR-3, FR-12, FR-14, FR-15, FR-16
- **ADR-002:** FR-5, FR-7, FR-8, FR-9, FR-10, FR-11, FR-13
- **ADR-003:** FR-17, FR-18
- **ADR-004:** FR-20, FR-24
- **Implementation only (no decision needed):** FR-4, FR-19, FR-21, FR-22, FR-23, FR-25

**Non-Functional Requirements (9 of 10 covered):**
- **ADR-001:** NFR-1, NFR-2, NFR-6, NFR-7
- **ADR-002:** NFR-5
- **ADR-003:** NFR-8
- **ADR-004:** NFR-3, NFR-9, NFR-10
- **Implementation only:** NFR-4

**Constraints (9 of 10 covered):**
- **ADR-001:** C-6, C-7
- **ADR-002:** C-1, C-5
- **ADR-003:** C-8, C-9
- **ADR-004:** C-2, C-4, C-10
- **Implementation only:** C-3

**Assumptions Validated:** A-1, A-2, A-3, A-4, A-5, A-6, A-7, A-8, A-9 (referenced in ADR context sections)

**See:** [requirements.md](../../research/workflow-simplification/requirements.md) for complete requirements

---

## 🚀 Next Steps

1. Review ADR documents
2. Approve or modify decisions
3. Use `/transition-plan --from-adr` to transition to planning

---

**Last Updated:** 2026-02-19
