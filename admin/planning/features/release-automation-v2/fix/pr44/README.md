# PR #44 Fix Tracking

**PR:** #44 - feat: automate release tag creation (Phase 1)  
**Phase:** Phase 1 - Tag Creation Automation  
**Merged:** 2025-12-11  
**Review:** Sourcery feedback

---

## 📋 Deferred Issues

**Date:** 2025-12-11  
**Review:** PR #44 (Phase 1) Sourcery feedback  
**Status:** 🟡 **DEFERRED** - 1 HIGH, 1 MEDIUM priority issue to address

**Deferred Issues:**

### HIGH Priority

- **PR44-#1:** `workflow_dispatch` will always fail validation (HIGH priority, MEDIUM effort)
  - **Location:** `.github/workflows/create-release-tag.yml:36-41`
  - **Issue:** Manual dispatch hardcodes `BRANCH_NAME="main"`, which doesn't match version regex
  - **Impact:** Dry-run mode cannot be tested manually
  - **Recommendation:** Add `version` or `branch` input parameter for manual testing
  - **Action:** Address before v0.5.0 release (needed for testing)

### MEDIUM Priority

- **PR44-#2:** Check if tag already exists before creating (MEDIUM priority, LOW effort)
  - **Location:** `.github/workflows/create-release-tag.yml:60-71`
  - **Issue:** If tag exists (from re-run), `git tag -a` will fail with vague error
  - **Recommendation:** Add `git rev-parse` check before creating tag
  - **Action:** Can be deferred to future improvement (low urgency)

---

## 🎯 Action Plan

**HIGH Priority (#1):**
- **When:** Before v0.5.0 release
- **Why:** Need to test dry-run mode before production use
- **How:** Add workflow input parameter for version/branch, update extraction logic

**MEDIUM Priority (#2):**
- **When:** Opportunistic (during future workflow improvements)
- **Why:** Improves error handling but not critical (first-time creation will work)
- **How:** Add tag existence check with clear error message

---

## 📝 Notes

**Workflow Status:**
- Automated PR merge path works correctly (primary use case)
- Manual dispatch path needs fix for testing
- First production use: v0.5.0 release

**Related:**
- **Sourcery Review:** `admin/feedback/sourcery/pr44.md`
- **Phase Plan:** `admin/planning/features/release-automation-v2/phase-1.md`
- **Feature Status:** `admin/planning/features/release-automation-v2/status-and-next-steps.md`

---

**Last Updated:** 2025-12-11  
**Status:** 🟡 Deferred issues tracked

