# Prompt Interactive Detection Analysis

**Purpose:** Deep dive into why `prompt_yes_no` non-interactive detection failed in GitHub Actions  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-11-17  
**PR:** #17

---

## 📋 Overview

This document analyzes why the non-interactive detection logic in `prompt_yes_no` didn't work in GitHub Actions CI, despite working locally.

---

## 🔍 Current Implementation

**Function:** `prompt_yes_no` in `scripts/new-project.sh`

**Current Detection Logic:**

```bash
# Check if we're in a non-interactive environment (CI, automated tests, etc.)
if [ ! -t 0 ] || [ -n "$CI" ] || [ -n "$BATS_RUN_TMPDIR" ]; then
    # Non-interactive: return default value
    case "${default:-n}" in
        [Yy]* ) return 0;;
        * ) return 1;;
    esac
fi
```

**Expected Behavior:**

- Detect non-interactive environments
- Return default value without prompting
- Work in CI, BATS tests, and automated environments

**Actual Behavior:**

- Detection fails in GitHub Actions
- Function still tries to read from stdin
- Tests fail with non-zero exit code

---

## 🔬 Investigation

### 1. Terminal Detection: `[ ! -t 0 ]`

**What it checks:** Whether file descriptor 0 (stdin) is a terminal

**Expected in CI:** Should return true (not a terminal)

**Reality:** May return false (is a terminal) in GitHub Actions

**Possible Reasons:**

- GitHub Actions may connect stdin to a pseudo-terminal
- The `-t` test may not work as expected in containerized environments
- Different behavior between Ubuntu and macOS runners

**Test Needed:**

```bash
# In GitHub Actions workflow
- name: Test terminal detection
  run: |
    if [ ! -t 0 ]; then
      echo "Not a terminal"
    else
      echo "Is a terminal"
    fi
```

---

### 2. CI Environment Variable: `$CI`

**What it checks:** Whether `$CI` environment variable is set

**Expected in CI:** Should be set to a truthy value

**Reality:** May not be set in GitHub Actions

**GitHub Actions Environment:**

- GitHub Actions doesn't automatically set `$CI`
- Some CI systems set it (Travis CI, CircleCI)
- GitHub Actions uses `$GITHUB_ACTIONS` instead

**Test Needed:**

```bash
# In GitHub Actions workflow
- name: Check CI variables
  run: |
    echo "CI=$CI"
    echo "GITHUB_ACTIONS=$GITHUB_ACTIONS"
    env | grep -i ci
```

**Recommendation:**

Use `$GITHUB_ACTIONS` instead of or in addition to `$CI`:

```bash
if [ -n "$GITHUB_ACTIONS" ] || [ -n "$CI" ]; then
    # CI environment detected
fi
```

---

### 3. BATS Environment Variable: `$BATS_RUN_TMPDIR`

**What it checks:** Whether BATS test environment is detected

**Expected in Tests:** Should be set by BATS

**Reality:** May not be available when functions are sourced

**How BATS Works:**

1. BATS sets `$BATS_RUN_TMPDIR` for each test
2. Tests load helpers which source the script
3. Functions are defined in the test environment
4. Functions should have access to `$BATS_RUN_TMPDIR`

**Possible Issues:**

- Variable may not be exported
- Variable may be in different scope
- Variable may not be set when function is called

**Test Needed:**

```bash
# In test file
@test "test BATS variables" {
    echo "BATS_RUN_TMPDIR=$BATS_RUN_TMPDIR"
    run bash -c 'echo "BATS_RUN_TMPDIR=$BATS_RUN_TMPDIR"'
    [ -n "$BATS_RUN_TMPDIR" ]
}
```

---

### 4. Detection Logic: OR Conditions

**Current Logic:**

```bash
if [ ! -t 0 ] || [ -n "$CI" ] || [ -n "$BATS_RUN_TMPDIR" ]; then
```

**How OR Works:**

- Returns true if ANY condition is true
- If ALL conditions are false, proceeds to interactive mode

**Problem:**

If all three conditions evaluate to false:
- `[ ! -t 0 ]` → false (stdin IS a terminal)
- `[ -n "$CI" ]` → false (CI not set)
- `[ -n "$BATS_RUN_TMPDIR" ]` → false (not available)

Then the function proceeds to interactive mode and fails.

---

## 💡 Recommended Solutions

### Solution 1: Use GitHub Actions Specific Variable

**Approach:** Check for `$GITHUB_ACTIONS` explicitly

```bash
if [ -n "$GITHUB_ACTIONS" ] || [ -n "$CI" ] || [ ! -t 0 ] || [ -n "$BATS_RUN_TMPDIR" ]; then
    # Non-interactive: return default value
    case "${default:-n}" in
        [Yy]* ) return 0;;
        * ) return 1;;
    esac
fi
```

**Pros:**

- Explicitly handles GitHub Actions
- More reliable detection
- Clear intent

**Cons:**

- GitHub Actions specific (but that's our CI)

---

### Solution 2: Set Environment Variable in Workflow

**Approach:** Explicitly set `$CI` or custom variable in workflow

```yaml
- name: Run unit tests
  run: bats --recursive tests/unit/ || exit 1
  env:
    CI: true
    NON_INTERACTIVE: true
```

**Pros:**

- Explicit control
- Works for all detection methods
- Easy to test locally

**Cons:**

- Requires workflow changes
- Need to set in all test jobs

---

### Solution 3: Check for BATS More Reliably

**Approach:** Check for BATS in a different way

```bash
# Check if running under BATS
if [ -n "$BATS_VERSION" ] || [ -n "$BATS_RUN_TMPDIR" ] || command -v bats >/dev/null 2>&1 && [ -n "$TEST_TMPDIR" ]; then
    # BATS environment
fi
```

**Pros:**

- More reliable BATS detection
- Multiple fallback methods

**Cons:**

- More complex logic
- May still have scope issues

---

### Solution 4: Explicit Non-Interactive Mode

**Approach:** Add explicit flag or environment variable

```bash
# In script
NON_INTERACTIVE="${NON_INTERACTIVE:-false}"

prompt_yes_no() {
    if [ "$NON_INTERACTIVE" = "true" ] || [ -n "$GITHUB_ACTIONS" ] || [ -n "$CI" ] || [ ! -t 0 ] || [ -n "$BATS_RUN_TMPDIR" ]; then
        # Non-interactive mode
    fi
}
```

**Pros:**

- Most explicit
- Easy to test
- Clear intent

**Cons:**

- Requires environment variable setup
- More configuration needed

---

## 🎯 Recommended Approach

**Combination of Solutions 1 and 2:**

1. **Update detection logic** to check `$GITHUB_ACTIONS`
2. **Set environment variable** in workflow for explicit control
3. **Test locally** with `CI=true` before pushing

**Implementation:**

```bash
# In prompt_yes_no function
if [ -n "$GITHUB_ACTIONS" ] || [ -n "$CI" ] || [ -n "$NON_INTERACTIVE" ] || [ ! -t 0 ] || [ -n "$BATS_RUN_TMPDIR" ]; then
    # Non-interactive: return default value
    case "${default:-n}" in
        [Yy]* ) return 0;;
        * ) return 1;;
    esac
fi
```

```yaml
# In workflow
- name: Run unit tests
  run: bats --recursive tests/unit/ || exit 1
  env:
    CI: true
    NON_INTERACTIVE: true
```

---

## 🧪 Testing Strategy

1. **Test locally with CI=true:**
   ```bash
   CI=true bats tests/unit/git-operations.bats
   ```

2. **Test with GITHUB_ACTIONS:**
   ```bash
   GITHUB_ACTIONS=true bats tests/unit/git-operations.bats
   ```

3. **Test in workflow:**
   - Add debug output to see which condition triggers
   - Verify environment variables are set
   - Confirm detection works

---

## 📊 Comparison

| Solution              | Reliability | Complexity | Testing Ease | Recommendation |
| --------------------- | ----------- | ---------- | ------------ | -------------- |
| GitHub Actions Var    | 🟢 High     | 🟢 Low     | 🟢 Easy      | ✅ Recommended |
| Workflow Env Var       | 🟢 High     | 🟡 Medium  | 🟢 Easy      | ✅ Recommended |
| BATS Detection        | 🟡 Medium   | 🟠 High    | 🟡 Medium    | ⚠️ Fallback    |
| Explicit Flag         | 🟢 High     | 🟡 Medium  | 🟢 Easy      | ✅ Good        |

---

**Status:** 🟠 In Progress  
**Next:** Implement recommended solution and test locally before pushing

