# PR #8 Fixes - Critical Path Issues

**Date:** 2025-11-13  
**Source:** Bugbot feedback for PR #8  
**Status:** ✅ Fixed  
**Priority:** 🔴 Critical

---

## 🎯 Overview

During PR #8 review, Bugbot identified critical blocking issues related to outdated path references that would break user experience after the template restructure.

---

## 🐛 Issues Identified

### Bug #1: Broken Paths in show_next_steps() Function

**Location:** `scripts/new-project.sh` lines 500-501  
**Severity:** 🔴 Critical  
**Impact:** Users would see outdated paths in next steps instructions

**Problem:**
```bash
echo "- Review admin/planning/README.md for project management"
echo "- Set up your first feature in admin/planning/features/"
```

**Root Cause:**
- Template restructure moved `admin/` → `docs/maintainers/`
- Script still referenced old paths
- Would confuse users with non-existent paths

**Fix:**
```bash
echo "- Review docs/maintainers/planning/README.md for project management"
echo "- Set up your first feature in docs/maintainers/planning/features/"
```

**Files Changed:**
- `scripts/new-project.sh` (lines 500-501)

---

### Bug #2: Outdated Path in Test Helper

**Location:** `tests/helpers.bash` line 326  
**Severity:** 🔴 Critical  
**Impact:** Test validation would reference outdated paths

**Problem:**
```bash
echo "- Review admin/planning/README.md for project management"
```

**Root Cause:**
- Test helper's `show_next_steps()` function also had old paths
- Would cause test failures or incorrect validation

**Fix:**
```bash
echo "- Review docs/maintainers/planning/README.md for project management"
```

**Files Changed:**
- `tests/helpers.bash` (line 326)

---

## ✅ Verification

### Path Verification
- ✅ Verified `templates/standard-project/docs/maintainers/planning/` exists
- ✅ Verified `templates/standard-project/docs/maintainers/planning/features/` exists
- ✅ Verified `templates/standard-project/docs/maintainers/planning/README.md` exists

### Test Verification
- ✅ All 64 tests passing
- ✅ No broken path references in test output
- ✅ Test helper functions updated correctly

---

## 📝 Related Changes

### Documentation Updates
- Updated `admin/feedback/sourcery/pr08.md` priority matrix
- Added deferred tasks to `admin/feedback/deferred-tasks.md`
- Documented test file structure changes

---

## 🎯 Impact

**Before Fix:**
- Users would see broken paths in next steps
- Tests would reference non-existent paths
- Confusion about where to find documentation

**After Fix:**
- ✅ Correct paths displayed to users
- ✅ Tests validate correct structure
- ✅ Clear guidance for users

---

## 📚 Related Documentation

- [PR #8 Bugbot Feedback](../../../feedback/bugbot/pr08.md)
- [PR #8 Sourcery Feedback](../../../feedback/sourcery/pr08.md)
- [Deferred Tasks](../../../feedback/deferred-tasks.md)

---

**Last Updated:** 2025-11-13  
**Status:** ✅ Fixed  
**Verified:** All tests passing, paths correct

