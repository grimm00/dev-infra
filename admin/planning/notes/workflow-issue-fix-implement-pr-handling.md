# Workflow Issue: /fix-implement PR Handling

**Issue Identified:** 2025-12-09  
**Severity:** 🔴 CRITICAL  
**Status:** 🟡 Documented - Needs Fix

---

## Problem

`/fix-implement` command does not distinguish between pre-merge and post-merge fix scenarios, leading to incorrect workflow execution.

### What Happened

**Scenario:** PR #32 created → `/pr-validation 32` → HIGH priority issues found → `/fix-implement` executed

**Expected Behavior:**
1. PR #32 created
2. `/pr-validation 32` identifies HIGH priority issues
3. `/fix-plan 32 --priority HIGH` creates fix plans
4. `/fix-implement pr32-batch-high-low-01` **pushes fixes to PR #32's branch** (before merge)
5. PR #32 merges with all HIGH priority fixes included

**Actual Behavior:**
1. PR #32 created
2. `/pr-validation 32` identifies issues
3. `/fix-plan 32 --priority HIGH` creates fix plans
4. `/fix-implement pr32-batch-high-low-01` **created NEW PR #33** ❌
5. `/fix-implement pr32-batch-medium-low-01` **created NEW PR #34** ❌
6. Now have 3 PRs instead of 1

---

## Root Cause

`/fix-implement` command workflow does not check:
1. **Is source PR still open?**
2. **Is this HIGH/CRITICAL priority?**
3. **Should fixes go to existing PR branch vs. new PR?**

The command always creates a new branch and new PR, regardless of whether the source PR is still open.

---

## Impact

**Workflow Fragmentation:**
- Single PR becomes multiple PRs
- Harder to track related changes
- More PRs to review and merge
- Violates principle: "HIGH priority issues fixed before merge"

**Review Overhead:**
- Multiple PRs require multiple reviews
- Multiple CI runs
- Multiple merge operations
- Increased cognitive load

**Documentation Confusion:**
- Fix tracking becomes complex
- Unclear which PR contains which fixes
- Harder to understand fix history

---

## Correct Workflow

### Pre-Merge Fixes (HIGH/CRITICAL Priority)

**When:** Source PR is still OPEN and issues are HIGH/CRITICAL priority

**Action:**
1. Check if source PR is open: `gh pr view [pr-number] --json state`
2. If OPEN and HIGH/CRITICAL priority:
   - Checkout PR's branch (not create new branch)
   - Implement fixes on PR's branch
   - Push commits to PR's branch
   - NO new PR created
   - Update PR description with fixes

**Example:**
```bash
# PR #32 is open, fix HIGH priority issue
git checkout feat/release-readiness  # PR #32's branch
# Implement fix
git commit -m "fix: ..."
git push origin feat/release-readiness  # Updates PR #32
```

### Post-Merge Fixes (MEDIUM/LOW Priority or PR Merged)

**When:** Source PR is MERGED or issues are MEDIUM/LOW priority

**Action:**
1. Create new branch from develop
2. Implement fixes
3. Create new PR
4. Reference original PR in description

**Example:**
```bash
# PR #32 is merged, fix MEDIUM priority issue
git checkout develop
git checkout -b fix/pr32-batch-medium-low-01
# Implement fix
git commit -m "fix: ..."
git push origin fix/pr32-batch-medium-low-01
gh pr create ...  # New PR
```

---

## Required Fix

### Update `/fix-implement` Command

**Add Step 1a: Check Source PR Status**

**Location:** `.cursor/commands/fix-implement.md`

**Add after "Step 1: Load Fix Plan":**

```markdown
### 1a. Check Source PR Status (NEW)

**For PR-Specific Batches Only:**

**Determine if source PR is still open:**

1. **Extract source PR number from batch name:**
   - Example: `pr32-batch-high-low-01` → PR #32

2. **Check PR status:**
   ```bash
   gh pr view [pr-number] --json state,headRefName
   ```

3. **Determine action based on status and priority:**

   **If PR is OPEN and priority is HIGH/CRITICAL:**
   - **Action:** Push fixes to PR's branch (pre-merge fixes)
   - **Branch:** Use PR's existing branch (from `headRefName`)
   - **No new PR:** Fixes update existing PR
   - **Rationale:** HIGH/CRITICAL issues should be fixed before merge

   **If PR is MERGED or priority is MEDIUM/LOW:**
   - **Action:** Create new branch and PR (post-merge fixes)
   - **Branch:** Create new `fix/[batch-name]` branch
   - **New PR:** Separate PR for deferred fixes
   - **Rationale:** MEDIUM/LOW issues can be addressed after merge

**Implementation:**

```bash
# Extract PR number from batch name
if [[ "$BATCH_NAME" =~ ^pr([0-9]+)-batch- ]]; then
    SOURCE_PR="${BASH_REMATCH[1]}"
    
    # Check if PR is open
    PR_STATE=$(gh pr view "$SOURCE_PR" --json state --jq '.state')
    PR_BRANCH=$(gh pr view "$SOURCE_PR" --json headRefName --jq '.headRefName')
    
    # Check priority from fix plan
    PRIORITY=$(grep "^**Priority:**" "$FIX_PLAN_FILE" | sed 's/.*: //' | sed 's/ .*//')
    
    if [[ "$PR_STATE" == "OPEN" ]] && [[ "$PRIORITY" =~ (CRITICAL|HIGH) ]]; then
        echo "Source PR #$SOURCE_PR is OPEN and priority is $PRIORITY"
        echo "Action: Push fixes to PR's branch ($PR_BRANCH)"
        PUSH_TO_EXISTING_PR=true
        TARGET_BRANCH="$PR_BRANCH"
    else
        echo "Source PR #$SOURCE_PR is $PR_STATE or priority is $PRIORITY"
        echo "Action: Create new branch and PR"
        PUSH_TO_EXISTING_PR=false
        TARGET_BRANCH="fix/$BATCH_NAME"
    fi
fi
```

**Checklist:**

- [ ] Source PR number extracted
- [ ] PR status checked (OPEN/MERGED)
- [ ] Priority level checked (CRITICAL/HIGH vs MEDIUM/LOW)
- [ ] Action determined (push to existing vs create new)
- [ ] Target branch identified
```

**Update Step 2: Create/Checkout Branch**

Change to:

```markdown
### 2. Checkout Target Branch

**If pushing to existing PR (pre-merge fixes):**

```bash
# Checkout PR's branch
git checkout develop
git pull origin develop
git checkout [pr-branch-name]
git pull origin [pr-branch-name]
```

**If creating new PR (post-merge fixes):**

```bash
# Create new branch
git checkout develop
git pull origin develop
git checkout -b fix/[batch-name]
```

**Checklist:**

- [ ] Correct branch checked out
- [ ] Branch is up-to-date
- [ ] Ready for implementation
```

**Update Step 8: Create/Update PR**

Change to:

```markdown
### 8. Create or Update PR

**If pushing to existing PR (pre-merge fixes):**

```bash
# Push to PR's branch
git push origin [pr-branch-name]

# Update PR description with fixes
gh pr edit [pr-number] --body "$(cat /tmp/pr-update.md)"
```

**If creating new PR (post-merge fixes):**

```bash
# Push new branch
git push origin fix/[batch-name]

# Create new PR
gh pr create --title "fix: ..." --body-file /tmp/pr-description.md --base develop --head fix/[batch-name]
```

**Checklist:**

- [ ] Commits pushed to correct branch
- [ ] PR created or updated
- [ ] Description includes fixes
- [ ] PR link presented to user
```

---

## Current State

**PRs Created:**
- PR #32: Original (feat/release-readiness) - OPEN
- PR #33: gh CLI fix (fix/pr32-batch-high-low-01) - OPEN ❌ Should have been commits in PR #32
- PR #34: Phase 1 checklist (fix/pr32-batch-medium-low-01) - OPEN ❌ Should have been commits in PR #32

**What Should Have Happened:**
- PR #32: Original + gh CLI fix + Phase 1 checklist - All in ONE PR

---

## Resolution Options

### Option 1: Merge Fixes into PR #32 (Correct Approach)

**Steps:**
1. Cherry-pick commits from PR #33 and #34 into PR #32's branch
2. Close PR #33 and #34 without merging
3. Update PR #32 description to include all fixes
4. Merge PR #32 with all fixes included

**Pros:**
- Follows correct workflow
- Single PR with all related changes
- Clean history

**Cons:**
- Requires manual cleanup
- Closes PRs that were already created

### Option 2: Continue with Current State (Pragmatic)

**Steps:**
1. Merge all three PRs sequentially (PR #33, #34, #32)
2. Document this as a workflow learning
3. Fix `/fix-implement` for future

**Pros:**
- Simpler immediate action
- All PRs get merged
- Captures learning

**Cons:**
- Fragmented history
- Not ideal workflow
- Sets precedent for future

---

## Recommendation

**Immediate:** Choose Option 1 or 2 based on user preference

**Long-term:** Fix `/fix-implement` command to check PR status and priority before deciding whether to push to existing PR or create new PR

---

## Related

- **Original PR:** #32
- **Fix PRs:** #33, #34
- **Command:** `.cursor/commands/fix-implement.md`
- **Known Issues:** `admin/planning/ci/multi-environment-testing/known-issues.md`

---

**Last Updated:** 2025-12-09  
**Status:** 🟡 Documented - Awaiting decision and fix

