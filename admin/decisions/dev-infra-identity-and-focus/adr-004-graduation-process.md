# ADR-004: Graduation Process - Formal Criteria for Templatization

**Status:** ⚠️ Superseded  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-17  
**Superseded By:** [ADR-001: Commands as Guides](../command-simplification/adr-001-commands-as-guides.md)

> **Note:** This ADR has been superseded. Commands are now distributed to all templates without graduation gates. See the superseding ADR for rationale.

---

## Context

Currently, there's no formal process for deciding when dev-infra features should become template features. Features often get templatized:
- During the same release they're created
- Without maturity assessment
- Without demonstrated user need

This leads to:
- Premature templatization
- Template complexity growth
- Features that don't work well in templates

**The Question:** What criteria should determine when an internal improvement becomes a template feature?

**Related Research:**
- [Graduation Criteria](../../research/dev-infra-identity-and-focus/research-graduation-criteria.md)
- [Research Summary](../../research/dev-infra-identity-and-focus/research-summary.md)

**Related Requirements:**
- FR-9: All template features must pass graduation checklist
- FR-10: Graduation decisions must be documented
- NFR-7: Features should be in dev-infra for ≥1 release before graduation

---

## Decision

**Establish formal graduation criteria for templatization.**

Features must meet explicit criteria before being added to templates.

### Graduation Checklist

#### Required Criteria (ALL must pass)

| Criterion | Threshold | Rationale |
|-----------|-----------|-----------|
| **Time in dev-infra** | ≥1 release cycle | Prove it works |
| **Stability** | No major changes in 2+ weeks | Ready for freeze |
| **Documentation** | 100% complete | Ready for users |
| **Demonstrated use** | Used successfully in dev-infra | Not speculative |

#### Recommended Criteria (3/4 should pass)

| Criterion | Threshold | Rationale |
|-----------|-----------|-----------|
| **User request** | Evidence of demand | Validate need |
| **Low complexity** | Newcomers can understand | Maintainability |
| **Self-contained** | No dev-infra dependencies | Works in templates |
| **Testing defined** | Manual testing guide exists | Quality assurance |

#### Optional Criteria (nice to have)

| Criterion | Threshold | Rationale |
|-----------|-----------|-----------|
| **Multiple use cases** | >1 project type | Broad applicability |
| **External validation** | Used in real project | Proven value |

---

## Consequences

### Positive

- **Quality gate** - Prevents premature templatization
- **Maturity signal** - Features proven before distribution
- **Documentation** - Decisions tracked and justified
- **User focus** - Only valuable features graduate
- **Reduced complexity** - Templates don't grow without reason

### Negative

- **Process overhead** - Additional step before templatization
- **Delayed features** - Users wait for graduation
- **Judgment required** - Criteria need interpretation

### Neutral

- **Retroactive application** - Can't apply to existing template features
- **Flexible criteria** - "Recommended" allows exceptions

---

## Alternatives Considered

### Alternative 1: No Formal Process

**Description:** Continue with ad-hoc templatization decisions

**Pros:**
- No process overhead
- Fast templatization
- Flexible

**Cons:**
- Premature templatization continues
- No quality gate
- No documentation of decisions

**Why not chosen:** Research showed need for explicit criteria

---

### Alternative 2: Strict Gate (All Criteria)

**Description:** All criteria must pass, no exceptions

**Pros:**
- Very high quality bar
- No ambiguity
- Maximum template stability

**Cons:**
- Too rigid
- May block valuable features
- No room for judgment

**Why not chosen:** Some flexibility needed for unique situations

---

### Alternative 3: Time-Only Gate

**Description:** Just require ≥1 release, no other criteria

**Pros:**
- Simple
- Easy to measure
- Low overhead

**Cons:**
- Time alone doesn't indicate quality
- Ignores documentation needs
- Ignores user demand

**Why not chosen:** Time is necessary but not sufficient

---

## Decision Rationale

**Key Factors:**

1. **Prevent premature graduation** - Time requirement ensures maturity

2. **Ensure documentation** - Users need complete docs

3. **Validate demand** - Recommended criteria check user need

4. **Allow exceptions** - Required + Recommended structure provides flexibility

**Research Support:**
- research-graduation-criteria.md: "Need ≥1 release cycle in dev-infra"
- research-other-projects.md: "Templates are products" (need quality gate)

---

## Requirements Impact

**Requirements Affected:**
- FR-9: All template features must pass graduation checklist ✅
- FR-10: Graduation decisions must be documented ✅
- NFR-7: Features should be in dev-infra for ≥1 release before graduation ✅

---

## Implementation

### Phase 1: Create Checklist Template (v0.5.0)

**File:** `admin/planning/templates/graduation-checklist.md`

```markdown
# Feature Graduation Checklist

**Feature:** [Name]
**Source:** dev-infra
**Target:** templates
**Date:** YYYY-MM-DD

## Required Criteria (ALL must pass)

- [ ] In dev-infra for ≥1 release: [version introduced]
- [ ] No major changes in last 2 weeks
- [ ] Documentation is 100% complete
- [ ] Used successfully in dev-infra (evidence: [link])

## Recommended Criteria (3/4 should pass)

- [ ] User/project has requested this feature
- [ ] Complexity is low (newcomer can understand)
- [ ] No dev-infra-specific dependencies
- [ ] Manual testing approach is documented

## Optional Criteria (nice to have)

- [ ] Applies to multiple project types
- [ ] Validated in external project

## Decision

- [ ] **GRADUATE:** Add to templates in v[X.Y.Z]
- [ ] **DEFER:** Needs more time/refinement
- [ ] **REJECT:** Not suitable for templates

**Rationale:** [Explanation]
**Reviewer:** [Name]
```

### Phase 2: Apply to New Features (v0.5.0+)

1. All new templatization decisions must use checklist
2. Document graduation decisions in feature planning
3. Track graduation status in release notes

### Phase 3: Review Past Decisions (v0.6.0)

1. Retroactively document why existing template features were included
2. Identify any that should be reconsidered
3. Update documentation

---

## References

- [Graduation Criteria Research](../../research/dev-infra-identity-and-focus/research-graduation-criteria.md)
- [Research Summary](../../research/dev-infra-identity-and-focus/research-summary.md)
- [Requirements](../../research/dev-infra-identity-and-focus/requirements.md)

---

**Last Updated:** 2025-12-11

