# ADR-001: Tiered Planning Structure

**Status:** Proposed
**Created:** 2026-02-19
**Last Updated:** 2026-02-19

---

## Context

The current planning structure (`feature-plan.md` + multiple `phase-N.md` files) is too heavy for small features (3-5 tasks) and too fragmented for the new 1-PR-per-feature workflow. Phase files become "write-once" artifacts that drift from reality, while `status-and-next-steps.md` is actively maintained. We need a structure that scales down for simple features and up for complex ones without imposing unnecessary overhead.

**Related Research:**
- [Research Summary](../../research/workflow-simplification/research-summary.md)
- [Topic 1: Feature Plan Usage](../../research/workflow-simplification/topic-1-feature-plan-usage.md)
- [Topic 3: Transition Plan Output Format](../../research/workflow-simplification/topic-3-transition-plan-output-format.md)

**Related Requirements:**
- [FR-1: Tiered Planning Document Per Feature](../../research/workflow-simplification/requirements.md)
- [FR-12: Tiered Implementation Plan Structure](../../research/workflow-simplification/requirements.md)
- [NFR-1: Scale from Simple to Complex Features](../../research/workflow-simplification/requirements.md)
- [NFR-7: AI Context Efficiency](../../research/workflow-simplification/requirements.md)

---

## Decision

We will adopt a **tiered planning structure** based on task count, consolidated into a single `implementation-plan.md` entry point (plus `status-and-next-steps.md` for runtime tracking).

**Tiers:**
1.  **Simple (1-8 tasks):** Single `implementation-plan.md` file containing all tasks.
2.  **Medium (9-15 tasks):** Single `implementation-plan.md` file with `### Group Name` headings for logical grouping.
3.  **Complex (16+ tasks):** Hub `implementation-plan.md` (index) + `tasks/[group].md` files (details).

**Mechanism:**
-   `/transition-plan` automatically determines the tier based on task count from the ADR/requirements.
-   `implementation-plan.md` contains YAML frontmatter (the "blueprint") declaring the tier and structure, which `/task` reads to understand how to parse the plan.

---

## Consequences

### Positive
-   **Reduced Overhead:** Small features have 1 planning file instead of 4-5.
-   **Scalability:** Complex features still have breakdown to manage context window and progressive disclosure.
-   **AI Efficiency:** AI agents read only what's needed (single file for small, specific group file for large).
-   **Flexibility:** Groups are optional context, not rigid architectural boundaries.

### Negative
-   **Complexity in Tooling:** Commands (`/task`, `/transition-plan`) must handle three different structural layouts.
-   **Migration:** Existing projects with `phase-N.md` files will have a different structure than new features.

---

## Alternatives Considered

### Alternative 1: Flat List for All Features
**Description:** Always use a single `implementation-plan.md` regardless of size.
**Pros:** Maximum simplicity, easiest tooling.
**Cons:** Fails for large features (30+ tasks). Context window waste. Hard for humans to scan.
**Why not chosen:** Violates NFR-1 (Scale) and NFR-7 (AI Context Efficiency).

### Alternative 2: Always Hub-and-Spoke
**Description:** Always use `implementation-plan.md` + `tasks/[group].md`, even for small features.
**Pros:** Consistent structure, easy tooling.
**Cons:** Massive overhead for small features (3 files for 3 tasks).
**Why not chosen:** Violates NFR-2 (Lower Barrier to Entry).

---

## Decision Rationale

The tiered approach balances simplicity and scalability. Research (Topic 3) showed that a single file is optimal for up to ~15 tasks, after which navigation and context management degrade. The "blueprint" metadata pattern allows tooling to handle the complexity, keeping the user experience simple.

**Key Factors:**
-   **Task Count:** The primary driver of complexity.
-   **AI Context:** Minimizing token usage for agentic workflows.
-   **User Experience:** Reducing file hopping for simple tasks.

---

## Requirements Impact

**Requirements Affected:**
-   FR-1 (Tiered Planning) - Fulfilled.
-   FR-12 (Tiered Structure) - Fulfilled.
-   FR-15 (Feature Blueprint) - Fulfilled.
-   NFR-1 (Scale) - Fulfilled.
-   NFR-7 (Context Efficiency) - Fulfilled.

---

## References

- [Topic 3: Transition Plan Output Format](../../research/workflow-simplification/topic-3-transition-plan-output-format.md)

---

**Last Updated:** 2026-02-19
