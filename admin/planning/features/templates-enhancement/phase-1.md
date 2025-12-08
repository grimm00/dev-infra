# Templates Enhancement - Phase 1: Workflow Automation Commands Integration

**Phase:** 1 - Workflow Automation Commands Integration  
**Duration:** 2-3 hours  
**Status:** 🔴 Not Started  
**Prerequisites:** All 17 commands exist in `.cursor/commands/`, template directories exist  
**Created:** 2025-12-07

---

## 📋 Overview

Phase 1 focuses on integrating all 17 workflow automation commands into dev-infra templates. Commands should be copied as-is to `.cursor/commands/` directory in both `standard-project` and `learning-project` templates. No command modification needed - commands already support template structure (`docs/maintainers/` paths).

**What this phase delivers:** New projects generated from templates will have all 17 workflow automation commands ready to use, providing complete workflow automation from day one.

**Success definition:** All 17 commands successfully copied to both templates, template READMEs updated with command documentation, and template generation validated to include commands.

---

## 🎯 Goals

1. Copy all 17 commands to both template directories
2. Update template READMEs with command documentation
3. Validate template generation includes commands
4. Verify commands work in generated projects

---

## 📝 Tasks

### 1. Copy Commands to Standard-Project Template (TDD - RED)

- [ ] Create `.cursor/commands/` directory in `templates/standard-project/` if it doesn't exist
- [ ] Copy all 17 commands from `.cursor/commands/` to `templates/standard-project/.cursor/commands/`
- [ ] Verify all 17 command files copied correctly
- [ ] Check file permissions are correct
- [ ] Run test: Generate project from template - **FAILS** ❌ (commands not documented yet)

**Commands to copy:**
1. `cursor-rules.md`
2. `decision.md`
3. `explore.md`
4. `fix-implement.md`
5. `fix-plan.md`
6. `fix-review.md`
7. `int-opp.md`
8. `post-pr.md`
9. `pre-phase-review.md`
10. `pr.md`
11. `pr-validation.md`
12. `reflect.md`
13. `reflection-artifacts.md`
14. `research.md`
15. `task-improvement.md`
16. `task-phase.md`
17. `task-release.md`
18. `transition-plan.md`

---

### 2. Copy Commands to Learning-Project Template (TDD - GREEN)

- [ ] Create `.cursor/commands/` directory in `templates/learning-project/` if it doesn't exist
- [ ] Copy all 17 commands from `.cursor/commands/` to `templates/learning-project/.cursor/commands/`
- [ ] Verify all 17 command files copied correctly
- [ ] Check file permissions are correct
- [ ] Run test: Generate project from template - **PASSES** ✅ (commands copied)

---

### 3. Update Standard-Project Template README (TDD - RED)

- [ ] Read current `templates/standard-project/README.md`
- [ ] Add "Workflow Automation Commands" section
- [ ] Document all 17 commands with brief descriptions
- [ ] Add command usage examples
- [ ] Add quick reference table
- [ ] Link to command documentation
- [ ] Run test: Template README updated - **FAILS** ❌ (not committed yet)

---

### 4. Update Standard-Project Template README (TDD - GREEN)

- [ ] Commit updated README.md
- [ ] Verify formatting is correct
- [ ] Verify links work
- [ ] Run test: Template README updated - **PASSES** ✅

---

### 5. Update Learning-Project Template README (TDD - RED)

- [ ] Read current `templates/learning-project/README.md`
- [ ] Add "Workflow Automation Commands" section
- [ ] Document all 17 commands with brief descriptions
- [ ] Add command usage examples
- [ ] Add quick reference table
- [ ] Link to command documentation
- [ ] Run test: Template README updated - **FAILS** ❌ (not committed yet)

---

### 6. Update Learning-Project Template README (TDD - GREEN)

- [ ] Commit updated README.md
- [ ] Verify formatting is correct
- [ ] Verify links work
- [ ] Run test: Template README updated - **PASSES** ✅

---

### 7. Test Template Generation (TDD - RED)

- [ ] Run `./scripts/new-project.sh` with test project name
- [ ] Select standard-project template
- [ ] Verify generated project includes `.cursor/commands/` directory
- [ ] Verify all 17 commands are present
- [ ] Run test: Template generation - **FAILS** ❌ (may need validation)

---

### 8. Test Template Generation (TDD - GREEN)

- [ ] Fix any template generation issues
- [ ] Verify commands work in generated project
- [ ] Test command path detection in generated project
- [ ] Run test: Template generation - **PASSES** ✅

---

## ✅ Completion Criteria

- [ ] All 17 commands copied to `templates/standard-project/.cursor/commands/`
- [ ] All 17 commands copied to `templates/learning-project/.cursor/commands/`
- [ ] Template READMEs updated with command documentation
- [ ] Template generation tested and validated
- [ ] Commands work in generated projects
- [ ] All tests passing

---

## 📦 Deliverables

1. **Commands in Template Directories**
   - All 17 commands in `templates/standard-project/.cursor/commands/`
   - All 17 commands in `templates/learning-project/.cursor/commands/`

2. **Updated Template READMEs**
   - `templates/standard-project/README.md` with command documentation
   - `templates/learning-project/README.md` with command documentation

3. **Template Generation Validation**
   - Test results showing commands included in generated projects
   - Verification that commands work in generated projects

---

## 🔗 Dependencies

### Prerequisites

- [ ] All 17 commands exist in `.cursor/commands/`
- [ ] Template directories exist (`templates/standard-project/`, `templates/learning-project/`)
- [ ] Commands support template structure (confirmed by research)

### External Dependencies

- None

### Blocks

- Blocks Phase 2 (CI/CD structure) until commands are integrated
- Blocks template release until commands are integrated

---

## ⚠️ Risks

**Risk: Commands may not work in generated projects**  
**Probability:** Low  
**Impact:** High  
**Mitigation:** Test template generation early, verify commands work in generated projects

**Risk: Template size may become too large**  
**Probability:** Low  
**Impact:** Low  
**Mitigation:** Commands are text files, minimal size impact

---

## 📊 Progress Tracking

### Status by Category

- **Commands Copying:** 🔴 Not Started
- **README Updates:** 🔴 Not Started
- **Template Generation Testing:** 🔴 Not Started

### Overall Progress

- **Phase Status:** 🔴 Not Started
- **Tasks Complete:** 0/8
- **Estimated Completion:** 2-3 hours

---

## 💡 Implementation Notes

### TDD Workflow

- Use TDD approach: RED → GREEN → REFACTOR
- Test template generation after each major step
- Verify commands work in generated projects

### Command Organization

- Commands should be copied as-is, no modification needed
- Commands already support template structure (`docs/maintainers/` paths)
- Commands auto-detect structure, so no path changes needed

### Template README Documentation

- Document all 17 commands with brief descriptions
- Include usage examples for common workflows
- Add quick reference table for easy discovery
- Link to command documentation files

### Testing Approach

- Test template generation with both templates
- Verify commands are included in generated projects
- Test command path detection in generated projects
- Verify commands work correctly in generated projects

---

## 📚 Related Documents

- [Feature Plan](feature-plan.md)
- [Transition Plan](transition-plan.md)
- [ADR-001: Workflow Automation Commands Integration](../../../decisions/templates-enhancement/adr-001-workflow-automation-commands-integration.md)
- [Research: Workflow Automation Commands Integration](../../../research/templates-enhancement/research-workflow-automation-commands-integration.md)
- [Requirements Document](../../../research/templates-enhancement/requirements.md) - FR-1

---

**Last Updated:** 2025-12-07

