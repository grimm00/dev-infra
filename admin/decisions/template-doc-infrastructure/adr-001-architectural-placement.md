# ADR-001: Architectural Placement (Four-Arm Question)

**Status:** 🔴 Proposed  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 1 (Foundation)

---

## Context

Template documentation infrastructure requires multiple components: templates, generation scripts, validation scripts, and command integration. The question is where these components should live within the four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod).

**Related Research:**
- [Research: Architectural Placement](../../research/template-doc-infrastructure/research-architectural-placement.md)
- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - Finding 7

**Related Requirements:**
- FR-15: Templates must reside in dev-infra
- FR-16: Tooling must reside in dev-toolkit
- FR-17: Tooling must fetch templates from dev-infra
- FR-18: Tooling must follow dt-* naming convention
- NFR-9: Independent versioning for templates and tooling
- NFR-10: Tooling must be compatible with templates from dev-infra
- C-7: Scripts generate structure, AI fills content
- C-8: No template duplication across repos
- C-9: No orchestration logic in dev-infra

---

## Decision

<!-- FILL: State the decision clearly -->

**Decision:** [To be filled]

---

## Consequences

### Positive

<!-- FILL: List positive consequences -->

- [Positive consequence 1]
- [Positive consequence 2]

### Negative

<!-- FILL: List negative consequences -->

- [Negative consequence 1]
- [Negative consequence 2]

---

## Alternatives Considered

### Alternative 1: Everything in dev-infra

**Description:** Keep all template infrastructure (templates + tooling) in dev-infra.

**Pros:**
- Simpler architecture (one repo)
- No cross-repo coordination needed
- Atomic changes to templates and tooling

**Cons:**
- Violates ADR-001 (Project Identity): "Internal tooling stays internal"
- Makes dev-infra bloated with non-template concerns
- Conflicts with dt-* naming convention

**Why not chosen:** [To be filled]

---

### Alternative 2: Everything in dev-toolkit

**Description:** Keep all template infrastructure (templates + tooling) in dev-toolkit.

**Pros:**
- Follows dt-* convention
- Keeps tooling together
- Simpler distribution

**Cons:**
- Violates dev-infra's "Template Factory" identity
- Templates are not tooling
- Breaks source-of-truth pattern for templates

**Why not chosen:** [To be filled]

---

### Alternative 3: Split (templates in dev-infra, tooling in dev-toolkit)

**Description:** Templates in dev-infra (source), tooling in dev-toolkit (distribution).

**Pros:**
- Follows existing precedents (ADR-001, dt-review)
- Clear ownership: dev-infra owns templates, dev-toolkit owns tooling
- Independent versioning possible

**Cons:**
- Cross-repo coordination needed
- Template fetching required

**Why not chosen:** [Or: Why chosen - to be filled]

---

## Decision Rationale

<!-- FILL: Explain why this decision was made -->

**Key Factors:**
- [Factor 1]
- [Factor 2]

**Research Support:**
- Finding 7: Four-Arm Placement Decision
- Precedent: dt-review pattern
- Precedent: ADR-001 (Project Identity)

---

## Requirements Impact

<!-- FILL: Document requirements affected -->

**Requirements Addressed:**
- FR-15 through FR-18 (architectural placement)
- NFR-9, NFR-10 (versioning, compatibility)
- C-7 through C-9 (separation of concerns)

---

## References

- [Research: Architectural Placement](../../research/template-doc-infrastructure/research-architectural-placement.md)
- [dev-infra ADR-001: Project Identity](../../dev-infra-identity-and-focus/adr-001-project-identity.md)
- [four-arm-architecture ADR-001: Command Distribution](../../four-arm-architecture/adr-001-command-distribution-ownership.md)

---

**Last Updated:** 2026-01-14
