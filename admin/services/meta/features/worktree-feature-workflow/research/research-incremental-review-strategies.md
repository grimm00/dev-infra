# Research: Incremental Review Strategies

**Research Topic:** Worktree Feature Workflow  
**Question:** How can we get incremental reviews (only new changes) instead of full-PR reviews?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2026-01-09  
**Completed:** 2026-01-09

---

## 🎯 Research Question

How can we manipulate what Sourcery (or other reviewers) see to get incremental feedback on only new changes, not the entire PR diff?

**Sub-questions:**

- Can Sourcery review only specific commit ranges?
- Can we create PRs that target the feature branch itself (sub-PRs)?
- What does GitHub provide for "changes since last review"?
- What are the trade-offs of each approach?

---

## 🔍 Discovery Context

**During dogfooding PR #59:**

1. Created draft PR (`feat/worktree-feature-workflow → develop`)
2. Triggered Sourcery review with `@sourcery-ai review`
3. Made fixes, pushed commits
4. Triggered another Sourcery review
5. **Observed:** Sourcery commented on the same issues again

**Root cause:** Sourcery reviews the _entire PR diff_ each time, not just the delta since last review.

---

## 📊 Findings

### Finding 1: Sourcery Reviews Full PR Diff

Each `@sourcery-ai review` trigger:

- Compares: `base branch (develop) → HEAD of feature branch`
- Sees: **All changes** since branch divergence
- Result: Re-comments on unfixed issues

**This is expected behavior** - Sourcery doesn't track "what it already reviewed."

```
PR Diff = base (develop) → HEAD (feat/feature)
        = ALWAYS the complete set of changes
```

**Source:** Practical testing on PR #59

---

### Finding 2: GitHub Has "Changes Since Last Review" But...

GitHub offers a "Changes since last review" button in the PR interface that:

- Shows diff of commits since last human review
- Works by comparing commit SHAs
- **Limitation:** Breaks after rebase/force push
- **Limitation:** Only for human reviewers, not automated tools like Sourcery

**Source:** Web search, GitHub documentation

**Relevance:** Not usable for Sourcery - Sourcery isn't a "reviewer" in GitHub's sense.

---

### Finding 3: GitHub API Compare Endpoint

The GitHub API allows comparing specific commits:

```bash
# Compare two commits
curl -H "Accept: application/vnd.github.v3.diff" \
     https://api.github.com/repos/{owner}/{repo}/compare/{base}...{head}
```

**This could enable:**

- Saving the "reviewed commit" SHA after each review
- Comparing new head vs reviewed commit
- Getting just the incremental diff

**Limitation:** Would require custom tooling - Sourcery doesn't use this pattern.

**Source:** GitHub API documentation

---

### Finding 4: Sub-PR Pattern (PRs into Feature Branch)

**The user's idea:**

```
develop
  └── feat/my-feature (main feature branch)
        ├── feat/my-feature-phase-1 → PR → feat/my-feature (small, reviewed)
        ├── feat/my-feature-phase-2 → PR → feat/my-feature (small, reviewed)
        └── ... (finally merge feat/my-feature → develop)
```

**How it works:**

1. Create main feature branch (`feat/my-feature`)
2. For each phase/increment, create sub-branch
3. Open PR from sub-branch → feature branch
4. Sourcery reviews just the sub-PR diff
5. Merge sub-PR into feature branch
6. When complete, merge feature branch to develop

**Advantages:**

- ✅ Sourcery sees only the incremental changes
- ✅ Clean, focused reviews
- ✅ Feature branch accumulates all changes
- ✅ Final PR to develop is atomic

**Disadvantages:**

- ⚠️ More branch management
- ⚠️ More PRs to create/manage
- ⚠️ PR numbers don't tell the whole story
- ⚠️ Each sub-PR merge creates a commit

**Source:** User suggestion, analysis

---

### Finding 5: Fixup Commits Pattern

An alternative approach using fixup commits:

```bash
# Make a fix for a previous commit
git commit --fixup=<sha-of-original-commit>

# Later, squash fixups into original commits
git rebase -i --autosquash origin/develop
```

**How it helps:**

- Keeps commit history clean
- GitHub's "Files changed" shows actual changes
- Reviewers can see commit-by-commit changes
- **But:** Sourcery still reviews full PR diff

**Source:** Web search, GitHub best practices

**Relevance:** Helps human reviewers but doesn't change Sourcery behavior.

---

### Finding 6: Sourcery CLI Limitations

Searched for Sourcery CLI options for incremental reviews:

- Sourcery CLI exists (`pip install sourcery`)
- Primary use: local refactoring suggestions
- No documented `--since [commit]` option
- GitHub integration is the recommended approach

**Conclusion:** CLI doesn't solve the incremental review problem.

**Source:** Web search for Sourcery CLI documentation

---

## 🔍 Analysis

### Option Comparison

| Approach                 | Incremental Review? | Complexity | Branch Isolation | Sourcery Works? |
| ------------------------ | ------------------- | ---------- | ---------------- | --------------- |
| **Fix before re-review** | ⚠️ Manual           | ✅ Simple  | ✅ Yes           | ✅ Yes          |
| **Sub-PR pattern**       | ✅ Yes              | 🟠 Medium  | ✅ Yes           | ✅ Yes          |
| **Custom API tooling**   | ✅ Yes              | 🔴 High    | ✅ Yes           | ❌ Custom       |
| **Sourcery CLI**         | ❌ No               | ✅ Simple  | ✅ Yes           | ❌ Limited      |

### Sub-PR Pattern in Detail

**Workflow:**

```
1. git checkout develop
2. git checkout -b feat/my-feature          # Main feature branch
3. git checkout -b feat/my-feature-phase-1  # Sub-branch for phase 1

4. # Do phase 1 work...
5. git push -u origin feat/my-feature-phase-1
6. gh pr create --base feat/my-feature --draft  # PR into feature branch!

7. # Sourcery reviews only phase 1 changes
8. # Fix issues, push
9. gh pr merge --squash  # Merge into feature branch

10. git checkout feat/my-feature
11. git pull
12. git checkout -b feat/my-feature-phase-2  # Next sub-branch
13. # Repeat...

14. # When feature complete:
15. git checkout feat/my-feature
16. gh pr create --base develop  # Final PR with all phases
```

**Key insight:** By targeting PRs at the feature branch instead of develop:

- Each sub-PR has a focused diff
- Sourcery reviews only what's in that sub-PR
- Feature branch accumulates all changes
- Final merge to develop is one atomic PR

---

## 💡 Recommendations

### Recommendation 1: "Fix Before Re-Review" as Primary Pattern ✅

**This is the recommended approach for most features.**

> **Best Practice:** Fix Sourcery issues before requesting another phase review. Each `/pr --review` triggers a fresh review of the entire PR, so unfixed issues will generate duplicate comments.

**Why this works:**

- Keeps workflow simple (one draft PR per feature)
- **Reduces total PRs** compared to old phase-by-phase PR workflow
- Natural gate for "Definition of Done" per phase
- No additional tooling required

**Workflow:**

```
1. Open draft PR after first commit
2. Phase 1 → Push → /pr --review
3. Fix Sourcery issues ← KEY STEP (before next phase)
4. Phase 2 → Push → /pr --review
5. Fix Sourcery issues
6. ... repeat ...
7. Mark ready for review
8. Final merge

Result: 1 PR per feature, clean review history
```

### Recommendation 2: Sub-PRs as Escape Hatch (Edge Cases Only)

For unusually large features (8+ phases or massive code changes), the sub-PR pattern remains an option:

```
feat/my-feature-phase-1 → PR → feat/my-feature (not develop)
```

**When to consider:**

- Feature spans multiple weeks
- 8+ distinct phases
- Different team members working on phases
- Review history becoming unwieldy

**For most features:** Use the simpler "fix before re-review" pattern.

### Recommendation 3: Document in Workflow Guide

Phase 4 documentation should include:

- Explanation that Sourcery reviews full PR diff
- "Fix before re-review" as the standard practice
- PR count benefit (1 PR vs many)
- Sub-PRs mentioned as advanced option

### Recommendation 4: No Additional Tooling Needed

The current `/pr --review` command is sufficient. No need for:

- `--base` flag for sub-PRs (keep it simple)
- Deduplication in `dt-review` (not a bug)
- Complex incremental review tooling

---

## 📋 Requirements Discovered

- [x] FR-23: Documentation MUST explain full-PR review behavior
- [x] FR-24: Workflow MUST recommend "fix before re-review" pattern
- [x] NFR-13: Draft PR workflow SHOULD result in 1 PR per feature
- [x] NFR-14: Sub-PRs documented as escape hatch for edge cases only

---

## 🔑 Key Insight

**The draft PR workflow already solves the "too many PRs" problem.** The "fix before re-review" discipline makes it work without duplicates. This is a workflow adjustment, not a tooling problem.

| Workflow                        | PRs per Feature               |
| ------------------------------- | ----------------------------- |
| Old (phase PRs to develop)      | ~3-5 PRs                      |
| **New (draft PR + discipline)** | **1 PR**                      |
| Sub-PR pattern                  | ~4-6 PRs (defeats simplicity) |

---

## 🚀 Next Steps

1. ✅ Research complete
2. ✅ "Fix before re-review" selected as primary pattern
3. Update Phase 4 documentation with this insight
4. ADR-003 update can be included in Phase 4 deliverables

---

**Last Updated:** 2026-01-09
