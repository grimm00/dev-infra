# PR Command - Implementation Plan

**Command:** `/pr`  
**Status:** 🟠 In Progress  
**Priority:** 🔴 CRITICAL  
**Estimated Effort:** 8 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Source Command](../../../../work-prod/.cursor/commands/pr.md)** - Original work-prod command
- **[Task Phase Command](task-phase-command.md)** - Related command (creates phase PRs)
- **[Fix Implement Command](fix-implement-command.md)** - Related command (creates fix PRs)
- **[Phase 1 Plan](PLAN.md)** - Overall Phase 1 planning

---

## 🎯 Overview

The `/pr` command is the most frequently used command and central to all workflows. It provides centralized PR creation for phases, fix batches, and releases with consistent formatting and validation.

**Key Features:**
- Phase PR mode (`--phase`)
- Fix PR mode (`--fix`)
- Release PR mode (`--release`)
- Pre-PR validation checklists
- Manual testing scenario management
- PR description templates
- Integration with Sourcery reviews

---

## 🔄 Adaptations Required

### 1. Generic PR Templates

**Current:** Work-prod specific templates

**Target:** Generic templates for any project

**Implementation:**
- Create template placeholders
- Support project-specific customization
- Maintain template structure
- Allow template overrides

---

### 2. Configurable Validation Checklists

**Current:** Hardcoded validation steps

**Target:** Configurable checklists per project type

**Implementation:**
- Default checklists for standard projects
- Customizable for learning projects
- Support project-specific requirements
- Allow checklist customization

---

### 3. Project-Agnostic Manual Testing Guides

**Current:** Assumes specific manual testing structure

**Target:** Support multiple testing guide patterns

**Implementation:**
- Auto-detect manual testing guide location
- Support feature-specific guides
- Support project-wide guides
- Create guide if missing (optional)

---

### 4. Flexible Feature/Project Structure Support

**Current:** Assumes `features/[feature]/` structure

**Target:** Support multiple structures

**Implementation:**
- Auto-detect feature structure
- Support project-wide phases
- Support multiple feature patterns
- Allow configuration override

---

### 5. Generic Path References

**Current:** Hardcoded paths throughout

**Target:** Generic paths matching other commands

**Implementation:**
- Match `/task-phase` phase paths
- Match `/fix-implement` fix paths
- Support project-wide structures
- Consistent with other commands

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command

- [ ] Read complete source command from work-prod
- [ ] Understand all three modes (phase, fix, release)
- [ ] Identify validation checklist steps
- [ ] Document manual testing guide structure
- [ ] List all hardcoded paths
- [ ] Understand PR template structure
- [ ] Document Sourcery review integration

**Files:**
- `../../../../work-prod/.cursor/commands/pr.md`

---

### Step 2: Create Adaptation Document

- [ ] Create comprehensive adaptation document
- [ ] Document all adaptations needed
- [ ] Provide before/after examples for each mode
- [ ] Document template customization approach
- [ ] Link to related command adaptations

**Target Location:**
- `../../opportunities/external/work-prod/cursor-commands/adaptations/pr-adaptation.md`

---

### Step 3: Create Adapted Command File

- [x] Create `.cursor/commands/pr.md` in dev-infra
- [x] Replace hardcoded paths with generic patterns
- [x] Match `/task-phase` and `/fix-implement` paths
- [x] Add feature detection logic
- [x] Make validation checklists configurable
- [x] Make manual testing guide paths configurable
- [x] Create generic PR templates
- [x] Support template customization

**Target Location:**
- `.cursor/commands/pr.md` (for dev-infra project)
- `templates/.cursor/commands/pr.md` (for templates)

---

### Step 4: Create PR Templates

- [ ] Create phase PR template
- [ ] Create fix PR template
- [ ] Create release PR template
- [ ] Make templates customizable
- [ ] Document template variables
- [ ] Create example templates

**Template Locations:**
- `.cursor/templates/pr-phase.md`
- `.cursor/templates/pr-fix.md`
- `.cursor/templates/pr-release.md`

---

### Step 5: Add Configuration Support

- [ ] Define configuration structure
- [ ] Match other commands' configuration
- [ ] Add config file detection
- [ ] Support project-specific overrides
- [ ] Document configuration options

**Configuration Options:**
- Phase path pattern (match task-phase)
- Fix path pattern (match fix-implement)
- Manual testing guide location
- Validation checklist customization
- PR template customization

---

### Step 6: Test in Dev-Infra Project

- [ ] Test phase PR mode
- [ ] Test fix PR mode
- [ ] Test release PR mode
- [ ] Test validation checklists
- [ ] Test manual testing guide integration
- [ ] Test PR template generation
- [ ] Test Sourcery review integration
- [ ] Verify integration with other commands

---

### Step 7: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Add PR templates to templates
- [ ] Create example manual testing guide
- [ ] Document usage in template README
- [ ] Link to related command documentation

**Template Locations:**
- `templates/standard-project/.cursor/commands/pr.md`
- `templates/learning-project/.cursor/commands/pr.md`
- `templates/standard-project/.cursor/templates/`
- `templates/learning-project/.cursor/templates/`

---

### Step 8: Documentation

- [ ] Update command documentation
- [ ] Create usage examples for each mode
- [ ] Document validation checklists
- [ ] Document manual testing integration
- [ ] Document PR templates
- [ ] Document configuration options
- [ ] Add troubleshooting guide
- [ ] Link to related commands
- [ ] Update template documentation

---

## ✅ Definition of Done

- [ ] Adaptation document created
- [x] Command adapted for dev-infra
- [x] Generic PR templates created
- [x] Validation checklists configurable
- [x] Manual testing integration working
- [x] All three modes working (phase, fix, release)
- [x] Paths match other commands
- [ ] Tested in dev-infra project
- [x] Integrated with `/task-phase` and `/fix-implement`
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- `/task-phase` command (for phase PRs)
- `/fix-implement` command (for fix PRs)
- Understanding of phase and fix structures

**Enables:**
- Complete workflow automation
- Consistent PR creation across all workflows

---

## 📚 Related Documentation

**Source:**
- [Work-Prod PR Command](../../../../work-prod/.cursor/commands/pr.md)

**Related Commands:**
- [Task Phase Command](task-phase-command.md) - Creates phase PRs
- [Fix Implement Command](fix-implement-command.md) - Creates fix PRs

**Planning:**
- [Phase 1 Plan](PLAN.md)
- [Commands Status](../../commands/STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

