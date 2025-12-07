# Fix Plan Command - Implementation Plan

**Command:** `/fix-plan`  
**Status:** 🟡 Planned  
**Priority:** 🟠 HIGH  
**Estimated Effort:** 6 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Adaptation Document](../../opportunities/external/work-prod/cursor-commands/adaptations/fix-plan-adaptation.md)** - Detailed adaptation guide
- **[Source Command](../../../../work-prod/.cursor/commands/fix-plan.md)** - Original work-prod command
- **[Phase 1 Plan](PLAN.md)** - Overall Phase 1 planning

---

## 🎯 Overview

The `/fix-plan` command analyzes Sourcery reviews and creates fix batches. This is foundational for the fix management workflow and should be implemented first.

**Key Features:**
- Parses Sourcery review files
- Batches issues by priority and effort
- Creates fix plan documents
- Supports cross-PR batches
- Updates fix tracking hubs

---

## 🔄 Adaptations Required

### 1. Generic Fix Tracking Paths

**Current (work-prod specific):**
```
docs/maintainers/planning/features/projects/fix/pr##/
```

**Target (generic):**
```
docs/maintainers/planning/features/[feature-name]/fix/pr##/
OR
docs/maintainers/planning/fix/pr##/  (project-wide)
```

**Implementation:**
- Auto-detect feature name from context
- Support project-wide fix structure
- Allow configuration override

---

### 2. Configurable Feature Context

**Current:** Assumes `features/projects/` structure

**Target:** Support multiple patterns:
- `features/[feature-name]/fix/` - Feature-specific fixes
- `docs/maintainers/planning/fix/` - Project-wide fixes
- Auto-detect or allow configuration

**Implementation:**
- Detect feature structure
- Support both patterns
- Create structure if needed

---

### 3. Generic Batch Naming

**Current:** Hardcoded `pr##-batch-[priority]-[effort]-[batch-number]`

**Target:** Configurable naming pattern

**Implementation:**
- Default to work-prod pattern
- Allow custom patterns via config
- Support project preferences

---

### 4. Optional Fix Management

**Current:** Assumes fix tracking exists

**Target:** Create structure if needed, make optional

**Implementation:**
- Check if fix structure exists
- Create if missing (optional)
- Support projects without fix management

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command

- [ ] Read complete source command from work-prod
- [ ] Identify all hardcoded paths
- [ ] List all project-specific assumptions
- [ ] Document workflow steps

**Files:**
- `../../../../work-prod/.cursor/commands/fix-plan.md`

---

### Step 2: Create Adapted Command File

- [ ] Create `.cursor/commands/fix-plan.md` in dev-infra
- [ ] Replace hardcoded paths with generic patterns
- [ ] Add feature detection logic
- [ ] Add structure detection
- [ ] Make batch naming configurable
- [ ] Add optional fix management support

**Target Location:**
- `.cursor/commands/fix-plan.md` (for dev-infra project)
- `templates/.cursor/commands/fix-plan.md` (for templates)

---

### Step 3: Add Configuration Support

- [ ] Define configuration structure
- [ ] Add config file detection
- [ ] Support project-specific overrides
- [ ] Document configuration options

**Configuration Options:**
- Fix path pattern
- Feature detection method
- Batch naming pattern
- Fix management enabled/disabled

---

### Step 4: Test in Dev-Infra Project

- [ ] Test with existing fix structure
- [ ] Test with project-wide fixes
- [ ] Test feature detection
- [ ] Test batch creation
- [ ] Test cross-PR batches
- [ ] Verify fix plan documents created correctly

---

### Step 5: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example fix structure
- [ ] Document usage in template README

**Template Locations:**
- `templates/standard-project/.cursor/commands/fix-plan.md`
- `templates/learning-project/.cursor/commands/fix-plan.md`

---

### Step 6: Documentation

- [ ] Update command documentation
- [ ] Create usage examples
- [ ] Document configuration options
- [ ] Add troubleshooting guide
- [ ] Update template documentation

---

## ✅ Definition of Done

- [ ] Command adapted for dev-infra
- [ ] Generic paths implemented
- [ ] Feature detection working
- [ ] Batch naming configurable
- [ ] Optional fix management supported
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [ ] Documentation complete

---

## 📚 Related Documentation

**Adaptation:**
- [Fix Plan Adaptation](../../opportunities/external/work-prod/cursor-commands/adaptations/fix-plan-adaptation.md)

**Source:**
- [Work-Prod Fix Plan Command](../../../../work-prod/.cursor/commands/fix-plan.md)

**Planning:**
- [Phase 1 Plan](PLAN.md)
- [Commands Status](../../commands/STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟡 Planned  
**Next:** Start implementation - read source command and create adapted version

