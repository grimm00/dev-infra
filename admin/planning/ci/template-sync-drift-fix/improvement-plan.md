# CI/CD Improvement Plan - Template Sync Drift Fix

**Improvement:** Fix Template Sync Drift  
**Priority:** 🔴 High  
**Effort:** Quick (~30 min)  
**Status:** 🔴 Not Started  
**Created:** 2025-12-30  
**Source:** reflection-transition-plan-two-mode-2025-12-29.md

---

## Overview

Address the template sync drift causing CI failures. The `status.md` file has drifted between `standard-project` and `learning-project` templates, causing the template sync validation to fail in CI.

**Problem:**
- CI failing due to template sync validation failure
- Drift in `status.md` file between templates
- Confusion during PR validation (failures unrelated to PR changes)

**Solution:**
- Identify which template has the correct version
- Sync the file between templates
- Verify CI passes

---

## Benefits

- Clean CI status
- No confusion during PR validation
- Clear distinction between PR-related and pre-existing failures

---

## Implementation Steps

### 1. Identify Drift Source

```bash
# Check template sync validation output
./scripts/validate-template-sync.sh

# Compare files between templates
diff templates/standard-project/.cursor/commands/status.md templates/learning-project/.cursor/commands/status.md
```

### 2. Determine Correct Version

- Review both versions
- Identify which is most current/correct
- If unclear, use standard-project as source of truth

### 3. Sync Files

```bash
# Copy from source to target (example - adjust based on analysis)
cp templates/standard-project/.cursor/commands/status.md templates/learning-project/.cursor/commands/status.md
```

### 4. Verify Fix

```bash
# Run template sync validation
./scripts/validate-template-sync.sh

# If passing, commit
git add templates/
git commit -m "fix(templates): sync status.md between templates

Resolves template sync drift causing CI failures."
```

### 5. Verify CI Passes

- Push changes
- Verify CI passes
- Confirm no other sync issues

---

## Definition of Done

- [ ] Drift source identified
- [ ] Files synced between templates
- [ ] Template sync validation passes locally
- [ ] Changes committed and pushed
- [ ] CI passes

---

## Related Issues

- Known CI failure from `status.md` drift
- Mentioned in PR #55/#56 validation

---

**Last Updated:** 2025-12-30

