# Release Readiness - Manual Testing Guide

**Feature:** Release Readiness  
**Phase:** 3  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-12-09  
**PR:** #35

---

## 📋 Overview

Manual testing guide for the Release Readiness feature, specifically Phase 3: Assessment Structure implementation.

---

## 🎯 Test Scenarios

### Scenario 1: Help Command

**Test:** Verify help displays usage information

**CLI Test:**

```bash
./scripts/check-release-readiness.sh --help
```

**Verification:**

- [x] Shows usage information
- [x] Lists all options (--help, --verbose, --json, --generate)
- [x] Shows examples

**Expected Result:** ✅ Help displayed correctly

---

### Scenario 2: Standard Mode (No Flags)

**Test:** Verify standard readiness check runs all automated checks

**CLI Test:**

```bash
./scripts/check-release-readiness.sh v1.4.0
```

**Verification:**

- [x] Checks release branch existence
- [x] Checks version format
- [x] Checks CI/CD test status
- [x] Checks CHANGELOG entry
- [x] Checks release notes file
- [x] Shows recent merged PRs (if gh CLI available)
- [x] Shows blocking issues (if any)
- [x] Shows summary with pass/fail counts

**Expected Result:** ✅ All automated checks run

---

### Scenario 3: Generate Assessment (--generate)

**Test:** Verify markdown assessment generation

**CLI Test:**

```bash
./scripts/check-release-readiness.sh --generate v1.4.0
```

**Verification:**

- [x] Generates markdown output
- [x] Contains "Overall Readiness Summary" section
- [x] Shows blocking failures count
- [x] Shows release type (Major/Minor/Patch)
- [x] Contains collapsible `<details>`/`<summary>` tags
- [x] Shows check results for each criteria
- [x] Contains actionable details in evidence sections

**Expected Result:** ✅ Markdown assessment generated

---

### Scenario 4: Error Handling - Missing Version

**Test:** Verify script handles missing version argument

**CLI Test:**

```bash
./scripts/check-release-readiness.sh
```

**Verification:**

- [x] Shows error message
- [x] Displays usage information
- [x] Exits with non-zero status

**Expected Result:** ✅ Error handled correctly

---

### Scenario 5: Version Format Validation

**Test:** Verify version format validation

**CLI Test:**

```bash
./scripts/check-release-readiness.sh v1.4.0
./scripts/check-release-readiness.sh invalid-version
```

**Verification:**

- [x] Valid semantic version (v1.4.0) passes
- [x] Invalid version format detected

**Expected Result:** ✅ Version validation works

---

## ✅ Acceptance Criteria

### Phase 3 Requirements

- [x] Assessment generator implemented with `--generate` flag
- [x] Summary calculation includes blocking failures count
- [x] Summary shows overall readiness status
- [x] Evidence sections use collapsible HTML tags
- [x] All 26 unit tests passing

---

## 📝 Test Results

**Tested:** 2025-12-09  
**Tester:** AI Assistant  
**Environment:** macOS (local)

### Summary

- **Scenarios Tested:** 5
- **Scenarios Passed:** 5
- **Scenarios Failed:** 0

### Notes

- All manual testing scenarios pass
- Unit tests pass locally (26/26)
- CI tests have known issue with git branch creation (Known Issue #1)

---

**Last Updated:** 2025-12-09
