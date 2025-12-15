# Template Synchronization Guide

**Purpose:** Define shared file categories and sync requirements between `standard-project` and `experimental-project` templates  
**Status:** ✅ Active  
**Created:** 2025-12-15  
**Last Updated:** 2025-12-15

---

## 📋 Overview

The `standard-project` and `experimental-project` templates share common files that must stay in sync. This document defines which files are shared (must be identical) versus experimental-only (different by design).

**Sync Strategy:** Manual sync with CI-based drift detection to ensure consistency.

---

## 📊 Shared File Categories

### ✅ Must Be Identical (Shared Files)

These files and directories must be identical between both templates:

| Category | Examples | Sync Required | Notes |
|----------|----------|---------------|-------|
| **Infrastructure** | `.gitignore`, `.dockerignore` | ✅ Yes | Core project configuration |
| **CI Workflows** | `.github/workflows/ci.yml` | ✅ Yes | CI/CD configuration |
| **Core Structure** | `backend/`, `frontend/`, `tests/`, `scripts/` | ✅ Yes | Project structure directories |
| **Stable Commands** | `.cursor/commands/[essential/valuable/advanced]` | ✅ Yes | All commands except Evolving tier |
| **Documentation Structure** | `docs/maintainers/` | ✅ Yes | Planning, research, decision docs |
| **Template Config** | `.cursor/rules/` | ✅ Yes | Cursor rules configuration |

### ❌ Different by Design (Experimental-Only)

These files are intentionally different or experimental-only:

| Category | Examples | Sync Required | Notes |
|----------|----------|---------------|-------|
| **Evolving Commands** | `.cursor/commands/status.md` | ❌ No | Experimental template only |
| **Template Identity** | `README.md` (stability section) | ❌ No | Different disclaimers |
| **Template Identity** | `start.txt` | ❌ No | May reference experimental nature |
| **Experimental Docs** | `docs/EXPERIMENTAL.md` | ❌ No | Experimental template only |

---

## 🔍 Detailed File Analysis

### Shared Commands (18 commands)

All commands in `.cursor/commands/` are shared **except** Evolving tier commands:

**Shared Commands:**
- `cursor-rules.md`
- `decision.md`
- `explore.md`
- `fix-implement.md`
- `fix-plan.md`
- `fix-review.md`
- `int-opp.md`
- `post-pr.md`
- `pre-phase-review.md`
- `pr-validation.md`
- `pr.md`
- `reflect.md`
- `reflection-artifacts.md`
- `research.md`
- `task-improvement.md`
- `task-phase.md`
- `task-release.md`
- `transition-plan.md`

**Experimental-Only Commands:**
- `status.md` (Evolving tier)

### Shared Directories

**Must be identical:**
- `backend/` - Backend application structure
- `frontend/` - Frontend application structure
- `tests/` - Test structure and helpers
- `scripts/` - Automation scripts
- `docs/maintainers/` - Planning, research, decision documentation structure
- `.cursor/rules/` - Cursor rules configuration

### Shared Files

**Must be identical:**
- `.gitignore` - Git ignore patterns
- `.dockerignore` - Docker ignore patterns
- `.github/workflows/ci.yml` - CI workflow configuration

### Different Files

**Intentionally different:**
- `README.md` - Contains template-specific stability disclaimers
- `start.txt` - May reference experimental nature
- `docs/EXPERIMENTAL.md` - Only exists in experimental template

---

## 🔄 Sync Process

### How Sync Works

1. **Manual Sync:** When updating shared files in `standard-project`, manually copy to `experimental-project`
2. **CI Validation:** CI runs `validate-template-sync.sh` on every PR
3. **Drift Detection:** Script compares shared files and fails if differences found
4. **Fix Drift:** Copy correct file from source template to fix drift

### Adding New Shared Files

When adding a new shared file:

1. Add file to `standard-project` template
2. Copy file to `experimental-project` template
3. Add file path to `scripts/template-sync-manifest.txt`
4. CI will enforce sync going forward

### Adding New Experimental-Only Files

When adding experimental-only files:

1. Add file to `experimental-project` template only
2. Do NOT add to manifest (script ignores files not in manifest)
3. Document in this guide if it's a new category

---

## 📝 Manifest File Format

The `scripts/template-sync-manifest.txt` file lists all shared files:

```
# Files that must be identical between standard and experimental templates
# Lines starting with # are comments
# Use relative paths from template root

.gitignore
.dockerignore
.github/workflows/ci.yml
backend/
frontend/
tests/
scripts/
docs/maintainers/
.cursor/rules/
.cursor/commands/cursor-rules.md
.cursor/commands/decision.md
# ... (all shared commands)
```

---

## 🚨 Common Drift Scenarios

### Scenario 1: Infrastructure File Updated

**Problem:** `.gitignore` updated in `standard-project` but not `experimental-project`

**Solution:**
1. Copy `.gitignore` from `standard-project` to `experimental-project`
2. Commit the sync
3. CI will validate sync

### Scenario 2: New Shared Command Added

**Problem:** New stable command added to `standard-project` but missing in `experimental-project`

**Solution:**
1. Copy command file to `experimental-project`
2. Add command path to manifest
3. Commit both changes

### Scenario 3: Shared Directory Structure Changed

**Problem:** `docs/maintainers/` structure updated in one template

**Solution:**
1. Sync entire directory structure
2. Ensure manifest includes directory path
3. Commit sync

---

## 🔗 Related

- **CI Validation:** `scripts/validate-template-sync.sh`
- **Manifest:** `scripts/template-sync-manifest.txt`
- **Phase Plan:** `admin/planning/features/experimental-template/phase-3.md`
- **Feature Hub:** `admin/planning/features/experimental-template/README.md`

---

**Last Updated:** 2025-12-15

