# Test Directory Structure Proposal

**Date:** 2025-11-13  
**Purpose:** Propose improved organization for test directory

---

## Current Structure Issues

1. **Flat structure** - 13 test files + helpers + docs all at root level
2. **No clear organization** - Hard to find specific test types
3. **Helpers at root** - Should be in dedicated subdirectory
4. **Documentation mixed** - `comparison-agent-suggestions.md` should be organized

---

## Proposed Structure

```
tests/
├── README.md                          # Main test documentation
├── helpers/                           # Test utilities and helpers
│   ├── helpers.bash                   # Main helper functions
│   └── comparison-agent-suggestions.md # Historical comparison doc
├── unit/                              # Unit tests (individual functions)
│   ├── path-expansion.bats
│   ├── directory-validation.bats
│   ├── project-name-validation.bats
│   ├── file-customization.bats
│   ├── github-auth.bats
│   ├── git-operations.bats
│   └── user-experience.bats
├── integration/                      # Integration tests (multiple functions)
│   ├── integration.bats
│   ├── template-operations.bats
│   └── template-structure.bats
├── regression/                       # Regression tests (bug fixes)
│   ├── regression.bats
│   └── backward-compat.bats
├── smoke/                            # End-to-end smoke tests
│   └── smoke.bats
└── fixtures/                          # Test data (currently empty)
```

---

## Benefits

1. **Clear organization** - Easy to find tests by type
2. **Scalability** - Easy to add new tests in appropriate directories
3. **Standard practice** - Follows common testing directory patterns
4. **Better navigation** - Logical grouping makes maintenance easier
5. **Helper separation** - Helpers clearly separated from test files

---

## Test Categorization

### Unit Tests (7 files)
- Individual function testing
- Isolated behavior validation
- Fast execution

### Integration Tests (3 files)
- Multiple functions working together
- Template operations
- Template structure validation

### Regression Tests (2 files)
- Historical bug fix verification
- Backward compatibility checks

### Smoke Tests (1 file)
- Full script execution
- End-to-end validation

---

## Migration Steps

1. Create subdirectories: `helpers/`, `unit/`, `integration/`, `regression/`, `smoke/`
2. Move `helpers.bash` → `helpers/helpers.bash`
3. Move `comparison-agent-suggestions.md` → `helpers/comparison-agent-suggestions.md`
4. Move test files to appropriate subdirectories
5. Update all `load 'helpers.bash'` → `load 'helpers/helpers.bash'`
6. Update `tests/README.md` with new structure
7. Verify all tests still pass

---

## Running Tests After Restructure

```bash
# Run all tests
bats tests/unit tests/integration tests/regression tests/smoke

# Run specific type
bats tests/unit

# Run specific file
bats tests/unit/path-expansion.bats
```

---

**Status:** ✅ Implemented - Restructure completed 2025-11-13

