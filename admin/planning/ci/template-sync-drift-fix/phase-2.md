# Template Sync Drift Fix - Phase 2: Implementation

**Phase:** 2 - Implementation  
**Duration:** ~10-15 minutes  
**Status:** ✅ Expanded  
**Prerequisites:** Phase 1 complete (drift source identified, source of truth decided)

---

## 📋 Overview

Sync the drifted `status.md` file and verify the fix locally before pushing.

**Success Definition:** Template sync validation passes locally, changes committed with descriptive message.

**Phase 1 Decision (Reference):**
- **Source of Truth:** `learning-project`
- **Direction:** `learning → standard`
- **File:** `.cursor/commands/status.md`
- **Reason:** Standard-project has extra trailing blank line; learning-project is cleaner

---

## 🎯 Goals

1. **Sync Files** - Copy correct version to target template
2. **Verify Locally** - Run template sync validation to confirm fix
3. **Commit Changes** - Create commit with descriptive message

---

## 📝 Tasks

### Task 1: Sync File from Learning to Standard

**Purpose:** Copy the clean version from learning-project to standard-project to resolve the drift.

**Steps:**

- [ ] Verify current working directory is dev-infra root
- [ ] Copy file from learning-project to standard-project
- [ ] Verify the copy succeeded

**Commands:**

```bash
# Ensure we're in the right directory
cd /Users/cdwilson/Projects/dev-infra

# Copy from learning-project (source of truth) to standard-project
cp templates/learning-project/.cursor/commands/status.md \
   templates/standard-project/.cursor/commands/status.md

# Verify the copy by checking line count (should now be 494, not 495)
wc -l templates/standard-project/.cursor/commands/status.md
# Expected: 494

# Verify files are now identical
diff templates/standard-project/.cursor/commands/status.md \
     templates/learning-project/.cursor/commands/status.md
# Expected: No output (files identical)
```

**Expected Result:**

- Standard-project file now has 494 lines (matching learning-project)
- `diff` command produces no output (files are identical)

**Checklist:**

- [ ] File copied from learning-project to standard-project
- [ ] Line count verified (494 lines)
- [ ] Files confirmed identical via diff

---

### Task 2: Verify Template Sync Validation Passes

**Purpose:** Confirm that the fix resolves the template sync drift.

**Steps:**

- [ ] Run template sync validation script
- [ ] Verify script exits with success (exit code 0)
- [ ] Confirm no drift detected

**Commands:**

```bash
# Run template sync validation
./scripts/validate-template-sync.sh

# Expected output:
# ℹ️ 🔍 Validating template sync...
# ✅ Template sync validation PASSED
# ℹ️ All shared files are in sync
```

**Expected Result:**

- Script exits with code 0 (success)
- Output shows "Template sync validation PASSED"
- No files listed as drifted

**Troubleshooting:**

If validation still fails:
- Check if other files have drifted (manifest may have been updated)
- Verify the copy command completed successfully
- Re-run diff to confirm files are identical

**Checklist:**

- [ ] Validation script executed
- [ ] Exit code is 0 (success)
- [ ] "PASSED" message displayed

---

### Task 3: Stage and Commit the Fix

**Purpose:** Commit the fix with a descriptive message for easy tracking.

**Steps:**

- [ ] Check git status to see changed files
- [ ] Stage the synced file
- [ ] Commit with descriptive message

**Commands:**

```bash
# Check what changed
git status

# Expected: templates/standard-project/.cursor/commands/status.md modified

# Stage the fix
git add templates/standard-project/.cursor/commands/status.md

# Commit with descriptive message
git commit -m "fix(templates): sync status.md to resolve template drift

Sync status.md from learning-project to standard-project.

Root cause: standard-project had extra trailing blank line (495 vs 494 lines)
Direction: learning-project → standard-project (learning is cleaner)

Resolves CI template sync validation failures.

Related: CI Improvement template-sync-drift-fix, Phase 2"
```

**Expected Result:**

- Commit created on `ci/template-sync-drift-fix-phase-1` branch
- Single file changed: `templates/standard-project/.cursor/commands/status.md`
- Clear commit message explains the fix

**Checklist:**

- [ ] Git status reviewed
- [ ] File staged
- [ ] Commit created with descriptive message

---

## 📊 Progress Tracking

| Task                         | Status         | Notes |
| ---------------------------- | -------------- | ----- |
| Task 1: Sync File            | 🔴 Not Started |       |
| Task 2: Verify Validation    | 🔴 Not Started |       |
| Task 3: Stage and Commit     | 🔴 Not Started |       |

---

## ✅ Completion Criteria

- [ ] File synced between templates
- [ ] `./scripts/validate-template-sync.sh` passes
- [ ] Changes committed with descriptive message
- [ ] Ready for Phase 3 (push and CI verification)

---

## 📦 Deliverables

- Synced `status.md` file in both templates (identical content)
- Passing local validation
- Git commit ready for push

---

## 🔗 Dependencies

### Prerequisites

- Phase 1 complete
- Decision on source of truth (learning-project)

### Blocks

- Phase 3: Verification (cannot push without commit)

---

## 🔗 Related Documents

- [Transition Plan](transition-plan.md)
- [Phase 1: Analysis](phase-1.md) - Source of truth decision documented here
- [Phase 3: Verification](phase-3.md)
- [Template Sync Validation Script](../../../../scripts/validate-template-sync.sh)

---

**Last Updated:** 2025-12-30  
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1
