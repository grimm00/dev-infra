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

## 🔗 References

- [ADR-004: Validation Architecture](../../../admin/decisions/template-doc-infrastructure/adr-004-validation-architecture.md)
- [FORMAT.md](FORMAT.md) - Template format specification
- [VARIABLES.md](VARIABLES.md) - Variable reference
- [AUTHORING.md](AUTHORING.md) - Template authoring guide

---

<!-- 
NOTE: Type-specific rules (Task 2), error format (Task 3), and CLI reference (Task 9) 
will be added in subsequent tasks.
-->

**Last Updated:** 2026-01-16
