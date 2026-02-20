# ADR-002: Hybrid Task Command Interface

**Status:** Proposed
**Created:** 2026-02-19
**Last Updated:** 2026-02-19

---

## Context

The current `/task-phase` command is rigid, requiring a phase number and sequential execution. It doesn't support jumping between tasks easily or checking status without execution. We need a flexible interface that works with the new tiered planning structure and supports both sequential flow and explicit selection.

**Related Research:**
- [Research Summary](../../research/workflow-simplification/research-summary.md)
- [Topic 2: Task Command Interface Design](../../research/workflow-simplification/topic-2-task-command-interface-design.md)

**Related Requirements:**
- [FR-5: Command Renaming](../../research/workflow-simplification/requirements.md)
- [FR-7: Hybrid Task Selection Interface](../../research/workflow-simplification/requirements.md)
- [FR-8: Implementation Plan as Task Source](../../research/workflow-simplification/requirements.md)
- [FR-13: Global Continuous Task Numbering](../../research/workflow-simplification/requirements.md)
- [C-5: Cursor Has No Command Aliasing](../../research/workflow-simplification/requirements.md)

---

## Decision

We will rename `/task-phase` to `/task` and support a **hybrid interface** with three modes:

1.  **`next`:** Sequential flow. Finds the first unchecked task in the implementation plan and executes it.
2.  **`N`:** Explicit selection. Executes task number `N` (e.g., `/task 5`).
3.  **Bare (`/task`):** Status/list view. Shows the implementation plan with checkboxes, current progress, and next steps.

**Mechanism:**
-   `/task` reads the `implementation-plan.md` (and its frontmatter blueprint) to find tasks.
-   Tasks are numbered globally (1 to N) across groups/files to ensure unambiguous reference.
-   Backward compatibility is provided via a `task-phase.md` stub file that points users to `/task`.

**Naming Conventions:**
-   Branch names drop phase numbers: `feat/[feature]-[desc]` (not `feat/[feature]-phase-N-[desc]`).
-   Commit scopes use feature/component names: `feat(auth): ...` (not `feat(phase-3): ...`).

---

## Consequences

### Positive
-   **Flexibility:** Users can choose their workflow (sequential vs. random access).
-   **Simplicity:** One command (`/task`) covers execution and status.
-   **Clarity:** Global numbering removes ambiguity ("Task 5" is always Task 5).
-   **Alignment:** Matches industry patterns (Taskwarrior, Taskfile).

### Negative
-   **Migration:** Users accustomed to `/task-phase` must learn the new name.
-   **Stub Maintenance:** Deprecation stubs add clutter until removed in v1.0.

---

## Alternatives Considered

### Alternative 1: Keep `/task-phase`
**Description:** Modify existing command to support new features.
**Pros:** No rename friction.
**Cons:** Name "phase" is misleading in a tiered structure where phases are optional/gone.
**Why not chosen:** Violates FR-5 (Renaming) and the goal of simplification.

### Alternative 2: Separate Commands
**Description:** `/task-next`, `/task-do N`, `/task-list`.
**Pros:** Explicit intent.
**Cons:** Command bloat. Harder to discover.
**Why not chosen:** Violates the principle of a unified interface.

---

## Decision Rationale

The hybrid interface is the standard pattern for task runners. It accommodates both "flow state" (just give me the next thing) and "control freak" (I want to do specifically this thing) workflows. Renaming to `/task` removes the "phase" baggage and aligns with the simplified mental model.

**Key Factors:**
-   **Usability:** Reducing cognitive load.
-   **Flexibility:** Supporting diverse workflows.
-   **Semantics:** "Task" is the unit of work, not "Phase".

---

## Requirements Impact

**Requirements Fulfilled:**
-   FR-5 (Command Renaming) - Fulfilled. `/task-phase` renamed to `/task`, `/pre-phase-review` renamed to `/plan-review`.
-   FR-7 (Hybrid Task Selection Interface) - Fulfilled. `next`/`N`/bare modes.
-   FR-8 (Implementation Plan as Task Source) - Fulfilled. `/task` reads from `implementation-plan.md`.
-   FR-9 (Deprecation Stubs for Renamed Commands) - Fulfilled. Stub files point users to new command names.
-   FR-10 (Simplified Branch Naming) - Fulfilled. Phase numbers dropped from branch names.
-   FR-11 (Simplified Commit Scope) - Fulfilled. Feature/component scope replaces phase scope.
-   FR-13 (Global Continuous Task Numbering) - Fulfilled. Tasks numbered 1 to N across all groups.
-   NFR-5 (75% of `/task-phase` Logic Is Reusable) - Validated. TDD workflow, task grouping, and commit strategy carry forward unchanged.

**Constraints Acknowledged:**
-   C-1 (Hard Phase Dependencies in Commands) - 9 commands have hard dependencies on phase files; `/task` is the hub command and must be refactored first to unlock the others.
-   C-5 (Cursor Has No Command Aliasing) - Addressed via physical stub files for backward compatibility.

---

## References

- [Topic 2: Task Command Interface Design](../../research/workflow-simplification/topic-2-task-command-interface-design.md)

---

**Last Updated:** 2026-02-19
