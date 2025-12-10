# Address Review Command Creation

**Date:** 2025-12-10  
**Branch:** `docs/address-review-command`  
**Status:** ✅ Applied to develop  
**Commands Affected:** `address-review` (NEW), `task-phase` (MODIFIED)  
**Priority:** MEDIUM

---

## 📋 Summary

Created new `/address-review` command to address pre-phase review gaps separately from implementation. Updated `/task-phase` to remove `--from-review` option and reference the new command instead.

**Rationale:** Keeping planning/documentation updates separate from implementation follows the single responsibility principle and makes the workflow clearer.

---

## 🔄 Changes Made

### 1. New Command: `/address-review`

**Location:** `.cursor/commands/address-review.md`

**Purpose:** Address gaps identified in pre-phase review documents without starting implementation.

**Key Features:**
- Loads pre-phase review document
- Parses blockers, action items, recommendations
- Applies recommended updates to phase document
- Marks review items as addressed
- Updates review status to "Ready"
- Commits changes to develop (docs-only workflow)

**Usage:**
```bash
/address-review phase-5-review.md
/address-review --phase 5 --feature release-readiness
/address-review phase-5-review.md --dry-run
```

### 2. Modified Command: `/task-phase`

**Changes:**
- **REMOVED:** `--from-review [path]` option
- **REMOVED:** "Pre-Implementation Review Integration" section
- **ADDED:** "Pre-Phase Review Workflow" section (simplified reference)
- **ADDED:** Reference to `/address-review` in related commands
- **UPDATED:** Examples section (removed --from-review example)

**New Workflow Section:**
```markdown
## Pre-Phase Review Workflow

1. /pre-phase-review [N]     → Identifies gaps
2. /address-review [path]    → Addresses gaps
3. /task-phase [N] [task]    → Implements work
```

---

## 🎯 Impact

### Workflow Improvement

**Before (single command did both):**
```
/task-phase --from-review → Updates docs AND implements
```

**After (separation of concerns):**
```
/address-review           → Updates docs only
/task-phase               → Implements only
```

### Benefits

- **Single Responsibility:** Each command does one thing well
- **Clearer Workflow:** Explicit steps (review → address → implement)
- **Better Control:** Can address gaps without starting implementation
- **Audit Trail:** Clear separation of planning vs coding commits

---

## 🔗 Related

- **Previous Update:** 2025-12-10-task-phase-review-integration.md (superseded)
- **Phase 5 Review:** Used as example for workflow design

---

## 📊 Files Modified

| File | Change |
|------|--------|
| `.cursor/commands/address-review.md` | NEW - Complete command documentation |
| `.cursor/commands/task-phase.md` | MODIFIED - Removed --from-review, added reference |

---

**Created:** 2025-12-10  
**Author:** AI Assistant

