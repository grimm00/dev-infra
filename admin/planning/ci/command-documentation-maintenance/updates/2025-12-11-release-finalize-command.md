# Command Update: Release Finalize Command

**Date:** 2025-12-11  
**Branch:** `docs/release-commands`  
**Status:** ✅ Applied to develop  
**Priority:** 🟡 MEDIUM

---

## 📋 Overview

Created new `/release-finalize` command to bridge the gap between draft generation and release PR creation.

---

## 🔄 Changes Made

### Commands Affected

| Command | Change Type | Description |
|---------|-------------|-------------|
| `release-finalize` | **NEW** | Finalize release documents |

### New Command: `/release-finalize`

**Purpose:** Finalize release preparation by merging drafts and updating documentation.

**Functionality:**

1. **Merge CHANGELOG Draft** - Insert draft into CHANGELOG.md
2. **Finalize Release Notes** - Update status and date
3. **Scan Version References** - Find files needing version updates
4. **Update Readiness Checklist** - Mark preparation steps complete
5. **Create Release Branch** - If not already exists

**Options:**

| Flag | Purpose |
|------|---------|
| `--dry-run` | Preview changes |
| `--changelog-only` | Only merge CHANGELOG |
| `--skip-branch` | Skip branch creation |
| `--date YYYY-MM-DD` | Set release date |
| `--force` | Continue with warnings |

**Usage Examples:**

```bash
/release-finalize v0.4.0                    # Full finalization
/release-finalize v0.4.0 --dry-run          # Preview mode
/release-finalize v0.4.0 --changelog-only   # CHANGELOG only
/release-finalize v0.4.0 --date 2025-12-15  # Set date
```

---

## 🎯 Impact

### Workflow Integration

**Gap Filled:**
```
/release-prep v0.4.0
      │
      ▼
(Review Drafts - manual)
      │
      ▼
/release-finalize v0.4.0    ◄── NEW (fills gap)
      │
      ▼
/pr --release
```

**Before:** Manual CHANGELOG merge, manual status updates  
**After:** Automated finalization with validation

### Benefits

- Consistent CHANGELOG formatting
- Automated date replacement
- Version reference scanning
- Checklist tracking
- Single command for finalization

---

## 📚 Root Cause

**Why this command was needed:**

1. **Manual CHANGELOG Merge** - `/release-prep` created draft but merge was manual
2. **Status Tracking Gap** - No automated way to update checklist
3. **Version Reference Updates** - No systematic scan for version strings
4. **Workflow Continuity** - Gap between prep and PR creation

**User Feedback:**
- "Is there anything more we can do to guide AI through this process?"
- "Do commands need more inputs related to releases?"

---

## 🔗 Related

### Related Commands

- `/release-prep` - Creates draft documents (predecessor)
- `/pr --release` - Creates release PR (successor)
- `/post-release` - Post-release cleanup (also created)

### Related Files

- `CHANGELOG.md` - Target for merge
- `admin/planning/releases/[version]/CHANGELOG-DRAFT.md` - Source
- `admin/planning/releases/[version]/RELEASE-READINESS.md` - Checklist updates

---

## ✅ Verification

**Command created:**
- [x] `.cursor/commands/release-finalize.md` created
- [x] All sections documented
- [x] Options documented
- [x] Integration with workflow documented

**Tracking updated:**
- [x] This tracking document created
- [x] README.md updated with entry

---

**Last Updated:** 2025-12-11

