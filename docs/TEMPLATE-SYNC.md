# Template Synchronization

**Purpose:** Document sync requirements and process for shared template files  
**Status:** ✅ Active  
**Last Updated:** 2025-12-15

---

## 📋 Overview

The `standard-project` and `experimental-project` templates share common files that must stay in sync. This document explains the sync requirements, process, and how to handle drift.

**Why Sync Matters:**
- Ensures consistent base functionality across templates
- Prevents divergence of core features
- Maintains upgrade path from experimental to standard
- Reduces maintenance burden

---

## 📁 Shared File Categories

| Category | Files | Sync Requirement |
|----------|-------|------------------|
| **Infrastructure** | `.gitignore`, `.dockerignore` | Must be identical |
| **CI/CD Workflows** | `.github/workflows/ci.yml` | Must be identical |
| **Core Structure** | `backend/`, `frontend/`, `tests/`, `scripts/` | Must be identical |
| **Maintainer Docs** | `docs/maintainers/` | Must be identical |
| **Stable Commands** | `.cursor/commands/*.md` (Essential, Valuable, Advanced tiers) | Must be identical |

### Intentionally Different Files

These files are **excluded** from sync and allowed to differ:

| File | Reason |
|------|--------|
| `README.md` | Different stability disclaimers |
| `start.txt` | May reference experimental nature |
| `docs/EXPERIMENTAL.md` | Experimental-only documentation |
| `.cursor/commands/status.md` | Evolving tier command (experimental-only) |

---

## 🔧 How Sync Works

### CI Validation

1. CI runs `validate-template-sync.sh` on every PR
2. Script reads `scripts/template-sync-manifest.txt` for shared files
3. Compares files between `standard-project` and `experimental-project`
4. PR **fails** if drift is detected

### Validation Script

```bash
# Run manually to check sync status
./scripts/validate-template-sync.sh

# Output on success:
# ✅ Template sync validation PASSED
# All shared files are in sync

# Output on failure:
# ❌ DRIFT DETECTED in the following files:
#   - .gitignore (content differs)
#   - backend/app.py (missing in experimental)
```

### Manifest File

The manifest (`scripts/template-sync-manifest.txt`) defines which files must stay in sync:

```txt
# Files that must be identical between standard and experimental templates
# Lines starting with # are comments
# Use relative paths from template root
# Directories ending with / will be recursively checked

# Infrastructure files
.gitignore
.dockerignore

# CI/CD workflows
.github/workflows/ci.yml

# Core directories (recursive)
backend/
frontend/
```

---

## 🔄 Fixing Drift

When drift is detected, follow these steps:

### Step 1: Identify Source of Truth

**Usually `standard-project`** is the source of truth because:
- Core functionality originates there
- Experimental extends standard, not replaces it
- Graduation path goes from experimental → standard

**Exception:** If the change was intentionally made to experimental first (e.g., testing a fix), use experimental as source.

### Step 2: Copy Files

```bash
# Example: Sync .gitignore from standard to experimental
cp templates/standard-project/.gitignore templates/experimental-project/.gitignore

# Example: Sync entire directory
cp -r templates/standard-project/backend/ templates/experimental-project/backend/
```

### Step 3: Commit the Sync

```bash
git add templates/
git commit -m "chore: sync templates (.gitignore, backend/)"
```

### Step 4: Verify

```bash
./scripts/validate-template-sync.sh
# Should show: ✅ Template sync validation PASSED
```

---

## ➕ Adding New Shared Files

When adding a file that should be shared between templates:

### Step 1: Add to Both Templates

```bash
# Create the file in standard-project first
echo "content" > templates/standard-project/new-file.txt

# Copy to experimental-project
cp templates/standard-project/new-file.txt templates/experimental-project/new-file.txt
```

### Step 2: Update Manifest

Add the file to `scripts/template-sync-manifest.txt`:

```txt
# Add under appropriate category
new-file.txt
```

### Step 3: Verify

```bash
./scripts/validate-template-sync.sh
# Ensures both templates have the file and they're identical
```

---

## ➖ Removing Shared Files

When removing a file from sync requirements:

### Option A: Remove from Both Templates

```bash
rm templates/standard-project/old-file.txt
rm templates/experimental-project/old-file.txt
# Remove from manifest
```

### Option B: Make Experimental-Only

If the file should only exist in experimental:

1. Remove from `standard-project`
2. Remove from manifest
3. Add to "Intentionally Different" comment section in manifest

---

## 🆕 Adding New Commands

### Stable Commands (Essential, Valuable, Advanced Tiers)

1. Add to **both** templates
2. Add to manifest under "Stable commands"
3. CI enforces sync

### Evolving Commands (Experimental Tier)

1. Add to **experimental-project only**
2. **Do NOT** add to manifest
3. Document in `docs/EXPERIMENTAL.md`
4. After graduation (ADR-004), promote to both templates

---

## 📊 Sync Workflow Diagram

```
Developer makes change to standard-project
         │
         ▼
    ┌─────────────────┐
    │ Is file in      │
    │ manifest?       │
    └────────┬────────┘
             │
    ┌────────┴────────┐
    │ YES             │ NO
    ▼                 ▼
┌────────────────┐  ┌────────────────┐
│ Also change    │  │ Only affects   │
│ experimental   │  │ standard       │
└────────────────┘  └────────────────┘
         │
         ▼
    ┌─────────────────┐
    │ Commit both     │
    │ templates       │
    └─────────────────┘
         │
         ▼
    ┌─────────────────┐
    │ CI validates    │
    │ sync            │
    └─────────────────┘
```

---

## 🚨 Common Issues

### Issue: CI Fails with Drift

**Cause:** A shared file was changed in one template but not the other.

**Solution:**
1. Check which file(s) drifted
2. Determine which version is correct
3. Copy to the other template
4. Commit and push

### Issue: New File Not Being Checked

**Cause:** File not added to manifest.

**Solution:** Add the file path to `scripts/template-sync-manifest.txt`

### Issue: False Positive on Intentionally Different File

**Cause:** File is in manifest but should be different.

**Solution:**
1. Remove from manifest
2. Add to "Intentionally Different" comment section
3. Document why it's different

---

## 🔗 Related Documents

- **Experimental Template Docs:** `docs/EXPERIMENTAL.md` (in experimental-project)
- **Command Tiers:** ADR-003 Command Tiers
- **Graduation Process:** ADR-004 Graduation Process
- **Template Usage:** [docs/TEMPLATE-USAGE.md](TEMPLATE-USAGE.md)

---

**Last Updated:** 2025-12-15
