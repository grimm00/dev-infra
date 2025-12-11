# Phase 2: Version Reference Automation

**Phase:** 2 of 3  
**Status:** 🟡 Planned  
**Priority:** 🔴 High  
**Effort:** 3-5 hours  
**Dependencies:** None (can run parallel with Phase 1)

---

## 🎯 Goal

Create script to automatically update version references across the codebase and integrate with `/release-finalize` command. This eliminates manual scanning and updating of version numbers.

---

## 📋 Current State

- Version references manually scanned with grep
- Manual updates to each file found
- Risk of missing references
- Time-consuming (15-20 minutes per release)
- No validation that all references updated

---

## 🎯 Target State

- Single script updates all known version locations
- Integrated into `/release-finalize` workflow
- Dry-run mode to preview changes
- Validation confirms successful updates
- Easy to add new locations

---

## 📍 Known Version Reference Locations

| File | Pattern | Example |
|------|---------|---------|
| `.cursor/rules/main.mdc` | `**Version:** vX.Y.Z` | `**Version:** v1.4.0 (released...)` |
| `README.md` | Version badge (if exists) | `![Version](https://img.shields.io/.../v1.4.0)` |
| `package.json` | `"version": "X.Y.Z"` | `"version": "1.4.0"` |
| Template files | May contain version examples | Various |

---

## 📅 Tasks

### Task 1: Create Update Script

**File:** `scripts/update-version-references.sh`

- [ ] Create script with argument parsing
- [ ] Accept: `--old-version v1.4.0 --new-version v1.5.0`
- [ ] Accept: `--dry-run` flag
- [ ] Validate version formats
- [ ] Exit codes for success/failure

**Estimated:** 1 hour

---

### Task 2: Implement File Updates

- [ ] Update `.cursor/rules/main.mdc`
  - Pattern: `**Version:** vX.Y.Z`
  - Handle various status suffixes (released, pending, etc.)

- [ ] Update `README.md` (if version badge exists)
  - Pattern: `version-vX.Y.Z` or `v=X.Y.Z`

- [ ] Update `package.json` (if exists)
  - Pattern: `"version": "X.Y.Z"` (no 'v' prefix)

- [ ] Add backup before modification
- [ ] Restore backup on failure

**Estimated:** 2 hours

---

### Task 3: Add Validation

- [ ] Verify old version no longer present
- [ ] Verify new version present
- [ ] Report success/failure for each file
- [ ] Return appropriate exit code

**Code:**
```bash
validate_update() {
    local file=$1
    local old_version=$2
    local new_version=$3
    
    if grep -q "$old_version" "$file"; then
        print_error "Update failed: $file still contains $old_version"
        return 1
    fi
    
    if ! grep -q "$new_version" "$file"; then
        print_error "Update failed: $file doesn't contain $new_version"
        return 1
    fi
    
    print_success "Updated: $file"
    return 0
}
```

**Estimated:** 30 minutes

---

### Task 4: Add Dry-Run Mode

- [ ] Show what would change without modifying files
- [ ] Display diff-like output
- [ ] Clear indication that dry-run is active

**Code:**
```bash
if [[ "$DRY_RUN" == true ]]; then
    print_info "[DRY RUN] Would update: $file"
    print_info "  Old: $old_version"
    print_info "  New: $new_version"
else
    # Actually update
fi
```

**Estimated:** 30 minutes

---

### Task 5: Integrate with /release-finalize

**Updates to `.cursor/commands/release-finalize.md`:**

- [ ] Add step: "Update Version References"
- [ ] Detect previous version (from git tags)
- [ ] Call `update-version-references.sh`
- [ ] Handle dry-run passthrough
- [ ] Add `--skip-version-update` flag

**Workflow Update:**
```markdown
### Step 4: Update Version References

**Process:**
1. Detect previous version from git tags
2. Run version reference update script
3. Validate all updates successful
4. Report changes made
```

**Estimated:** 1 hour

---

### Task 6: Add Tests

**File:** `tests/unit/update-version-references.bats`

- [ ] Test version format validation
- [ ] Test file updates (mock files)
- [ ] Test dry-run mode
- [ ] Test validation logic
- [ ] Test error handling

**Estimated:** 1 hour

---

### Task 7: Documentation

- [ ] Add inline script documentation
- [ ] Update `/release-finalize` command
- [ ] Create `docs/VERSION-REFERENCES.md` documenting locations
- [ ] Update release process docs

**Estimated:** 30 minutes

---

## ✅ Definition of Done

- [ ] Script created and tested
- [ ] All known locations updated correctly
- [ ] Dry-run mode works
- [ ] Validation catches failures
- [ ] Integration with `/release-finalize` complete
- [ ] Tests pass (Bats tests)
- [ ] Documentation updated
- [ ] Tested with v1.5.0 release

---

## 🧪 Testing Plan

### Unit Testing (Bats)

| Test Case | Input | Expected |
|-----------|-------|----------|
| Valid versions | `v1.4.0 → v1.5.0` | Success |
| Invalid old version | `1.4.0` (no v) | Error |
| Invalid new version | `v1.5` (no patch) | Error |
| Missing file | File doesn't exist | Warning, continue |
| Dry-run | `--dry-run` | No changes, output only |

### Integration Testing

1. **Script Standalone:**
   - Run on test files
   - Verify updates correct
   - Verify validation catches issues

2. **With /release-finalize:**
   - Run full command
   - Verify version updates happen
   - Verify validation reports

3. **v1.5.0 Release:**
   - First real use
   - Verify all references updated

---

## 📝 Configuration (Optional)

**File:** `scripts/version-references.conf` (optional enhancement)

```bash
# Version reference locations
# Format: FILE:PATTERN
VERSION_LOCATIONS=(
    ".cursor/rules/main.mdc:**Version:** {VERSION}"
    "README.md:version-{VERSION}"
    "package.json:\"version\": \"{VERSION_NO_V}\""
)
```

**Note:** Start with hardcoded locations, add config later if needed.

---

**Migrated From:** `admin/planning/ci/version-reference-automation/improvement-plan.md`  
**Last Updated:** 2025-12-11

