# Template Synchronization

**Purpose:** Document sync requirements and process for shared template files  
**Status:** ✅ Active  
**Last Updated:** 2025-12-17

---

## 📋 Overview

The `standard-project` and `learning-project` templates share common files that must stay in sync. This document explains the sync requirements, process, and how to handle drift.

**Why Sync Matters:**
- Ensures consistent command set across templates
- Prevents divergence of core features
- Reduces maintenance burden
- All templates get all commands

---

## 📁 Shared File Categories

| Category | Files | Sync Requirement |
|----------|-------|------------------|
| **Commands** | `.cursor/commands/*.md` (all 19) | Must be identical |

### Intentionally Different Files

These files are **excluded** from sync and allowed to differ:

| File | Reason |
|------|--------|
| `README.md` | Different project type descriptions |
| `start.txt` | Different initialization guidance |
| `.gitignore` | Different ignore patterns per template |
| `docs/` structure | Learning has stages, standard has backend/frontend |

---

## 🔧 How Sync Works

### CI Validation

1. CI runs `validate-template-sync.sh` on every PR
2. Script reads `scripts/template-sync-manifest.txt` for shared files
3. Compares files between `standard-project` and `learning-project`
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
#   - .cursor/commands/status.md (content differs)
```

### Manifest File

The manifest (`scripts/template-sync-manifest.txt`) defines which files must stay in sync:

```txt
# Files that must be identical between standard-project and learning-project templates
# Lines starting with # are comments
# Use relative paths from template root

# All commands (19 total)
.cursor/commands/cursor-rules.md
.cursor/commands/decision.md
.cursor/commands/status.md
...
```

---

## 🔄 Fixing Drift

When drift is detected, follow these steps:

### Step 1: Identify Source of Truth

**Usually `standard-project`** is the source of truth because:
- Core functionality originates there
- Learning template extends standard with educational structure

### Step 2: Copy Files

```bash
# Example: Sync command from standard to learning
cp templates/standard-project/.cursor/commands/status.md templates/learning-project/.cursor/commands/status.md
```

### Step 3: Commit the Sync

```bash
git add templates/
git commit -m "chore: sync templates (status.md)"
```

### Step 4: Verify

```bash
./scripts/validate-template-sync.sh
# Should show: ✅ Template sync validation PASSED
```

---

## ➕ Adding New Commands

When adding a new command that should be in all templates:

### Step 1: Add to Both Templates

```bash
# Create the command in standard-project first
echo "content" > templates/standard-project/.cursor/commands/new-command.md

# Copy to learning-project
cp templates/standard-project/.cursor/commands/new-command.md templates/learning-project/.cursor/commands/new-command.md
```

### Step 2: Update Manifest

Add the file to `scripts/template-sync-manifest.txt`:

```txt
# Add under commands section
.cursor/commands/new-command.md
```

### Step 3: Verify

```bash
./scripts/validate-template-sync.sh
# Ensures both templates have the file and they're identical
```

---

## 📊 Sync Workflow Diagram

```
Developer makes change to standard-project command
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
│ learning       │  │ standard       │
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

### Issue: New Command Not Being Checked

**Cause:** File not added to manifest.

**Solution:** Add the file path to `scripts/template-sync-manifest.txt`

---

## 🔗 Related Documents

- **Template Usage:** [docs/TEMPLATE-USAGE.md](TEMPLATE-USAGE.md)
- **Project Types:** [docs/PROJECT-TYPES.md](PROJECT-TYPES.md)
- **ADR-001: Commands as Guides:** [admin/decisions/command-simplification/adr-001-commands-as-guides.md](../admin/decisions/command-simplification/adr-001-commands-as-guides.md)

---

**Last Updated:** 2025-12-17
