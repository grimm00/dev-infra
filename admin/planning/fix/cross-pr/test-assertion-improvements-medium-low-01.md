# Fix Plan: Cross-PR Batch Test Assertion Improvements - MEDIUM/LOW

**Batch:** test-assertion-improvements-medium-low-01  
**Priority:** 🟡 MEDIUM  
**Effort:** 🟢 LOW  
**Status:** ✅ Complete  
**Completed:** 2025-12-15  
**PR:** #50  
**Created:** 2025-12-15  
**Source:** fix-review-report-2025-12-15.md  
**Issues:** 4 issues from 2 PRs

---

## Issues in This Batch

| Issue   | PR  | Priority  | Impact    | Effort | Description                                 |
| ------- | --- | --------- | --------- | ------ | ------------------------------------------- |
| PR48-#1 | 48  | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Strengthen README disclaimer test assertion |
| PR48-#2 | 48  | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Add content check to EXPERIMENTAL.md test   |
| PR49-#3 | 49  | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Test doesn't check output content           |
| PR49-#6 | 49  | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Empty manifest behavior assertion unclear   |

---

## Overview

This batch contains 4 MEDIUM priority issues with LOW effort from PR #48 and #49. These issues are all related to **strengthening test assertions** to avoid false positives and ensure proper test coverage.

**Estimated Time:** 1-2 hours  
**Files Affected:**

- `tests/unit/new-project.bats`
- `tests/unit/validate-template-sync.bats`

**Source PRs:**

- PR #48: Experimental Template Phase 2 (Update Generator)
- PR #49: Experimental Template Phase 3 (CI Drift Detection)

---

## Issue Details

### Issue PR48-#1: Strengthen README disclaimer test assertion

**Source PR:** #48 - Experimental Template Phase 2  
**Location:** `tests/unit/new-project.bats:94-98`  
**Sourcery Comment:** Comment #1  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
The test currently passes if README contains any `experimental` mention, even if the intended disclaimer text is missing or altered. This is a weak regression guard.

**Current Code:**

```bash
@test "new-project: experimental-project README includes stability disclaimer" {
    # ... setup ...
    [ "$status" -eq 0 ]
    # Check README contains experimental template warning
    grep -q "Experimental Template" "$TEST_PROJECT_DIR/README.md" || \
    grep -q "experimental" "$TEST_PROJECT_DIR/README.md"
}
```

**Proposed Solution:**

```bash
    [ "$status" -eq 0 ]
    # Check README contains specific experimental template disclaimer
    grep -q "## ⚠️ Experimental Template" "$TEST_PROJECT_DIR/README.md"
    # Verify stability levels section exists
    grep -q "### Stability Levels" "$TEST_PROJECT_DIR/README.md"
```

---

### Issue PR48-#2: Add content check to EXPERIMENTAL.md test

**Source PR:** #48 - Experimental Template Phase 2  
**Location:** `tests/unit/new-project.bats:59-68`  
**Sourcery Comment:** Comment #2  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
The test currently only asserts that `docs/EXPERIMENTAL.md` exists. An empty or incomplete file would still pass. Should verify key content.

**Current Code:**

```bash
@test "new-project: experimental-project includes EXPERIMENTAL.md" {
    # ... setup ...
    [ "$status" -eq 0 ]
    [ -f "$TEST_PROJECT_DIR/docs/EXPERIMENTAL.md" ]
}
```

**Proposed Solution:**

```bash
    [ "$status" -eq 0 ]
    [ -f "$TEST_PROJECT_DIR/docs/EXPERIMENTAL.md" ]
    # Verify key content exists
    grep -q "Experimental Features" "$TEST_PROJECT_DIR/docs/EXPERIMENTAL.md" || \
    grep -q "experimental" "$TEST_PROJECT_DIR/docs/EXPERIMENTAL.md"
```

---

### Issue PR49-#3: Test doesn't check output content

**Source PR:** #49 - Experimental Template Phase 3  
**Location:** `tests/unit/validate-template-sync.bats:208-30`  
**Sourcery Comment:** Comment #3  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
The "outputs clear error messages" test only checks exit status with placeholder assertion and never inspects `$output`. Should assert on specific substrings like "DRIFT DETECTED".

**Current Code:**

```bash
@test "validate-template-sync: outputs clear error messages" {
    # ... setup ...
    # Expected: Output should contain "DRIFT DETECTED" or similar
    [ "$status" -ne 0 ] || [ -f "$SCRIPT" ]
}
```

**Proposed Solution:**

```bash
    # Assert specific exit status
    [ "$status" -ne 0 ]
    # Verify output contains drift detection message
    [[ "$output" == *"DRIFT DETECTED"* ]] || \
    [[ "$output" == *"drift"* ]]
```

---

### Issue PR49-#6: Empty manifest behavior assertion unclear

**Source PR:** #49 - Experimental Template Phase 3  
**Location:** `tests/unit/validate-template-sync.bats:105`  
**Sourcery Comment:** Comment #6  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
The "handles empty manifest gracefully" test doesn't define what "gracefully" means. Should specify whether empty manifest is success (no-op) or error, with concrete assertions.

**Current Code:**

```bash
@test "validate-template-sync: handles empty manifest gracefully" {
    echo "" > "$TEST_TMPDIR/scripts/template-sync-manifest.txt"
    # ... run script ...
    [ "$status" -ne 0 ] || [ -f "$SCRIPT" ]
}
```

**Proposed Solution:**

```bash
    # Empty manifest should succeed (no files to check = no drift)
    [ "$status" -eq 0 ]
    # Verify output indicates no files checked
    [[ "$output" == *"0 files"* ]] || [[ "$output" == *"complete"* ]]
```

---

## Implementation Steps

1. **Issue PR48-#1: Strengthen README test**

   - [ ] Update assertion to check for specific heading `## ⚠️ Experimental Template`
   - [ ] Add check for `### Stability Levels` section
   - [ ] Run test to verify

2. **Issue PR48-#2: Add EXPERIMENTAL.md content check**

   - [ ] Add grep check for key phrase in EXPERIMENTAL.md
   - [ ] Run test to verify

3. **Issue PR49-#3: Add output content assertion**

   - [ ] Replace placeholder assertion with `[ "$status" -ne 0 ]`
   - [ ] Add assertion for "DRIFT DETECTED" in output
   - [ ] Run test to verify

4. **Issue PR49-#6: Define empty manifest behavior**
   - [ ] Decide behavior: empty manifest = success (no drift)
   - [ ] Update assertion to `[ "$status" -eq 0 ]`
   - [ ] Add output assertion for completion message
   - [ ] Run test to verify

---

## Testing

- [ ] All existing tests pass
- [ ] Updated tests pass
- [ ] No regressions introduced
- [ ] Run full test suite: `bats tests/unit/`

---

## Files to Modify

- `tests/unit/new-project.bats` - PR48-#1, PR48-#2
- `tests/unit/validate-template-sync.bats` - PR49-#3, PR49-#6

---

## Definition of Done

- [x] All 4 issues fixed
- [x] Tests passing
- [x] No regressions
- [x] Ready for PR

---

**Batch Rationale:**
This batch was created from fix-review report recommendations. These issues are batched together because they:

- Share the same priority (MEDIUM) and effort (LOW)
- All relate to strengthening test assertions
- Can be implemented together efficiently
- Were identified as "Test Assertion Improvements" in review report

---

**Last Updated:** 2025-12-15
