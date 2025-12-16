# Research: Graduation Path

**Research Topic:** Experimental Template  
**Question:** How do commands graduate from experimental to standard?  
**Priority:** 🟡 Medium  
**Status:** ✅ Complete  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12  
**Completed:** 2025-12-12

---

## 🎯 Research Question

How do commands graduate from experimental to standard, and what criteria/process should govern this transition?

**The need:**
- Clear criteria for when a command is "stable enough"
- Process for promotion decisions
- Communication to users about changes

---

## 🔍 Research Goals

- [x] Goal 1: Define graduation criteria (stability, usage, documentation)
- [x] Goal 2: Establish decision-making process
- [x] Goal 3: Design user notification workflow
- [x] Goal 4: Integrate with ADR-004 graduation process

---

## 📚 Research Methodology

**Note:** Research based on existing ADRs and industry patterns.

**Sources:**
- [x] ADR-004: Graduation Process (existing)
- [x] ADR-003: Command Tiers
- [x] Rust RFC stabilization process
- [x] Feature flag graduation patterns
- [x] Open source project promotion processes

---

## 📊 Findings

### Finding 1: ADR-004 Graduation Criteria is Foundation

**Existing criteria from ADR-004:**

| Criterion | Requirement |
|-----------|-------------|
| Time in dev-infra | ≥1 release cycle |
| Stability | No major changes in 2+ weeks |
| Documentation | 100% complete |
| Usage | Demonstrated use in dev-infra |

**Source:** ADR-004: Graduation Process

**Relevance:** These criteria apply directly to command graduation. Already established and approved.

---

### Finding 2: Rust's Stabilization Process is Well-Defined

**Rust's Process:**
1. **RFC** - Feature proposed and approved
2. **Implementation** - Feature implemented on nightly
3. **Testing Period** - Used and tested on nightly
4. **FCP (Final Comment Period)** - Community review
5. **Stabilization PR** - Feature moved to stable

**Key Elements:**
- Tracking issue for each feature
- Clear criteria for stabilization
- Public discussion before promotion
- Release notes announce graduations

**Source:** Rust governance documentation

**Relevance:** Model for transparent, well-communicated graduation process.

---

### Finding 3: Feature Flags Use Metrics for Graduation

**Common Metrics:**
- **Usage rate** - X% of eligible users enabling
- **Error rate** - Below threshold for Y period
- **Feedback sentiment** - Net positive feedback
- **Support tickets** - Manageable volume

**Example Criteria:**
```
Feature Flag Graduation Checklist:
- [ ] >1000 users enabled
- [ ] Error rate <0.1% for 14 days
- [ ] No critical bugs open
- [ ] Documentation complete
- [ ] Support team trained
```

**Source:** Feature flag best practices

**Relevance:** Quantitative criteria add objectivity to graduation decisions.

---

### Finding 4: Command Tiers Map to Graduation Levels

**Tier Progression:**

```
                     ┌─────────────────┐
                     │   Essential     │  ← Graduates to highest tier
                     │   (Always)      │
                     └────────▲────────┘
                              │
                     ┌────────┴────────┐
                     │   Valuable      │  ← Common graduation target
                     │   (Default)     │
                     └────────▲────────┘
                              │
                     ┌────────┴────────┐
                     │   Advanced      │  ← Complex but stable
                     │   (Optional)    │
                     └────────▲────────┘
                              │
┌────────────────────────────┴────────────────────────────┐
│                    Evolving (Experimental)               │
│                    Dev-infra only → Templates            │
└─────────────────────────────────────────────────────────┘
```

**Source:** ADR-003: Command Tiers

**Relevance:** Graduation typically moves from Evolving → Advanced or Valuable.

---

### Finding 5: Communication is Critical for Graduations

**What users need to know:**
1. **What graduated** - Command name and description
2. **What changed** - Any API/behavior changes during stabilization
3. **When** - Release version containing graduation
4. **Migration** - Steps to adopt if using experimental version

**Communication Channels:**
- Release notes (primary)
- Template README updates
- CHANGELOG entries
- Migration guides (if breaking changes)

**Source:** Open source release practices

**Relevance:** Users in experimental template need clear upgrade path.

---

## 🔍 Analysis

**Proposed Graduation Process for Commands:**

### Graduation Criteria Checklist

```markdown
## Command Graduation Checklist

### Required (ALL must be met):
- [ ] ≥1 release cycle in dev-infra (per ADR-004)
- [ ] No major changes in 2+ weeks (per ADR-004)
- [ ] Documentation 100% complete (per ADR-004)
- [ ] Demonstrated use in dev-infra (per ADR-004)
- [ ] No open critical bugs
- [ ] Command follows established patterns

### Recommended (majority should be met):
- [ ] Positive user feedback
- [ ] Clear use cases documented
- [ ] Error handling comprehensive
- [ ] Tests cover main scenarios
```

### Graduation Workflow

```
1. Identify Candidate
   - Command meets criteria
   - Maintainer proposes graduation
   
2. Review Period (1 week)
   - Document any final changes
   - Ensure tests pass
   - Update documentation
   
3. Graduation PR
   - Move command to standard template
   - Update tier metadata
   - Add to release notes
   
4. Communication
   - CHANGELOG entry
   - Release notes highlight
   - Template README update
```

**Key Insights:**
- [x] Insight 1: ADR-004 criteria form the foundation; no need to reinvent
- [x] Insight 2: Tier progression provides clear graduation targets
- [x] Insight 3: Communication is as important as the criteria themselves
- [x] Insight 4: Simple checklist process is better than complex governance

---

## 💡 Recommendations

- [x] Recommendation 1: Use ADR-004 criteria as graduation checklist
- [x] Recommendation 2: Graduation target is typically "Valuable" tier
- [x] Recommendation 3: Include graduation in release notes
- [x] Recommendation 4: Create migration guide if any breaking changes

---

## 📋 Requirements Discovered

- [x] REQ-GP-1: Graduation checklist based on ADR-004 criteria
- [x] REQ-GP-2: Graduation PR template for consistency
- [x] REQ-GP-3: CHANGELOG section for graduated commands
- [x] REQ-GP-4: Migration guide template for breaking changes
- [x] REQ-GP-5: Release notes must highlight graduations

---

## 🚀 Next Steps

1. ✅ Research complete
2. All 5 research topics completed
3. Ready for `/decision experimental-template --from-research`

---

**Last Updated:** 2025-12-12
