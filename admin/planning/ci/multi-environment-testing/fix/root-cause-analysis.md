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

**Possible Reasons:**

1. **Different Shell Behavior:** Ubuntu uses bash differently than macOS
2. **Environment Variable Differences:** Different variables set in each environment
3. **Terminal Detection:** `[ ! -t 0 ]` may behave differently on each platform
4. **BATS Execution:** BATS may run differently on each platform

**Impact:** 🟠 High - Inconsistent test results across platforms

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

## 🎯 Next Steps

1. Investigate GitHub Actions environment variables
2. Test different non-interactive detection methods
3. Verify fix locally before pushing
4. Consider alternative approaches (explicit environment variable, mock stdin)

---

**Status:** 🟠 In Progress  
**Next:** See [Prompt Interactive Analysis](prompt-interactive-analysis.md) for deep dive into the detection issue
