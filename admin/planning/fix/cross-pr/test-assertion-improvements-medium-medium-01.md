# Fix Plan: Cross-PR Batch Test Assertion Improvements - MEDIUM/MEDIUM

**Batch:** test-assertion-improvements-medium-medium-01  
**Priority:** 🟡 MEDIUM  
**Effort:** 🟡 MEDIUM  
**Status:** ✅ Complete  
**Completed:** 2025-12-15  
**PR:** #51  
**Created:** 2025-12-15  
**Source:** fix-review-report-2025-12-15.md  
**Issues:** 3 issues from 2 PRs

---

## Issues in This Batch

| Issue   | PR  | Priority  | Impact    | Effort    | Description                                             |
| ------- | --- | --------- | --------- | --------- | ------------------------------------------------------- |
| PR48-#3 | 48  | 🟡 MEDIUM | 🟢 LOW    | 🟡 MEDIUM | Test for warning skip in non-interactive mode           |
| PR49-#2 | 49  | 🟡 MEDIUM | 🟡 MEDIUM | 🟡 MEDIUM | Replace TDD placeholder assertions with real assertions |
| PR49-#4 | 49  | 🟡 MEDIUM | 🟡 MEDIUM | 🟡 MEDIUM | Missing edge case tests (file exists in one template)   |

---

## Overview

This batch contains 3 MEDIUM priority issues with MEDIUM effort from PR #48 and #49. These issues require more substantial test refactoring than the LOW effort batch.

**Estimated Time:** 2-3 hours  
**Files Affected:**

- `tests/unit/new-project.bats`
- `tests/unit/validate-template-sync.bats`

**Source PRs:**

- PR #48: Experimental Template Phase 2 (Update Generator)
- PR #49: Experimental Template Phase 3 (CI Drift Detection)

---

## Issue Details

### Issue PR48-#3: Test for warning skip in non-interactive mode

**Source PR:** #48 - Experimental Template Phase 2  
**Location:** `tests/unit/new-project.bats:138-143`  
**Sourcery Comment:** Comment #3  
**Priority:** 🟡 MEDIUM | **Impact:** 🟢 LOW | **Effort:** 🟡 MEDIUM

**Description:**
Since stability warnings/confirmations are skipped in non-interactive mode (for CI/automation), it'd be good to assert that explicitly. All current experimental tests use `--non-interactive` but only check for successful generation.

**Current Behavior:**
Tests verify experimental project generation succeeds but don't verify that the warning/confirmation prompts are actually skipped.

**Proposed Solution:**
Add a dedicated test that:

1. Verifies non-interactive mode completes without hanging
2. Checks output doesn't contain interactive prompts
3. Verifies project is created successfully

```bash
@test "new-project: non-interactive mode skips experimental warning" {
    export PROJECT_NAME="test-experimental"
    export PROJECT_TYPE="experimental-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"

    # Run in non-interactive mode
    run timeout 10 "$SCRIPT" --non-interactive

    # Should complete successfully without hanging
    [ "$status" -eq 0 ]
    # Output should NOT contain interactive prompts
    ! [[ "$output" == *"Press Enter"* ]]
    ! [[ "$output" == *"Continue?"* ]]
    # Project should be created
    [ -d "$TEST_PROJECT_DIR" ]
}
```

---

### Issue PR49-#2: Replace TDD placeholder assertions

**Source PR:** #49 - Experimental Template Phase 3  
**Location:** `tests/unit/validate-template-sync.bats:63`  
**Sourcery Comment:** Comment #2  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟡 MEDIUM

**Description:**
All tests currently use `[ "$status" -ne 0 ] || [ -f "$SCRIPT" ]`, which was useful while the script might not exist (TDD), but now makes the tests too permissive. Each test should assert the specific expected exit status.

**Current Code (in multiple tests):**

```bash
[ "$status" -ne 0 ] || [ -f "$SCRIPT" ]
```

**Proposed Solution:**
Update each test to use proper assertions:

| Test                          | Expected Status       | Reason                     |
| ----------------------------- | --------------------- | -------------------------- |
| templates in sync             | `[ "$status" -eq 0 ]` | Success = no drift         |
| detects file differences      | `[ "$status" -ne 0 ]` | Failure = drift detected   |
| detects directory differences | `[ "$status" -ne 0 ]` | Failure = drift detected   |
| handles empty manifest        | `[ "$status" -eq 0 ]` | Success = nothing to check |
| handles missing directories   | `[ "$status" -ne 0 ]` | Failure = error condition  |
| outputs clear error messages  | `[ "$status" -ne 0 ]` | Failure = drift exists     |

---

### Issue PR49-#4: Missing edge case tests

**Source PR:** #49 - Experimental Template Phase 3  
**Location:** `tests/unit/validate-template-sync.bats:166`  
**Sourcery Comment:** Comment #4  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟡 MEDIUM

**Description:**
Current tests cover content differences and missing template directories, but not the case where a manifest entry exists in only one template (file/dir missing on one side).

**Missing Test Cases:**

1. **File exists only in standard-project:**

```bash
@test "validate-template-sync: detects file missing in experimental" {
    # Setup: File exists in standard but not experimental
    echo "content" > "$TEST_STANDARD_DIR/test-file.txt"
    # (don't create in experimental)

    # Run script
    run "$SCRIPT"

    # Should fail - drift detected
    [ "$status" -ne 0 ]
    [[ "$output" == *"missing"* ]] || [[ "$output" == *"DRIFT"* ]]
}
```

2. **File exists only in experimental-project:**

```bash
@test "validate-template-sync: detects file missing in standard" {
    # Setup: File exists in experimental but not standard
    echo "content" > "$TEST_EXPERIMENTAL_DIR/test-file.txt"
    # (don't create in standard)

    # Run script
    run "$SCRIPT"

    # Should fail - drift detected
    [ "$status" -ne 0 ]
    [[ "$output" == *"missing"* ]] || [[ "$output" == *"DRIFT"* ]]
}
```

3. **Directory exists only in one template:**

```bash
@test "validate-template-sync: detects directory missing in experimental" {
    # Setup: Directory exists in standard but not experimental
    mkdir -p "$TEST_STANDARD_DIR/test-dir"
    echo "file" > "$TEST_STANDARD_DIR/test-dir/file.txt"

    # Run script
    run "$SCRIPT"

    # Should fail - drift detected
    [ "$status" -ne 0 ]
}
```

---

## Implementation Steps

1. **Issue PR48-#3: Add non-interactive warning skip test**

   - [ ] Create new test function
   - [ ] Add timeout to prevent hanging if interactive
   - [ ] Assert no interactive prompts in output
   - [ ] Verify project creation
   - [ ] Run test to verify

2. **Issue PR49-#2: Replace TDD placeholder assertions**

   - [ ] Identify all tests using placeholder assertion
   - [ ] Determine expected status for each test (success vs failure)
   - [ ] Update each test with proper assertion
   - [ ] Run all tests to verify

3. **Issue PR49-#4: Add missing edge case tests**
   - [ ] Add test for file missing in experimental
   - [ ] Add test for file missing in standard
   - [ ] Add test for directory missing in one template
   - [ ] Run tests to verify

---

## Testing

- [ ] All existing tests pass
- [ ] New tests pass
- [ ] Updated assertions are correct
- [ ] No regressions introduced
- [ ] Run full test suite: `bats tests/unit/`

---

## Files to Modify

- `tests/unit/new-project.bats` - PR48-#3
- `tests/unit/validate-template-sync.bats` - PR49-#2, PR49-#4

---

## Definition of Done

- [x] All 3 issues fixed
- [x] Tests passing
- [x] No regressions
- [x] Ready for PR

---

**Batch Rationale:**
This batch was created from fix-review report recommendations. These issues are batched together because they:

- Share the same priority (MEDIUM) and effort (MEDIUM)
- All require more substantial test refactoring
- Can be implemented together efficiently
- Were identified as "Test Assertion Improvements" in review report

---

**Last Updated:** 2025-12-15
