# CI/CD Transition Plan - Template Generation Testing Automation

**Improvement:** Template Generation Testing Automation  
**Status:** 🔴 Not Started  
**Created:** 2025-12-08  
**Source:** admin/decisions/template-generation-testing-automation/decisions-summary.md  
**Type:** CI/CD

---

## Overview

Automate template generation testing to reduce manual verification burden and enable CI/CD integration. This improvement addresses a recurring issue mentioned in Phases 4 and 5 learnings where template generation testing required manual verification because the script is interactive.

**Context:**
- Template generation script requires user input (project name, type, etc.)
- No automated test mode available
- Manual verification is time-consuming
- Can't easily verify in CI/CD
- Template generation testing mentioned in Phases 4 and 5 learnings

**Decision Context:**
- ADR-001: Non-Interactive Mode Implementation - Use `--non-interactive` flag + environment variables
- ADR-002: Template Validation Test Suite - Use bats framework with four test categories

---

## Transition Goals

**Primary Goals:**
- Enable automated template validation
- Support CI/CD testing integration
- Reduce manual testing burden
- Catch issues early in CI/CD
- Provide consistent validation across all template changes

**Success Criteria:**
- Non-interactive mode implemented and tested
- Template validation test suite created and passing
- CI/CD workflow includes template validation tests
- Manual verification no longer required for template changes

---

## Pre-Transition Checklist

- [ ] ADR documents reviewed and approved
- [ ] Requirements document reviewed
- [ ] Improvement plan reviewed
- [ ] Dependencies identified (non-interactive mode must be completed before test suite)
- [ ] CI/CD infrastructure ready
- [ ] Test environment prepared

---

## Transition Steps

### Step 1: Add Non-Interactive Mode to Template Generation Script

**Goal:** Add `--non-interactive` flag to `scripts/new-project.sh` to support automated testing.

**Estimated Effort:** Moderate (2-4 hours)

**Prerequisites:**
- [ ] Review ADR-001: Non-Interactive Mode Implementation
- [ ] Review requirements FR-1 through FR-5, NFR-1, NFR-2, NFR-3
- [ ] Review existing script structure

**Tasks:**
- [ ] Design non-interactive mode interface
- [ ] Add `--non-interactive` flag parsing to script
- [ ] Implement environment variable reading:
  - `PROJECT_NAME` (required)
  - `PROJECT_TYPE` (required, must be `standard-project` or `learning-project`)
  - `PROJECT_DESCRIPTION` (optional)
  - `INIT_GIT` (optional, default: false, accepts `true` or `false`)
- [ ] Implement early validation function (`validate_non_interactive_inputs()`)
- [ ] Modify input collection logic to use environment variables when flag is set
- [ ] Add error handling with non-zero exit codes and clear error messages
- [ ] Test non-interactive mode with various inputs:
  - Test with all environment variables set
  - Test with missing required variables (should fail)
  - Test with invalid PROJECT_TYPE (should fail)
  - Test backward compatibility (no flag = interactive mode)
- [ ] Document non-interactive mode usage:
  - Document `--non-interactive` flag in script help
  - Document environment variables in script and CI/CD workflows
  - Add usage examples

**Deliverables:**
- Updated `scripts/new-project.sh` with non-interactive mode
- Non-interactive mode tested and working
- Documentation updated

**Definition of Done:**
- [ ] `--non-interactive` flag implemented
- [ ] All environment variables supported
- [ ] Early validation working
- [ ] Error handling implemented
- [ ] Backward compatibility maintained
- [ ] Tests passing
- [ ] Documentation updated

**Related:**
- ADR-001: Non-Interactive Mode Implementation
- Requirements: FR-1 through FR-5, NFR-1, NFR-2, NFR-3
- Phase 4 learnings: Template generation testing
- Phase 5 learnings: Template generation testing

---

### Step 2: Create Template Validation Test Suite

**Goal:** Create automated test suite for template validation using bats framework.

**Estimated Effort:** Moderate (3-5 hours)

**Prerequisites:**
- [ ] Step 1 complete (non-interactive mode must be available)
- [ ] Review ADR-002: Template Validation Test Suite
- [ ] Review requirements FR-6 through FR-11, NFR-4, NFR-5, NFR-6, NFR-7
- [ ] Review existing bats test structure

**Tasks:**
- [ ] Design test suite structure:
  - Main test suite: `tests/integration/template-validation/template-validation.bats`
  - File presence tests: `tests/integration/template-validation/file-presence.bats`
  - Link validation tests: `tests/integration/template-validation/link-validation.bats`
  - Structure validation tests: `tests/integration/template-validation/structure-validation.bats`
  - Generation success tests: `tests/integration/template-validation/generation-success.bats`
- [ ] Implement file presence tests:
  - Check all required files are present in generated projects
  - Verify directory structure
  - Check file permissions
  - Test both template types (standard-project, learning-project)
- [ ] Implement link validation tests:
  - Validate markdown links work in generated projects
  - Check internal references
  - Verify external links (optional)
  - Test both template types
- [ ] Implement structure validation tests:
  - Verify template structure matches expected
  - Check required directories exist
  - Validate template variables replaced
  - Test both template types
- [ ] Implement generation success tests:
  - Test template generation succeeds for both template types
  - Verify generated project structure
  - Check generated files are valid
  - Use non-interactive mode in tests
- [ ] Implement test cleanup:
  - Use temporary directories for test projects
  - Clean up test projects after tests complete
  - Use bats `setup()` and `teardown()` functions
- [ ] Integrate with CI/CD workflow:
  - Add test step to CI/CD workflow
  - Run tests on template changes (watch `templates/` directory)
  - Run tests on script changes (watch `scripts/new-project.sh`)
  - Fail CI/CD if tests fail
- [ ] Provide clear failure messages:
  - Include context in test failures
  - Show what was expected vs actual
  - Help debug template issues

**Deliverables:**
- Complete test suite in `tests/integration/template-validation/`
- All test categories implemented
- CI/CD workflow updated
- Tests passing

**Definition of Done:**
- [ ] Test suite structure created
- [ ] File presence tests implemented
- [ ] Link validation tests implemented
- [ ] Structure validation tests implemented
- [ ] Generation success tests implemented
- [ ] Test cleanup working
- [ ] CI/CD integration complete
- [ ] Tests passing
- [ ] Clear failure messages provided

**Related:**
- ADR-002: Template Validation Test Suite
- Requirements: FR-6 through FR-11, NFR-4, NFR-5, NFR-6, NFR-7
- Step 1: Non-Interactive Mode (prerequisite)
- Phase 4 learnings: Template generation testing
- Phase 5 learnings: Template generation testing

---

## Post-Transition

- [ ] Template generation testing automated
- [ ] CI/CD workflow includes template validation
- [ ] Manual verification no longer required
- [ ] Documentation updated
- [ ] Monitoring active (CI/CD test results)

---

## Definition of Done

- [ ] All transition steps complete
- [ ] Non-interactive mode implemented and tested
- [ ] Template validation test suite created and passing
- [ ] CI/CD workflow updated
- [ ] Documentation updated
- [ ] Manual testing checklist documented (for fallback)
- [ ] Ready for next improvement

---

## Related Documents

- [Improvement Plan](improvement-plan.md)
- [Fix Tracking](fix/README.md) - Fix plans and tracking (topic-centric organization)
- [ADR-001: Non-Interactive Mode Implementation](../../decisions/template-generation-testing-automation/adr-001-non-interactive-mode-implementation.md)
- [ADR-002: Template Validation Test Suite](../../decisions/template-generation-testing-automation/adr-002-template-validation-test-suite.md)
- [Decisions Summary](../../decisions/template-generation-testing-automation/decisions-summary.md)
- [Requirements Document](../../research/template-generation-testing-automation/requirements.md)
- [Research Summary](../../research/template-generation-testing-automation/research-summary.md)

---

## Fix Tracking

**Location:** `admin/planning/ci/template-generation-testing-automation/fix/`

Fixes from PR reviews are tracked within the improvement directory structure (topic-centric approach). This keeps fixes organized with their source context.

**Related:**
- [Fix Tracking Hub](fix/README.md) - Fix plans and tracking
- PR #27 fixes: Documentation accuracy improvements (✅ Complete via PR #28)

---

**Last Updated:** 2025-12-08

