# Multi-Environment Testing Workflow - Specification

**Last Updated:** 2025-01-27

---

## 🎯 Overview

Complete GitHub Actions workflow specification for automated multi-environment testing with Ubuntu and macOS matrix strategy, including optimizations for cost savings and developer experience.

---

## 📋 Workflow File

**Location:** `.github/workflows/test.yml`

**Complete Workflow:**

```yaml
name: Run Tests

on:
  push:
    branches: [main, develop]
    paths-ignore:
      - "**/*.md"
      - "docs/**"
      - "admin/**"
  pull_request:
    branches: [main, develop]
    types: [opened, synchronize, reopened, ready_for_review]

concurrency:
  group: ${{ github.workflow }}-${{ github.event.pull_request.head.ref || github.ref }}
  cancel-in-progress: true

jobs:
  quick-checks:
    if: ${{ github.event.pull_request.draft == false || github.event_name == 'push' }}
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Install BATS
        run: |
          sudo apt-get update
          sudo apt-get install -y bats

      - name: Run unit tests
        run: bats --recursive tests/unit/

  full-tests:
    if: ${{ github.event.pull_request.draft == false || github.event_name == 'push' }}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest]
    runs-on: ${{ matrix.os }}
    timeout-minutes: 30
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Install BATS
        run: |
          if [ "${{ runner.os }}" == "Linux" ]; then
            sudo apt-get update
            sudo apt-get install -y bats
          elif [ "${{ runner.os }}" == "macOS" ]; then
            brew install bats-core
          fi

      - name: Run all tests
        run: bats --recursive tests/
```

---

## 🔍 Workflow Explanation

### Triggers

**Push Events:**

- Triggers on push to `main` or `develop` branches
- Path filtering skips docs/admin/markdown changes
- Aligns with Git Flow (docs can merge directly)

**Pull Request Events:**

- Triggers on PR opened, synchronized, reopened, or ready for review
- No path filtering (want full validation for PRs)
- Ensures all PRs are tested

### Concurrency Control

**Purpose:** Prevent duplicate workflow runs

**Configuration:**

- Groups by workflow name and branch/PR ref
- Cancels in-progress runs when new commit pushed
- Saves ~50% CI minutes

**Example:**

- Developer pushes commit → workflow starts
- Developer pushes another commit → first workflow cancelled, second runs
- Only latest run matters

### Quick Checks Job

**Purpose:** Fast feedback for developers

**Configuration:**

- Runs on Ubuntu only (faster, cheaper)
- Unit tests only (fast execution)
- 10 minute timeout
- Skips for draft PRs

**Execution Time:** ~2-3 minutes

**When It Runs:**

- On push to main/develop (if not docs-only)
- On PR (if not draft)

### Full Tests Job

**Purpose:** Comprehensive validation across platforms

**Configuration:**

- Matrix strategy: Ubuntu + macOS
- All tests (unit, integration, regression)
- 30 minute timeout
- Skips for draft PRs

**Execution Time:**

- Ubuntu: ~5-10 seconds (with Docker image, down from ~20-23 seconds)
- macOS: ~7-10 minutes (unchanged, no Docker support)
- Total: ~7-10 minutes (parallel execution, Ubuntu much faster)

**When It Runs:**

- On push to main/develop (if not docs-only)
- On PR (if not draft)

### Path Filtering

**Purpose:** Skip CI for documentation-only changes

**Paths Ignored:**

- `**/*.md` - All markdown files
- `docs/**` - Documentation directory
- `admin/**` - Admin directory (while it exists)

**Rationale:**

- Aligns with Git Flow (docs can merge directly)
- Saves CI minutes (~20% reduction)
- Faster feedback for code changes

**Note:** Only applies to push events, not PR events (want full validation for PRs)

### Draft PR Filtering

**Purpose:** Skip full validation for work-in-progress PRs

**Configuration:**

```yaml
if: ${{ github.event.pull_request.draft == false || github.event_name == 'push' }}
```

**Behavior:**

- Draft PRs: Skip both quick-checks and full-tests
- Ready PRs: Run both jobs
- Push events: Always run (not PRs)

**Rationale:**

- Saves CI minutes (~30% reduction)
- Better developer experience
- Full validation only when PR is ready

### Timeout Limits

**Purpose:** Prevent hung workflows

**Configuration:**

- Quick checks: 10 minutes
- Full tests: 30 minutes

**Rationale:**

- Prevents hung workflows
- Fails fast on issues
- Predictable CI times
- Cost control

### BATS Installation

**Ubuntu (Docker Container):**

- Uses pre-built Docker image from GHCR: `ghcr.io/${{ github.repository }}/test-image:latest`
- Image contains BATS, git, bash, and other required tools
- No installation step needed - saves ~15 seconds per run
- Image is tagged after successful test runs for reproducibility

**macOS (Native Installation):**

```bash
brew install bats-core
```

**Image Tagging Strategy:**

- `latest`: Current image (updated after successful test runs)
- `stable`: Last verified working image (updated after successful test runs)
- `verified-{sha}`: Specific commit's verified image
- `{branch}-{sha}`: Branch-specific commit image

**Benefits:**

- Consistent tool versions across all Ubuntu test runs
- Faster execution (no installation time)
- Reproducible test environments
- Known-good versions available via tags

### Test Execution

**Quick Checks:**

```bash
bats --recursive tests/unit/
```

- Runs unit tests only
- Fast feedback
- ~49 tests

**Full Tests:**

```bash
bats --recursive tests/
```

- Runs all tests (unit, integration, regression)
- Comprehensive validation
- ~64 tests (63 passing, 1 skipped)

---

## 🔗 Integration with Release Workflow

### Release Workflow Dependency

**File:** `.github/workflows/release-distribution.yml`

**Update Required:**

```yaml
jobs:
  quick-checks:
    # ... quick-checks job ...

  full-tests:
    # ... full-tests job ...

  create-distribution:
    needs: [quick-checks, full-tests]
    runs-on: ubuntu-latest
    # ... distribution steps ...
```

**Behavior:**

- Release workflow waits for tests to complete
- If tests fail, release workflow is blocked
- Ensures quality before distribution

---

## 📊 Expected Execution

### Typical PR Flow

1. **Developer creates PR**

   - If draft: No tests run
   - If ready: Both jobs run

2. **Quick Checks (Ubuntu)**

   - ~6-10 seconds (with Docker image, down from ~20-23 seconds)
   - Unit tests only
   - Fast feedback
   - Uses Docker container with pre-installed tools

3. **Full Tests (Ubuntu + macOS)**

   - ~10-15 minutes (parallel)
   - All tests
   - Comprehensive validation

4. **Results**
   - All tests pass → PR ready to merge
   - Tests fail → Developer fixes and pushes

### Typical Push Flow

1. **Developer pushes to develop**

   - If docs-only: Workflow skipped (path filtering)
   - If code change: Both jobs run

2. **Quick Checks + Full Tests**
   - Same as PR flow
   - Validates code changes

### Release Flow

1. **Release published**

   - Release workflow triggered
   - Waits for test workflow to complete

2. **Tests must pass**
   - If tests fail: Release blocked
   - If tests pass: Distribution created

---

## 🔧 Configuration Details

### Workflow Permissions

**Default Permissions:**

- `contents: read` - Checkout code
- No write permissions needed (tests are read-only)

**No Secrets Required:**

- Tests use mocks for external dependencies
- No real API calls
- No authentication needed

### Runner Requirements

**Ubuntu:**

- Standard GitHub Actions runner
- BATS available via apt-get
- No additional setup needed

**macOS:**

- Standard GitHub Actions runner
- BATS available via Homebrew
- No additional setup needed

### Test Dependencies

**External Dependencies (Mocked):**

- `gh` CLI - Mocked via `mock_gh()` helper
- `git` - Available on all runners

**No Real Dependencies:**

- Tests are self-contained
- No external services required
- No network access needed (except for checkout)

---

## 🐛 Troubleshooting

### Tests Fail on One Platform

**Issue:** Tests pass on Ubuntu but fail on macOS (or vice versa)

**Solution:**

- Check platform-specific behavior (e.g., `sed -i`)
- Review test output for OS-specific errors
- Verify test logic handles both platforms

### Workflow Not Triggering

**Issue:** Workflow doesn't run on push/PR

**Possible Causes:**

- Path filtering excluded all changed files
- Draft PR (filtered out)
- Workflow file not in `.github/workflows/`

**Solution:**

- Check path filtering configuration
- Verify PR is not draft
- Verify workflow file location

### BATS Installation Fails

**Issue:** BATS installation step fails

**Possible Causes:**

- Package manager issue
- Network connectivity
- Runner environment issue

**Solution:**

- Check runner OS detection
- Verify package manager availability
- Check GitHub Actions status

### Timeout Issues

**Issue:** Workflow times out

**Possible Causes:**

- Tests taking longer than expected
- Hung test execution
- Runner performance issues

**Solution:**

- Increase timeout if needed
- Investigate slow tests
- Check for hung processes

---

## 📈 Monitoring and Optimization

### Metrics to Track

- Test execution time (per platform)
- Test pass/fail rate
- CI minute usage
- Cost savings from optimizations

### Optimization Opportunities

- Test result caching (if beneficial)
- Parallel test execution within jobs (if needed)
- Further path filtering refinement
- Additional timeout tuning

---

## 📝 Summary

### Workflow Features

- ✅ Multi-platform testing (Ubuntu + macOS)
- ✅ Two-stage testing (quick + full)
- ✅ Concurrency control (cost savings)
- ✅ Path filtering (efficiency)
- ✅ Draft PR filtering (better UX)
- ✅ Timeout limits (reliability)
- ✅ Release integration (quality gate)

### Expected Results

- **Execution Time:** ~10-15 minutes (parallel)
- **Cost Savings:** ~50% reduction in CI minutes
- **Quality Assurance:** Automated testing on every PR
- **Developer Experience:** Fast feedback, less noise

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Specification Complete - Ready for Implementation
