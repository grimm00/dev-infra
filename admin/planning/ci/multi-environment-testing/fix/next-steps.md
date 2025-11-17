# Multi-Environment Testing Next Steps

**Purpose:** Action plan for addressing workflow failures  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-11-17  
**PRs:** #16, #17

---

## 📋 Overview

This document outlines the action plan for fixing the issues identified in PR #17. It includes prioritized tasks, testing strategy, and verification steps.

---

## 🎯 Immediate Actions

### Step 1: Investigate GitHub Actions Environment

**Priority:** 🔴 Critical  
**Effort:** 🟢 Low  
**Timeline:** 30 minutes

**Tasks:**

- [ ] Add debug step to workflow to check environment variables
- [ ] Verify which variables are set in GitHub Actions
- [ ] Test `[ ! -t 0 ]` check in workflow
- [ ] Document findings

**Implementation:**

```yaml
- name: Debug environment
  run: |
    echo "CI=$CI"
    echo "GITHUB_ACTIONS=$GITHUB_ACTIONS"
    echo "BATS_RUN_TMPDIR=$BATS_RUN_TMPDIR"
    if [ ! -t 0 ]; then
      echo "Not a terminal"
    else
      echo "Is a terminal"
    fi
    env | grep -iE "(ci|bats|github)" | sort
```

**Output:**

- List of environment variables available
- Terminal detection result
- Clear understanding of CI environment

---

### Step 2: Update `prompt_yes_no` Function

**Priority:** 🔴 Critical  
**Effort:** 🟢 Low  
**Timeline:** 30 minutes

**Tasks:**

- [ ] Update detection logic to check `$GITHUB_ACTIONS`
- [ ] Add `$NON_INTERACTIVE` check
- [ ] Keep existing checks as fallbacks
- [ ] Add debug output (optional, for troubleshooting)

**Implementation:**

```bash
prompt_yes_no() {
    local prompt="$1"
    local default="$2"
    local input
    
    # Check if we're in a non-interactive environment (CI, automated tests, etc.)
    # Check GITHUB_ACTIONS first (GitHub Actions specific)
    # Then check CI (generic CI systems)
    # Then check NON_INTERACTIVE (explicit flag)
    # Then check terminal (fallback)
    # Finally check BATS environment
    if [ -n "$GITHUB_ACTIONS" ] || [ -n "$CI" ] || [ -n "$NON_INTERACTIVE" ] || [ ! -t 0 ] || [ -n "$BATS_RUN_TMPDIR" ]; then
        # Non-interactive: return default value
        case "${default:-n}" in
            [Yy]* ) return 0;;
            * ) return 1;;
        esac
    fi
    
    # Interactive mode (original logic)
    while true; do
        if [ -n "$default" ]; then
            read -p "$prompt [y/N]: " input
            input="${input:-$default}"
        else
            read -p "$prompt: " input
        fi
        
        case $input in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
```

**Output:**

- Updated function with better detection
- Ready for testing

---

### Step 3: Update Workflow to Set Environment Variables

**Priority:** 🔴 Critical  
**Effort:** 🟢 Low  
**Timeline:** 15 minutes

**Tasks:**

- [ ] Add `CI: true` to test job environments
- [ ] Add `NON_INTERACTIVE: true` for explicit control
- [ ] Apply to both quick-checks and full-tests jobs

**Implementation:**

```yaml
- name: Run unit tests
  run: bats --recursive tests/unit/ || exit 1
  env:
    CI: true
    NON_INTERACTIVE: true

- name: Run all tests
  run: bats --recursive tests/ || exit 1
  env:
    CI: true
    NON_INTERACTIVE: true
```

**Output:**

- Workflow explicitly sets environment variables
- Detection logic will work reliably

---

### Step 4: Test Locally Before Pushing

**Priority:** 🔴 Critical  
**Effort:** 🟢 Low  
**Timeline:** 15 minutes

**Tasks:**

- [ ] Test with `CI=true`:
  ```bash
  CI=true bats tests/unit/git-operations.bats
  ```

- [ ] Test with `GITHUB_ACTIONS=true`:
  ```bash
  GITHUB_ACTIONS=true bats tests/unit/git-operations.bats
  ```

- [ ] Test with `NON_INTERACTIVE=true`:
  ```bash
  NON_INTERACTIVE=true bats tests/unit/git-operations.bats
  ```

- [ ] Test full suite:
  ```bash
  CI=true bats --recursive tests/
  ```

- [ ] Verify all tests pass before committing

**Verification Checklist:**

- [ ] Git operations tests pass with `CI=true`
- [ ] Git operations tests pass with `GITHUB_ACTIONS=true`
- [ ] Git operations tests pass with `NON_INTERACTIVE=true`
- [ ] All 64 tests pass with `CI=true`
- [ ] No regressions in other tests

**Output:**

- Confirmed fix works locally
- Ready to push with confidence

---

### Step 5: Commit and Push Fixes

**Priority:** 🔴 Critical  
**Effort:** 🟢 Low  
**Timeline:** 10 minutes

**Tasks:**

- [ ] Commit script changes
- [ ] Commit workflow changes
- [ ] Push to `ci/multi-environment-testing` branch
- [ ] Monitor workflow run

**Commit Messages:**

```
fix: improve prompt_yes_no non-interactive detection for GitHub Actions

- Add GITHUB_ACTIONS environment variable check
- Add NON_INTERACTIVE explicit flag support
- Set CI and NON_INTERACTIVE in workflow for reliable detection
- Test locally with CI=true before pushing

Fixes git operations tests failing in CI:
- git_operations: initializes git repository successfully
- git_operations: creates initial commit
```

**Output:**

- Changes pushed to branch
- Workflow triggered
- Ready for validation

---

### Step 6: Verify Fix in CI

**Priority:** 🔴 Critical  
**Effort:** 🟢 Low  
**Timeline:** Wait for workflow (5-10 minutes)

**Tasks:**

- [ ] Monitor workflow run
- [ ] Verify all tests pass
- [ ] Check that git operations tests pass
- [ ] Verify no regressions

**Success Criteria:**

- [ ] All 64 tests pass
- [ ] Git operations tests pass on Ubuntu
- [ ] Git operations tests pass on macOS
- [ ] No new failures introduced
- [ ] Workflow completes successfully

**Output:**

- Confirmed fix works in CI
- Ready to merge PR

---

## 🧪 Testing Strategy

### Local Testing

**Before Pushing:**

1. **Test with CI environment:**
   ```bash
   CI=true bats tests/unit/git-operations.bats
   ```

2. **Test with GitHub Actions environment:**
   ```bash
   GITHUB_ACTIONS=true bats tests/unit/git-operations.bats
   ```

3. **Test with explicit flag:**
   ```bash
   NON_INTERACTIVE=true bats tests/unit/git-operations.bats
   ```

4. **Test full suite:**
   ```bash
   CI=true bats --recursive tests/
   ```

5. **Verify no regressions:**
   ```bash
   bats --recursive tests/
   ```

### CI Testing

**After Pushing:**

- Monitor workflow runs
- Verify all jobs pass
- Check test output for any issues
- Confirm environment variables are set correctly

---

## 📅 Timeline

### Phase 1: Investigation and Fix (1 hour)

- **0-30 min:** Investigate GitHub Actions environment
- **30-60 min:** Update function and workflow
- **60-75 min:** Test locally
- **75-90 min:** Commit and push

### Phase 2: Validation (10-15 minutes)

- **Wait for workflow:** 5-10 minutes
- **Verify results:** 5 minutes
- **Document success/failure:** 5 minutes

---

## ✅ Success Criteria

- [ ] GitHub Actions environment investigated and documented
- [ ] `prompt_yes_no` function updated with better detection
- [ ] Workflow updated with environment variables
- [ ] All tests pass locally with `CI=true`
- [ ] Changes committed and pushed
- [ ] All tests pass in CI (64/64)
- [ ] Git operations tests pass on both Ubuntu and macOS
- [ ] No regressions introduced
- [ ] Process documented for future fixes

---

## 🔄 Update Process

1. As fixes are implemented, update this document
2. Mark tasks as complete
3. Update timeline if needed
4. Document any new issues discovered
5. Update related documentation

---

## 📚 Related Documentation

- **[Failed Jobs](pr17-failures.md)** - Detailed failure information
- **[Root Cause Analysis](root-cause-analysis.md)** - Why failures occurred
- **[Prompt Interactive Analysis](prompt-interactive-analysis.md)** - Deep dive into detection issue
- **[Fixes Needed](fixes-needed.md)** - Prioritized fix list

---

**Status:** 🟠 In Progress  
**Next:** Investigate GitHub Actions environment, then implement fix with local testing

