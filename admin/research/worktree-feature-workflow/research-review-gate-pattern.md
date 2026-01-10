# Research: Review Gate Pattern

**Research Topic:** Worktree Feature Workflow  
**Question:** How should the review gate workflow function?  
**Status:** ✅ Complete  
**Priority:** 🟡 Medium  
**Created:** 2026-01-09  
**Completed:** 2026-01-09

---

## 🎯 Research Question

How should the review gate workflow function?

**Sub-questions:**
- What's the minimum viable feature to merge?
- Should explorations that lead to "no action" be merged for learning?
- How to handle long-running features with develop drift?
- How to review code + docs together?

---

## 🔍 Research Goals

- [x] Goal 1: Define minimum merge criteria
- [x] Goal 2: Determine handling of abandoned/no-action explorations
- [x] Goal 3: Define develop drift management strategy
- [x] Goal 4: Establish PR review workflow for mixed code/docs

---

## 💡 Pre-Research Insights

**Current workflow problem:**
```
1. Work on feature
2. Commit docs to develop (premature)
3. Work more
4. PR code to develop
5. Merge → docs already there, even if idea changed
```

**Proposed workflow:**
```
1. Create feature worktree
2. All work (code + docs) on feature branch
3. PR feature branch to develop
4. Review entire feature
5. Merge only if idea pans out
6. If abandoned → delete branch, develop stays clean
```

---

## 📚 Research Methodology

**Sources:**
- [x] Git Flow and trunk-based development patterns
- [x] Feature branch lifecycle best practices
- [x] Code review literature and patterns
- [x] Agile spike/exploration patterns

---

## 📊 Findings

### Finding 1: Minimum Merge Criteria - "Definition of Done"

The minimum viable feature to merge should follow a clear "Definition of Done":

**For Feature Branches:**
1. **Complete implementation** - All planned functionality works
2. **Tests pass** - If applicable, tests are green
3. **Documentation updated** - Feature docs are current
4. **Reviewed** - At least one approval from reviewer

**For Exploration Branches:**
1. **Decision reached** - Clear recommendation or "no action"
2. **Documentation complete** - Exploration, research, and ADR (if applicable)
3. **Reviewed** - Exploration reviewed for value and accuracy

**Source:** Agile "Definition of Done" patterns, Git Flow best practices

**Relevance:** Clear criteria prevents premature merges and ensures consistent quality.

---

### Finding 2: Exploration Outcomes - Merge Learning, Not Just Code

Explorations have three possible outcomes:

| Outcome | Action | Rationale |
|---------|--------|-----------|
| **Proceed** | Merge exploration + implementation | Standard feature merge |
| **No Action** | Merge exploration docs only | Preserve learning for future |
| **Abandoned** | Delete branch | No value to preserve |

**Key distinction:**
- **"No Action"** = Deliberate decision after research → Merge docs for learning
- **"Abandoned"** = Ran out of time/priority changed → Delete (no value)

The exploration process itself has value even if the conclusion is "don't do this."

**Source:** Agile spike patterns, knowledge management best practices

**Relevance:** Preserving "no action" decisions prevents repeated exploration of the same ideas.

---

### Finding 3: Develop Drift - Rebase for Short, Merge for Long

**Short-lived branches (< 1 week):**
- Rebase onto develop before PR
- Clean, linear history
- Minimal conflict resolution

**Long-lived branches (> 1 week):**
- Periodic merge from develop (not rebase)
- Preserves branch history
- Easier conflict resolution

**Prevention:**
- Keep features small and focused
- Time-box explorations (days, not weeks)
- Break large features into phases

**Source:** Git branching strategies, trunk-based development patterns

**Relevance:** Time-boxing prevents most drift issues; merge strategy handles the rest.

---

### Finding 4: Holistic PR Review - Code + Docs Together

**Benefits of reviewing code + docs together:**
1. **Full context** - Reviewers see the "why" (docs) and "how" (code)
2. **Atomic changes** - Feature is complete in one merge
3. **Better decisions** - Context enables better review feedback
4. **No orphaned docs** - Docs and code always in sync

**Review focus by section:**
- **Exploration/Research** - Is the thinking sound? Any gaps?
- **ADRs** - Is the decision justified? Alternatives considered?
- **Implementation** - Does code match the decision?
- **Feature docs** - Is the feature documented for users?

**Tooling consideration:**
- Configure Sourcery to ignore `admin/**` and `docs/maintainers/**`
- Focuses automated review on code, not process docs

**Source:** Code review best practices, documentation-as-code patterns

**Relevance:** Holistic review is the core benefit of self-contained feature branches.

---

### Finding 5: Review Types by Branch Type

Different branch types need different review approaches:

| Branch Type | Review Focus | Reviewer Criteria |
|-------------|--------------|-------------------|
| `feat/*` | Implementation + design | Domain expertise |
| `fix/*` | Correctness + regression | Issue familiarity |
| `docs/*` | Accuracy + clarity | Can skip for minor |
| `explore/*` | Thinking + conclusions | Anyone can review |

**For explorations:**
- Review is about validating the exploration process
- Less about "approving" a decision
- More about "have we thought this through?"

**Source:** PR review patterns, exploration workflow design

**Relevance:** Different review criteria prevent over-engineering simple changes.

---

### Finding 6: Merge vs Delete Decision Tree

**Decision tree for feature branch completion:**

```
Feature complete?
├── Yes → Create PR → Review → Merge
│
└── No → Why?
    ├── "No Action" decision reached
    │   └── Has learning value? 
    │       ├── Yes → Merge docs only
    │       └── No → Delete branch
    │
    ├── Abandoned (no decision)
    │   └── Delete branch
    │
    └── Paused (will resume)
        └── Keep branch, document status
```

**Source:** Feature branch lifecycle patterns

**Relevance:** Clear decision tree prevents branch accumulation.

---

## 🔍 Analysis

The review gate pattern should be lightweight but consistent:

**Core principle:** All work on feature branch, review atomically, merge completely.

**Key decision points:**
1. **Minimum criteria:** Definition of Done (implementation OR exploration complete)
2. **No-action explorations:** Merge docs if they have learning value
3. **Drift management:** Time-box to prevent; merge/rebase to handle
4. **Review style:** Holistic (code + docs), focus varies by branch type

**Key Insights:**
- [x] Insight 1: "No action" ≠ "abandoned" - deliberate decisions have learning value
- [x] Insight 2: Time-boxing features (days, not weeks) prevents most drift issues
- [x] Insight 3: Different branch types need different review focus
- [x] Insight 4: Holistic review is the core benefit of self-contained branches
- [x] Insight 5: Clear decision tree prevents branch accumulation

---

## 💡 Recommendations

- [x] Recommendation 1: Define clear "Definition of Done" for features and explorations
- [x] Recommendation 2: Merge "no-action" exploration docs for learning value
- [x] Recommendation 3: Time-box explorations (max 1 week) to prevent drift
- [x] Recommendation 4: Use rebase for short branches, merge for long branches
- [x] Recommendation 5: Review holistically (code + docs together)
- [x] Recommendation 6: Configure Sourcery to ignore process docs (`admin/**`)
- [x] Recommendation 7: Delete abandoned branches promptly (no learning value)

---

## 📋 Requirements Discovered

- [x] FR-5: Feature branches MUST have clear "Definition of Done" criteria
- [x] FR-6: "No-action" explorations SHOULD be merged if they have learning value
- [x] FR-7: PRs MUST be reviewed holistically (code + docs together)
- [x] NFR-3: Features SHOULD be time-boxed (target: < 1 week)
- [x] NFR-4: Abandoned branches SHOULD be deleted promptly
- [x] NFR-5: sourcery.yml SHOULD ignore `admin/**` for cleaner code review
- [x] C-3: Long-running branches (> 1 week) require periodic develop merges

---

## 🚀 Next Steps

1. ✅ Research complete
2. Update summary and requirements docs
3. Continue with Topic 4: sourcery.yml Configuration

---

**Last Updated:** 2026-01-09
