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
- [x] Direct experience: This feature tests the pattern
- [x] Git branch strategies (GitFlow, trunk-based)
- [x] Software engineering best practices
- [x] Web search: feature branch documentation strategies

---

## 📊 Findings

### Finding 1: Full Isolation Works (Validated by This Feature)

This very feature (`feat/worktree-feature-workflow`) demonstrates full isolation:

| Commits | Content |
|---------|---------|
| 5 commits | All on feature branch |
| Files | Exploration (3), Research (8), Handoff (1) |
| On develop | None - all work is isolated |

**Git log shows:**
```
cbc7b67 docs(research): conduct Topic 1 - Worktree Naming Conventions
1c7d8a9 docs(research): add worktree-feature-workflow research structure
4e5ec16 docs(explore): add research questions for worktree naming
9e880b7 docs(exploration): add session insights on per-window focus
f87ba18 docs(exploration): add worktree-feature-workflow exploration
```

**Source:** Direct testing on this feature branch

**Relevance:** Proves the pattern works. If abandoned, deleting the branch removes all traces.

---

### Finding 2: Atomic Feature = Code + Docs Together

Software engineering best practice: **related changes belong together**.

| Principle | Application |
|-----------|-------------|
| Atomic commits | Feature code + feature docs = one unit |
| Single responsibility | One branch = one feature (complete) |
| Review holistically | PR includes all context for reviewers |

**Benefits:**
- Reviewers see the full picture (why + how)
- Changes are traceable to feature decision
- Rollback includes all related changes

**Source:** Software engineering principles (atomic commits, cohesion)

**Relevance:** Self-contained branches align with atomic commit principles.

---

### Finding 3: Abandoned Features Leave No Trace

**Current problem:**
```
develop
├── docs from Feature A (abandoned) ← clutter
├── docs from Feature B (merged)
├── docs from Feature C (in progress)
└── docs from Feature D (rejected) ← clutter
```

**With self-contained branches:**
```
develop
└── docs from Feature B (merged)

[deleted branches:]
├── feat/feature-a (abandoned → deleted)
├── feat/feature-c (still in progress)
└── feat/feature-d (rejected → deleted)
```

**Source:** Git branch management best practices

**Relevance:** Clean git history on develop - only successful features leave traces.

---

### Finding 4: Document Categories for Isolation

Not all docs should be on feature branches. Classification:

| Category | Location | Rationale |
|----------|----------|-----------|
| **Feature exploration** | Feature branch | Feature-specific, may be abandoned |
| **Feature research** | Feature branch | Feature-specific, may be abandoned |
| **Feature ADRs** | Feature branch | Decision about specific feature |
| **Feature planning** | Feature branch | Implementation plan for feature |
| **Global rules** | Develop | Affects all work, not feature-specific |
| **Templates** | Develop | Shared infrastructure |
| **Cursor commands** | Develop | Shared tooling |
| **Project-wide docs** | Develop | Not tied to single feature |

**Rule of thumb:** If the doc would be useful only if the feature ships → feature branch.

**Source:** Analysis of documentation types

**Relevance:** Clear categorization prevents confusion about what goes where.

---

### Finding 5: Cross-Feature Documentation

Some docs span multiple features. Handling strategies:

| Scenario | Strategy |
|----------|----------|
| Doc affects multiple features | Put on develop, reference from features |
| Feature A depends on Feature B doc | Feature A waits for B to merge |
| Shared exploration | Create shared exploration on develop |
| Global update during feature work | Separate commit/PR for global change |

**Key principle:** Don't couple features through shared docs on feature branches.

**Source:** Dependency management principles

**Relevance:** Prevents merge conflicts and unclear ownership.

---

### Finding 6: Develop Drift and Long-Running Features

Long-running feature branches face develop drift:

| Strategy | When to Use |
|----------|-------------|
| Regular rebases | Active development, < 1 week old |
| Periodic merges from develop | Active development, > 1 week old |
| Split into smaller features | Feature too large |
| Keep features short-lived | Preferred approach |

**Best practice:** Feature branches should be short-lived (days, not weeks).

**Source:** Git branching best practices (GitFlow, trunk-based development)

**Relevance:** Self-contained branches work best when features are small and focused.

---

## 🔍 Analysis

**Self-contained feature branches provide significant benefits:**

1. **Clean git history** - Only successful features leave traces
2. **Holistic review** - Reviewers see complete context
3. **Easy abandonment** - Delete branch, no cleanup needed
4. **Atomic changes** - Related changes stay together

**The pattern works when:**
- Features are small and focused
- Feature lifecycle is short (days, not weeks)
- Global docs are kept separate
- Cross-feature dependencies are minimized

**Key Insights:**
- [x] Insight 1: Full isolation is preferred over partial isolation
- [x] Insight 2: Feature docs travel WITH the feature (exploration, research, ADRs, planning)
- [x] Insight 3: Global docs (rules, templates, commands) stay on develop
- [x] Insight 4: Short-lived feature branches minimize drift issues
- [x] Insight 5: This pattern aligns with atomic commit principles

---

## 💡 Recommendations

- [x] Recommendation 1: Use full isolation - ALL feature docs on feature branch
- [x] Recommendation 2: Keep feature branches short-lived (days, not weeks)
- [x] Recommendation 3: Global docs (rules, templates, commands) stay on develop
- [x] Recommendation 4: Cross-feature docs go on develop, not feature branches
- [x] Recommendation 5: Review PRs holistically (code + docs together)
- [x] Recommendation 6: Delete abandoned branches promptly (no trace)

---

## 📋 Requirements Discovered

- [x] FR-5: Feature exploration docs MUST be created on feature branch
- [x] FR-6: Feature research docs MUST be created on feature branch
- [x] FR-7: Feature ADRs MUST be created on feature branch
- [x] FR-8: Feature planning docs MUST be created on feature branch
- [x] FR-9: Global docs (rules, templates, commands) MUST remain on develop
- [x] FR-10: Cross-feature docs MUST be on develop, not feature branches
- [x] NFR-3: Feature branches SHOULD be short-lived (days, not weeks)
- [x] NFR-4: Abandoned branches SHOULD be deleted promptly after decision
- [x] NFR-5: PRs SHOULD be reviewed holistically (code + docs together)

---

## 🚀 Next Steps

1. ✅ Research complete
2. Update summary and requirements docs
3. Continue with Topic 3: Review Gate Pattern

---

**Last Updated:** 2026-01-09
