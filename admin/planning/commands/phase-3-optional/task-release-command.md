# Task Release Command - Implementation Plan

**Command:** `/task-release`  
**Status:** 🟠 In Progress  
**Priority:** 🟡 MEDIUM  
**Estimated Effort:** 4 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Task Phase Command](../phase-1-core/task-phase-command.md)** - Related command (similar workflow)
- **[Transition Plan Command](transition-plan-command.md)** - Related command (creates release transition plans)
- **[Phase 3 Plan](PLAN.md)** - Overall Phase 3 planning

---

## 🎯 Overview

The `/task-release` command implements release tasks following TDD workflow. Similar to `/task-phase` but focused on release preparation tasks. Ensures release tasks are implemented with proper testing and documentation.

**Key Features:**
- Implements release tasks with TDD
- Updates release checklist
- Updates release notes
- Follows TDD workflow
- Creates release PRs

---

## 🔄 Adaptations Required

### 1. Generic Release Paths ✅

**Current:** Assumes specific release structure

**Target:** Support multiple release organization patterns

**Implementation:**
- ✅ Release transition plan: `docs/maintainers/planning/releases/[version]/transition-plan.md`
- ✅ Release checklist: `docs/maintainers/planning/releases/[version]/checklist.md`
- ✅ Release notes: `docs/maintainers/planning/releases/[version]/release-notes.md`
- ✅ Auto-detect version from branch or directory

---

### 2. Project-Agnostic Release Tasks ✅

**Current:** Assumes specific release task patterns

**Target:** Support different release workflows

**Implementation:**
- ✅ Generic release task structure
- ✅ Configurable release workflows
- ✅ Support different release types

---

### 3. TDD Workflow for Releases ✅

**Current:** Assumes standard TDD workflow

**Target:** Adapt TDD workflow for release tasks

**Implementation:**
- ✅ Release-specific test patterns
- ✅ Version validation tests
- ✅ Release checklist validation
- ✅ Release notes format validation

---

## 📝 Implementation Steps

### Step 1: Design Command Structure ✅

- [x] Analyze `/task-phase` command for patterns
- [x] Design release task workflow
- [x] Define release task structure
- [x] Create release task template

---

### Step 2: Create Adapted Command File ✅

- [x] Create `.cursor/commands/task-release.md` in dev-infra
- [x] Implement generic release paths
- [x] Add version detection logic
- [x] Create release task workflow
- [x] Document TDD workflow for releases

**Target Location:**
- `.cursor/commands/task-release.md` (for dev-infra project)
- `templates/.cursor/commands/task-release.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test with existing release transition plan
- [ ] Test release task implementation
- [ ] Test checklist updates
- [ ] Test integration with `/transition-plan` and `/pr`

---

### Step 4: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example release task
- [ ] Document usage in template README

---

### Step 5: Documentation

- [x] Update command documentation
- [ ] Create usage examples
- [ ] Document release task workflow
- [ ] Document integration with `/transition-plan` and `/pr`

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Generic release paths implemented
- [x] Project-agnostic release tasks implemented
- [x] TDD workflow for releases implemented
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- `/task-phase` command (similar workflow)
- `/transition-plan` command (creates release transition plans)

**Enables:**
- Release task implementation
- TDD workflow for releases
- Release checklist management
- Release PR creation

---

## 📚 Related Documentation

**Related Commands:**
- [Task Phase Command](../phase-1-core/task-phase-command.md) - Similar workflow for phases
- [Transition Plan Command](transition-plan-command.md) - Creates release transition plans
- [PR Command](../phase-1-core/pr-command.md) - Creates release PRs

**Planning:**
- [Phase 3 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

