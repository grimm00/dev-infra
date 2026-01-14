# Research: Validation Approach

**Research Topic:** Template Doc Infrastructure  
**Question:** How should doc validation work (CLI, pre-commit, command checks)?  
**Status:** ✅ Complete  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-14

---

## 🎯 Research Question

How should doc validation work - on-demand CLI validation, automatic pre-commit hooks, or validation within commands? Each has tradeoffs for feedback timing and enforcement.

---

## 🔍 Research Goals

- [x] Goal 1: Define validation rules for each doc type (required sections, field formats)
- [x] Goal 2: Review release-readiness validation patterns
- [x] Goal 3: Evaluate timing options (pre-commit vs on-demand vs in-command)
- [x] Goal 4: Design error message format (actionable, specific)

---

## 📚 Research Methodology

**Sources:**
- [x] Source 1: Analyze `check-release-readiness.sh` validation patterns
- [x] Source 2: Analyze `validate-templates.sh` patterns
- [x] Source 3: Review current documentation patterns in codebase
- [x] Source 4: Evaluate timing options based on existing workflow

---

## 📊 Findings

### Finding 1: Existing Validation Patterns in check-release-readiness.sh

The `check-release-readiness.sh` script provides a mature validation pattern:

**Key patterns:**
| Pattern               | Implementation                    | Benefit                          |
| --------------------- | --------------------------------- | -------------------------------- |
| **Pass/Fail Tracking**| Arrays: `PASSED_CHECKS`, `FAILED_CHECKS` | Aggregates results for report |
| **Status Display**    | `print_status()` with colors      | Clear visual feedback            |
| **Multiple Outputs**  | `--verbose`, `--json`, `--generate` | Flexible for CLI, CI, docs     |
| **Exit Codes**        | 0=success, non-zero=failure type  | CI integration                   |
| **Modular Checks**    | Individual functions per check    | Maintainable, testable           |

**Code pattern from script:**

```bash
add_result() {
    local check_name="$1"
    local passed="$2"
    if [[ "$passed" == "true" ]]; then
        PASSED_CHECKS+=("$check_name")
    else
        FAILED_CHECKS+=("$check_name")
    fi
}
```

**Source:** `scripts/check-release-readiness.sh`

**Relevance:** Proven pattern for aggregating validation results with clear output.

---

### Finding 2: Validation Patterns in validate-templates.sh

The `validate-templates.sh` script shows a counter-based approach:

**Key patterns:**
| Pattern                 | Implementation                          | Benefit                       |
| ----------------------- | --------------------------------------- | ----------------------------- |
| **Counter Tracking**    | `VALIDATION_ERRORS`, `VALIDATION_WARNINGS`, `VALIDATION_SUCCESS` | Summary statistics |
| **Type-Specific Checks**| `validate_standard_template()`, `validate_learning_template()` | Modular per type  |
| **Hub Verification**    | `check_readme_hub()` - verifies README.md in directories | Hub-and-spoke compliance |
| **Link Checking**       | `check_readme_links()` - finds broken internal links | Documentation integrity |
| **Aggregated Report**   | `generate_report()` - summary at end    | Clear pass/fail indication    |

**Source:** `scripts/validate-templates.sh`

**Relevance:** Established pattern for type-specific validation with counters.

---

### Finding 3: Validation Rules by Doc Type

Based on pattern analysis from codebase (`admin/explorations/`, `admin/research/`):

**Common Rules (All Doc Types):**

| Check             | Regex/Pattern                              | Example                                |
| ----------------- | ------------------------------------------ | -------------------------------------- |
| Status Header     | `\*\*Status:\*\* [🔴🟠🟡🟢✅]`            | `**Status:** 🟠 In Progress`           |
| Created Date      | `\*\*Created:\*\* \d{4}-\d{2}-\d{2}`       | `**Created:** 2026-01-14`              |
| Last Updated      | `\*\*Last Updated:\*\* \d{4}-\d{2}-\d{2}` | `**Last Updated:** 2026-01-14`         |
| Status Indicator  | One of: 🔴, 🟠, 🟡, 🟢, ✅                 | Valid emoji in Status header           |

**Type-Specific Rules:**

| Doc Type    | Required Sections                                               |
| ----------- | --------------------------------------------------------------- |
| Exploration | `## 🎯 Problem`, `## 🌊 Themes`, `## ❓ Key Questions`          |
| Research    | `## 🎯 Research Question`, `## 📊 Findings`, `## 💡 Recommendations` |
| ADR         | `## Context`, `## Decision`, `## Consequences`                  |
| Hub (README)| `## 📋 Quick Links`                                             |
| Feature Plan| `## 📋 Overview`, `## 🎯 Success Criteria`, `## 📅 Phases`      |
| Handoff     | `## 📍 Current State`, `## 🚀 Next Steps`                       |

**Source:** Pattern analysis of existing documents in codebase

**Relevance:** Defines the validation ruleset for `dt-doc-validate`.

---

### Finding 4: Timing Options Analysis

Three validation timing options evaluated:

| Timing         | Enforcement    | Feedback Delay | Developer Experience | CI Fit |
| -------------- | -------------- | -------------- | -------------------- | ------ |
| **Pre-commit** | Automatic      | Immediate      | ⚠️ Can be frustrating| ✅     |
| **On-demand**  | Manual (opt-in)| When invoked   | ✅ Non-blocking      | ✅     |
| **In-command** | Per-workflow   | During workflow| ✅ Context-aware     | ❓     |

**Analysis:**

**Pre-commit hooks:**
- ✅ Catches issues before commit
- ⚠️ Slow hooks frustrate developers
- ⚠️ WIP commits blocked (defeats purpose of draft PRs)
- ⚠️ Requires pre-commit framework installation
- **Verdict:** Good for final validation, not WIP

**On-demand CLI:**
- ✅ Developer controls when to validate
- ✅ Fast iteration during development
- ✅ Works standalone or in CI
- ⚠️ Easy to forget
- **Verdict:** Primary approach

**In-command validation:**
- ✅ Context-aware (knows doc type)
- ✅ Validates at meaningful moments (before commit)
- ⚠️ Requires command to trigger
- **Verdict:** Secondary approach (commands call CLI tool)

**Source:** Analysis of workflow patterns and developer experience tradeoffs

**Relevance:** Determines validation integration points.

---

### Finding 5: Error Message Design

Effective validation error messages follow patterns from existing scripts:

**Pattern from `validate-templates.sh`:**
```bash
print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    ((VALIDATION_ERRORS++))
}
```

**Actionable error message format:**
```
[ERROR] Missing required section: ## 📊 Findings
  File: admin/research/template-doc-infrastructure/research-user-demand.md
  Fix:  Add "## 📊 Findings" section after Research Goals
```

**Key principles:**
| Principle         | Implementation                                    |
| ----------------- | ------------------------------------------------- |
| **Specific**      | Name the exact missing section/field              |
| **Located**       | Include file path (clickable in terminal)         |
| **Actionable**    | Suggest how to fix                                |
| **Formatted**     | Use colors, indentation for readability           |

**Source:** Pattern analysis of `validate-templates.sh`, `check-release-readiness.sh`

**Relevance:** Guides error message implementation.

---

### Finding 6: Layered Validation Architecture

Based on architectural placement research (FR-16), validation lives in `dev-toolkit`. A layered approach:

```
┌─────────────────────────────────────────────────────────┐
│  Layer 3: Command Integration                           │
│  Commands call dt-doc-validate as part of workflow      │
│  Example: /research --conduct → validate before commit  │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│  Layer 2: On-demand CLI (dt-doc-validate)               │
│  Primary interface for developers and CI                │
│  Example: dt-doc-validate exploration admin/explorations/my-topic/
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│  Layer 1: Validation Library (lib/validate.sh)          │
│  Reusable validation functions                          │
│  check_status_header(), check_required_sections(), etc. │
└─────────────────────────────────────────────────────────┘
```

**Source:** Architectural analysis, existing script patterns

**Relevance:** Defines how validation components compose.

---

## 🔍 Analysis

**Key Insights:**
- [x] **Insight 1:** On-demand CLI is primary approach; pre-commit is optional enhancement
- [x] **Insight 2:** Commands should call validation CLI rather than duplicating logic
- [x] **Insight 3:** Counter-based tracking with colored output is proven pattern
- [x] **Insight 4:** Type-specific validation requires dispatching to per-type checkers
- [x] **Insight 5:** Error messages must be actionable (file, location, fix suggestion)

**Recommended Validation Flow:**

```
┌────────────────────────────────────────────────────────────┐
│  1. Developer creates/edits doc (AI fills content)         │
└────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌────────────────────────────────────────────────────────────┐
│  2. Command validation (optional, context-aware)           │
│     - /research --conduct → validates before commit        │
│     - /explore → validates on completion                   │
└────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌────────────────────────────────────────────────────────────┐
│  3. On-demand validation (developer choice)                │
│     - dt-doc-validate research admin/research/my-topic/    │
│     - dt-doc-validate --all admin/                         │
└────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌────────────────────────────────────────────────────────────┐
│  4. CI validation (enforcement)                            │
│     - GitHub Action runs dt-doc-validate on PR             │
│     - Fails PR if required docs invalid                    │
└────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌────────────────────────────────────────────────────────────┐
│  5. Pre-commit hook (optional, user-configurable)          │
│     - .pre-commit-config.yaml calls dt-doc-validate        │
│     - Can bypass with --no-verify for WIP                  │
└────────────────────────────────────────────────────────────┘
```

---

## 💡 Recommendations

- [x] **R1:** On-demand CLI (`dt-doc-validate`) as primary interface
- [x] **R2:** Commands invoke validation CLI (don't duplicate logic)
- [x] **R3:** Counter-based tracking with summary report
- [x] **R4:** Type-specific validation dispatching (exploration, research, adr, etc.)
- [x] **R5:** Actionable error messages (file, location, fix suggestion)
- [x] **R6:** CI integration via GitHub Action (enforce on PR)
- [x] **R7:** Pre-commit hook as optional user-configurable enhancement
- [x] **R8:** `--json` output for programmatic parsing
- [x] **R9:** `--quiet` mode for CI (exit code only)

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-19:** Validation CLI must support type-specific validation (exploration, research, adr, feature, handoff)
- **FR-20:** Validation CLI must check common rules (status header, dates, status indicators) for all doc types
- **FR-21:** Validation CLI must check type-specific required sections based on doc type
- **FR-22:** Validation errors must include file path, specific issue, and fix suggestion
- **FR-23:** Validation CLI must support `--json` output for programmatic parsing
- **FR-24:** Validation CLI must support `--quiet` mode (exit code only) for CI scripts
- **FR-25:** Validation CLI must support validating single file or directory recursively

### Non-Functional Requirements

- **NFR-11:** Validation must complete within 1 second per file (fast enough for pre-commit)
- **NFR-12:** Validation must have clear exit codes (0=pass, 1=validation errors, 2=usage error)

### Constraints

- **C-10:** Validation logic must be in shared library (`lib/validate.sh`) for reuse
- **C-11:** Commands must call validation CLI, not implement validation inline
- **C-12:** Pre-commit integration must be optional (not required)

---

## 🚀 Next Steps

1. Add FR-19 through FR-25 to requirements.md
2. Add NFR-11, NFR-12 to requirements.md
3. Add C-10 through C-12 to requirements.md
4. Update research summary with validation findings
5. Continue with Topic 4: Command Integration research

---

**Last Updated:** 2026-01-14
