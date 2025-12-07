# Cursor Rules Command - Implementation Plan

**Command:** `/cursor-rules`  
**Status:** 🟠 In Progress  
**Priority:** 🟢 LOW  
**Estimated Effort:** 2 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

- **[Phase 3 Plan](PLAN.md)** - Overall Phase 3 planning
- **[Commands Status](../STATUS.md)** - Overall command status

---

## 🎯 Overview

The `/cursor-rules` command manages cursor rules files (`.mdc` files) for AI assistant configuration. It helps update rules based on learnings, create new rule files, and maintain rule documentation.

**Key Features:**
- Lists available rules
- Updates rules from learnings
- Creates new rule files
- Validates rule structure
- Maintains rule documentation

---

## 🔄 Adaptations Required

### 1. Generic Rules Paths ✅

**Current:** Standard cursor rules structure

**Target:** Support standard `.cursor/rules/` structure

**Implementation:**
- ✅ Rules directory: `.cursor/rules/`
- ✅ Standard rule file format: `.mdc`
- ✅ Support custom rule files
- ✅ Standard rule template structure

---

### 2. Learning Source Detection ✅

**Current:** Assumes specific learning locations

**Target:** Support multiple learning source patterns

**Implementation:**
- ✅ Feature-specific learnings: `docs/maintainers/planning/features/[feature-name]/learnings/` (if exists)
- ✅ Project-wide learnings: `docs/maintainers/planning/notes/learnings/` (if exists)
- ✅ Reflections: `docs/maintainers/planning/notes/reflections/reflection-*.md`
- ✅ Opportunities: `docs/maintainers/planning/opportunities/internal/` (if exists)

---

### 3. Rule Template Structure ✅

**Current:** Standard rule file format

**Target:** Consistent rule template structure

**Implementation:**
- ✅ Frontmatter metadata (optional)
- ✅ Purpose statement
- ✅ Last updated date
- ✅ Status indicator
- ✅ Quick links section
- ✅ Overview section
- ✅ Structured content sections

---

## 📝 Implementation Steps

### Step 1: Design Command Structure ✅

- [x] Analyze cursor rules structure
- [x] Design rule management workflow
- [x] Define rule template structure
- [x] Create command actions (list, update, create, validate)

---

### Step 2: Create Adapted Command File ✅

- [x] Create `.cursor/commands/cursor-rules.md` in dev-infra
- [x] Implement rule management actions
- [x] Add learning source detection
- [x] Create rule template structure
- [x] Document validation process

**Target Location:**
- `.cursor/commands/cursor-rules.md` (for dev-infra project)
- `templates/.cursor/commands/cursor-rules.md` (for templates)

---

### Step 3: Test in Dev-Infra Project

- [ ] Test rule listing
- [ ] Test rule update from learnings
- [ ] Test rule creation
- [ ] Test rule validation
- [ ] Test integration with `/reflect` and `/int-opp`

---

### Step 4: Integrate into Templates

- [ ] Add command to standard project template
- [ ] Add command to learning project template
- [ ] Create example rule file
- [ ] Document usage in template README

---

### Step 5: Documentation

- [x] Update command documentation
- [ ] Create usage examples
- [ ] Document rule template structure
- [ ] Document integration with learning workflows

---

## ✅ Definition of Done

- [x] Command adapted for dev-infra
- [x] Generic rules paths implemented
- [x] Learning source detection implemented
- [x] Rule template structure implemented
- [ ] Tested in dev-infra project
- [ ] Integrated into templates
- [x] Documentation complete

---

## 🔗 Dependencies

**Depends on:**
- Cursor rules structure (`.cursor/rules/` directory)
- Learning documents (optional)

**Enables:**
- Rule maintenance workflow
- Learning-based rule updates
- Rule validation
- Rule documentation

---

## 📚 Related Documentation

**Related Commands:**
- [Reflect Command](reflect-command.md) - Creates reflection documents (may inform rule updates)
- [Int-Opp Command](../phase-3-optional/README.md) - Captures internal opportunities (may inform rule updates)

**Planning:**
- [Phase 3 Plan](PLAN.md)
- [Commands Status](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test command in dev-infra project, then integrate into templates

