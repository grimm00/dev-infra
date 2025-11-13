# Automated Tests for new-project.sh

**Purpose:** Automated testing suite for new-project.sh script  
**Status:** ✅ Implemented  
**Last Updated:** 2025-01-27

---

## Overview

This directory contains BATS (Bash Automated Testing System) tests for the `new-project.sh` script. Tests are organized by behavior/specification rather than script function order, following TDD best practices.

## Test Suite

**Test Files:** 
- `new-project.bats` - 64 tests (comprehensive coverage, 1 smoke test skipped)

**Total Tests:** 64 (63 passing, 1 skipped)  
**Status:** ✅ All tests passing

### Test Organization (By Behavior)

#### Path Expansion and Resolution (9 tests)
- Environment variable expansion ($HOME, $USER, $PWD)
- Tilde expansion (~)
- ${VAR} syntax
- Mixed variables
- Edge cases

#### Directory Validation and Path Resolution (12 tests)
- Absolute and relative paths
- Non-existent paths
- Non-writable directories
- Environment variable paths
- Root directory handling
- Trailing slash normalization
- Return codes (0, 1, 2, 3)

#### Project Name Validation (5 tests)
- Valid names
- Empty names
- Names with spaces
- Invalid characters
- Existing directory detection

#### Template Operations (4 tests)
- Template copying (standard-project, learning-project)
- Error handling (missing template)
- .gitignore verification

#### File Customization (9 tests)
- Cross-platform sed -i behavior (macOS/BSD vs GNU/Linux)
- OSTYPE detection
- Multiple replacements
- README.md customization
- package.json customization
- Error handling

#### GitHub Authentication (5 tests)
- gh CLI installation check
- Authentication status check
- Author name matching
- Mismatch handling
- Missing gh CLI

#### Git Repository Operations (4 tests)
- Git initialization
- Initial commit creation
- Error handling (cd failures)
- Directory change and return

#### User Experience (5 tests)
- Next steps output format
- Project path display
- Project type display
- Learning project instructions
- Regular project instructions

#### Integration Tests (4 tests)
- Absolute path resolution end-to-end
- Relative path resolution end-to-end
- Environment variable expansion in path
- Tilde expansion in path

#### Regression Tests (3 tests)
- Root directory fix verification (PR #6)
- Cross-platform sed fix verification (PR #6)
- Silent failure fix verification

#### Backward Compatibility Tests (2 tests)
- Script works from any directory
- Relative paths resolve correctly

#### Template Structure Tests (3 tests)
- standard-project template path resolution
- regular-project template removal verification
- Both template types available

#### Smoke Tests (1 test, skipped)
- End-to-end script execution (requires refinement for interactive testing)

## Running Tests

### Prerequisites
- BATS installed (`brew install bats-core` on macOS)
- Bash 4.0+
- Git (for template structure tests)

### Run All Tests
```bash
cd tests
bats new-project.bats
```

### Run Specific Test
```bash
bats new-project.bats -t "path_expansion: expands \$HOME"
```

### Verbose Output
```bash
bats new-project.bats --tap
```

## Test Infrastructure

### Helpers
- `helpers.bash` - Test helper functions and setup
  - `setup_test_env()` - Creates isolated test environment
  - `cleanup_test_env()` - Cleans up test environment
  - Function definitions extracted from main script
  - `mock_gh()` - Configurable GitHub CLI mock (scenarios: success, failure, mismatch, not_installed)

### Test Isolation
- Each test runs in an isolated temporary directory
- Test environment variables are set per test
- Cleanup after each test ensures no side effects
- Mocks for external dependencies (GitHub CLI, git)

### Test Style
- Uses BATS `run` command for cleaner test syntax
- Automatic capture of exit status (`$status`) and output (`$output`)
- No manual `set +e`/`set -e` toggling required
- Reusable `mock_gh()` helper for GitHub CLI tests

## Test Coverage

### Functions Tested
- ✅ `expand_env_vars()` - Full coverage
- ✅ `validate_target_directory()` - Full coverage
- ✅ `validate_project_name()` - Core functionality
- ✅ `copy_template()` - Full coverage
- ✅ `customize_project()` - Full coverage (including sed portability)
- ✅ `verify_github_auth()` - Full coverage (with mocks)
- ✅ `init_git_repo()` - Full coverage (with mocks)
- ✅ `show_next_steps()` - Full coverage

### Features Tested
- ✅ Environment variable expansion
- ✅ Path resolution (absolute, relative)
- ✅ Directory validation
- ✅ Project name validation
- ✅ Template copying and customization
- ✅ Cross-platform sed -i behavior
- ✅ GitHub authentication
- ✅ Git repository initialization
- ✅ Error handling
- ✅ Edge cases (root directory, trailing slashes)
- ✅ Regression fixes (PR #6, PR #7)
- ✅ Template structure (standard-project)

### Not Tested (Requires Interactive Input)
- `prompt_input()` - Requires user input
- `prompt_yes_no()` - Requires user input
- Full end-to-end interactive project creation flow

## Test Results

**Last Run:** 2025-01-27  
**Status:** ✅ All 63 tests passing  
**Execution Time:** < 5 seconds

## Test Organization Philosophy

Tests are organized by **behavior/specification** rather than script function order:
- **Path Expansion** - How paths are expanded and resolved
- **Directory Validation** - How directories are validated
- **Project Name Validation** - How project names are validated
- **Template Operations** - How templates are copied and customized
- **GitHub Authentication** - How GitHub auth is verified
- **Git Operations** - How git repos are initialized
- **User Experience** - How information is presented to users
- **Integration** - End-to-end scenarios
- **Regression** - Historical bug fixes
- **Backward Compatibility** - Cross-cutting concerns
- **Template Structure** - Template availability and structure

This organization makes it easier to:
- Find tests for specific behaviors
- Understand what the code does (specification)
- Add new tests in the right place
- Maintain test suite as code evolves

## Future Enhancements

- [ ] Integration tests for full project creation flow
- [ ] Performance tests
- [ ] Test coverage reporting
- [ ] CI/CD integration

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Implemented
