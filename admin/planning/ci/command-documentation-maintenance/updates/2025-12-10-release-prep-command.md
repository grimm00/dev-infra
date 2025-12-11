# Command Update: Release Prep Command

**Date:** 2025-12-10  
**Branch:** `docs/release-prep-command`  
**Status:** ✅ Applied to develop  
**Priority:** 🟡 MEDIUM

---

## 📋 Overview

Created new `/release-prep` command to orchestrate release preparation workflow.

---

## 🔄 Changes Made

### Commands Affected

| Command | Change Type | Description |
|---------|-------------|-------------|
| `release-prep` | **NEW** | Orchestrates release preparation |

### New Command: `/release-prep`

**Purpose:** Automate and orchestrate the release preparation process.

**Functionality:**

1. **Run Readiness Check** - Execute `check-release-readiness.sh`
2. **Generate Assessment** - Create RELEASE-READINESS.md with YAML frontmatter
3. **Create CHANGELOG Draft** - Gather changes since last release
4. **Create Release Notes Draft** - Generate release notes template
5. **Create Release Branch** - Optionally create release/vX.Y.Z branch

**Options:**

| Flag | Purpose |
|------|---------|
| `--dry-run` | Show what would be done |
| `--skip-branch` | Skip branch creation |
| `--assessment-only` | Only generate assessment |
| `--force` | Continue despite blocking issues |
| `--verbose` | Detailed output |

**Usage Examples:**

```bash
/release-prep v1.4.0                    # Full preparation
/release-prep v1.4.0 --dry-run          # Preview mode
/release-prep v1.4.0 --assessment-only  # Assessment only
/release-prep v1.4.0 --skip-branch      # No branch creation
```

---

## 🎯 Impact

### Workflow Integration

**Before:** Manual release preparation
```
1. Run check-release-readiness.sh
2. Manually create CHANGELOG draft
3. Manually create release notes
4. Manually create release branch
5. Manually commit everything
```

**After:** Single command orchestration
```
/release-prep v1.4.0
  → All steps automated
  → Consistent document generation
  → Integrated with other release commands
```

### Command Workflow Position

```
Feature Complete
      │
      ▼
/release-prep v1.4.0      ◄── NEW
      │
      ▼
/task-release v1.4.0
      │
      ▼
/pr --release
      │
      ▼
Merge & Tag
```

---

## 📚 Root Cause

**Why this command was needed:**

1. **Manual Process:** Release preparation was a multi-step manual process
2. **Inconsistency:** Document generation varied between releases
3. **Tool Fragmentation:** Scripts existed but weren't orchestrated
4. **Workflow Gap:** No command covered the "prepare for release" step

**User Feedback:**

- "How should we handle our release planning?"
- "Should we have a command/workflow for this?"
- Tools exist (scripts) but need orchestration layer

---

## 🔗 Related

### Related Commands

- `/task-release` - Implements release tasks (uses documents created by `/release-prep`)
- `/pr --release` - Creates release PR (validates readiness)
- `/transition-plan --type release` - Creates transition planning documents

### Related Scripts

- `scripts/check-release-readiness.sh` - Assessment and validation
- `scripts/create-release-branch.sh` - Branch creation helper
- `scripts/analyze-releases.sh` - Historical analysis

### Related Documentation

- Release process: `admin/planning/releases/PROCESS.md`
- Standard criteria: `admin/planning/releases/standard-criteria.md`
- Transition plan: `admin/planning/releases/v1.4.0/transition-plan.md`

---

## ✅ Verification

**Command created:**
- [x] `.cursor/commands/release-prep.md` created
- [x] All sections documented
- [x] Options documented
- [x] Integration with other commands documented

**Tracking updated:**
- [x] This tracking document created
- [x] README.md updated with entry

---

**Last Updated:** 2025-12-10

