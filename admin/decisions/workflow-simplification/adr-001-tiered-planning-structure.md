# ADR-001: Uniform Planning Structure

**Status:** Proposed (Amended 2026-02-19)
**Created:** 2026-02-19
**Last Updated:** 2026-02-19

---

## Context

The current planning structure (`feature-plan.md` + multiple `phase-N.md` files) is too heavy for small features and too fragmented for the new 1-PR-per-feature workflow. Phase files become "write-once" artifacts that drift from reality, while `status-and-next-steps.md` is actively maintained. We need a structure that scales naturally without imposing unnecessary overhead.

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

We will adopt a **uniform planning structure** for every feature, replacing `feature-plan.md` + `phase-N.md` with a consistent directory layout:

```
feature-name/
├── implementation-plan.md      # Overview, task index, groups
├── status-and-next-steps.md    # Runtime tracking (proven pattern)
└── tasks/                      # Task details (scales naturally)
    ├── group-1.md              # 1 file per group (or 1 file total)
    └── group-2.md
```

**Key properties:**
-   The structure is **always the same** regardless of feature size. Predictability over optimization.
-   `implementation-plan.md` is the entry point: task index with GFM checkboxes, optional `### Group` headings.
-   `tasks/` is always present. Its contents scale naturally: a 3-task feature has one file; a 30-task feature has several grouped files.
-   `/task` always resolves to the same path pattern: read the plan, find the task in `tasks/`.
-   No tier detection, no blueprint metadata for structure type, no branching logic in commands.

**What changed (Amendment 2026-02-19):**

The original decision proposed three tiers (Simple/Medium/Complex) with different file structures based on task count. Post-decision discussion identified that:
1. The "simple" tier (1-8 tasks, no `tasks/` directory) rarely occurs in practice -- features that go through the planning pipeline consistently produce 8+ tasks.
2. Predictability is more valuable than optimization -- a uniform structure eliminates the meta-decision of "which tier am I?" and the cognitive load of "does this feature have a `tasks/` folder?"
3. The `tasks/` directory is the key structural improvement over phase files -- it provides progressive disclosure (plan = overview, tasks/ = details) for both humans and AI agents.
4. Three tiers means three code paths in every command. One structure means one code path.

---

## Consequences

### Positive
-   **Predictability:** Every feature looks the same. No "which structure is this?" question.
-   **Simplicity in Tooling:** `/task` has one code path, not three. No tier detection needed.
-   **Progressive Disclosure:** `implementation-plan.md` is the overview; `tasks/` has the details. Works for both humans (manageable cognitive load) and AI (efficient context loading).
-   **Scalability:** The `tasks/` directory absorbs complexity without changing the shape. More tasks = more files, same structure.
-   **Command-to-Directory Mapping:** `/task` owns `tasks/`, creating a clean mental model where each command has a "home" directory.

### Negative
-   **Minimal Overhead for Tiny Features:** A 3-task feature still has a `tasks/` directory with one file. This is a trivial cost compared to the predictability benefit.
-   **Migration:** Existing projects with `phase-N.md` files will have a different structure than new features.

---

## Alternatives Considered

### Alternative 1: Flat List (No `tasks/` Directory)
**Description:** Always use a single `implementation-plan.md` with all tasks inline.
**Pros:** Maximum simplicity.
**Cons:** Fails for large features (30+ tasks). Context window waste. No progressive disclosure.
**Why not chosen:** Violates NFR-1 (Scale) and NFR-7 (AI Context Efficiency).

### Alternative 2: Three Tiers (Original Decision)
**Description:** Simple (1-8 tasks, single file), Medium (9-15, single file + groups), Complex (16+, hub + `tasks/` directory).
**Pros:** Minimizes overhead for small features.
**Cons:** Introduces a meta-decision ("which tier?"), three code paths in every command, unpredictable structure across features, and the "simple" tier rarely occurs in practice.
**Why not chosen:** Predictability and tooling simplicity outweigh the marginal overhead of a `tasks/` directory for small features.

### Alternative 3: Always Hub-and-Spoke (Previous Assessment)
**Description:** Same as the chosen approach but was previously rejected as "massive overhead."
**Why reconsidered:** The overhead was overstated. A `tasks/` directory with one file is not "massive overhead" -- it's one extra directory. The consistency benefit was undervalued.

---

## Decision Rationale

Predictability is the primary design driver, not file count optimization. Both human cognitive load and AI context windows share the same constraint: accuracy degrades with volume. A uniform structure with progressive disclosure (plan = overview, `tasks/` = details) serves both audiences consistently.

The `tasks/` directory is the key structural change. It replaces rigid, sequentially-named phase files with flexible, content-named task files. It provides a consistent "home" for the `/task` command, mirroring the pattern where commands map to directories.

**Key Factors:**
-   **Predictability:** Eliminates "which structure?" decisions.
-   **Progressive Disclosure:** Overview + details pattern for humans and AI alike.
-   **Tooling Simplicity:** One code path in every command.
-   **Cognitive Load = Context Windows:** Both converge on the need for manageable, structured information.

---

## Requirements Impact

**Requirements Fulfilled:**
-   FR-1 (Planning Document Per Feature) - Fulfilled. Uniform structure replaces multi-file phase approach.
-   FR-2 (Preserve Status Tracking) - Fulfilled. `status-and-next-steps.md` retained as a separate file.
-   FR-3 (Machine-Parseable Task List) - Fulfilled. GFM checkboxes (`- [ ]` / `- [x]`) in `implementation-plan.md`.
-   FR-14 (Group Headings as Optional Context) - Fulfilled. `### Group Name` headings provide human-readable structure; groups map to files in `tasks/`.
-   NFR-1 (Scale from Simple to Complex) - Fulfilled. `tasks/` directory absorbs complexity.
-   NFR-2 (Lower Barrier to Entry) - Fulfilled. Uniform structure is easier to learn than three tiers.
-   NFR-6 (GitHub-Compatible Rendering) - Fulfilled. GFM checkboxes render natively.
-   NFR-7 (AI Context Efficiency) - Fulfilled. AI reads plan, then only the relevant task file.

**Requirements Revised:**
-   FR-12 (Tiered Structure) - Superseded. Uniform structure replaces three tiers.
-   FR-15 (Feature Blueprint with Tier Metadata) - Simplified. YAML frontmatter still useful for task count and groups, but tier field is removed.
-   FR-16 (Codified Tier Thresholds) - Removed. No tiers, no thresholds.
-   FR-17 (Tier Specification as Single Source of Truth) - Revised. Specification defines the uniform structure and `tasks/` directory contract, not tier logic.

**Constraints Acknowledged:**
-   C-6 (Parsing Contract) - The `- [ ] Task N: Description` checkbox pattern is the contract between `/transition-plan` (producer) and `/task` (consumer).
-   C-7 (Handle Both Structures) - Simplified. `/task` always reads from `tasks/`. Legacy `phase-N.md` detection handled by migration path (ADR-004).

---

## References

- [Topic 3: Transition Plan Output Format](../../research/workflow-simplification/topic-3-transition-plan-output-format.md)

---

**Last Updated:** 2026-02-19
