# Feature Graduation Checklist

**Purpose:** Template for evaluating whether a dev-infra feature should graduate to templates  
**Source:** [ADR-004: Graduation Process](../../decisions/dev-infra-identity-and-focus/adr-004-graduation-process.md)  
**Created:** 2025-12-11

---

## Usage

Copy this template when evaluating a feature for template graduation:

```bash
cp admin/planning/templates/graduation-checklist.md admin/planning/features/[feature]/graduation-evaluation.md
```

Fill out all sections and make a decision.

---

## Evaluation Template

```markdown
# Graduation Evaluation - [Feature Name]

**Feature:** [Name]
**Source:** dev-infra  
**Target:** templates (standard-project, learning-project)  
**Evaluation Date:** YYYY-MM-DD  
**Evaluator:** [Name/AI]

---

## Required Criteria (ALL must pass)

| Criterion | Threshold | Evidence | Pass? |
|-----------|-----------|----------|-------|
| Time in dev-infra | ≥1 release | v[X.Y.Z] introduced | ✅/❌ |
| Stability | No major changes 2+ weeks | Last change: [date] | ✅/❌ |
| Documentation | 100% complete | [Link to docs] | ✅/❌ |
| Demonstrated use | Used in dev-infra | [Link to usage] | ✅/❌ |

**Required Score:** 4/4

---

## Recommended Criteria (3/4 should pass)

| Criterion | Threshold | Evidence | Pass? |
|-----------|-----------|----------|-------|
| User request | Evidence of demand | [Link/note] | ✅/❌ |
| Low complexity | Newcomers can understand | [Assessment] | ✅/❌ |
| Self-contained | No dev-infra dependencies | [Assessment] | ✅/❌ |
| Testing defined | Manual testing guide | [Link to guide] | ✅/❌ |

**Recommended Score:** [ ]/4 (need ≥3)

---

## Optional Criteria (nice to have)

| Criterion | Threshold | Evidence | Pass? |
|-----------|-----------|----------|-------|
| Multiple use cases | >1 project type | [Examples] | ✅/❌ |
| External validation | Used in real project | [Project name] | ✅/❌ |

---

## Decision

### Summary

| Category | Score | Threshold | Met? |
|----------|-------|-----------|------|
| Required | [ ]/4 | 4/4 | ✅/❌ |
| Recommended | [ ]/4 | 3/4 | ✅/❌ |

### Decision

- [ ] **GRADUATE:** Add to templates in v[X.Y.Z]
- [ ] **DEFER:** Needs more time/refinement
  - Reason: [Explain what's missing]
  - Revisit: v[X.Y.Z] or [date]
- [ ] **REJECT:** Not suitable for templates
  - Reason: [Explain why]

### Rationale

[Detailed explanation of decision]

### If Graduating

**Target templates:**
- [ ] standard-project
- [ ] learning-project
- [ ] both

**Implementation notes:**
- [Any modifications needed for templates]
- [Path changes required]
- [Documentation updates]

---

## Sign-off

**Decision Date:** YYYY-MM-DD  
**Evaluator:** [Name]  
**Status:** [Pending Review | Approved | Rejected]
```

---

## Examples

### Example 1: Release Commands (REJECT)

| Criterion | Pass? | Reason |
|-----------|-------|--------|
| Time in dev-infra | ✅ | v0.4.0 |
| Stability | ✅ | Stable 2+ weeks |
| Documentation | ✅ | Complete |
| Demonstrated use | ✅ | Used for v0.4.0 release |
| User request | ❌ | No external demand |
| Low complexity | ❌ | Requires meta-project context |
| Self-contained | ❌ | Needs release-specific tooling |
| Testing defined | ✅ | Manual testing guide exists |

**Decision:** REJECT - Not suitable for templates. Release commands are meta-project tooling that template users don't need.

### Example 2: /reflect Command (GRADUATE)

| Criterion | Pass? | Reason |
|-----------|-------|--------|
| Time in dev-infra | ✅ | v0.3.0 |
| Stability | ✅ | Stable 4+ weeks |
| Documentation | ✅ | Complete |
| Demonstrated use | ✅ | Used throughout v0.4.0 cycle |
| User request | ✅ | Valuable for any project |
| Low complexity | ✅ | Simple workflow |
| Self-contained | ✅ | No dev-infra dependencies |
| Testing defined | ✅ | Manual testing in command doc |

**Decision:** GRADUATE - Valuable for all projects, stable, well-documented.

---

## Reference

- [ADR-001: Project Identity](../../decisions/dev-infra-identity-and-focus/adr-001-project-identity.md) - Why graduation matters
- [ADR-004: Graduation Process](../../decisions/dev-infra-identity-and-focus/adr-004-graduation-process.md) - Full criteria details
- [Research: Graduation Criteria](../../research/dev-infra-identity-and-focus/research-graduation-criteria.md) - Research behind criteria

---

**Last Updated:** 2025-12-11

