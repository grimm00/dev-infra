# Fix Plan: PR 27 Batch MEDIUM LOW - Batch 01

**PR:** 27  
**Batch:** medium-low-01  
**Priority:** 🟡 MEDIUM  
**Effort:** 🟢 LOW  
**Status:** ✅ Complete  
**Completed:** 2025-12-08  
**PR:** #28  
**Created:** 2025-12-08  
**Issues:** 2 issues

---

## Issues in This Batch

| Issue   | Priority   | Impact   | Effort   | Description   |
| ------- | ---------- | -------- | -------- | ------------- |
| PR27-#1 | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Exit code documentation mismatch |
| PR27-#2 | 🟢 LOW | 🟢 LOW | 🟢 LOW | Fast-forward merge documentation |

---

## Overview

This batch contains 2 documentation issues with LOW effort. These are documentation fixes that improve accuracy and consistency.

**Estimated Time:** 30 minutes  
**Files Affected:** 
- `scripts/new-project.sh` (help text)
- `docs/COMMIT-WORKFLOW.md` (merge example)

---

## Issue Details

### Issue PR27-#1: Exit Code Documentation Mismatch

**Location:** `scripts/new-project.sh:518-527`  
**Sourcery Comment:** Comment #1  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
The help text documents exit code `2` for "Invalid arguments or usage error", but the script only recognizes `--non-interactive` and `--help|-h` and otherwise falls through without a specific exit code. Please either implement invalid-argument handling that exits with `2`, or update the help text so it matches the actual behavior.

**Current Code:**

```bash
Exit Codes:
  0  Success
  1  Validation error or general error
  2  Invalid arguments or usage error
```

**Proposed Solution:**
Update help text to remove exit code 2 since invalid argument handling is not implemented. The script currently only recognizes `--non-interactive` and `--help|-h` flags, and falls through for any other arguments without exiting.

**Files to Modify:**
- `scripts/new-project.sh` - Update help text

---

### Issue PR27-#2: Fast-Forward Merge Documentation

**Location:** `docs/COMMIT-WORKFLOW.md:106-111`  
**Sourcery Comment:** Comment #2  
**Priority:** 🟢 LOW | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**
This example can still create a merge commit, which conflicts with the recommendation to use fast-forward merges. Either adjust the wording to not promise a fast-forward merge, or change the command to enforce it (for example, `git merge --ff-only ...` or `git pull --ff-only` from the docs branch).

**Current Code:**

```bash
**Direct Merge Workflow:**

```bash
git checkout develop
git pull origin develop
git merge docs/[topic] --no-edit
git push origin develop
git branch -d docs/[topic]
```

**Proposed Solution:**
Update the merge command to use `--ff-only` to enforce fast-forward merges, matching the recommendation in the documentation.

**Files to Modify:**
- `docs/COMMIT-WORKFLOW.md` - Update merge command to use `--ff-only`

---

## Implementation Steps

1. **Issue PR27-#1: Exit Code Documentation**

   - [x] Read current help text in `scripts/new-project.sh`
   - [x] Remove exit code 2 from help text
   - [x] Update exit codes section to only list codes 0 and 1
   - [x] Verify help text is accurate
   - [x] Test help text display: `./scripts/new-project.sh --help`

2. **Issue PR27-#2: Fast-Forward Merge Documentation**

   - [x] Read current merge example in `docs/COMMIT-WORKFLOW.md`
   - [x] Update merge command to use `--ff-only` flag
   - [x] Verify example matches recommendation
   - [x] Check for other merge examples that need updating

---

## Testing

- [x] Help text displays correctly (`./scripts/new-project.sh --help`)
- [x] Exit codes section only shows codes 0 and 1
- [x] Documentation example uses `--ff-only` flag
- [x] No other merge examples need updating

---

## Files to Modify

- `scripts/new-project.sh` - Update help text (remove exit code 2)
- `docs/COMMIT-WORKFLOW.md` - Update merge command to use `--ff-only`

---

## Definition of Done

- [x] All issues in batch fixed
- [x] Help text updated and accurate
- [x] Documentation example updated
- [x] Changes tested
- [x] Ready for PR

---

**Batch Rationale:**
These issues are batched together because they:

- Are both documentation fixes
- Share LOW effort level
- Can be implemented quickly together
- Improve documentation accuracy and consistency

---

**Last Updated:** 2025-12-08

