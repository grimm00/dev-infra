# Foundation & Specs

**Feature:** Workflow Simplification
**Group:** Foundation & Specs
**Status:** ✅ Complete
**Last Updated:** 2026-02-19

---

## 📝 Tasks

- [x] Task 1: Create migration guide (`docs/MIGRATION-v0.10.md`) explaining the new structure and adoption strategy.
  - Covers old vs new layout, "new features only" adoption, command dual-path detection, validation rule changes, YAML frontmatter contract.
  - Fulfills FR-20.

- [x] Task 2: Update validation rules (`scripts/doc-gen/templates/validation-rules/planning.yaml`) to accept `implementation_plan` and `task_group` types.
  - Added `implementation_plan` and `task_group` document types with path patterns, required sections, metadata rules, and content patterns.
  - Marked `feature_plan` and `phase` as deprecated (kept for transition per NFR-3).
  - Updated `status_and_next_steps` to accept both phase-based and group-based progress tables.
  - Fulfills FR-24.

- [x] Task 3: Add planning structure specification to `planning.yaml` defining the uniform structure and `tasks/` directory contract.
  - Added `structure_specification` section: layout, frontmatter contract, task file naming, parsing contract, legacy detection.
  - Co-located with validation rules as single source of truth.
  - Fulfills FR-17 (revised).

---

## 📦 Deliverables

- `docs/MIGRATION-v0.10.md`
- Updated `scripts/doc-gen/templates/validation-rules/planning.yaml`

---

**Last Updated:** 2026-02-19
