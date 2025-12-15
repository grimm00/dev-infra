# Fix Plan: Cross-PR Batch Quick Wins Round 3 - LOW LOW

**Batch:** quick-wins-low-low-03  
**Priority:** 🟢 LOW  
**Effort:** 🟢 LOW  
**Status:** ✅ Complete  
**Created:** 2025-12-15  
**Completed:** 2025-12-15  
**PR:** #52  
**Source:** fix-review-report-2025-12-15.md  
**Issues:** 4 issues from 2 PRs

---

## Issues in This Batch

| Issue | PR | Priority | Impact | Effort | Description |
|-------|-----|----------|--------|--------|-------------|
| PR47-#1 | 47 | 🟢 LOW | 🟢 LOW | 🟢 LOW | Grammar fix in phase-1.md |
| PR47-Overall-3 | 47 | 🟢 LOW | 🟢 LOW | 🟢 LOW | Reword phase-1.md verification status |
| PR48-#4 | 48 | 🟢 LOW | 🟢 LOW | 🟢 LOW | Grammar: "Starting a new internal team project" |
| PR48-Overall-2 | 48 | 🟢 LOW | 🟢 LOW | 🟢 LOW | Test cleanup simplification |

---

## Overview

This batch contains 4 LOW priority issues with LOW effort from PRs #47 and #48. These are true quick wins - simple documentation and code style improvements.

**Estimated Time:** 30-45 minutes  
**Files Affected:**
- `admin/planning/ci/ci-git-configuration/phase-1.md`
- `docs/PROJECT-TYPES.md`
- `tests/unit/new-project.bats` (cleanup only)

**Source PRs:**
- PR #47: CI Git Configuration (2025-12-12)
- PR #48: Experimental Template Phase 2 (2025-12-15)

**Common Theme:** Grammar fixes and code cleanup

---

## Issue Details

### Issue PR47-#1: Grammar Fix in phase-1.md

**Source PR:** 47 - CI Git Configuration  
**Location:** `admin/planning/ci/ci-git-configuration/phase-1.md:111`  
**Sourcery Comment:** Comment #1  
**Priority:** 🟢 LOW | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

Fix grammar in step description. Current wording: "Verify workflow syntax correct". Should be: "Verify that the workflow syntax is correct" for full-sentence style.

**Current Code:**

```markdown
5. [x] Verify workflow syntax correct
```

**Proposed Solution:**

```markdown
5. [x] Verify that the workflow syntax is correct
```

**Related Files:**
- `admin/planning/ci/ci-git-configuration/phase-1.md` - Fix grammar

---

### Issue PR47-Overall-3: Reword phase-1.md Verification Status

**Source PR:** 47 - CI Git Configuration  
**Sourcery Comment:** Overall Comment #3  
**Priority:** 🟢 LOW | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

Phase-1.md marks CI verification as complete while noting that full runtime validation is pending PR/release runs. Consider rewording to clarify the distinction between syntax verification (complete) and runtime verification (pending).

**Current State:**

The phase document has "(will run on PR creation)" and "(will verify on next release)" notes, which already provide context. However, rewording could improve clarity.

**Proposed Solution:**

Review the completion criteria and status sections. Either:
1. Keep current wording (already sufficiently clear)
2. Add explicit note: "Syntax verified; runtime validation pending first PR/release"

**Related Files:**
- `admin/planning/ci/ci-git-configuration/phase-1.md` - Review and potentially reword

---

### Issue PR48-#4: Grammar Fix in PROJECT-TYPES.md

**Source PR:** 48 - Experimental Template Phase 2  
**Location:** `docs/PROJECT-TYPES.md:230`  
**Sourcery Comment:** Comment #4  
**Priority:** 🟢 LOW | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

Minor grammar tweak: add "a" for smoother phrasing in the checklist.

**Current Code:**

```markdown
**Choose Experimental Project If:**

- [ ] Starting new internal team project
```

**Proposed Solution:**

```markdown
**Choose Experimental Project If:**

- [ ] Starting a new internal team project
```

**Related Files:**
- `docs/PROJECT-TYPES.md` - Fix grammar

---

### Issue PR48-Overall-2: Test Cleanup Simplification

**Source PR:** 48 - Experimental Template Phase 2  
**Sourcery Comment:** Overall Comment #2  
**Priority:** 🟢 LOW | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

The new BATS tests introduce their own `TEST_*_DIR` variables and manual `rm -rf` cleanup on top of `setup_test_env`/`cleanup_test_env`. If the helpers already isolate temp directories, the tests could be simplified by deriving paths from those helpers and letting them handle cleanup.

**Current State:**

Tests define:
```bash
TEST_TMPDIR=$(mktemp -d)
TEST_PROJECT_DIR="$TEST_TMPDIR/test-experimental"
```

And manually clean up in teardown.

**Proposed Solution:**

Review if `setup_test_env`/`cleanup_test_env` helpers can handle this. Options:
1. Use existing helpers if they provide temp directory isolation
2. Keep current approach if explicit control is needed for test clarity
3. Document why manual cleanup is used (if intentional)

**Related Files:**
- `tests/unit/new-project.bats` - Review test setup/cleanup patterns

---

## Implementation Steps

1. **Issue PR47-#1: Grammar Fix**
   - [ ] Open `admin/planning/ci/ci-git-configuration/phase-1.md`
   - [ ] Change "Verify workflow syntax correct" to "Verify that the workflow syntax is correct"
   - [ ] Verify markdown renders correctly

2. **Issue PR47-Overall-3: Verification Status**
   - [ ] Review phase-1.md status and completion criteria
   - [ ] Determine if rewording is needed (may be sufficient as-is)
   - [ ] If needed, add clarifying note about syntax vs runtime verification

3. **Issue PR48-#4: Grammar Fix**
   - [ ] Open `docs/PROJECT-TYPES.md`
   - [ ] Change "Starting new internal team project" to "Starting a new internal team project"
   - [ ] Verify markdown renders correctly

4. **Issue PR48-Overall-2: Test Cleanup Review**
   - [ ] Review `setup_test_env`/`cleanup_test_env` in test helpers
   - [ ] Determine if manual cleanup is redundant
   - [ ] Either simplify or document why manual approach is used

---

## Testing

- [ ] Documentation changes render correctly
- [ ] All existing tests pass
- [ ] No regressions introduced
- [ ] Markdown linting passes (if applicable)

---

## Files to Modify

- `admin/planning/ci/ci-git-configuration/phase-1.md` - Grammar and wording (PR47-#1, PR47-Overall-3)
- `docs/PROJECT-TYPES.md` - Grammar fix (PR48-#4)
- `tests/unit/new-project.bats` - Review cleanup patterns (PR48-Overall-2)

---

## Definition of Done

- [x] All grammar issues fixed
- [x] Verification status wording reviewed (already clear)
- [x] Test cleanup reviewed/simplified
- [x] Tests passing
- [x] Ready for PR

---

**Batch Rationale:**

These issues are batched together because they:
- All are LOW priority and LOW effort (true quick wins)
- Can be implemented very quickly (< 1 hour total)
- Are primarily documentation and style improvements
- Don't require complex logic or refactoring
- Were identified as "Quick Wins" in fix-review report

