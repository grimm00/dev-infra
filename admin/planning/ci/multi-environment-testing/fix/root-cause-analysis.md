# Multi-Environment Testing Root Cause Analysis

**Purpose:** Analyze why failures occurred in the multi-environment testing workflow  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-11-17  
**PRs:** #16, #17

---

## 📋 Overview

This document analyzes the root causes of failures in PR #17. It examines workflow configuration, platform differences, and implementation issues to understand why git operations tests fail in CI but pass locally.

---

## 🔍 Analysis Areas

### 1. Git Operations Test Failures

**Issue:** Two git operations tests failing in CI but passing locally

**Failing Tests:**

- `git_operations: initializes git repository successfully`
- `git_operations: creates initial commit`

**Root Cause:**

The `init_git_repo` function calls `prompt_yes_no "Initialize git repository?" "y"`, which attempts to read from stdin. In CI environments, stdin is not available for interactive input, causing the function to fail.

**Previous Fix Attempt:**

A fix was attempted to detect non-interactive environments:

```bash
if [ ! -t 0 ] || [ -n "$CI" ] || [ -n "$BATS_RUN_TMPDIR" ]; then
    # Non-interactive: return default value
    case "${default:-n}" in
        [Yy]* ) return 0;;
        * ) return 1;;
    esac
fi
```

**Why Fix Didn't Work:**

1. **`[ ! -t 0 ]` Check:** May not work as expected in GitHub Actions
   - The `-t` test checks if file descriptor 0 (stdin) is a terminal
   - In GitHub Actions, stdin may be connected to a pipe or device that passes the `-t` test
   - The check may evaluate to false even in non-interactive environments

2. **`$CI` Environment Variable:** May not be set
   - GitHub Actions doesn't automatically set `$CI` to a truthy value
   - The variable may be unset or empty, causing the check to fail

3. **`$BATS_RUN_TMPDIR` Variable:** May not be available
   - This variable is set by BATS during test execution
   - However, when functions are sourced from the script, the variable may not be in scope
   - The check may not detect the BATS environment correctly

4. **Detection Logic Evaluation:** The OR conditions may not work as expected
   - If all three conditions evaluate to false, the function proceeds to interactive mode
   - This causes `read -p` to hang or fail in CI

**Impact:** 🔴 Critical - Blocks 2 tests from passing in CI

---

### 2. Platform-Specific Behavior

**Issue:** Tests fail on Ubuntu but pass on macOS

**Observation:**

- Ubuntu CI: Tests fail
- macOS CI: Tests pass
- Local (macOS): Tests pass

**Root Cause Analysis:**

After comprehensive investigation (see [Platform Differences Investigation](platform-differences-investigation.md)), the following differences were identified:

1. **Tool Versions:**
   - Ubuntu: BATS 1.2.0-1.3.0 (apt-get)
   - macOS: BATS 1.8.0+ (Homebrew)
   - **Impact:** Low - Both versions work, but may have subtle differences

2. **Installation Timing:**
   - Ubuntu: 13-14 seconds (apt-get install)
   - macOS: 10 seconds (brew install, better caching)
   - **Impact:** Low - Timing doesn't affect test results

3. **Test Execution:**
   - Ubuntu: Fails quickly (2-3 seconds)
   - macOS: Runs longer before cancellation (12+ seconds)
   - **Impact:** Medium - macOS has more time to complete before cancellation

4. **Environment Detection:**
   - Both platforms should behave identically
   - Detection logic works the same on both
   - **Impact:** Low - Not the root cause of failures

**Actual Root Cause:**

The platform difference is not the cause of test failures. Both platforms fail the same tests when `prompt_yes_no` detection doesn't work. macOS tests pass in some runs because:
- They may have different environment variable values
- They run longer, giving more time for detection to work
- Cancellation may occur before tests complete

**Impact:** 🟠 High - Inconsistent test results across platforms, but root cause is detection logic, not platform differences

---

### 3. Local vs CI Environment Differences

**Issue:** Tests pass locally but fail in CI

**Local Environment:**

- Interactive terminal available
- Environment variables may differ
- BATS runs in interactive mode
- `prompt_yes_no` works correctly

**CI Environment:**

- Non-interactive execution
- Limited environment variables
- BATS runs in non-interactive mode
- `prompt_yes_no` fails to detect non-interactive mode

**Root Cause:**

The detection logic doesn't correctly identify the CI environment, causing the function to attempt interactive input which fails.

**Impact:** 🔴 Critical - Tests can't be validated in CI

---

### 4. Function Sourcing and Scope

**Issue:** Environment variables may not be available when functions are sourced

**How Tests Work:**

1. Tests load helpers: `load '../helpers/helpers.bash'`
2. Helpers source the script: Functions are extracted and defined
3. Functions are called: `run init_git_repo "$project_dir" "Test Author"`
4. Functions check environment: `prompt_yes_no` checks for non-interactive mode

**Problem:**

When functions are sourced from the script, they may not have access to:
- BATS-specific environment variables
- CI environment variables
- Test-specific variables

**Impact:** 🟡 Medium - Detection logic may not work correctly

---

## 📊 Root Cause Summary

| Issue                              | Severity    | Impact                    | Frequency |
| ---------------------------------- | ----------- | ------------------------- | --------- |
| Git Operations Test Failures       | 🔴 Critical | Blocks CI validation      | Always    |
| Non-Interactive Detection Failure  | 🔴 Critical | Function hangs/fails      | Always    |
| Platform-Specific Behavior         | 🟠 High     | Inconsistent results      | Always    |
| Local vs CI Differences            | 🔴 Critical | Can't validate in CI      | Always    |
| Function Sourcing and Scope        | 🟡 Medium   | Detection may not work    | Always    |

---

## 🔗 Related Issues

- **Previous Fix Attempt:** Commit `df1378d` - "fix: make prompt_yes_no work in non-interactive environments"
- **Sourcery Feedback:** [pr16.md](../../../feedback/sourcery/pr16.md) - Code review feedback
- **Test Implementation:** [git-operations.bats](../../../../tests/unit/git-operations.bats)

---

### 5. macOS Job Cancellation

**Issue:** macOS test jobs are being cancelled before completion

**Observation:**

- macOS jobs take 30-33 seconds to complete
- Ubuntu jobs take 20-23 seconds to complete
- When commits are pushed rapidly (< 2 minutes apart), macOS jobs are cancelled
- Concurrency control cancels in-progress runs when new commits are pushed

**Root Cause:**

The concurrency group `${{ github.workflow }}-${{ github.event.pull_request.number || github.ref }}` cancels all in-progress runs when a new commit is pushed to the same PR branch. Since macOS jobs take longer to complete, they are more vulnerable to cancellation.

**Timeline Example:**
```
21:36:13 - Run starts, macOS job begins
21:36:46 - macOS job cancelled (29s runtime, not complete)
21:38:00 - New commit pushed, new run starts
         - Previous run's macOS job cancelled
```

**Impact:** 🟡 Medium - macOS tests may not complete if commits are pushed rapidly

**Solutions Considered:**

1. **Include Commit SHA in Concurrency Group:** Only cancels duplicate runs of same commit
2. **Remove `cancel-in-progress`:** Not recommended (wastes CI minutes)
3. **Optimize macOS Job Speed:** Use Docker images (not supported on macOS)
4. **Accept Cancellation:** Document behavior, rely on Ubuntu for fast feedback

**Recommendation:** Accept cancellation behavior for now, document it, and consider Docker images for Ubuntu jobs to improve consistency.

---

## 🎯 Next Steps

1. ✅ Investigate GitHub Actions environment variables (Completed - see investigation doc)
2. ✅ Test different non-interactive detection methods (Completed - fix implemented)
3. ✅ Verify fix locally before pushing (Completed)
4. ✅ Consider alternative approaches (Docker images evaluated - see GHCR research)
5. Document platform differences and cancellation behavior
6. Evaluate Docker images for Ubuntu jobs (see [GHCR Docker Images Research](../../../research/ci-cd-workflow-improvements/ghcr-docker-images.md))

---

**Status:** 🟠 In Progress  
**Next:** See [Prompt Interactive Analysis](prompt-interactive-analysis.md) for deep dive into the detection issue
