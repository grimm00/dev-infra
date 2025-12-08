# Templates Enhancement - Phase 5: Workflow Guides and Examples

**Phase:** 5 - Workflow Guides and Examples  
**Duration:** 2-3 hours  
**Status:** 🔴 Not Started  
**Prerequisites:** Phase 4 complete  
**Priority:** Lower priority - can be added incrementally after core structure is in place  
**Created:** 2025-12-07

---

## 📋 Overview

Phase 5 focuses on adding workflow guides and example documents to templates. This includes creating guides covering exploration → research → decision → planning workflow, feature development workflow, CI/CD improvement workflow, and status update workflow. Also includes example documents (exploration, research, ADR, feature plan) as reference.

**What this phase delivers:** New projects generated from templates will have comprehensive workflow guides and examples, helping users understand how to use workflow automation and structures effectively.

**Success definition:** All workflow guides created, all example documents created, template generation tested, and guides/examples validated.

---

## 🎯 Goals

1. Create workflow overview guide
2. Create exploration → research → decision → planning workflow guide
3. Create feature development workflow guide
4. Create CI/CD improvement workflow guide
5. Create example documents (exploration, research, ADR, feature plan)
6. Validate template generation includes guides and examples

---

## 📝 Tasks

### 1. Create Workflow Overview Guide (TDD - RED)

- [ ] Create `docs/maintainers/WORKFLOW-OVERVIEW.md` in both templates
- [ ] Document all available workflows
- [ ] Link to specific workflow guides
- [ ] Provide quick start guide
- [ ] Run test: Guide created - **FAILS** ❌ (not committed yet)

---

### 2. Create Workflow Overview Guide (TDD - GREEN)

- [ ] Commit workflow overview guide
- [ ] Verify formatting is correct
- [ ] Run test: Guide created - **PASSES** ✅

---

### 3. Create Exploration/Research/Decision Workflow Guide (TDD - RED)

- [ ] Create `docs/maintainers/WORKFLOW-EXPLORATION-RESEARCH-DECISION.md` in both templates
- [ ] Document `/explore` → `/research` → `/decision` → `/transition-plan` workflow
- [ ] Include step-by-step instructions
- [ ] Include examples
- [ ] Run test: Guide created - **FAILS** ❌ (not committed yet)

---

### 4. Create Exploration/Research/Decision Workflow Guide (TDD - GREEN)

- [ ] Commit workflow guide
- [ ] Verify formatting is correct
- [ ] Run test: Guide created - **PASSES** ✅

---

### 5. Create Feature Development Workflow Guide (TDD - RED)

- [ ] Create `docs/maintainers/WORKFLOW-FEATURE-DEVELOPMENT.md` in both templates
- [ ] Document feature development workflow
- [ ] Include `/task-phase` command usage
- [ ] Include `/pr` command usage
- [ ] Include status update workflow
- [ ] Run test: Guide created - **FAILS** ❌ (not committed yet)

---

### 6. Create Feature Development Workflow Guide (TDD - GREEN)

- [ ] Commit workflow guide
- [ ] Verify formatting is correct
- [ ] Run test: Guide created - **PASSES** ✅

---

### 7. Create CI/CD Improvement Workflow Guide (TDD - RED)

- [ ] Create `docs/maintainers/WORKFLOW-CICD-IMPROVEMENT.md` in both templates
- [ ] Document CI/CD improvement workflow
- [ ] Include `/task-improvement` command usage
- [ ] Include CI/CD vs feature structure differences
- [ ] Run test: Guide created - **FAILS** ❌ (not committed yet)

---

### 8. Create CI/CD Improvement Workflow Guide (TDD - GREEN)

- [ ] Commit workflow guide
- [ ] Verify formatting is correct
- [ ] Run test: Guide created - **PASSES** ✅

---

### 9. Create Example Exploration Document (TDD - RED)

- [ ] Create `docs/maintainers/examples/example-exploration.md` in both templates
- [ ] Include example exploration structure
- [ ] Include example research topics
- [ ] Include comments explaining structure
- [ ] Run test: Example created - **FAILS** ❌ (not committed yet)

---

### 10. Create Example Exploration Document (TDD - GREEN)

- [ ] Commit example exploration document
- [ ] Verify example is clear and helpful
- [ ] Run test: Example created - **PASSES** ✅

---

### 11. Create Example Research Document (TDD - RED)

- [ ] Create `docs/maintainers/examples/example-research.md` in both templates
- [ ] Include example research structure
- [ ] Include example findings
- [ ] Include example requirements
- [ ] Run test: Example created - **FAILS** ❌ (not committed yet)

---

### 12. Create Example Research Document (TDD - GREEN)

- [ ] Commit example research document
- [ ] Verify example is clear and helpful
- [ ] Run test: Example created - **PASSES** ✅

---

### 13. Create Example ADR Document (TDD - RED)

- [ ] Create `docs/maintainers/examples/example-adr.md` in both templates
- [ ] Include example ADR structure
- [ ] Include example decision rationale
- [ ] Include example alternatives considered
- [ ] Run test: Example created - **FAILS** ❌ (not committed yet)

---

### 14. Create Example ADR Document (TDD - GREEN)

- [ ] Commit example ADR document
- [ ] Verify example is clear and helpful
- [ ] Run test: Example created - **PASSES** ✅

---

### 15. Create Example Feature Plan (TDD - RED)

- [ ] Create `docs/maintainers/examples/example-feature-plan.md` in both templates
- [ ] Include example feature plan structure
- [ ] Include example phases
- [ ] Include example success criteria
- [ ] Run test: Example created - **FAILS** ❌ (not committed yet)

---

### 16. Create Example Feature Plan (TDD - GREEN)

- [ ] Commit example feature plan
- [ ] Verify example is clear and helpful
- [ ] Run test: Example created - **PASSES** ✅

---

### 17. Update Template READMEs with Guide Links (TDD - RED)

- [ ] Read current template READMEs
- [ ] Add "Workflow Guides" section
- [ ] Link to all workflow guides
- [ ] Link to example documents
- [ ] Run test: READMEs updated - **FAILS** ❌ (not committed yet)

---

### 18. Update Template READMEs with Guide Links (TDD - GREEN)

- [ ] Commit updated README.md files
- [ ] Verify links work
- [ ] Run test: READMEs updated - **PASSES** ✅

---

### 19. Test Template Generation (TDD - RED)

- [ ] Run `./scripts/new-project.sh` with test project name
- [ ] Select standard-project template
- [ ] Verify generated project includes all workflow guides
- [ ] Verify generated project includes all example documents
- [ ] Run test: Template generation - **FAILS** ❌ (may need validation)

---

### 20. Test Template Generation (TDD - GREEN)

- [ ] Fix any template generation issues
- [ ] Verify guides and examples work in generated project
- [ ] Test accessing guides and examples
- [ ] Run test: Template generation - **PASSES** ✅

---

## ✅ Completion Criteria

- [ ] All workflow guides created
- [ ] All example documents created
- [ ] Template READMEs updated with guide links
- [ ] Template generation tested and validated
- [ ] Guides and examples work in generated projects

---

## 📦 Deliverables

1. **Workflow Guides**
   - Workflow overview guide
   - Exploration/research/decision workflow guide
   - Feature development workflow guide
   - CI/CD improvement workflow guide

2. **Example Documents**
   - Example exploration document
   - Example research document
   - Example ADR document
   - Example feature plan

3. **Documentation Updates**
   - Template READMEs updated with guide links

---

## 🔗 Dependencies

### Prerequisites

- [ ] Phase 4 complete (requirements template)
- [ ] Workflow guides structure understood (from ADR-005)

### External Dependencies

- None

### Blocks

- None (final phase)

---

## ⚠️ Risks

**Risk: Guides may become outdated**  
**Probability:** Medium  
**Impact:** Low  
**Mitigation:** Keep guides updated as workflows evolve

**Risk: Examples may not match user needs**  
**Probability:** Medium  
**Impact:** Low  
**Mitigation:** Use real examples from dev-infra, update based on feedback

---

## 📊 Progress Tracking

### Status by Category

- **Workflow Guides Creation:** 🔴 Not Started
- **Example Documents Creation:** 🔴 Not Started
- **Documentation Updates:** 🔴 Not Started
- **Template Generation Testing:** 🔴 Not Started

### Overall Progress

- **Phase Status:** 🔴 Not Started
- **Tasks Complete:** 0/20
- **Estimated Completion:** 2-3 hours

---

## 💡 Implementation Notes

### Workflow Guide Structure

- Clear step-by-step instructions
- Include command usage examples
- Link to command documentation
- Provide troubleshooting tips

### Example Document Structure

- Use real examples from dev-infra where possible
- Include comments explaining structure
- Make examples clear and helpful
- Keep examples up-to-date

### Documentation Approach

- Link guides from template READMEs
- Make guides easy to discover
- Provide quick start guides
- Include workflow diagrams if helpful

---

## 📚 Related Documents

- [Feature Plan](feature-plan.md)
- [Transition Plan](transition-plan.md)
- [ADR-005: Workflow Guides and Examples](../../../decisions/templates-enhancement/adr-005-workflow-guides-and-examples.md)
- [Research: Other Template Enhancements](../../../research/templates-enhancement/research-other-template-enhancements.md)
- [Requirements Document](../../../research/templates-enhancement/requirements.md) - FR-6

---

**Last Updated:** 2025-12-07

