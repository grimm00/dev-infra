# Release Finalize Command

Finalizes release preparation by merging CHANGELOG draft, completing release notes, scanning for version references, and updating the release readiness checklist.

---

## Configuration

**Path Detection:**

This command supports multiple project organization patterns:

1. **Dev-Infra Structure (default):**
   - Releases: `admin/planning/releases/[version]/`
   - CHANGELOG: `CHANGELOG.md` (root)
   - Scripts: `scripts/`

2. **Template Structure (for generated projects):**
   - Releases: `docs/maintainers/planning/releases/[version]/`
   - CHANGELOG: `CHANGELOG.md` (root)

**Version Detection:**

- Use version argument (required)
- Format: `v1.4.0` or `1.4.0` (normalized to `vX.Y.Z`)

---

## Workflow Overview

**When to use:**

- After `/release-prep` has generated draft documents
- After reviewing and approving draft content
- Before creating the release PR
- To finalize all release documentation

**Key principle:** Bridge the gap between draft generation and release PR creation.

**Workflow Position:**

```
/release-prep v1.4.0
         │
         ▼
   Review Drafts (manual)
         │
         ▼
┌─────────────────────────────────────┐
│   /release-finalize v1.4.0          │  ◄── This command
│                                     │
│   1. Merge CHANGELOG draft          │
│   2. Finalize release notes         │
│   3. Scan version references        │
│   4. Update readiness checklist     │
│   5. Create release branch (if not) │
└─────────────────────────────────────┘
         │
         ▼
   /pr --release
```

---

## Usage

**Command:** `/release-finalize [version] [options]`

**Examples:**

- `/release-finalize v1.4.0` - Full finalization
- `/release-finalize v1.4.0 --dry-run` - Preview changes
- `/release-finalize v1.4.0 --changelog-only` - Only merge CHANGELOG
- `/release-finalize v1.4.0 --skip-branch` - Skip branch creation
- `/release-finalize v1.4.0 --date 2025-12-15` - Set release date

**Options:**

- `--dry-run` - Show what would be done without executing
- `--changelog-only` - Only merge CHANGELOG draft
- `--skip-branch` - Skip release branch creation
- `--date YYYY-MM-DD` - Set release date (default: today)
- `--force` - Continue even with warnings

---

## Step-by-Step Process

### 1. Validate Prerequisites

**Check required files exist:**

```bash
# Required files
admin/planning/releases/v1.4.0/CHANGELOG-DRAFT.md
admin/planning/releases/v1.4.0/RELEASE-NOTES.md
admin/planning/releases/v1.4.0/RELEASE-READINESS.md
CHANGELOG.md
```

**Validate CHANGELOG-DRAFT.md:**

- Has version section header
- Has categorized changes (Added, Changed, Fixed, etc.)
- Review checklist items are addressed

**Checklist:**

- [ ] CHANGELOG-DRAFT.md exists
- [ ] RELEASE-NOTES.md exists
- [ ] RELEASE-READINESS.md exists
- [ ] Root CHANGELOG.md exists
- [ ] Draft content is valid

---

### 2. Merge CHANGELOG Draft

**Process:**

1. **Read CHANGELOG-DRAFT.md:**
   - Extract version section content
   - Parse categorized changes

2. **Read existing CHANGELOG.md:**
   - Find insertion point (after `## [Unreleased]` or at top of versions)
   - Preserve existing content

3. **Merge content:**
   - Insert new version section
   - Set release date (replace `YYYY-MM-DD` placeholder)
   - Update `[Unreleased]` section if present

**Example merge:**

```markdown
## [Unreleased]
...

## [1.4.0] - 2025-12-11    ◄── Inserted

### Added
- **Release Readiness Feature** - Complete release assessment...
...

## [1.3.0] - 2025-11-18    ◄── Existing
...
```

4. **Validate merge:**
   - Check version section is present
   - Check date is set
   - Check categories are preserved

**Checklist:**

- [ ] Draft content extracted
- [ ] Insertion point found
- [ ] Content merged
- [ ] Date set
- [ ] CHANGELOG.md updated

---

### 3. Finalize Release Notes

**Process:**

1. **Update RELEASE-NOTES.md:**
   - Set release date (replace placeholder)
   - Update status from "Draft" to "Final"
   - Verify all sections are complete

2. **Validate content:**
   - Highlights section populated
   - Features documented
   - Statistics accurate
   - Compare link correct

**Updates:**

```markdown
# Before
**Release Date:** 2025-12-XX
**Status:** 🔴 Draft - Needs Review

# After
**Release Date:** 2025-12-11
**Status:** ✅ Final
```

**Checklist:**

- [ ] Release date set
- [ ] Status updated to Final
- [ ] All sections complete
- [ ] Links valid

---

### 4. Scan Version References

**Scan files for version strings:**

```bash
# Files to scan
grep -r "v1\.3\.0" --include="*.md" --include="*.sh" --include="*.json"
```

**Common locations:**

| File | Field | Action |
|------|-------|--------|
| `README.md` | Version badge, examples | Update if present |
| `package.json` | `version` field | Update if present |
| `scripts/*.sh` | Version variables | Review |
| `.cursor/rules/*.mdc` | Project state | Update |

**Report findings:**

```markdown
## Version Reference Scan

### Files with v1.3.0 references:
- `README.md:15` - Version badge → Update to v1.4.0
- `.cursor/rules/main.mdc:363` - Project state → Update to v1.4.0

### Recommended updates:
1. Update README.md version badge
2. Update main.mdc project state
```

**Checklist:**

- [ ] Version references scanned
- [ ] Files needing update identified
- [ ] Updates applied (or documented for manual)

---

### 5. Update Readiness Checklist

**Update RELEASE-READINESS.md:**

Add or update preparation checklist:

```markdown
## 📋 Preparation Checklist

- [x] Assessment generated (`/release-prep`)
- [x] CHANGELOG draft created (`/release-prep`)
- [x] Release notes draft created (`/release-prep`)
- [x] CHANGELOG finalized (`/release-finalize`) ◄── NEW
- [x] Release notes finalized (`/release-finalize`) ◄── NEW
- [x] Version references updated (`/release-finalize`) ◄── NEW
- [ ] Release branch created
- [ ] External review completed
- [ ] Merged to main
- [ ] Tagged v1.4.0
```

**Update status:**

```markdown
# Before
**Status:** 🟡 REVIEW NEEDED (preparation in progress)

# After
**Status:** 🟢 READY FOR RELEASE BRANCH
```

**Checklist:**

- [ ] Checklist items updated
- [ ] Status updated
- [ ] Date updated

---

### 6. Create Release Branch (if needed)

**Check if release branch exists:**

```bash
git branch -a | grep "release/v1.4.0"
```

**If not exists and `--skip-branch` not set:**

**Dev-Infra (with script):**
```bash
./scripts/create-release-branch.sh v1.4.0
```

**Manual:**
```bash
git checkout develop
git pull origin develop
git checkout -b release/v1.4.0
```

**Commit finalized documents:**

```bash
git add CHANGELOG.md
git add admin/planning/releases/v1.4.0/
git commit -m "docs(release): finalize v1.4.0 release documents

- Merged CHANGELOG draft into CHANGELOG.md
- Finalized release notes
- Updated version references
- Updated release readiness checklist

Generated by /release-finalize v1.4.0"
```

**Checklist:**

- [ ] Release branch created (or skipped)
- [ ] Documents committed
- [ ] Branch pushed

---

### 7. Generate Summary Report

**Present to user:**

```markdown
## ✅ Release Finalization Complete

**Version:** v1.4.0
**Date:** 2025-12-11

### Changes Made

| Action | Status |
|--------|--------|
| CHANGELOG merged | ✅ Done |
| Release notes finalized | ✅ Done |
| Version references | ✅ 2 files updated |
| Readiness checklist | ✅ Updated |
| Release branch | ✅ Created |

### Files Modified

- `CHANGELOG.md` - Added v1.4.0 section
- `admin/planning/releases/v1.4.0/RELEASE-NOTES.md` - Status: Final
- `admin/planning/releases/v1.4.0/RELEASE-READINESS.md` - Checklist updated
- [Other files with version updates]

### Next Steps

1. Review changes on release branch
2. Run `/pr --release` to create PR to main
3. Get external review
4. Merge and tag v1.4.0
```

---

## Common Scenarios

### Scenario 1: Standard Finalization

**Situation:** Drafts reviewed, ready to finalize

**Action:**
```bash
/release-finalize v1.4.0
```

**Result:**
- CHANGELOG merged
- Release notes finalized
- Branch created with all changes

---

### Scenario 2: CHANGELOG Only

**Situation:** Only need to merge CHANGELOG

**Action:**
```bash
/release-finalize v1.4.0 --changelog-only
```

**Result:**
- Only CHANGELOG.md updated
- Other documents unchanged

---

### Scenario 3: Dry Run

**Situation:** Preview changes before applying

**Action:**
```bash
/release-finalize v1.4.0 --dry-run
```

**Result:**
- Shows all changes that would be made
- No files modified

---

### Scenario 4: Custom Release Date

**Situation:** Release scheduled for future date

**Action:**
```bash
/release-finalize v1.4.0 --date 2025-12-15
```

**Result:**
- All date fields set to 2025-12-15

---

## Integration with Other Commands

### Release Workflow

```
/release-prep v1.4.0
    │
    ├── Creates drafts
    │
    ▼
(Manual Review)
    │
    ▼
/release-finalize v1.4.0    ◄── This command
    │
    ├── Merges CHANGELOG
    ├── Finalizes notes
    ├── Updates versions
    └── Creates branch
         │
         ▼
/pr --release
    │
    └── Creates PR to main
         │
         ▼
/post-release v1.4.0
    │
    └── Post-release cleanup
```

---

## Tips

### Before Running

- Review CHANGELOG-DRAFT.md for accuracy
- Review RELEASE-NOTES.md for completeness
- Ensure all PRs are merged to develop

### During Finalization

- Check version reference scan results
- Verify date is correct
- Review generated diffs

### After Finalization

- Review release branch changes
- Test any affected scripts
- Get team review if applicable

---

## Reference

**Input Files:**

- `admin/planning/releases/[version]/CHANGELOG-DRAFT.md`
- `admin/planning/releases/[version]/RELEASE-NOTES.md`
- `admin/planning/releases/[version]/RELEASE-READINESS.md`

**Output Files:**

- `CHANGELOG.md` (root)
- Updated release notes
- Updated readiness checklist

**Scripts:**

- `scripts/create-release-branch.sh` - Branch creation helper

**Related Commands:**

- `/release-prep` - Generate draft documents
- `/pr --release` - Create release PR
- `/post-release` - Post-release cleanup

---

**Last Updated:** 2025-12-11  
**Status:** ✅ Active  
**Next:** Use after `/release-prep` to finalize release documents

