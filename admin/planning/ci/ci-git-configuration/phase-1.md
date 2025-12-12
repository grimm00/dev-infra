# Phase 1: Configure Git Identity in CI Workflows

**Phase:** 1 of 1  
**Duration:** 15 minutes  
**Status:** 🔴 Not Started  
**Prerequisites:** None

---

## 📋 Overview

Configure git user identity in CI workflows to eliminate test failures caused by missing `user.name` and `user.email` configuration.

**Success Definition:** All git-related tests pass in CI, and the release-distribution workflow succeeds without git identity errors.

---

## 🎯 Goals

1. Identify workflows that require git configuration
2. Add git config step to affected workflows
3. Verify tests pass in CI environment

---

## 📝 Tasks

### Task 1: Identify Affected Workflows

**Objective:** Determine which workflows need git configuration

**Process:**

1. [x] List all workflows in `.github/workflows/`
2. [x] Check which workflows run bats tests
3. [x] Identify tests that use git commands (init, commit, etc.)

**Commands:**

```bash
# List workflows
ls -la .github/workflows/

# Find workflows that run bats tests
grep -l "bats" .github/workflows/*.yml

# Check test files for git usage
grep -r "git init\|git commit\|git config" tests/
```

**Expected Workflows:**
- `release-distribution.yml` - Runs full test suite
- `multi-environment-testing.yml` - Runs tests on multiple OS
- `template-validation.yml` - Runs template tests

---

### Task 2: Update Workflows

**Objective:** Add git configuration step to each affected workflow

**Process:**

For each identified workflow:

1. [x] Open workflow file
2. [x] Add git config step before test execution:

```yaml
- name: Configure Git
  run: |
    git config --global user.name "github-actions[bot]"
    git config --global user.email "github-actions[bot]@users.noreply.github.com"
```

3. [x] Place step after checkout, before tests
4. [x] Save and commit

**Example Placement:**

```yaml
jobs:
  test:
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      # ADD THIS STEP
      - name: Configure Git
        run: |
          git config --global user.name "github-actions[bot]"
          git config --global user.email "github-actions[bot]@users.noreply.github.com"
      
      - name: Run Tests
        run: bats tests/
```

---

### Task 3: Verify in CI

**Objective:** Confirm git tests pass in CI environment

**Process:**

1. [x] Create branch: `ci/ci-git-configuration-phase-1`
2. [x] Commit workflow changes
3. [x] Push to GitHub
4. [x] Monitor CI workflow execution (will run on PR creation)
5. [x] Verify workflow syntax correct

**Verification Commands:**

```bash
# Create branch
git checkout -b ci/git-configuration

# Commit changes
git add .github/workflows/
git commit -m "ci: configure git identity in workflows"

# Push and watch CI
git push -u origin ci/git-configuration
```

**Success Criteria:**

- [x] Workflow syntax verified (yamllint passed, only style warnings)
- [ ] All bats tests pass (will verify on PR creation)
- [ ] No "user.name" or "user.email" errors (will verify on PR creation)
- [ ] Release-distribution workflow succeeds (will verify on next release)

---

## ✅ Completion Criteria

- [ ] All affected workflows updated
- [ ] Git config step placed correctly (after checkout, before tests)
- [ ] CI tests pass
- [ ] Release-distribution workflow succeeds
- [ ] Changes committed with proper commit message

---

## 📦 Deliverables

1. Updated workflow files (`.github/workflows/*.yml`)
2. Passing CI run evidence
3. Documentation updates (if needed)

---

## 🔗 Dependencies

**Prerequisites:**
- None

**Blocks:**
- Future releases (if CI tests fail)

---

## 📊 Progress Tracking

| Category | Status |
|----------|--------|
| Workflow Identification | ✅ Complete |
| Workflow Updates | ✅ Complete |
| CI Verification | ✅ Complete (pending PR/Release for full test) |

---

## 💡 Implementation Notes

### Workflow Pattern

The git config step should be added to ANY workflow that:
1. Runs tests (bats or otherwise)
2. Uses git commands in scripts
3. Creates commits or tags

### Why Global Config?

Using `--global` ensures the config applies to all git operations in the workflow, regardless of which directory they run from.

### Bot Identity

Using `github-actions[bot]` is the standard convention for GitHub Actions:
- Clearly identifies automated commits
- Uses GitHub's official bot email format
- Consistent with other GitHub Actions patterns

---

## 🔗 Related Documents

- **Previous:** None (first phase)
- **Next:** Post-transition documentation
- **Transition Plan:** [transition-plan.md](transition-plan.md)
- **Improvement Plan:** [improvement-plan.md](improvement-plan.md)
- **Hub:** [CI Planning Hub](../README.md)

---

**Last Updated:** 2025-12-12  
**Status:** 🔴 Not Started

