# ADR-003: Spec-Only Dev-Infra Boundary

**Status:** Proposed
**Created:** 2026-02-19
**Last Updated:** 2026-02-19

---

## Context

We need to define the boundary between `dev-infra` (this repository) and `dev-toolkit` (the CLI tool that consumes it). Specifically, who owns the logic for determining the tier structure (simple/medium/complex) and scaffolding the files? Should dev-infra ship a script (`scaffold-feature.sh`) to generated projects, or just provide the specification?

**Related Research:**
- [Research Summary](../../research/workflow-simplification/research-summary.md)
- [Topic 6: Dev-Infra Code Boundary](../../research/workflow-simplification/topic-6-dev-infra-code-boundary.md)

**Related Requirements:**
- [FR-17: Tier Specification as Single Source of Truth](../../research/workflow-simplification/requirements.md)
- [FR-18: Replace Planning Doc-Gen Templates](../../research/workflow-simplification/requirements.md)
- [NFR-8: Tier Specification Consumable by Both IDE and CLI](../../research/workflow-simplification/requirements.md)
- [C-8: Doc-Gen Template Replacement Is a Breaking Change](../../research/workflow-simplification/requirements.md)
- [C-9: Dev-Infra Templates Are the Single Source of Truth](../../research/workflow-simplification/requirements.md)

---

## Decision

**Dev-infra owns specifications only.** It defines the templates, validation rules (`planning.yaml`), and tier configuration (`tier-config.yaml` or similar). It explicitly **DOES NOT** ship executable scripts (like `scaffold-feature.sh`) to generated projects.

**Dev-toolkit owns implementation.** It consumes the dev-infra specs to implement the CLI (`dt scaffold feature`, `dt doc-gen`).

**Mechanism:**
-   Dev-infra publishes a machine-readable tier configuration (thresholds, file structures, template mappings).
-   Cursor commands read this config to simulate the logic for AI agents.
-   Dev-toolkit reads this config to execute the logic for humans.

---

## Consequences

### Positive
-   **Clean Separation:** Clear ownership boundary. Prevents "script creep" in generated projects.
-   **Single Source of Truth:** Logic is defined once (in config), implemented twice (AI prompt vs. CLI binary) but consistent.
-   **Maintainability:** Updating tier thresholds is a config change, not a code change distributed to thousands of repos.

### Negative
-   **Duplication of Logic:** AI prompts (Cursor commands) and CLI (dev-toolkit) must both implement the logic defined in the config.
-   **Gap Period:** Until dev-toolkit implements the logic, users rely solely on AI agents (which is acceptable per A-9).

---

## Alternatives Considered

### Alternative 1: Ship Scaffolding Script
**Description:** Include `scripts/scaffold-feature.sh` in the template.
**Pros:** Immediate availability for users without AI.
**Cons:** Bloats generated projects. Hard to update once ejected. Violates "template factory" identity.
**Why not chosen:** Violates ADR-001 (Project Identity).

### Alternative 2: Hardcode Logic in Commands
**Description:** Embed tier thresholds directly in `.cursor/commands/transition-plan.md`.
**Pros:** Simple for AI.
**Cons:** Drifts from dev-toolkit implementation. No single source of truth.
**Why not chosen:** Violates FR-17 (Single Source of Truth).

---

## Decision Rationale

The "template factory" identity dictates that we produce artifacts (templates, specs), not tooling. Shipping scripts to generated projects creates a maintenance burden and blurs the line between infrastructure and application. Defining the logic as data (configuration) allows both AI and CLI to consume it consistently.

**Key Factors:**
-   **Identity:** Adhering to ADR-001.
-   **Consistency:** Ensuring AI and CLI behave identically.
-   **Maintainability:** Centralizing logic definition.

---

## Requirements Impact

**Requirements Affected:**
-   FR-17 (Spec Source) - Fulfilled.
-   FR-18 (Template Replacement) - Fulfilled.
-   NFR-8 (Consumable Spec) - Fulfilled.
-   C-8 (Breaking Change) - Acknowledged.
-   C-9 (Single Source) - Fulfilled.

---

## References

- [Topic 6: Dev-Infra Code Boundary](../../research/workflow-simplification/topic-6-dev-infra-code-boundary.md)

---

**Last Updated:** 2026-02-19
