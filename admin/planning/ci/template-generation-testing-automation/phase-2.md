# Template Generation Testing Automation - Phase 2: Create Template Validation Test Suite

**Phase:** 2 - Create Template Validation Test Suite  
**Duration:** 3-5 hours (Estimated)  
**Status:** 🔴 Not Started  
**Prerequisites:** Phase 1 complete (non-interactive mode available)  
**Completed:** (if complete)

---

## 📋 Overview

Create automated test suite for template validation using bats framework. This phase implements four test categories (file presence, link validation, structure validation, generation success) to validate both template types (standard-project, learning-project) and integrates with CI/CD workflow.

**Success Definition:** Complete test suite created with all four test categories, tests passing for both template types, CI/CD integration complete, and clear failure messages provided.

---

## 🎯 Goals

1. **Test Suite Structure** - Create organized test suite with main file and category-specific files
2. **File Presence Tests** - Validate all required files exist in generated projects
3. **Link Validation Tests** - Validate markdown links work in generated projects
4. **Structure Validation Tests** - Validate directory structure matches template structure
5. **Generation Success Tests** - Test template generation succeeds for both template types
6. **CI/CD Integration** - Integrate test suite with CI/CD workflow

---

## 📝 Tasks

### Process Workflow (Test Suite Development)

#### 1. Review Prerequisites and Design Test Suite Structure

- [ ] Verify Phase 1 complete (non-interactive mode available)
- [ ] Review ADR-002: Template Validation Test Suite
- [ ] Review requirements FR-6 through FR-11, NFR-4, NFR-5, NFR-6, NFR-7
- [ ] Review existing bats test structure (`tests/integration/`)
- [ ] Design test suite structure:
  - Main test suite: `tests/integration/template-validation/template-validation.bats`
  - File presence tests: `tests/integration/template-validation/file-presence.bats`
  - Link validation tests: `tests/integration/template-validation/link-validation.bats`
  - Structure validation tests: `tests/integration/template-validation/structure-validation.bats`
  - Generation success tests: `tests/integration/template-validation/generation-success.bats`
- [ ] Plan test organization and helper functions

**Design Notes:**
- Use bats framework for consistency with existing tests
- Organize tests by category for modularity
- Use temporary directories for test projects
- Clean up test projects after tests complete
- Test both template types (standard-project, learning-project)

---

#### 2. Create Test Suite Directory Structure

- [ ] Create `tests/integration/template-validation/` directory
- [ ] Create main test suite file: `template-validation.bats`
- [ ] Create file presence test file: `file-presence.bats`
- [ ] Create link validation test file: `link-validation.bats`
- [ ] Create structure validation test file: `structure-validation.bats`
- [ ] Create generation success test file: `generation-success.bats`
- [ ] Set up bats `load` directives in main file
- [ ] Test directory structure:
  ```bash
  ls -la tests/integration/template-validation/
  # Should show all test files
  ```

**Implementation Example:**
```bash
# template-validation.bats
#!/usr/bin/env bats

load 'test_helper'

# Load test category files
load 'file-presence'
load 'link-validation'
load 'structure-validation'
load 'generation-success'
```

---

#### 3. Implement Test Setup and Teardown

- [ ] Create `setup()` function for test environment setup:
  - Create temporary directory for test projects
  - Set up environment variables for non-interactive mode
  - Initialize test project variables
- [ ] Create `teardown()` function for cleanup:
  - Remove temporary test projects
  - Clean up environment variables
- [ ] Test setup and teardown:
  ```bash
  bats tests/integration/template-validation/template-validation.bats
  # Should run setup/teardown for each test
  ```

**Implementation Example:**
```bash
setup() {
  # Create temporary directory
  TEST_DIR=$(mktemp -d)
  export TEST_DIR
  
  # Set up environment variables for non-interactive mode
  export PROJECT_NAME="test-project"
  export PROJECT_TYPE="standard-project"
  export INIT_GIT="false"
}

teardown() {
  # Clean up temporary directory
  if [[ -n "$TEST_DIR" && -d "$TEST_DIR" ]]; then
    rm -rf "$TEST_DIR"
  fi
  
  # Clean up environment variables
  unset PROJECT_NAME
  unset PROJECT_TYPE
  unset PROJECT_DESCRIPTION
  unset INIT_GIT
}
```

---

#### 4. Implement File Presence Tests

- [ ] Create test for standard-project file presence:
  - Check all required files exist (README.md, start.txt, etc.)
  - Check directory structure files exist
  - Check file permissions
- [ ] Create test for learning-project file presence:
  - Check all required files exist
  - Check stage directories exist
  - Check file permissions
- [ ] Add helper function to check file existence:
  ```bash
  check_file_exists() {
    local file="$1"
    [[ -f "$file" ]]
  }
  ```
- [ ] Test file presence tests:
  ```bash
  bats tests/integration/template-validation/file-presence.bats
  # Should validate file presence for both template types
  ```

**Implementation Example:**
```bash
@test "standard-project: all required files exist" {
  PROJECT_TYPE="standard-project" \
    PROJECT_NAME="test-standard" \
    run ./scripts/new-project.sh --non-interactive "$TEST_DIR/test-standard"
  
  [ "$status" -eq 0 ]
  
  # Check required files
  [ -f "$TEST_DIR/test-standard/README.md" ]
  [ -f "$TEST_DIR/test-standard/start.txt" ]
  [ -f "$TEST_DIR/test-standard/.gitignore" ]
  # ... more file checks
}

@test "learning-project: all required files exist" {
  PROJECT_TYPE="learning-project" \
    PROJECT_NAME="test-learning" \
    run ./scripts/new-project.sh --non-interactive "$TEST_DIR/test-learning"
  
  [ "$status" -eq 0 ]
  
  # Check required files
  [ -f "$TEST_DIR/test-learning/README.md" ]
  [ -f "$TEST_DIR/test-learning/start.txt" ]
  # ... more file checks
}
```

---

#### 5. Implement Link Validation Tests

- [ ] Create test for markdown link validation:
  - Check internal markdown links work
  - Check relative links resolve correctly
  - Check link targets exist
- [ ] Add helper function to validate markdown links:
  ```bash
  validate_markdown_links() {
    local file="$1"
    # Extract links from markdown file
    # Check link targets exist
  }
  ```
- [ ] Test link validation for both template types:
  ```bash
  bats tests/integration/template-validation/link-validation.bats
  # Should validate links in generated projects
  ```

**Implementation Example:**
```bash
@test "standard-project: markdown links are valid" {
  PROJECT_TYPE="standard-project" \
    PROJECT_NAME="test-standard" \
    run ./scripts/new-project.sh --non-interactive "$TEST_DIR/test-standard"
  
  [ "$status" -eq 0 ]
  
  # Validate links in README.md
  local readme="$TEST_DIR/test-standard/README.md"
  while IFS= read -r line; do
    if [[ "$line" =~ \[([^\]]+)\]\(([^\)]+)\) ]]; then
      local link_target="${BASH_REMATCH[2]}"
      # Check if link target exists (relative to README location)
      # ... validation logic
    fi
  done < "$readme"
}
```

---

#### 6. Implement Structure Validation Tests

- [ ] Create test for directory structure validation:
  - Check required directories exist
  - Check directory structure matches template
  - Check template variables replaced correctly
- [ ] Add helper function to validate directory structure:
  ```bash
  validate_directory_structure() {
    local project_dir="$1"
    local template_type="$2"
    # Check directory structure matches expected
  }
  ```
- [ ] Test structure validation for both template types:
  ```bash
  bats tests/integration/template-validation/structure-validation.bats
  # Should validate structure for both template types
  ```

**Implementation Example:**
```bash
@test "standard-project: directory structure matches template" {
  PROJECT_TYPE="standard-project" \
    PROJECT_NAME="test-standard" \
    run ./scripts/new-project.sh --non-interactive "$TEST_DIR/test-standard"
  
  [ "$status" -eq 0 ]
  
  # Check required directories
  [ -d "$TEST_DIR/test-standard/docs" ]
  [ -d "$TEST_DIR/test-standard/docs/maintainers" ]
  [ -d "$TEST_DIR/test-standard/backend" ]
  [ -d "$TEST_DIR/test-standard/frontend" ]
  [ -d "$TEST_DIR/test-standard/tests" ]
  # ... more directory checks
}

@test "standard-project: template variables replaced" {
  PROJECT_NAME="my-project" \
    PROJECT_TYPE="standard-project" \
    run ./scripts/new-project.sh --non-interactive "$TEST_DIR/my-project"
  
  [ "$status" -eq 0 ]
  
  # Check template variables replaced
  grep -q "my-project" "$TEST_DIR/my-project/README.md"
  # ... more variable checks
}
```

---

#### 7. Implement Generation Success Tests

- [ ] Create test for generation success:
  - Test template generation succeeds for standard-project
  - Test template generation succeeds for learning-project
  - Verify generated project structure is valid
  - Verify generated files are valid
- [ ] Add helper function to test generation:
  ```bash
  test_generation_success() {
    local template_type="$1"
    local project_name="$2"
    # Run generation and verify success
  }
  ```
- [ ] Test generation success for both template types:
  ```bash
  bats tests/integration/template-validation/generation-success.bats
  # Should test generation success for both template types
  ```

**Implementation Example:**
```bash
@test "standard-project: generation succeeds" {
  PROJECT_TYPE="standard-project" \
    PROJECT_NAME="test-standard" \
    run ./scripts/new-project.sh --non-interactive "$TEST_DIR/test-standard"
  
  [ "$status" -eq 0 ]
  [ -d "$TEST_DIR/test-standard" ]
  [ -f "$TEST_DIR/test-standard/README.md" ]
}

@test "learning-project: generation succeeds" {
  PROJECT_TYPE="learning-project" \
    PROJECT_NAME="test-learning" \
    run ./scripts/new-project.sh --non-interactive "$TEST_DIR/test-learning"
  
  [ "$status" -eq 0 ]
  [ -d "$TEST_DIR/test-learning" ]
  [ -f "$TEST_DIR/test-learning/README.md" ]
}
```

---

#### 8. Implement Test Cleanup

- [ ] Ensure `teardown()` function removes all test projects
- [ ] Ensure temporary directories are cleaned up
- [ ] Ensure environment variables are cleaned up
- [ ] Test cleanup:
  ```bash
  bats tests/integration/template-validation/template-validation.bats
  # After tests, verify no temporary directories remain
  ls -la /tmp/ | grep test-project
  # Should show no test projects
  ```

**Implementation Example:**
```bash
teardown() {
  # Remove test projects
  if [[ -n "$TEST_DIR" && -d "$TEST_DIR" ]]; then
    rm -rf "$TEST_DIR"
  fi
  
  # Clean up any other temporary files
  # ... cleanup logic
  
  # Clean up environment variables
  unset PROJECT_NAME
  unset PROJECT_TYPE
  unset PROJECT_DESCRIPTION
  unset INIT_GIT
  unset TEST_DIR
}
```

---

#### 9. Add Clear Failure Messages

- [ ] Add context to test failures:
  - Show what was expected vs actual
  - Show file/directory paths
  - Show relevant environment variables
- [ ] Use bats `--tap` output for better error messages
- [ ] Add helper functions for better error reporting:
  ```bash
  fail_with_context() {
    local message="$1"
    local context="$2"
    echo "FAIL: $message" >&2
    echo "Context: $context" >&2
    return 1
  }
  ```
- [ ] Test failure messages:
  ```bash
  # Intentionally break a test and verify error message is clear
  ```

**Implementation Example:**
```bash
@test "standard-project: all required files exist" {
  PROJECT_TYPE="standard-project" \
    PROJECT_NAME="test-standard" \
    run ./scripts/new-project.sh --non-interactive "$TEST_DIR/test-standard"
  
  if [ "$status" -ne 0 ]; then
    echo "FAIL: Template generation failed" >&2
    echo "Exit code: $status" >&2
    echo "Output: $output" >&2
    return 1
  fi
  
  if [ ! -f "$TEST_DIR/test-standard/README.md" ]; then
    echo "FAIL: README.md not found" >&2
    echo "Expected: $TEST_DIR/test-standard/README.md" >&2
    echo "Project directory contents:" >&2
    ls -la "$TEST_DIR/test-standard/" >&2
    return 1
  fi
}
```

---

#### 10. Integrate with CI/CD Workflow

- [ ] Review existing CI/CD workflow structure (`.github/workflows/`)
- [ ] Add test step to CI/CD workflow:
  - Run template validation tests
  - Watch `templates/` directory for changes
  - Watch `scripts/new-project.sh` for changes
  - Fail CI/CD if tests fail
- [ ] Test CI/CD integration:
  ```bash
  # Simulate CI/CD run
  bats tests/integration/template-validation/template-validation.bats
  # Should run all tests
  ```
- [ ] Document CI/CD integration

**Implementation Example:**
```yaml
# .github/workflows/test.yml (or similar)
- name: Run Template Validation Tests
  run: |
    bats tests/integration/template-validation/template-validation.bats
  env:
    PROJECT_NAME: test-project
    PROJECT_TYPE: standard-project
```

---

#### 11. Run Full Test Suite

- [ ] Run all tests:
  ```bash
  bats tests/integration/template-validation/template-validation.bats
  # Should run all test categories
  ```
- [ ] Verify all tests pass
- [ ] Fix any failing tests
- [ ] Verify test cleanup works
- [ ] Document test results

---

## ✅ Completion Criteria

- [ ] Test suite structure created (main file + 4 category files)
- [ ] File presence tests implemented and passing
- [ ] Link validation tests implemented and passing
- [ ] Structure validation tests implemented and passing
- [ ] Generation success tests implemented and passing
- [ ] Test cleanup working (no temporary files left)
- [ ] CI/CD integration complete (tests run in CI/CD)
- [ ] Clear failure messages provided
- [ ] All tests passing for both template types
- [ ] Test suite documented

---

## 📦 Deliverables

1. **Test Suite**
   - `tests/integration/template-validation/template-validation.bats` - Main test suite
   - `tests/integration/template-validation/file-presence.bats` - File presence tests
   - `tests/integration/template-validation/link-validation.bats` - Link validation tests
   - `tests/integration/template-validation/structure-validation.bats` - Structure validation tests
   - `tests/integration/template-validation/generation-success.bats` - Generation success tests

2. **CI/CD Integration**
   - Updated CI/CD workflow file (`.github/workflows/`)
   - Test step added to workflow

3. **Documentation**
   - Test suite usage documented
   - CI/CD integration documented

---

## 🔗 Dependencies

### Prerequisites

- ✅ Phase 1 complete (non-interactive mode must be available)
- ✅ ADR-002: Template Validation Test Suite reviewed and approved
- ✅ Requirements FR-6 through FR-11, NFR-4, NFR-5, NFR-6, NFR-7 reviewed
- ✅ Existing bats test structure reviewed

### External Dependencies

- bats framework (already installed)
- Shell environment
- Template generation script (from Phase 1)

### Blocks

- None (final phase)

---

## ⚠️ Risks

**Risk: Test Suite Maintenance Burden**  
**Probability:** Medium  
**Impact:** Medium  
**Mitigation:** Organize tests by category, use helper functions, document test structure  
**Contingency:** Refactor tests if maintenance becomes difficult

**Risk: CI/CD Performance Impact**  
**Probability:** Low  
**Impact:** Low  
**Mitigation:** Use temporary directories efficiently, clean up properly, optimize test execution  
**Contingency:** Optimize tests if CI/CD becomes slow

---

## 📊 Progress Tracking

**Phase Status:** 🔴 Not Started

**Design & Setup (0/3 complete)**
- [ ] Review prerequisites and design test suite structure
- [ ] Create test suite directory structure
- [ ] Implement test setup and teardown

**Test Implementation (0/4 complete)**
- [ ] Implement file presence tests
- [ ] Implement link validation tests
- [ ] Implement structure validation tests
- [ ] Implement generation success tests

**Integration & Testing (0/4 complete)**
- [ ] Implement test cleanup
- [ ] Add clear failure messages
- [ ] Integrate with CI/CD workflow
- [ ] Run full test suite

---

## 💡 Implementation Notes

### Process Workflow

**For Test Suite Development:**
1. Review prerequisites → Verify Phase 1 complete, review ADR and requirements
2. Design test suite structure → Plan test organization
3. Create directory structure → Set up test files
4. Implement setup/teardown → Create test environment
5. Implement test categories → Create tests for each category
6. Add cleanup → Ensure tests clean up properly
7. Add failure messages → Provide clear error messages
8. Integrate with CI/CD → Add tests to workflow
9. Run full suite → Verify all tests pass

### Test Pattern

**Bats Test Structure:**
```bash
#!/usr/bin/env bats

load 'test_helper'

setup() {
  # Set up test environment
}

teardown() {
  # Clean up test environment
}

@test "test description" {
  # Test implementation
  run command
  [ "$status" -eq 0 ]
  [ -f "$file" ]
}
```

**Helper Functions:**
```bash
check_file_exists() {
  local file="$1"
  [[ -f "$file" ]]
}

validate_markdown_links() {
  local file="$1"
  # Validation logic
}
```

### Testing Pattern

**Manual Testing:**
```bash
# Run all tests
bats tests/integration/template-validation/template-validation.bats

# Run specific test file
bats tests/integration/template-validation/file-presence.bats

# Run with verbose output
bats --tap tests/integration/template-validation/template-validation.bats
```

### Test Commands

```bash
# Run all template validation tests
bats tests/integration/template-validation/template-validation.bats

# Run specific test category
bats tests/integration/template-validation/file-presence.bats

# Run with verbose output
bats --tap tests/integration/template-validation/template-validation.bats

# Check test cleanup
bats tests/integration/template-validation/template-validation.bats
ls -la /tmp/ | grep test-project
# Should show no test projects
```

---

## 🔗 Related Documents

- [Phase 1: Add Non-Interactive Mode](phase-1.md)
- [Transition Plan](transition-plan.md)
- [Improvement Plan](improvement-plan.md)
- [ADR-002: Template Validation Test Suite](../../../decisions/template-generation-testing-automation/adr-002-template-validation-test-suite.md)
- [Requirements Document](../../../research/template-generation-testing-automation/requirements.md)
- [CI/CD Planning Hub](../README.md)

---

**Last Updated:** 2025-12-08  
**Status:** 🔴 Not Started  
**Approach:** Process/Documentation Workflow (CI/CD Improvement)  
**Next:** Begin after Phase 1 complete, use `/task-improvement` command to implement

