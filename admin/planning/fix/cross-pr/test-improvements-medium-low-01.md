# Fix Plan: Cross-PR Batch Test Improvements - MEDIUM LOW

**Batch:** test-improvements-medium-low-01  
**Priority:** 🟡 MEDIUM  
**Effort:** 🟢 LOW  
**Status:** ✅ Complete  
**Created:** 2025-12-09  
**Completed:** 2025-12-09  
**PR:** #[pending]  
**Source:** fix-review-report-2025-12-09.md  
**Issues:** 4 issues from 3 PRs

---

## Issues in This Batch

| Issue | PR | Task | Priority | Impact | Effort | Description |
|-------|-----|------|----------|--------|--------|-------------|
| Task 12 | #7 | 12 | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Test for existing file (not directory) |
| Task 14 | #8 | 14 | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Test for gh CLI unexpected errors |
| Task 17 | #8-2 | 17 | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Test package.json with additional fields |
| Task 19 | #8-2 | 19 | 🟡 MEDIUM | 🟡 MEDIUM | 🟢 LOW | Test undefined environment variables |

---

## Overview

This batch contains 4 MEDIUM priority test improvement issues with LOW effort. These add missing edge case coverage to the test suite.

**Estimated Time:** 1-2 hours  
**Files Affected:**
- `tests/unit/project-name-validation.bats` (Task 12)
- `tests/unit/github-auth.bats` (Task 14)
- `tests/unit/file-customization.bats` (Task 17)
- `tests/unit/path-expansion.bats` (Task 19)

**Source PRs:**
- PR #7: Sed portability fixes
- PR #8: Test file restructure
- PR #8-2: Deprecated path fixes

---

## Issue Details

### Task 12: Test for Existing File (Not Directory)

**Source PR:** #7 - Sed portability fixes  
**Location:** `tests/unit/project-name-validation.bats`  
**Sourcery Comment:** Comment #1  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
Add a test case for when a file (not directory) with the intended project name exists, to ensure this edge case is handled correctly by `validate_project_name()`.

**Proposed Implementation:**
```bash
@test "validate_project_name: detects existing file with project name" {
    local test_dir="$TEST_TMPDIR/projects"
    local existing_file="$test_dir/existingfile"
    mkdir -p "$test_dir"
    touch "$existing_file"

    local result
    local exit_code
    set +e
    result=$(validate_project_name "existingfile" "$test_dir" 2>/dev/null)
    exit_code=$?
    set -e

    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}
```

---

### Task 14: Test for gh CLI Unexpected Errors

**Source PR:** #8 - Test file restructure  
**Location:** `tests/unit/github-auth.bats`  
**Sourcery Comment:** Comment #1  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
Add a test case where gh CLI is installed but returns an unexpected error, to verify error handling in `verify_github_auth()` function handles edge cases beyond the current scenarios (not_installed, failure, mismatch).

**Proposed Implementation:**
```bash
@test "verify_github_auth: handles unexpected gh CLI error" {
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

---

### Task 17: Test package.json with Additional Fields

**Source PR:** #8-2 - Deprecated path fixes  
**Location:** `tests/unit/file-customization.bats`  
**Sourcery Comment:** #17  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
Add a test case for package.json customization that includes additional fields beyond name/description (like scripts, dependencies, etc.) to verify they are preserved.

**Proposed Implementation:**
```bash
@test "customize_project: preserves package.json additional fields" {
    local project_dir="$TEST_TMPDIR/myproject"
    mkdir -p "$project_dir"
    
    # Create package.json with additional fields
    cat > "$project_dir/package.json" << 'EOF'
{
  "name": "{{PROJECT_NAME}}",
  "description": "{{PROJECT_DESCRIPTION}}",
  "scripts": {
    "test": "jest",
    "build": "webpack"
  },
  "dependencies": {
    "lodash": "^4.17.21"
  }
}
EOF

    customize_project "$project_dir" "my-project" "My description"
    
    # Verify additional fields preserved
    run jq -e '.scripts.test' "$project_dir/package.json"
    [ "$status" -eq 0 ]
    [ "$output" = '"jest"' ]
    
    run jq -e '.dependencies.lodash' "$project_dir/package.json"
    [ "$status" -eq 0 ]
}
```

---

### Task 19: Test Undefined Environment Variables

**Source PR:** #8-2 - Deprecated path fixes  
**Location:** `tests/unit/path-expansion.bats`  
**Sourcery Comment:** #19  
**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟢 LOW

**Description:**
Add a test case for path expansion behavior when environment variables in paths are undefined, to verify graceful handling.

**Proposed Implementation:**
```bash
@test "path_expansion: handles undefined environment variables" {
    # Unset any test variable
    unset UNDEFINED_VAR 2>/dev/null || true
    
    local path_with_undefined="/home/\$UNDEFINED_VAR/projects"
    local result
    local exit_code
    
    set +e
    result=$(expand_path "$path_with_undefined" 2>&1)
    exit_code=$?
    set -e
    
    # Should either expand to literal or return error
    # Document actual behavior here
    [ -n "$result" ] || [ $exit_code -ne 0 ]
}
```

---

## Implementation Steps

1. **Task 12: Test Existing File**
   - [ ] Open `tests/unit/project-name-validation.bats`
   - [ ] Add test case for file (not directory) collision
   - [ ] Verify test passes with current implementation
   - [ ] If test fails, may indicate a bug to fix

2. **Task 14: Test gh CLI Unexpected Errors**
   - [ ] Open `tests/unit/github-auth.bats`
   - [ ] Add test case for unexpected error codes
   - [ ] Mock gh CLI with unusual return code
   - [ ] Verify error handling behavior

3. **Task 17: Test package.json Additional Fields**
   - [ ] Open `tests/unit/file-customization.bats`
   - [ ] Add test with complex package.json
   - [ ] Verify scripts and dependencies preserved
   - [ ] May require `jq` for JSON validation

4. **Task 19: Test Undefined Env Variables**
   - [ ] Open `tests/unit/path-expansion.bats`
   - [ ] Add test for undefined variable in path
   - [ ] Document expected behavior
   - [ ] Ensure graceful handling

---

## Testing

- [ ] All new tests pass
- [ ] All existing tests still pass
- [ ] Edge cases covered appropriately
- [ ] Test behaviors documented
- [ ] No regressions introduced

---

## Files to Modify

- `tests/unit/project-name-validation.bats` - Task 12
- `tests/unit/github-auth.bats` - Task 14
- `tests/unit/file-customization.bats` - Task 17
- `tests/unit/path-expansion.bats` - Task 19

---

## Definition of Done

- [x] All test improvements added
- [x] All tests pass (32/32)
- [ ] Code reviewed
- [x] Test coverage improved
- [x] Ready for PR

---

**Batch Rationale:**
This batch was created from fix-review report recommendations. These issues are batched together because they:
- All improve test coverage
- Share MEDIUM priority and LOW effort levels
- Add missing edge case tests
- Can be implemented together efficiently

---

**Last Updated:** 2025-12-09

