# Reflection Artifacts Command - Implementation Plan

**Command:** `/reflection-artifacts`  
**Status:** 🟠 In Progress  
**Priority:** 🟡 MEDIUM  
**Estimated Effort:** 3 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Source Command](../../../../work-prod/.cursor/commands/reflection-artifacts.md)** - Original work-prod command
- **[Reflect Command](../phase-3-optional/reflect-command.md)** - Related command (creates reflections)
- **[Phase 2 Plan](PLAN.md)** - Overall Phase 2 planning

---

## 🎯 Overview

The `/reflection-artifacts` command extracts structured planning artifacts from reflection documents. It completes the reflection workflow by transforming insights into actionable planning documents.

**Key Features:**
- Parses reflection documents
- Categorizes suggestions by type
- Generates feature plans, release checklists, CI/CD plans
- Creates directory structures
- Updates planning hubs

---

## 🔄 Adaptations Required

### 1. Generic Reflection Paths

**Current (work-prod specific):**
```
docs/maintainers/planning/notes/reflections/reflection-*.md
```

**Target (generic):**
```
docs/maintainers/planning/features/[feature-name]/reflections/reflection-*.md
OR
docs/maintainers/planning/notes/reflections/reflection-*.md  (project-wide)
```

**Implementation:**
- Auto-detect feature name from context
- Support project-wide reflection structure
- Support alternative reflection locations
- Allow configuration override

---

### 2. Generic Artifact Output Paths

**Current:** Hardcoded artifact paths

**Target:** Configurable artifact paths matching project structure

**Implementation:**
- Release artifacts: `docs/maintainers/planning/releases/[version]/`
- Feature artifacts: `docs/maintainers/planning/features/[feature-name]/`
- CI/CD artifacts: `docs/maintainers/planning/ci/[improvement-name]/`
- Infrastructure artifacts: `docs/maintainers/planning/infrastructure/[improvement-name]/` (if exists)

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command

- [x] Read complete source command from work-prod
- [x] Understand reflection parsing logic
- [x] Understand artifact generation logic
- [x] Document artifact template structures
- [x] List all hardcoded paths

**Files:**
- `../../../../work-prod/.cursor/commands/reflection-artifacts.md`

---

### Step 2: Create Adapted Command File

- [x] Create `.cursor/commands/reflection-artifacts.md` in dev-infra
- [x] Replace hardcoded paths with generic patterns
- [x] Add feature detection logic
- [x] Make reflection paths configurable
- [x] Make artifact output paths configurable

**Target Location:**
- `.cursor/commands/reflection-artifacts.md` (for dev-infra project)
- `templates/.cursor/commands/reflection-artifacts.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test with existing reflection file
- [ ] Test artifact generation
- [ ] Test directory structure creation
- [ ] Test hub updates
- [ ] Test integration with `/transition-plan` (if available)

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
- [ ] Document artifact types
- [ ] Document integration with `/reflect` and `/transition-plan`

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Generic reflection paths implemented
- [x] Generic artifact output paths implemented
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- `/reflect` command (creates reflection documents, if available)
- Understanding of reflection document structure

**Enables:**
- Complete reflection workflow
- Artifact-based planning
- Integration with `/transition-plan` (if available)

---

## 📚 Related Documentation

**Source:**
- [Work-Prod Reflection Artifacts Command](../../../../work-prod/.cursor/commands/reflection-artifacts.md)

**Related Commands:**
- [Reflect Command](../phase-3-optional/reflect-command.md) - Creates reflections
- [Transition Plan Command](../phase-3-optional/transition-plan-command.md) - Creates transition plans from artifacts

**Planning:**
- [Phase 2 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

