# Fix Implement Command - Implementation Plan

**Command:** `/fix-implement`  
**Status:** 🟠 In Progress  
**Priority:** 🔴 CRITICAL  
**Estimated Effort:** 6 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Source Command](../../../../work-prod/.cursor/commands/fix-implement.md)** - Original work-prod command
- **[Fix Plan Command](fix-plan-command.md)** - Related command (dependency)
- **[Phase 1 Plan](PLAN.md)** - Overall Phase 1 planning

---

## 🎯 Overview

The `/fix-implement` command implements fixes from a fix plan batch. This completes the fix management workflow started by `/fix-plan`. It handles TDD workflow, testing, and PR creation for fix batches.

**Key Features:**
- Loads fix plan batches
- Implements fixes following TDD workflow
- Writes tests for fixes
- Creates fix branches
- Commits work incrementally
- Creates fix PRs
- Updates fix tracking

---

## 🔄 Adaptations Required

### 1. Generic Fix Plan Paths

**Current (work-prod specific):**
```
PR-Specific: docs/maintainers/planning/features/projects/fix/pr##/batch-[name].md
Cross-PR: docs/maintainers/planning/features/projects/fix/cross-pr/[name].md
```

**Target (generic):**
```
PR-Specific: docs/maintainers/planning/features/[feature-name]/fix/pr##/batch-[name].md
OR docs/maintainers/planning/fix/pr##/batch-[name].md (project-wide)
Cross-PR: docs/maintainers/planning/features/[feature-name]/fix/cross-pr/[name].md
OR docs/maintainers/planning/fix/cross-pr/[name].md (project-wide)
```

**Implementation:**
- Auto-detect feature name from context
- Support project-wide fix structure
- Match `/fix-plan` command paths
- Allow configuration override

---

### 2. Configurable Batch Name Parsing

**Current:** Hardcoded batch name formats

**Target:** Configurable batch naming patterns

**Implementation:**
- Match `/fix-plan` batch naming
- Support custom naming patterns
- Auto-detect batch type (PR-specific vs cross-PR)

---

### 3. Generic Branch Naming

**Current:** Hardcoded `fix/[batch-name]`

**Target:** Configurable naming pattern

**Implementation:**
- Default to work-prod pattern
- Allow custom patterns via config
- Support feature-based branches

---

### 4. Generic Fix Tracking Updates

**Current:** Hardcoded fix tracking paths

**Target:** Match `/fix-plan` fix tracking structure

**Implementation:**
- Use same paths as `/fix-plan`
- Support feature-specific and project-wide
- Update fix tracking hubs correctly

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command

- [ ] Read complete source command from work-prod
- [ ] Understand TDD workflow for fixes
- [ ] Identify batch name parsing logic
- [ ] Document fix plan structure requirements
- [ ] List all hardcoded paths
- [ ] Understand fix tracking update logic

**Files:**
- `../../../../work-prod/.cursor/commands/fix-implement.md`

---

### Step 2: Create Adaptation Document

- [ ] Create adaptation document (similar to fix-plan)
- [ ] Document all adaptations needed
- [ ] Provide before/after examples
- [ ] Link to fix-plan adaptations

**Target Location:**
- `../../opportunities/external/work-prod/cursor-commands/adaptations/fix-implement-adaptation.md`

---

### Step 3: Create Adapted Command File

- [x] Create `.cursor/commands/fix-implement.md` in dev-infra
- [x] Replace hardcoded paths with generic patterns
- [x] Match `/fix-plan` path structure
- [x] Add feature detection logic
- [x] Make batch name parsing configurable
- [x] Make branch naming configurable
- [x] Update fix tracking paths

**Target Location:**
- `.cursor/commands/fix-implement.md` (for dev-infra project)
- `templates/.cursor/commands/fix-implement.md` (for templates)

---

### Step 4: Add Configuration Support

- [ ] Define configuration structure
- [ ] Match `/fix-plan` configuration
- [ ] Add config file detection
- [ ] Support project-specific overrides
- [ ] Document configuration options

**Configuration Options:**
- Fix path pattern (match fix-plan)
- Feature detection method
- Batch naming pattern (match fix-plan)
- Branch naming pattern

---

### Step 5: Test in Dev-Infra Project

- [ ] Test with PR-specific batches
- [ ] Test with cross-PR batches
- [ ] Test TDD workflow enforcement
- [ ] Test branch creation
- [ ] Test commit strategy
- [ ] Test fix PR creation
- [ ] Test fix tracking updates
- [ ] Verify integration with `/fix-plan`

---

### Step 6: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example fix plan
- [ ] Document usage in template README
- [ ] Link to `/fix-plan` command documentation

**Template Locations:**
- `templates/standard-project/.cursor/commands/fix-implement.md`
- `templates/learning-project/.cursor/commands/fix-implement.md`

---

### Step 7: Documentation

- [ ] Update command documentation
- [ ] Create usage examples
- [ ] Document TDD workflow for fixes
- [ ] Document batch name formats
- [ ] Document configuration options
- [ ] Add troubleshooting guide
- [ ] Link to `/fix-plan` documentation
- [ ] Update template documentation

---

## ✅ Definition of Done

- [ ] Adaptation document created
- [x] Command adapted for dev-infra
- [x] Generic fix plan paths implemented
- [x] Batch name parsing configurable
- [x] Branch naming configurable
- [x] Fix tracking updates working
- [x] TDD workflow enforced
- [ ] Tested in dev-infra project
- [x] Integrated with `/fix-plan` command
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- `/fix-plan` command (must be implemented first)
- Fix plan structure must exist

**Enables:**
- Complete fix management workflow
- `/pr --fix` command (Phase 1, Step 4)

---

## 📚 Related Documentation

**Source:**
- [Work-Prod Fix Implement Command](../../../../work-prod/.cursor/commands/fix-implement.md)

**Related Commands:**
- [Fix Plan Command](fix-plan-command.md) - Creates fix plans
- [PR Command](pr-command.md) - Creates fix PRs

**Planning:**
- [Phase 1 Plan](PLAN.md)
- [Commands Status](../../commands/STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

