# Version References Documentation

This document describes where version numbers are stored in the codebase and how they are automatically updated during releases.

---

## 📋 Overview

Version references are automatically updated by the `update-version-references.sh` script during the release finalization process (`/release-finalize` command).

**Script Location:** `scripts/update-version-references.sh`

**Integration:** Step 4 of `/release-finalize` command

---

## 📍 Version Reference Locations

### 1. Cursor Rules (`.cursor/rules/main.mdc`)

**Pattern:** `**Version:** vX.Y.Z`

**Example:**
```markdown
**Version:** v1.4.0 (released 2025-12-11)
```

**Purpose:** Project state tracking in Cursor AI rules

**Update Behavior:**
- Preserves status suffixes (e.g., "(released YYYY-MM-DD)")
- Updates version number only
- Maintains formatting

---

### 2. README.md (Optional)

**Pattern:** `version-vX.Y.Z` or `v=X.Y.Z` in version badges

**Example:**
```markdown
![Version](https://img.shields.io/badge/version-v1.4.0-blue)
```

**Purpose:** Display current version in repository README

**Update Behavior:**
- Only updated if version badge exists
- Updates badge URL parameter
- Skipped if no version badge present

---

### 3. package.json (Optional)

**Pattern:** `"version": "X.Y.Z"` (no 'v' prefix)

**Example:**
```json
{
  "version": "1.4.0"
}
```

**Purpose:** NPM package version (for Node.js projects)

**Update Behavior:**
- Only updated if file exists
- Uses semantic version format (no 'v' prefix)
- Skipped if file doesn't exist

---

## 🔧 Automation

### Script Usage

**Manual execution:**
```bash
./scripts/update-version-references.sh \
    --old-version v1.3.0 \
    --new-version v1.4.0
```

**Dry-run (preview changes):**
```bash
./scripts/update-version-references.sh --dry-run \
    --old-version v1.3.0 \
    --new-version v1.4.0
```

**Verbose mode:**
```bash
./scripts/update-version-references.sh --verbose \
    --old-version v1.3.0 \
    --new-version v1.4.0
```

### Automated via /release-finalize

The script is automatically invoked during release finalization:

```bash
/release-finalize v1.4.0
```

**Process:**
1. Detects previous version from git tags
2. Runs `update-version-references.sh`
3. Updates all known locations
4. Validates changes
5. Reports results

**Options:**
- `--skip-version-update` - Skip automatic version updates
- `--dry-run` - Preview all changes (including version updates)

---

## ✅ Validation

The script includes built-in validation:

### Pre-Update Validation

- Version format validation (vMAJOR.MINOR.PATCH)
- File existence checks
- Backup creation before modification

### Post-Update Validation

- Old version removed from all files
- New version present in all files
- Backup restoration on failure

### Error Handling

- Creates `.bak` backup files
- Restores backups if validation fails
- Returns error exit codes
- Reports specific failure reasons

---

## 📝 Adding New Version Locations

To add a new version reference location to the script:

### 1. Identify the Location

Document the file path, pattern, and purpose:
```markdown
File: path/to/file.ext
Pattern: exact-pattern-to-match
Purpose: why this version exists
```

### 2. Update the Script

Add to `scripts/update-version-references.sh` in the main() function:

```bash
# 4. Update your-new-file
if [[ -f "$PROJECT_ROOT/path/to/file.ext" ]]; then
    if ! update_file_version "$PROJECT_ROOT/path/to/file.ext" "$OLD_VERSION" "$NEW_VERSION" "file-type"; then
        ((errors++))
    fi
else
    log "File not found: path/to/file.ext (skipping)"
fi
```

### 3. Add Test Coverage

Add tests to `tests/unit/update-version-references.bats`:

```bash
@test "update-version-references.sh updates your-new-file" {
    # Test logic here
}
```

### 4. Update This Document

Add the new location to the "Version Reference Locations" section above.

### 5. Update /release-finalize

Update `.cursor/commands/release-finalize.md` if the new location requires special handling.

---

## 🔍 Verification

### Manual Verification

After a release, verify version updates:

```bash
# Check main.mdc
grep "Version:" .cursor/rules/main.mdc

# Check README.md (if badge exists)
grep "version.*v1\." README.md

# Check package.json (if exists)
grep '"version"' package.json
```

### Automated Verification

The script automatically verifies updates:
- Runs grep to confirm old version removed
- Runs grep to confirm new version present
- Reports any validation failures

---

## 🚨 Troubleshooting

### Issue: Version Not Updated

**Symptoms:** File still contains old version after script runs

**Causes:**
- File not in known locations list
- Pattern doesn't match expected format
- File permissions issue
- Validation failed and backup restored

**Solution:**
1. Check script output for errors
2. Verify file is in known locations
3. Check file pattern matches expected format
4. Run with `--verbose` for detailed output

### Issue: Backup File Remains

**Symptoms:** `.bak` files left after script runs

**Causes:**
- Script interrupted before cleanup
- Validation failed (backup intentionally preserved)

**Solution:**
1. Check script exit code and output
2. If validation failed, fix issue and re-run
3. If successful, manually remove `.bak` files:
   ```bash
   find . -name "*.bak" -delete
   ```

### Issue: Wrong Version Detected

**Symptoms:** Script uses incorrect previous version

**Causes:**
- Git tags not up to date
- Wrong tag format

**Solution:**
1. Check git tags: `git tag --list 'v*' --sort=-v:refname`
2. Ensure tags follow `vX.Y.Z` format
3. Manually specify versions if needed

---

## 📚 Related Documentation

- **Script Source:** `scripts/update-version-references.sh`
- **Tests:** `tests/unit/update-version-references.bats`
- **Release Finalize Command:** `.cursor/commands/release-finalize.md`
- **Release Process:** `../admin/planning/releases/PROCESS.md`
- **Phase 2 Plan:** `../admin/planning/features/release-automation-v2/phase-2.md`

---

**Last Updated:** 2025-12-11  
**Maintained By:** Release Automation v2 (Phase 2)  
**Script Version:** 1.0.0

