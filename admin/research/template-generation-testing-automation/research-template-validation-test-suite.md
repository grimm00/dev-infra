# Research: Template Validation Test Suite

**Research Topic:** Template Generation Testing Automation  
**Question:** How to create an automated template validation test suite?  
**Status:** 🔴 Research  
**Created:** 2025-12-08  
**Last Updated:** 2025-12-08

---

## 🎯 Research Question

How can we create an automated test suite that validates template generation, including file presence, link validation, structure validation, and generation success?

---

## 🔍 Research Goals

- [ ] Goal 1: Understand current template structure and requirements
- [ ] Goal 2: Identify test framework options (bats, pytest, custom)
- [ ] Goal 3: Design test suite structure and organization
- [ ] Goal 4: Determine validation criteria for each test type
- [ ] Goal 5: Identify CI/CD integration patterns

---

## 📚 Research Methodology

**Sources:**
- [ ] Source 1: Current template structure (`templates/standard-project/`, `templates/learning-project/`)
- [ ] Source 2: Existing test suite (`tests/integration/template-operations.bats`)
- [ ] Source 3: Template validation script (`scripts/validate-templates.sh`)
- [ ] Source 4: CI/CD workflow patterns for template testing

---

## 📊 Findings

### Finding 1: Current Template Structure

**Description:**
Templates have standardized structure:
- `docs/maintainers/` - Maintainer documentation
- `docs/` - User documentation
- `.cursor/commands/` - Cursor commands
- `README.md` - Project hub
- Various subdirectories with specific purposes

**Required Files:**
- README.md files in major directories
- Workflow guides
- Example documents
- Command documentation

**Source:** `templates/standard-project/` and `templates/learning-project/` structure

**Relevance:**
Test suite must validate this structure is preserved in generated projects.

---

### Finding 2: Existing Test Framework (bats)

**Description:**
Project already uses `bats` (Bash Automated Testing System) for integration tests:
- `tests/integration/template-operations.bats` - Tests template operations
- `tests/integration/template-structure.bats` - Tests template structure
- `tests/integration/integration.bats` - Integration test suite

**Advantages:**
- Already in use, consistent with project
- Shell-based, matches script language
- Good for file system and command testing

**Relevance:**
Should use bats for consistency with existing test suite.

---

### Finding 3: Current Validation Script

**Description:**
`scripts/validate-templates.sh` exists but:
- Validates template structure (not generated projects)
- Checks README.md presence
- Validates documentation links
- Doesn't test generation process

**Gap:**
Need tests that:
- Generate project using non-interactive mode
- Validate generated project structure
- Check generated files are correct
- Verify links work in generated project

**Relevance:**
Can extend existing validation logic for generated projects.

---

### Finding 4: Test Types Needed

**Description:**
Four main test categories:

1. **File Presence Tests:**
   - Check all required files exist
   - Verify directory structure matches template
   - Check file permissions

2. **Link Validation Tests:**
   - Validate markdown links work
   - Check internal references
   - Verify external links (optional, may skip)

3. **Structure Validation Tests:**
   - Verify template structure matches expected
   - Check required directories exist
   - Validate template variables replaced correctly

4. **Generation Success Tests:**
   - Test template generation succeeds
   - Verify generated project structure
   - Check generated files are valid

**Relevance:**
Defines test suite organization.

---

### Finding 5: CI/CD Integration Patterns

**Description:**
CI/CD integration patterns:
1. Run tests on template changes (watch `templates/` directory)
2. Run tests on script changes (watch `scripts/new-project.sh`)
3. Run tests in CI/CD workflow
4. Fail CI/CD if tests fail

**GitHub Actions Pattern:**
```yaml
- name: Test template generation
  run: |
    PROJECT_NAME="test-project" \
    PROJECT_TYPE="standard-project" \
    ./scripts/new-project.sh --non-interactive
    ./tests/integration/template-validation.bats
```

**Relevance:**
Enables automated validation in CI/CD.

---

## 🔍 Analysis

**Key Insights:**
- [ ] Insight 1: Use bats framework for consistency
- [ ] Insight 2: Extend existing validation script logic
- [ ] Insight 3: Test both template types (standard-project, learning-project)
- [ ] Insight 4: Clean up generated test projects after tests
- [ ] Insight 5: Use temporary directories for test projects

**Test Suite Structure:**
```
tests/integration/template-validation/
├── template-validation.bats          # Main test suite
├── file-presence.bats                 # File presence tests
├── link-validation.bats               # Link validation tests
├── structure-validation.bats          # Structure validation tests
└── generation-success.bats            # Generation success tests
```

---

## 💡 Recommendations

- [ ] Recommendation 1: Use bats framework for consistency
- [ ] Recommendation 2: Create separate test files for each test type
- [ ] Recommendation 3: Use temporary directories for generated test projects
- [ ] Recommendation 4: Test both template types (standard-project, learning-project)
- [ ] Recommendation 5: Integrate with CI/CD workflow
- [ ] Recommendation 6: Clean up test projects after tests complete

---

## 📋 Requirements Discovered

- [ ] FR-1: Test suite must validate file presence in generated projects
- [ ] FR-2: Test suite must validate directory structure matches template
- [ ] FR-3: Test suite must validate markdown links work
- [ ] FR-4: Test suite must validate template variables replaced correctly
- [ ] FR-5: Test suite must test generation success for both template types
- [ ] FR-6: Test suite must use non-interactive mode for generation
- [ ] NFR-1: Test suite must use bats framework for consistency
- [ ] NFR-2: Test suite must clean up generated test projects
- [ ] NFR-3: Test suite must run in CI/CD workflow
- [ ] NFR-4: Test suite must provide clear failure messages
- [ ] C-1: Must not modify template files during testing
- [ ] C-2: Must use temporary directories for test projects
- [ ] A-1: Non-interactive mode will be available when test suite is created

---

## 🚀 Next Steps

1. Review findings with test maintainer
2. Design detailed test suite structure
3. Implement test suite using bats
4. Integrate with CI/CD workflow
5. Document test suite usage

---

**Last Updated:** 2025-12-08

