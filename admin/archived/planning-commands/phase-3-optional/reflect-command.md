# Reflect Command - Implementation Plan

**Command:** `/reflect`  
**Status:** 🟠 In Progress  
**Priority:** 🟡 MEDIUM  
**Estimated Effort:** 4 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Source Command](../../../../work-prod/.cursor/commands/reflect.md)** - Original work-prod command
- **[Reflection Artifacts Command](../phase-2-supporting/reflection-artifacts-command.md)** - Related command (extracts artifacts)
- **[Phase 3 Plan](PLAN.md)** - Overall Phase 3 planning

---

## 🎯 Overview

The `/reflect` command analyzes project state, recent work, and patterns to provide actionable suggestions. It provides insights and recommendations based on current project state.

**Key Features:**
- Analyzes recent commits and PRs
- Reviews current phase/feature status
- Identifies patterns and opportunities
- Provides actionable suggestions
- References phase learnings (if available)

---

## 🔄 Adaptations Required

### 1. Generic Phase/Feature Paths ✅

**Current (work-prod specific):**
```
docs/maintainers/planning/features/projects/status-and-next-steps.md
```

**Target (generic):**
```
docs/maintainers/planning/features/[feature-name]/status-and-next-steps.md
OR
docs/maintainers/planning/status-and-next-steps.md (project-wide)
```

**Implementation:**
- ✅ Auto-detect feature name from context
- ✅ Support project-wide structure
- ✅ Support multiple feature structures
- ✅ Allow configuration override

---

### 2. Configurable Reflection Scope ✅

**Current:** Assumes `features/projects/` structure

**Target:** Support project-specific reflection scopes

**Implementation:**
- ✅ Support `features/[feature-name]/` or `releases/[version]/` structures
- ✅ Support phase-based or milestone-based development
- ✅ Auto-detect project structure

---

### 3. Generic Learnings References ✅

**Current:** Hardcoded learnings document paths

**Target:** Configurable learnings document paths

**Implementation:**
- ✅ Make learnings optional
- ✅ Auto-detect learnings location
- ✅ Support projects without learnings structure

---

### 4. Project-Agnostic Suggestions ✅

**Current:** Work-prod specific suggestion patterns

**Target:** Contextual suggestions based on project structure

**Implementation:**
- ✅ Detect project features from structure
- ✅ Adapt suggestions to project context
- ✅ Support optional workflows (fix management, etc.)

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command ✅

- [x] Read complete source command from work-prod
- [x] Understand reflection analysis logic
- [x] Understand suggestion generation logic
- [x] Document reflection report structure
- [x] List all hardcoded paths

**Files:**
- `../../../../work-prod/.cursor/commands/reflect.md`

---

### Step 2: Create Adapted Command File ✅

- [x] Create `.cursor/commands/reflect.md` in dev-infra
- [x] Replace hardcoded paths with generic patterns
- [x] Add feature detection logic
- [x] Make reflection paths configurable
- [x] Make learnings references optional

**Target Location:**
- `.cursor/commands/reflect.md` (for dev-infra project)
- `templates/.cursor/commands/reflect.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test reflection generation
- [ ] Test suggestion generation
- [ ] Test reflection file creation
- [ ] Test integration with `/reflection-artifacts`

---

### Step 4: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example reflection file
- [ ] Document usage in template README

---

### Step 5: Documentation

- [x] Update command documentation
- [ ] Create usage examples
- [ ] Document reflection scopes
- [ ] Document integration with `/reflection-artifacts`

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Generic phase/feature paths implemented
- [x] Configurable reflection scope implemented
- [x] Generic learnings references implemented
- [x] Project-agnostic suggestions implemented
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- None (standalone command)

**Enables:**
- Reflection workflow
- Actionable suggestions
- Project state analysis
- Integration with `/reflection-artifacts`

---

## 📚 Related Documentation

**Source:**
- [Work-Prod Reflect Command](../../../../work-prod/.cursor/commands/reflect.md)

**Related Commands:**
- [Reflection Artifacts Command](../phase-2-supporting/reflection-artifacts-command.md) - Extracts artifacts from reflection
- [Transition Plan Command](transition-plan-command.md) - Creates transition plans from artifacts

**Planning:**
- [Phase 3 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

