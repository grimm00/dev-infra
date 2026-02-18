# Research Topics - Workflow Simplification

**Status:** ✅ Expanded
**Created:** 2026-02-13
**Expanded:** 2026-02-13

---

## 📋 Research Topics

### Topic 1: Feature Plan Structure Usage

**Status:** ✅ Complete ([View Research](../../research/workflow-simplification/topic-1-feature-plan-usage.md))

**Question:** How are feature plan structures actually used across projects, and what would be lost by flattening them?

**Context:** The current structure produces 3-5+ files per feature (`feature-plan.md`, `phase-N.md`, `status-and-next-steps.md`). With 1 PR per feature (draft PR workflow), phase documents are no longer PR boundaries. Understanding actual usage patterns will reveal which documents are genuinely referenced during and after implementation vs. which exist as ceremony.

**Priority:** High

**Rationale:** This is the foundation question. If feature plan structures are heavily used, simplification needs to preserve their value. If they're mostly write-once-read-never, simplification is straightforward.

**Suggested Approach:**
- Review completed features in dev-infra (command simplification, worktree workflow, release readiness)
- Check git log for how often phase documents are read vs. written after creation
- Interview usage: which documents did the developer actually consult during implementation?
- Compare with helm-charts and dev-toolkit usage patterns (if available)

---

### Topic 2: Task Command Interface Design

**Status:** ✅ Complete ([View Research](../../research/workflow-simplification/topic-2-task-command-interface-design.md))

**Question:** What interface would `/task` need to replace `/task-phase` while remaining useful for both simple and complex features?

**Context:** `/task-phase 3 2` is verbose and implies a rigid hierarchy. But the command does more than just identify a task -- it enforces TDD workflow, manages commit strategy, and tracks progress. A simplified interface needs to preserve these behaviors while reducing the naming friction.

**Priority:** High

**Rationale:** This is the highest-touch change (affects all templates, all commands that reference `/task-phase`, and the user's muscle memory). Getting the interface right is critical -- a bad rename is worse than no rename.

**Suggested Approach:**
- Analyze `/task-phase` command internals: what depends on the "phase" concept vs. what's task-generic?
- Prototype 2-3 interface options against real features (dev-infra's command simplification feature)
- Survey: does `/task next` lose important context vs. `/task 7`?
- Check if backward compatibility (`/task-phase` as alias) is feasible in Cursor commands

---

### Topic 3: Transition Plan Output Format

**Status:** ✅ Complete ([View Research](../../research/workflow-simplification/topic-3-transition-plan-output-format.md))

**Question:** Can the transition plan produce an ordered work breakdown (flat list) instead of a phase hierarchy, and what does that template look like?

**Context:** The transition plan currently produces `feature-plan.md` + `phase-N.md` files. If the hierarchy flattens (Theme 2), the transition plan should produce a single document with an ordered task list. This document becomes the single planning artifact between `/decision` and `/task`.

**Priority:** Medium

**Rationale:** This is a design question that depends on Topics 1 and 2. Once we know what's lost by flattening (Topic 1) and what the task command needs (Topic 2), the transition plan format follows naturally.

**Suggested Approach:**
- Design 2-3 candidate formats (checkbox list, numbered tasks with optional grouping, table format)
- Test each format against a small feature (3-5 tasks) and a large feature (10-15 tasks)
- Determine if optional grouping (sections/headings) feels natural within a flat document
- Prototype how `/task` would parse and update progress in each format

---

### Topic 4: Template Impact Assessment

**Status:** ✅ Complete ([View Research](../../research/workflow-simplification/topic-4-template-impact-assessment.md))

**Question:** How would workflow simplification affect the standard-project and learning-project templates, and is it a breaking change for existing projects?

**Context:** Templates are the product. Changes to the planning structure directly affect every project generated from these templates. The learning-project template has additional complexity (stage-based progression) that may interact differently with a flat work breakdown.

**Priority:** Medium

**Rationale:** This is downstream of the other decisions but critical for implementation planning. Understanding the blast radius helps prioritize and sequence the changes.

**Suggested Approach:**
- Map current template planning structure (files, commands, references)
- Identify which files would be removed, renamed, or restructured
- Assess learning-project specific concerns (stages vs. flat tasks)
- Define "breaking change" criteria: what would require existing projects to change?
- Propose migration guidance or backward compatibility strategy

---

### Topic 5: Command Dependency Analysis

**Status:** ✅ Complete ([View Research](../../research/workflow-simplification/topic-5-command-dependency-analysis.md))

**Question:** Which commands reference phase concepts, and what's the refactoring scope?

**Context:** Multiple commands reference phase documents, phase numbers, and the phase concept: `/task-phase`, `/pr --phase`, `/post-pr --phase`, `/pr-validation`, and likely others. Understanding the full dependency graph is essential for scoping the refactor.

**Priority:** High

**Rationale:** This determines whether simplification is a focused change (just `/task-phase` and `/transition-plan`) or a broad refactor (touching 10+ commands). The scope directly affects feasibility and timeline.

**Suggested Approach:**
- Search all commands (`.cursor/commands/*.md`) for "phase" references
- Search rules files (`.cursor/rules/*.mdc`) for phase references
- Categorize: hard dependency (command breaks without phases) vs. soft reference (documentation mention)
- Map the refactoring scope: which commands need changes, which just need doc updates?

---

## 🎯 Research Workflow

1. Start with **Topic 5** (Command Dependency Analysis) to understand scope
2. Then **Topic 1** (Feature Plan Structure Usage) to understand value
3. Then **Topic 2** (Task Command Interface Design) to design the replacement
4. Then **Topic 3** (Transition Plan Output Format) which follows from 1+2
5. Finally **Topic 4** (Template Impact Assessment) for implementation planning

**Use:** `/research workflow-simplification --from-explore workflow-simplification` to start research.

---

**Last Updated:** 2026-02-13
