# Multi-Environment Testing - Known Issues Registry

**Purpose:** Track known CI/CD failures with fixes pending  
**Status:** ✅ Active  
**Last Updated:** 2025-12-10

---

## 🔴 Active Known Issues

_No active known issues at this time._

---

## ✅ Resolved Issues

### Issue #1: Git Branch Creation in CI (full-tests-ubuntu, quick-checks)

**Status:** ✅ Resolved  
**First Identified:** PR #30 (2025-12-08)  
**Resolved:** PR #40 (2025-12-10)  
**Fix:** Skip git branch test in CI due to detached HEAD state  
**Fix Plan:** `admin/planning/ci/multi-environment-testing/fix/known-issue-1-git-branch-ci-fix.md`

**Root Cause:** GitHub Actions checks out PRs in detached HEAD state, preventing branch creation (`git checkout -b`) even with full clone (`fetch-depth: 0`).

**Solution Implemented:**
- **Option A (Fallback):** Skip test in CI with clear message
- **Option B (Attempted):** Configure full clone (`fetch-depth: 0`) - didn't resolve issue
- Test still runs locally (maintains coverage)
- No CI failures after fix

**PRs Affected:**
- PR #30, #32, #35, #36, #37, #38, #39: Test failures documented
- PR #40: Fix implemented and merged (2025-12-10)
  - Workflow Run: [20109441927](https://github.com/grimm00/dev-infra/actions/runs/20109441927)
  - Status: ✅ All CI checks passing
  - Jobs: full-tests-ubuntu (✅), quick-checks (✅), full-tests-macos (✅)

### Issue #1: Git Operations Test Failures

**Status:** ✅ Resolved  
**Resolved:** PR #17 (2025-11-18)  
**Fix:** Updated prompt_yes_no detection logic, added CI environment variables  
**PRs Affected:** PR #16, PR #17

---

## 📊 Summary

**Active Known Issues:** 0  
**Resolved Issues:** 2  
**Last Updated:** 2025-12-10

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

**Last Updated:** 2025-12-10

