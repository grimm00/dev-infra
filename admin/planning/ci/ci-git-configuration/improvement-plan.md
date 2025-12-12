# CI Git Configuration - Improvement Plan

**Improvement:** Configure Git Identity in CI Workflows  
**Priority:** 🟡 MEDIUM  
**Effort:** 🟢 LOW (15 minutes)  
**Status:** 🔴 Not Started  
**Created:** 2025-12-12  
**Source:** [Release Automation v2 Reflection](../../notes/reflections/reflection-release-automation-v2-2025-12-12.md)

---

## 📋 Overview

Fix git initialization test failures in CI environments by either:

1. Configuring git user identity in workflows, or
2. Skipping tests that require git identity when running in CI

---

## 🎯 Success Criteria

- [ ] Git-related tests pass consistently in CI
- [ ] Release-distribution workflow succeeds
- [ ] Local tests still work correctly

---

## 💡 Implementation Options

### Option A: Configure Git in Workflows (Recommended)

**Add to workflow steps:**

```yaml
- name: Configure Git
  run: |
    git config --global user.name "github-actions[bot]"
    git config --global user.email "github-actions[bot]@users.noreply.github.com"
```

**Pros:**

- Tests run exactly as in local environment
- No test modifications needed

**Cons:**

- Must add to each workflow that needs it

---

### Option B: Skip Tests in CI

**Modify tests to skip in CI:**

```bash
@test "test that needs git identity" {
    if [[ -n "${CI:-}" ]]; then
        skip "Skipped in CI - requires git user configuration"
    fi
    # test body
}
```

**Pros:**

- No workflow changes needed
- Clear documentation of CI differences

**Cons:**

- Tests don't run in CI (less coverage)
- CI environment becomes "special"

---

## 📅 Implementation Steps

1. [ ] Identify which workflows need git configuration
2. [ ] Add git config step to workflows (Option A) OR
3. [ ] Add CI skip conditions to tests (Option B)
4. [ ] Test in CI environment
5. [ ] Update known issues if applicable

---

## 🧪 Testing

**Verification:**

1. Push to branch with workflow changes
2. Verify all tests pass
3. Verify release-distribution workflow succeeds

---

## ✅ Definition of Done

- [ ] Git tests pass in CI
- [ ] Release-distribution workflow succeeds
- [ ] Approach documented

---

## 🔗 Related

- **[Transition Plan](transition-plan.md)** - Structured transition approach
- **[Phase 1](phase-1.md)** - Implementation phase details
- **[Multi-Environment Testing Known Issues](../multi-environment-testing/known-issues.md)**
- **[Release Distribution Workflow](../../../.github/workflows/release-distribution.yml)**
- **[v1.5.0 Release Learnings](../../opportunities/internal/dev-infra/learnings/release-automation-v2/v1.5.0-release-learnings.md)**

---

**Last Updated:** 2025-12-12  
**Status:** 🔴 Not Started
