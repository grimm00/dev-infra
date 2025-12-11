# CI/CD Improvement Plan - Version Reference Automation

**Improvement:** Automate Version Reference Updates  
**Priority:** 🔴 High  
**Effort:** Moderate (3-5 hours)  
**Status:** 🟡 Planned  
**Created:** 2025-12-11  
**Source:** reflection-v1.4.0-release-cycle-2025-12-11.md

---

## 📋 Overview

Enhance `/release-finalize` command with automatic version reference updates for known locations in the codebase. This eliminates manual scanning and ensures version consistency across all documentation and configuration files.

**Current State:**
- Version references manually scanned with grep
- Manual updates to each file
- Risk of missing references
- Time-consuming process

**Desired State:**
- Automatic detection of version references
- Automatic updates to all known locations
- Validation of successful updates
- Dry-run mode to preview changes

---

## 🎯 Benefits

1. **Eliminates Manual Scanning**
   - No more grep commands
   - No manual file-by-file updates
   - Saves 15-20 minutes per release

2. **Ensures Version Consistency**
   - All references updated atomically
   - No risk of missed references
   - Consistent version numbers across codebase

3. **Documents All Version Locations**
   - Script serves as living documentation
   - Easy to add new locations
   - Clear inventory of where versions are referenced

4. **Reduces Release Prep Time**
   - Automated step in `/release-finalize`
   - No manual intervention needed
   - Faster release preparation

---

## 📅 Implementation Steps

### Step 1: Create Update Script

**File:** `scripts/update-version-references.sh`

**Functionality:**
- Accept old version and new version as arguments
- Update known files with version references
- Support dry-run mode
- Validate updates successful
- Report changes made

**Actions:**
1. Create script file
2. Add argument parsing
3. Add version validation
4. Add dry-run support

**Estimated Time:** 1 hour

---

### Step 2: Identify Version Reference Locations

**Known Locations:**

1. **`.cursor/rules/main.mdc`** - Project state
   ```markdown
   **Version:** v1.4.0 (released 2025-12-11)
   ```

2. **`README.md`** - Version badge (if exists)
   ```markdown
   ![Version](https://img.shields.io/badge/version-v1.4.0-blue)
   ```

3. **`package.json`** - Version field (if exists)
   ```json
   {
     "version": "1.4.0"
   }
   ```

4. **Template files** (if applicable)
   - `templates/standard-project/README.md`
   - Other template locations

**Actions:**
1. Document all current version reference locations
2. Verify each location format
3. Create test cases for each location
4. Add to script configuration

**Estimated Time:** 1 hour

---

### Step 3: Implement Update Logic

**For Each File Type:**

1. **`.mdc` Files (Markdown + Metadata):**
   ```bash
   # Update "Version: vX.Y.Z"
   sed -i.bak "s/Version: $OLD_VERSION/Version: $NEW_VERSION/g" "$FILE"
   ```

2. **`README.md` Files:**
   ```bash
   # Update version badges
   sed -i.bak "s/version-$OLD_VERSION/version-$NEW_VERSION/g" "$FILE"
   ```

3. **`package.json` Files:**
   ```bash
   # Update version field
   jq ".version = \"$NEW_VERSION_NO_V\"" "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
   ```
   (Note: Need to strip 'v' prefix for package.json)

**Actions:**
1. Implement update logic for each file type
2. Handle edge cases (missing files, invalid format)
3. Create backup files before updates
4. Validate updates successful
5. Add error handling

**Estimated Time:** 2 hours

---

### Step 4: Add Validation

**Validation Checks:**
1. Verify old version replaced
2. Verify new version present
3. Verify no unexpected changes
4. Report success/failure

**Implementation:**
```bash
validate_update() {
    local file=$1
    local old_version=$2
    local new_version=$3
    
    # Check old version not present
    if grep -q "$old_version" "$file"; then
        echo "❌ Update failed: $file still contains $old_version"
        return 1
    fi
    
    # Check new version present
    if ! grep -q "$new_version" "$file"; then
        echo "❌ Update failed: $file doesn't contain $new_version"
        return 1
    fi
    
    echo "✅ Updated: $file"
    return 0
}
```

**Actions:**
1. Implement validation function
2. Add validation for each file
3. Report validation results
4. Return error code if any validation fails

**Estimated Time:** 1 hour

---

### Step 5: Integrate with `/release-finalize`

**Integration Points:**
1. Add call to `update-version-references.sh` after CHANGELOG merge
2. Pass old version (detected from previous tag) and new version
3. Handle dry-run mode
4. Report results to user

**Updates to `/release-finalize`:**
```markdown
### Step 4: Update Version References (NEW)

**Purpose:** Update all version references across codebase.

**Process:**
1. Detect previous version from git tags
2. Extract new version from arguments
3. Run update-version-references.sh
4. Validate updates successful
5. Report changes made
```

**Actions:**
1. Update `/release-finalize` command documentation
2. Add version update step to workflow
3. Add `--skip-version-update` flag
4. Test integration

**Estimated Time:** 1 hour

---

### Step 6: Add Configuration Support

**Configuration File:** `scripts/version-references.conf` (optional)

**Purpose:** Allow projects to customize version reference locations

**Format:**
```bash
# Version reference locations
VERSION_LOCATIONS=(
    ".cursor/rules/main.mdc:Version: {VERSION}"
    "README.md:version-{VERSION}"
    "package.json:\"version\": \"{VERSION_NO_V}\""
)
```

**Actions:**
1. Create configuration file format
2. Add configuration loading to script
3. Use configuration if exists, defaults otherwise
4. Document configuration format

**Estimated Time:** 30 minutes

---

## ✅ Definition of Done

- [ ] Script created (`scripts/update-version-references.sh`)
- [ ] All known locations documented
- [ ] Update logic implemented for each file type
- [ ] Validation implemented
- [ ] Dry-run mode working
- [ ] Integration with `/release-finalize` complete
- [ ] Tests pass (all file types)
- [ ] Configuration support added
- [ ] Documentation updated
  - [ ] Script usage documented
  - [ ] `/release-finalize` command updated
  - [ ] Version reference locations documented
- [ ] Tested with v1.5.0 release (or test release)

---

## 🧪 Testing Plan

### Unit Testing

**Test Cases:**
1. **`.mdc` File Updates:**
   - Test updating "Version: v1.4.0" → "Version: v1.5.0"
   - Test multiple occurrences
   - Test with different version formats

2. **`README.md` Updates:**
   - Test updating version badges
   - Test version in links
   - Test version in examples

3. **`package.json` Updates:**
   - Test version field update
   - Test stripping 'v' prefix
   - Test JSON formatting preserved

4. **Validation:**
   - Test validation passes when update successful
   - Test validation fails when update incomplete
   - Test validation reports clear errors

---

### Integration Testing

**Test Scenarios:**
1. **Complete Update Flow:**
   - Run script with test versions
   - Verify all files updated
   - Verify validation passes
   - Verify no unexpected changes

2. **Dry-Run Mode:**
   - Run with --dry-run
   - Verify no files modified
   - Verify output shows what would change

3. **Error Handling:**
   - Test with missing files
   - Test with invalid version format
   - Test with permission errors
   - Verify appropriate error messages

4. **Integration with `/release-finalize`:**
   - Run `/release-finalize` with version updates
   - Verify automatic updates
   - Verify no manual intervention needed

---

## 📝 Documentation Updates

**Files to Update:**

1. **`scripts/update-version-references.sh`** (inline documentation)
   - Usage examples
   - Supported file types
   - Configuration options

2. **`.cursor/commands/release-finalize.md`**
   - Update Step 4 to include version reference updates
   - Document `--skip-version-update` flag
   - Add examples

3. **`admin/planning/releases/PROCESS.md`**
   - Note version references updated automatically
   - Remove manual scanning steps
   - Update release checklist

4. **Version Reference Locations Document** (new)
   - Create `docs/VERSION-REFERENCES.md`
   - List all known version reference locations
   - Document format expectations
   - Explain how to add new locations

---

## 🔗 Related

**Related Scripts:**
- `scripts/check-release-readiness.sh` - Release validation
- `scripts/create-release-branch.sh` - Branch creation

**Related Commands:**
- `/release-prep` - Release preparation
- `/release-finalize` - Release finalization (integrates this script)

**Related Documents:**
- `admin/planning/releases/PROCESS.md` - Release process
- `.cursor/rules/main.mdc` - Main cursor rules (version reference)

---

## 🎯 Success Criteria

**Immediate Success:**
- Script updates all known version references automatically
- Validation confirms successful updates
- Integration with `/release-finalize` works smoothly
- Zero manual version updates required

**Long-term Success:**
- Used for v1.5.0 release (first automated update)
- Zero version inconsistency issues in next 3 releases
- Release preparation time reduced by 15-20 minutes
- Easy to add new version reference locations

---

## 📊 Metrics

**Track:**
- Time saved per release (target: 15-20 minutes)
- Version update success rate (target: 100%)
- Version consistency rate (target: 100%)
- Number of version reference locations tracked

---

**Last Updated:** 2025-12-11  
**Status:** 🟡 Planned  
**Next:** Create script and test with dry-run mode

