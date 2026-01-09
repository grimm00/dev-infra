# Research: Phase-Based Review in Self-Contained Workflow

**Research Topic:** Worktree Feature Workflow  
**Question:** How do we maintain early bug detection (via Sourcery reviews) in a self-contained feature branch workflow?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2026-01-09  
**Completed:** 2026-01-09

---

## 🎯 Research Question

How do we maintain early bug detection (via Sourcery reviews) in a self-contained feature branch workflow?

**Sub-questions:**
- Should we still create phase-based PRs? If so, to what?
- Can Sourcery CLI be used locally for early feedback?
- Do draft PRs provide a middle ground?
- How do we balance isolation with early feedback?
- What's the review workflow during feature development?

---

## 🔍 Research Goals

- [x] Goal 1: Understand current phase-based review workflow value
- [x] Goal 2: Identify options for early feedback in self-contained branches
- [x] Goal 3: Evaluate trade-offs of each approach
- [x] Goal 4: Recommend a workflow that preserves early bug detection

---

## 💡 Pre-Research Context

**Current Workflow (Phase-Based PRs via transition-plan):**
```
develop → feat/feature
  └── Phase 1 → PR → Sourcery Review → Fix → Merge to develop
  └── Phase 2 → PR → Sourcery Review → Fix → Merge to develop
  └── etc.
```

**Benefits of current workflow:**
- Early bug detection at each phase
- Incremental review (smaller PRs)
- Issues caught before they compound

**Tension with self-contained branches:**
- If all docs are on feature branch, merging to develop defeats isolation
- But waiting until the end loses early feedback value

---

## 📚 Research Methodology

**Sources:**
- [x] Current dev-infra workflow documentation (`task-phase.md`, `pr.md`)
- [x] Sourcery feedback examples (`admin/feedback/sourcery/`)
- [x] Web search: feature branch review strategies
- [x] Web search: draft PR workflows

---

## 📊 Findings

### Finding 1: Current Workflow Already Distinguishes Docs-Only vs Code Phases

The current `task-phase` command has built-in logic:

**Docs-Only Phases:**
- Merge directly to develop (no PR)
- Preserves Sourcery quota for code changes
- Fast path for documentation work

**Code Phases:**
- Create PR for Sourcery review
- Address CRITICAL/HIGH issues before merge
- Full review workflow

**Source:** `.cursor/commands/task-phase.md` lines 166-197

**Relevance:** The existing workflow already optimizes for when reviews are needed. Self-contained branches could adopt similar logic.

---

### Finding 2: Draft PRs Provide Early Feedback Without Merging

Draft PRs enable:
- **Continuous feedback:** Sourcery reviews on each push
- **No merge pressure:** PR stays open until feature complete
- **Incremental review:** Reviewers see changes as they happen
- **Single PR:** All changes in one place

**Workflow:**
```
develop → feat/feature
  └── Open draft PR immediately after first commit
  └── Phase 1 → Push → Sourcery reviews → Fix issues
  └── Phase 2 → Push → Sourcery reviews → Fix issues
  └── Mark ready for review when complete
  └── Final review → Merge
```

**Source:** Web search on draft PR workflows, GitHub documentation

**Relevance:** This preserves early feedback while maintaining branch isolation.

---

### Finding 3: The Real Value is Per-Push Feedback, Not Per-Merge

Looking at the current workflow:
- Sourcery reviews happen when PR is opened/updated
- Reviews are stored in `admin/feedback/sourcery/pr##.md`
- Fixes are made BEFORE merge

**Key insight:** The value is **feedback before code solidifies**, not the merge itself.

A draft PR achieves the same:
- Push to feature branch → Sourcery reviews
- Fix issues on feature branch → Push again → New review
- Iterate until quality is good
- Merge when feature is complete

**Source:** Analysis of `admin/feedback/sourcery/` files, `task-phase.md`

**Relevance:** Draft PRs preserve the feedback loop without requiring incremental merges.

---

### Finding 4: Single Draft PR Aligns with Self-Contained Philosophy

| Approach | Isolation | Early Feedback | Complexity |
|----------|-----------|----------------|------------|
| Phase PRs to develop | ❌ Poor | ✅ Excellent | 🟡 Medium |
| Single PR at end | ✅ Excellent | ❌ Poor | ✅ Simple |
| Draft PR throughout | ✅ Excellent | ✅ Excellent | ✅ Simple |

**Draft PR advantages:**
- Feature branch stays isolated until complete
- Sourcery reviews on every push
- Documentation stays on feature branch
- Single PR number for entire feature
- Easy to track feature progress

**Source:** Analysis and comparison

**Relevance:** Draft PR is the best balance for self-contained workflow.

---

### Finding 5: Workflow Modification is Minimal

The existing commands need only minor adjustments:

**Current `/task-phase` workflow:**
1. Complete task → Commit → Push
2. After all tasks: Create PR → Review → Merge

**Modified workflow:**
1. First task → Commit → Push → **Open Draft PR**
2. Subsequent tasks → Commit → Push → **Sourcery reviews automatically**
3. All tasks complete → **Mark Ready for Review** → Merge

**Changes needed:**
- Add `--draft` flag to `/pr` command (or auto-detect first PR)
- Document draft PR workflow in commands
- No changes to `task-phase` itself

**Source:** Workflow analysis

**Relevance:** Low implementation effort, high value.

---

### Finding 6: Sourcery CLI Exists But Has Limitations

Sourcery does offer CLI tools, but:
- Requires paid subscription for full features
- GitHub integration is more seamless
- Draft PR approach already gives per-push feedback

**Recommendation:** Use draft PR approach rather than CLI.

**Source:** Web search on Sourcery CLI

**Relevance:** Draft PRs are the simpler, more integrated solution.

---

## 🔍 Analysis

**Core insight:** The self-contained workflow doesn't have to sacrifice early feedback. 
Draft PRs provide the best of both worlds:

1. **Isolation:** Feature branch stays independent until merge
2. **Early feedback:** Sourcery reviews on every push
3. **Simplicity:** One PR per feature (not per phase)
4. **Atomic merge:** All docs + code merge together

**The key workflow change:**
- Open draft PR at start of feature (not end)
- Get continuous feedback throughout development
- Mark ready when feature is complete
- Merge atomically

**Key Insights:**
- [x] Insight 1: Draft PRs preserve feedback without requiring phase merges
- [x] Insight 2: Current workflow's value is per-push feedback, not per-merge
- [x] Insight 3: Single draft PR aligns perfectly with self-contained philosophy
- [x] Insight 4: Minimal changes needed to existing commands
- [x] Insight 5: Sourcery CLI is not needed - draft PR approach is superior

---

## 💡 Recommendations

- [x] Recommendation 1: Use draft PR workflow for self-contained features
- [x] Recommendation 2: Open draft PR after first meaningful commit
- [x] Recommendation 3: Push frequently to get incremental Sourcery feedback
- [x] Recommendation 4: Mark ready for review only when feature is complete
- [x] Recommendation 5: Keep single PR per feature (not per phase)
- [x] Recommendation 6: Update `/pr` command to support `--draft` flag

---

## 📋 Requirements Discovered

- [x] FR-20: Features SHOULD open draft PR after first commit
- [x] FR-21: Draft PRs SHOULD be used for early Sourcery feedback
- [x] FR-22: `/pr` command SHOULD support `--draft` flag for initial PR
- [x] NFR-11: Features SHOULD push frequently for incremental feedback
- [x] NFR-12: Single PR per feature (not per phase) for self-contained workflow
- [x] C-4: Draft PR workflow requires GitHub (or similar platform with draft PR support)

---

## 🚀 Next Steps

1. ✅ Research complete
2. Update summary and requirements docs
3. All 6 research topics complete - ready for decision phase!

---

**Last Updated:** 2026-01-09
