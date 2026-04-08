# Design: Agentic Workflow Modernization

**Status:** 🔴 Stub  
**Created:** 2026-04-02  
**Last Updated:** 2026-04-02  
**Prerequisite:** Remaining research (Topics 5-10) + decisions

---

## Inputs

- [ ] Decision ADR(s) -- (pending)
- [ ] Consolidated requirements -- FR-1 through FR-13+ (partially complete; Topics 1-4 done)
- [ ] Exploration constraints -- [exploration.md](../../explorations/agentic-workflow-modernization/exploration.md) Constraints section

---

## 1. System Overview

*Narrative description of the target state from the user's perspective. What does a developer experience on day one with the new system? How do they discover, invoke, and navigate the skill-based workflow?*

> TODO: Fill after decisions are made.

---

## 2. Cross-Cutting Quality Attributes

*Standing NFRs applied to this design. Each must be explicitly addressed.*

- **Usability** -- Can the user discover and invoke skills without memorizing names? Is the naming convention intuitive? Does the `/` menu feel manageable at scale?
- **Shippability** -- Can each stage be released as a coherent, non-broken state? No "half migrated" limbo.
- **Maintainability** -- Is the maintenance burden sustainable? What about template sync at scale?
- **Migration Safety** -- Can users on the old system transition without disruption? Is there a coexistence period?
- **Backward Compatibility** -- What breaks, and is the breakage justified?

> TODO: Assess each attribute against the designed system.

---

## 3. Component Design

*How each major piece works and relates to others. Composes individual requirements into a coherent system.*

### 3.1 AGENTS.md

> TODO: What it contains, target size, what it replaces from current rules.

### 3.2 Slimmed `.mdc` Rules

> TODO: What stays, target size (~100-150 lines), Cursor-specific behavioral config only.

### 3.3 Skill Families

> TODO: Naming convention, family grouping, `assets/` and `references/` usage, how the 26 commands decompose.

### 3.4 Template Sync

> TODO: How sync extends to cover skills, manifest format, drift detection.

### 3.5 Dual Distribution

> TODO: Marketplace vs template path, which skills are team-appropriate.

---

## 4. Interaction Design

*How components interact with each other and with the user.*

> TODO: User journeys -- new project setup, daily workflow, pipeline flow (explore → research → design → transition-plan → task) as skills.

---

## 5. Staging Plan

*How the system gets built incrementally. Each stage must leave the system usable and shippable.*

> TODO: Define stages with clear boundaries, entry/exit criteria, and what the user experience is at each boundary.

---

## 6. Open Questions / Risks

*Things the design acknowledges but doesn't resolve.*

- Pending spikes: skill-decomposition-pattern, conversation-as-orchestration, subagent delegation
- The `/` menu UX at 60-80 skills (no research yet on discoverability)
- `disable-model-invocation` marketplace bug (C-3) -- timeline unknown

---

## 7. NFR Checklist

*Explicit sign-off against each quality attribute from Section 2.*

- [ ] **Usability** -- addressed in: (section ref)
- [ ] **Shippability** -- addressed in: (section ref)
- [ ] **Maintainability** -- addressed in: (section ref)
- [ ] **Migration Safety** -- addressed in: (section ref)
- [ ] **Backward Compatibility** -- addressed in: (section ref)

---

**Last Updated:** 2026-04-02
