# Exploration: Workflow Simplification

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** 2026-02-13

---

## 🎯 What We're Exploring

The spike workflow integration (spike -> research -> decision loop) and draft PR workflow (1 PR per feature) have exposed that several parts of the current command and planning structure may be over-engineered. Specifically: the feature/phase/task hierarchy, the `/task-phase` command naming, the role of `/decision` (formerly performative, now substantial), and whether the heavyweight feature plan structure still earns its weight.

---

## 🔍 Initial Themes

### Theme 1: Decision Command Value Shift
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

With the spike workflow creating an iterative loop (explore -> spike -> research, repeat as needed), `/decision` now produces a much stronger, less mutable ADR. Previously, decisions were created quickly and revised frequently -- essentially a checkbox before `/transition-plan`. Now they should be high-confidence records backed by spike evidence and thorough research. This changes the role of the decision command from "document a choice" to "crystallize validated knowledge."

### Theme 2: Feature/Phase/Task Hierarchy Weight
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

The current structure (`features/[name]/feature-plan.md`, `phase-1.md`, `phase-2.md`, etc.) was designed when each phase was a separate PR (~3-5 PRs per feature). With the draft PR workflow collapsing this to 1 PR per feature, the phase documents become internal planning artifacts rather than PR boundaries. The question: does a flat list of work items (in the transition plan) replace the need for separate phase documents?

### Theme 3: `/task-phase` Naming and Interface
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

`/task-phase 3 2` (phase 3, task 2) implies a rigid 2-level hierarchy. In practice, after a strong decision + transition plan, you often just need to execute the next chunk of work. A simpler interface like `/task [item]` or `/task next` could reduce friction. The "phase" concept may still be useful for logical grouping but doesn't need to be a first-class command parameter.

### Theme 4: Transition Plan as the New Center of Gravity
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

If decisions become stronger and the feature plan structure gets lighter, the transition plan becomes the critical bridge between "what we decided" and "what we build." It may need to evolve from producing a feature plan + phases into producing a simpler, ordered work breakdown that feeds directly into a `/task` command.

---

## ❓ Key Questions

1. Does the feature plan structure (`feature-plan.md` + `phase-N.md` + `status-and-next-steps.md`) still add value with 1 PR per feature?
2. Should `/task-phase` be renamed/simplified (e.g., `/task next`, `/task [item]`)?
3. What's the minimum planning structure needed between `/decision` and implementation?
4. How does this affect the templates -- do generated projects need the same simplification?
5. Can the transition plan output a flat work breakdown instead of a phase hierarchy?

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| Flatten feature plan structure | MEDIUM | No | Can be researched by reviewing existing usage patterns |
| Rename/simplify `/task-phase` | MEDIUM-HIGH | Consider | Interface change affects all templates and workflow rules |
| Transition plan output format | MEDIUM | No | Design question, not technical uncertainty |
| Impact on generated projects | LOW | No | Follows from whatever we decide for dev-infra |

**Risk framework:** HIGH = spike first (hard to pivot), MEDIUM-HIGH = consider spike, MEDIUM/LOW = research only.

---

## 📊 Exploration Summary

### Themes Analyzed

| Theme | Key Finding |
|-------|-------------|
| Decision command value shift | Spike workflow transforms `/decision` from performative to substantial |
| Feature/phase/task hierarchy | Draft PR workflow makes per-phase documents and PRs unnecessary |
| `/task-phase` naming | Command interface implies rigidity that doesn't match actual workflow |
| Transition plan gravity | Becomes the key artifact between decision and implementation |

### Initial Recommendations

1. Explore simplifying the feature plan structure to a single transition plan with ordered work items
2. Consider renaming `/task-phase` to `/task` with a simpler interface
3. Keep `/decision` as-is but update its documentation to reflect its stronger role in the spike workflow

---

## 🚀 Next Steps

1. Run `/explore workflow-simplification --conduct` to expand this exploration
2. Review how `/task-phase` is actually used across projects (dev-infra, helm-charts, dev-toolkit)
3. Consider whether this should be a dev-toolkit codification effort rather than a dev-infra template change

---

## 🔗 Related

- **[Spike Workflow Framework](../../planning/opportunities/external/dev-toolkit/spike-workflow-framework.md)** - The catalyst for this exploration
- **[Worktree Feature Workflow](../../docs/WORKTREE-WORKFLOW.md)** - Draft PR workflow (1 PR per feature)
- **[ADR-003: Draft PR Workflow](../decisions/worktree-feature-workflow/adr-003-draft-pr-review-workflow.md)** - Decision that reduced PRs per feature
