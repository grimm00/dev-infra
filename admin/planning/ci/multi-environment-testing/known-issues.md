# Multi-Environment Testing - Known Issues Registry

**Purpose:** Track known CI/CD failures with fixes pending  
**Status:** ✅ Active  
**Last Updated:** 2025-12-08

---

## 🔴 Active Known Issues

### Issue #1: full-tests-ubuntu Intermittent Failures

**Status:** 🟡 Known Issue - Under Investigation  
**First Identified:** PR #30 (2025-12-08)  
**Affected Jobs:** `full-tests-ubuntu`  
**Platform:** Ubuntu (Docker container)  
**Fix Status:** 🟡 Under Investigation  
**Fix Tracking:** `admin/planning/ci/multi-environment-testing/fix/`

**Symptoms:**
- Job fails with test failures
- Tests pass locally (58/58 passing)
- Platform-specific or environment-specific issue
- May be flaky tests or environment differences

**Workaround:**
- Local tests passing (58/58)
- Can proceed with PR validation if local tests pass
- Document failure but don't block PR merge
- Fixes tracked in multi-environment-testing topic

**Investigation:**
- Review workflow run logs for root cause
- Compare local vs CI environment differences
- Check for flaky tests or timing issues
- See: `admin/planning/ci/multi-environment-testing/fix/pr30-failures.md`

**Fix Plan:**
- See: `admin/planning/ci/multi-environment-testing/fix/next-steps.md`
- Priority: MEDIUM (tests pass locally, not blocking)
- Estimated Fix: TBD

**PRs Affected:**
- PR #30: Documented failure (2025-12-08)
  - Workflow Run: [20036474596](https://github.com/grimm00/dev-infra/actions/runs/20036474596)
  - Status: Local tests passing (58/58), CI failure documented
  - Failure Document: `admin/planning/ci/multi-environment-testing/fix/pr30-failures.md`
- PR #31: Empty directory fix (2025-12-08)
  - Workflow Run: [20041642506](https://github.com/grimm00/dev-infra/actions/runs/20041642506)
  - Status: ✅ All CI checks passing (full-tests-ubuntu, full-tests-macos)
  - Fix: Added `.gitkeep` files to empty stage directories
  - Fix Document: `admin/planning/ci/multi-environment-testing/fix/pr30-fix-plan.md`
- PR #32: Release Readiness Phase 1 & 2 (2025-12-09)
  - Workflow Run: [20050338867](https://github.com/grimm00/dev-infra/actions/runs/20050338867)
  - Status: Test failure in check-release-readiness.sh (test #6: git branch creation in CI)
  - Note: Local tests passing (17/17), CI-specific git issue
  - Issue: Git branch creation fails in CI (status 128)
  - Fixes included: gh CLI skipped check bug (PR32-#2), Phase 1 completion criteria (PR32-#6)
- PR #35: Release Readiness Phase 3 (2025-12-09)
  - Workflow Run: [20075363421](https://github.com/grimm00/dev-infra/actions/runs/20075363421)
  - Status: Test failure in check-release-readiness.sh (test #6/81: git branch creation in CI)
  - Note: Local tests passing (26/26), CI-specific git issue
  - Issue: Git branch creation fails in CI (status 128) - same as PR #32
  - Jobs: full-tests-ubuntu (❌), quick-checks (❌), full-tests-macos (✅)

---

## ✅ Resolved Issues

### Issue #1: Git Operations Test Failures

**Status:** ✅ Resolved  
**Resolved:** PR #17 (2025-11-18)  
**Fix:** Updated prompt_yes_no detection logic, added CI environment variables  
**PRs Affected:** PR #16, PR #17

---

## 📊 Summary

**Active Known Issues:** 1  
**Resolved Issues:** 1  
**Last Updated:** 2025-12-08

---

## 🔄 Update Process

1. **When new failure identified:**
   - Check if matches existing known issue
   - If match: Add PR number to "PRs Affected"
   - If no match: Create new known issue entry

2. **When fix implemented:**
   - Update fix status to "Resolved"
   - Move to "Resolved Issues" section
   - Note resolution date and PR number

3. **When investigating:**
   - Update investigation status
   - Link to failure documentation
   - Update fix plan if needed

---

**Last Updated:** 2025-12-08

