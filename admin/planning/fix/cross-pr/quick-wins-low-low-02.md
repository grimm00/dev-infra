# Fix Plan: Cross-PR Batch Quick Wins Round 2 - LOW LOW

**Batch:** quick-wins-low-low-02  
**Priority:** 🟢 LOW  
**Effort:** 🟢 LOW  
**Status:** ✅ Complete  
**Created:** 2025-12-10  
**Completed:** 2025-12-15  
**PR:** [#52](https://github.com/grimm00/dev-infra/pull/52)  
**Source:** fix-review-report-2025-12-10.md  
**Issues:** 2 issues from 2 PRs

---

## Issues in This Batch

| Issue | PR | Priority | Impact | Effort | Description |
|-------|-----|----------|--------|--------|-------------|
| PR36-#1 | 36 | 🟢 LOW | 🟢 LOW | 🟢 LOW | Add negative test case for malformed HTML tags |
| PR37-Overall-2 | 37 | 🟢 LOW | 🟢 LOW | 🟢 LOW | Use POSIX `=` instead of bash `==` |

---

## Overview

This batch contains 2 LOW priority issues with LOW effort from PRs #36 and #37. These are true quick wins that can be implemented quickly and improve code quality.

**Estimated Time:** 30-45 minutes  
**Files Affected:**
- `tests/unit/check-release-readiness.bats`
- `scripts/new-project.sh`

**Source PRs:**
- PR #36: Quick Wins Cross-PR Batch (2025-12-09)
- PR #37: Script Improvements Cross-PR Batch (2025-12-09)

**Common Theme:** Small, simple improvements to test coverage and POSIX compatibility.

---

## Issue Details

### Issue PR36-#1: Add Negative Test Case for Malformed HTML Tags

**Source PR:** 36 - Quick Wins Cross-PR Batch  
**Location:** `tests/unit/check-release-readiness.bats:237-239`  
**Sourcery Comment:** Comment #1  
**Priority:** 🟢 LOW | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

Right now this only confirms the valid case where all four tags are present. If the script is expected to enforce this structure, please add a negative test where some of the tags are missing or malformed and assert that the script fails or flags an error. That will cover the failure path when the HTML structure is broken.

**Current Code:**

```bash
# Evidence sections should use HTML details/summary for collapsible content
# Check for both opening tags (proper HTML structure)
[[ "$output" =~ "<details>" ]] && [[ "$output" =~ "<summary>" ]]
# Verify closing tags are present (proper HTML structure)
[[ "$output" =~ "</summary>" ]] && [[ "$output" =~ "</details>" ]]
```

**Proposed Solution:**

Add a negative test case to verify malformed HTML detection (if applicable):

```bash
@test "check_release_readiness: detects malformed HTML in output" {
    # Setup: Create release directory with proper structure
    local version="v1.0.0"
    mkdir -p "admin/planning/releases/$version"
    echo "# Release Notes" > "admin/planning/releases/$version/RELEASE-NOTES.md"
    echo "# Changelog" > "CHANGELOG.md"
    
    # Run check
    run bash scripts/check-release-readiness.sh "$version"
    
    # Verify that if HTML tags are present, they are properly paired
    # If script doesn't enforce HTML structure, this test documents current behavior
    # Either:
    # (a) Script enforces HTML and this test verifies detection of malformed tags
    # (b) Script doesn't enforce, and this test documents that it doesn't fail on bad HTML
    
    # For now, document that script doesn't validate HTML structure
    # (This test may be marked as skip if HTML validation is not a requirement)
    skip "Script does not currently validate HTML structure in output"
}
```

**Note:** This test should be adjusted based on whether the script actually needs to validate HTML structure. If validation is not required, the test can be skipped or removed.

**Related Files:**
- `tests/unit/check-release-readiness.bats` - Add negative test

---

### Issue PR37-Overall-2: Use POSIX `=` Instead of Bash `==`

**Source PR:** 37 - Script Improvements Cross-PR Batch  
**Sourcery Comment:** Overall Comment #2  
**Priority:** 🟢 LOW | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:**

In `verify_github_auth()`, the string comparison uses `==`, which is bash-specific; either switch to `=` for POSIX compatibility or ensure the shebang and usage clearly assume bash for consistency across environments.

**Current Code:**

```bash
verify_github_auth() {
    # ... code ...
    
    if [ -n "$github_login" ] && [ "$github_login" != "unknown" ]; then
        print_status "Authenticated as: $github_login"
    elif [ "$github_login" == "unknown" ]; then
        # ^^ This uses bash-specific ==
        print_warning "GitHub login returned 'unknown'. This may indicate authentication issues."
        print_warning "Try running 'gh auth status' to verify your GitHub authentication."
    fi
    
    # ... rest of function ...
}
```

**Proposed Solution:**

Change `==` to POSIX-compatible `=`:

```bash
verify_github_auth() {
    # ... code ...
    
    if [ -n "$github_login" ] && [ "$github_login" != "unknown" ]; then
        print_status "Authenticated as: $github_login"
    elif [ "$github_login" = "unknown" ]; then
        # Now POSIX-compatible
        print_warning "GitHub login returned 'unknown'. This may indicate authentication issues."
        print_warning "Try running 'gh auth status' to verify your GitHub authentication."
    fi
    
    # ... rest of function ...
}
```

**Note:** The script uses `#!/usr/bin/env bash` shebang, so bash-specific features are technically allowed. However, using POSIX-compatible syntax improves portability and consistency.

**Related Files:**
- `scripts/new-project.sh` - Change `==` to `=` in `verify_github_auth()`

---

## Implementation Steps

1. **Issue PR36-#1: HTML Malformed Test**
   - [ ] Review if HTML validation is a requirement
   - [ ] Add negative test (or skipped test documenting current behavior)
   - [ ] Run tests to verify

2. **Issue PR37-Overall-2: POSIX Compatibility**
   - [ ] Update `scripts/new-project.sh`
   - [ ] Change `[ "$github_login" == "unknown" ]` to `[ "$github_login" = "unknown" ]`
   - [ ] Search for other instances of `==` in the script (if any)
   - [ ] Run tests to verify

---

## Testing

- [ ] All existing tests pass
- [ ] New negative test added (or documented why not needed)
- [ ] POSIX compatibility change doesn't break functionality
- [ ] No regressions introduced

---

## Files to Modify

- `tests/unit/check-release-readiness.bats` - Add negative test for HTML
- `scripts/new-project.sh` - Change `==` to `=` for POSIX compatibility

---

## Definition of Done

- [x] Both issues addressed
- [x] Tests passing
- [x] Code quality improved
- [x] Documentation updated (if needed)
- [x] Ready for PR

---

**Batch Rationale:**

These issues are batched together because they:
- Both are LOW priority and LOW effort (true quick wins)
- Can be implemented very quickly (< 1 hour total)
- Don't require complex logic or refactoring
- Improve code quality incrementally
- Were identified as "Quick Wins" in fix-review report

