# PR #45 Fix Tracking

**PR:** #45 - feat: Version Reference Automation (Phase 2)  
**Phase:** Phase 2 - Version Reference Automation  
**Merged:** 2025-12-12  
**Status:** ✅ Complete (with deferred issues)

---

## 📋 Quick Links

- **[Phase 2 Plan](../../phase-2.md)** - Phase details
- **[Sourcery Review](../../../../feedback/sourcery/pr45.md)** - Full review
- **[Feature Status](../../status-and-next-steps.md)** - Overall progress

---

## 📋 Deferred Issues

**Date:** 2025-12-12  
**Review:** PR #45 (Phase 2) Sourcery feedback  
**Status:** 🟡 **DEFERRED** - All MEDIUM priority, test quality improvements

### Deferred Issues

**Test Quality Improvements:**

- **PR45-#2:** Placeholder tests (TODOs) - tests exist but don't exercise update logic
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟠 HIGH
  - **Description:** Several tests currently create files and assert their existence but never call `update-version-references.sh`. The `run "$SCRIPT"...` lines are still TODOs, so they don't verify the advertised update/validation behavior.
  - **Action:** Need proper integration tests that exercise script's update logic

- **PR45-#3:** Test exit codes too permissive - should assert specific expected status
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟢 LOW
  - **Description:** Several tests currently accept both exit codes 0 and 1 for valid invocations (e.g. the version and flag acceptance tests). Now that the script behavior is defined, these should assert the *specific* expected status so regressions are caught.
  - **Action:** Tighten test assertions to expect specific exit codes

- **PR45-#4:** Missing rollback/restore tests - feature exists but not tested
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟡 MEDIUM
  - **Description:** The PR calls out "Backup and restore on failure" / "rollback on failure", but current tests only sketch backup creation (and even that is a TODO) and don't exercise rollback behavior.
  - **Action:** Add tests covering rollback/restore behavior when an update fails

- **PR45-#5:** Tests depend on real repo state (v0.4.0) - brittle
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟡 MEDIUM
  - **Description:** Several dry-run tests (e.g. `dry-run shows matching lines`, `dry-run shows file-by-file preview`, and some validation tests) assert behavior based on the real repo files (like `$PROJECT_ROOT/.cursor/rules/main.mdc`) containing `v0.4.0`. This couples test outcomes to the current repo state and release version, making them brittle.
  - **Action:** Use mock files or test fixtures instead of real repo files

- **PR45-Overall-#2:** Argument parser allows flags as values - minor robustness issue
  - **Priority:** 🟡 MEDIUM
  - **Impact:** 🟡 MEDIUM
  - **Effort:** 🟢 LOW
  - **Description:** The argument parser currently allows a flag to be consumed as the value of `--old-version`/`--new-version` (as noted in the tests). If you want to make the CLI more robust, add an explicit check that the next token does not start with `--` before treating it as a value and emit a clearer error when it does.
  - **Action:** Add validation to prevent flags being consumed as argument values

---

## ✅ Addressed Issues

**CRITICAL Issues (Fixed in PR):**

- **PR45-#1 / Overall-#1:** package.json update bug - grep check uses v-prefix but file has bare semver
  - **Status:** ✅ Fixed in commit `aff00b9`
  - **Fix:** Use `get_version_number` for package.json presence check

**LOW Issues (Fixed in PR):**

- **PR45-#6:** Documentation typo - missing dot in path
  - **Status:** ✅ Fixed in commit `aff00b9`
  - **Fix:** Changed `cursor/rules/main.mdc` to `.cursor/rules/main.mdc`

---

## 📝 Action Plan

**Immediate:** None - all CRITICAL/HIGH issues addressed in PR

**Future (Opportunistic):**
- Test quality improvements can be handled during future phases
- Consider dedicated test quality improvement PR
- Address issues when working on related functionality

**Priority:** MEDIUM - not blocking, but improves test suite quality and robustness

---

**Last Updated:** 2025-12-12  
**Status:** ✅ Documented

