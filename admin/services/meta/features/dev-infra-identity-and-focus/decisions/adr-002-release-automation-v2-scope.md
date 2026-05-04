# ADR-002: Release Automation v2 Scope - Internal Tooling Only

**Status:** ✅ Accepted  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## Context

Release Automation v2 was planned with 3 phases:

| Phase | Focus | Effort | Originally Planned |
|-------|-------|--------|-------------------|
| Phase 1 | Tag Creation Automation | 1-2 days | Template feature |
| Phase 2 | Version Reference Automation | 2-3 days | Template feature |
| Phase 3 | Template Integration | 3-5 days | Put commands in templates |

With the identity decision (ADR-001) establishing dev-infra as a template factory, we need to reconsider this scope.

**The Question:** Should Release Automation v2 proceed as planned, be rescoped, or deferred?

**Related Research:**
- [Release Automation Scope](../../research/dev-infra-identity-and-focus/research-release-automation-scope.md)
- [Research Summary](../../research/dev-infra-identity-and-focus/research-summary.md)

**Related Requirements:**
- FR-7: Release automation should be internal tooling by default
- FR-8: Template integration requires explicit graduation decision
- C-1: v0.5.0 scope must align with template-centric identity

---

## Decision

**v0.5.0 will complete Release Automation v2 as internal tooling only.**

| Phase | Decision | Rationale |
|-------|----------|-----------|
| Phase 1 | ✅ **Complete** | Improves dev-infra's release process |
| Phase 2 | ✅ **Complete** | Improves dev-infra's release process |
| Phase 3 | ❌ **Skip** | Conflicts with template factory identity |

### What This Means

1. **Tag automation** - Implemented for dev-infra use
2. **Version reference automation** - Implemented for dev-infra use
3. **Template integration** - Not done; release commands stay dev-infra-only
4. **Future consideration** - Phase 3 can be revisited after graduation criteria met

---

## Consequences

### Positive

- **Aligns with identity** - Consistent with template factory focus
- **Simpler templates** - No meta-project tooling added
- **Faster v0.5.0** - Reduced scope (skip Phase 3)
- **Internal improvement** - Dev-infra gets better release workflow
- **Validates pattern** - Tests automation before any templatization

### Negative

- **Templates don't get release commands** - Users wanting this must build their own
- **Potential user disappointment** - "I want `/release-prep` in my project"
- **Two-tier system** - Dev-infra more capable than templates

### Neutral

- **Phase 3 not cancelled** - Just deferred pending graduation
- **Release commands already excluded** - Validates existing decision

---

## Alternatives Considered

### Alternative A: Proceed as Planned (All 3 Phases)

**Description:** Complete all phases, put release commands in templates

**Pros:**
- Templates get full release workflow
- Consistent with v0.4.0 Release Readiness work
- Some projects might benefit

**Cons:**
- Conflicts with template factory identity (ADR-001)
- Adds meta-project tooling to templates
- Increases template complexity
- Higher maintenance burden

**Why not chosen:** Conflicts with foundational identity decision

---

### Alternative B: Phase 3 Only (Template Integration)

**Description:** Skip automation, just add existing commands to templates

**Pros:**
- Templates get release commands
- Less implementation work

**Cons:**
- Commands haven't been proven yet
- Premature templatization
- Still conflicts with identity

**Why not chosen:** Violates graduation criteria

---

### Alternative C: Defer Entirely

**Description:** No Release Automation v2 work in v0.5.0

**Pros:**
- Maximum template focus
- No new release features
- Simplest option

**Cons:**
- Misses opportunity to improve dev-infra workflow
- Phase 1-2 are valuable internal improvements
- v0.4.0 release showed gaps

**Why not chosen:** Internal improvements still valuable

---

### Alternative D: Internal Only (Chosen)

**Description:** Complete Phase 1-2 as internal tooling, skip Phase 3

**Pros:**
- Aligns with template factory identity
- Improves dev-infra's own workflow
- Validates automation before any templatization
- Can revisit Phase 3 after graduation criteria

**Cons:**
- Templates don't get release commands
- Two-tier capability

**Why chosen:** Best balance of improvement vs identity alignment

---

## Decision Rationale

**Key Factors:**

1. **Identity Alignment** - Phase 3 directly conflicts with ADR-001

2. **Graduation Criteria** - New commands should prove themselves (≥1 release) before templatization

3. **User Needs** - Template users aren't meta-projects; they have different release needs

4. **Incremental Approach** - Prove internally first, templatize later if warranted

**Research Support:**
- research-release-automation-scope.md: "Phase 1-2 are internal tooling; Phase 3 conflicts with template-centric identity"
- research-template-user-needs.md: "Release commands intentionally excluded from templates"
- research-graduation-criteria.md: "≥1 release cycle in dev-infra before graduation"

---

## Requirements Impact

**Requirements Affected:**
- FR-7: Release automation should be internal tooling by default ✅
- FR-8: Template integration requires explicit graduation decision ✅
- C-1: v0.5.0 scope must align with template-centric identity ✅

**Release Automation v2 Feature Plan Update:**
- Phase 3 should be removed or marked as "Deferred - Pending Graduation"
- Feature status should reflect internal-only scope

---

## Implementation

1. **Update Release Automation v2 feature plan** - Mark Phase 3 as deferred
2. **Complete Phase 1** - Tag creation automation
3. **Complete Phase 2** - Version reference automation
4. **Document as internal tooling** - Not for templates
5. **Revisit after v0.6.0** - Evaluate if graduation criteria met

---

## References

- [Release Automation v2 Feature Plan](../../planning/features/release-automation-v2/feature-plan.md)
- [Research Summary](../../research/dev-infra-identity-and-focus/research-summary.md)
- [Graduation Criteria](../../research/dev-infra-identity-and-focus/research-graduation-criteria.md)

---

**Last Updated:** 2025-12-11

