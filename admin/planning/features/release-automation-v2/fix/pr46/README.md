# PR #46 Fix Tracking

**PR:** #46 - chore: Release v1.5.0  
**Type:** Release PR  
**Merged:** TBD  
**Status:** 🟡 **DEFERRED** - 1 HIGH, 5 MEDIUM priority issues deferred

---

## 📋 Quick Links

- **[Sourcery Review](../../../../feedback/sourcery/pr46.md)** - Full review
- **[Feature Status](../../status-and-next-steps.md)** - Overall progress

---

## 📋 Deferred Issues

**Date:** 2025-12-12  
**Review:** PR #46 (Release v1.5.0) Sourcery feedback  
**Status:** 🟡 **DEFERRED** - 1 HIGH, 5 MEDIUM priority issues

### HIGH Priority Issues (Deferred)

**Workflow Enhancement:**

- **PR46-#3:** Workflow manual dispatch always fails
  - **Priority:** 🟠 HIGH
  - **Impact:** 🟠 HIGH
  - **Effort:** 🟡 MEDIUM
  - **Description:** The `workflow_dispatch` path in `.github/workflows/create-release-tag.yml` hardcodes `BRANCH_NAME="main"` which will always fail version validation. Manual testing of the tag creation workflow is not possible.
  - **Action:** Add explicit `branch` and/or `version` inputs for workflow_dispatch so dry-run/manual testing can exercise the same validation logic as the PR path.
  - **Note:** Not blocking release - PR merge path works correctly. This affects manual testing only.

### MEDIUM Priority Issues (Deferred)

**Test Quality Improvements:**

- **PR46-#4:** Placeholder tests (TODOs) - tests exist but don't exercise update logic
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟠 HIGH
  - **Description:** Several tests in Task 2/3 sections currently create fixtures and check setup, but never invoke the script or assert its side effects. The `run "$SCRIPT"...` lines are still TODOs. Tests pass even if implementation is a no-op.
  - **Action:** Complete placeholder tests to exercise actual file update and validation behavior. Add integration tests that verify script updates files correctly.

- **PR46-#5:** Test exit codes too permissive - should assert specific expected status
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟢 LOW
  - **Description:** Tests like "accepts valid version formats" allow both exit codes 0 and 1 for valid invocations. This means tests still pass if valid input is incorrectly treated as an error.
  - **Action:** Tighten test assertions to expect specific exit codes per case. Split tests if needed for pre/post implementation states.

- **PR46-#6:** Tests depend on real repo state (v1.4.0) - brittle
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟡 MEDIUM
  - **Description:** Several tests (dry-run, validation) assert behavior based on real repo files containing `v1.4.0`. This couples test outcomes to current repo state, making them brittle. Tests will become no-ops when version changes.
  - **Action:** Use mock files or test fixtures under `$BATS_TEST_TMPDIR` instead of real repo files. Control file contents independently of repo version.

- **PR46-#7:** Missing rollback/restore tests - feature exists but not tested
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟡 MEDIUM
  - **Description:** The script documents "backup and restore on failure" / "rollback on failure", but current tests only sketch backup creation (with TODOs) and don't exercise rollback behavior.
  - **Action:** Add tests that (1) verify `.bak` file is created with original content, and (2) simulate failure during update to confirm rollback leaves files consistent and returns non-zero exit code.

### Overall Comments (Deferred)

- **PR46-Overall-#1:** Workflow dispatch needs explicit branch/version inputs
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟡 MEDIUM
  - **Description:** Consider adding explicit inputs for `branch` and/or `version` for the `workflow_dispatch` path so dry-run/manual testing can exercise the same validation logic as the PR path.
  - **Action:** Add workflow inputs for manual testing capability.

- **PR46-Overall-#2:** Script hardcodes target locations - consider configuration
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟡 MEDIUM
  - **Description:** The version update script currently hardcodes three target locations in `main()`. If more versioned files are added over time, consider extracting into configuration structure.
  - **Action:** Extract target file locations into configuration or separate function for easier maintenance.

---

## ✅ Addressed Issues

**FALSE POSITIVES (Already Fixed in PR #45):**

- **PR46-#1:** package.json version verification bug
  - **Status:** ✅ Already fixed in PR #45 (commit aff00b9)
  - **Fix:** Script already uses `get_version_number()` for package.json checks

- **PR46-#2:** Dry-run match preview for package.json
  - **Status:** ✅ Already fixed in PR #45 (commit aff00b9)
  - **Fix:** Dry-run logic already handles package.json correctly

**LOW Issues (Fixed in PR #46):**

- **PR46-#8:** Broken relative links in RELEASE-NOTES.md
  - **Status:** ✅ Fixed in commit 9c5b20a
  - **Fix:** Removed extra `admin/` segment from paths, corrected relative levels

- **PR46-#9:** Broken relative links in VERSION-REFERENCES.md
  - **Status:** ✅ Fixed in commit 9c5b20a
  - **Fix:** Added missing `../` prefix to admin paths

---

## 📝 Action Plan

**Immediate:** None - all CRITICAL/LOW issues addressed in PR

**Future (Opportunistic):**
- HIGH priority workflow enhancement (PR46-#3) - enables manual testing
- MEDIUM priority test quality improvements (PR46-#4, #5, #6, #7) - improves test suite
- MEDIUM priority script enhancements (Overall comments) - improves maintainability

**Priority:** HIGH (#3) for workflow testing, MEDIUM for test improvements

---

**Last Updated:** 2025-12-12  
**Status:** ✅ Documented

