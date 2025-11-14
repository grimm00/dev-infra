# Automated Tests for new-project.sh

**Purpose:** Automated testing suite for new-project.sh script  
**Status:** ✅ Implemented  
**Last Updated:** 2025-11-13

---

## Overview

This directory contains BATS (Bash Automated Testing System) tests for the `new-project.sh` script. Tests are organized by test type (unit, integration, regression, smoke) and by behavior/specification, following TDD best practices.

## Directory Structure

```
tests/
├── README.md                    # This file
├── STRUCTURE-PROPOSAL.md        # Structure proposal document
├── helpers/                     # Test utilities and helpers
│   ├── helpers.bash             # Main helper functions
│   └── comparison-agent-suggestions.md  # Historical comparison doc
├── unit/                        # Unit tests (individual functions)
│   ├── path-expansion.bats      # 9 tests
│   ├── directory-validation.bats # 12 tests
│   ├── project-name-validation.bats # 5 tests
│   ├── file-customization.bats  # 9 tests
│   ├── github-auth.bats         # 5 tests
│   ├── git-operations.bats      # 4 tests
│   └── user-experience.bats      # 5 tests
├── integration/                 # Integration tests (multiple functions)
│   ├── integration.bats         # 4 tests
│   ├── template-operations.bats # 4 tests
│   └── template-structure.bats  # 3 tests
├── regression/                  # Regression tests (bug fixes)
│   ├── regression.bats         # 3 tests
│   └── backward-compat.bats     # 2 tests
├── smoke/                       # End-to-end smoke tests
│   └── smoke.bats               # 1 test (skipped)
└── fixtures/                    # Test data (currently empty)
```

## Test Suite

**Total Tests:** 64 (63 passing, 1 skipped)  
**Status:** ✅ All tests passing

### Test Breakdown by Type

- **Unit Tests:** 49 tests (7 files) - Individual function testing
- **Integration Tests:** 11 tests (3 files) - Multiple functions working together
- **Regression Tests:** 5 tests (2 files) - Historical bug fix verification
- **Smoke Tests:** 1 test (1 file, skipped) - End-to-end script execution

### Test Organization (By Behavior)

#### Unit Tests (`unit/`)

**Path Expansion** (`path-expansion.bats` - 9 tests)
- Environment variable expansion ($HOME, $USER, $PWD)
- Tilde expansion (~)
- ${VAR} syntax
- Mixed variables
- Edge cases

**Directory Validation** (`directory-validation.bats` - 12 tests)
- Absolute and relative paths
- Non-existent paths
- Non-writable directories
- Environment variable paths
- Root directory handling
- Trailing slash normalization
- Return codes (0, 1, 2, 3)

**Project Name Validation** (`project-name-validation.bats` - 5 tests)
- Valid names
- Empty names
- Names with spaces
- Invalid characters
- Existing directory detection

**File Customization** (`file-customization.bats` - 9 tests)
- Cross-platform sed -i behavior (macOS/BSD vs GNU/Linux)
- OSTYPE detection
- Multiple replacements
- README.md customization
- package.json customization
- Error handling

**GitHub Authentication** (`github-auth.bats` - 5 tests)
- gh CLI installation check
- Authentication status check
- Author name matching
- Mismatch handling
- Missing gh CLI

**Git Operations** (`git-operations.bats` - 4 tests)
- Git initialization
- Initial commit creation
- Error handling (cd failures)
- Directory change and return

**User Experience** (`user-experience.bats` - 5 tests)
- Next steps output format
- Project path display
- Project type display
- Learning project instructions
- Regular project instructions

#### Integration Tests (`integration/`)

**Integration Scenarios** (`integration.bats` - 4 tests)
- Absolute path resolution end-to-end
- Relative path resolution end-to-end
- Environment variable expansion in path
- Tilde expansion in path

**Template Operations** (`template-operations.bats` - 4 tests)
- Template copying (standard-project, learning-project)
- Error handling (missing template)
- .gitignore verification

**Template Structure** (`template-structure.bats` - 3 tests)
- standard-project template path resolution
- regular-project template removal verification
- Both template types available

#### Regression Tests (`regression/`)

**Regression Fixes** (`regression.bats` - 3 tests)
- Root directory fix verification (PR #6)
- Cross-platform sed fix verification (PR #6)
- Silent failure fix verification

**Backward Compatibility** (`backward-compat.bats` - 2 tests)
- Script works from any directory
- Relative paths resolve correctly

#### Smoke Tests (`smoke/`)

**End-to-End Execution** (`smoke.bats` - 1 test, skipped)
- Full script execution (requires refinement for interactive testing)

## Running Tests

### Prerequisites
- BATS installed (`brew install bats-core` on macOS)
- Bash 4.0+
- Git (for template structure tests)

### Run All Tests
```bash
# Option 1: Recursive (recommended - runs all tests in subdirectories)
bats --recursive tests/

# Option 2: Explicit directories
cd tests
bats unit integration regression smoke
```

### Run Specific Test Type
```bash
# From project root (recommended)
bats --recursive tests/unit
bats --recursive tests/integration
bats --recursive tests/regression
bats --recursive tests/smoke

# Or from tests directory
cd tests
bats unit
bats integration
bats regression
bats smoke
```

### Run Specific Test File
```bash
bats unit/path-expansion.bats
bats integration/integration.bats
```

### Run Specific Test
```bash
bats unit/path-expansion.bats -t "path_expansion: expands \$HOME"
```

### Verbose Output
```bash
bats unit integration regression smoke --tap
```

## Test Infrastructure

### Helpers (`helpers/`)

**`helpers.bash`** - Main test helper functions
- `setup_test_env()` - Creates isolated test environment
- `cleanup_test_env()` - Cleans up test environment
- Function definitions extracted from main script
- `mock_gh()` - Configurable GitHub CLI mock (scenarios: success, failure, mismatch, not_installed)

**`comparison-agent-suggestions.md`** - Historical comparison document
- Comparison of agent suggestions vs current implementation
- Documents test improvements and best practices

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

**Last Run:** 2025-11-13  
**Status:** ✅ All 63 tests passing (1 skipped)  
**Execution Time:** < 5 seconds

## Test Organization Philosophy

Tests are organized by **test type** and **behavior/specification**:

1. **Test Type** (directory structure)
   - `unit/` - Individual function testing
   - `integration/` - Multiple functions working together
   - `regression/` - Historical bug fixes
   - `smoke/` - End-to-end validation

2. **Behavior/Specification** (file organization)
   - Each file focuses on a specific behavior or feature
   - Tests describe what the code does (specification)
   - Makes it easy to find tests for specific behaviors

This organization makes it easier to:
- Find tests for specific behaviors
- Understand what the code does (specification)
- Add new tests in the right place
- Run specific test types
- Maintain test suite as code evolves

## Future Enhancements

- [ ] Integration tests for full project creation flow
- [ ] Performance tests
- [ ] Test coverage reporting
- [ ] CI/CD integration
- [ ] Additional smoke tests for interactive flows

---

**Last Updated:** 2025-11-13  
**Status:** ✅ Implemented
