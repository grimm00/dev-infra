# ADR-004: Validation Architecture

**Status:** ✅ Accepted  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 2 (Implementation)

---

## Context

Documentation infrastructure needs validation to ensure compliance with template standards. Research identified multiple timing options (pre-commit, on-demand, in-command) and validation patterns from existing scripts. We need to decide on the validation architecture.

**Related Research:**
- [Research: Validation Approach](../../research/template-doc-infrastructure/research-validation-approach.md)
- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - Finding 8

**Related Requirements:**
- FR-19: Validation for document type determination
- FR-20: Validation for required sections per type
- FR-21: Common rule validation (status header, date format, etc.)
- FR-22: Actionable error messages with line numbers
- FR-23: JSON output format for tooling integration
- FR-24: Quiet mode for CI (exit code only)
- FR-25: Single file and directory validation
- NFR-11: Validation completes in <200ms per file
- NFR-12: Clear exit codes (0 success, 1 validation error, 2 system error)
- C-10: Validation in shared library
- C-11: Commands must call CLI, not implement own validation
- C-12: Pre-commit hooks optional

---

## Decision

**Decision:** Adopt a **layered validation architecture with on-demand CLI as primary interface**:

1. **Layer 1:** Shared library (`lib/doc-validate.sh`) with reusable functions
2. **Layer 2:** CLI tool (`dt-doc-validate`) as primary interface
3. **Layer 3:** Command integration (commands call CLI tool)
4. **Timing:** On-demand CLI primary, CI enforcement, pre-commit optional

This approach provides reusable validation logic, clear developer interface, and flexible integration points.

---

## Consequences

### Positive

- **Reusable logic:** Validation functions shared via library
- **Developer control:** On-demand CLI lets developers validate when ready
- **CI enforcement:** GitHub Action validates on PR
- **Flexible timing:** Pre-commit available but optional
- **Clear errors:** Actionable messages with file, location, fix suggestion
- **Multiple outputs:** Text (default), JSON (`--json`), quiet (`--quiet`)

### Negative

- **Not automatic:** Developers may forget to validate (mitigated by CI enforcement)
- **Multiple layers:** Complexity in maintaining library + CLI + integration
- **Learning curve:** Developers must know about dt-doc-validate

---

## Alternatives Considered

### Alternative 1: In-Command Validation Only

**Description:** Each Cursor command validates its own output inline.

**Pros:**
- Immediate feedback
- No external tools needed
- Self-contained commands

**Cons:**
- Duplicated validation logic across 23 commands
- Inconsistent validation rules
- No standalone validation tool

**Why not chosen:** Violates DRY. 23 commands would duplicate validation logic. Changes would require updating all commands.

---

### Alternative 2: Pre-Commit Hook Only

**Description:** Validation runs only as pre-commit hook.

**Pros:**
- Automatic enforcement
- Catches all commits
- No manual invocation needed

**Cons:**
- Delayed feedback (only at commit time)
- Can be bypassed with `--no-verify`
- WIP commits blocked (defeats draft PR workflow)
- Slow commits if validation is heavy

**Why not chosen:** Frustrating for iterative development. Draft PR workflow (ADR-003 worktree) relies on WIP commits. Pre-commit blocking all commits is counterproductive.

---

### Alternative 3: CI-Only Validation

**Description:** Validation runs only in CI pipeline.

**Pros:**
- Guaranteed enforcement on PRs
- No local setup required
- Centralized validation

**Cons:**
- Very delayed feedback (push → CI → feedback)
- Frustrating iteration cycle
- Doesn't catch issues locally

**Why not chosen:** Feedback loop too slow. Developers should be able to validate locally before pushing.

---

### Alternative 4: Layered Validation (On-Demand Primary)

**Description:** Three-layer validation with on-demand CLI as primary:
1. Library (`lib/doc-validate.sh`) - Reusable functions
2. CLI (`dt-doc-validate`) - Primary interface
3. Commands - Call CLI during workflow

**Pros:**
- Developer controls when to validate
- Reusable across contexts (CLI, commands, CI)
- Multiple integration points
- Doesn't block WIP commits

**Cons:**
- Requires developer discipline to validate
- More infrastructure to build

**Why chosen:** Best balance of developer experience and enforcement. On-demand gives control, CI provides enforcement, pre-commit available for those who want it.

---

## Decision Rationale

**Key Factors:**

1. **Draft PR workflow:** WIP commits must not be blocked (per WORKTREE-WORKFLOW.md)
2. **Developer experience:** Immediate feedback when requested, not forced
3. **CI as safety net:** Enforcement happens on PR, not every commit
4. **Reusability:** Library functions can be used anywhere

**Research Support:**

| Finding | Implication |
|---------|-------------|
| Finding 8: Layered validation | Three layers: library → CLI → commands |
| Finding 4: On-demand primary | Developer controls validation timing |
| Finding 5: Pre-commit optional | Available but not required |

---

## Validation Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│ Layer 3: Cursor Commands                                         │
│ - Call dt-doc-validate after generation                         │
│ - Example: /research --conduct → validate before commit         │
│ - Commands are orchestrators, not validators                    │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ invoke
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Layer 2: CLI (dt-doc-validate)                                  │
│ - Primary interface for developers                              │
│ - Accepts file/directory paths                                  │
│ - Returns structured output (text/JSON)                         │
│ - Exit codes: 0=pass, 1=validation error, 2=system error        │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ calls
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Layer 1: Library (lib/doc-validate.sh)                          │
│ - Reusable validation functions                                 │
│ - check_status_header(), check_required_sections()              │
│ - Type-specific validators                                      │
│ - Counter-based result tracking                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Validation Timing

| When | How | Required? | Purpose |
|------|-----|-----------|---------|
| **On-demand** | Developer runs `dt-doc-validate` | Primary | Immediate feedback when desired |
| **In-command** | Commands call CLI after generation | Yes | Context-aware validation |
| **CI** | GitHub Action on PR | Yes | Enforcement gate |
| **Pre-commit** | Hook calls CLI on staged files | Optional | For those who want it |

**Validation flow:**

```
Developer creates/edits doc
         │
         ▼
Command validation (context-aware)
         │ /research --conduct validates
         ▼
On-demand validation (developer choice)
         │ dt-doc-validate research admin/research/my-topic/
         ▼
CI validation (enforcement)
         │ GitHub Action on PR
         ▼
Pre-commit hook (optional)
         │ User-configurable
```

---

## CLI Interface

```bash
# Validate single file
dt-doc-validate admin/research/template-doc-infrastructure/research-summary.md

# Validate directory (all docs)
dt-doc-validate admin/research/template-doc-infrastructure/

# Validate with specific type (override auto-detection)
dt-doc-validate --type exploration admin/explorations/my-topic/

# JSON output for tooling
dt-doc-validate --json admin/research/my-topic/

# Quiet mode for CI (exit code only)
dt-doc-validate --quiet admin/research/my-topic/

# Verbose output (show all checks)
dt-doc-validate --verbose admin/research/my-topic/
```

**Exit codes:**

| Code | Meaning |
|------|---------|
| 0 | All validations passed |
| 1 | Validation errors found |
| 2 | System error (bad args, file not found) |

---

## Validation Rules

### Common Rules (All Doc Types)

| Check | Pattern | Example |
|-------|---------|---------|
| Status Header | `\*\*Status:\*\* [🔴🟠🟡🟢✅]` | `**Status:** 🟠 In Progress` |
| Created Date | `\*\*Created:\*\* \d{4}-\d{2}-\d{2}` | `**Created:** 2026-01-14` |
| Last Updated | `\*\*Last Updated:\*\* \d{4}-\d{2}-\d{2}` | `**Last Updated:** 2026-01-14` |
| Valid Indicator | One of: 🔴 🟠 🟡 🟢 ✅ | Valid emoji in Status |

### Type-Specific Rules

| Doc Type | Required Sections |
|----------|-------------------|
| **Exploration** | `## 🎯 Problem`, `## 🌊 Themes`, `## ❓ Key Questions` |
| **Research** | `## 🎯 Research Question`, `## 📊 Findings`, `## 💡 Recommendations` |
| **ADR** | `## Context`, `## Decision`, `## Consequences` |
| **Hub (README)** | `## 📋 Quick Links` |
| **Feature Plan** | `## 📋 Overview`, `## 🎯 Success Criteria`, `## 📅 Phases` |
| **Handoff** | `## 📍 Current State`, `## 🚀 Next Steps` |

---

## Error Output Format

**Text format (default):**

```
dt-doc-validate admin/research/my-topic/research-summary.md

[ERROR] Missing required section: ## 📊 Findings
  File: admin/research/my-topic/research-summary.md
  Fix:  Add "## 📊 Findings" section after Research Goals

[WARNING] Date may be stale: Last Updated is 30+ days old
  File: admin/research/my-topic/research-summary.md

Summary: 1 error, 1 warning
```

**JSON format (`--json`):**

```json
{
  "file": "admin/research/my-topic/research-summary.md",
  "type": "research-summary",
  "errors": [
    {
      "code": "MISSING_SECTION",
      "message": "Missing required section: ## 📊 Findings",
      "fix": "Add \"## 📊 Findings\" section after Research Goals"
    }
  ],
  "warnings": [
    {
      "code": "STALE_DATE",
      "message": "Date may be stale: Last Updated is 30+ days old"
    }
  ],
  "passed": false
}
```

---

## Library Functions

**`lib/doc-validate.sh`:**

```bash
# Result tracking
declare -a VALIDATION_ERRORS=()
declare -a VALIDATION_WARNINGS=()

# Common checks
check_status_header() { ... }
check_date_format() { ... }
check_required_sections() { ... }

# Type-specific checks
validate_exploration() { ... }
validate_research() { ... }
validate_adr() { ... }

# Result reporting
print_error() { ... }
print_warning() { ... }
generate_report() { ... }
```

---

## Requirements Impact

**Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-19 | Auto-detect doc type from path/content |
| FR-20 | Type-specific section validation |
| FR-21 | Common rules in shared library |
| FR-22 | Errors include file, message, fix suggestion |
| FR-23 | `--json` flag for JSON output |
| FR-24 | `--quiet` flag for exit code only |
| FR-25 | Supports single file and directory |
| NFR-11 | grep/awk checks are fast (<200ms) |
| NFR-12 | Exit codes: 0=pass, 1=error, 2=system |
| C-10 | Logic in `lib/doc-validate.sh` |
| C-11 | Commands call dt-doc-validate |
| C-12 | Pre-commit integration optional |

---

## Implementation Notes

**For dev-toolkit (this feature goes there per ADR-001):**
- Create `dt-doc-validate` CLI script
- Create `lib/doc-validate.sh` shared functions
- Implement type detection logic
- Implement validation rules from ADR-002

**For CI (GitHub Actions):**
- Create workflow that runs `dt-doc-validate`
- Configure to run on PR for relevant paths
- Report validation results in PR comments

**For Pre-commit (optional):**
- Document how to add to `.pre-commit-config.yaml`
- Ensure `--no-verify` bypass works for WIP

---

## References

- [Research: Validation Approach](../../research/template-doc-infrastructure/research-validation-approach.md)
- [ADR-001: Architectural Placement](adr-001-architectural-placement.md)
- [ADR-002: Template Structure Standard](adr-002-template-structure-standard.md)
- [Existing: validate-templates.sh](../../../scripts/validate-templates.sh)
- [Existing: check-release-readiness.sh](../../../scripts/check-release-readiness.sh)

---

**Last Updated:** 2026-01-14
