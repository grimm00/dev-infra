# Command Documentation Update: Fix Implement PR Status Check

**Date:** 2025-12-09  
**Branch:** `docs/fix-implement-pr-status-check`  
**Status:** ✅ Merged to develop  
**Type:** Critical Workflow Fix

---

## 📋 Overview

Updated `/fix-implement` command to check source PR status before deciding whether to push fixes to an existing open PR or create a new PR. This fixes a critical workflow issue where HIGH priority fixes were being split into separate PRs instead of being included in the original PR before merge.

---

## 🎯 Problem Statement

### Issue Discovered

**What Happened:**
- PR #32 created for Release Readiness Phase 1 & 2
- `/pr-validation 32` identified HIGH priority issues
- `/fix-implement pr32-batch-high-low-01` **created NEW PR #33** ❌
- `/fix-implement pr32-batch-medium-low-01` **created NEW PR #34** ❌
- Result: 3 separate PRs instead of 1 unified PR

**What Should Have Happened:**
- PR #32 created
- `/pr-validation 32` identifies issues
- `/fix-implement pr32-batch-high-low-01` **pushes to PR #32's branch** ✅
- Result: 1 PR with all HIGH priority fixes included

### Root Cause

`/fix-implement` command did not check:
1. Is the source PR still open?
2. Is this a HIGH/CRITICAL priority fix?
3. Should fixes go to existing PR branch vs. new PR?

The command always created a new branch and new PR, regardless of PR status or fix priority.

---

## 🔧 Changes Made

### 1. Added Step 1a: Check Source PR Status

**New step inserted after Step 1 (Load Fix Plan):**

- Extracts source PR number from batch name (e.g., `pr32-batch-high-low-01` → PR #32)
- Checks PR status using `gh pr view` (OPEN/MERGED/CLOSED)
- Reads priority from fix plan file (CRITICAL/HIGH/MEDIUM/LOW)
- Determines action based on PR status + priority:
  - **PR OPEN + HIGH/CRITICAL priority** → Push to existing PR branch
  - **PR MERGED OR MEDIUM/LOW priority** → Create new PR

**Variables set:**
- `PUSH_TO_EXISTING_PR` (true/false)
- `TARGET_BRANCH` (existing PR branch OR new fix branch name)

### 2. Updated Step 2: Checkout Target Branch

**Modified to handle both cases:**

**If pushing to existing PR:**
```bash
git checkout develop
git pull origin develop
git checkout $TARGET_BRANCH  # PR's branch
git pull origin $TARGET_BRANCH
```

**If creating new PR:**
```bash
git checkout develop
git pull origin develop
git checkout -b $TARGET_BRANCH  # New fix branch
```

### 3. Updated Step 8: Create or Update PR

**Modified to handle both cases:**

**If pushing to existing PR:**
- Push commits to PR's branch
- Update PR description (append fix information)
- No new PR created

**If creating new PR:**
- Push new branch
- Create new PR with full description

---

## 📊 Impact

### Commands Enhanced

**Modified:** 1 command
- `/fix-implement` - Now checks PR status before deciding workflow

### Workflow Fixed

**Correct Workflow (HIGH/CRITICAL fixes):**
1. PR created (e.g., PR #32)
2. Issues identified in review
3. `/fix-plan 32 --priority HIGH` creates fix plans
4. `/fix-implement pr32-batch-high-low-01` **pushes to PR #32** ✅
5. PR #32 merges with all HIGH priority fixes

**Correct Workflow (MEDIUM/LOW fixes):**
1. PR merged (e.g., PR #32 merged)
2. Deferred issues tracked
3. `/fix-implement pr32-batch-medium-low-01` creates new PR ✅
4. Separate PR for post-merge fixes

### Benefits

- ✅ HIGH priority fixes included before merge
- ✅ Reduces PR fragmentation
- ✅ Simplifies review process
- ✅ Maintains correct workflow semantics
- ✅ Single PR for related changes

---

## 🔗 Related Documentation

### Workflow Issue

- **Document:** `admin/planning/notes/workflow-issue-fix-implement-pr-handling.md`
- **Created:** 2025-12-09
- **Purpose:** Documents the problem, impact, and resolution options

### Example: PR #32 Resolution

**Problem:**
- PR #32 + fix batches → Created PR #33 and PR #34 (incorrect)

**Resolution:**
- Cherry-picked commits from PR #33 and PR #34 into PR #32
- Closed PR #33 and PR #34
- Updated PR #32 description
- Result: Single PR with all fixes (correct workflow)

---

## ✅ Verification

- [x] Command documentation updated
- [x] Step 1a added with PR status check logic
- [x] Step 2 updated for both workflows
- [x] Step 8 updated for both workflows
- [x] Examples provided for both cases
- [x] Tracking document created
- [x] Command-documentation-maintenance README updated
- [x] Changes merged to develop

---

## 📝 Implementation Details

### PR Status Check Logic

```bash
# For PR-specific batches only (e.g., pr32-batch-high-low-01)
if [[ "$BATCH_NAME" =~ ^pr([0-9]+)-batch- ]]; then
    SOURCE_PR="${BASH_REMATCH[1]}"
    PR_STATE=$(gh pr view "$SOURCE_PR" --json state --jq '.state')
    PRIORITY=$(grep "^**Priority:**" "$FIX_PLAN_FILE" | sed 's/.*: //' | sed 's/ .*//')
    
    if [[ "$PR_STATE" == "OPEN" ]] && [[ "$PRIORITY" =~ (CRITICAL|HIGH) ]]; then
        # Push to existing PR branch
        PUSH_TO_EXISTING_PR=true
        TARGET_BRANCH="$PR_BRANCH"
    else
        # Create new PR
        PUSH_TO_EXISTING_PR=false
        TARGET_BRANCH="fix/$BATCH_NAME"
    fi
fi
```

### Decision Matrix

| PR State | Priority         | Action                    | New PR? |
| -------- | ---------------- | ------------------------- | ------- |
| OPEN     | CRITICAL or HIGH | Push to PR's branch       | No      |
| OPEN     | MEDIUM or LOW    | Create new branch and PR  | Yes     |
| MERGED   | Any              | Create new branch and PR  | Yes     |
| CLOSED   | Any              | Create new branch and PR  | Yes     |

---

## 🔄 Next Steps

### For Future Use

1. When running `/fix-implement` for HIGH priority fixes:
   - Command will automatically check if source PR is open
   - Will push to existing PR if open + HIGH priority
   - Will create new PR if merged or MEDIUM/LOW priority

2. Monitor workflow in practice:
   - Verify command correctly detects PR status
   - Verify priority detection works correctly
   - Verify target branch selection is correct

### Template Integration

- Command already integrated in templates (`.cursor/commands/fix-implement.md`)
- Updates will be included in next template generation
- No migration needed for existing projects (command is docs-only)

---

**Last Updated:** 2025-12-09  
**Status:** ✅ Complete

