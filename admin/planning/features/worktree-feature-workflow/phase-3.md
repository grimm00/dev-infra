# Worktree Feature Workflow - Phase 3: Command Updates

**Phase:** 3 - Command Updates  
**Duration:** ~1 hour  
**Status:** ✅ Complete  
**Completed:** 2026-01-09  
**Prerequisites:** Phase 2 complete

---

## 📋 Overview

Update the `/pr` command to support the `--draft` flag for creating initial draft PRs.

**Success Definition:** `/pr --draft` creates draft PRs for continuous Sourcery feedback.

---

## 🎯 Goals

1. **Add --draft flag** - Update /pr command to support draft PR creation
2. **Add --ready flag** - Mark draft PR as ready for review
3. **Add --review flag** - Trigger Sourcery review on draft PR (manual trigger required!)
4. **Document workflow** - Add draft PR workflow to command documentation
5. **Update usage examples** - Show draft PR usage patterns

---

## 📝 Tasks

### Task 1: Add Draft PR Section to /pr Command

**Purpose:** Document the `--draft` flag for creating draft PRs with initial commits.

**Implementation Steps:**

1. **Update Usage section:**
   - [x] Add new "Draft PR Mode" to command modes
   - [x] Document `--draft` flag usage

2. **Add Draft PR Mode section:**
   - [x] Create new section "Draft PR Mode (`--draft`)"
   - [x] Document when to use draft PRs
   - [x] Document workflow for draft PR creation

**Content to Add to Usage section (after existing modes):**

```markdown
4. **Draft PR:** `/pr --draft [--feature feature-name]`
   - Example: `/pr --draft`
   - Example: `/pr --draft --feature my-feature`
   - Creates draft PR for early feedback
   - Use at start of feature for continuous Sourcery review
```

**Content to Add (new section after Fix PR Mode):**

```markdown
## Draft PR Mode (`--draft`)

### When to Use

Use draft PRs when:
- Starting a new feature branch
- Want early Sourcery feedback during development
- Following self-contained feature branch workflow
- Not ready for merge but want continuous review

### Workflow

1. Create feature branch from develop
2. Make first meaningful commit
3. Run `/pr --draft` to open draft PR
4. Continue development with regular pushes
5. Request Sourcery reviews at milestones with `/pr --review`
6. When complete, run `/pr --ready` to mark ready for merge

### Create Draft PR

**Command:**

```bash
/pr --draft --feature [feature-name]
```

**Steps:**

1. **Verify branch:**
   ```bash
   git branch --show-current
   # Expected: feat/[feature-name] or similar
   ```

2. **Push branch:**
   ```bash
   git push -u origin [branch-name]
   ```

3. **Create draft PR:**
   ```bash
   gh pr create --draft \
     --title "feat: [Feature Name] (WIP)" \
     --body "[Description - work in progress]" \
     --base develop
   ```

4. **Note PR number** for future reference

### Draft PR Template

```markdown
## [Feature Name] - Work in Progress

**Status:** 🟠 In Progress  
**Branch:** feat/[feature-name]

---

## Overview

[Brief description of the feature being developed]

---

## Current Progress

- [ ] Phase 1: [Description]
- [ ] Phase 2: [Description]
- [ ] Phase N: [Description]

---

## Notes

- This is a draft PR for early feedback
- Sourcery reviews requested at milestones
- Will mark ready when feature complete
```
```

**Checklist:**

- [x] Usage section updated with Draft PR mode
- [x] Draft PR Mode section created
- [x] Workflow documented
- [x] Template provided
- [x] When to use documented

---

### Task 2: Add --ready Flag Documentation

**Purpose:** Document the `--ready` flag for marking draft PRs as ready for review.

**Implementation Steps:**

1. **Add --ready to Options section:**
   - [x] Document `--ready` flag
   - [x] Document usage pattern

2. **Add Ready PR section:**
   - [x] Create section for marking PR ready
   - [x] Document steps

**Content to Add to Options section:**

```markdown
- `--ready` - Mark draft PR as ready for review (convert from draft to ready)
```

**Content to Add (after Draft PR Mode section):**

```markdown
## Mark PR Ready (`--ready`)

### When to Use

Use `--ready` when:
- Feature development is complete
- All phases implemented
- Ready for final review and merge
- Draft PR exists and needs to be converted

### Command

```bash
/pr --ready --feature [feature-name]
```

### Steps

1. **Find PR number:**
   ```bash
   gh pr list --state open --head [branch-name]
   ```

2. **Mark ready:**
   ```bash
   gh pr ready [PR-number]
   ```

3. **Optionally update title (remove WIP):**
   ```bash
   gh pr edit [PR-number] --title "feat: [Feature Name]"
   ```

### Checklist Before Marking Ready

- [ ] All phases complete
- [ ] All tests passing
- [ ] Documentation updated
- [ ] Sourcery issues addressed
- [ ] Ready for final review
```

**Checklist:**

- [x] --ready option documented
- [x] Ready PR section created
- [x] Steps documented
- [x] Checklist provided

---

### Task 3: Add --review Flag Documentation

**Purpose:** Document the `--review` flag for triggering Sourcery review on draft PRs.

**Implementation Steps:**

1. **Add --review to Options section:**
   - [x] Document `--review` flag
   - [x] Note that Sourcery doesn't auto-review drafts

2. **Add Review Request section:**
   - [x] Create section for requesting Sourcery review
   - [x] Document manual trigger command

**Content to Add to Options section:**

```markdown
- `--review` - Request Sourcery review on draft PR (triggers `@sourcery-ai review`)
```

**Content to Add (after Mark PR Ready section):**

```markdown
## Request Sourcery Review (`--review`)

### Important: Sourcery Does NOT Auto-Review Draft PRs

Draft PRs do not trigger automatic Sourcery reviews. You must manually request a review:

```bash
/pr --review --feature [feature-name]
```

### When to Request Review

Request Sourcery review at:
- After completing a phase
- After significant changes
- Before marking PR ready
- At development milestones

### Command

```bash
/pr --review --feature [feature-name]
```

### Steps

1. **Find PR number:**
   ```bash
   gh pr list --state open --head [branch-name]
   ```

2. **Request review:**
   ```bash
   gh pr comment [PR-number] --body "@sourcery-ai review"
   ```

3. **Wait for review** (usually 1-2 minutes)

4. **Save review feedback** (optional):
   - Copy Sourcery comments to `admin/feedback/sourcery/pr[number].md`

### Note on Review Frequency

- Request review at meaningful milestones, not every commit
- Each review provides feedback on current state vs. base branch
- Too frequent reviews may generate noise for incremental changes
```

**Checklist:**

- [x] --review option documented
- [x] Review Request section created
- [x] Manual trigger documented
- [x] When to request documented
- [x] Steps provided

---

### Task 4: Add Integration Section

**Purpose:** Document how draft PR workflow integrates with existing commands and ADR-003.

**Implementation Steps:**

1. **Update Integration section:**
   - [x] Add draft PR workflow integration
   - [x] Reference ADR-003

**Content to Add (update Integration with Other Commands section):**

```markdown
### Draft PR Workflow (Worktree Feature)

1. Start feature: `git checkout -b feat/[feature-name]`
2. First commit: Make meaningful change, commit
3. Draft PR: `/pr --draft --feature [feature-name]`
4. Develop: Multiple commits, regular pushes
5. Review: `/pr --review` at milestones
6. Complete: `/pr --ready` when done
7. Final review: Address any remaining issues
8. Merge: PR merged to develop

**See:** [ADR-003: Draft PR Review Workflow](../decisions/worktree-feature-workflow/adr-003-draft-pr-review-workflow.md)
```

**Checklist:**

- [x] Integration section updated
- [x] Draft PR workflow documented
- [x] ADR-003 referenced

---

### Task 5: Update Command Header

**Purpose:** Update the command description and status to reflect new functionality.

**Implementation Steps:**

1. **Update command description:**
   - [x] Mention draft PR support

2. **Update Workflow Overview:**
   - [x] Add draft PR to "When to use"

**Content to Update (in opening description):**

```markdown
Centralized command for creating pull requests for phases, fix batches, and draft PRs. Provides consistent PR creation workflow with appropriate templates and validation. Also supports draft PR workflow for continuous feedback during feature development.
```

**Content to Update (in Workflow Overview - When to use):**

```markdown
**When to use:**

- After completing a phase (use `--phase`)
- After implementing a fix batch (use `--fix`)
- After completing release transition steps (use `--release`)
- To start a feature with early feedback (use `--draft`)
- To mark a draft PR ready for review (use `--ready`)
- To request Sourcery review on a draft PR (use `--review`)
- To create PRs with consistent formatting and validation
```

**Checklist:**

- [x] Description updated
- [x] Workflow Overview updated
- [x] All new flags mentioned

---

### Task 6: Update Options Table

**Purpose:** Ensure all new options are listed together in the Options section.

**Implementation Steps:**

1. **Update Options section:**
   - [x] Add `--draft` option
   - [x] Add `--ready` option  
   - [x] Add `--review` option
   - [x] Ensure options are in logical order

**Content to Add to Options section (add after `--release`):**

```markdown
**Draft PR Options:**

- `--draft` - Create draft PR for early feedback (use at start of feature)
- `--ready` - Mark draft PR as ready for review
- `--review` - Request Sourcery review on draft PR
```

**Checklist:**

- [x] All new options listed
- [x] Options grouped logically
- [x] Options have clear descriptions

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 1: Add Draft PR Mode section | ✅ Complete | Full section with workflow and template |
| Task 2: Add --ready flag documentation | ✅ Complete | Section with steps and checklist |
| Task 3: Add --review flag documentation | ✅ Complete | Section with Sourcery manual trigger |
| Task 4: Add Integration section | ✅ Complete | Draft PR Workflow added, ADR-003 referenced |
| Task 5: Update Command Header | ✅ Complete | Description and When to use updated |
| Task 6: Update Options Table | ✅ Complete | Draft PR Options group added |

---

## ✅ Completion Criteria

- [x] `/pr` command supports `--draft` flag (creates draft PR)
- [x] `/pr` command supports `--ready` flag (marks draft as ready)
- [x] `/pr` command supports `--review` flag (triggers Sourcery via comment)
- [x] Draft PR workflow documented in command
- [x] Sourcery manual trigger documented (`@sourcery-ai review`)
- [x] Usage examples show draft PR pattern
- [x] Command integrates with ADR-003 workflow
- [ ] Changes committed

---

## 📦 Deliverables

- Updated `.cursor/commands/pr.md`

---

## 💡 Implementation Notes

### Key Insight: Sourcery Does NOT Auto-Review Draft PRs

This was discovered during dogfooding Phase 1. Draft PRs require manual Sourcery trigger:

```bash
gh pr comment [PR-number] --body "@sourcery-ai review"
```

This is why the `--review` flag is important - it provides a simple way to request reviews at milestones.

### Flag Relationships

| Flag | Purpose | Typical Usage |
|------|---------|---------------|
| `--draft` | Create initial draft PR | Start of feature |
| `--review` | Request Sourcery review | At milestones during development |
| `--ready` | Convert draft to ready | When feature complete |

### Workflow Timeline

```
Day 1: git checkout -b feat/my-feature
Day 1: First commit, push
Day 1: /pr --draft → Opens draft PR #59
Day 2: More commits, push
Day 2: /pr --review → Triggers Sourcery on #59
Day 3: Address issues, more commits
Day 4: Feature complete
Day 4: /pr --ready → Converts #59 to ready
Day 4: Final review, merge
```

---

## 🔗 Dependencies

### Prerequisites

- Phase 2 complete

### Blocks

- Phase 4 (Documentation)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 2](phase-2.md)
- [Next Phase: Phase 4](phase-4.md)
- [ADR-003: Draft PR Review Workflow](../../decisions/worktree-feature-workflow/adr-003-draft-pr-review-workflow.md)
- [Current /pr Command](.cursor/commands/pr.md)

---

**Last Updated:** 2026-01-09  
**Status:** ✅ Complete  
**Next:** Phase 4 (Documentation)
