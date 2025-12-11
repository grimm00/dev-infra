# ADR-001: Project Identity - Template Factory Focus

**Status:** 🟡 Proposed  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## Context

Dev-infra has organically grown to serve multiple purposes:

1. **Laboratory** - Experimenting with workflow automation (commands, scripts)
2. **Factory** - Producing templates for other projects
3. **Reference Implementation** - Using what we build to build it (dogfooding)

This creates complexity:
- Every workflow improvement becomes a multi-phase feature
- Confusion about where work belongs (`features/` vs `ci/` vs internal)
- High maintenance burden (23 commands, extensive documentation)
- Scope creep from treating every idea as needing templatization

**The Core Question:** Should dev-infra be primarily a template factory?

**Related Research:**
- [Research Summary](../../research/dev-infra-identity-and-focus/research-summary.md)
- [Template User Needs](../../research/dev-infra-identity-and-focus/research-template-user-needs.md)
- [Other Projects' Patterns](../../research/dev-infra-identity-and-focus/research-other-projects.md)

**Related Requirements:**
- FR-15: Templates should not include dev-infra internal tooling
- NFR-5: Templates should not grow more complex without clear user need
- NFR-13: Template complexity should be appropriate for user projects

---

## Decision

**Dev-infra's primary identity is "template factory."**

Internal tooling and workflow experimentation are secondary concerns that should not automatically become template features.

### What This Means

1. **Templates are products** - Treated as output, not reflections of dev-infra's internal process
2. **Internal tooling stays internal** - Release automation, validation scripts remain dev-infra-only
3. **Graduation required** - Features must prove themselves before templatization
4. **Quality over quantity** - Fewer, more stable template features

### Practical Implications

| Before (Implicit) | After (Explicit) |
|-------------------|------------------|
| Every improvement → template feature | Improvements require graduation |
| All commands in templates | Essential commands in templates |
| Complex templates | Simpler templates |
| Workflow-centric planning | Template-centric planning |

---

## Consequences

### Positive

- **Clarity** - Clear guidance on what goes in templates
- **Simpler templates** - Users get focused, stable templates
- **Faster iteration** - Internal tooling can evolve without template impact
- **Reduced maintenance** - Fewer template commands to keep in sync
- **Aligned with industry** - Matches patterns from CRA, Vue CLI, Cookiecutter

### Negative

- **Template users don't get everything** - Some powerful features stay internal
- **Two-tier system** - Dev-infra is more capable than templates
- **Potential frustration** - "Why can't templates have X?"
- **Requires discipline** - Must resist templatizing everything

### Neutral

- **Existing natural separation validated** - Release commands already excluded
- **Current templates mostly fine** - Major restructure not needed

---

## Alternatives Considered

### Alternative 1: Status Quo (Multi-Purpose)

**Description:** Continue as laboratory + factory + reference implementation

**Pros:**
- No change needed
- Everything gets templatized eventually
- Dev-infra showcases all capabilities

**Cons:**
- Continued confusion about identity
- Scope creep on every improvement
- Templates grow increasingly complex
- High maintenance burden

**Why not chosen:** Research showed this creates unsustainable complexity

---

### Alternative 2: Pure Laboratory

**Description:** Focus on experimentation, minimal templates

**Pros:**
- Maximum innovation freedom
- Templates stay simple
- Fast iteration

**Cons:**
- Templates become bare-bones
- Users don't benefit from innovations
- Defeats purpose of having templates

**Why not chosen:** Abandons value of providing useful templates

---

### Alternative 3: Full Parity

**Description:** Templates get everything dev-infra has

**Pros:**
- Single standard
- No "two-tier" system
- Users get all features

**Cons:**
- Templates become complex
- All dev-infra-specific tooling in templates
- High maintenance burden
- Users don't need meta-project tooling

**Why not chosen:** Research showed template users have simpler needs

---

## Decision Rationale

**Key Factors:**

1. **Industry Patterns** - All successful template systems (CRA, Vue CLI, Cookiecutter) separate internal tooling from templates

2. **Natural Separation Validated** - The existing exclusion of release commands was instinctively correct

3. **User Needs** - Template users don't need meta-project tooling (release automation, validation scripts)

4. **Sustainability** - Maintaining 23+ commands across templates is unsustainable

**Research Support:**
- research-other-projects.md: "Templates are products, not process"
- research-template-user-needs.md: "Natural separation already exists"
- research-minimum-viable-tooling.md: "Templates may be over-featured"

---

## Requirements Impact

**Requirements Affected:**
- FR-7: Release automation should be internal tooling by default ✅
- FR-15: Templates should not include dev-infra internal tooling ✅
- NFR-5: Templates should not grow more complex without clear user need ✅

**This decision establishes the foundation for all other decisions.**

---

## Implementation

1. **Document this identity** - Update Cursor rules, README
2. **Add category metadata** - Mark plans as Template Feature | Internal Tooling | CI/CD
3. **Apply graduation process** - Features must graduate to templates
4. **Review current templates** - Identify any internal tooling that leaked in

---

## References

- [Research Summary](../../research/dev-infra-identity-and-focus/research-summary.md)
- [Exploration](../../explorations/dev-infra-identity-and-focus/exploration.md)
- [Requirements](../../research/dev-infra-identity-and-focus/requirements.md)

---

**Last Updated:** 2025-12-11

