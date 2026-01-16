# Validation Rules Specification

**Purpose:** Define validation rules for `dt-doc-validate` implementation in dev-toolkit.  
**Target Audience:** Tooling implementers (dev-toolkit team)  
**Status:** ✅ Active  
**Created:** 2026-01-16  
**Last Updated:** 2026-01-16

---

## 📋 Overview

This document specifies the validation rules that `dt-doc-validate` must implement to ensure documentation complies with template standards. Rules are organized into **common rules** (applicable to all doc types) and **type-specific rules** (per document category).

**Architecture Reference:** [ADR-004: Validation Architecture](../../../admin/decisions/template-doc-infrastructure/adr-004-validation-architecture.md)

---

## 🎯 Key Principles

1. **Layered Validation:** Library functions → CLI tool → Command integration
2. **On-Demand Primary:** Developers control when to validate
3. **Actionable Errors:** Every error includes file, message, and fix suggestion
4. **Multiple Outputs:** Text (default), JSON (`--json`), quiet (`--quiet`)
5. **Fast Execution:** <200ms per file target (grep/awk based)

---

## 📊 Common Rules (All Doc Types)

These rules apply to **every document type** generated from templates.

### Rule: Status Header

**Description:** Every document must have a valid status header in the metadata block.

| Property | Value |
|----------|-------|
| **Rule ID** | `COMMON_STATUS_HEADER` |
| **Severity** | ERROR |
| **Pattern** | `^\*\*Status:\*\*\s+[🔴🟠🟡🟢✅]` |
| **Example (Valid)** | `**Status:** 🟠 In Progress` |
| **Example (Invalid)** | `**Status:** Started` (missing emoji) |
| **Error Message** | `Missing or invalid status header` |
| **Fix Suggestion** | `Add "**Status:** [emoji] [text]" with valid status emoji` |

**Valid Status Indicators:**

| Emoji | Text | Meaning |
|-------|------|---------|
| 🔴 | Not Started / Scaffolding | Work not yet begun or initial scaffold |
| 🟠 | In Progress | Active work underway |
| 🟡 | Planned / On Hold | Planned but not started, or temporarily paused |
| 🟢 | Review | Ready for review or in review |
| ✅ | Complete / Active / Accepted | Finished, operational, or approved |

**Regex Pattern (PCRE):**

```regex
^\*\*Status:\*\*\s+[🔴🟠🟡🟢✅].*$
```

**Implementation Notes:**
- Match at line start (`^`)
- Allow any text after the emoji (e.g., "In Progress", "Complete", "Active")
- Case-insensitive text matching not required (text is human-readable, emoji is machine-checked)

---

### Rule: Created Date

**Description:** Every document must have a Created date in ISO 8601 format (YYYY-MM-DD).

| Property | Value |
|----------|-------|
| **Rule ID** | `COMMON_CREATED_DATE` |
| **Severity** | ERROR |
| **Pattern** | `^\*\*Created:\*\*\s+\d{4}-\d{2}-\d{2}` |
| **Example (Valid)** | `**Created:** 2026-01-16` |
| **Example (Invalid)** | `**Created:** Jan 16, 2026` (wrong format) |
| **Error Message** | `Missing or invalid Created date` |
| **Fix Suggestion** | `Add "**Created:** YYYY-MM-DD" with ISO date format` |

**Regex Pattern (PCRE):**

```regex
^\*\*Created:\*\*\s+\d{4}-\d{2}-\d{2}\s*$
```

**Implementation Notes:**
- Match at line start (`^`)
- Four-digit year, two-digit month, two-digit day
- No validation of actual date validity (e.g., 2026-13-45 would match but is invalid)
- Consider adding semantic date validation as WARNING level

---

### Rule: Last Updated Date

**Description:** Every document must have a Last Updated date in ISO 8601 format (YYYY-MM-DD).

| Property | Value |
|----------|-------|
| **Rule ID** | `COMMON_LAST_UPDATED` |
| **Severity** | ERROR |
| **Pattern** | `^\*\*Last Updated:\*\*\s+\d{4}-\d{2}-\d{2}` |
| **Example (Valid)** | `**Last Updated:** 2026-01-16` |
| **Example (Invalid)** | `**Last Updated:** today` (wrong format) |
| **Error Message** | `Missing or invalid Last Updated date` |
| **Fix Suggestion** | `Add "**Last Updated:** YYYY-MM-DD" with ISO date format` |

**Regex Pattern (PCRE):**

```regex
^\*\*Last Updated:\*\*\s+\d{4}-\d{2}-\d{2}\s*$
```

**Implementation Notes:**
- Same format requirements as Created date
- Should be >= Created date (validation as WARNING)

---

### Rule: Stale Date Warning

**Description:** Documents with Last Updated date >30 days old should trigger a warning.

| Property | Value |
|----------|-------|
| **Rule ID** | `COMMON_STALE_DATE` |
| **Severity** | WARNING |
| **Condition** | `Last Updated date is >30 days from current date` |
| **Example (Triggers)** | `**Last Updated:** 2025-11-01` (if today is 2026-01-16) |
| **Warning Message** | `Date may be stale: Last Updated is 30+ days old` |
| **Fix Suggestion** | `Review document and update "**Last Updated:** YYYY-MM-DD" if still accurate` |

**Implementation Notes:**
- Calculate days between Last Updated and current date
- 30-day threshold is configurable (environment variable or config)
- This is a WARNING, not an ERROR (document may be intentionally stable)

---

### Rule: Valid Status Indicator

**Description:** Status emoji must be one of the five valid indicators.

| Property | Value |
|----------|-------|
| **Rule ID** | `COMMON_VALID_INDICATOR` |
| **Severity** | ERROR |
| **Valid Values** | `🔴`, `🟠`, `🟡`, `🟢`, `✅` |
| **Example (Valid)** | `**Status:** ✅ Active` |
| **Example (Invalid)** | `**Status:** ⚪ Pending` (invalid emoji) |
| **Error Message** | `Invalid status indicator: [found emoji]` |
| **Fix Suggestion** | `Use one of: 🔴 🟠 🟡 🟢 ✅` |

**Implementation Notes:**
- This rule is often checked alongside `COMMON_STATUS_HEADER`
- Extract emoji from status line and validate against allowed set
- Unicode handling may require care depending on implementation language

---

## 📊 Common Rules Summary Table

| Rule ID | Severity | Pattern/Check | Example |
|---------|----------|---------------|---------|
| `COMMON_STATUS_HEADER` | ERROR | `\*\*Status:\*\* [emoji]` | `**Status:** 🟠 In Progress` |
| `COMMON_CREATED_DATE` | ERROR | `\*\*Created:\*\* YYYY-MM-DD` | `**Created:** 2026-01-16` |
| `COMMON_LAST_UPDATED` | ERROR | `\*\*Last Updated:\*\* YYYY-MM-DD` | `**Last Updated:** 2026-01-16` |
| `COMMON_STALE_DATE` | WARNING | Last Updated >30 days old | — |
| `COMMON_VALID_INDICATOR` | ERROR | Emoji in {🔴🟠🟡🟢✅} | — |

---

## 🔍 Validation Logic

### Order of Checks

Common rules should be checked in this order:

1. **Status Header** (`COMMON_STATUS_HEADER`) - Fail fast if no status
2. **Valid Indicator** (`COMMON_VALID_INDICATOR`) - Check emoji validity
3. **Created Date** (`COMMON_CREATED_DATE`) - Check date presence/format
4. **Last Updated** (`COMMON_LAST_UPDATED`) - Check date presence/format
5. **Stale Date** (`COMMON_STALE_DATE`) - Warning if outdated

### Short-Circuit Behavior

- If `COMMON_STATUS_HEADER` fails, `COMMON_VALID_INDICATOR` should be skipped (no emoji to validate)
- All other rules are independent and should be checked regardless of previous failures

### Multi-File Validation

When validating a directory:

1. Discover all `.md` files in directory (recursive optional)
2. For each file, run common rules + type-specific rules
3. Aggregate results
4. Report per-file and summary statistics

---

## 📑 Type-Specific Rules

Each document type has additional required sections beyond the common rules. Document type is detected from:
1. **Path-based detection:** Directory structure (e.g., `admin/explorations/` → Exploration)
2. **Content-based detection:** Title patterns (e.g., `# ADR-NNN:` → ADR)
3. **Override flag:** `--type` CLI option

---

### Exploration Documents

**Path Pattern:** `admin/explorations/[topic]/exploration.md`

**Document Subtypes:**

| Subtype | File Pattern | Required Sections |
|---------|--------------|-------------------|
| **Exploration** | `exploration.md` | What We're Exploring, Themes, Key Questions |
| **Research Topics** | `research-topics.md` | Topics Identified |
| **Exploration Hub** | `README.md` | Quick Links, Overview |

#### Exploration (Main Document)

| Property | Value |
|----------|-------|
| **Rule ID** | `EXPLORATION_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| What We're Exploring | `^## 🎯 What We're Exploring` | Missing "What We're Exploring" section | Add `## 🎯 What We're Exploring` section after metadata |
| Themes | `^## 🔍 Themes` | Missing "Themes" section | Add `## 🔍 Themes` section |
| Key Questions | `^## ❓ Key Questions` | Missing "Key Questions" section | Add `## ❓ Key Questions` section |

**Optional Sections:**
- `## 💡 Initial Thoughts`
- `## 🚀 Next Steps`
- `## 🔗 Related`

#### Exploration Hub (README.md)

| Property | Value |
|----------|-------|
| **Rule ID** | `EXPLORATION_HUB_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Quick Links | `^## 📋 Quick Links` | Missing "Quick Links" section | Add `## 📋 Quick Links` section |
| Overview | `^## 🎯 Overview` | Missing "Overview" section | Add `## 🎯 Overview` section |

---

### Research Documents

**Path Pattern:** `admin/research/[topic]/`

**Document Subtypes:**

| Subtype | File Pattern | Required Sections |
|---------|--------------|-------------------|
| **Research Topic** | `research-*.md` | Research Question, Findings, Recommendations |
| **Research Summary** | `research-summary.md` | Research Overview, Key Insights, Recommendations |
| **Requirements** | `requirements.md` | Overview, Functional Requirements |
| **Research Hub** | `README.md` | Quick Links, Research Overview |

#### Research Topic

| Property | Value |
|----------|-------|
| **Rule ID** | `RESEARCH_TOPIC_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Research Question | `^## 🎯 Research Question` | Missing "Research Question" section | Add `## 🎯 Research Question` section after metadata |
| Findings | `^## 📊 Findings` | Missing "Findings" section | Add `## 📊 Findings` section |
| Recommendations | `^## 💡 Recommendations` | Missing "Recommendations" section | Add `## 💡 Recommendations` section |

**Optional Sections:**
- `## 📋 Requirements Discovered`
- `## 🚀 Next Steps`

#### Research Summary

| Property | Value |
|----------|-------|
| **Rule ID** | `RESEARCH_SUMMARY_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Research Overview | `^## 📋 Research Overview` | Missing "Research Overview" section | Add `## 📋 Research Overview` section |
| Key Insights | `^## 💡 Key Insights` | Missing "Key Insights" section | Add `## 💡 Key Insights` section |
| Recommendations | `^## 🎯 Recommendations` | Missing "Recommendations" section | Add `## 🎯 Recommendations` section |

#### Requirements Document

| Property | Value |
|----------|-------|
| **Rule ID** | `REQUIREMENTS_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Overview | `^## 📋 Overview` | Missing "Overview" section | Add `## 📋 Overview` section |
| Non-Functional Requirements | `^## 🎯 Non-Functional Requirements` | Missing "Non-Functional Requirements" section | Add `## 🎯 Non-Functional Requirements` section |

**Note:** Functional Requirements section uses format `### FR-NN:` (inline, not section header)

#### Research Hub (README.md)

| Property | Value |
|----------|-------|
| **Rule ID** | `RESEARCH_HUB_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Quick Links | `^## 📋 Quick Links` | Missing "Quick Links" section | Add `## 📋 Quick Links` section |
| Research Overview | `^## 🎯 Research Overview` | Missing "Research Overview" section | Add `## 🎯 Research Overview` section |

---

### Decision Documents (ADRs)

**Path Pattern:** `admin/decisions/[topic]/`

**Document Subtypes:**

| Subtype | File Pattern | Required Sections |
|---------|--------------|-------------------|
| **ADR** | `adr-NNN-*.md` | Context, Decision, Consequences |
| **Decisions Summary** | `decisions-summary.md` | Decisions Overview, Key Decisions |
| **Decision Hub** | `README.md` | Quick Links, Decisions Overview |

#### ADR (Architectural Decision Record)

| Property | Value |
|----------|-------|
| **Rule ID** | `ADR_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Context | `^## Context` | Missing "Context" section | Add `## Context` section after metadata |
| Decision | `^## Decision` | Missing "Decision" section | Add `## Decision` section |
| Consequences | `^## Consequences` | Missing "Consequences" section | Add `## Consequences` section |

**Optional Sections:**
- `## Alternatives Considered`
- `## Decision Rationale`
- `## Requirements Impact`
- `## References`

**ADR-Specific Rules:**

| Rule ID | Severity | Pattern | Error Message |
|---------|----------|---------|---------------|
| `ADR_TITLE_FORMAT` | ERROR | `^# ADR-\d{3}:` | ADR title must follow format "# ADR-NNN: Title" |
| `ADR_BATCH_FIELD` | WARNING | `^\*\*Batch:\*\*` | ADR should include Batch field in metadata |

#### Decisions Summary

| Property | Value |
|----------|-------|
| **Rule ID** | `DECISIONS_SUMMARY_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Decisions Overview | `^## 📋 Decisions Overview` | Missing "Decisions Overview" section | Add `## 📋 Decisions Overview` section |
| Key Decisions | `^## 🎯 Key Decisions` | Missing "Key Decisions" section | Add `## 🎯 Key Decisions` section |

#### Decision Hub (README.md)

| Property | Value |
|----------|-------|
| **Rule ID** | `DECISION_HUB_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Quick Links | `^## 📋 Quick Links` | Missing "Quick Links" section | Add `## 📋 Quick Links` section |
| Decisions Overview | `^## 🎯 Decisions Overview` | Missing "Decisions Overview" section | Add `## 🎯 Decisions Overview` section |

---

### Planning Documents

**Path Pattern:** `admin/planning/features/[feature]/` or `docs/maintainers/planning/features/[feature]/`

**Document Subtypes:**

| Subtype | File Pattern | Required Sections |
|---------|--------------|-------------------|
| **Feature Plan** | `feature-plan.md` | Overview, Goals |
| **Phase** | `phase-N.md` | Goals, Tasks |
| **Status** | `status-and-next-steps.md` | Progress Overview, Next Steps |
| **Planning Hub** | `README.md` | Quick Links, Overview |

#### Feature Plan

| Property | Value |
|----------|-------|
| **Rule ID** | `FEATURE_PLAN_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Overview | `^## 📋 Overview` | Missing "Overview" section | Add `## 📋 Overview` section after metadata |
| Goals | `^## 🎯 Goals` | Missing "Goals" section | Add `## 🎯 Goals` section |

**Optional Sections:**
- `## 📅 Phases` or `## Phases`
- `## 🚀 Next Steps`

#### Phase Document

| Property | Value |
|----------|-------|
| **Rule ID** | `PHASE_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Goals | `^## 🎯 Goals` | Missing "Goals" section | Add `## 🎯 Goals` section after metadata |

**Phase-Specific Rules:**

| Rule ID | Severity | Pattern | Error Message |
|---------|----------|---------|---------------|
| `PHASE_TASKS_SECTION` | ERROR | `^## 📝 Tasks` or `^### Task \d+` | Phase must contain Tasks section or individual Task headings |
| `PHASE_NUMBER_METADATA` | WARNING | `^\*\*Phase:\*\*` | Phase document should include Phase number in metadata |

#### Status and Next Steps

| Property | Value |
|----------|-------|
| **Rule ID** | `STATUS_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Progress Overview | `^## 📊 Progress Overview` | Missing "Progress Overview" section | Add `## 📊 Progress Overview` section |
| Next Steps | `^## 🚀 Next Steps` | Missing "Next Steps" section | Add `## 🚀 Next Steps` section |

#### Planning Hub (README.md)

| Property | Value |
|----------|-------|
| **Rule ID** | `PLANNING_HUB_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Quick Links | `^## 📋 Quick Links` | Missing "Quick Links" section | Add `## 📋 Quick Links` section |
| Overview | `^## 🎯 Overview` | Missing "Overview" section | Add `## 🎯 Overview` section |

---

### Handoff Documents

**Path Pattern:** `tmp/handoff*.md` or context-specific

**Document Subtypes:**

| Subtype | File Pattern | Required Sections |
|---------|--------------|-------------------|
| **Handoff** | `handoff*.md` | Current State, Next Actions |
| **Reflection** | `reflection*.md` | Current State, Actionable Suggestions |

#### Handoff

| Property | Value |
|----------|-------|
| **Rule ID** | `HANDOFF_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Current State | `^## 📍 Current State` | Missing "Current State" section | Add `## 📍 Current State` section |
| Next Actions | `^## 🚀 Next Actions` | Missing "Next Actions" section | Add `## 🚀 Next Actions` section |

**Optional Sections:**
- `## 📋 Implementation Scope`
- `## 📝 Notes`

#### Reflection

| Property | Value |
|----------|-------|
| **Rule ID** | `REFLECTION_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Current State | `^## 📊 Current State` | Missing "Current State" section | Add `## 📊 Current State` section |
| Actionable Suggestions | `^## 💡 Actionable Suggestions` | Missing "Actionable Suggestions" section | Add `## 💡 Actionable Suggestions` section |
| Recommended Next Steps | `^## 🎯 Recommended Next Steps` | Missing "Recommended Next Steps" section | Add `## 🎯 Recommended Next Steps` section |

---

### Fix Documents

**Path Pattern:** `admin/planning/fix/` or `admin/feedback/sourcery/`

**Document Subtypes:**

| Subtype | File Pattern | Required Sections |
|---------|--------------|-------------------|
| **Fix Batch** | `fix-batch-*.md` | Issues in This Batch, Overview |

#### Fix Batch

| Property | Value |
|----------|-------|
| **Rule ID** | `FIX_BATCH_REQUIRED_SECTIONS` |
| **Severity** | ERROR |
| **Required Sections** | |

| Section | Pattern | Error Message | Fix Suggestion |
|---------|---------|---------------|----------------|
| Issues in This Batch | `^## 📋 Issues in This Batch` | Missing "Issues in This Batch" section | Add `## 📋 Issues in This Batch` section |
| Overview | `^## 🎯 Overview` | Missing "Overview" section | Add `## 🎯 Overview` section |

**Fix-Specific Rules:**

| Rule ID | Severity | Pattern | Error Message |
|---------|----------|---------|---------------|
| `FIX_BATCH_TABLE` | WARNING | `\| Issue \|` or `\| # \|` | Fix batch should contain issues table |

---

## 📊 Type-Specific Rules Summary

| Doc Type | Subtypes | Rule ID Prefix | Required Sections (Main) |
|----------|----------|----------------|--------------------------|
| **Exploration** | exploration, hub | `EXPLORATION_*` | What We're Exploring, Themes, Key Questions |
| **Research** | topic, summary, requirements, hub | `RESEARCH_*` | Research Question, Findings, Recommendations |
| **Decision** | adr, summary, hub | `ADR_*`, `DECISION_*` | Context, Decision, Consequences |
| **Planning** | feature-plan, phase, status, hub | `FEATURE_*`, `PHASE_*`, `PLANNING_*` | Overview, Goals |
| **Handoff** | handoff, reflection | `HANDOFF_*`, `REFLECTION_*` | Current State, Next Actions |
| **Fix** | fix-batch | `FIX_*` | Issues in This Batch, Overview |

---

## 🚨 Error Output Format

Validation errors must be **actionable** - each error includes the file, issue, and specific fix suggestion.

---

### Severity Levels

| Severity | Symbol | Meaning | Exit Code Impact |
|----------|--------|---------|------------------|
| **ERROR** | `[ERROR]` | Must be fixed for document to be valid | Causes exit code 1 |
| **WARNING** | `[WARNING]` | Should be reviewed but doesn't fail validation | Does not affect exit code |

**Examples:**
- ERROR: Missing required section, invalid status header, malformed date
- WARNING: Stale date (>30 days), missing optional sections, format suggestions

---

### Error Code Conventions

All error codes follow the pattern `[CATEGORY]_[SPECIFIC_ERROR]`.

| Code | Category | Description |
|------|----------|-------------|
| `MISSING_SECTION` | Structure | Required section not found |
| `INVALID_FORMAT` | Format | Pattern doesn't match expected format |
| `INVALID_STATUS` | Metadata | Status indicator not valid |
| `INVALID_DATE` | Metadata | Date not in YYYY-MM-DD format |
| `MISSING_METADATA` | Metadata | Required metadata field missing |
| `STALE_DATE` | Warning | Last Updated >30 days old |
| `TYPE_DETECTION_FAILED` | System | Could not determine document type |
| `FILE_NOT_FOUND` | System | Specified file does not exist |

**Full Error Code List:**

| Error Code | Severity | Rule ID | Trigger |
|------------|----------|---------|---------|
| `MISSING_STATUS_HEADER` | ERROR | `COMMON_STATUS_HEADER` | No `**Status:**` line found |
| `INVALID_STATUS_INDICATOR` | ERROR | `COMMON_VALID_INDICATOR` | Status emoji not in allowed set |
| `MISSING_CREATED_DATE` | ERROR | `COMMON_CREATED_DATE` | No `**Created:**` line found |
| `INVALID_CREATED_DATE` | ERROR | `COMMON_CREATED_DATE` | Date not YYYY-MM-DD format |
| `MISSING_LAST_UPDATED` | ERROR | `COMMON_LAST_UPDATED` | No `**Last Updated:**` line found |
| `INVALID_LAST_UPDATED` | ERROR | `COMMON_LAST_UPDATED` | Date not YYYY-MM-DD format |
| `STALE_LAST_UPDATED` | WARNING | `COMMON_STALE_DATE` | Date >30 days old |
| `MISSING_SECTION` | ERROR | `*_REQUIRED_SECTIONS` | Required section not found |
| `INVALID_ADR_TITLE` | ERROR | `ADR_TITLE_FORMAT` | ADR title not `# ADR-NNN: Title` |
| `MISSING_ADR_BATCH` | WARNING | `ADR_BATCH_FIELD` | ADR missing Batch field |
| `MISSING_TASKS_SECTION` | ERROR | `PHASE_TASKS_SECTION` | Phase has no tasks |
| `MISSING_ISSUES_TABLE` | WARNING | `FIX_BATCH_TABLE` | Fix batch has no issues table |

---

### Text Output Format (Default)

**Single File Validation:**

```
dt-doc-validate admin/research/my-topic/research-summary.md

[ERROR] Missing required section: ## 📊 Findings
  File: admin/research/my-topic/research-summary.md
  Line: (not found)
  Fix:  Add "## 📊 Findings" section after Research Goals

[WARNING] Date may be stale: Last Updated is 30+ days old
  File: admin/research/my-topic/research-summary.md
  Line: 7
  Fix:  Review document and update "**Last Updated:** YYYY-MM-DD"

Summary: 1 error, 1 warning
Result: FAILED
```

**Multi-File Validation (Directory):**

```
dt-doc-validate admin/research/my-topic/

Validating: admin/research/my-topic/README.md
  ✓ Passed

Validating: admin/research/my-topic/research-summary.md
  [ERROR] Missing required section: ## 📊 Findings
    Fix: Add "## 📊 Findings" section after Research Goals

Validating: admin/research/my-topic/requirements.md
  [WARNING] Date may be stale
    Fix: Update "**Last Updated:** YYYY-MM-DD"

Summary: 3 files, 1 passed, 1 error, 1 warning
Result: FAILED
```

**Text Format Structure:**

```
[SEVERITY] {message}
  File: {file_path}
  Line: {line_number} (or "not found" if section missing)
  Fix:  {actionable_fix_suggestion}
```

---

### JSON Output Format (`--json`)

**Single File:**

```json
{
  "file": "admin/research/my-topic/research-summary.md",
  "type": "research-summary",
  "passed": false,
  "errors": [
    {
      "code": "MISSING_SECTION",
      "rule_id": "RESEARCH_SUMMARY_REQUIRED_SECTIONS",
      "message": "Missing required section: ## 📊 Findings",
      "line": null,
      "fix": "Add \"## 📊 Findings\" section after Research Goals"
    }
  ],
  "warnings": [
    {
      "code": "STALE_LAST_UPDATED",
      "rule_id": "COMMON_STALE_DATE",
      "message": "Date may be stale: Last Updated is 30+ days old",
      "line": 7,
      "fix": "Review document and update \"**Last Updated:** YYYY-MM-DD\""
    }
  ]
}
```

**Multi-File (Directory):**

```json
{
  "summary": {
    "total_files": 3,
    "passed": 1,
    "failed": 2,
    "errors": 1,
    "warnings": 1
  },
  "results": [
    {
      "file": "admin/research/my-topic/README.md",
      "type": "research-hub",
      "passed": true,
      "errors": [],
      "warnings": []
    },
    {
      "file": "admin/research/my-topic/research-summary.md",
      "type": "research-summary",
      "passed": false,
      "errors": [
        {
          "code": "MISSING_SECTION",
          "rule_id": "RESEARCH_SUMMARY_REQUIRED_SECTIONS",
          "message": "Missing required section: ## 📊 Findings",
          "line": null,
          "fix": "Add \"## 📊 Findings\" section after Research Goals"
        }
      ],
      "warnings": []
    },
    {
      "file": "admin/research/my-topic/requirements.md",
      "type": "requirements",
      "passed": true,
      "errors": [],
      "warnings": [
        {
          "code": "STALE_LAST_UPDATED",
          "rule_id": "COMMON_STALE_DATE",
          "message": "Date may be stale: Last Updated is 30+ days old",
          "line": 5,
          "fix": "Review document and update \"**Last Updated:** YYYY-MM-DD\""
        }
      ]
    }
  ]
}
```

**JSON Schema:**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "file": { "type": "string", "description": "Path to validated file" },
    "type": { "type": "string", "description": "Detected document type" },
    "passed": { "type": "boolean", "description": "True if no errors" },
    "errors": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "code": { "type": "string" },
          "rule_id": { "type": "string" },
          "message": { "type": "string" },
          "line": { "type": ["integer", "null"] },
          "fix": { "type": "string" }
        },
        "required": ["code", "message", "fix"]
      }
    },
    "warnings": {
      "type": "array",
      "items": { "$ref": "#/properties/errors/items" }
    }
  },
  "required": ["file", "type", "passed", "errors", "warnings"]
}
```

---

### Exit Codes

| Code | Meaning | When |
|------|---------|------|
| `0` | Success | All files passed validation (warnings OK) |
| `1` | Validation Error | One or more files have errors |
| `2` | System Error | Invalid arguments, file not found, etc. |

**Exit Code Logic:**
- Errors → exit 1 (validation failed)
- Warnings only → exit 0 (validation passed with notes)
- System issues → exit 2 (cannot complete validation)

---

### Fix Suggestion Guidelines

Fix suggestions must be **specific and actionable**:

| Guideline | Good Example | Bad Example |
|-----------|--------------|-------------|
| **Specific location** | `Add "## 📊 Findings" section after Research Goals` | `Add missing section` |
| **Exact text** | `Change "**Status:** Started" to "**Status:** 🟠 In Progress"` | `Fix status` |
| **Format example** | `Use format "**Created:** YYYY-MM-DD" (e.g., 2026-01-16)` | `Fix date format` |
| **Context aware** | `Add "## Context" section after metadata block` | `Add Context section` |

**Fix Suggestion Template:**

For missing sections:
```
Add "{section_header}" section after {preceding_element}
```

For invalid format:
```
Change "{found_value}" to "{expected_format}" (e.g., {example})
```

For missing metadata:
```
Add "{metadata_field}" to document metadata block
```

---

## 🖥️ CLI Reference (`dt-doc-validate`)

The `dt-doc-validate` CLI tool in dev-toolkit implements these validation rules.

### Basic Usage

```bash
# Validate a single file
dt-doc-validate <file>

# Validate all .md files in a directory
dt-doc-validate <directory>

# Validate with specific options
dt-doc-validate [options] <path>
```

### Command-Line Options

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--type <type>` | `-t` | Override auto-detected document type | Auto-detect |
| `--json` | `-j` | Output results in JSON format | Text format |
| `--quiet` | `-q` | Suppress output, exit code only | Normal output |
| `--verbose` | `-v` | Show additional details (rules checked, timing) | Normal output |
| `--help` | `-h` | Show help message | — |
| `--version` | | Show version information | — |

### Document Type Values (`--type`)

When using `--type` to override detection, use one of these values:

| Type Value | Documents |
|------------|-----------|
| `exploration` | Exploration documents |
| `exploration-hub` | Exploration README.md |
| `research-topic` | Individual research topic |
| `research-summary` | Research summary document |
| `requirements` | Requirements document |
| `research-hub` | Research README.md |
| `adr` | Architecture Decision Record |
| `decisions-summary` | Decisions summary |
| `decisions-hub` | Decisions README.md |
| `feature-plan` | Feature plan document |
| `phase` | Phase document |
| `status` | Status and next steps |
| `planning-hub` | Planning README.md |
| `handoff` | Handoff document |
| `reflection` | Reflection document |
| `fix-batch` | Fix batch plan |

### Exit Codes

| Code | Meaning | Description |
|------|---------|-------------|
| `0` | Success | All files passed validation (warnings OK) |
| `1` | Validation Error | One or more files have errors |
| `2` | System Error | Invalid arguments, file not found, etc. |

### Usage Examples

#### Validate a Single File

```bash
# Validate a research summary
dt-doc-validate admin/research/my-topic/research-summary.md

# Expected output:
# Validating: admin/research/my-topic/research-summary.md
#   ✓ Passed
# 
# Summary: 1 file, 1 passed, 0 errors, 0 warnings
# Result: PASSED
```

#### Validate a Directory

```bash
# Validate all docs in a research topic directory
dt-doc-validate admin/research/my-topic/

# Expected output:
# Validating: admin/research/my-topic/README.md
#   ✓ Passed
# Validating: admin/research/my-topic/research-summary.md
#   ✓ Passed
# Validating: admin/research/my-topic/requirements.md
#   [WARNING] Date may be stale
# 
# Summary: 3 files, 3 passed, 0 errors, 1 warning
# Result: PASSED
```

#### Override Document Type

```bash
# Force validation as exploration type
dt-doc-validate --type exploration admin/explorations/my-topic/exploration.md

# Validate a hub file explicitly
dt-doc-validate --type research-hub admin/research/my-topic/README.md
```

#### JSON Output for CI/Scripts

```bash
# Get JSON output for parsing
dt-doc-validate --json admin/research/my-topic/research-summary.md

# Pipe to jq for processing
dt-doc-validate --json admin/research/ | jq '.summary'

# Check specific field
dt-doc-validate --json admin/research/ | jq '.summary.errors'
```

#### Quiet Mode for Scripts

```bash
# Use exit code only (for shell scripts)
if dt-doc-validate --quiet admin/research/my-topic/; then
  echo "Validation passed"
else
  echo "Validation failed"
fi

# Combine with --json for minimal but parseable output
dt-doc-validate --quiet --json admin/research/my-topic/
```

#### Verbose Mode for Debugging

```bash
# Show detailed validation information
dt-doc-validate --verbose admin/research/my-topic/research-summary.md

# Expected additional output:
# Document type: research-summary (auto-detected)
# Rules checked: COMMON_STATUS_HEADER, COMMON_CREATED_DATE, ...
# Validation time: 45ms
```

### Integration with dev-toolkit Commands

The validation tool integrates with other dev-toolkit commands:

```bash
# Validate before generating docs
dt-doc-gen exploration my-topic && dt-doc-validate admin/explorations/my-topic/

# Validate as part of research workflow
dt-research complete my-topic  # Internally calls dt-doc-validate

# Pre-commit hook usage
dt-doc-validate --quiet $(git diff --name-only --staged '*.md')
```

### Common Patterns

#### Validate Before Commit

```bash
# Validate changed markdown files
git diff --name-only --staged '*.md' | xargs -r dt-doc-validate
```

#### Validate Feature Documentation

```bash
# Validate all planning docs for a feature
dt-doc-validate admin/planning/features/my-feature/

# Validate exploration → research → decision chain
dt-doc-validate admin/explorations/my-topic/ \
                admin/research/my-topic/ \
                admin/decisions/my-topic/
```

#### CI Pipeline Usage

```bash
# In CI, fail fast on validation errors
dt-doc-validate --quiet admin/planning/features/my-feature/ || exit 1

# Or collect all errors with JSON
dt-doc-validate --json admin/ > validation-report.json
```

---

## 🔗 References

- [ADR-004: Validation Architecture](../../../admin/decisions/template-doc-infrastructure/adr-004-validation-architecture.md)
- [validation-rules/](validation-rules/) - Machine-readable YAML validation rules
- [FORMAT.md](FORMAT.md) - Template format specification
- [VARIABLES.md](VARIABLES.md) - Variable reference
- [AUTHORING.md](AUTHORING.md) - Template authoring guide

---

**Last Updated:** 2026-01-16
