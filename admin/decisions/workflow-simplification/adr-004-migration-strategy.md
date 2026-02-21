# ADR-004: Migration Strategy

**Status:** Proposed
**Created:** 2026-02-19
**Last Updated:** 2026-02-19

---

## Context

The new tiered planning structure is a breaking change for existing projects generated from dev-infra templates. These projects have `feature-plan.md` and `phase-N.md` files. We need a strategy that allows them to adopt the new structure for new features without breaking existing ones or requiring massive manual migration.

**Related Research:**
- [Research Summary](../../research/workflow-simplification/research-summary.md)
- [Topic 4: Template Impact Assessment](../../research/workflow-simplification/topic-4-template-impact-assessment.md)

**Related Requirements:**
- [FR-20: Migration Guide for Existing Projects](../../research/workflow-simplification/requirements.md)
- [FR-24: Validation Rule Migration](../../research/workflow-simplification/requirements.md)
- [NFR-3: Phased Deprecation Approach](../../research/workflow-simplification/requirements.md)
- [NFR-9: Atomic Template Updates](../../research/workflow-simplification/requirements.md)
- [C-2: Existing Projects Need Migration Path](../../research/workflow-simplification/requirements.md)
- [C-10: In-Progress Features Coexist with New Structure](../../research/workflow-simplification/requirements.md)

---

## Decision

We will treat this as a **minor version bump (v0.10.0)** and support a **"new features only" adoption strategy**.

**Strategy:**
1.  **New Features:** Use the new tiered structure (`implementation-plan.md`).
2.  **Existing Features:** Keep the old structure (`phase-N.md`).
3.  **Commands:** Updated to handle both structures (detects which one is present).
4.  **Validation Rules:** Updated to accept both `phase` and `implementation_plan` document types during the transition period.
5.  **Documentation:** Ship a migration guide (`docs/MIGRATION-v0.10.md`) explaining the changes.

**Concurrent Scope:**
-   Deferred tasks 56 (centralize detection rules for docs-only vs code-phase) and 57 (temp directory path conventions) will be addressed as part of this feature to avoid duplicate refactoring effort across the same command files.

---

## Consequences

### Positive
-   **Low Friction:** Users don't have to migrate historical data.
-   **Safety:** Existing features continue to work.
-   **Clarity:** Clear distinction between "legacy" and "modern" features.

### Negative
-   **Complexity:** Tooling must support two code paths for an indefinite period.
-   **Inconsistency:** Projects will have mixed structures until old features are completed/archived.

---

## Alternatives Considered

### Alternative 1: Hard Break (Major Version)
**Description:** Require full migration of all features to the new structure.
**Pros:** Clean codebase immediately.
**Cons:** Huge burden on users. High risk of data loss or frustration.
**Why not chosen:** Violates C-2 (Migration Path) and user trust.

### Alternative 2: Parallel Templates
**Description:** Maintain `v0.9` and `v0.10` templates separately.
**Pros:** Isolation.
**Cons:** Maintenance nightmare. Divergent evolution.
**Why not chosen:** Violates NFR-9 (Atomic Updates).

---

## Decision Rationale

The "new features only" approach is the standard pattern for infrastructure migrations. It respects the user's existing investment while enabling progress. The cost of supporting dual paths in tooling is outweighed by the benefit of a smooth user experience.

**Key Factors:**
-   **User Trust:** Avoiding "flag days."
-   **Adoption:** Lower barrier to upgrading.
-   **Reality:** Most projects have a mix of active and completed work.

---

## Requirements Impact

**Requirements Fulfilled:**
-   FR-20 (Migration Guide for Existing Projects) - Fulfilled. `docs/MIGRATION-v0.10.md` ships with the release.
-   FR-24 (Validation Rule Migration) - Fulfilled. Both old and new document types accepted during transition.
-   NFR-3 (Phased Deprecation Approach) - Fulfilled. New alongside old, then deprecate, then remove.
-   NFR-9 (Atomic Template Updates) - Fulfilled. Standard-project first, sync to learning-project via manifest.
-   NFR-10 (Zero Learning-Project Regressions) - Fulfilled. Stage-based structure is orthogonal to planning changes; regression testing required.

**Constraints Acknowledged:**
-   C-2 (Existing Projects Need Migration Path) - Fulfilled. "New features only" adoption; old features keep old structure.
-   C-4 (Deferred Tasks 56/57 Concurrent) - Addressed. Included in scope to avoid duplicate refactoring.
-   C-10 (In-Progress Features Coexist) - Fulfilled. Commands detect which structure is present and handle both gracefully.

---

## References

- [Topic 4: Template Impact Assessment](../../research/workflow-simplification/topic-4-template-impact-assessment.md)

---

**Last Updated:** 2026-02-19
