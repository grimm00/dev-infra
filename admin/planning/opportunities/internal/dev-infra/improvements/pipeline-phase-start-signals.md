# Pipeline Phases Need Explicit Start Signals and Clear I/O Boundaries

**Source:** /discuss session -- agentic-workflow-modernization (2026-04-10)
**Target:** dev-infra workflow pipeline (all templates)
**Status:** 🔴 Not Started
**Priority:** MEDIUM
**Effort:** MEDIUM (pipeline I/O audit + artifact placement review)
**Created:** 2026-04-10
**Last Updated:** 2026-04-10

---

## Problem Statement

The pipeline steps (explore, research, decision, design, transition-plan, task) don't have explicit "start" signals. You just run the command. There's no artifact that says "this phase has been initiated" or "here's the starting state." This creates two problems:

1. **No phase awareness for session resume.** When resuming after a break (FR-18), there's no quick way to determine which phase you're in. You have to read hub READMEs, check status tables, and reconstruct state from scattered signals.

2. **Unclear I/O boundaries between phases.** Requirements are currently a "research artifact" (`admin/research/[topic]/requirements.md`) but they're consumed by the decision phase. The decision interview was initially placed in the designs directory but belongs in the decisions directory. These placement questions arise because the pipeline doesn't have explicit "this phase produces X and consumes Y" contracts.

---

## Observations

### The "Start" Signal Gap

Each phase has a **completion** signal (consolidation marks research Final, ADRs mark decisions complete, etc.) but no **initiation** signal. Examples of what a start signal could look like:

| Phase | Start Signal | Completion Signal |
|-------|-------------|------------------|
| Explore | `exploration.md` created | All themes documented |
| Research | Hub README + topic scaffolds | `--consolidate` marks Final |
| Decision | **Decision interview filled out** (new) | ADRs written |
| Design | Design document started | Design document complete |
| Transition-plan | Plan generated | Tasks decomposed |

The decision interview is the first example of a "start signal" artifact. It explicitly marks "the decision phase has begun, here's the human's input."

### Requirements: Research Output or Decision Input?

Requirements sit at the boundary between phases:

- **Research extracts them** from findings (they're authored during research)
- **Decisions consume them** as input (they're read during decision-making)
- **Cross-references point backward** to topic documents (source attribution)

Current placement in `admin/research/` preserves the source-attribution links. But conceptually, consolidated requirements are a "handoff artifact" -- the bridge between phases. This is a design question for the pipeline, not a one-off placement decision.

### Broader Pattern: Each Phase Should Declare Its I/O

A phase manifest could look like:

```
Phase: Decision
  Inputs:
    - admin/research/[topic]/requirements.md (Final)
    - admin/decisions/[topic]/decision-interview.md (human priorities)
    - admin/explorations/[topic]/exploration.md (constraints)
  Outputs:
    - admin/decisions/[topic]/adr-NNN-*.md (one per decision cluster)
  Start signal: decision-interview.md exists and is filled out
  Completion signal: all decision clusters have ADRs
```

This would make the pipeline machine-readable and address FR-18 (session resume) naturally -- the agent checks which phases have start/completion signals and reports status.

---

## Connection to Other Int-Opps

- **[design-step-in-pipeline.md](design-step-in-pipeline.md)** -- The design step introduces a new phase that needs I/O boundaries
- **[decision-command-human-involvement.md](decision-command-human-involvement.md)** -- The decision interview is the first "start signal" artifact; this int-opp generalizes the pattern
- **FR-18 (session resume)** -- Phase start signals would make session resume more reliable

---

## Proposed Actions

1. **Keep requirements in research directory** (pragmatic -- links are valuable, placement is conventional)
2. **Adopt the decision interview as the decision phase start signal** (already done)
3. **During the design step**, define I/O boundaries for each pipeline phase as a cross-cutting concern
4. **Consider whether phase manifests should be formal artifacts** or just documented conventions

---

## Related

- [decision-command-human-involvement.md](decision-command-human-involvement.md) -- The interview pattern that prompted this
- [design-step-in-pipeline.md](design-step-in-pipeline.md) -- Adds a new phase to the pipeline
- [requirements.md](../../../../research/agentic-workflow-modernization/requirements.md) -- The artifact that prompted the "where does this belong?" question
- FR-18 in requirements -- Session resume must load current workflow state

---

**Last Updated:** 2026-04-10
