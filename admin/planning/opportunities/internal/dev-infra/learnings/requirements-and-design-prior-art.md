# Prior Art: Requirements and Design Document Criteria

**Project:** Dev-Infra
**Topic:** Team engineering practices that informed the design step discovery
**Date:** 2026-04-02
**Status:** ✅ Complete
**Last Updated:** 2026-04-02

---

## Overview

During the agentic-workflow-modernization exploration, a `/discuss` session identified a gap in dev-infra's pipeline: the absence of a holistic design step between decisions and implementation planning. This gap was captured as an internal improvement (`design-step-in-pipeline.md`) and a design document stub was created.

After identifying this gap independently, a connection surfaced to a team proposal encountered early in the apprenticeship: a formal set of criteria for when Platform Engineering projects require requirements and design documents. The proposal was written by senior engineers on the team (not the author of this document) and was shared as a learning resource to illustrate the thought process behind engineering rigor.

The alignment between the team's proposal and what dev-infra discovered independently validates that the same principles apply at different scales -- from multi-team infrastructure projects to single-developer template factory workflows.

---

## What the Proposal Covers

The team proposal (internal, `go/pe-req-design-proposal`, September 2024) defines requirements documents and design documents as **logically separate** concerns:

**Requirements document:** Scope, objectives, functional and non-functional requirements, stakeholder identification, acceptance criteria. Describes *what* the project must achieve and the constraints it operates under.

**Design document:** Architectural design, detailed component specs, estimates, trade-offs and alternatives, diagrams, dependencies, milestones with value indication, and a support plan. Translates requirements into a technical blueprint. The proposal notes designs must balance being "detailed enough to enable execution and mitigate risks while not being overly prescriptive."

**Criteria for when these are needed:**
- Multi-team involvement or stakeholders outside the immediate team
- New technologies or significant architectural changes
- High interdependencies between components
- High-risk (technical, operational, or business)
- Multiple phases with distinct deliverables
- More than one week of effort

**Heuristics for quality:**
- Clarity, completeness, consistency, traceability, feasibility
- Estimates (time and resource)
- Trade-offs and alternatives analysis
- Production-readiness considerations (hosting, deployment, security, monitoring)

---

## Mapping to Dev-Infra's Pipeline

| Proposal Concept | Dev-Infra Equivalent | Status |
|------------------|---------------------|--------|
| Requirements document | `/research` findings + `requirements.md` (FRs, NFRs, constraints) | Exists |
| Design document | `admin/designs/[topic]/design.md` | Newly created (stub) |
| Criteria for when needed | Not yet formalized | Gap -- the int-opp captures the need but no criteria defined |
| Stakeholder approvals | PR review workflow | Exists (lighter weight) |
| Milestones with value | Design stub Section 5 (staging plan) | Stub only |
| Support plan | Not in design stub | Gap -- relevant for template-distributed artifacts |
| Heuristics for quality | Design stub Section 2 (quality attributes) + Section 7 (NFR checklist) | Stub only |

---

## What Dev-Infra Can Adopt

### 1. Criteria Table for the Design Step

The proposal's criteria for when formal artifacts are needed can directly inform when dev-infra features require a design step vs going straight from decision to transition-plan. Adapted for dev-infra's scale:

| Criterion | Proposal Version | Dev-Infra Adaptation |
|-----------|-----------------|---------------------|
| Multi-team | Multiple teams involved | Feature affects both templates and dev-infra internal tooling |
| New technology | Introduces new tech or significant changes | Introduces a new artifact layer or distribution channel |
| Architectural change | Significant architectural modifications | Changes the pipeline structure or skill/command model |
| High interdependency | Components tightly coupled | Multiple research topics with cross-references |
| Multiple phases | Distinct deliverables per phase | Needs staging where intermediate states must be coherent |
| Effort threshold | More than one week | More than 3 research topics or 10+ requirements |

### 2. "Milestones with Value" Framing

The proposal says milestones should indicate "the value provided at each stage." Dev-infra's staging plan (Section 5 of the design stub) currently asks "is the system coherent at each boundary?" The proposal adds: "what value does the user get at each boundary?" This is a stronger framing -- coherence is the floor, value is the bar.

### 3. Support Plan Section

The proposal includes post-completion support planning: operational support, backlog management, training, communication plans for impacted users. Dev-infra's design stub doesn't have this. For features that change how templates work (like the agentic-workflow-modernization migration), a support/transition section would be valuable.

### 4. Trade-offs and Alternatives as a Required Section

The proposal calls out trade-offs and alternatives as both a design document component and a quality heuristic. Dev-infra captures alternatives in ADRs (the decision step), but the design document could include a "design alternatives considered" section that addresses *how* alternatives (not just *what* alternatives) -- e.g., "we considered staging as 2 phases vs 4 phases; here's why 3 is the right balance."

---

## What Dev-Infra Already Has That the Proposal Doesn't

- **Agentic context:** Artifacts serve as agent interface contracts, not just human documentation. Structural schemas and the NFR checklist are accountability mechanisms for workflows where there's no design review meeting.
- **Pipeline position:** The proposal describes *when* to create artifacts but not *where* they sit in a workflow sequence. Dev-infra's contribution is the ordered pipeline with clear I/O between steps.
- **Staging as coherence constraint:** The proposal mentions milestones; dev-infra elevates staging to a first-class design concern where intermediate system states must be independently usable.
- **Cross-cutting quality attributes as a checklist:** The proposal lists heuristics as prose guidance. Dev-infra's Section 7 (NFR checklist) turns them into explicit sign-off items.

---

## Apprenticeship Connection

This proposal was encountered during the early apprenticeship period as an example of how senior engineers think about project scoping and rigor. The key lesson: requirements and design are *separate disciplines* even when they appear in one document. Requirements say what; design says how. Conflating them produces documents that try to do both and do neither well.

The fact that this principle resurfaced independently during dev-infra's agentic-workflow-modernization work -- without consciously referencing the proposal -- suggests the concept was internalized effectively. The pipeline gap was felt as a practitioner pain point ("the scoping seems random, NFRs aren't systematic") before the connection to the proposal was made.

---

## Related Documents

- [Design Step in Pipeline (int-opp)](../improvements/design-step-in-pipeline.md) -- The improvement opportunity that identified the gap
- [Design Stub](../../../../designs/agentic-workflow-modernization/design.md) -- The 7-section design document template
- [Agentic Workflow Modernization Narrative](../../../../narratives/agentic-workflow-modernization/narrative.md) -- Act 6 captures the discovery

---

**Last Updated:** 2026-04-02
