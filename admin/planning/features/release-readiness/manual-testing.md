# Release Readiness - Manual Testing Guide

**Feature:** Release Readiness  
**Phases:** 3, 5  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-12-10  
**PRs:** #35, #42

---

## 📋 Overview

Manual testing guide for the Release Readiness feature:
- Phase 3: Assessment Structure implementation
- Phase 5: Historical Tracking implementation

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

### Scenario 6: Generate Assessment with Metadata (Phase 5)

**Test:** Verify YAML frontmatter metadata in generated assessment

**CLI Test:**

```bash
./scripts/check-release-readiness.sh --generate v1.4.0 | head -20
```

**Verification:**

- [ ] Output starts with `---` (YAML frontmatter marker)
- [ ] Contains `version: v1.4.0` field
- [ ] Contains `date:` field with current date
- [ ] Contains `readiness_score:` field
- [ ] Contains `blocking_failures:` field
- [ ] Contains `total_checks:`, `passed_checks:`, `warnings:` fields
- [ ] Contains `status:` field (READY/NOT_READY/BLOCKED)
- [ ] Ends frontmatter with closing `---`
- [ ] Markdown content follows after frontmatter

**Expected Result:** ✅ YAML metadata generated correctly

---

### Scenario 7: Analyze Historical Releases (Phase 5)

**Test:** Verify historical analysis with test fixtures

**CLI Test:**

```bash
./scripts/analyze-releases.sh --dir tests/fixtures/release-assessments
```

**Verification:**

- [ ] Parses multiple assessment files
- [ ] Displays "Release Readiness Analysis" header
- [ ] Shows table with columns: Version, Date, Score, Fail, Total, Pass, Warn, Status
- [ ] Lists releases in reverse chronological order (newest first)
- [ ] Shows "Summary Metrics" section
- [ ] Displays "Total Releases Analyzed"
- [ ] Displays "Average Readiness Score"
- [ ] Displays "Trend" with indicator (📈 Improving / 📉 Declining / ➡️ Stable)

**Expected Result:** ✅ Historical analysis displays correctly

---

### Scenario 8: JSON Output Format (Phase 5)

**Test:** Verify JSON output with metrics

**CLI Test:**

```bash
./scripts/analyze-releases.sh --dir tests/fixtures/release-assessments --json
```

**Verification:**

- [ ] Output is valid JSON
- [ ] Contains `releases` array
- [ ] Each release has `version`, `date`, `readiness_score`, `blocking_failures`, `total_checks`, `passed_checks`, `warnings`, `status` fields
- [ ] Contains `metrics` object
- [ ] Metrics includes `total_releases` field
- [ ] Metrics includes `average_readiness_score` field

**Expected Result:** ✅ JSON output formatted correctly

---

### Scenario 9: Last N Releases Filter (Phase 5)

**Test:** Verify `--last N` option limits output

**CLI Test:**

```bash
./scripts/analyze-releases.sh --dir tests/fixtures/release-assessments --last 2
```

**Verification:**

- [ ] Shows only 2 most recent releases
- [ ] Summary metrics calculated for 2 releases only
- [ ] Trend compares the 2 shown releases

**Expected Result:** ✅ Last N filter works correctly

---

## ✅ Acceptance Criteria

### Phase 3 Requirements

- [x] Assessment generator implemented with `--generate` flag
- [x] Summary calculation includes blocking failures count
- [x] Summary shows overall readiness status
- [x] Evidence sections use collapsible HTML tags
- [x] All 26 unit tests passing

### Phase 5 Requirements

- [ ] YAML frontmatter metadata added to assessment generation
- [ ] Historical analysis script (`analyze-releases.sh`) implemented
- [ ] Metrics reporting with average score calculation
- [ ] Trend analysis (improving/declining/stable)
- [ ] JSON output format with metrics object
- [ ] `--last N` option to limit releases
- [ ] All 107 unit tests passing (21 new tests for Phase 5)

---

## 📝 Test Results

### Phase 3 Testing (2025-12-09)

**Tested:** 2025-12-09  
**Tester:** AI Assistant  
**Environment:** macOS (local)

**Summary:**
- **Scenarios Tested:** 5 (Scenarios 1-5)
- **Scenarios Passed:** 5
- **Scenarios Failed:** 0

**Notes:**
- All Phase 3 manual testing scenarios pass
- Unit tests pass locally (26/26)
- CI tests have known issue with git branch creation (Known Issue #1)

### Phase 5 Testing (Pending)

**Tested:** [To be run]  
**Tester:** [To be assigned]  
**Environment:** [To be tested]

**Summary:**
- **Scenarios Tested:** 0 (Scenarios 6-9)
- **Scenarios Passed:** 0
- **Scenarios Failed:** 0

**Notes:**
- Phase 5 scenarios added, ready for testing
- Unit tests pass locally (107/107 including 21 new Phase 5 tests)

---

**Last Updated:** 2025-12-10
