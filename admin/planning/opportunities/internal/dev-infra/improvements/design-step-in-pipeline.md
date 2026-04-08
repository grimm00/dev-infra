# Design Step in Pipeline

**Source:** /discuss session -- agentic-workflow-modernization (2026-04-02)  
**Target:** dev-infra workflow pipeline (all templates)  
**Status:** 🔴 Not Started  
**Priority:** HIGH  
**Effort:** MEDIUM (command design + artifact template)  
**Created:** 2026-04-02  
**Last Updated:** 2026-04-02

---

## Problem Statement

The current workflow pipeline has a gap between decision and transition-plan:

```
/explore → /research → /decision → /transition-plan → /task
```

Research produces individual findings and requirements (FR-1, FR-2, ...) per topic. Decision commits to an approach. Transition-plan decomposes into implementation tasks. But nothing answers: **"How should this all work as a coherent system, and in what order do we build it so the system is usable at every intermediate step?"**

This gap causes two problems:

1. **No holistic design** -- Requirements are discovered per-topic and remain a flat list. Nobody composes them into a designed user experience. Transition-plan inherits disconnected requirements and must implicitly do design work while also decomposing tasks.

2. **No staging discipline** -- Large features need multiple stages where the system is shippable and coherent at each boundary. Research doesn't answer staging. Decision doesn't answer staging. Transition-plan creates task groups within a stage but doesn't decide *what* the stages are.

**Evidence:** The agentic-workflow-modernization feature has 10 themes, 11 research topics, 13+ functional requirements, and multiple pending spikes. There is no artifact that describes how the four-layer model works as a coherent system, what the user experience is, or how to build it incrementally.

---

## Proposed Solution

Add a `/design` step between `/decision` and `/transition-plan`:

```
/explore → /research → /decision → /design → /transition-plan → /task
```

### What `/design` Produces

A design document with these sections:

1. **System Overview** -- Narrative description of the target state from the user's perspective
2. **Cross-Cutting Quality Attributes** -- Standing NFRs applied to this design (usability, shippability, maintainability, migration safety, backward compatibility)
3. **Component Design** -- How each major piece works and relates to others (composes individual requirements into a coherent system)
4. **Interaction Design** -- How components interact with each other and with the user
5. **Staging Plan** -- How the system gets built incrementally, with each stage leaving the system usable and shippable
6. **Open Questions / Risks** -- Things the design acknowledges but doesn't resolve
7. **NFR Checklist** -- Explicit sign-off against each quality attribute

### I/O Changes

| Command | Current Input | Proposed Input |
|---------|--------------|----------------|
| `/decision` | Research findings + requirements | (unchanged) |
| `/design` | (NEW) | Decision ADR(s) + consolidated requirements + exploration constraints |
| `/transition-plan` | Decision ADR(s) | Design document (tasks decompose *within* designed stages) |

### Cross-Cutting NFRs

A key insight: some quality attributes (usability, shippability, maintainability) are not feature-specific research findings -- they're design constraints that apply to every feature. The `/design` command should reference a standing set of quality attributes and ensure the design addresses each one.

Options:
- **Standing NFRs document** -- Persistent, evolvable, referenced by `/design`
- **Embedded in command** -- Checklist in the command itself

---

## Artifact Location

Design documents live in `admin/designs/[topic]/`:

```
admin/
├── explorations/[topic]/    ← exploration phase
├── research/[topic]/        ← research phase
├── decisions/[topic]/       ← decision phase (ADRs)
├── designs/[topic]/         ← design phase (NEW)
```

This mirrors the pipeline: each phase gets its own top-level directory, topic name is the thread.

Not every feature needs a design step. Simple features can go directly from decision to transition-plan. The design step is for features complex enough that transition-planning without a holistic design would produce incoherent results.

---

## Related

- [agentic-workflow-modernization design stub](../../../../designs/agentic-workflow-modernization/design.md) -- First use of this pattern
- `/transition-plan` command -- Downstream consumer of design documents
- `/decision` command -- Upstream producer of design inputs

---

**Last Updated:** 2026-04-02
