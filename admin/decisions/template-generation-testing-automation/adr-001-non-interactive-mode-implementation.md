# ADR-001: Non-Interactive Mode Implementation

**Status:** Proposed  
**Created:** 2025-12-08  
**Last Updated:** 2025-12-08

---

## Context

Template generation script (`scripts/new-project.sh`) currently requires interactive user input for project name, template type, project description, and git initialization. This prevents automated testing and CI/CD integration. A non-interactive mode is needed to enable automated template validation.

**Related Research:**
- [Research Summary](../../research/template-generation-testing-automation/research-summary.md)
- [Non-Interactive Mode Research](../../research/template-generation-testing-automation/research-non-interactive-mode.md)

**Related Requirements:**
- [Requirements Document](../../research/template-generation-testing-automation/requirements.md)
  - FR-1: Non-Interactive Mode Flag
  - FR-2: Environment Variable Support - PROJECT_NAME
  - FR-3: Environment Variable Support - PROJECT_TYPE
  - FR-4: Environment Variable Support - PROJECT_DESCRIPTION
  - FR-5: Environment Variable Support - INIT_GIT
  - NFR-1: Input Validation
  - NFR-2: Error Handling
  - NFR-3: Backward Compatibility

---

## Decision

**Decision:** Implement non-interactive mode using `--non-interactive` flag + environment variables pattern. Script will read from environment variables when flag is set, validate all required inputs early, and maintain backward compatibility with interactive mode as default.

**Implementation Approach:**
1. Add `--non-interactive` flag parsing to script
2. When flag is set, read from environment variables:
   - `PROJECT_NAME` (required)
   - `PROJECT_TYPE` (required, must be `standard-project` or `learning-project`)
   - `PROJECT_DESCRIPTION` (optional)
   - `INIT_GIT` (optional, default: `false`, accepts `true` or `false`)
3. Validate all required inputs before proceeding
4. Exit with non-zero code and clear error messages on validation errors
5. Default to interactive mode when flag not set (backward compatible)

**Note:** Script already has some non-interactive detection logic (checking `GITHUB_ACTIONS`, `CI`, `NON_INTERACTIVE` environment variables), but no explicit `--non-interactive` flag. This decision adds explicit flag support while maintaining existing detection logic.

---

## Consequences

### Positive

- Enables automated template validation
- Supports CI/CD testing integration
- Reduces manual testing burden
- Faster validation process
- Clear interface for automated use
- Maintains backward compatibility

### Negative

- Adds complexity to script (flag parsing, environment variable handling)
- Requires documentation of environment variables
- Must maintain both interactive and non-interactive code paths

---

## Alternatives Considered

### Alternative 1: Environment Variables Only (No Flag)

**Description:** Use environment variables to detect non-interactive mode (check `CI`, `GITHUB_ACTIONS`, etc.), no explicit flag needed.

**Pros:**
- Simpler implementation
- Works automatically in CI environments
- No flag parsing needed

**Cons:**
- Less explicit control
- Harder to test locally
- May trigger non-interactive mode unintentionally
- Doesn't address explicit non-interactive use cases

**Why not chosen:** Explicit flag provides better control and clarity. Current environment variable detection can remain as fallback, but explicit flag is clearer for intentional non-interactive use.

---

### Alternative 2: Config File Approach

**Description:** Read configuration from a file (e.g., `config.json` or `.new-project-config`) instead of environment variables.

**Pros:**
- Can store complex configurations
- Easier to version control
- Can include defaults

**Cons:**
- More complex to implement
- Requires file I/O
- Less flexible for CI/CD (need to create config file)
- Overkill for simple inputs

**Why not chosen:** Environment variables are simpler, more flexible for CI/CD, and standard practice for non-interactive scripts. Config file adds unnecessary complexity.

---

### Alternative 3: Command-Line Arguments Only

**Description:** Use command-line arguments instead of environment variables (e.g., `--project-name`, `--project-type`, etc.).

**Pros:**
- Explicit and clear
- Easy to document
- Standard shell script pattern

**Cons:**
- More verbose command line
- Harder to use in CI/CD (longer commands)
- Less flexible (can't easily override defaults)

**Why not chosen:** Environment variables are more flexible for CI/CD and testing. Can combine with command-line args if needed, but environment variables are sufficient.

---

## Decision Rationale

**Key Factors:**
- **Explicit Control:** `--non-interactive` flag provides clear intent
- **CI/CD Integration:** Environment variables are standard for CI/CD
- **Backward Compatibility:** Default to interactive mode maintains existing behavior
- **Early Validation:** Validate inputs before work begins prevents wasted effort
- **Clear Errors:** Exit codes and error messages enable debugging

**Research Support:**
- Research Finding 2: Shell Script Non-Interactive Patterns - Flag + environment variables is common pattern
- Research Finding 4: Error Handling in Non-Interactive Mode - Early validation and clear errors are essential
- Research Finding 5: Testing Non-Interactive Scripts - Environment variables enable easy testing

**Requirements Alignment:**
- Satisfies FR-1 through FR-5 (all non-interactive mode requirements)
- Satisfies NFR-1, NFR-2, NFR-3 (validation, error handling, backward compatibility)

---

## Requirements Impact

**Requirements Affected:**
- FR-1: Non-Interactive Mode Flag ✅ (implemented via `--non-interactive` flag)
- FR-2: Environment Variable Support - PROJECT_NAME ✅ (implemented)
- FR-3: Environment Variable Support - PROJECT_TYPE ✅ (implemented)
- FR-4: Environment Variable Support - PROJECT_DESCRIPTION ✅ (implemented)
- FR-5: Environment Variable Support - INIT_GIT ✅ (implemented)
- NFR-1: Input Validation ✅ (early validation before proceeding)
- NFR-2: Error Handling ✅ (non-zero exit codes, clear error messages)
- NFR-3: Backward Compatibility ✅ (interactive mode default)

**Requirements Refined:**
- None - all requirements satisfied as specified

---

## Implementation Notes

**Script Changes:**
1. Add flag parsing: `if [[ "$1" == "--non-interactive" ]]; then ...`
2. Add environment variable reading: `PROJECT_NAME="${PROJECT_NAME:-}"`
3. Add validation function: `validate_non_interactive_inputs()`
4. Modify input collection: `if [ "$NON_INTERACTIVE_MODE" = "true" ]; then ... else ... fi`

**Testing:**
- Test with all environment variables set
- Test with missing required variables (should fail)
- Test with invalid PROJECT_TYPE (should fail)
- Test backward compatibility (no flag = interactive mode)

**Documentation:**
- Document `--non-interactive` flag in script help
- Document environment variables in script and CI/CD workflows
- Add usage examples

---

## References

- [Research Summary](../../research/template-generation-testing-automation/research-summary.md)
- [Non-Interactive Mode Research](../../research/template-generation-testing-automation/research-non-interactive-mode.md)
- [Requirements Document](../../research/template-generation-testing-automation/requirements.md)
- [CI/CD Improvement Plan](../../planning/ci/template-generation-testing-automation/improvement-plan.md)

---

**Last Updated:** 2025-12-08

