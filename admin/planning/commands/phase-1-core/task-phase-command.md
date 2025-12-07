# Task Phase Command - Implementation Plan

**Command:** `/task-phase`  
**Status:** 🟡 Planned  
**Priority:** 🔴 CRITICAL  
**Estimated Effort:** 8 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Adaptation Document](../../opportunities/external/work-prod/cursor-commands/adaptations/task-phase-adaptation.md)** - Detailed adaptation guide
- **[Source Command](../../../../work-prod/.cursor/commands/task-phase.md)** - Original work-prod command
- **[Phase 1 Plan](PLAN.md)** - Overall Phase 1 planning

---

## 🎯 Overview

The `/task-phase` command implements phase tasks following TDD workflow. This is critical for automating phase-based development with proper testing discipline.

**Key Features:**
- Reads phase documents
- Implements tasks following TDD (RED → GREEN → REFACTOR)
- Groups related tasks (RED+GREEN pairs)
- Creates feature branches
- Commits work incrementally
- Creates phase PRs at completion

---

## 🔄 Adaptations Required

### 1. Generic Phase Paths

**Current (work-prod specific):**
```
docs/maintainers/planning/features/projects/phase-N.md
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
- Allow configuration override

---

### 2. Flexible Phase Structures

**Current:** Assumes numbered phases (`phase-1.md`, `phase-2.md`)

**Target:** Support multiple patterns:
- Numbered phases: `phase-N.md`
- Named phases: `phase-[name].md`
- Milestones: `milestone-N.md`
- Sprints: `sprint-N.md`

**Implementation:**
- Detect phase structure
- Support multiple patterns
- Auto-detect phase organization

---

### 3. Configurable Task Grouping

**Current:** Hardcoded RED+GREEN grouping

**Target:** Configurable grouping rules

**Implementation:**
- Default to RED+GREEN grouping
- Allow custom grouping rules
- Support task type detection
- Auto-detect task relationships

---

### 4. Generic Branch Naming

**Current:** Hardcoded `feat/phase-N-[description]`

**Target:** Configurable naming pattern

**Implementation:**
- Default to work-prod pattern
- Allow custom patterns via config
- Support feature-based branches

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command

- [ ] Read complete source command from work-prod
- [ ] Understand TDD workflow (RED → GREEN → REFACTOR)
- [ ] Identify task grouping logic
- [ ] Document phase document structure requirements
- [ ] List all hardcoded paths

**Files:**
- `../../../../work-prod/.cursor/commands/task-phase.md`

---

### Step 2: Create Adapted Command File

- [ ] Create `.cursor/commands/task-phase.md` in dev-infra
- [ ] Replace hardcoded paths with generic patterns
- [ ] Add feature detection logic
- [ ] Add phase structure detection
- [ ] Make task grouping configurable
- [ ] Make branch naming configurable

**Target Location:**
- `.cursor/commands/task-phase.md` (for dev-infra project)
- `templates/.cursor/commands/task-phase.md` (for templates)

---

### Step 3: Add Phase Structure Detection

- [ ] Detect numbered phases
- [ ] Detect named phases
- [ ] Support milestones/sprints
- [ ] Auto-detect phase organization
- [ ] Handle missing phase documents gracefully

---

### Step 4: Add Configuration Support

- [ ] Define configuration structure
- [ ] Add config file detection
- [ ] Support project-specific overrides
- [ ] Document configuration options

**Configuration Options:**
- Phase path pattern
- Feature detection method
- Task grouping rules
- Branch naming pattern

---

### Step 5: Test in Dev-Infra Project

- [ ] Test with existing phase structure
- [ ] Test task grouping (RED+GREEN pairs)
- [ ] Test TDD workflow enforcement
- [ ] Test branch creation
- [ ] Test commit strategy
- [ ] Test phase PR creation

---

### Step 6: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example phase document
- [ ] Document usage in template README

**Template Locations:**
- `templates/standard-project/.cursor/commands/task-phase.md`
- `templates/learning-project/.cursor/commands/task-phase.md`

---

### Step 7: Documentation

- [ ] Update command documentation
- [ ] Create usage examples
- [ ] Document TDD workflow
- [ ] Document task grouping rules
- [ ] Document configuration options
- [ ] Add troubleshooting guide
- [ ] Update template documentation

---

## ✅ Definition of Done

- [ ] Command adapted for dev-infra
- [ ] Generic phase paths implemented
- [ ] Phase structure detection working
- [ ] Task grouping configurable
- [ ] Branch naming configurable
- [ ] TDD workflow enforced
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [ ] Documentation complete

---

## 📚 Related Documentation

**Adaptation:**
- [Task Phase Adaptation](../../opportunities/external/work-prod/cursor-commands/adaptations/task-phase-adaptation.md)

**Source:**
- [Work-Prod Task Phase Command](../../../../work-prod/.cursor/commands/task-phase.md)

**Planning:**
- [Phase 1 Plan](PLAN.md)
- [Commands Status](../../commands/STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟡 Planned  
**Next:** Start implementation - read source command and create adapted version

