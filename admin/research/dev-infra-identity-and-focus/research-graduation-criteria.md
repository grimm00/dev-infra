# Research: Graduation Criteria

**Research Topic:** Dev-Infra Identity & Focus  
**Question:** What criteria should determine when an internal improvement becomes a template feature?  
**Status:** ✅ Complete  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 🎯 Research Question

What criteria should determine when an internal improvement becomes a template feature? Need clear process to prevent premature templatization and reduce scope creep.

---

## 🔍 Research Goals

- [x] Goal 1: Understand current templatization process
- [x] Goal 2: Identify criteria categories
- [x] Goal 3: Define concrete graduation requirements
- [x] Goal 4: Create checklist for graduation decisions

---

## 📊 Findings

### Finding 1: Current (Implicit) Process

**How features currently reach templates:**

1. Feature is built in dev-infra
2. Feature is used for a few tasks
3. Feature is copied to templates (often during same release)
4. Sometimes diverges, sometimes stays in sync

**Problems:**
- No explicit decision point
- No maturity assessment
- No user need validation
- Templatization often happens too early

### Finding 2: Criteria Categories

**Four categories of graduation criteria:**

| Category | Question | Purpose |
|----------|----------|---------|
| **Time** | Has it been stable for N releases? | Ensure maturity |
| **Value** | Do template users need this? | Validate demand |
| **Stability** | Has it changed recently? | Reduce maintenance |
| **Complexity** | Can it be maintained in templates? | Assess burden |

### Finding 3: Proposed Graduation Criteria

**MUST HAVE (all required):**

| Criterion | Threshold | Rationale |
|-----------|-----------|-----------|
| **Time in dev-infra** | ≥1 release cycle | Prove it works |
| **No major changes** | Stable for 2+ weeks | Ready for freeze |
| **Documentation complete** | 100% | Ready for users |
| **Demonstrated need** | Used successfully in dev-infra | Not speculative |

**SHOULD HAVE (most required):**

| Criterion | Threshold | Rationale |
|-----------|-----------|-----------|
| **User request** | Evidence of demand | Validate need |
| **Low complexity** | Understandable by newcomers | Maintainability |
| **No dev-infra dependencies** | Self-contained | Works in templates |
| **Testing approach defined** | Manual testing guide | Quality assurance |

**NICE TO HAVE:**

| Criterion | Threshold | Rationale |
|-----------|-----------|-----------|
| **Multiple use cases** | >1 project type | Broad applicability |
| **External validation** | Used in real project | Proven value |

### Finding 4: Graduation Checklist

**Proposed checklist for graduation decisions:**

```markdown
## Feature Graduation Checklist

**Feature:** [Name]
**Source:** dev-infra
**Target:** templates

### Required Criteria (ALL must pass)

- [ ] In dev-infra for ≥1 release
- [ ] No major changes in last 2 weeks
- [ ] Documentation is 100% complete
- [ ] Used successfully in dev-infra (evidence: [link])

### Recommended Criteria (3/4 should pass)

- [ ] User/project has requested this feature
- [ ] Complexity is low (newcomer can understand)
- [ ] No dev-infra-specific dependencies
- [ ] Manual testing approach is documented

### Optional Criteria (nice to have)

- [ ] Applies to multiple project types
- [ ] Validated in external project

### Decision

- [ ] **GRADUATE:** Add to templates in v[X.Y.Z]
- [ ] **DEFER:** Needs more time/refinement
- [ ] **REJECT:** Not suitable for templates

**Rationale:** [Explanation]
**Decision Date:** [YYYY-MM-DD]
```

---

## 🔍 Analysis

**Key Insights:**

### Insight 1: Time Requirement Prevents Premature Graduation

Requiring 1 release cycle means:
- Feature has been through full release testing
- Any issues have been discovered and fixed
- Documentation has been validated
- Team has experience using it

### Insight 2: Demonstrated Need Prevents Speculation

Requiring evidence of actual use:
- Prevents "build it and they will come" features
- Ensures features solve real problems
- Keeps templates focused and useful

### Insight 3: Complexity Filter Is Critical

Many dev-infra features are too complex for templates:
- Release automation (requires meta-project context)
- Validation scripts (templates don't validate themselves)
- Historical tracking (templates don't track history)

---

## 💡 Recommendations

- [x] **R5: Adopt graduation checklist** - Use for all templatization decisions
- [ ] **R6: Require 1-release waiting period** - Minimum maturity threshold
- [ ] **R7: Track graduation decisions** - Document why features did/didn't graduate
- [ ] **R8: Review current templates** - Apply criteria retroactively

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-9:** All template features must pass graduation checklist
- **FR-10:** Graduation decisions must be documented

### Non-Functional Requirements

- **NFR-7:** Features should be in dev-infra for ≥1 release before graduation
- **NFR-8:** Graduation decisions should be tracked in planning docs

---

## 🚀 Next Steps

1. Create graduation checklist template
2. Document past graduation decisions (retroactively)
3. Apply to Release Automation v2 decision

---

**Last Updated:** 2025-12-11

