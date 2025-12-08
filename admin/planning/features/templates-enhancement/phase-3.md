# Templates Enhancement - Phase 3: Exploration/Research/Decision Workflows

**Phase:** 3 - Exploration/Research/Decision Workflows  
**Duration:** 1-2 hours  
**Status:** 🔴 Not Started  
**Prerequisites:** Phase 2 complete  
**Created:** 2025-12-07

---

## 📋 Overview

Phase 3 focuses on adding exploration/research/decision directory structure to templates. This includes creating hub directories with README.md files: `docs/maintainers/planning/explorations/`, `docs/maintainers/research/`, and `docs/maintainers/decisions/`. Commands create topic-specific directories automatically, but templates need hub directories for organization.

**What this phase delivers:** New projects generated from templates will have exploration/research/decision workflows ready, supporting `/explore`, `/research`, and `/decision` commands from day one.

**Success definition:** All three hub directories created in both templates, hub README.md files created, workflow documented, and template generation validated.

---

## 🎯 Goals

1. Create exploration/research/decision hub directories in both templates
2. Create hub README.md files for each directory
3. Document exploration/research/decision workflow
4. Validate template generation includes new directories

---

## 📝 Tasks

### 1. Create Explorations Directory (TDD - RED)

- [ ] Create `docs/maintainers/planning/explorations/` directory in `templates/standard-project/`
- [ ] Create `docs/maintainers/planning/explorations/` directory in `templates/learning-project/`
- [ ] Verify directories created correctly
- [ ] Run test: Generate project from template - **FAILS** ❌ (no README yet)

---

### 2. Create Explorations Directory (TDD - GREEN)

- [ ] Verify directories exist
- [ ] Check directory permissions
- [ ] Run test: Generate project from template - **PASSES** ✅ (directories created)

---

### 3. Create Research Directory (TDD - RED)

- [ ] Create `docs/maintainers/research/` directory in `templates/standard-project/`
- [ ] Create `docs/maintainers/research/` directory in `templates/learning-project/`
- [ ] Verify directories created correctly
- [ ] Run test: Generate project from template - **FAILS** ❌ (no README yet)

---

### 4. Create Research Directory (TDD - GREEN)

- [ ] Verify directories exist
- [ ] Check directory permissions
- [ ] Run test: Generate project from template - **PASSES** ✅ (directories created)

---

### 5. Create Decisions Directory (TDD - RED)

- [ ] Create `docs/maintainers/decisions/` directory in `templates/standard-project/`
- [ ] Create `docs/maintainers/decisions/` directory in `templates/learning-project/`
- [ ] Verify directories created correctly
- [ ] Run test: Generate project from template - **FAILS** ❌ (no README yet)

---

### 6. Create Decisions Directory (TDD - GREEN)

- [ ] Verify directories exist
- [ ] Check directory permissions
- [ ] Run test: Generate project from template - **PASSES** ✅ (directories created)

---

### 7. Create Explorations Hub README (TDD - RED)

- [ ] Create `docs/maintainers/planning/explorations/README.md` in both templates
- [ ] Include hub structure with quick links section
- [ ] Document exploration workflow
- [ ] Link to `/explore` command documentation
- [ ] Run test: README created - **FAILS** ❌ (not committed yet)

---

### 8. Create Explorations Hub README (TDD - GREEN)

- [ ] Commit explorations README.md files
- [ ] Verify formatting is correct
- [ ] Run test: README created - **PASSES** ✅

---

### 9. Create Research Hub README (TDD - RED)

- [ ] Create `docs/maintainers/research/README.md` in both templates
- [ ] Include hub structure with quick links section
- [ ] Document research workflow
- [ ] Link to `/research` command documentation
- [ ] Run test: README created - **FAILS** ❌ (not committed yet)

---

### 10. Create Research Hub README (TDD - GREEN)

- [ ] Commit research README.md files
- [ ] Verify formatting is correct
- [ ] Run test: README created - **PASSES** ✅

---

### 11. Create Decisions Hub README (TDD - RED)

- [ ] Create `docs/maintainers/decisions/README.md` in both templates
- [ ] Include hub structure with quick links section
- [ ] Document decision workflow
- [ ] Link to `/decision` command documentation
- [ ] Run test: README created - **FAILS** ❌ (not committed yet)

---

### 12. Create Decisions Hub README (TDD - GREEN)

- [ ] Commit decisions README.md files
- [ ] Verify formatting is correct
- [ ] Run test: README created - **PASSES** ✅

---

### 13. Document Exploration/Research/Decision Workflow (TDD - RED)

- [ ] Read current template READMEs
- [ ] Add "Exploration/Research/Decision Workflows" section
- [ ] Document workflow: `/explore` → `/research` → `/decision` → `/transition-plan`
- [ ] Document how commands create topic-specific directories
- [ ] Document hub directories vs topic-specific directories
- [ ] Run test: Documentation updated - **FAILS** ❌ (not committed yet)

---

### 14. Document Exploration/Research/Decision Workflow (TDD - GREEN)

- [ ] Commit updated README.md files
- [ ] Verify documentation is clear
- [ ] Run test: Documentation updated - **PASSES** ✅

---

### 15. Test Template Generation (TDD - RED)

- [ ] Run `./scripts/new-project.sh` with test project name
- [ ] Select standard-project template
- [ ] Verify generated project includes all three directories
- [ ] Verify hub README.md files are present
- [ ] Run test: Template generation - **FAILS** ❌ (may need validation)

---

### 16. Test Template Generation (TDD - GREEN)

- [ ] Fix any template generation issues
- [ ] Verify directories work in generated project
- [ ] Test `/explore`, `/research`, `/decision` commands in generated project
- [ ] Run test: Template generation - **PASSES** ✅

---

## ✅ Completion Criteria

- [ ] All three directories created in both templates
- [ ] Hub README.md files created for each directory
- [ ] Workflow documented
- [ ] Template generation tested and validated
- [ ] Commands work in generated projects

---

## 📦 Deliverables

1. **Exploration/Research/Decision Directories**
   - `docs/maintainers/planning/explorations/` directory in both templates
   - `docs/maintainers/research/` directory in both templates
   - `docs/maintainers/decisions/` directory in both templates

2. **Hub README.md Files**
   - Explorations hub README.md
   - Research hub README.md
   - Decisions hub README.md

3. **Workflow Documentation**
   - Exploration/research/decision workflow documented
   - Command usage documented

---

## 🔗 Dependencies

### Prerequisites

- [ ] Phase 2 complete (CI/CD structure)
- [ ] Exploration/research/decision structure understood (from ADR-003)

### External Dependencies

- None

### Blocks

- Blocks Phase 4 (requirements template) until directories are complete

---

## ⚠️ Risks

**Risk: Directory structure may not match command expectations**  
**Probability:** Low  
**Impact:** Medium  
**Mitigation:** Review command path detection logic before creating directories

**Risk: Users may not understand hub vs topic-specific directories**  
**Probability:** Medium  
**Impact:** Low  
**Mitigation:** Clear documentation explaining the difference

---

## 📊 Progress Tracking

### Status by Category

- **Directory Creation:** 🔴 Not Started
- **Hub README Creation:** 🔴 Not Started
- **Workflow Documentation:** 🔴 Not Started
- **Template Generation Testing:** 🔴 Not Started

### Overall Progress

- **Phase Status:** 🔴 Not Started
- **Tasks Complete:** 0/16
- **Estimated Completion:** 1-2 hours

---

## 💡 Implementation Notes

### Directory Structure Pattern

- Hub directories: `docs/maintainers/planning/explorations/`, `docs/maintainers/research/`, `docs/maintainers/decisions/`
- Commands create topic-specific directories automatically
- Templates provide hub structure, commands populate it

### Hub README Structure

- Include quick links section
- Document workflow
- Link to command documentation
- Explain hub vs topic-specific directories

### Workflow Documentation

- Document: `/explore` → `/research` → `/decision` → `/transition-plan`
- Explain how commands create topic-specific directories
- Provide examples of workflow usage

---

## 📚 Related Documents

- [Feature Plan](feature-plan.md)
- [Transition Plan](transition-plan.md)
- [ADR-003: Exploration/Research/Decision Workflows Structure](../../../decisions/templates-enhancement/adr-003-exploration-research-decision-workflows-structure.md)
- [Research: Exploration/Research/Decision Workflows](../../../research/templates-enhancement/research-exploration-research-decision-workflows.md)
- [Requirements Document](../../../research/templates-enhancement/requirements.md) - FR-3

---

**Last Updated:** 2025-12-07

