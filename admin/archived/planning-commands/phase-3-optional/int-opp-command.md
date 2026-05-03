# Int-Opp Command - Implementation Plan

**Command:** `/int-opp`  
**Status:** 🟠 In Progress  
**Priority:** 🟡 MEDIUM  
**Estimated Effort:** 2 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Source Command](../../../../work-prod/.cursor/commands/int-opp.md)** - Original work-prod command
- **[Adaptation Document](../../opportunities/external/work-prod/cursor-commands/adaptations/int-opp-adaptation.md)** - Detailed adaptation guide
- **[Phase 3 Plan](PLAN.md)** - Overall Phase 3 planning

---

## 🎯 Overview

The `/int-opp` command captures learnings from projects to improve dev-infra template and other projects. This adaptation makes it generic and reusable for any project, not just work-prod.

**Key Features:**
- Phase learnings capture
- Dev-infra improvements documentation
- Project-specific opportunities with automatic project discovery
- Command adaptation workflow

---

## 🔄 Adaptations Required

### 1. Project-Specific Support ✅

**Current (work-prod specific):**
- Hardcoded `work-prod` paths
- Assumes work-prod project structure
- Only supports work-prod → dev-infra flow

**Target (generic):**
- Configurable project name parameter
- Project discovery (`--new-project` flag)
- Support for multiple projects

**Implementation:**
- ✅ Generic project paths
- ✅ Project discovery logic
- ✅ Support multiple projects

---

### 2. Path Updates ✅

**Current:** `docs/maintainers/planning/notes/opportunities/internal/`

**Target:** `admin/planning/opportunities/internal/`

**Implementation:**
- ✅ Updated all path references to dev-infra structure
- ✅ Maintained directory structure pattern
- ✅ Updated hub file locations

---

### 3. Project Discovery ✅

**Current:** No project discovery

**Target:** Automatic project discovery with `--new-project` flag

**Implementation:**
- ✅ Search Projects API (if available)
- ✅ Search GitHub
- ✅ Search local filesystem
- ✅ Ask for clarification if ambiguous

---

### 4. Command Adaptation Workflow ✅

**Current:** No command adaptation workflow

**Target:** `--command-adaptation` flag for dev-infra

**Implementation:**
- ✅ Command adaptation template
- ✅ Adaptation documentation structure
- ✅ Dev-infra specific workflow

---

## 📝 Implementation Steps

### Step 1: Read and Analyze Source Command ✅

- [x] Read complete source command from work-prod
- [x] Understand learnings capture workflow
- [x] Understand project discovery logic
- [x] Understand command adaptation workflow
- [x] List all hardcoded paths

**Files:**
- `../../../../work-prod/.cursor/commands/int-opp.md`

---

### Step 2: Create Adapted Command File ✅

- [x] Create `.cursor/commands/int-opp.md` in dev-infra
- [x] Replace hardcoded paths with dev-infra paths
- [x] Add project discovery logic
- [x] Make project name configurable
- [x] Update directory structure documentation

**Target Location:**
- `.cursor/commands/int-opp.md` (for dev-infra project)
- `templates/.cursor/commands/int-opp.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test project discovery
- [ ] Test learnings capture
- [ ] Test improvements documentation
- [ ] Test command adaptation workflow

---

### Step 4: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example opportunity document
- [ ] Document usage in template README

---

### Step 5: Documentation

- [x] Update command documentation
- [ ] Create usage examples
- [ ] Document project discovery process
- [ ] Document command adaptation workflow

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Project-specific support implemented
- [x] Path updates completed
- [x] Project discovery implemented
- [x] Command adaptation workflow implemented
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- None (standalone command)

**Enables:**
- Learning capture workflow
- Project opportunity management
- Command adaptation documentation
- Template improvement tracking

---

## 📚 Related Documentation

**Source:**
- [Work-Prod Int-Opp Command](../../../../work-prod/.cursor/commands/int-opp.md)
- [Int-Opp Adaptation Document](../../opportunities/external/work-prod/cursor-commands/adaptations/int-opp-adaptation.md)

**Related Commands:**
- [Reflect Command](reflect-command.md) - Creates reflection documents (may inform learnings)
- [Transition Plan Command](transition-plan-command.md) - Creates transition plans (may use learnings)

**Planning:**
- [Phase 3 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

