# Phase 3: Add CI Drift Detection

**Phase:** 3 of 4  
**Duration:** 2-3 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 2 complete  
**Last Updated:** 2025-12-15

---

## 📋 Overview

Implement CI validation that detects when shared files drift between standard-project and experimental-project templates, ensuring they stay in sync.

**Success Definition:** CI automatically detects and fails when shared files differ between templates.

---

## 🎯 Goals

1. Document shared file categories
2. Create drift detection script
3. Integrate with existing CI workflow
4. Add tests for drift detection

---

## 📝 Tasks

### Task 1: Define Shared File Categories

**Objective:** Document which files must be in sync vs experimental-only

**Process:**

1. [x] Analyze template file structure
2. [x] Categorize files into shared vs experimental-only
3. [x] Create documentation of categories

**File Categories:**

| Category | Examples | Sync Required |
|----------|----------|---------------|
| **Infrastructure** | `.gitignore`, `.editorconfig` | ✅ Yes |
| **CI Workflows** | `.github/workflows/*.yml` | ✅ Yes |
| **Core Structure** | `backend/`, `frontend/`, `tests/` | ✅ Yes |
| **Stable Commands** | `.cursor/commands/[essential/valuable/advanced]` | ✅ Yes |
| **Evolving Commands** | `.cursor/commands/[evolving]` | ❌ Experimental only |
| **Template Identity** | `README.md` (partial), `start.txt` | ❌ Different by design |
| **Experimental Docs** | `docs/EXPERIMENTAL.md` | ❌ Experimental only |

---

### Task 2: Create Shared Files Manifest

**Objective:** Create machine-readable list of shared files

**File:** `scripts/template-sync-manifest.txt`

**Process:**

1. [x] Create manifest file with shared files list
2. [x] Include all infrastructure files
3. [x] Include all shared directories
4. [x] Include all 18 stable commands
5. [x] Add comments documenting intentionally different files

```
# Files that must be identical between standard and experimental templates
# Lines starting with # are comments
# Use relative paths from template root

.gitignore
.editorconfig
.github/workflows/test.yml
backend/
frontend/
tests/
scripts/
docs/maintainers/
.cursor/commands/fix-plan.md
.cursor/commands/fix-implement.md
.cursor/commands/task-phase.md
.cursor/commands/pr.md
.cursor/commands/pr-validation.md
.cursor/commands/post-pr.md
# ... other stable commands
```

---

### Task 3: Create Drift Detection Script

**Objective:** Script that compares shared files between templates

**File:** `scripts/validate-template-sync.sh`

**Process:**

1. [ ] Create script with TDD (write tests first)
2. [ ] Read manifest of shared files
3. [ ] Compare files between templates
4. [ ] Report differences clearly
5. [ ] Exit with error if drift detected

**Expected Script Structure:**

```bash
#!/bin/bash
# Validates that shared files are in sync between templates

STANDARD_DIR="templates/standard-project"
EXPERIMENTAL_DIR="templates/experimental-project"
MANIFEST="scripts/template-sync-manifest.txt"

# Read manifest and compare files
# Exit 0 if in sync, exit 1 if drift detected
```

**Expected Output (drift detected):**

```
🔍 Validating template sync...

DRIFT DETECTED in the following files:
- .gitignore
  Standard: line 15 differs
  
- .cursor/commands/fix-plan.md
  Files are different

❌ Template sync validation FAILED
Run './scripts/sync-templates.sh' to fix (or manually sync)
```

---

### Task 4: Write Tests for Drift Detection

**Objective:** TDD tests for drift detection script

**File:** `tests/unit/validate-template-sync.bats`

**Test Cases:**

```bash
@test "validate-template-sync.sh passes when templates are in sync" {
  # Setup: Create identical files in both templates
  run "$SCRIPT"
  [ "$status" -eq 0 ]
}

@test "validate-template-sync.sh fails when shared file differs" {
  # Setup: Modify a shared file in one template
  run "$SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "DRIFT DETECTED" ]]
}

@test "validate-template-sync.sh ignores experimental-only files" {
  # Setup: Ensure evolving commands don't cause failure
  run "$SCRIPT"
  [ "$status" -eq 0 ]
}
```

---

### Task 5: Integrate with CI Workflow

**Objective:** Run drift detection in CI pipeline

**Process:**

1. [ ] Add drift detection step to template validation workflow
2. [ ] Run after checkout, before other tests
3. [ ] Fail fast if drift detected

**CI Workflow Update:**

```yaml
# .github/workflows/test.yml
jobs:
  template-validation:
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        
      - name: Validate Template Sync
        run: ./scripts/validate-template-sync.sh
        
      - name: Run Template Tests
        run: bats tests/unit/validate-templates.bats
```

---

### Task 6: Create Sync Documentation

**Objective:** Document sync requirements and process

**File:** `docs/TEMPLATE-SYNC.md`

**Contents:**

```markdown
# Template Synchronization

## Overview

The `standard-project` and `experimental-project` templates share common 
files that must stay in sync. This document explains the sync requirements 
and process.

## Shared File Categories

[Categories table]

## How Sync Works

1. CI runs `validate-template-sync.sh` on every PR
2. Script compares shared files between templates
3. PR fails if drift is detected

## Fixing Drift

When drift is detected:

1. Identify the source of truth (usually standard-project)
2. Copy the file to the other template
3. Commit the sync

## Adding New Shared Files

1. Add the file to both templates
2. Add to `scripts/template-sync-manifest.txt`
3. CI will enforce sync going forward
```

---

## ✅ Completion Criteria

- [ ] Shared file categories documented
- [ ] Manifest file created
- [ ] Drift detection script works
- [ ] Tests pass for drift detection
- [ ] CI workflow updated
- [ ] Sync documentation complete

---

## 📦 Deliverables

1. `scripts/template-sync-manifest.txt`
2. `scripts/validate-template-sync.sh`
3. `tests/unit/validate-template-sync.bats`
4. Updated `.github/workflows/test.yml`
5. `docs/TEMPLATE-SYNC.md`

---

## 🔗 Dependencies

**Prerequisites:**
- Phase 1 & 2 complete (both templates exist and work)

**Blocks:**
- None (Phase 4 can run in parallel)

---

## 💡 Implementation Notes

### Performance

Script should be fast (<5 seconds) for CI. Use `diff -q` for quick comparison before detailed diff.

### Handling Binary Files

If templates contain binary files, use checksums instead of diff.

### Future Enhancement

Consider optional `--fix` flag that automatically syncs files (copy from standard to experimental).

---

## 🔗 Related Documents

- **Previous:** [Phase 2: Update Generator](phase-2.md)
- **Next:** [Phase 4: Stability Indicators](phase-4.md)
- **Feature Plan:** [feature-plan.md](feature-plan.md)
- **Hub:** [README.md](README.md)

---

**Last Updated:** 2025-12-12  
**Status:** 🔴 Not Started

