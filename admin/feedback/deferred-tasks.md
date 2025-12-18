# Deferred Tasks and Opportunities

**Purpose:** Collection of medium and low priority tasks/opportunities identified in PR reviews that have been deferred for future work  
**Status:** 📋 Active Backlog  
**Last Updated:** 2025-12-10

---

## Overview

This document tracks all medium (🟡) and low (🟢) priority tasks identified during PR code reviews that have been assessed but deferred to future work. These are non-blocking improvements that can be addressed when time permits or as part of ongoing code quality improvements.

**Total Tasks:** 42 (3 fixed in PR #39, 20 new from PR #39, PR #40, PR #41, PR #42)

- 🟠 **HIGH**: 1 task (deferred - edge case)
- 🟡 **MEDIUM**: 26 tasks
- 🟢 **LOW**: 18 tasks (1 fixed)

---

## 🟡 Medium Priority Tasks

### Code Quality & Maintainability

#### Task 1: Return Code Documentation

- **Source:** PR #6 - Sourcery Overall Comment #1
- **Location:** `scripts/new-project.sh:92-175` - `validate_target_directory()` function
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟢 LOW
- **Description:** Add inline comments or constants to document return codes (0, 1, 2, 3) in `validate_target_directory()` function to avoid magic numbers and improve readability.
- **Proposed Implementation:**
  ```bash
  # Return codes:
  # 0 - Directory exists and is writable
  # 1 - Parent directory doesn't exist (but path returned for creation attempt)
  # 2 - Directory or parent is not writable
  # 3 - Directory doesn't exist but parent exists and is writable (can be created)
  ```
- **Status:** 🟡 Planned

---

#### Task 2: Path Resolution Duplication

- **Source:** PR #5 - Sourcery Overall Comment
- **Location:** `scripts/new-project.sh:92-175` - `validate_target_directory()` function
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟡 MEDIUM
- **Description:** Extract path resolution and normalization code into a helper function to DRY up the `validate_target_directory()` function. There's significant duplication in the path resolution logic.
- **Status:** ⏸️ Deferred

---

#### Task 3: Whitespace Trimming

- **Source:** PR #5 - Sourcery Comment #2
- **Location:** `scripts/new-project.sh:203-208` - `validate_project_name()` function
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟢 LOW
- **Description:** Trim leading and trailing whitespace before applying replacement to prevent unwanted dashes at the start or end of project names. Currently only internal whitespace is replaced.
- **Status:** ⏸️ Deferred

---

#### Task 4: Unknown Login Warning

- **Source:** PR #5 - Sourcery Comment #4
- **Location:** `scripts/new-project.sh:403-405` - `verify_github_auth()` function
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟢 LOW
- **Description:** Display a warning or status message when the GitHub login is 'unknown' to assist users in identifying authentication problems.
- **Status:** ⏸️ Deferred

---

### Documentation

#### Task 5: Consolidate README Sections

- **Source:** PR #1 - Sourcery Overall Comment #1
- **Location:** `README.md`
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟢 LOW
- **Description:** Consolidate the Installation and Quick Start sections in README to avoid duplication and streamline onboarding.
- **Status:** ⏸️ Deferred to v0.1.1

---

#### Task 6: Split Integration Guide

- **Source:** PR #1 - Sourcery Overall Comment #2
- **Location:** `docs/integration/` or `INTEGRATION.md`
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟡 MEDIUM
- **Description:** The integration guide is very large (600+ lines). Splitting it into focused sub-documents or sections could improve readability and maintainability.
- **Status:** ⏸️ Deferred to v0.1.1

---

#### Task 7: Root Directory Edge Case (Already Addressed)

- **Source:** PR #5 - Sourcery Comment #1
- **Location:** `scripts/new-project.sh:150-153` - `validate_target_directory()` function
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟢 LOW
- **Description:** Add a condition to retain '/' when dir_path is the root directory to avoid returning an empty string. **Note:** This was actually addressed in PR #6 as part of the critical bug fix.
- **Status:** ✅ Addressed in PR #6

---

## 🟢 Low Priority Tasks

### Code Quality

#### Task 8: Multiple Trailing Slashes

- **Source:** PR #5 - Sourcery Comment #3
- **Location:** `scripts/new-project.sh:222` (or related path handling)
- **Priority:** 🟢 LOW
- **Impact:** 🟢 LOW
- **Effort:** 🟢 LOW
- **Description:** Consider using a pattern that removes all trailing slashes, such as `${target_dir%%/}`, or implement a loop to ensure consistent normalization. **Note:** This is already handled in `validate_target_directory()` but could be applied elsewhere.
- **Status:** ⏸️ Deferred

---

#### Task 9: sed vs bash expansion (Already Addressed)

- **Source:** PR #5 - Sourcery Overall Comment
- **Location:** `scripts/new-project.sh:205` - `validate_project_name()` function
- **Priority:** 🟢 LOW
- **Impact:** 🟢 LOW
- **Effort:** 🟢 LOW
- **Description:** Replace external `sed` call for whitespace sanitization with bash parameter expansion (e.g. `${name//[[:space:]]/-}`) to avoid spawning a subshell. **Note:** This was actually addressed in PR #6 as part of the critical bug fix for cross-platform compatibility.
- **Status:** ✅ Addressed in PR #6

---

### Documentation

#### Task 10: Duplicate Status Fields

- **Source:** PR #6 - Sourcery Overall Comment #2
- **Location:** `admin/planning/features/directory-selection/fix/pr05-implementation-plan.md`
- **Priority:** 🟢 LOW
- **Impact:** 🟢 LOW
- **Effort:** 🟢 LOW
- **Description:** Remove duplicate "Status" field from the implementation plan markdown. The document has a Status field in the header and another at the bottom—remove the redundant one to streamline the document.
- **Status:** 🟡 Planned

---

#### Task 11: Automate CURRENT_DATE Placeholder

- **Source:** PR #1 - Sourcery Overall Comment #3
- **Location:** Template files
- **Priority:** 🟢 LOW
- **Impact:** 🟢 LOW
- **Effort:** 🟡 MEDIUM
- **Description:** Evaluate automating the `{{CURRENT_DATE}}` placeholder in templates to avoid manual updates and ensure consistency.
- **Status:** ⏸️ Deferred to v0.1.1

---

#### Task 12: Test for Existing File (Not Directory)

- **Source:** PR #7 - Sourcery Comment #1
- **Location:** `tests/new-project.bats:252-264` - `validate_project_name()` tests
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟢 LOW
- **Description:** Add a test case for when a file (not directory) with the intended project name exists, to ensure this edge case is handled correctly by `validate_project_name()`.
- **Proposed Implementation:**

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

- **Status:** ⏸️ Deferred

---

#### Task 13: Use Portable Path Utilities

- **Source:** PR #7 - Sourcery Overall Comment #1
- **Location:** `scripts/new-project.sh:92-175` - `validate_target_directory()` function
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟠 HIGH
- **Description:** Consider leveraging portable utilities like `realpath` or `readlink -f` with fallbacks instead of extensive custom string manipulation for path normalization. This would reduce code complexity and improve maintainability.
- **Status:** ⏸️ Deferred

---

#### Task 14: Test for gh CLI Unexpected Errors

- **Source:** PR #8 - Sourcery Comment #1
- **Location:** `tests/github-auth.bats`
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟢 LOW
- **Description:** Add a test case where gh CLI is installed but returns an unexpected error, to verify error handling in `verify_github_auth()` function handles edge cases beyond the current scenarios (not_installed, failure, mismatch).
- **Status:** 🟡 Planned

---

#### Task 15: Test for Template Directory Permissions

- **Source:** PR #8 - Sourcery Comment #2
- **Location:** `tests/template-operations.bats` or new test file
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟡 MEDIUM
- **Description:** Add a test that triggers permission or read errors on the template directory to verify the script handles these cases and reports errors clearly. This requires permission manipulation which may be complex in test environments.
- **Status:** 🟡 Planned

---

#### Task 16: Extract Test Implementations to Dedicated Fixture Library

- **Source:** PR #8 - Sourcery Overall Comment #2
- **Location:** `tests/helpers.bash` - extract test-specific implementations
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟠 HIGH
- **Description:** Extract test-specific implementations (copy_template, customize_project, etc.) out of helpers.bash into a dedicated test fixture or mock library to avoid mixing production logic with test stubs. This would improve separation of concerns and make test helpers more maintainable.
- **Status:** 🟡 Planned

---

## Summary by Status

### 🟡 Planned (Ready to Address)

- Task 1: Return Code Documentation
- Task 10: Duplicate Status Fields
- Task 14: Test for gh CLI Unexpected Errors
- Task 15: Test for Template Directory Permissions
- Task 16: Extract Test Implementations to Dedicated Fixture Library

### ⏸️ Deferred (Future Work)

- Task 2: Path Resolution Duplication
- Task 3: Whitespace Trimming
- Task 4: Unknown Login Warning
- Task 5: Consolidate README Sections
- Task 6: Split Integration Guide
- Task 8: Multiple Trailing Slashes
- Task 11: Automate CURRENT_DATE Placeholder
- Task 12: Test for Existing File (Not Directory)
- Task 13: Use Portable Path Utilities
- Task 14: Test for gh CLI Unexpected Errors
- Task 15: Test for Template Directory Permissions
- Task 16: Extract Test Implementations to Dedicated Fixture Library

### ✅ Addressed (Already Fixed)

- Task 7: Root Directory Edge Case (Fixed in PR #6)
- Task 9: sed vs bash expansion (Fixed in PR #6)

---

## Priority Levels Reference

- 🔴 **CRITICAL**: Security, stability, or core functionality issues
- 🟠 **HIGH**: Bug risks or significant maintainability issues
- 🟡 **MEDIUM**: Code quality and maintainability improvements
- 🟢 **LOW**: Nice-to-have improvements

## Impact Levels Reference

- 🔴 **CRITICAL**: Affects core functionality
- 🟠 **HIGH**: User-facing or significant changes
- 🟡 **MEDIUM**: Developer experience improvements
- 🟢 **LOW**: Minor improvements

## Effort Levels Reference

- 🟢 **LOW**: Simple, quick changes
- 🟡 **MEDIUM**: Moderate complexity
- 🟠 **HIGH**: Complex refactoring
- 🔴 **VERY_HIGH**: Major rewrites

---

## How to Use This Document

1. **When Planning Work:** Review this list when planning sprints or code quality improvements
2. **When Addressing Tasks:** Update the status when a task is completed
3. **When Adding New Tasks:** Add new deferred medium/low priority items from PR reviews
4. **When Prioritizing:** Use priority, impact, and effort to determine what to tackle next

---

## Related Documentation

- **[PR Feedback Index](README.md)** - Overview of all PR feedback
- **[Sourcery Reviews](sourcery/)** - Individual PR review analyses
- **[Bugbot Reviews](bugbot/)** - Bug detection reports

---

**Last Updated:** 2025-12-09  
**Status:** 📋 Active Backlog

---

## PR #7 Additions

**Date:** 2025-11-12  
**Status:** ✅ Critical issue fixed, medium/low priority items deferred

### Fixed in PR #7

- ✅ **sed -i.bak portability** - Replaced with portable sed -i syntax using OSTYPE detection for macOS/BSD compatibility

### Deferred from PR #7

- Task 12: Test for existing file case (MEDIUM priority)
- Task 13: Use portable path utilities (MEDIUM priority, HIGH effort)

---

## PR #8 Additions

**Date:** 2025-11-13  
**Status:** ✅ Critical issues fixed, test file refactored, medium priority items deferred

### Fixed in PR #8

- ✅ **Broken paths in show_next_steps** - Updated to use `docs/maintainers/planning/` paths
- ✅ **Test file structure** - Split monolithic `new-project.bats` into 13 behavior-focused files (Sourcery Overall Comment #1)
- ✅ **mock_gh helper** - Already improved in previous PR (Sourcery Overall Comment #3)

### Deferred from PR #8

- Task 14: Test for gh CLI unexpected errors (MEDIUM priority, LOW effort)
- Task 15: Test for template directory permissions (MEDIUM priority, MEDIUM effort)
- Task 16: Extract test implementations to dedicated fixture library (MEDIUM priority, HIGH effort)

---

## PR #8-2 Additions

**Date:** 2025-11-13  
**Status:** ✅ Critical issue fixed, medium priority items deferred

### Fixed in PR #8-2

- ✅ **Deprecated path in test** - Updated test to check `docs/maintainers/planning` instead of `admin/planning`

### Deferred from PR #8-2

- Task 17: Test package.json with additional fields (MEDIUM priority, LOW effort)
- Task 18: Test git initialization failure scenarios (MEDIUM priority, MEDIUM effort)
- Task 19: Test undefined environment variables in path expansion (MEDIUM priority, LOW effort)
- Task 20: Test gh CLI not executable scenario (MEDIUM priority, MEDIUM effort)
- Task 21: Refine smoke test for end-to-end validation (MEDIUM priority, MEDIUM effort)
- Task 22: Create migration guide for template restructure (MEDIUM priority, MEDIUM effort)

---

## PR #10 Additions

**Date:** 2025-11-14  
**Status:** ✅ All items fixed/verified, no deferred tasks

### Fixed in PR #10 / PR #11

- ✅ **CLI script references** - Updated `scripts/new-project.sh` to reference "Standard Project" instead of "Regular Project" (Fixed in PR #11)
- ✅ **CI/CD workflow references** - Updated `.github/workflows/release-distribution.yml` to reference `standard-project` template (Fixed in PR #11)
- ✅ **Markdown links verification** - Verified all template links correctly point to `docs/maintainers/` paths (Already correct in PR #10)

### Deferred from PR #10

- None - All verification items were addressed (fixed or verified)

---

## PR #35 Additions

**Date:** 2025-12-09  
**Status:** ✅ Deferred issues added to backlog

### Deferred from PR #35 (Release Readiness Phase 3)

- Task 23: Shell `&&`/`||` precedence bug (HIGH priority, LOW effort) - ✅ Fixed in PR #37
- Task 24: Add comprehensive blocking vs non-blocking test cases (MEDIUM priority, MEDIUM effort)
- Task 25: Remove duplicate `generate_assessment` function (MEDIUM priority, MEDIUM effort)
- Task 26: Improve HTML tag test assertions (LOW priority, LOW effort) - ✅ Fixed in PR #36
- Task 27: Refactor blocking criteria to use array iteration (LOW priority, MEDIUM effort)

---

## PR #36 Additions

**Date:** 2025-12-09  
**Status:** ✅ Deferred issues added to backlog

### Deferred from PR #36 (Quick Wins Cross-PR Batch)

- Task 28: Add negative test case for malformed HTML tags (LOW priority, LOW effort) - Nice-to-have improvement to test coverage

---

## PR #37 Additions

**Date:** 2025-12-09  
**Status:** ✅ Deferred issues added to backlog

### Deferred from PR #37 (Script Improvements Cross-PR Batch)

- Task 29: Extract whitespace trimming/sanitization into helper function (LOW priority, MEDIUM effort) - Deferred: code duplication refactoring
- Task 30: Use POSIX-compatible `=` instead of bash-specific `==` (LOW priority, LOW effort) - Deferred: POSIX compatibility improvement

---

## PR #38 Additions

**Date:** 2025-12-09  
**Status:** ✅ Deferred issues added to backlog

### Deferred from PR #38 (Test Improvements Cross-PR Batch)

- Task 31: Tighten path expansion test assertion for undefined vars (MEDIUM priority, LOW effort) - Deferred: test assertion precision - ✅ Fixed in PR #39
- Task 32: Clarify existing file collision test assertion (MEDIUM priority, LOW effort) - Deferred: test assertion clarity - ✅ Fixed in PR #39
- Task 33: Tighten assertions in gh CLI and path expansion tests (MEDIUM priority, LOW effort) - Deferred: test assertion robustness - ✅ Fixed in PR #39

---

## PR #39 Additions

**Date:** 2025-12-10  
**Status:** ✅ Deferred issues added to backlog

### Deferred from PR #39 (Test Assertion Precision Cross-PR Batch)

- Task 34: Mock gh should not fall back to real binary (MEDIUM priority, LOW effort) - Deferred: test hermiticity improvement
- Task 35: Clarify task count documentation mismatch (LOW priority, LOW effort) - Deferred: documentation clarity
- Task 36: Improve skipped test assertion clarity (LOW priority, LOW effort) - Deferred: test documentation

---

## PR #40 Additions

**Date:** 2025-12-10  
**Status:** ✅ Deferred issues added to backlog

### Deferred from PR #40 (Known Issue #1 - Git Branch CI Fix)

- Task 37: Remove fetch-depth from build-image job (LOW priority, LOW effort) - Performance optimization: build-image doesn't need full history
- Task 38: Update status field timing in planning docs (LOW priority, LOW effort) - Documentation consistency: status marked complete before CI validation

---

## PR #41 Additions

**Date:** 2025-12-10  
**Status:** ✅ Deferred issues added to backlog

### Deferred from PR #41 (Release Readiness Phase 4 - Process Integration)

- Task 39: Add git repository check before git commands (MEDIUM priority, LOW effort) - Defensive programming: script handles gracefully but explicit check would improve error messages
- Task 40: Adjust dry-run banner messaging (LOW priority, LOW effort) - UX improvement: banner says "Created Successfully" even in dry-run mode
- Task 41: Add non-dry-run test coverage for file creation (MEDIUM priority, MEDIUM effort) - Test coverage: tests only use --dry-run, don't verify actual file creation
- Task 42: Flexible argument order in CLI (LOW priority, MEDIUM effort) - UX improvement: version must come before --dry-run
- Task 43: Consistent dry-run simulation messaging (LOW priority, LOW effort) - Same as Task 40, overall comment

---

## PR #42 Additions

**Date:** 2025-12-10  
**Status:** ✅ Deferred issues added to backlog

### Deferred from PR #42 (Release Readiness Phase 5 - Historical Tracking)

- Task 44: Input validation for --last flag (MEDIUM priority, LOW effort) - Bug risk: non-numeric input could cause integer expression error (PR42-#1, Overall-1)
- Task 45: Tests skipped in CI (MEDIUM priority, MEDIUM effort) - Testing gap: analyze-releases tests not run in CI automation (PR42-#3)
- Task 46: Strengthen JSON test assertions (MEDIUM priority, LOW effort) - Test quality: validate JSON structure with jq and required fields (PR42-#5)
- Task 47: Strengthen metrics test assertions (MEDIUM priority, LOW effort) - Test quality: validate exact output for metrics calculations (PR42-#6)
- Task 48: Remove verbose logging suppression (LOW priority, LOW effort) - UX inconsistency: 2>/dev/null disables --verbose for discovery (PR42-#2)
- Task 49: Strengthen backward compat test assertions (LOW priority, LOW effort) - Test quality: add explicit assertions for files without metadata (PR42-#4)
- Task 50: Add --last N edge case tests (LOW priority, MEDIUM effort) - Test coverage: test boundary/invalid values (PR42-#7)
- Task 51: Fix grammar typo in manual testing docs (LOW priority, LOW effort) - Documentation: "Metrics includes" → "Metrics include" (PR42-#8)
- Task 52: Refactor generate_assessment variable dependencies (LOW priority, MEDIUM effort) - Code organization: keep computation within function (PR42-Overall-2)
