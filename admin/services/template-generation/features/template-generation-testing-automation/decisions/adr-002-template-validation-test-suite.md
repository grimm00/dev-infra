# ADR-002: Template Validation Test Suite

**Status:** Proposed  
**Created:** 2025-12-08  
**Last Updated:** 2025-12-08

---

## Context

Template generation currently requires manual verification to ensure generated projects have correct structure, files, and links. An automated test suite is needed to validate template generation, catch issues early, and enable CI/CD integration.

**Related Research:**
- [Research Summary](../../research/template-generation-testing-automation/research-summary.md)
- [Template Validation Test Suite Research](../../research/template-generation-testing-automation/research-template-validation-test-suite.md)

**Related Requirements:**
- [Requirements Document](../../research/template-generation-testing-automation/requirements.md)
  - FR-6: File Presence Validation
  - FR-7: Directory Structure Validation
  - FR-8: Link Validation
  - FR-9: Template Variable Replacement Validation
  - FR-10: Generation Success Testing
  - FR-11: Non-Interactive Mode Usage in Tests
  - NFR-4: Test Framework Consistency
  - NFR-5: Test Cleanup
  - NFR-6: CI/CD Integration
  - NFR-7: Test Failure Messages

---

## Decision

**Decision:** Create automated template validation test suite using bats framework. Test suite will include four test categories (file presence, link validation, structure validation, generation success), test both template types (standard-project, learning-project), use temporary directories for test projects, and integrate with CI/CD workflow.

**Test Suite Structure:**
```
tests/integration/template-validation/
├── template-validation.bats          # Main test suite (includes all test files)
├── file-presence.bats                 # File presence tests
├── link-validation.bats               # Link validation tests
├── structure-validation.bats          # Structure validation tests
└── generation-success.bats            # Generation success tests
```

**Test Categories:**
1. **File Presence Tests:** Validate all required files exist in generated projects
2. **Link Validation Tests:** Validate markdown links work in generated projects
3. **Structure Validation Tests:** Validate directory structure matches template structure
4. **Generation Success Tests:** Test template generation succeeds for both template types

**Implementation Approach:**
1. Use bats framework (already in use for integration tests)
2. Use non-interactive mode for template generation in tests
3. Use temporary directories for generated test projects
4. Clean up test projects after tests complete
5. Test both template types (standard-project, learning-project)
6. Integrate with CI/CD workflow
7. Provide clear failure messages

---

## Consequences

### Positive

- Automated validation reduces manual testing burden
- Catches issues early in CI/CD
- Faster validation process
- Better quality assurance
- Consistent validation across all template changes
- Enables CI/CD integration

### Negative

- Requires maintenance as templates evolve
- Test suite must be updated when template structure changes
- Adds test execution time to CI/CD

---

## Alternatives Considered

### Alternative 1: Extend Existing Validation Script

**Description:** Extend `scripts/validate-templates.sh` to validate generated projects instead of creating new test suite.

**Pros:**
- Reuse existing validation logic
- Single script for all validation
- Less code duplication

**Cons:**
- Script validates templates, not generated projects
- Different validation needs (generated projects need different checks)
- Harder to integrate with CI/CD (script vs test suite)
- Less flexible (can't easily add new test types)

**Why not chosen:** Test suite provides better structure, CI/CD integration, and flexibility. Can reuse validation logic from script, but test suite structure is better for automated testing.

---

### Alternative 2: Use Different Test Framework (pytest, custom)

**Description:** Use pytest or custom test framework instead of bats.

**Pros:**
- pytest has rich features
- Custom framework could be tailored

**Cons:**
- Inconsistent with existing test suite (uses bats)
- Requires learning new framework
- Adds dependency
- bats is already working well

**Why not chosen:** bats is already in use and working well. Consistency with existing test suite is important. bats is sufficient for file system and command testing.

---

### Alternative 3: Single Test File

**Description:** Put all tests in single `template-validation.bats` file instead of separate files per category.

**Pros:**
- Simpler structure
- Single file to maintain
- Easier to see all tests

**Cons:**
- Large file harder to navigate
- Less modular
- Harder to run specific test categories
- Less organized

**Why not chosen:** Separate files per category provide better organization, modularity, and ability to run specific test categories. Main test suite can include all files.

---

## Decision Rationale

**Key Factors:**
- **Framework Consistency:** Use bats to match existing test suite
- **Comprehensive Coverage:** Four test categories cover all validation needs
- **CI/CD Integration:** Test suite structure enables easy CI/CD integration
- **Modularity:** Separate files per category provide better organization
- **Template Coverage:** Test both template types ensures comprehensive validation

**Research Support:**
- Research Finding 2: Existing Test Framework (bats) - bats already in use, consistency important
- Research Finding 4: Test Types Needed - Four test categories identified
- Research Finding 5: CI/CD Integration Patterns - Test suite enables CI/CD integration

**Requirements Alignment:**
- Satisfies FR-6 through FR-11 (all test suite requirements)
- Satisfies NFR-4, NFR-5, NFR-6, NFR-7 (framework consistency, cleanup, CI/CD integration, clear messages)

---

## Requirements Impact

**Requirements Affected:**
- FR-6: File Presence Validation ✅ (implemented in file-presence.bats)
- FR-7: Directory Structure Validation ✅ (implemented in structure-validation.bats)
- FR-8: Link Validation ✅ (implemented in link-validation.bats)
- FR-9: Template Variable Replacement Validation ✅ (implemented in structure-validation.bats)
- FR-10: Generation Success Testing ✅ (implemented in generation-success.bats)
- FR-11: Non-Interactive Mode Usage in Tests ✅ (uses non-interactive mode)
- NFR-4: Test Framework Consistency ✅ (uses bats framework)
- NFR-5: Test Cleanup ✅ (cleans up test projects)
- NFR-6: CI/CD Integration ✅ (integrates with CI/CD workflow)
- NFR-7: Test Failure Messages ✅ (clear failure messages)

**Requirements Refined:**
- None - all requirements satisfied as specified

---

## Implementation Notes

**Test Suite Structure:**
- Main test suite (`template-validation.bats`) includes all test files
- Each test category in separate file for modularity
- Use bats `load` directive to include test files

**Test Implementation:**
- Use `setup()` and `teardown()` for test environment setup/cleanup
- Use temporary directories (`$BATS_RUN_TMPDIR` or `mktemp`)
- Use non-interactive mode: `PROJECT_NAME="test-project" PROJECT_TYPE="standard-project" ./scripts/new-project.sh --non-interactive`
- Validate generated project structure, files, links

**CI/CD Integration:**
- Add test step to CI/CD workflow
- Run tests on template changes (watch `templates/` directory)
- Run tests on script changes (watch `scripts/new-project.sh`)
- Fail CI/CD if tests fail

**Reusing Existing Logic:**
- Can reuse validation logic from `scripts/validate-templates.sh`
- Adapt for generated projects (different paths, different checks)
- Extend with new checks specific to generated projects

---

## References

- [Research Summary](../../research/template-generation-testing-automation/research-summary.md)
- [Template Validation Test Suite Research](../../research/template-generation-testing-automation/research-template-validation-test-suite.md)
- [Requirements Document](../../research/template-generation-testing-automation/requirements.md)
- [CI/CD Improvement Plan](../../planning/ci/template-generation-testing-automation/improvement-plan.md)
- [Existing Test Suite](../../../tests/integration/template-operations.bats)

---

**Last Updated:** 2025-12-08

