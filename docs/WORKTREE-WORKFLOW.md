# Worktree Feature Workflow

**Purpose:** Complete guide for feature development using git worktrees and draft PRs  
**Status:** ✅ Active  
**Last Updated:** 2026-01-09

---

## 📋 Overview

The Worktree Feature Workflow is a streamlined approach to feature development that combines:

- **Git worktrees** for isolated development environments
- **Self-contained feature branches** for atomic, portable features
- **Draft PRs** for continuous feedback during development
- **Sourcery configuration** to reduce review noise

**Key Benefits:**

| Benefit | Description |
|---------|-------------|
| 🔒 **Isolation** | Features stay independent until merge |
| 📉 **Reduced PRs** | 1 PR per feature (vs 3-5 with phase-based PRs) |
| 🔍 **Early Feedback** | Sourcery reviews throughout development |
| 🧹 **Clean Abandonment** | Delete branch = no leftover docs |
| ⚛️ **Atomic Merge** | All code + docs merge together |

---

## 🏗️ Setup

### Creating a Worktree

```bash
# From your main repository
cd /path/to/project

# Create worktree for a new feature
git worktree add worktrees/feat-my-feature -b feat/my-feature

# Open in Cursor
cursor worktrees/feat-my-feature
```

### Naming Conventions (ADR-001)

**Directory names mirror branch names** (replacing `/` with `-`):

| Branch Name | Worktree Directory |
|-------------|-------------------|
| `feat/my-feature` | `worktrees/feat-my-feature` |
| `fix/bug-123` | `worktrees/fix-bug-123` |
| `feat/phase-1-config` | `worktrees/feat-phase-1-config` |

**Standard location:** `worktrees/` directory at project root

**Why `worktrees/`?**
- Avoids Cursor confirmation prompts (unlike `.cursor/worktrees/`)
- Clear, visible location
- Automatically gitignored

### .gitignore Configuration

Add to your `.gitignore`:

```gitignore
# Git worktrees (created with `git worktree add`)
worktrees/

# Temporary files (handoff docs, scratch)
tmp/
```

---

## 🔄 Development Workflow

### Self-Contained Feature Branches (ADR-002)

**All feature-related content stays on the feature branch:**

```
feat/my-feature/
├── admin/
│   ├── explorations/my-feature/    # Initial exploration
│   ├── research/my-feature/        # Research documents
│   ├── decisions/my-feature/       # ADRs
│   └── planning/features/my-feature/  # Phase plans
├── src/                            # Implementation
├── tests/                          # Tests
└── docs/                           # User documentation
```

**Benefits:**
- Feature is self-contained and portable
- No cleanup needed on `develop` if feature is abandoned
- All context merges atomically when complete
- Easy to hand off to another developer

### Draft PR Workflow (ADR-003)

**Open a draft PR early and use it throughout development:**

```
1. First meaningful commit → Push → Open Draft PR
2. Phase 1 work → Push → Request Sourcery review
3. Fix issues → Push
4. Phase 2 work → Push → Request Sourcery review
5. Fix issues → Push
6. ... repeat ...
7. Mark ready for review → Final review → Merge
```

**Commands:**

```bash
# Create initial draft PR
/pr --draft --feature my-feature

# Request Sourcery review at milestones
/pr --review

# Mark ready when feature is complete
/pr --ready
```

**Important:** Sourcery does NOT automatically review draft PRs. You must explicitly request reviews:

```bash
# Via command
/pr --review

# Or via GitHub CLI
gh pr comment [PR-number] --body "@sourcery-ai review"
```

### Sourcery Configuration (ADR-004)

Create `.sourcery.yaml` to ignore process documentation:

```yaml
# .sourcery.yaml
# Ignore process documentation to focus code review on actual code

ignore:
  - admin/**     # Process docs (explorations, research, decisions, planning)
  - tmp/**       # Temporary files (handoff docs, scratch)
```

**Why ignore these?**
- Sourcery focuses on code quality, not documentation
- Reduces noise in PR reviews
- Process docs are for humans, not linters

---

## 🔍 Review Workflow

### The "Fix Before Re-Review" Pattern

**Critical insight from dogfooding:**

Sourcery reviews the **entire PR diff** each time `@sourcery-ai review` is triggered. This means:
- Unfixed issues will generate duplicate comments
- Multiple reviews without fixes = noisy review history

**Solution:** Fix Sourcery issues before requesting the next review.

```
Draft PR Workflow (refined)
─────────────────────────────
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

### PR Count Comparison

| Workflow | PRs per Feature | Description |
|----------|-----------------|-------------|
| **Old (phase PRs)** | ~3-5 PRs | Each phase merges to develop |
| **New (draft PR)** | **1 PR** | Single draft PR, merge at end |

The draft PR workflow dramatically reduces the number of PRs while maintaining continuous feedback.

### When to Request Reviews

Request Sourcery review (`/pr --review`) at meaningful milestones:

- ✅ After completing a phase
- ✅ After significant implementation
- ✅ Before marking PR as ready
- ❌ Not after every tiny commit
- ❌ Not when previous issues are unfixed

### Marking Ready for Review

When the feature is complete:

```bash
# Mark draft PR as ready
/pr --ready

# This:
# - Converts draft to regular PR
# - Triggers final Sourcery review
# - Notifies reviewers
```

**Pre-Ready Checklist:**

- [ ] All phases complete
- [ ] All tests passing
- [ ] Sourcery issues addressed
- [ ] Documentation updated
- [ ] Manual testing done (if applicable)

---

## 💡 Best Practices

### 1. One PR Per Feature

**Do:** Open single draft PR at start, merge at end  
**Don't:** Create multiple PRs for phases within a feature

### 2. Fix Before Re-Review

**Do:** Address Sourcery issues before requesting next review  
**Don't:** Request multiple reviews without fixing issues (creates duplicates)

### 3. Push Frequently, Review at Milestones

**Do:** Push often to back up work, request reviews at phase boundaries  
**Don't:** Wait until the end to push or review

### 4. Keep Features Self-Contained

**Do:** All exploration, research, decisions, and planning on feature branch  
**Don't:** Put feature docs on `develop` before feature is complete

### 5. Use Meaningful Worktree Names

**Do:** `worktrees/feat-user-auth` (mirrors branch name)  
**Don't:** `worktrees/work1`, `worktrees/temp`

---

## 🛠️ Commands Reference

### Draft PR Commands

| Command | Description |
|---------|-------------|
| `/pr --draft` | Create draft PR for current feature |
| `/pr --draft --feature [name]` | Create draft PR for specific feature |
| `/pr --review` | Request Sourcery review on current draft PR |
| `/pr --ready` | Mark draft PR as ready for final review |

### Worktree Management

```bash
# Create worktree with new branch
git worktree add worktrees/feat-my-feature -b feat/my-feature

# List all worktrees
git worktree list

# Remove worktree (after merge)
git worktree remove worktrees/feat-my-feature

# Clean up stale references
git worktree prune
```

### Sourcery Review (Manual)

```bash
# Trigger Sourcery review via GitHub CLI
gh pr comment [PR-number] --body "@sourcery-ai review"
```

---

## 📊 Complete Example

### Starting a New Feature

```bash
# 1. Create worktree
cd /path/to/project
git worktree add worktrees/feat-user-auth -b feat/user-auth

# 2. Open in Cursor
cursor worktrees/feat-user-auth

# 3. Do initial exploration
# Create: admin/explorations/user-auth/exploration.md

# 4. First meaningful commit
git add .
git commit -m "docs(exploration): add user-auth exploration"
git push -u origin feat/user-auth

# 5. Open draft PR
/pr --draft --feature user-auth
```

### Developing the Feature

```bash
# 6. Complete research phase
# Create: admin/research/user-auth/*.md
git add . && git commit -m "docs(research): complete user-auth research"
git push

# 7. Request review at milestone
/pr --review

# 8. Fix any Sourcery issues
# ... make fixes ...
git add . && git commit -m "fix: address Sourcery review feedback"
git push

# 9. Continue with implementation phases
# ... implement code, tests, docs ...
git add . && git commit -m "feat(user-auth): implement authentication"
git push

# 10. Request review at next milestone
/pr --review

# 11. Repeat until feature complete
```

### Completing the Feature

```bash
# 12. Final fixes and cleanup
git add . && git commit -m "chore: final cleanup before merge"
git push

# 13. Mark ready for review
/pr --ready

# 14. Final human review

# 15. Merge (via GitHub)

# 16. Clean up worktree
cd /path/to/project
git worktree remove worktrees/feat-user-auth
```

---

## 🔗 Related Documents

### Architecture Decisions

- [ADR-001: Worktree Location and Naming](../admin/services/meta/features/worktree-feature-workflow/decisions/adr-001-worktree-location-and-naming.md)
- [ADR-002: Self-Contained Feature Branches](../admin/services/meta/features/worktree-feature-workflow/decisions/adr-002-self-contained-feature-branches.md)
- [ADR-003: Draft PR Review Workflow](../admin/services/meta/features/worktree-feature-workflow/decisions/adr-003-draft-pr-review-workflow.md)
- [ADR-004: Sourcery Configuration](../admin/services/meta/features/worktree-feature-workflow/decisions/adr-004-sourcery-configuration.md)

### Research

- [Incremental Review Strategies](../admin/services/meta/features/worktree-feature-workflow/research/research-incremental-review-strategies.md)
- [Phase-Based Review](../admin/services/meta/features/worktree-feature-workflow/research/research-phase-based-review.md)

### Other Guides

- [Worktree Multi-Agent Guide](WORKTREE-GUIDE.md) - Using worktrees with multiple Cursor agents
- [Commit Workflow](COMMIT-WORKFLOW.md) - Commit message conventions

---

**Last Updated:** 2026-01-09  
**Status:** ✅ Active
