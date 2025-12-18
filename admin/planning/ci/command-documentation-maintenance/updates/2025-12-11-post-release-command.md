# Command Update: Post Release Command

**Date:** 2025-12-11  
**Branch:** `docs/release-commands`  
**Status:** ✅ Applied to develop  
**Priority:** 🟡 MEDIUM

---

## 📋 Overview

Created new `/post-release` command to handle post-release tasks and complete the release cycle.

---

## 🔄 Changes Made

### Commands Affected

| Command | Change Type | Description |
|---------|-------------|-------------|
| `post-release` | **NEW** | Post-release cleanup and tracking |

### New Command: `/post-release`

**Purpose:** Complete the release cycle with cleanup, tracking, and preparation for next iteration.

**Functionality:**

1. **Merge Main to Develop** - Ensure develop has all release changes
2. **Update Historical Tracking** - Run `analyze-releases.sh`
3. **Archive Release Documents** - Update status to "Released"
4. **Clean Up Release Branch** - Delete local and remote branch
5. **Create Retrospective** - Optional release retrospective document
6. **Update Project State** - Update cursor rules and README

**Options:**

| Flag | Purpose |
|------|---------|
| `--dry-run` | Preview changes |
| `--skip-retrospective` | Skip retrospective creation |
| `--keep-branch` | Don't delete release branch |
| `--skip-archive` | Skip archiving documents |
| `--force` | Continue with warnings |

**Usage Examples:**

```bash
/post-release v0.4.0                      # Full post-release
/post-release v0.4.0 --dry-run            # Preview mode
/post-release v0.4.0 --skip-retrospective # No retrospective
/post-release v0.4.0 --keep-branch        # Keep branch
```

---

## 🎯 Impact

### Workflow Integration

**Completes Release Cycle:**
```
/release-prep v0.4.0
      │
      ▼
/release-finalize v0.4.0
      │
      ▼
/pr --release
      │
      ▼
(Merge & Tag)
      │
      ▼
/post-release v0.4.0    ◄── NEW (completes cycle)
      │
      ▼
Ready for v0.5.0
```

**Before:** Manual cleanup, no historical tracking update  
**After:** Automated cleanup with retrospective and tracking

### Benefits

- Consistent post-release process
- Historical tracking maintained
- Clean branch management
- Retrospective for continuous improvement
- Ready for next development cycle

---

## 📚 Root Cause

**Why this command was needed:**

1. **No Post-Release Workflow** - Release cycle ended at merge/tag
2. **Manual Cleanup** - Branch deletion was manual
3. **Historical Tracking** - `analyze-releases.sh` not integrated
4. **No Retrospective** - No structured way to capture learnings

**User Feedback:**
- "Is there anything more we can do to guide AI through this process?"
- Analysis identified missing post-release command

---

## 🔗 Related

### Related Commands

- `/release-finalize` - Finalize documents (predecessor)
- `/pr --release` - Creates release PR (predecessor)
- `/release-prep` - Prepare documents (earlier in workflow)
- `/reflect` - Can use after post-release for learnings

### Related Scripts

- `scripts/analyze-releases.sh` - Historical analysis

### Related Files

- `admin/planning/releases/[version]/retrospective.md` - Created by command
- `admin/planning/releases/history/index.md` - Updated by command

---

## ✅ Verification

**Command created:**
- [x] `.cursor/commands/post-release.md` created
- [x] All sections documented
- [x] Options documented
- [x] Integration with workflow documented

**Tracking updated:**
- [x] This tracking document created
- [x] README.md updated with entry

---

**Last Updated:** 2025-12-11

