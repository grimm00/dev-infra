# Phase 1 Task 1: Script Structure Analysis

**Date:** 2025-12-08  
**Task:** Review Existing Script Structure  
**Status:** ✅ Complete

---

## Script Overview

**File:** `scripts/new-project.sh`  
**Purpose:** Interactive project template generator  
**Lines:** 703 total

---

## Current Input Collection Points

### 1. Target Directory (Line 542)
- **Function:** `prompt_input()`
- **Variable:** `target_dir`
- **Default:** `$HOME/Projects` or current directory
- **Validation:** `validate_target_directory()` function (lines 106-189)
- **Location:** Main function, early in flow

### 2. Project Name (Line 639)
- **Function:** `prompt_input()`
- **Variable:** `project_name`
- **Validation:** `validate_project_name()` function (lines 192-238)
- **Location:** Main function, after directory selection
- **Notes:** Includes whitespace sanitization logic

### 3. Project Description (Line 649)
- **Function:** `prompt_input()`
- **Variable:** `description`
- **No validation** (free-form text)
- **Location:** Main function, after project name

### 4. Author Name (Line 650)
- **Function:** `prompt_input()`
- **Variable:** `author`
- **Default:** `git config user.name` or empty
- **No validation** (free-form text)
- **Location:** Main function, after description

### 5. Project Type Selection (Lines 659-677)
- **Function:** `read` loop with case statement
- **Variable:** `project_type_choice` (1 or 2)
- **Maps to:** `project_type` ("Standard Project" or "Learning Project") and `template_type` ("standard-project" or "learning-project")
- **Location:** Main function, after author
- **Notes:** Menu-driven selection (1 or 2)

### 6. Project Creation Confirmation (Line 689)
- **Function:** `prompt_yes_no()`
- **Variable:** Confirmation result
- **Default:** "y"
- **Location:** Main function, before project creation

### 7. Git Initialization Confirmation (Line 435)
- **Function:** `prompt_yes_no()`
- **Variable:** Confirmation result
- **Default:** "y"
- **Location:** `init_git_repo()` function

### 8. GitHub Repository Creation Confirmation (Line 450)
- **Function:** `prompt_yes_no()`
- **Variable:** Confirmation result
- **Default:** "n"
- **Location:** `init_git_repo()` function

---

## Existing Non-Interactive Detection Logic

### Location: `prompt_yes_no()` Function (Lines 52-85)

**Current Detection (Line 63):**
```bash
if [ -n "$GITHUB_ACTIONS" ] || [ -n "$CI" ] || [ -n "$NON_INTERACTIVE" ] || [ ! -t 0 ] || [ -n "$BATS_RUN_TMPDIR" ]; then
```

**Checks:**
1. `GITHUB_ACTIONS` - GitHub Actions specific
2. `CI` - Generic CI systems
3. `NON_INTERACTIVE` - Explicit flag (already exists!)
4. `[ ! -t 0 ]` - Terminal check (no stdin)
5. `BATS_RUN_TMPDIR` - Bats test framework

**Behavior:**
- Returns default value when non-interactive detected
- Only affects `prompt_yes_no()` function
- Does NOT affect `prompt_input()` function (still prompts)

**Limitations:**
- Only works for yes/no prompts
- Does not handle text input (`prompt_input()`)
- No explicit `--non-interactive` flag
- No early validation of required inputs
- No environment variable reading for project details

---

## Where to Add Flag Parsing

### Recommended Location: Start of `main()` Function

**Current Structure:**
- Line 523: `main()` function starts
- Line 524-526: Welcome message
- Line 529: Default directory setup
- Line 542: First input collection (target directory)

**Best Place:** After welcome message, before any input collection (around line 527)

**Implementation Point:**
```bash
main() {
    echo "🚀 Dev-Infra Project Template Generator"
    echo "======================================"
    echo
    
    # ADD FLAG PARSING HERE
    # Parse --non-interactive flag
    # Set NON_INTERACTIVE_MODE variable
    # Read environment variables if flag set
    # Validate inputs early
    
    # Determine default directory
    local DEFAULT_DIR="$HOME/Projects"
    # ... rest of function
}
```

---

## Environment Variables Needed

Based on ADR-001 and current script analysis:

1. **PROJECT_NAME** (required)
   - Maps to: `project_name` variable (line 639)
   - Current: Collected via `prompt_input()`

2. **PROJECT_TYPE** (required)
   - Maps to: `template_type` variable ("standard-project" or "learning-project")
   - Current: Collected via menu selection (lines 659-677)
   - Note: Script uses "Standard Project" / "Learning Project" internally, but template_type uses "standard-project" / "learning-project"

3. **PROJECT_DESCRIPTION** (optional)
   - Maps to: `description` variable (line 649)
   - Current: Collected via `prompt_input()`

4. **INIT_GIT** (optional, default: false)
   - Maps to: Git initialization confirmation (line 435)
   - Current: Collected via `prompt_yes_no()`
   - Note: Also affects GitHub repo creation (line 450)

**Additional Considerations:**
- `TARGET_DIR` - Not in ADR, but needed for non-interactive mode
- `AUTHOR` - Not in ADR, but currently collected

---

## Validation Function Location

### Recommended: Create `validate_non_interactive_inputs()` Function

**Location:** Before `main()` function (around line 520)

**Should Validate:**
1. `PROJECT_NAME` is set and not empty
2. `PROJECT_TYPE` is set and is "standard-project" or "learning-project"
3. `INIT_GIT` is "true" or "false" (if set)
4. `TARGET_DIR` is valid (if provided, or use default)

**Call Location:** Early in `main()` function, after flag parsing, before any work begins

---

## Key Findings

### ✅ Existing Non-Interactive Support
- `prompt_yes_no()` already has non-interactive detection
- Checks `NON_INTERACTIVE` environment variable
- Works for yes/no prompts only

### ❌ Missing Features
- No explicit `--non-interactive` flag
- No environment variable reading for project details
- No early validation of required inputs
- `prompt_input()` does not support non-interactive mode
- No way to provide project name, type, description via environment variables

### 📝 Implementation Notes
- Need to add flag parsing at start of `main()`
- Need to read environment variables when flag is set
- Need to create validation function
- Need to modify input collection logic to use environment variables when in non-interactive mode
- Need to maintain backward compatibility (interactive mode default)
- Can reuse existing `NON_INTERACTIVE` environment variable check as fallback

---

## Next Steps

1. ✅ Review existing script structure - **COMPLETE**
2. Design non-interactive mode interface
3. Add flag parsing
4. Implement environment variable reading
5. Implement input validation function
6. Modify input collection logic
7. Test non-interactive mode
8. Document non-interactive mode

---

**Last Updated:** 2025-12-08

