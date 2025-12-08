# Templates Enhancement - Phase 2: CI/CD Improvement Structure

**Phase:** 2 - CI/CD Improvement Structure  
**Duration:** 1-2 hours  
**Status:** ✅ Complete  
**Prerequisites:** Phase 1 complete  
**Created:** 2025-12-07  
**Completed:** 2025-12-07

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

- [x] Create `docs/maintainers/planning/ci/` directory in `templates/standard-project/`
- [x] Create `docs/maintainers/planning/ci/` directory in `templates/learning-project/`
- [x] Verify directories created correctly
- [x] Run test: Generate project from template - **FAILS** ❌ (no templates yet)

---

### 2. Create CI/CD Directory Structure (TDD - GREEN)

- [x] Verify directories exist
- [x] Check directory permissions
- [x] Run test: Generate project from template - **PASSES** ✅ (directories created)

---

### 3. Create CI/CD Improvement README Hub (TDD - RED)

- [x] Create `docs/maintainers/planning/ci/README.md` in `templates/standard-project/`
- [x] Create `docs/maintainers/planning/ci/README.md` in `templates/learning-project/`
- [x] Include hub structure with quick links section
- [x] Document CI/CD improvement workflow
- [x] Link to improvement-plan.md template
- [x] Run test: Template README created - **FAILS** ❌ (not committed yet)

---

### 4. Create CI/CD Improvement README Hub (TDD - GREEN)

- [x] Commit CI/CD README.md files
- [x] Verify formatting is correct
- [x] Verify links work
- [x] Run test: Template README created - **PASSES** ✅

---

### 5. Create Improvement Plan Template (TDD - RED)

- [x] Create `docs/maintainers/planning/ci/improvement-plan-template.md` in `templates/standard-project/`
- [x] Create `docs/maintainers/planning/ci/improvement-plan-template.md` in `templates/learning-project/`
- [x] Include improvement plan structure matching dev-infra pattern
- [x] Include sections: Overview, Benefits, Implementation Steps, Definition of Done
- [x] Document difference from feature-plan.md
- [x] Run test: Template created - **FAILS** ❌ (not committed yet)

---

### 6. Create Improvement Plan Template (TDD - GREEN)

- [x] Commit improvement-plan-template.md files
- [x] Verify template structure matches dev-infra pattern
- [x] Run test: Template created - **PASSES** ✅

---

### 7. Document CI/CD vs Feature Structure Differences (TDD - RED)

- [x] Read current template READMEs
- [x] Add "CI/CD Improvements" section explaining structure differences
- [x] Document: Uses `improvement-plan.md` instead of `feature-plan.md`
- [x] Document: No `status-and-next-steps.md` file (status in README.md)
- [x] Document: Similar phase structure to features
- [x] Run test: Documentation updated - **FAILS** ❌ (not committed yet)

---

### 8. Document CI/CD vs Feature Structure Differences (TDD - GREEN)

- [x] Commit updated README.md files
- [x] Verify documentation is clear
- [x] Run test: Documentation updated - **PASSES** ✅

---

### 9. Test Template Generation (TDD - RED)

- [x] Run `./scripts/new-project.sh` with test project name
- [x] Select standard-project template
- [x] Verify generated project includes `docs/maintainers/planning/ci/` directory
- [x] Verify CI/CD README.md hub is present
- [x] Verify improvement-plan-template.md is present
- [x] Run test: Template generation - **PASSES** ✅ (structure verified)

---

### 10. Test Template Generation (TDD - GREEN)

- [x] Fix any template generation issues
- [x] Verify CI/CD structure works in generated project
- [x] Test creating CI/CD improvement using template
- [x] Run test: Template generation - **PASSES** ✅

---

## ✅ Completion Criteria

- [x] CI/CD directories created in both templates
- [x] CI/CD improvement README.md hubs created
- [x] Improvement-plan.md templates created
- [x] Structure differences documented
- [x] Template generation tested and validated
- [x] CI/CD structure works in generated projects

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

- **Directory Creation:** ✅ Complete
- **Template Creation:** ✅ Complete
- **Documentation:** ✅ Complete
- **Template Generation Testing:** ✅ Complete

### Overall Progress

- **Phase Status:** ✅ Complete
- **Tasks Complete:** 10/10
- **Actual Duration:** ~30 minutes

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

