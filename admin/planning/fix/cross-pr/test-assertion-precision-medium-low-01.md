# Fix Plan: Cross-PR Batch Test Assertion Precision - MEDIUM LOW

**Batch:** test-assertion-precision-medium-low-01  
**Priority:** 🟡 MEDIUM  
**Effort:** 🟢 LOW  
**Status:** 🔴 Not Started  
**Created:** 2025-12-10  
**Source:** fix-review-report-2025-12-10.md  
**Issues:** 4 issues from 1 PR (PR #38)

---

## Issues in This Batch

| Issue | PR | Priority | Impact | Effort | Description |
|-------|-----|----------|--------|--------|-------------|
| PR38-#1 | 38 | 🟡 MEDIUM | 🟢 LOW | 🟢 LOW | Tighten path expansion test assertion for undefined vars |
| PR38-#2 | 38 | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Clarify existing file collision test assertion |
| PR38-Overall-1 | 38 | 🟡 MEDIUM | 🟢 LOW | 🟢 LOW | Same as #2 - tighten existing file assertion |
| PR38-Overall-2 | 38 | 🟡 MEDIUM | 🟢 LOW | 🟢 LOW | Tighten assertions in gh CLI and path expansion tests |

---

## Overview

This batch contains 4 MEDIUM priority issues with LOW effort from PR #38. These issues are all related to improving test assertion precision to prevent regressions and make tests more robust.

**Estimated Time:** 1-2 hours  
**Files Affected:**
- `tests/unit/path-expansion.bats`
- `tests/unit/project-name-validation.bats`
- `tests/unit/github-auth.bats`

**Source PR:**
- PR #38: Test Improvements Cross-PR Batch (2025-12-09)

**Common Theme:** All issues address loose test assertions that could allow unintended behavior changes to pass undetected.

---

## Issue Details

### Issue PR38-#1: Tighten Path Expansion Test Assertion

**Source PR:** 38 - Test Improvements Cross-PR Batch  
**Location:** `tests/unit/path-expansion.bats:74-83`  
**Sourcery Comment:** Comment #1  
**Priority:** 🟡 MEDIUM | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

The final assertion is too loose and could let regressions slip through (e.g., keeping `$UNDEFINED_VAR` literal or adding extra text). Since the behavior is defined as expanding undefined vars to an empty string, assert the exact expected output path (e.g., `/home//projects`, or whatever it should be) and also assert that `$UNDEFINED_VAR` is not present in `"$output"` to more tightly validate the behavior.

**Current Code:**

```bash
@test "path_expansion: handles undefined environment variables" {
    # Ensure variable is undefined
    unset UNDEFINED_VAR 2>/dev/null || true
    
    # Test with undefined variable in path
    local path_with_undefined="/home/\$UNDEFINED_VAR/projects"
    run expand_env_vars "$path_with_undefined"
    
    # Should handle gracefully - either expand to literal or return error
    # Current implementation expands undefined vars to empty string
    [ "$status" -eq 0 ]
    # Result should contain the literal path (undefined var becomes empty)
    [[ "$output" == *"/home/"* ]] || [[ "$output" == *"/projects"* ]]
}
```

**Proposed Solution:**

Replace loose substring checks with exact assertion:

```bash
@test "path_expansion: handles undefined environment variables" {
    # Ensure variable is undefined
    unset UNDEFINED_VAR 2>/dev/null || true
    
    # Test with undefined variable in path
    local path_with_undefined="/home/\$UNDEFINED_VAR/projects"
    run expand_env_vars "$path_with_undefined"
    
    # Current implementation expands undefined vars to empty string
    [ "$status" -eq 0 ]
    # Assert exact expected output (undefined var becomes empty)
    [ "$output" = "/home//projects" ]
    # Verify variable was not kept literal
    [[ ! "$output" =~ \$UNDEFINED_VAR ]]
}
```

**Related Files:**
- `tests/unit/path-expansion.bats` - Update test assertion

---

### Issue PR38-#2: Clarify Existing File Collision Test Assertion

**Source PR:** 38 - Test Improvements Cross-PR Batch  
**Location:** `tests/unit/project-name-validation.bats:66-75`  
**Sourcery Comment:** Comment #2  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**

The current assertion (`[ -n "$output" ] || [ "$status" -ne 0 ]`) is too permissive: it passes for multiple, potentially conflicting behaviors and doesn't clearly state what "correct" looks like. Please either (a) define a single expected outcome for an existing file (e.g., specific non-zero status and error message) and assert that explicitly, or (b) split this into two tests—one that locks in today's behavior and another that documents the desired future behavior (e.g., with a TODO or expected-fail). Otherwise this test may keep passing even if behavior changes in an unintended way.

**Current Code:**

```bash
@test "project_name_validation: detects existing file with project name" {
    local test_dir="$TEST_TMPDIR/projects"
    local existing_file="$test_dir/existingfile"
    mkdir -p "$test_dir"
    touch "$existing_file"
    
    run validate_project_name "existingfile" "$test_dir" 2>/dev/null
    # Note: Current implementation only checks for directories, not files
    # This test documents current behavior - if status is 0, it indicates
    # the function doesn't detect file collisions (potential bug)
    # If status is non-zero, the function correctly handles file collisions
    [ -n "$output" ] || [ "$status" -ne 0 ]
}
```

**Proposed Solution:**

Split into two tests - one for current behavior, one for desired behavior:

```bash
@test "project_name_validation: detects existing file with project name (current behavior)" {
    local test_dir="$TEST_TMPDIR/projects"
    local existing_file="$test_dir/existingfile"
    mkdir -p "$test_dir"
    touch "$existing_file"
    
    run validate_project_name "existingfile" "$test_dir" 2>/dev/null
    
    # Current behavior: Only checks for directories, not files
    # So it returns 0 (success) and the path
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir/existingfile" ]
    # Note: This indicates a potential bug - should detect file collisions
}

@test "project_name_validation: should detect file collision (TODO - desired behavior)" {
    skip "TODO: Function should detect file collisions, not just directories"
    
    local test_dir="$TEST_TMPDIR/projects"
    local existing_file="$test_dir/existingfile"
    mkdir -p "$test_dir"
    touch "$existing_file"
    
    run validate_project_name "existingfile" "$test_dir" 2>/dev/null
    
    # Desired behavior: Should return non-zero and error message
    [ "$status" -ne 0 ]
    [ -z "$output" ]
}
```

**Related Files:**
- `tests/unit/project-name-validation.bats` - Split test into two

---

### Issue PR38-Overall-1: Same as #2 (Included for Completeness)

**Source PR:** 38 - Test Improvements Cross-PR Batch  
**Sourcery Comment:** Overall Comment #1  
**Priority:** 🟡 MEDIUM | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

This is the same issue as PR38-#2, mentioned again in the overall comments. No additional work needed beyond fixing PR38-#2.

---

### Issue PR38-Overall-2: Tighten Assertions in gh CLI and Path Expansion Tests

**Source PR:** 38 - Test Improvements Cross-PR Batch  
**Sourcery Comment:** Overall Comment #2  
**Priority:** 🟡 MEDIUM | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

The new path expansion and gh CLI error tests use fairly loose assertions (e.g., checking only for `/home/` or `/projects`, or just non-zero exit) which could let unexpected outputs pass; consider asserting the complete expected output or error pattern to make these edge-case tests more robust and self-documenting.

**Files to Review:**
- `tests/unit/path-expansion.bats` - Already covered by PR38-#1
- `tests/unit/github-auth.bats` - Tighten gh CLI unexpected error test

**Current Code (gh CLI test):**

```bash
@test "github_auth: handles unexpected gh CLI error" {
    # Mock gh to return unexpected error code
    mock_gh() {
        echo "Unexpected error: network timeout" >&2
        return 42  # Unusual error code
    }
    export -f mock_gh

    local result
    local exit_code
    set +e
    result=$(GH_CMD=mock_gh verify_github_auth 2>&1)
    exit_code=$?
    set -e

    [ $exit_code -ne 0 ]
    [[ "$result" == *"error"* ]] || [[ "$result" == *"failed"* ]]
}
```

**Proposed Solution:**

Make assertion more specific:

```bash
@test "github_auth: handles unexpected gh CLI error" {
    # Mock gh to return unexpected error code
    mock_gh() {
        echo "Unexpected error: network timeout" >&2
        return 42  # Unusual error code
    }
    export -f mock_gh

    local result
    local exit_code
    set +e
    result=$(GH_CMD=mock_gh verify_github_auth 2>&1)
    exit_code=$?
    set -e

    # Assert specific error behavior
    [ $exit_code -eq 42 ]
    [[ "$result" == *"Unexpected error: network timeout"* ]]
}
```

**Related Files:**
- `tests/unit/github-auth.bats` - Tighten assertion

---

## Implementation Steps

1. **Issue PR38-#1: Path Expansion Test**
   - [ ] Update `tests/unit/path-expansion.bats`
   - [ ] Change assertion to exact match: `[ "$output" = "/home//projects" ]`
   - [ ] Add check that `$UNDEFINED_VAR` is not in output
   - [ ] Run test to verify

2. **Issue PR38-#2: File Collision Test**
   - [ ] Update `tests/unit/project-name-validation.bats`
   - [ ] Rename existing test with "(current behavior)" suffix
   - [ ] Lock in current behavior with exact assertions
   - [ ] Add new skipped test for desired behavior with TODO
   - [ ] Run tests to verify

3. **Issue PR38-Overall-2: gh CLI Test**
   - [ ] Update `tests/unit/github-auth.bats`
   - [ ] Change assertion to check exact exit code and error message
   - [ ] Run test to verify

---

## Testing

- [ ] All existing tests pass (32/32 unit tests)
- [ ] New assertions are more specific and catch edge cases
- [ ] Tests fail appropriately when behavior changes
- [ ] No regressions introduced

---

## Files to Modify

- `tests/unit/path-expansion.bats` - Tighten undefined var test assertion
- `tests/unit/project-name-validation.bats` - Split file collision test
- `tests/unit/github-auth.bats` - Tighten gh CLI error test assertion

---

## Definition of Done

- [ ] All 4 issues addressed
- [ ] Tests passing (32/32 or more if new tests added)
- [ ] Assertions are precise and catch regressions
- [ ] Documentation updated (test comments clear)
- [ ] Ready for PR

---

**Batch Rationale:**

These issues are batched together because they:
- All came from PR #38's Sourcery review
- Share the same priority (MEDIUM) and effort (LOW)
- Address the same concern: test assertion quality
- Can be implemented quickly in one focused session
- Affect only test files (no production code changes)

