# Phase 1 Tasks 2-3: Non-Interactive Mode Design and Flag Parsing

**Date:** 2025-12-08  
**Tasks:** Design Non-Interactive Mode Interface + Add Flag Parsing  
**Status:** ✅ Complete

---

## Design Decisions

### 1. Flag Parsing Approach

**Decision:** Use `--non-interactive` flag as explicit control mechanism.

**Implementation:**
- Parse flag at start of `main()` function
- Set `NON_INTERACTIVE_MODE` variable when flag present
- Maintain existing environment variable detection as fallback
- Support `--help` flag to show usage

**Location:** Start of `main()` function (after welcome message, before input collection)

**Code Pattern:**
```bash
# Parse command-line arguments
NON_INTERACTIVE_MODE="false"
if [[ "$1" == "--non-interactive" ]]; then
  NON_INTERACTIVE_MODE="true"
  shift  # Remove flag from arguments
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
  show_help
  exit 0
fi

# Fallback to existing detection (maintain backward compatibility)
if [[ "$NON_INTERACTIVE_MODE" != "true" ]]; then
  if [[ -n "$GITHUB_ACTIONS" || -n "$CI" || -n "$NON_INTERACTIVE" ]]; then
    NON_INTERACTIVE_MODE="true"
  fi
fi
```

---

### 2. Environment Variable Names

**Decision:** Use clear, consistent environment variable names matching ADR-001.

**Required Variables:**
- `PROJECT_NAME` - Project name (required)
- `PROJECT_TYPE` - Template type: `standard-project` or `learning-project` (required)

**Optional Variables:**
- `PROJECT_DESCRIPTION` - Project description (optional)
- `INIT_GIT` - Initialize git repository: `true` or `false` (optional, default: `false`)

**Additional Variables (for non-interactive mode):**
- `TARGET_DIR` - Target directory for project (optional, defaults to `$HOME/Projects` or current directory)
- `AUTHOR` - Author name (optional, defaults to `git config user.name`)

**Reading Pattern:**
```bash
if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
  PROJECT_NAME="${PROJECT_NAME:-}"
  PROJECT_TYPE="${PROJECT_TYPE:-}"
  PROJECT_DESCRIPTION="${PROJECT_DESCRIPTION:-}"
  INIT_GIT="${INIT_GIT:-false}"
  TARGET_DIR="${TARGET_DIR:-}"
  AUTHOR="${AUTHOR:-$(git config user.name 2>/dev/null || echo '')}"
fi
```

---

### 3. Validation Function Structure

**Function Name:** `validate_non_interactive_inputs()`

**Location:** Before `main()` function (around line 520)

**Validation Rules:**
1. `PROJECT_NAME` must be set and not empty
2. `PROJECT_TYPE` must be set and must be `standard-project` or `learning-project`
3. `INIT_GIT` must be `true` or `false` if set (optional, defaults to `false`)
4. `TARGET_DIR` must be valid if provided (optional, uses default if not set)

**Error Handling:**
- Exit with non-zero code (exit 1) on validation errors
- Print clear error messages to stderr
- List all validation errors before exiting (don't stop on first error)

**Implementation Pattern:**
```bash
validate_non_interactive_inputs() {
  local errors=0
  
  if [[ -z "$PROJECT_NAME" ]]; then
    print_error "PROJECT_NAME environment variable is required in non-interactive mode"
    errors=$((errors + 1))
  fi
  
  if [[ -z "$PROJECT_TYPE" ]]; then
    print_error "PROJECT_TYPE environment variable is required in non-interactive mode"
    errors=$((errors + 1))
  elif [[ "$PROJECT_TYPE" != "standard-project" && "$PROJECT_TYPE" != "learning-project" ]]; then
    print_error "PROJECT_TYPE must be 'standard-project' or 'learning-project', got: $PROJECT_TYPE"
    errors=$((errors + 1))
  fi
  
  if [[ -n "$INIT_GIT" && "$INIT_GIT" != "true" && "$INIT_GIT" != "false" ]]; then
    print_error "INIT_GIT must be 'true' or 'false', got: $INIT_GIT"
    errors=$((errors + 1))
  fi
  
  if [[ $errors -gt 0 ]]; then
    exit 1
  fi
}
```

---

### 4. Error Handling Approach

**Exit Codes:**
- `0` - Success
- `1` - Validation error or general error
- `2` - Invalid arguments or usage error

**Error Messages:**
- Use `print_error()` function for consistency
- Include context (which variable, what was expected, what was received)
- Print to stderr (already handled by `print_error()`)
- Provide actionable guidance

**Error Message Examples:**
```bash
# Missing required variable
print_error "PROJECT_NAME environment variable is required in non-interactive mode"

# Invalid value
print_error "PROJECT_TYPE must be 'standard-project' or 'learning-project', got: $PROJECT_TYPE"

# Multiple errors
print_error "Validation failed with $errors error(s). Please fix the issues above."
```

---

### 5. Help Text Design

**Flag:** `--help` or `-h`

**Content:**
- Script description
- Usage examples
- Non-interactive mode documentation
- Environment variables documentation
- Exit codes

**Help Text Structure:**
```bash
show_help() {
  cat << EOF
Usage: $0 [--non-interactive] [--help]

Dev-Infra Project Template Generator
Creates new projects from dev-infra templates

Options:
  --non-interactive    Run in non-interactive mode (reads from environment variables)
  --help, -h          Show this help message

Non-Interactive Mode:
  When --non-interactive flag is used, the script reads inputs from environment variables:
  
  Required:
    PROJECT_NAME         Project name
    PROJECT_TYPE         Template type: standard-project or learning-project
  
  Optional:
    PROJECT_DESCRIPTION  Project description
    INIT_GIT            Initialize git repository: true or false (default: false)
    TARGET_DIR          Target directory (default: \$HOME/Projects or current directory)
    AUTHOR              Author name (default: git config user.name)
  
  Example:
    PROJECT_NAME="my-project" \\
    PROJECT_TYPE="standard-project" \\
    ./scripts/new-project.sh --non-interactive

Exit Codes:
  0  Success
  1  Validation error or general error
  2  Invalid arguments or usage error
EOF
}
```

---

## Implementation Plan

### Step 1: Add Help Function
- Create `show_help()` function before `main()`
- Include usage, options, environment variables, examples

### Step 2: Add Flag Parsing
- Parse `--non-interactive` flag at start of `main()`
- Parse `--help` flag and show help
- Set `NON_INTERACTIVE_MODE` variable
- Maintain existing environment variable detection as fallback

### Step 3: Add Validation Function
- Create `validate_non_interactive_inputs()` function
- Validate all required inputs
- Provide clear error messages
- Exit with non-zero code on errors

### Step 4: Call Validation Early
- Call validation function immediately after flag parsing
- Before any input collection or work begins
- Only call when in non-interactive mode

---

## Backward Compatibility

**Maintained:**
- Default behavior: Interactive mode (no flag = interactive)
- Existing environment variable detection (`GITHUB_ACTIONS`, `CI`, `NON_INTERACTIVE`) still works
- Existing `prompt_yes_no()` function behavior unchanged
- All existing functionality preserved

**Changes:**
- New `--non-interactive` flag available
- New validation function (only called in non-interactive mode)
- New help text (only shown when `--help` flag used)

---

## Testing Plan

### Test Cases

1. **Flag Parsing:**
   ```bash
   ./scripts/new-project.sh --non-interactive --help
   # Should show help including --non-interactive flag
   ```

2. **Help Flag:**
   ```bash
   ./scripts/new-project.sh --help
   # Should show help message
   ```

3. **Backward Compatibility:**
   ```bash
   ./scripts/new-project.sh
   # Should run in interactive mode (prompts for inputs)
   ```

4. **Environment Variable Detection (Fallback):**
   ```bash
   NON_INTERACTIVE=1 ./scripts/new-project.sh
   # Should detect non-interactive mode (existing behavior)
   ```

---

## Design Complete

**Tasks Completed:**
- ✅ Task 2: Design Non-Interactive Mode Interface
- ✅ Task 3: Add Flag Parsing (design complete, implementation next)

**Next Steps:**
- Implement flag parsing in script
- Add help function
- Add validation function
- Test implementation

---

**Last Updated:** 2025-12-08

