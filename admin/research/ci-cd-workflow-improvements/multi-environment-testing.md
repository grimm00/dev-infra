# Multi-Environment Testing Strategy

**Purpose:** Define testing strategy for running BATS tests across multiple operating systems  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This document defines the multi-environment testing strategy for dev-infra, including:

- Required operating systems
- BATS compatibility across platforms
- GitHub Actions matrix strategy
- Test secrets/variables needed
- Integration with release workflow

---

## 📋 Current Test Suite

### Test Statistics

- **Total Tests:** 64 (63 passing, 1 skipped)
- **Test Types:**
  - Unit Tests: 49 tests (7 files)
  - Integration Tests: 11 tests (3 files)
  - Regression Tests: 5 tests (2 files)
  - Smoke Tests: 1 test (1 file, skipped)

### Platform-Specific Behavior

**Current Tests with OS-Specific Logic:**

1. **`file-customization.bats`** - Tests `sed -i` behavior

   - macOS/BSD: Uses `sed -i ''` (empty string required)
   - GNU/Linux: Uses `sed -i` (no extension)
   - Tests skip based on `$OSTYPE` detection

2. **`git-operations.bats`** - Tests git functionality

   - Some tests skip if git not available
   - No OS-specific logic, but git behavior may differ

3. **`smoke.bats`** - End-to-end tests
   - Currently skipped (needs refinement)
   - May have OS-specific behavior when implemented

### Test Dependencies

**External Dependencies (Mocked):**

- `gh` CLI - Mocked in tests via `mock_gh()` helper
- `git` - Available in all environments, some tests skip if missing

**No Real Authentication Required:**

- Tests use mocks for GitHub CLI
- No real API calls
- No secrets needed for test execution

---

## 🔍 Operating System Requirements

### Option 1: Ubuntu + macOS (Recommended)

**Rationale:**

- Covers primary development platforms
- Tests cross-platform `sed -i` behavior
- Represents majority of users
- Lower CI/CD cost and complexity

**Coverage:**

- ✅ Linux (Ubuntu) - Primary server/CI environment
- ✅ macOS - Primary development environment
- ❌ Windows - Not required (low user base, higher complexity)

**GitHub Actions Runners:**

- `ubuntu-latest` - Linux testing
- `macos-latest` - macOS testing

### Option 2: Ubuntu + macOS + Windows

**Rationale:**

- Complete cross-platform coverage
- Tests Windows-specific behavior
- Higher CI/CD cost and complexity

**Coverage:**

- ✅ Linux (Ubuntu)
- ✅ macOS
- ✅ Windows

**GitHub Actions Runners:**

- `ubuntu-latest` - Linux testing
- `macos-latest` - macOS testing
- `windows-latest` - Windows testing

**Considerations:**

- BATS may require WSL or Git Bash on Windows
- Higher maintenance burden
- May not be necessary for dev-infra use case

### Option 3: Research First

**Rationale:**

- Evaluate actual Windows usage
- Assess BATS compatibility on Windows
- Make informed decision

**Action:**

- Research Windows BATS compatibility
- Survey user base for Windows usage
- Evaluate cost/benefit

---

## 🎯 Recommendation: Ubuntu + macOS

### Justification

1. **User Base:** Majority of dev-infra users are on Linux/macOS
2. **Cost:** Two runners are more cost-effective than three
3. **Complexity:** Windows adds significant complexity (WSL, Git Bash, path handling)
4. **Coverage:** Ubuntu + macOS covers critical cross-platform differences (`sed -i`)
5. **Maintenance:** Lower maintenance burden with two platforms

### Windows Support (Future)

- **Option:** Add Windows testing if user demand increases
- **Approach:** Use WSL or Git Bash for BATS execution
- **Priority:** Low - defer until needed
- **Action:** Research Windows support as a later task (evaluate user demand, BATS compatibility, cost/benefit)

---

## 🏗️ GitHub Actions Matrix Strategy

### Workflow Structure

```yaml
name: Run Tests

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/checkout@v4

      - name: Install BATS
        run: |
          if [ "${{ runner.os }}" == "Linux" ]; then
            # Install BATS on Ubuntu
            sudo apt-get update
            sudo apt-get install -y bats
          elif [ "${{ runner.os }}" == "macOS" ]; then
            # Install BATS on macOS
            brew install bats-core
          fi

      - name: Run tests
        run: |
          bats --recursive tests/
```

### Matrix Benefits

- ✅ Runs tests on both platforms in parallel
- ✅ Fails fast if any platform fails
- ✅ Clear visibility into platform-specific issues
- ✅ Standard GitHub Actions pattern

---

## 🔧 BATS Compatibility

### Ubuntu (Linux)

**Status:** ✅ Fully Compatible

- BATS available via `apt-get install bats`
- All tests should pass
- Standard Linux environment

**Test Execution:**

```bash
sudo apt-get update
sudo apt-get install -y bats
bats --recursive tests/
```

### macOS

**Status:** ✅ Fully Compatible

- BATS available via `brew install bats-core`
- All tests should pass
- Standard macOS environment

**Test Execution:**

```bash
brew install bats-core
bats --recursive tests/
```

### Windows

**Status:** ⚠️ Requires WSL or Git Bash

- BATS not natively available on Windows
- Requires WSL (Windows Subsystem for Linux) or Git Bash
- Higher complexity, may not be necessary

**Test Execution (WSL):**

```bash
# In WSL
sudo apt-get update
sudo apt-get install -y bats
bats --recursive tests/
```

**Test Execution (Git Bash):**

- May require BATS installation in Git Bash environment
- Path handling differences
- Not recommended for CI/CD

---

## 🔐 Test Secrets and Variables

### Current Requirements

**No Secrets Needed:**

- ✅ Tests use mocks for GitHub CLI (`mock_gh()` helper)
- ✅ Tests use mocks for git operations
- ✅ No real API calls
- ✅ No authentication required

### Future Requirements (If Adding Real Tests)

**Potential Secrets (Not Currently Needed):**

- `GITHUB_TOKEN` - For real GitHub API tests (if added)
- `TEST_GITHUB_USERNAME` - For real authentication tests (if added)

**Recommendation:**

- **Current:** No secrets needed
- **Future:** Add secrets only if real API tests are implemented
- **Documentation:** Document that mocks are used, no secrets required

---

## 🚀 Integration with Release Workflow

### Test Requirements for Release

**Option 1: Tests Block Release (Recommended)**

**Approach:**

- Run tests on all PRs
- Require all tests to pass before release
- Block release distribution if tests fail

**Implementation:**

```yaml
# In release-distribution.yml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/checkout@v4
      - name: Install BATS
        # ... install steps ...
      - name: Run tests
        run: bats --recursive tests/

  create-distribution:
    needs: test # Block until tests pass
    runs-on: ubuntu-latest
    # ... distribution steps ...
```

**Benefits:**

- ✅ Ensures quality before release
- ✅ Prevents broken releases
- ✅ Standard practice

**Option 2: Tests Inform Release (Not Recommended)**

**Approach:**

- Run tests but don't block release
- Tests are informational only

**Drawbacks:**

- ❌ Allows broken releases
- ❌ Not recommended

### Recommended Approach

**Tests Should Block Release:**

1. Run tests on all PRs (already in place via matrix)
2. Require tests to pass before merge
3. Run tests again before release (safety check)
4. Block release if tests fail

---

## 📊 Test Execution Strategy

### Pre-Merge Testing

**Current State:**

- Tests run manually or locally
- No automated CI/CD testing

**Recommended:**

- Add GitHub Actions workflow for PR testing
- Run tests on all PRs
- Require passing tests before merge

### Pre-Release Testing

**Current State:**

- No automated pre-release testing

**Recommended:**

- Run tests as part of release workflow
- Block release if tests fail
- Ensure quality before distribution

### Test Matrix Execution

**Parallel Execution:**

- Run Ubuntu and macOS tests in parallel
- Fail fast if any platform fails
- Clear visibility into platform issues

**Sequential Execution (Not Recommended):**

- Slower overall execution
- Less efficient

---

## 📝 Implementation Plan

### Phase 1: Add GitHub Actions Test Workflow

**File:** `.github/workflows/test.yml`

**Features:**

- Matrix strategy for Ubuntu + macOS
- BATS installation
- Test execution
- Results reporting

**Effort:** 🟢 Low (1-2 hours)

### Phase 2: Integrate with Release Workflow

**File:** `.github/workflows/release-distribution.yml`

**Changes:**

- Add test job
- Make distribution depend on test job
- Block release if tests fail

**Effort:** 🟢 Low (1 hour)

### Phase 3: Document Test Requirements

**Files:**

- `CONTRIBUTING.md` - Test requirements
- `tests/README.md` - CI/CD testing info

**Effort:** 🟢 Low (30 minutes)

---

## 🎯 Summary

### Operating Systems

- **Recommended:** Ubuntu + macOS
- **Rationale:** Covers primary platforms, lower cost/complexity
- **Windows:** Defer until needed

### Test Execution

- **Matrix Strategy:** Ubuntu + macOS in parallel
- **Blocking:** Tests should block release
- **Secrets:** None required (mocks used)

### Implementation

- **Priority:** High - Add CI/CD testing
- **Effort:** Low - Standard GitHub Actions setup
- **Timeline:** Can be implemented immediately

### Next Steps

1. Create `.github/workflows/test.yml` with matrix strategy
2. Integrate tests into release workflow
3. Document test requirements
4. Monitor test execution and adjust as needed

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Research Complete
