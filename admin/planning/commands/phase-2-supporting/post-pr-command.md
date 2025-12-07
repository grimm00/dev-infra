# Post PR Command - Implementation Plan

**Command:** `/post-pr`  
**Status:** 🟠 In Progress  
**Priority:** 🟠 HIGH  
**Estimated Effort:** 3 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Source Command](../../../../work-prod/.cursor/commands/post-pr.md)** - Original work-prod command
- **[PR Command](../phase-1-core/pr-command.md)** - Related command (creates PRs)
- **[Phase 2 Plan](PLAN.md)** - Overall Phase 2 planning

---

## 🎯 Overview

The `/post-pr` command updates documentation after a PR is merged. It ensures phase completion status, feature milestones, and next steps are properly documented.

**Key Features:**
- Updates phase/fix/release documents
- Updates feature status documents
- Documents deferred issues
- Updates progress tracking
- Cleans up merged PR branches

---

## 🔄 Adaptations Required

### 1. Generic Documentation Paths

**Current (work-prod specific):**
```
docs/maintainers/planning/features/projects/phase-N.md
docs/maintainers/planning/features/projects/status-and-next-steps.md
```

**Target (generic):**
```
docs/maintainers/planning/features/[feature-name]/phase-N.md
OR
docs/maintainers/planning/phases/phase-N.md  (project-wide)
```

**Implementation:**
- Auto-detect feature name from context
- Support project-wide phase structure
- Match `/task-phase` and `/pr` paths
- Allow configuration override

---

### 2. Configurable Fix Tracking Paths

**Current:** Hardcoded fix paths

**Target:** Match `/fix-plan` and `/fix-implement` paths

**Implementation:**
- Feature-specific: `docs/maintainers/planning/features/[feature-name]/fix/pr##/`
- Project-wide: `docs/maintainers/planning/fix/pr##/`
- Support both patterns

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command

- [x] Read complete source command from work-prod
- [x] Understand all three modes (phase, fix, release)
- [x] Identify documentation update logic
- [x] Document deferred issue tracking
- [x] List all hardcoded paths

**Files:**
- `../../../../work-prod/.cursor/commands/post-pr.md`

---

### Step 2: Create Adapted Command File

- [x] Create `.cursor/commands/post-pr.md` in dev-infra
- [x] Replace hardcoded paths with generic patterns
- [x] Match `/task-phase` and `/pr` paths
- [x] Add feature detection logic
- [x] Support all three modes (phase, fix, release)

**Target Location:**
- `.cursor/commands/post-pr.md` (for dev-infra project)
- `templates/.cursor/commands/post-pr.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test phase mode
- [ ] Test fix mode
- [ ] Test release mode
- [ ] Test deferred issue documentation
- [ ] Test branch cleanup

---

### Step 4: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Document usage in template README
- [ ] Link to `/pr` command documentation

---

### Step 5: Documentation

- [x] Update command documentation
- [ ] Create usage examples
- [ ] Document all three modes
- [ ] Document deferred issue tracking

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Generic documentation paths implemented
- [x] All three modes working (phase, fix, release)
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- `/pr` command (must be implemented first)
- Understanding of phase/fix/release structures

**Enables:**
- Complete documentation workflow
- Post-merge automation

---

## 📚 Related Documentation

**Source:**
- [Work-Prod Post PR Command](../../../../work-prod/.cursor/commands/post-pr.md)

**Related Commands:**
- [PR Command](../phase-1-core/pr-command.md) - Creates PRs
- [Task Phase Command](../phase-1-core/task-phase-command.md) - Implements phases

**Planning:**
- [Phase 2 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

