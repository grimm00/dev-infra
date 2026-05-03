# Pre Phase Review Command - Implementation Plan

**Command:** `/pre-phase-review`  
**Status:** 🟠 In Progress  
**Priority:** 🟡 MEDIUM  
**Estimated Effort:** 3 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Task Phase Command](../phase-1-core/task-phase-command.md)** - Related command (creates phase plans)
- **[Phase 3 Plan](PLAN.md)** - Overall Phase 3 planning

---

## 🎯 Overview

The `/pre-phase-review` command reviews phase planning documents before implementation begins. It ensures phase plans are complete, dependencies are identified, and implementation is ready to proceed.

**Key Features:**
- Reviews phase plan completeness
- Validates dependencies
- Reviews test plan
- Identifies issues and gaps
- Generates review report

---

## 🔄 Adaptations Required

### 1. Generic Phase Paths ✅

**Current:** Assumes specific phase structure

**Target:** Support multiple phase organization patterns

**Implementation:**
- ✅ Feature-specific: `docs/maintainers/planning/features/[feature-name]/phase-N.md`
- ✅ Project-wide: `docs/maintainers/planning/phases/phase-N.md`
- ✅ Auto-detect feature name
- ✅ Support multiple phase structures

---

### 2. Project-Agnostic Planning ✅

**Current:** Assumes specific planning patterns

**Target:** Support different planning structures

**Implementation:**
- ✅ Generic phase document structure
- ✅ Configurable review structure
- ✅ Support different phase formats

---

### 3. Configurable Review Structure ✅

**Current:** Hardcoded review sections

**Target:** Configurable review sections

**Implementation:**
- ✅ Generic review template
- ✅ Configurable review sections
- ✅ Support custom review formats

---

## 📝 Implementation Steps

### Step 1: Design Command Structure ✅

- [x] Analyze `/task-phase` command for patterns
- [x] Design review workflow
- [x] Define review sections
- [x] Create review template

---

### Step 2: Create Adapted Command File ✅

- [x] Create `.cursor/commands/pre-phase-review.md` in dev-infra
- [x] Implement generic phase paths
- [x] Add feature detection logic
- [x] Create review template
- [x] Document review process

**Target Location:**
- `.cursor/commands/pre-phase-review.md` (for dev-infra project)
- `templates/.cursor/commands/pre-phase-review.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test with existing phase document
- [ ] Test review generation
- [ ] Test dependency validation
- [ ] Test integration with `/task-phase`

---

### Step 4: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example review document
- [ ] Document usage in template README

---

### Step 5: Documentation

- [x] Update command documentation
- [ ] Create usage examples
- [ ] Document review sections
- [ ] Document integration with `/task-phase`

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Generic phase paths implemented
- [x] Project-agnostic planning implemented
- [x] Configurable review structure implemented
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- `/task-phase` command (creates phase plans)

**Enables:**
- Phase readiness validation
- Dependency checking
- Test plan validation
- Better phase planning

---

## 📚 Related Documentation

**Related Commands:**
- [Task Phase Command](../phase-1-core/task-phase-command.md) - Creates phase plans
- [PR Command](../phase-1-core/pr-command.md) - Creates PRs for phases

**Planning:**
- [Phase 3 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

