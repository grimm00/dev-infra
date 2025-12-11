# Phase 2 Design Notes - Template Validation Test Suite

**Phase:** 2 - Create Template Validation Test Suite  
**Date:** 2025-12-08  
**Status:** ✅ Design Complete

---

## Prerequisites Review

### Phase 1 Verification ✅

- **Non-interactive mode:** Available via `--non-interactive` flag
- **Environment variables:** PROJECT_NAME, PROJECT_TYPE, INIT_GIT, etc. supported
- **Early validation:** `validate_non_interactive_inputs()` function implemented
- **Manual testing:** Comprehensive guide with 10 scenarios created
- **Status:** Phase 1 complete (PR #27, PR #28)

### ADR-002 Review ✅

**Decision:** Use bats framework with four test categories:
1. File presence tests
2. Link validation tests
3. Structure validation tests
4. Generation success tests

**Key Points:**
- Use bats framework for consistency with existing tests
- Organize tests by category for modularity
- Use temporary directories for test projects
- Clean up test projects after tests complete
- Test both template types (standard-project, learning-project)

### Requirements Review ✅

**Functional Requirements:**
- FR-6: Test suite validates file presence
- FR-7: Test suite validates markdown links
- FR-8: Test suite validates directory structure
- FR-9: Test suite validates template generation success
- FR-10: Test suite supports both template types
- FR-11: Test suite integrates with CI/CD workflow

**Non-Functional Requirements:**
- NFR-4: Tests run in reasonable time (< 5 minutes)
- NFR-5: Tests provide clear failure messages
- NFR-6: Tests are maintainable and readable
- NFR-7: Tests use existing test infrastructure (bats)

### Existing Bats Test Structure Review ✅

**Current Structure:**
```
tests/integration/
├── integration.bats          # Main integration test file
├── template-operations.bats   # Template operation tests
└── template-structure.bats    # Template structure tests
```

**Patterns Observed:**
- Use `load 'test_helper'` for helper functions
- Use `setup()` and `teardown()` functions
- Use temporary directories for test projects
- Use bats assertions (`assert_success`, `assert_output`, etc.)
- Test both template types separately

---

## Test Suite Structure Design

### Directory Structure

```
tests/integration/template-validation/
├── template-validation.bats      # Main test suite file
├── file-presence.bats              # File presence tests
├── link-validation.bats            # Link validation tests
├── structure-validation.bats       # Structure validation tests
└── generation-success.bats         # Generation success tests
```

### Test Organization

**Main Test Suite (`template-validation.bats`):**
- Loads test helper
- Loads all category test files
- Provides shared setup/teardown
- Runs all test categories

**Category Test Files:**
- Each category in separate file for modularity
- Can be run independently for debugging
- Share common setup/teardown from main file

### Helper Functions

**Test Setup:**
- Create temporary directory for test projects
- Set up environment variables for non-interactive mode
- Initialize test project variables

**Test Teardown:**
- Remove temporary test projects
- Clean up environment variables

**Test Utilities:**
- `generate_test_project()` - Generate project using non-interactive mode
- `validate_file_exists()` - Check if file exists in generated project
- `validate_link()` - Validate markdown link
- `validate_structure()` - Validate directory structure

---

## Test Categories

### 1. File Presence Tests

**Purpose:** Validate all required files exist in generated projects

**Tests:**
- Required README.md files present
- Required directory structure files present
- Template-specific files present (standard-project vs learning-project)
- Configuration files present (.gitignore, etc.)

**Implementation:**
- Use `test -f` or `[ -f "$file" ]` to check file existence
- Test both template types separately
- Provide clear failure messages with file path

### 2. Link Validation Tests

**Purpose:** Validate markdown links work in generated projects

**Tests:**
- Internal markdown links resolve correctly
- External links are valid (optional, may skip in CI)
- Link format is correct
- No broken links

**Implementation:**
- Parse markdown files for links
- Check if linked files exist (for internal links)
- Validate link format
- Provide clear failure messages with link path

### 3. Structure Validation Tests

**Purpose:** Validate directory structure matches template structure

**Tests:**
- Required directories exist
- Directory structure matches template
- Template-specific directories present
- No unexpected directories

**Implementation:**
- Use `test -d` or `[ -d "$dir" ]` to check directory existence
- Compare generated structure with expected structure
- Test both template types separately
- Provide clear failure messages with directory path

### 4. Generation Success Tests

**Purpose:** Test template generation succeeds for both template types

**Tests:**
- Standard-project generation succeeds
- Learning-project generation succeeds
- Non-interactive mode works correctly
- Environment variables work correctly
- Error handling works correctly

**Implementation:**
- Use non-interactive mode to generate projects
- Check exit code (should be 0 for success)
- Verify project directory created
- Test error cases (missing required variables, etc.)

---

## CI/CD Integration

**Integration Points:**
- Add test step to CI/CD workflow
- Run tests on template changes
- Fail CI/CD if tests fail
- Provide test results in CI/CD output

**Workflow Integration:**
- Tests run automatically on PR
- Tests run on template changes
- Tests run on CI/CD workflow changes
- Test results visible in PR checks

---

## Next Steps

1. Create test suite directory structure
2. Implement test setup and teardown
3. Implement file presence tests
4. Implement link validation tests
5. Implement structure validation tests
6. Implement generation success tests
7. Integrate with CI/CD workflow

---

**Last Updated:** 2025-12-08

