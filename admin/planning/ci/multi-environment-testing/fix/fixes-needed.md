# Multi-Environment Testing Fixes Needed

**Purpose:** Prioritized list of fixes required to resolve workflow failures  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-11-17  
**PRs:** #16, #17

---

## 📋 Overview

This document lists all fixes needed to resolve the failures in PR #17, prioritized by severity and impact.

---

## 🔴 Critical Fixes

### Fix 1: Make `prompt_yes_no` Work Correctly in GitHub Actions CI

**Priority:** 🔴 Critical  
**Impact:** 🔴 Critical  
**Effort:** 🟢 Low

**Issue:**

- `prompt_yes_no` function fails to detect non-interactive environment in GitHub Actions
- Previous fix attempt didn't work
- Tests pass locally but fail in CI
- Function tries to read from stdin which hangs/fails in CI

**Root Cause:**

- Detection logic doesn't work in GitHub Actions
- `[ ! -t 0 ]` may not work as expected
- `$CI` may not be set in GitHub Actions
- `$BATS_RUN_TMPDIR` may not be available when functions are sourced

**Fix:**

1. **Update detection logic** to check for `$GITHUB_ACTIONS`:
   ```bash
   if [ -n "$GITHUB_ACTIONS" ] || [ -n "$CI" ] || [ -n "$NON_INTERACTIVE" ] || [ ! -t 0 ] || [ -n "$BATS_RUN_TMPDIR" ]; then
       # Non-interactive: return default value
       case "${default:-n}" in
           [Yy]* ) return 0;;
           * ) return 1;;
       esac
   fi
   ```

2. **Set environment variables in workflow:**
   ```yaml
   - name: Run unit tests
     run: bats --recursive tests/unit/ || exit 1
     env:
       CI: true
       NON_INTERACTIVE: true
   ```

3. **Test locally before pushing:**
   ```bash
   CI=true bats tests/unit/git-operations.bats
   GITHUB_ACTIONS=true bats tests/unit/git-operations.bats
   ```

**Verification:**

- Tests pass locally with `CI=true`
- Tests pass in GitHub Actions CI
- All 64 tests pass
- No hanging or stdin errors

**Status:** ⏳ Pending - Previous attempt failed, needs new approach

---

### Fix 2: Fix Platform-Specific Test Failures (Still Failing)

**Priority:** 🔴 Critical  
**Impact:** 🔴 Critical  
**Effort:** 🟡 Medium

**Issue:**

- Tests fail on Ubuntu but pass on macOS
- Same tests, different results
- Suggests environment or detection differences

**Fix:**

- Will be resolved by Fix 1 (prompt_yes_no fix)
- If still failing after Fix 1, investigate platform-specific differences

**Verification:**

- Tests pass on both Ubuntu and macOS
- No platform-specific failures

**Status:** ⏳ Pending - Depends on Fix 1

---

## 🟠 High Priority Fixes

### Fix 3: Add Local Testing Before Pushing

**Priority:** 🟠 High  
**Impact:** 🟠 High  
**Effort:** 🟢 Low

**Issue:**

- Code changes pushed without local testing
- Fixes attempted without verification
- Wastes CI time and resources

**Fix:**

- Always test locally before pushing
- Use `CI=true` to simulate CI environment
- Run full test suite before committing
- Document testing steps

**Implementation:**

1. Test with CI environment:
   ```bash
   CI=true bats --recursive tests/
   ```

2. Test specific failing tests:
   ```bash
   CI=true bats tests/unit/git-operations.bats
   ```

3. Verify all tests pass:
   ```bash
   bats --recursive tests/
   ```

**Verification:**

- All tests pass locally before pushing
- CI environment simulated correctly
- No regressions introduced

**Status:** ⏳ Pending - Process improvement needed

---

## 🟡 Medium Priority Fixes

### Fix 4: Improve Error Messages in Tests

**Priority:** 🟡 Medium  
**Impact:** 🟡 Medium  
**Effort:** 🟢 Low

**Issue:**

- Error messages don't show why function failed
- Difficult to debug in CI
- No output from failed function calls

**Fix:**

- Add debug output to `prompt_yes_no` when detection fails
- Log which detection method triggered (if any)
- Show environment variables in test output

**Verification:**

- Clear error messages in CI logs
- Easy to identify why detection failed

**Status:** ⏳ Pending - Nice to have

---

## 📊 Fix Priority Matrix

| Fix | Priority | Impact | Effort | Status |
|-----|----------|--------|--------|--------|
| Fix 1: prompt_yes_no in CI | 🔴 Critical | 🔴 Critical | 🟢 Low | ⏳ Pending |
| Fix 2: Platform-Specific Tests | 🔴 Critical | 🔴 Critical | 🟡 Medium | ⏳ Pending |
| Fix 3: Local Testing Process | 🟠 High | 🟠 High | 🟢 Low | ⏳ Pending |
| Fix 4: Error Messages | 🟡 Medium | 🟡 Medium | 🟢 Low | ⏳ Pending |

---

## 🎯 Implementation Order

1. **Fix 1** - Critical fix first (blocks all tests)
2. **Fix 3** - Process improvement (prevent future issues)
3. **Fix 2** - Verify platform-specific (should be resolved by Fix 1)
4. **Fix 4** - Nice to have (improve debugging)

---

## 📝 Notes

- Previous fix attempt (commit `df1378d`) didn't work
- Need to investigate GitHub Actions environment more thoroughly
- Must test locally with `CI=true` before pushing
- Consider setting explicit environment variables in workflow

---

**Status:** 🟠 In Progress  
**Next:** See [Next Steps](next-steps.md) for implementation plan

