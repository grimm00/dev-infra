# Deferred Tasks and Opportunities

**Purpose:** Collection of medium and low priority tasks/opportunities identified in PR reviews that have been deferred for future work  
**Status:** 📋 Active Backlog  
**Last Updated:** 2025-11-12

---

## Overview

This document tracks all medium (🟡) and low (🟢) priority tasks identified during PR code reviews that have been assessed but deferred to future work. These are non-blocking improvements that can be addressed when time permits or as part of ongoing code quality improvements.

**Total Tasks:** 11
- 🟡 **MEDIUM**: 7 tasks
- 🟢 **LOW**: 4 tasks

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
- **Status:** ⏸️ Deferred to v1.1.0

---

#### Task 6: Split Integration Guide
- **Source:** PR #1 - Sourcery Overall Comment #2
- **Location:** `docs/integration/` or `INTEGRATION.md`
- **Priority:** 🟡 MEDIUM
- **Impact:** 🟡 MEDIUM
- **Effort:** 🟡 MEDIUM
- **Description:** The integration guide is very large (600+ lines). Splitting it into focused sub-documents or sections could improve readability and maintainability.
- **Status:** ⏸️ Deferred to v1.1.0

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
- **Status:** ⏸️ Deferred to v1.1.0

---

## Summary by Status

### 🟡 Planned (Ready to Address)
- Task 1: Return Code Documentation
- Task 10: Duplicate Status Fields

### ⏸️ Deferred (Future Work)
- Task 2: Path Resolution Duplication
- Task 3: Whitespace Trimming
- Task 4: Unknown Login Warning
- Task 5: Consolidate README Sections
- Task 6: Split Integration Guide
- Task 8: Multiple Trailing Slashes
- Task 11: Automate CURRENT_DATE Placeholder

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

**Last Updated:** 2025-11-12  
**Status:** 📋 Active Backlog

