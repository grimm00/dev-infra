# Templates Enhancement - Phase 2: CI/CD Improvement Structure

**Phase:** 2 - CI/CD Improvement Structure  
**Duration:** 1-2 hours  
**Status:** 🔴 Not Started  
**Prerequisites:** Phase 1 complete  
**Created:** 2025-12-07

---

## 📋 Overview

Phase 2 focuses on adding CI/CD improvement structure to templates. This includes creating `docs/maintainers/planning/ci/` directory with README.md hub and improvement-plan.md template. Structure should match dev-infra pattern: `docs/maintainers/planning/ci/[improvement-name]/` with README.md, improvement-plan.md, and phase-N.md files.

**What this phase delivers:** New projects generated from templates will have CI/CD improvement structure ready, allowing them to plan CI/CD improvements properly from the start.

**Success definition:** CI/CD directories created in both templates, CI/CD improvement templates created, structure differences documented, and template generation validated.

---

## 🎯 Goals

1. Create CI/CD improvement directory structure in both templates
2. Create CI/CD improvement templates (README.md hub, improvement-plan.md)
3. Document CI/CD vs feature structure differences
4. Validate template generation includes CI/CD structure

---

## 📝 Tasks

### 1. Create CI/CD Directory Structure (TDD - RED)

- [ ] Create `docs/maintainers/planning/ci/` directory in `templates/standard-project/`
- [ ] Create `docs/maintainers/planning/ci/` directory in `templates/learning-project/`
- [ ] Verify directories created correctly
- [ ] Run test: Generate project from template - **FAILS** ❌ (no templates yet)

---

### 2. Create CI/CD Directory Structure (TDD - GREEN)

- [ ] Verify directories exist
- [ ] Check directory permissions
- [ ] Run test: Generate project from template - **PASSES** ✅ (directories created)

---

### 3. Create CI/CD Improvement README Hub (TDD - RED)

- [ ] Create `docs/maintainers/planning/ci/README.md` in `templates/standard-project/`
- [ ] Create `docs/maintainers/planning/ci/README.md` in `templates/learning-project/`
- [ ] Include hub structure with quick links section
- [ ] Document CI/CD improvement workflow
- [ ] Link to improvement-plan.md template
- [ ] Run test: Template README created - **FAILS** ❌ (not committed yet)

---

### 4. Create CI/CD Improvement README Hub (TDD - GREEN)

- [ ] Commit CI/CD README.md files
- [ ] Verify formatting is correct
- [ ] Verify links work
- [ ] Run test: Template README created - **PASSES** ✅

---

### 5. Create Improvement Plan Template (TDD - RED)

- [ ] Create `docs/maintainers/planning/ci/improvement-plan-template.md` in `templates/standard-project/`
- [ ] Create `docs/maintainers/planning/ci/improvement-plan-template.md` in `templates/learning-project/`
- [ ] Include improvement plan structure matching dev-infra pattern
- [ ] Include sections: Overview, Benefits, Implementation Steps, Definition of Done
- [ ] Document difference from feature-plan.md
- [ ] Run test: Template created - **FAILS** ❌ (not committed yet)

---

### 6. Create Improvement Plan Template (TDD - GREEN)

- [ ] Commit improvement-plan-template.md files
- [ ] Verify template structure matches dev-infra pattern
- [ ] Run test: Template created - **PASSES** ✅

---

### 7. Document CI/CD vs Feature Structure Differences (TDD - RED)

- [ ] Read current template READMEs
- [ ] Add "CI/CD Improvements" section explaining structure differences
- [ ] Document: Uses `improvement-plan.md` instead of `feature-plan.md`
- [ ] Document: No `status-and-next-steps.md` file (status in README.md)
- [ ] Document: Similar phase structure to features
- [ ] Run test: Documentation updated - **FAILS** ❌ (not committed yet)

---

### 8. Document CI/CD vs Feature Structure Differences (TDD - GREEN)

- [ ] Commit updated README.md files
- [ ] Verify documentation is clear
- [ ] Run test: Documentation updated - **PASSES** ✅

---

### 9. Test Template Generation (TDD - RED)

- [ ] Run `./scripts/new-project.sh` with test project name
- [ ] Select standard-project template
- [ ] Verify generated project includes `docs/maintainers/planning/ci/` directory
- [ ] Verify CI/CD README.md hub is present
- [ ] Verify improvement-plan-template.md is present
- [ ] Run test: Template generation - **FAILS** ❌ (may need validation)

---

### 10. Test Template Generation (TDD - GREEN)

- [ ] Fix any template generation issues
- [ ] Verify CI/CD structure works in generated project
- [ ] Test creating CI/CD improvement using template
- [ ] Run test: Template generation - **PASSES** ✅

---

## ✅ Completion Criteria

- [ ] CI/CD directories created in both templates
- [ ] CI/CD improvement README.md hubs created
- [ ] Improvement-plan.md templates created
- [ ] Structure differences documented
- [ ] Template generation tested and validated
- [ ] CI/CD structure works in generated projects

---

## 📦 Deliverables

1. **CI/CD Directory Structure**
   - `docs/maintainers/planning/ci/` directory in both templates
   - CI/CD improvement README.md hubs

2. **CI/CD Improvement Templates**
   - `improvement-plan-template.md` in both templates
   - Template structure matching dev-infra pattern

3. **Documentation**
   - CI/CD vs feature structure differences documented
   - CI/CD improvement workflow documented

---

## 🔗 Dependencies

### Prerequisites

- [ ] Phase 1 complete (commands integrated)
- [ ] CI/CD improvement structure understood (from ADR-002)

### External Dependencies

- None

### Blocks

- Blocks Phase 3 (exploration/research/decision) until CI/CD structure is complete

---

## ⚠️ Risks

**Risk: CI/CD structure may not match dev-infra pattern**  
**Probability:** Low  
**Impact:** Medium  
**Mitigation:** Review dev-infra CI/CD structure before creating templates

**Risk: Users may confuse CI/CD structure with feature structure**  
**Probability:** Medium  
**Impact:** Low  
**Mitigation:** Clear documentation of differences

---

## 📊 Progress Tracking

### Status by Category

- **Directory Creation:** 🔴 Not Started
- **Template Creation:** 🔴 Not Started
- **Documentation:** 🔴 Not Started
- **Template Generation Testing:** 🔴 Not Started

### Overall Progress

- **Phase Status:** 🔴 Not Started
- **Tasks Complete:** 0/10
- **Estimated Completion:** 1-2 hours

---

## 💡 Implementation Notes

### CI/CD Structure Pattern

- Match dev-infra pattern: `docs/maintainers/planning/ci/[improvement-name]/`
- Include README.md hub
- Include improvement-plan.md template
- No `status-and-next-steps.md` (status tracked in README.md)

### Template Structure

- Improvement plan template should match dev-infra improvement-plan.md structure
- Include: Overview, Benefits, Implementation Steps, Definition of Done
- Document difference from feature-plan.md

### Documentation Approach

- Clearly document CI/CD vs feature structure differences
- Explain when to use CI/CD improvements vs features
- Provide examples of CI/CD improvement structure

---

## 📚 Related Documents

- [Feature Plan](feature-plan.md)
- [Transition Plan](transition-plan.md)
- [ADR-002: CI/CD Improvement Structure Inclusion](../../../decisions/templates-enhancement/adr-002-cicd-improvement-structure-inclusion.md)
- [Research: CI/CD Improvement Structure](../../../research/templates-enhancement/research-cicd-improvement-structure-in-templates.md)
- [Requirements Document](../../../research/templates-enhancement/requirements.md) - FR-2

---

**Last Updated:** 2025-12-07

