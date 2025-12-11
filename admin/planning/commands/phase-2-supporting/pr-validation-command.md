# PR Validation Command - Implementation Plan

**Command:** `/pr-validation`  
**Status:** 🟠 In Progress  
**Priority:** 🟡 MEDIUM  
**Estimated Effort:** 4 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Source Command](../../../../work-prod/.cursor/commands/pr-validation.md)** - Original work-prod command
- **[PR Command](../phase-1-core/pr-command.md)** - Related command (creates PRs)
- **[Phase 2 Plan](PLAN.md)** - Overall Phase 2 planning

---

## 🎯 Overview

The `/pr-validation` command validates PRs by running manual testing, updating documentation, and performing code review in one workflow. It integrates Sourcery reviews and manual testing scenarios.

**Key Features:**
- Manual testing guide updates
- Manual testing execution
- Sourcery review integration (if available)
- Priority matrix filling
- PR description updates

---

## 🔄 Adaptations Required

### 1. Generic Manual Testing Paths

**Current (work-prod specific):**
```
docs/maintainers/planning/features/projects/manual-testing.md
```

**Target (generic):**
```
docs/maintainers/planning/features/[feature-name]/manual-testing.md
OR
docs/maintainers/planning/manual-testing.md  (project-wide)
```

**Implementation:**
- Auto-detect feature name from context
- Support project-wide manual testing guide
- Match `/pr` command paths
- Allow configuration override

---

### 2. Project-Agnostic Testing Commands

**Current:** Hardcoded testing commands (pytest, curl, etc.)

**Target:** Configurable testing commands

**Implementation:**
- Support project-specific test commands
- Support project-specific server start commands
- Support project-specific health check commands
- Document common patterns

---

### 3. Optional Sourcery Review

**Current:** Assumes dt-review is always available

**Target:** Handle missing reviews gracefully

**Implementation:**
- Check if dt-review is available
- Continue workflow if review not available
- Document that missing reviews are acceptable
- Note in summary when review skipped

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command

- [x] Read complete source command from work-prod
- [x] Understand manual testing workflow
- [x] Understand Sourcery review integration
- [x] Document priority matrix structure
- [x] List all hardcoded paths

**Files:**
- `../../../../work-prod/.cursor/commands/pr-validation.md`

---

### Step 2: Create Adapted Command File

- [x] Create `.cursor/commands/pr-validation.md` in dev-infra
- [x] Replace hardcoded paths with generic patterns
- [x] Match `/pr` command paths
- [x] Add feature detection logic
- [x] Make testing commands configurable
- [x] Handle missing reviews gracefully

**Target Location:**
- `.cursor/commands/pr-validation.md` (for dev-infra project)
- `templates/.cursor/commands/pr-validation.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test manual testing guide updates
- [ ] Test manual testing execution (if applicable)
- [ ] Test Sourcery review integration (if available)
- [ ] Test priority matrix filling
- [ ] Test with missing reviews

---

### Step 4: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example manual testing guide
- [ ] Document usage in template README

---

### Step 5: Documentation

- [x] Update command documentation
- [ ] Create usage examples
- [ ] Document manual testing workflow
- [ ] Document Sourcery review integration
- [ ] Document handling missing reviews

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Generic manual testing paths implemented
- [x] Testing commands configurable
- [x] Missing reviews handled gracefully
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- `/pr` command (must be implemented first)
- Understanding of manual testing structure

**Enables:**
- Complete PR validation workflow
- Manual testing automation
- Code review integration

---

## 📚 Related Documentation

**Source:**
- [Work-Prod PR Validation Command](../../../../work-prod/.cursor/commands/pr-validation.md)

**Related Commands:**
- [PR Command](../phase-1-core/pr-command.md) - Creates PRs
- [Post PR Command](post-pr-command.md) - Updates documentation after merge

**Planning:**
- [Phase 2 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

