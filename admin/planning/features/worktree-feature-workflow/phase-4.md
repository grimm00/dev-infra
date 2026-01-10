# Worktree Feature Workflow - Phase 4: Documentation

**Phase:** 4 - Documentation  
**Duration:** ~1-2 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 3 complete

---

## 📋 Overview

Document the complete worktree feature workflow including naming conventions, self-contained branches, draft PR workflow, and the "fix before re-review" pattern.

**Success Definition:** Complete workflow documentation exists and cursor rules are updated.

---

## 🎯 Goals

1. **Create workflow guide** - New WORKTREE-WORKFLOW.md document
2. **Update ADR-003** - Add "fix before re-review" pattern from dogfooding
3. **Update cursor rules** - Add workflow guidance to main.mdc and workflow.mdc
4. **Cross-reference** - Link from related documents

---

## 📝 Tasks

### Task 4.1: Create WORKTREE-WORKFLOW.md

**Goal:** Create comprehensive workflow guide for users.

**Document Structure:**

```markdown
# Worktree Feature Workflow

## Overview
- What is this workflow?
- Benefits (isolated development, reduced PRs, early feedback)

## Setup
- Creating worktrees
- Naming conventions (ADR-001)

## Development Workflow
- Self-contained branches (ADR-002)
- Draft PR workflow (ADR-003)
- Sourcery configuration (ADR-004)

## Review Workflow
- Opening draft PR after first commit
- Triggering Sourcery reviews
- "Fix before re-review" pattern
- Marking ready when complete

## Best Practices
- 1 PR per feature (not per phase)
- Fix issues before next phase review
- Push frequently, review at milestones

## Commands
- /pr --draft, --ready, --review
```

**Checklist:**
- [x] Create `docs/WORKTREE-WORKFLOW.md`
- [x] Include all 4 ADRs' decisions
- [x] Document "fix before re-review" pattern
- [x] Add examples and code snippets
- [x] Include PR count comparison (old vs new)

---

### Task 4.2: Update ADR-003 with Dogfooding Insights

**Goal:** Add the "fix before re-review" pattern discovered during dogfooding.

**Updates needed:**

1. Add "Fix Before Re-Review" section explaining:
   - Sourcery reviews entire PR diff each time
   - Unfixed issues generate duplicate comments
   - Solution: Fix issues before requesting next review

2. Update "Key Properties" table:
   - Add row about review discipline

3. Add "Dogfooding Insight" section:
   - PR count comparison (1 PR vs 3-5 PRs)
   - Link to incremental review research

**Checklist:**
- [x] Add "Fix Before Re-Review" section to ADR-003
- [x] Update consequences section
- [x] Add reference to incremental review research

---

### Task 4.3: Update Cursor Rules

**Goal:** Add workflow guidance to cursor rules for AI assistance.

**Files to update:**

1. **`.cursor/rules/main.mdc`**
   - Add reference to worktree workflow
   - Update "Current Project State" section

2. **`.cursor/rules/workflow.mdc`**
   - Add "Worktree Feature Workflow" section
   - Document draft PR workflow
   - Document "fix before re-review" pattern

**Checklist:**
- [ ] Update main.mdc with workflow reference
- [ ] Add worktree workflow section to workflow.mdc
- [ ] Include draft PR guidance
- [ ] Document review discipline

---

### Task 4.4: Update Cross-References

**Goal:** Link workflow guide from related documents.

**Documents to update:**

1. **`docs/WORKTREE-GUIDE.md`** - Add link to workflow
2. **`docs/README.md`** - Add link in documentation index
3. **`docs/COMMIT-WORKFLOW.md`** - Reference new workflow

**Checklist:**
- [ ] Update docs/WORKTREE-GUIDE.md with workflow link
- [ ] Update docs/README.md with workflow link
- [ ] Update docs/COMMIT-WORKFLOW.md with reference

---

### Task 4.5: Final Verification

**Goal:** Verify documentation completeness and accuracy.

**Checklist:**
- [ ] All 4 ADRs referenced in workflow guide
- [ ] "Fix before re-review" documented
- [ ] Commands documented correctly
- [ ] Cross-references working
- [ ] Cursor rules updated

---

## ✅ Completion Criteria

- [ ] `docs/WORKTREE-WORKFLOW.md` exists and is comprehensive
- [ ] ADR-003 updated with dogfooding insights
- [ ] Cursor rules reference new workflow
- [ ] Related documents link to workflow guide
- [ ] Documentation reflects 1-PR-per-feature pattern

---

## 📦 Deliverables

| Deliverable | Description |
|-------------|-------------|
| `docs/WORKTREE-WORKFLOW.md` | Complete workflow guide |
| `admin/decisions/worktree-feature-workflow/adr-003-draft-pr-review-workflow.md` | Updated with dogfooding insights |
| `.cursor/rules/main.mdc` | Updated with workflow reference |
| `.cursor/rules/workflow.mdc` | New worktree workflow section |
| Updated cross-references | Links from related docs |

---

## 🔑 Key Content: Fix Before Re-Review Pattern

This is a critical insight from dogfooding that must be documented:

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

**Why this matters:**
- Sourcery reviews entire PR diff each time
- Unfixed issues → duplicate comments
- This discipline prevents duplicates naturally
- Reduces PRs from ~3-5 to 1 per feature

---

## 🔗 Dependencies

### Prerequisites

- Phase 3 complete ✅

### Blocks

- Feature complete (this is the last phase)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 3](phase-3.md)
- [ADR-001: Worktree Location](../../decisions/worktree-feature-workflow/adr-001-worktree-location-and-naming.md)
- [ADR-002: Self-Contained Branches](../../decisions/worktree-feature-workflow/adr-002-self-contained-feature-branches.md)
- [ADR-003: Draft PR Workflow](../../decisions/worktree-feature-workflow/adr-003-draft-pr-review-workflow.md)
- [ADR-004: Sourcery Configuration](../../decisions/worktree-feature-workflow/adr-004-sourcery-configuration.md)
- [Research: Incremental Review Strategies](../../research/worktree-feature-workflow/research-incremental-review-strategies.md)

---

**Last Updated:** 2026-01-09  
**Status:** 🟠 In Progress  
**Next:** `/task-phase 4 1` to implement Task 4.1
