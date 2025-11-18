# Template Operations Investigation

**Purpose:** Document investigation and fix for template operations test failures  
**Status:** ✅ Complete  
**Last Updated:** 2025-11-17  
**PR:** #17

---

## Current Status

- ✅ Quick-checks passing (unit tests)
- ✅ Full-tests now passing (after alignment fix)
- All 4 template operations tests passing

---

## Issue Summary

Template operations tests were failing in Docker container:
- `template_operations: copies standard-project template successfully` - `[ "$status" -eq 0 ]' failed`
- `template_operations: copies learning-project template successfully` - `[ "$status" -eq 0 ]' failed`
- `template_operations: verifies .gitignore exists after copy` - `[ "$status" -eq 0 ]' failed`

---

## Investigation Process

### Step 1: Alignment Analysis

First, we analyzed whether test helper differences from actual script were intentional TDD additions or misalignments.

**Key Finding:** Differences were NOT intentional TDD additions. See [template-operations-alignment-analysis.md](template-operations-alignment-analysis.md) for full analysis.

### Step 2: Alignment Fix

Aligned test helper `copy_template` with actual script:
1. Removed `git rev-parse` (not used in actual script, causing Docker failures)
2. Used `PROJECT_ROOT` directly (equivalent to `DEV_INFRA_DIR`)
3. Matched copy method: `cp -r "$template_dir" "$full_project_path"` (copy directory, not contents)
4. Removed `return 2` on missing `.gitignore` (actual script only warns)

### Step 3: Path Resolution Fix

After alignment, tests still failed due to incorrect `PROJECT_ROOT` calculation:

**Problem:**
- `PROJECT_ROOT` was `$(cd "$SCRIPT_DIR/.." && pwd)` where `SCRIPT_DIR` is `tests/helpers/`
- This resolved to `tests/` instead of project root
- Template path was wrong: `tests/templates/...` instead of `templates/...`

**Fix:**
- Updated to `$(cd "$SCRIPT_DIR/../.." && pwd)` (go up two levels)
- Now correctly resolves to project root (parent of `tests/`)
- Matches actual script's `DEV_INFRA_DIR` calculation (parent of `scripts/`)

---

## Final Implementation

### Test Helper (`tests/helpers/helpers.bash`)

```bash
# PROJECT_ROOT calculation (lines 6-9)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# PROJECT_ROOT is the parent of tests/ (equivalent to DEV_INFRA_DIR in actual script)
# SCRIPT_DIR is tests/helpers/, so we need to go up two levels: tests/helpers/ -> tests/ -> project root
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# copy_template function (lines 149-172)
copy_template() {
    local template_type="$1"
    local full_project_path="$2"
    # Use PROJECT_ROOT directly (equivalent to DEV_INFRA_DIR in actual script)
    local template_dir="$PROJECT_ROOT/templates/$template_type"
    
    if [ ! -d "$template_dir" ]; then
        return 1
    fi
    
    # Copy template directory (matches actual script behavior)
    cp -r "$template_dir" "$full_project_path"
    
    # Verify important files were copied (matches actual script - only warns, doesn't fail)
    # Note: We don't return 2 here because actual script doesn't fail on missing .gitignore
    
    return 0
}
```

### Alignment with Actual Script

The test helper now matches `scripts/new-project.sh::copy_template()`:
- ✅ Uses project root directly (no git dependency)
- ✅ Copies entire directory with `cp -r "$template_dir" "$full_project_path"`
- ✅ Only returns 1 if template directory doesn't exist
- ✅ Doesn't fail on missing `.gitignore` (tests verify separately)

---

## Test Results

**Before Fix:**
```
not ok 1 template_operations: copies standard-project template successfully
not ok 2 template_operations: copies learning-project template successfully
not ok 4 template_operations: verifies .gitignore exists after copy
```

**After Fix:**
```
ok 1 template_operations: copies standard-project template successfully
ok 2 template_operations: copies learning-project template successfully
ok 3 template_operations: returns error for non-existent template
ok 4 template_operations: verifies .gitignore exists after copy
```

---

## Key Learnings

1. **Test helpers must match actual script behavior** - Differences should be intentional and documented
2. **Path resolution matters** - `PROJECT_ROOT` calculation must correctly resolve to project root
3. **Docker environment differences** - `git rev-parse` may not work in containers, so avoid git dependencies
4. **Copy behavior** - `cp -r source dest` creates `dest` as copy of `source` if `dest` doesn't exist

---

## Related Documentation

- [template-operations-alignment-analysis.md](template-operations-alignment-analysis.md) - Detailed alignment analysis
- [docker-image-fixes.md](docker-image-fixes.md) - All Docker-related fixes

---

**Status:** ✅ Complete  
**Result:** All template operations tests passing locally and ready for Docker verification

