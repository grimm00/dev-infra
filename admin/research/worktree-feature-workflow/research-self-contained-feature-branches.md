# Research: Self-Contained Feature Branches

**Research Topic:** Worktree Feature Workflow  
**Question:** What content should live on feature branches vs develop?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2026-01-09  
**Completed:** 2026-01-09

---

## 🎯 Research Question

What content should live on feature branches vs develop?

**Sub-questions:**
- Should ALL docs (exploration, research, decisions, planning) live on feature branch?
- Or only exploration/research, with planning on develop?
- How to handle docs that span multiple features?
- How to handle updates to global docs (rules, templates)?

---

## 🔍 Research Goals

- [x] Goal 1: Define what "self-contained" means for feature branches
- [x] Goal 2: Understand pros/cons of full isolation vs partial isolation
- [x] Goal 3: Determine handling of shared/global docs
- [x] Goal 4: Define merge strategy for documentation

---

## 💡 Pre-Research Insights

**Current workflow problem:**
> Docs committed to develop prematurely → ideas that don't pan out pollute git history

**Proposed benefit:**
> If feature is abandoned, git history stays clean - just delete the branch

**This feature is testing the pattern:**
- All docs (exploration, research) on `feat/worktree-feature-workflow`
- Nothing merged to develop until feature is reviewed

---

## 📚 Research Methodology

**Sources:**
- [x] Git branch strategies (GitFlow, trunk-based)
- [x] Documentation-as-code patterns
- [x] Feature flag/toggle patterns (similar isolation concept)
- [x] Atomic commit principles

---

## 📊 Findings

### Finding 1: Full Isolation is Preferred

Self-contained feature branches should include ALL feature-specific documentation:

| Content Type | Feature Branch | Develop |
|--------------|----------------|---------|
| Feature exploration | ✅ | ❌ |
| Feature research | ✅ | ❌ |
| Feature ADRs | ✅ | ❌ |
| Feature planning | ✅ | ❌ |
| Feature code | ✅ | ❌ |
| Feature tests | ✅ | ❌ |

**Benefits:**
- Abandoned features leave no trace in develop
- Reviewers see full context in PR
- Atomic changes (all or nothing)
- Clean git history on develop

**Source:** Atomic commit principles, documentation-as-code patterns

**Relevance:** Full isolation achieves the goal of clean develop history.

---

### Finding 2: Document Category Separation

Not all docs belong on feature branches. Clear separation:

| Category | Location | Rationale |
|----------|----------|-----------|
| **Feature-specific** | Feature branch | Tied to feature lifecycle |
| **Global docs** | Develop | Affect all features |
| **Cross-feature** | Develop | Not tied to single feature |

**Feature-specific (on feature branch):**
- `admin/explorations/[feature]/`
- `admin/research/[feature]/`
- `admin/decisions/[feature]/`
- `admin/planning/features/[feature]/`

**Global (on develop):**
- `.cursor/rules/` - AI rules
- `.cursor/commands/` - Workflow commands
- `templates/` - Project templates
- `scripts/` - Shared scripts
- `docs/` - User documentation

**Source:** Git Flow patterns, monorepo documentation strategies

**Relevance:** Clear boundaries prevent confusion about where docs belong.

---

### Finding 3: Merge Strategy - All at Once

**When feature merges to develop:**
- ALL feature docs merge together
- Single atomic PR
- Review covers everything

**This means:**
- Exploration docs merge with implementation
- Research docs merge with decisions
- Planning docs merge with completed work

**Benefit:** Complete feature history arrives together, making it easy to understand the evolution.

**Source:** Atomic commit patterns, PR best practices

**Relevance:** Single atomic merge maintains traceability.

---

### Finding 4: Handling Long-Running Features

For features that span multiple PRs or phases:

**Option A: Single branch, multiple PRs**
- Feature branch lives until all phases complete
- PRs from feature → develop for each phase
- All docs still on feature branch until final merge

**Option B: Phase branches**
- `feat/my-feature` → main feature branch
- `feat/my-feature-phase1` → phase 1 work
- Merge phases to main feature branch
- Final merge of main feature to develop

**Recommendation:** Option A for most features; Option B only for very large features.

**Source:** Git branching strategies, large feature management

**Relevance:** Supports various feature sizes while maintaining isolation.

---

### Finding 5: Avoiding Feature Branch Coupling

**Problem:** Feature A's docs reference Feature B's docs (both on branches)

**Solutions:**
1. **Wait for dependency:** Don't start Feature A until Feature B merges
2. **Reference by intent:** Reference what Feature B will provide, not its current docs
3. **Shared docs on develop:** If truly shared, the doc belongs on develop

**Best practice:** Features should be independent. Shared concepts go on develop.

**Source:** Dependency management patterns, modular design

**Relevance:** Prevents circular dependencies between feature branches.

---

### Finding 6: Practical Evidence - This Feature

This feature (`feat/worktree-feature-workflow`) is testing the pattern:

**What's on this branch:**
- `admin/explorations/worktree-feature-workflow/` - Exploration docs
- `admin/research/worktree-feature-workflow/` - Research docs
- `tmp/handoff.md` - Context switching doc

**What's NOT on this branch:**
- Changes to `.cursor/commands/` - Would be global
- Changes to `templates/` - Would be global
- Changes to `docs/` user docs - Would be global

**Observation:** The pattern feels natural and keeps work focused.

**Source:** Direct experience with this exploration

**Relevance:** Real-world validation of the approach.

---

## 🔍 Analysis

**Full isolation is the right approach** for feature-specific documentation:

| Approach | Pros | Cons |
|----------|------|------|
| **Full isolation** | Clean history, atomic PRs, context together | Requires discipline |
| **Partial isolation** | Easier for shared docs | Messy history, scattered context |
| **No isolation** | Simple | Polluted develop history |

**The key insight:** Feature branches are temporary; develop is permanent. Only put things on develop that you want permanently.

**Key Insights:**
- [x] Insight 1: Full isolation is preferred - all feature docs on feature branch
- [x] Insight 2: Clear category separation (feature-specific vs global)
- [x] Insight 3: Features should be independent - shared docs go on develop
- [x] Insight 4: Single atomic merge maintains traceability
- [x] Insight 5: This pattern is being validated by this very exploration

---

## 💡 Recommendations

- [x] Recommendation 1: Use full isolation - ALL feature docs on feature branch
- [x] Recommendation 2: Feature-specific = exploration, research, ADRs, planning
- [x] Recommendation 3: Global = rules, commands, templates, user docs
- [x] Recommendation 4: Merge atomically (all docs with code in single PR)
- [x] Recommendation 5: Avoid cross-feature doc references
- [x] Recommendation 6: If docs are shared, they belong on develop

---

## 📋 Requirements Discovered

- [x] FR-8: Feature exploration docs MUST be created on the feature branch
- [x] FR-9: Feature research docs MUST be created on the feature branch
- [x] FR-10: Feature ADRs MUST be created on the feature branch
- [x] FR-11: Feature planning docs MUST be created on the feature branch
- [x] FR-12: Global docs (rules, commands, templates) MUST remain on develop
- [x] FR-13: Cross-feature docs MUST be on develop, not feature branches
- [x] NFR-6: Features SHOULD be independent (no cross-branch doc references)
- [x] NFR-7: Feature merges SHOULD be atomic (all docs + code together)

---

## 🚀 Next Steps

1. ✅ Research complete
2. Update summary and requirements docs
3. Continue with remaining topics

---

**Last Updated:** 2026-01-09
