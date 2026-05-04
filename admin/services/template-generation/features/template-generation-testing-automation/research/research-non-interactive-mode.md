# Research: Non-Interactive Mode for Template Generation Script

**Research Topic:** Template Generation Testing Automation  
**Question:** How to add non-interactive mode to template generation script?  
**Status:** 🔴 Research  
**Created:** 2025-12-08  
**Last Updated:** 2025-12-08

---

## 🎯 Research Question

How can we add a non-interactive mode to `scripts/new-project.sh` that supports automated testing using environment variables instead of requiring user input?

---

## 🔍 Research Goals

- [ ] Goal 1: Understand current script structure and input requirements
- [ ] Goal 2: Identify best practices for non-interactive shell scripts
- [ ] Goal 3: Design non-interactive mode interface (flags and environment variables)
- [ ] Goal 4: Determine how to handle validation and error handling in non-interactive mode
- [ ] Goal 5: Identify testing patterns for non-interactive scripts

---

## 📚 Research Methodology

**Sources:**
- [ ] Source 1: Current `scripts/new-project.sh` implementation
- [ ] Source 2: Shell script best practices for non-interactive mode
- [ ] Source 3: Existing test patterns in `tests/integration/template-operations.bats`
- [ ] Source 4: CI/CD integration patterns for shell scripts

---

## 📊 Findings

### Finding 1: Current Script Structure

**Description:**
The current `scripts/new-project.sh` script uses interactive prompts via `read -p` commands. It collects:
- Project name (with validation)
- Template type selection (standard-project or learning-project)
- Project description (optional)
- Git initialization choice (yes/no)

**Source:** `scripts/new-project.sh` lines 37-49

**Relevance:**
Understanding current input collection is essential for designing non-interactive mode.

---

### Finding 2: Shell Script Non-Interactive Patterns

**Description:**
Common patterns for non-interactive shell scripts:
1. **Flag-based:** Use `--non-interactive` or `--batch` flag
2. **Environment variables:** Read from `$PROJECT_NAME`, `$PROJECT_TYPE`, etc.
3. **Config file:** Read from configuration file
4. **Combination:** Flag + environment variables (most flexible)

**Best Practice:**
- Use `--non-interactive` flag to enable mode
- Read from environment variables when flag is set
- Fall back to interactive prompts if variables not set (for backward compatibility)
- Validate all required inputs before proceeding

**Relevance:**
Provides design pattern for non-interactive mode implementation.

---

### Finding 3: Environment Variable Naming Convention

**Description:**
Standard environment variable naming:
- Uppercase with underscores: `PROJECT_NAME`, `PROJECT_TYPE`
- Descriptive names matching script parameters
- Optional variables can have defaults

**Proposed Variables:**
- `PROJECT_NAME` - Required, project name
- `PROJECT_TYPE` - Required, template type (standard-project, learning-project)
- `PROJECT_DESCRIPTION` - Optional, project description
- `INIT_GIT` - Optional, initialize git (true/false, default: false)
- `OUTPUT_DIR` - Optional, output directory (default: current directory)

**Relevance:**
Defines interface for non-interactive mode.

---

### Finding 4: Error Handling in Non-Interactive Mode

**Description:**
Non-interactive scripts should:
- Exit with non-zero code on errors
- Provide clear error messages to stderr
- Validate all inputs before starting work
- Not prompt for missing required inputs (fail fast)

**Pattern:**
```bash
if [ "$NON_INTERACTIVE" = "true" ]; then
    if [ -z "$PROJECT_NAME" ]; then
        echo "Error: PROJECT_NAME required in non-interactive mode" >&2
        exit 1
    fi
    # Use environment variables
else
    # Use interactive prompts
fi
```

**Relevance:**
Ensures robust error handling for automated use.

---

### Finding 5: Testing Non-Interactive Scripts

**Description:**
Testing patterns for non-interactive scripts:
1. Set environment variables
2. Run script with `--non-interactive` flag
3. Verify output and exit code
4. Test error cases (missing variables, invalid values)

**Example:**
```bash
PROJECT_NAME="test-project" \
PROJECT_TYPE="standard-project" \
INIT_GIT="false" \
./scripts/new-project.sh --non-interactive
```

**Relevance:**
Enables automated testing of non-interactive mode.

---

## 🔍 Analysis

**Key Insights:**
- [ ] Insight 1: Flag + environment variables provides best flexibility
- [ ] Insight 2: Backward compatibility maintained by defaulting to interactive mode
- [ ] Insight 3: Validation must happen before any work begins
- [ ] Insight 4: Error messages should be clear for CI/CD debugging

**Implementation Approach:**
1. Add `--non-interactive` flag parsing
2. Check flag, if set, read from environment variables
3. Validate all required variables are set
4. Proceed with generation using provided values
5. Maintain backward compatibility (interactive mode default)

---

## 💡 Recommendations

- [ ] Recommendation 1: Use `--non-interactive` flag + environment variables pattern
- [ ] Recommendation 2: Support all current inputs via environment variables
- [ ] Recommendation 3: Validate inputs early and fail fast with clear errors
- [ ] Recommendation 4: Maintain backward compatibility (interactive mode default)
- [ ] Recommendation 5: Document environment variables in script help/usage

---

## 📋 Requirements Discovered

- [ ] FR-1: Script must support `--non-interactive` flag
- [ ] FR-2: Script must read `PROJECT_NAME` from environment variable in non-interactive mode
- [ ] FR-3: Script must read `PROJECT_TYPE` from environment variable in non-interactive mode
- [ ] FR-4: Script must read `PROJECT_DESCRIPTION` from environment variable (optional)
- [ ] FR-5: Script must read `INIT_GIT` from environment variable (optional, default: false)
- [ ] NFR-1: Script must validate all required inputs before proceeding
- [ ] NFR-2: Script must exit with non-zero code on validation errors
- [ ] NFR-3: Script must provide clear error messages to stderr
- [ ] C-1: Must maintain backward compatibility (interactive mode default)
- [ ] A-1: Environment variables only used when `--non-interactive` flag is set

---

## 🚀 Next Steps

1. Review findings with script maintainer
2. Design detailed implementation plan
3. Implement non-interactive mode
4. Test with various inputs
5. Document usage in script and CI/CD workflows

---

**Last Updated:** 2025-12-08

