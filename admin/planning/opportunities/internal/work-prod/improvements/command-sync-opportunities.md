# Command Sync Opportunities - Work-Prod

**Source:** Dev-infra v1.6.0  
**Target:** Work-prod project  
**Status:** ✅ Complete  
**Created:** 2025-12-15  
**Last Updated:** 2025-12-15

---

## 📋 Overview

This document outlines actionable improvements to sync commands from dev-infra to work-prod.

---

## 🎯 Category 1: New Commands to Add

### High Priority

- [ ] **Add `/decision` command**
  - **Source:** `templates/standard-project/.cursor/commands/decision.md`
  - **Target:** `~/Projects/work-prod/.cursor/commands/decision.md`
  - **Action:** Copy from standard template
  - **Purpose:** Create ADR documents for architecture decisions
  - **Priority:** HIGH
  - **Effort:** LOW (just copy)

- [ ] **Add `/explore` command**
  - **Source:** `templates/standard-project/.cursor/commands/explore.md`
  - **Target:** `~/Projects/work-prod/.cursor/commands/explore.md`
  - **Action:** Copy from standard template
  - **Purpose:** Start exploration workflow for new ideas
  - **Priority:** HIGH
  - **Effort:** LOW (just copy)

- [ ] **Add `/research` command**
  - **Source:** `templates/standard-project/.cursor/commands/research.md`
  - **Target:** `~/Projects/work-prod/.cursor/commands/research.md`
  - **Action:** Copy from standard template
  - **Purpose:** Research workflow for investigation
  - **Priority:** HIGH
  - **Effort:** LOW (just copy)

- [ ] **Add `/task-improvement` command**
  - **Source:** `templates/standard-project/.cursor/commands/task-improvement.md`
  - **Target:** `~/Projects/work-prod/.cursor/commands/task-improvement.md`
  - **Action:** Copy from standard template
  - **Purpose:** CI/CD improvement implementation
  - **Priority:** HIGH
  - **Effort:** LOW (just copy)

### Medium Priority

- [ ] **Consider `/status` command**
  - **Source:** `templates/experimental-project/.cursor/commands/status.md`
  - **Target:** `~/Projects/work-prod/.cursor/commands/status.md`
  - **Action:** Evaluate if useful for work-prod
  - **Purpose:** Centralized status tracking (Evolving tier)
  - **Priority:** MEDIUM
  - **Effort:** LOW (just copy, but evaluate first)
  - **Note:** This is an "Evolving" command - may change

---

## 🎯 Category 2: Commands to Update

These commands exist in work-prod but may need updates from dev-infra:

### High Impact Updates

- [ ] **Update `/pr-validation`**
  - **Change:** Manual testing guide enforcement
  - **Impact:** Better PR reviews with human-readable testing guides
  - **Source:** `.cursor/commands/pr-validation.md` (dev-infra)
  - **Action:** Compare and merge changes
  - **Priority:** HIGH
  - **Effort:** MEDIUM (need to merge, not just copy)

- [ ] **Update `/transition-plan`**
  - **Change:** TDD task ordering guidance
  - **Impact:** Better phase planning with proper task order
  - **Source:** `.cursor/commands/transition-plan.md` (dev-infra)
  - **Action:** Compare and merge changes
  - **Priority:** HIGH
  - **Effort:** MEDIUM

- [ ] **Update `/task-phase`**
  - **Change:** Branch validation, auto-status updates
  - **Impact:** Fewer wrong-branch commits
  - **Source:** `.cursor/commands/task-phase.md` (dev-infra)
  - **Action:** Compare and merge changes
  - **Priority:** HIGH
  - **Effort:** MEDIUM

- [ ] **Update `/pr`**
  - **Change:** Branch detection, worktree awareness
  - **Impact:** Fewer PR creation errors
  - **Source:** `.cursor/commands/pr.md` (dev-infra)
  - **Action:** Compare and merge changes
  - **Priority:** HIGH
  - **Effort:** MEDIUM

### Medium Impact Updates

- [ ] **Update `/fix-implement`**
  - **Change:** PR status check before deciding workflow
  - **Impact:** Correct fix workflow (push to existing PR vs create new)
  - **Source:** `.cursor/commands/fix-implement.md` (dev-infra)
  - **Action:** Compare and merge changes
  - **Priority:** MEDIUM
  - **Effort:** MEDIUM

- [ ] **Update `/reflect`**
  - **Change:** Centralized reflection location
  - **Impact:** Better reflection organization
  - **Source:** `.cursor/commands/reflect.md` (dev-infra)
  - **Action:** Compare and merge changes
  - **Priority:** MEDIUM
  - **Effort:** LOW

---

## 🎯 Category 3: Commands NOT to Sync

These are dev-infra internal tooling and should NOT be synced:

| Command | Reason |
|---------|--------|
| `/address-review` | Dev-infra planning workflow only |
| `/post-release` | Dev-infra release process only |
| `/release-finalize` | Dev-infra release process only |
| `/release-prep` | Dev-infra release process only |

---

## 📋 Implementation Plan

### Phase 1: Add Missing Commands (Quick Wins)

```bash
# From dev-infra directory
cd ~/Projects/dev-infra

# Copy new commands from standard template
cp templates/standard-project/.cursor/commands/decision.md ~/Projects/work-prod/.cursor/commands/
cp templates/standard-project/.cursor/commands/explore.md ~/Projects/work-prod/.cursor/commands/
cp templates/standard-project/.cursor/commands/research.md ~/Projects/work-prod/.cursor/commands/
cp templates/standard-project/.cursor/commands/task-improvement.md ~/Projects/work-prod/.cursor/commands/
```

**Estimated time:** 5 minutes

### Phase 2: Update Existing Commands

For each command to update:

1. **Compare files:**
   ```bash
   diff ~/Projects/dev-infra/.cursor/commands/[cmd].md ~/Projects/work-prod/.cursor/commands/[cmd].md
   ```

2. **Identify changes:**
   - New sections added
   - Workflow changes
   - Path changes (adjust for work-prod structure)

3. **Merge changes:**
   - Keep work-prod specific paths
   - Add new workflow improvements
   - Update date and status

**Estimated time:** 30-60 minutes

### Phase 3: Evaluate Evolving Commands

1. Review `/status` command
2. Decide if useful for work-prod
3. If yes, copy from experimental template

**Estimated time:** 10 minutes

---

## ✅ Definition of Done

- [ ] All high-priority commands added
- [ ] All high-impact updates merged
- [ ] Commands tested in work-prod context
- [ ] Documentation updated

---

## 📊 Summary

| Category | Count | Effort |
|----------|-------|--------|
| New commands to add | 4-5 | LOW |
| Commands to update | 6 | MEDIUM |
| Commands NOT to sync | 4 | N/A |

**Total estimated time:** 1-2 hours

---

**Last Updated:** 2025-12-15

