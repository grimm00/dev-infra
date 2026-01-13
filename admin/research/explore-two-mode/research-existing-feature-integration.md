# Research: Existing Feature Plan Integration

**Research Topic:** Explore Two-Mode Enhancement  
**Question:** How should we handle the existing `explore-two-mode` feature plan?  
**Status:** ✅ Complete  
**Priority:** 🟡 Medium  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

How should we handle the existing `explore-two-mode` feature plan?

**Context:** There's already an `admin/planning/features/explore-two-mode/` with narrower scope (just two-mode pattern). This broader exploration covers input sources, topic unification, and consolidation. Need to decide integration approach.

---

## 🔍 Research Goals

- [x] Goal 1: Compare existing feature plan scope with this exploration scope
- [x] Goal 2: Determine if existing feature should be expanded or archived
- [x] Goal 3: Avoid duplicate planning work
- [x] Goal 4: Define best way to consolidate research and decisions

---

## 📚 Research Methodology

**Sources:**
- [x] Existing feature plan analysis (`admin/planning/features/explore-two-mode/`)
- [x] This exploration scope analysis
- [x] Dev-infra patterns for feature evolution

**Sub-questions to investigate:**
- Should existing feature be expanded or archived?
- How do we avoid duplicate planning work?
- Should this exploration supersede the existing feature plan?
- What's the best way to consolidate research and decisions?

---

## 📊 Findings

### Finding 1: Existing Feature Plan Has Narrow Scope

The existing `admin/planning/features/explore-two-mode/feature-plan.md` focuses on:
- Two-mode pattern only (Setup + Conduct)
- ~60-80 lines scaffolding, ~200-300 lines conduct
- Status indicators
- UX consistency with `/research` and `/transition-plan`

**Missing from existing plan:**
- Input sources (start.txt, reflections, raw text)
- Topic unification pattern
- Command organization decisions

**Source:** `admin/planning/features/explore-two-mode/feature-plan.md`

**Relevance:** Existing plan is valid but incomplete - this exploration is broader

---

### Finding 2: This Exploration Addresses Additional Concerns

This exploration covers:

| Concern | In Existing Plan? | In This Exploration? |
|---------|-------------------|----------------------|
| Two-mode pattern | ✅ Yes | ✅ Yes |
| Scaffolding boundaries | ✅ Yes | ✅ Yes (Topic 4) |
| Input sources | ❌ No | ✅ Yes (Topic 3) |
| Topic unification | ❌ No | ✅ Yes (Topic 2) |
| Command organization | ❌ No | ✅ Yes (Topic 1) |
| Cross-command consistency | Partial | ✅ Yes (Topic 6) |

**Source:** Exploration document and research-topics.md

**Relevance:** Exploration is superset of existing feature plan

---

### Finding 3: Feature Plan References Exploration/Research Workflow

The existing feature plan's Phase 1 explicitly calls for:
> "Create exploration for `/explore` two-mode pattern"
> "Research scaffolding vs conduct content boundaries"

This indicates the feature plan anticipated exploration/research work. The current exploration fulfills that requirement.

**Source:** `feature-plan.md` Phase 1 tasks

**Relevance:** This exploration is the intended next step from the feature plan

---

## 🔍 Analysis

**Options Considered:**

| Option | Pros | Cons |
|--------|------|------|
| **Archive existing, create new** | Clean slate | Loses existing work |
| **Expand existing feature** | Preserves history | Feature scope becomes unwieldy |
| **Keep both, link** | Clear separation | Duplicate tracking |
| **Supersede with exploration research** | Natural workflow | Need to update feature plan |

**Recommended Approach:** The existing feature plan should remain as the **implementation target**, while this exploration and resulting research/decisions inform and expand it.

**Key Insights:**
- [x] Insight 1: Existing feature plan is a valid implementation target - don't archive
- [x] Insight 2: This exploration is the "Phase 1" work the feature plan called for
- [x] Insight 3: Research findings should update the feature plan scope
- [x] Insight 4: No duplicate planning - exploration → decisions → feature plan update

---

## 💡 Recommendations

- [x] Recommendation 1: Keep existing feature plan as implementation target
- [x] Recommendation 2: Use `/decision` to create ADRs from this research
- [x] Recommendation 3: Update feature plan with expanded scope after decisions
- [x] Recommendation 4: Link exploration and decisions from feature plan README
- [x] Recommendation 5: Mark feature plan Phase 1 as "in progress via exploration"

---

## 📋 Requirements Discovered

**Process Requirements:**

- [x] PR-FI-1: Exploration research SHOULD feed into existing feature plans
- [x] PR-FI-2: Feature plans SHOULD be updated with expanded scope from research
- [x] PR-FI-3: ADRs SHOULD be linked from feature plan README

**No new functional requirements - this is a process/organization topic.**

---

## 🚀 Next Steps

1. ✅ Research complete
2. After `/decision`, update existing feature plan with expanded scope
3. Link exploration and decisions from feature plan README
4. Update feature plan status

---

**Last Updated:** 2026-01-09

