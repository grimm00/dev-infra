# ADR-001: Experimental Template Creation

**Status:** Accepted  
**Created:** 2025-12-12  
**Accepted:** 2025-12-12  
**Last Updated:** 2025-12-12

---

## Context

Dev-infra serves as a "template factory" (ADR-001), producing templates for projects. Currently, there are two templates:
- `standard-project` - Full-featured, stable template
- `learning-project` - Educational/tutorial focused template

ADR-003 established command tiers, with the "Evolving" tier containing commands not yet stable enough for templates. These commands are currently dev-infra only, meaning template users cannot access them.

**The question:** Should we create an experimental template that includes Evolving tier commands?

**Key factors:**
1. Research showed ~15% of users typically adopt experimental features
2. **Team projects specifically want access to experimental commands** (user feedback)
3. Early adopters provide disproportionate feedback value
4. Template factory identity supports multiple template "products"

**Related Research:**
- [Research Summary](../../research/experimental-template/research-summary.md)
- [User Demand Research](../../research/experimental-template/research-user-demand.md)

**Related Requirements:**
- [Requirements Document](../../research/experimental-template/requirements.md)

---

## Decision

**Create an experimental template (`experimental-project/`) that includes Evolving tier commands.**

This template will:
- Include all standard template content
- Add Evolving tier commands from dev-infra
- Clearly communicate stability levels
- Provide a graduation path for commands to move to standard

---

## Scope Limitations

### Learning Project Exclusion

**Decision:** The experimental template will be based on `standard-project` only. There will be no `experimental-learning-project` in v0.6.0.

**Rationale:**

1. **Primary demand source:** Team projects (which use standard-project) are the driving force behind this feature
2. **Learning context:** Educational/tutorial projects prioritize stability over bleeding-edge features
3. **Maintenance simplicity:** 3 templates (standard, learning, experimental) is more manageable than 4
4. **Faster delivery:** Smaller scope enables quicker delivery of core functionality

**Future consideration:** If user feedback indicates demand for an experimental learning template, this can be revisited in a future release. The pattern established here (copy base + add Evolving commands) would apply equally to `learning-project`.

---

## Consequences

### Positive

- **Team project access:** Internal team projects can use experimental commands
- **Early feedback:** Users can provide feedback before commands stabilize
- **Faster iteration:** Commands can be tested in real projects earlier
- **Template factory alignment:** Another template "product" aligns with identity
- **Clear boundaries:** Experimental features isolated from stable template
- **User choice:** Users explicitly choose their stability tolerance

### Negative

- **Maintenance burden:** Additional template to maintain
- **Sync challenge:** Must keep experimental in sync with standard
- **Potential confusion:** Users might not understand stability implications
- **Support load:** Experimental users may need more support

### Mitigations

- **CI drift detection** to catch sync issues early
- **Clear stability communication** following Rust/VS Code patterns
- **ADR-004 graduation criteria** for promoting commands
- **Documentation** explaining what "experimental" means

---

## Alternatives Considered

### Alternative 1: No Experimental Template

**Description:** Keep Evolving commands dev-infra only; don't expose to templates.

**Pros:**
- Simplest approach
- No additional maintenance
- No user confusion

**Cons:**
- Team projects can't access experimental commands
- Longer feedback loop
- Early adopters have no option
- Doesn't serve the ~15% user segment

**Why not chosen:** Doesn't meet the stated need for team projects to access experimental commands.

---

### Alternative 2: Feature Flags in Standard Template

**Description:** Use feature flags within standard template to enable experimental features.

**Pros:**
- Single template to maintain
- More granular control
- No sync challenge

**Cons:**
- Increases template complexity
- Mixed stability in one template
- Harder to communicate clearly
- Feature flag infrastructure needed

**Why not chosen:** Increases complexity and muddies the clear "standard = stable" message.

---

## Decision Rationale

**Key Factors:**

1. **Team project demand is immediate and concrete** - Not hypothetical ~15% segment, but real team need
2. **Template factory identity** - Templates as products aligns with separate experimental template
3. **Clear boundaries** - Standard stays stable, experimental is clearly different
4. **Precedent exists** - Rust stable/nightly, VS Code stable/insiders work well

**Research Support:**
- Technology adoption lifecycle shows 15-20% early adopter segment
- Industry examples (Rust, VS Code, Node.js) show dual-track adoption works
- Clear stability communication increases adoption confidence

---

## Requirements Impact

**Requirements Addressed:**
- FR-1: Template Generation (new template directory)
- FR-2: Generator Script Update (add template type)
- NFR-2: User Experience (clear template choice)
- NFR-3: Explicit Opt-In (separate template = explicit choice)

**Requirements Refined:**
- A-1: User Interest assumption strengthened by team project demand

---

## References

- [Research Summary](../../research/experimental-template/research-summary.md)
- [User Demand Research](../../research/experimental-template/research-user-demand.md)
- [Requirements Document](../../research/experimental-template/requirements.md)
- ADR-001: Project Identity (Template Factory)
- ADR-003: Command Tiers

---

**Last Updated:** 2025-12-12

