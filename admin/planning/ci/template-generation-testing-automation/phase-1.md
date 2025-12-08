# Template Generation Testing Automation - Phase 1: Add Non-Interactive Mode

**Phase:** 1 - Add Non-Interactive Mode  
**Duration:** 2-4 hours (Estimated)  
**Status:** ✅ Complete  
**Completed:** 2025-12-08
**Merged:** PR #27 (2025-12-08)
**Prerequisites:** ADR-001 reviewed and approved, requirements reviewed

---

## 📋 Overview

Add non-interactive mode to `scripts/new-project.sh` to enable automated template generation testing. This phase implements the `--non-interactive` flag with environment variable support, allowing the script to run without user interaction for CI/CD integration.

**Success Definition:** Script supports `--non-interactive` flag, reads inputs from environment variables, validates inputs early, maintains backward compatibility, and is fully documented and tested.

---

## 🎯 Goals

1. **Add Non-Interactive Flag** - Implement `--non-interactive` flag parsing in script
2. **Environment Variable Support** - Read PROJECT_NAME, PROJECT_TYPE, PROJECT_DESCRIPTION, INIT_GIT from environment
3. **Input Validation** - Validate all required inputs early with clear error messages
4. **Backward Compatibility** - Maintain interactive mode as default behavior
5. **Documentation** - Document non-interactive mode usage and environment variables

---

## 📝 Tasks

### Process Workflow (Script Enhancement)

#### 1. Review Existing Script Structure

- [ ] Read `scripts/new-project.sh` to understand current structure
- [ ] Identify where user input is collected
- [ ] Identify existing non-interactive detection logic (if any)
- [ ] Review ADR-001: Non-Interactive Mode Implementation
- [ ] Review requirements FR-1 through FR-5, NFR-1, NFR-2, NFR-3

**Current Script Analysis:**

- Note current input collection points
- Note existing environment variable checks (GITHUB_ACTIONS, CI, NON_INTERACTIVE)
- Identify where to add flag parsing

---

#### 2. Design Non-Interactive Mode Interface

- [ ] Design flag parsing approach (`--non-interactive`)
- [ ] Design environment variable names:
  - `PROJECT_NAME` (required)
  - `PROJECT_TYPE` (required, `standard-project` or `learning-project`)
  - `PROJECT_DESCRIPTION` (optional)
  - `INIT_GIT` (optional, default: `false`, accepts `true` or `false`)
- [ ] Design validation function structure (`validate_non_interactive_inputs()`)
- [ ] Design error handling approach (exit codes, error messages)
- [ ] Document design decisions

**Design Notes:**

- Flag should be explicit: `--non-interactive`
- Environment variables should be clear and consistent
- Validation should happen early (before any work begins)
- Error messages should be clear and actionable

---

#### 3. Add Flag Parsing

- [ ] Add `--non-interactive` flag detection at script start
- [ ] Set `NON_INTERACTIVE_MODE` variable when flag is present
- [ ] Maintain existing environment variable detection as fallback
- [ ] Add help text for `--non-interactive` flag
- [ ] Test flag parsing:
  ```bash
  ./scripts/new-project.sh --non-interactive --help
  # Should show help including --non-interactive flag
  ```

**Implementation Example:**

```bash
# Parse command-line arguments
NON_INTERACTIVE_MODE="false"
if [[ "$1" == "--non-interactive" ]]; then
  NON_INTERACTIVE_MODE="true"
  shift  # Remove flag from arguments
fi

# Fallback to existing detection
if [[ -z "$NON_INTERACTIVE_MODE" || "$NON_INTERACTIVE_MODE" == "false" ]]; then
  if [[ -n "$GITHUB_ACTIONS" || -n "$CI" || -n "$NON_INTERACTIVE" ]]; then
    NON_INTERACTIVE_MODE="true"
  fi
fi
```

---

#### 4. Implement Environment Variable Reading

- [ ] Read `PROJECT_NAME` from environment variable
- [ ] Read `PROJECT_TYPE` from environment variable
- [ ] Read `PROJECT_DESCRIPTION` from environment variable (optional)
- [ ] Read `INIT_GIT` from environment variable (optional, default: `false`)
- [ ] Store values in script variables
- [ ] Test environment variable reading:
  ```bash
  PROJECT_NAME="test-project" PROJECT_TYPE="standard-project" \
    ./scripts/new-project.sh --non-interactive
  # Should read from environment variables
  ```

**Implementation Example:**

```bash
if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
  PROJECT_NAME="${PROJECT_NAME:-}"
  PROJECT_TYPE="${PROJECT_TYPE:-}"
  PROJECT_DESCRIPTION="${PROJECT_DESCRIPTION:-}"
  INIT_GIT="${INIT_GIT:-false}"
fi
```

---

#### 5. Implement Input Validation Function

- [x] Create `validate_non_interactive_inputs()` function
- [x] Validate `PROJECT_NAME` is set and not empty
- [x] Validate `PROJECT_TYPE` is set and is `standard-project` or `learning-project`
- [x] Validate `INIT_GIT` is `true` or `false` (if set)
- [x] Exit with non-zero code on validation errors
- [x] Provide clear error messages for each validation failure
- [x] Call validation function early (before any work begins)
- [x] Test validation:

  ```bash
  # Missing PROJECT_NAME
  PROJECT_TYPE="standard-project" ./scripts/new-project.sh --non-interactive
  # Should fail with clear error message

  # Invalid PROJECT_TYPE
  PROJECT_NAME="test" PROJECT_TYPE="invalid" ./scripts/new-project.sh --non-interactive
  # Should fail with clear error message
  ```

**Implementation Example:**

```bash
validate_non_interactive_inputs() {
  local errors=0

  if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: PROJECT_NAME environment variable is required in non-interactive mode" >&2
    errors=$((errors + 1))
  fi

  if [[ -z "$PROJECT_TYPE" ]]; then
    echo "Error: PROJECT_TYPE environment variable is required in non-interactive mode" >&2
    errors=$((errors + 1))
  elif [[ "$PROJECT_TYPE" != "standard-project" && "$PROJECT_TYPE" != "learning-project" ]]; then
    echo "Error: PROJECT_TYPE must be 'standard-project' or 'learning-project', got: $PROJECT_TYPE" >&2
    errors=$((errors + 1))
  fi

  if [[ -n "$INIT_GIT" && "$INIT_GIT" != "true" && "$INIT_GIT" != "false" ]]; then
    echo "Error: INIT_GIT must be 'true' or 'false', got: $INIT_GIT" >&2
    errors=$((errors + 1))
  fi

  if [[ $errors -gt 0 ]]; then
    exit 1
  fi
}
```

---

#### 6. Modify Input Collection Logic

- [x] Update input collection to check `NON_INTERACTIVE_MODE`
- [x] Use environment variables when in non-interactive mode
- [x] Use interactive prompts when in interactive mode (default)
- [x] Ensure both modes work correctly
- [x] Test both modes:

  ```bash
  # Interactive mode (default)
  ./scripts/new-project.sh
  # Should prompt for inputs

  # Non-interactive mode
  PROJECT_NAME="test" PROJECT_TYPE="standard-project" \
    ./scripts/new-project.sh --non-interactive
  # Should use environment variables, no prompts
  ```

**Implementation Example:**

```bash
if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
  # Use environment variables
  # PROJECT_NAME, PROJECT_TYPE, etc. already set
else
  # Interactive prompts
  read -p "Enter project name: " PROJECT_NAME
  # ... etc
fi
```

---

#### 7. Add Error Handling

- [x] Ensure validation errors exit with non-zero code
- [x] Ensure script errors exit with non-zero code
- [x] Provide clear error messages throughout
- [x] Test error handling:

  ```bash
  # Missing required variable
  PROJECT_NAME="test" ./scripts/new-project.sh --non-interactive
  # Should exit with code 1 and error message

  # Invalid project type
  PROJECT_NAME="test" PROJECT_TYPE="invalid" ./scripts/new-project.sh --non-interactive
  # Should exit with code 1 and error message
  ```

---

#### 8. Test Non-Interactive Mode

- [x] Test with all environment variables set:
  ```bash
  PROJECT_NAME="test-project" \
  PROJECT_TYPE="standard-project" \
  PROJECT_DESCRIPTION="Test project" \
  INIT_GIT="false" \
  ./scripts/new-project.sh --non-interactive
  # Should generate project successfully
  ```
- [x] Test with missing required variables (should fail):
  ```bash
  PROJECT_TYPE="standard-project" ./scripts/new-project.sh --non-interactive
  # Should fail with error about missing PROJECT_NAME
  ```
- [x] Test with invalid PROJECT_TYPE (should fail):
  ```bash
  PROJECT_NAME="test" PROJECT_TYPE="invalid" ./scripts/new-project.sh --non-interactive
  # Should fail with error about invalid PROJECT_TYPE
  ```
- [x] Test backward compatibility (no flag = interactive):
  ```bash
  ./scripts/new-project.sh
  # Should prompt for inputs (interactive mode)
  ```
- [x] Test with optional variables:
  ```bash
  PROJECT_NAME="test" PROJECT_TYPE="standard-project" \
    PROJECT_DESCRIPTION="Optional description" \
    INIT_GIT="true" \
    ./scripts/new-project.sh --non-interactive
  # Should use optional values
  ```

---

#### 9. Document Non-Interactive Mode

- [x] Add `--non-interactive` flag to script help text
- [x] Document environment variables in script comments
- [ ] Document environment variables in CI/CD workflow files
- [x] Add usage examples to script or documentation:
  ```bash
  # Example: Non-interactive mode usage
  PROJECT_NAME="my-project" \
  PROJECT_TYPE="standard-project" \
  ./scripts/new-project.sh --non-interactive
  ```
- [ ] Update README or documentation files if they exist

**Documentation Example:**

```bash
# Help text addition
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo "Usage: $0 [--non-interactive]"
  echo ""
  echo "Options:"
  echo "  --non-interactive    Run in non-interactive mode (reads from environment variables)"
  echo ""
  echo "Environment Variables (non-interactive mode):"
  echo "  PROJECT_NAME         Project name (required)"
  echo "  PROJECT_TYPE         Template type: standard-project or learning-project (required)"
  echo "  PROJECT_DESCRIPTION  Project description (optional)"
  echo "  INIT_GIT             Initialize git repository: true or false (optional, default: false)"
  exit 0
fi
```

---

## ✅ Completion Criteria

- [x] `--non-interactive` flag implemented and working
- [x] All environment variables supported (PROJECT_NAME, PROJECT_TYPE, PROJECT_DESCRIPTION, INIT_GIT)
- [x] Early validation function implemented and working
- [x] Error handling implemented with clear messages
- [x] Backward compatibility maintained (interactive mode default)
- [x] All tests passing (manual testing)
- [x] Documentation updated (script help, comments, usage examples)
- [x] Script tested with various inputs (all variables, missing variables, invalid values)
- [x] Non-interactive mode verified in test scenarios

---

## 📦 Deliverables

1. **Script Enhancement**

   - `scripts/new-project.sh` - Updated with non-interactive mode support

2. **Documentation**

   - Script help text updated
   - Environment variables documented
   - Usage examples added

3. **Testing**
   - Manual test results documented
   - Test scenarios verified

---

## 🔗 Dependencies

### Prerequisites

- ✅ ADR-001: Non-Interactive Mode Implementation reviewed and approved
- ✅ Requirements FR-1 through FR-5, NFR-1, NFR-2, NFR-3 reviewed
- ✅ Existing script structure understood

### External Dependencies

- None (uses existing script and shell environment)

### Blocks

- Phase 2: Create Template Validation Test Suite - Requires non-interactive mode to be available

---

## ⚠️ Risks

**Risk: Breaking Existing Interactive Mode**  
**Probability:** Low  
**Impact:** High  
**Mitigation:** Maintain backward compatibility, test interactive mode thoroughly, use feature flag pattern  
**Contingency:** Revert changes if interactive mode breaks, fix and retest

**Risk: Environment Variable Conflicts**  
**Probability:** Low  
**Impact:** Medium  
**Mitigation:** Use clear, specific environment variable names, document usage  
**Contingency:** Rename variables if conflicts occur

---

## 📊 Progress Tracking

**Phase Status:** 🔴 Not Started

**Design & Planning (0/2 complete)**

- [ ] Review existing script structure
- [ ] Design non-interactive mode interface

**Implementation (0/4 complete)**

- [ ] Add flag parsing
- [ ] Implement environment variable reading
- [ ] Implement input validation function
- [ ] Modify input collection logic

**Testing & Documentation (0/3 complete)**

- [ ] Test non-interactive mode
- [ ] Add error handling
- [ ] Document non-interactive mode

---

## 💡 Implementation Notes

### Process Workflow

**For Script Enhancement:**

1. Review existing script structure → Understand current implementation
2. Design non-interactive mode interface → Plan changes
3. Implement flag parsing → Add flag detection
4. Implement environment variable reading → Read from environment
5. Implement validation → Validate inputs early
6. Modify input collection → Use environment variables or prompts
7. Test thoroughly → Verify both modes work
8. Document → Add help text and examples

### Script Pattern

**Flag Parsing:**

```bash
# Parse --non-interactive flag
if [[ "$1" == "--non-interactive" ]]; then
  NON_INTERACTIVE_MODE="true"
  shift
fi
```

**Environment Variable Reading:**

```bash
# Read from environment with defaults
PROJECT_NAME="${PROJECT_NAME:-}"
PROJECT_TYPE="${PROJECT_TYPE:-}"
PROJECT_DESCRIPTION="${PROJECT_DESCRIPTION:-}"
INIT_GIT="${INIT_GIT:-false}"
```

**Early Validation:**

```bash
# Validate before proceeding
validate_non_interactive_inputs
if [[ $? -ne 0 ]]; then
  exit 1
fi
```

### Testing Pattern

**Manual Testing:**

```bash
# Test non-interactive mode
PROJECT_NAME="test-project" \
PROJECT_TYPE="standard-project" \
./scripts/new-project.sh --non-interactive

# Test validation
PROJECT_TYPE="standard-project" ./scripts/new-project.sh --non-interactive
# Should fail: missing PROJECT_NAME

# Test backward compatibility
./scripts/new-project.sh
# Should prompt for inputs
```

### Script Testing Commands

```bash
# Test flag parsing
./scripts/new-project.sh --non-interactive --help

# Test with all variables
PROJECT_NAME="test" PROJECT_TYPE="standard-project" \
  PROJECT_DESCRIPTION="Test" INIT_GIT="false" \
  ./scripts/new-project.sh --non-interactive

# Test missing required variable
PROJECT_TYPE="standard-project" ./scripts/new-project.sh --non-interactive

# Test invalid PROJECT_TYPE
PROJECT_NAME="test" PROJECT_TYPE="invalid" ./scripts/new-project.sh --non-interactive

# Test backward compatibility
./scripts/new-project.sh
```

---

## 🔗 Related Documents

- [Phase 2: Create Template Validation Test Suite](phase-2.md)
- [Transition Plan](transition-plan.md)
- [Improvement Plan](improvement-plan.md)
- [ADR-001: Non-Interactive Mode Implementation](../../../decisions/template-generation-testing-automation/adr-001-non-interactive-mode-implementation.md)
- [Requirements Document](../../../research/template-generation-testing-automation/requirements.md)
- [CI/CD Planning Hub](../README.md)

---

**Last Updated:** 2025-12-08  
**Status:** 🔴 Not Started  
**Approach:** Process/Documentation Workflow (CI/CD Improvement)  
**Next:** Begin after prerequisites met, use `/task-improvement` command to implement
