# Template Operations Alignment Analysis

**Purpose:** Determine if test helper differences from actual script are intentional TDD additions or misalignments  
**Status:** 🟠 Analysis Complete  
**Last Updated:** 2025-11-17  
**PR:** #17

---

## Question

Are the differences between `tests/helpers/helpers.bash::copy_template()` and `scripts/new-project.sh::copy_template()` intentional TDD additions, or are they misalignments that need to be fixed?

---

## Side-by-Side Comparison

### Actual Script (`scripts/new-project.sh` lines 241-262)

```bash
copy_template() {
    local template_type="$1"
    local full_project_path="$2"
    local template_dir="$DEV_INFRA_DIR/templates/$template_type"
    
    print_status "Copying $template_type template..."
    
    if [ ! -d "$template_dir" ]; then
        print_error "Template directory not found: $template_dir"
        return 1
    fi
    
    # Copy template including hidden files
    cp -r "$template_dir" "$full_project_path"
    
    # Verify important files were copied
    if [ ! -f "$full_project_path/.gitignore" ]; then
        print_warning ".gitignore not found - template may need updating"
    fi
    
    print_success "Template copied successfully"
}
```

**Key characteristics:**
- Uses `DEV_INFRA_DIR` (calculated from script location: `$(dirname "$SCRIPT_DIR")`)
- Uses `cp -r "$template_dir" "$full_project_path"` (copies entire directory)
- Only warns if `.gitignore` missing (doesn't fail)
- Returns 1 only if template directory doesn't exist

### Test Helper (`tests/helpers/helpers.bash` lines 149-174)

```bash
copy_template() {
    local template_type="$1"
    local full_project_path="$2"
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "$PROJECT_ROOT")
    local template_dir="$git_root/templates/$template_type"
    
    if [ ! -d "$template_dir" ]; then
        return 1
    fi
    
    # Create project directory
    mkdir -p "$full_project_path"
    
    # Copy template contents including hidden files
    cp -r "$template_dir"/* "$full_project_path/" 2>/dev/null || true
    cp -r "$template_dir"/.[!.]* "$full_project_path/" 2>/dev/null || true
    
    # Verify important files were copied
    if [ ! -f "$full_project_path/.gitignore" ]; then
        return 2  # Warning: .gitignore not found
    fi
    
    return 0
}
```

**Key characteristics:**
- Uses `git rev-parse --show-toplevel` with fallback to `PROJECT_ROOT`
- Uses `cp -r "$template_dir"/*` and `cp -r "$template_dir"/.[!.]*` (copies contents)
- Returns 2 if `.gitignore` missing (fails the test)
- Creates project directory first (`mkdir -p`)

---

## Differences Analysis

### Difference 1: Path Resolution Method

**Actual Script:**
- `DEV_INFRA_DIR="$(dirname "$SCRIPT_DIR")"` where `SCRIPT_DIR` is `scripts/`
- `template_dir="$DEV_INFRA_DIR/templates/$template_type"`
- Always uses script location, no git dependency

**Test Helper:**
- Tries `git rev-parse --show-toplevel` first
- Falls back to `PROJECT_ROOT` (which is `$(cd "$SCRIPT_DIR/.." && pwd)` where `SCRIPT_DIR` is `tests/helpers/`)
- Has git dependency (though with fallback)

**Analysis:**
- The `git rev-parse` was likely added for testing flexibility
- Comments in tests say "copy_template uses PROJECT_ROOT fallback if git rev-parse fails" - suggests fallback was added for Docker compatibility
- In Docker containers, `git rev-parse` may fail, causing path resolution issues
- **Verdict:** Not intentional TDD - this is causing the current failures

---

### Difference 2: Copy Method

**Actual Script:**
- `cp -r "$template_dir" "$full_project_path"`
- Copies the entire template directory as a directory

**Test Helper:**
- `cp -r "$template_dir"/* "$full_project_path/"` (regular files)
- `cp -r "$template_dir"/.[!.]* "$full_project_path/"` (hidden files)
- Copies contents into existing directory

**Analysis:**
- The actual script copies the directory itself, which creates `$full_project_path/template_name/`
- Wait, that doesn't seem right... Let me check the actual behavior
- Actually, if `$full_project_path` doesn't exist, `cp -r "$template_dir" "$full_project_path"` creates it
- If `$full_project_path` exists, it creates `$full_project_path/template_name/`
- The test helper creates the directory first, then copies contents
- **Verdict:** This is a significant difference that could cause different behavior

---

### Difference 3: Error Handling for .gitignore

**Actual Script:**
- Only warns: `print_warning ".gitignore not found - template may need updating"`
- Does not fail (returns 0)

**Test Helper:**
- Returns 2 if `.gitignore` missing
- This would cause test to fail

**Analysis:**
- Test "template_operations: verifies .gitignore exists after copy" expects `status -eq 0`
- If the helper returned 2, this test would fail
- But the test is currently passing (or was before Docker issues)
- This suggests the return 2 might not be reached, or tests expect it to pass
- **Verdict:** Likely a bug - tests expect success, actual script only warns

---

### Difference 4: Directory Creation

**Actual Script:**
- Does not explicitly create `$full_project_path` before copying
- Relies on `cp -r` behavior

**Test Helper:**
- Explicitly creates directory: `mkdir -p "$full_project_path"`

**Analysis:**
- The actual script's `cp -r "$template_dir" "$full_project_path"` will create `$full_project_path` if it doesn't exist
- But if it exists, it creates a subdirectory
- The test helper ensures the directory exists first
- **Verdict:** Test helper is more explicit, but behavior differs

---

## Test Expectations

Looking at `tests/integration/template-operations.bats`:

1. **"copies standard-project template successfully"**
   - Expects `status -eq 0`
   - Expects `.gitignore` to exist
   - If helper returned 2, this would fail

2. **"verifies .gitignore exists after copy"**
   - Expects `status -eq 0`
   - Explicitly checks for `.gitignore`
   - If helper returned 2, this would fail

**Conclusion:** Tests expect the helper to succeed (return 0), not fail on missing `.gitignore`.

---

## Historical Context

From `admin/planning/features/directory-selection/phase-2-path-handling.md`:
- Shows the actual script was updated to use `cp -r "$template_dir" "$full_project_path"`
- This was part of Phase 2 implementation
- Test helper may not have been updated to match

---

## Root Cause of Current Failures

The current failures are:
```
not ok 5 template_operations: copies standard-project template successfully
# `[ "$status" -eq 0 ]' failed
```

This suggests `copy_template` is returning non-zero status. Possible causes:
1. `git rev-parse` failing in Docker, and `$PROJECT_ROOT` not resolving correctly
2. Template directory not found due to path resolution issue
3. Copy operation failing

---

## Copy Behavior Verification

Tested `cp -r` behavior:
- If destination doesn't exist: `cp -r source dest` creates `dest` as a copy of `source` ✓
- If destination exists: `cp -r source dest` creates `dest/source/` (subdirectory)

In the actual script:
- `$full_project_path` is `$target_dir/$name` where `$name` is the new project name
- This path should NOT exist yet (it's a new project)
- So `cp -r "$template_dir" "$full_project_path"` will create `$full_project_path` as a copy of the template ✓

In the test helper:
- Creates directory first: `mkdir -p "$full_project_path"`
- Then copies contents: `cp -r "$template_dir"/* "$full_project_path/"`
- This is different behavior - creates empty dir, then copies contents into it

**Verdict:** Test helper should match actual script - use `cp -r "$template_dir" "$full_project_path"` without `mkdir -p` first.

---

## Recommendation

**These differences are NOT intentional TDD additions.** They are misalignments:

1. **Path resolution:** Workaround using `git rev-parse` that's causing Docker failures
2. **Copy method:** Different approach (creates dir then copies contents vs copying directory)
3. **Error handling:** Returns 2 on missing `.gitignore` but tests expect 0

**Action:** Align test helper with actual script behavior:
1. Remove `git rev-parse`, use `PROJECT_ROOT` directly (equivalent to `DEV_INFRA_DIR`)
2. Match copy method: use `cp -r "$template_dir" "$full_project_path"` (remove `mkdir -p` and separate copy commands)
3. Match error handling: don't return 2 on missing `.gitignore` (just continue, like actual script only warns)

---

## Next Steps

1. **Verify actual script behavior:** Test what `cp -r "$template_dir" "$full_project_path"` actually does when `$full_project_path` exists vs doesn't exist
2. **Update test helper** to match actual script exactly
3. **Test locally** to ensure alignment
4. **Test in Docker** to verify fix

---

**Status:** 🟠 Analysis Complete - Ready for Implementation  
**Decision:** Align test helper with actual script (differences are not intentional TDD)

