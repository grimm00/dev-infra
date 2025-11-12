# Automated Tests for new-project.sh

**Purpose:** Automated testing suite for directory selection feature  
**Status:** ✅ Implemented  
**Last Updated:** 2025-11-12

---

## Overview

This directory contains BATS (Bash Automated Testing System) tests for the `new-project.sh` script, specifically focusing on the directory selection feature and related functionality.

## Test Suite

**Test Files:** 
- `new-project.bats` - 33 tests (directory selection feature)
- `sed-portability.bats` - 4 tests (PR #7 sed -i portability fix)

**Total Tests:** 37  
**Status:** ✅ All tests passing

### Test Categories

#### Unit Tests (24 tests)
- **expand_env_vars()** - 9 tests
  - Environment variable expansion ($HOME, $USER, $PWD)
  - Tilde expansion (~)
  - ${VAR} syntax
  - Mixed variables
  - Edge cases

- **validate_target_directory()** - 10 tests
  - Absolute and relative paths
  - Non-existent paths
  - Non-writable directories
  - Environment variable paths
  - Root directory handling
  - Trailing slash normalization
  - Return codes (0, 1, 2, 3)

- **validate_project_name()** - 5 tests
  - Valid names
  - Empty names
  - Names with spaces
  - Invalid characters
  - Existing directory detection

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

#### Portability Tests (4 tests) - `sed-portability.bats`
- sed -i works on macOS/BSD with empty string
- sed -i works on GNU/Linux without extension
- OSTYPE detection works correctly
- Multiple replacements work (simulates customize_project usage)

## Running Tests

### Prerequisites
- BATS installed (`brew install bats-core` on macOS)
- Bash 4.0+

### Run All Tests
```bash
cd tests
bats new-project.bats sed-portability.bats
```

Or run individually:
```bash
cd tests
bats new-project.bats      # Directory selection tests
bats sed-portability.bats # sed portability tests
```

### Run Specific Test
```bash
bats new-project.bats -t "expand_env_vars: expands \$HOME"
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

### Test Isolation
- Each test runs in an isolated temporary directory
- Test environment variables are set per test
- Cleanup after each test ensures no side effects

## Test Coverage

### Functions Tested
- ✅ `expand_env_vars()` - Full coverage
- ✅ `validate_target_directory()` - Full coverage
- ✅ `validate_project_name()` - Core functionality (simplified for non-interactive testing)
- ✅ `sed -i` portability - Cross-platform sed in-place editing (PR #7 fix)

### Features Tested
- ✅ Environment variable expansion
- ✅ Path resolution (absolute, relative)
- ✅ Directory validation
- ✅ Project name validation
- ✅ Error handling
- ✅ Edge cases (root directory, trailing slashes)
- ✅ Regression fixes (PR #6)

### Not Tested (Requires Interactive Input)
- `prompt_input()` - Requires user input
- `prompt_yes_no()` - Requires user input
- `verify_github_auth()` - Requires GitHub CLI and authentication
- `customize_project()` - Full function requires templates (sed -i part is tested)
- Full end-to-end project creation flow

## Test Results

**Last Run:** 2025-11-12  
**Status:** ✅ All 37 tests passing (33 + 4 sed portability)  
**Execution Time:** < 5 seconds

## Future Enhancements

- [ ] Mock GitHub CLI for `verify_github_auth()` tests
- [ ] Integration tests for full project creation flow
- [ ] Performance tests
- [ ] CI/CD integration
- [ ] Test coverage reporting

---

**Last Updated:** 2025-11-12  
**Status:** ✅ Implemented and Passing

