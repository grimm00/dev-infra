# ADR-004: Validation Architecture

**Status:** 🔴 Proposed  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 2 (Implementation)

---

## Context

Documentation infrastructure needs validation to ensure compliance with template standards. Research identified a layered validation architecture with on-demand CLI as primary interface. We need to decide on the validation architecture.

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

<!-- FILL: State the decision clearly -->

**Decision:** [To be filled]

---

## Consequences

### Positive

<!-- FILL: List positive consequences -->

- [Positive consequence 1]
- [Positive consequence 2]

### Negative

<!-- FILL: List negative consequences -->

- [Negative consequence 1]
- [Negative consequence 2]

---

## Alternatives Considered

### Alternative 1: In-Command Validation Only

**Description:** Each Cursor command validates its own output inline.

**Pros:**
- Immediate feedback
- No external tools needed
- Self-contained commands

**Cons:**
- Duplicated validation logic across commands
- Inconsistent validation
- No standalone validation tool

**Why not chosen:** [To be filled]

---

### Alternative 2: Pre-Commit Hook Only

**Description:** Validation runs only as pre-commit hook.

**Pros:**
- Automatic enforcement
- Catches all commits
- No manual invocation needed

**Cons:**
- Delayed feedback (only at commit time)
- Can be bypassed
- Slow commits if validation is heavy

**Why not chosen:** [To be filled]

---

### Alternative 3: CI-Only Validation

**Description:** Validation runs only in CI pipeline.

**Pros:**
- Guaranteed enforcement on PRs
- No local setup required
- Centralized validation

**Cons:**
- Very delayed feedback (push → CI → feedback)
- Frustrating iteration
- Doesn't catch issues locally

**Why not chosen:** [To be filled]

---

### Alternative 4: Layered Validation (On-Demand CLI Primary)

**Description:** Three-layer validation with on-demand CLI as primary:
1. Library (`lib/validate.sh`) - Reusable functions
2. CLI (`dt-doc-validate`) - Primary interface
3. Commands - Call CLI during workflow

**Pros:**
- Developer controls when to validate
- Reusable across contexts
- Multiple integration points

**Cons:**
- Requires developer discipline
- May miss validation if not called

**Why not chosen:** [Or: Why chosen - to be filled]

---

## Decision Rationale

<!-- FILL: Explain why this decision was made -->

**Key Factors:**
- [Factor 1]
- [Factor 2]

**Research Support:**
- Finding 8: Layered validation architecture
- Precedent: `check-release-readiness.sh` pattern

---

## Validation Architecture

<!-- FILL: Define the architecture -->

```
┌─────────────────────────────────────────────────────────────┐
│ Layer 3: Cursor Commands                                     │
│ - Call dt-doc-validate after generation                     │
│ - Show validation results to user                           │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ Layer 2: CLI (dt-doc-validate)                              │
│ - Primary interface for developers                          │
│ - Accepts file/directory paths                              │
│ - Returns structured output (text/JSON)                     │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ Layer 1: Library (lib/validate.sh)                          │
│ - Reusable validation functions                             │
│ - Type-specific rules                                       │
│ - Common rules                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Validation Timing

<!-- FILL: Define when validation runs -->

| When | How | Required? |
|------|-----|-----------|
| On-demand | Developer runs `dt-doc-validate` | No (primary) |
| In-command | Commands call CLI after generation | Yes |
| Pre-commit | Hook calls CLI on staged files | Optional |
| CI | GitHub Action on PR | Yes (enforcement) |

---

## Validation Rules

<!-- FILL: Define validation rules -->

### Common Rules (All Doc Types)

- [ ] Status header present (Status, Created, Last Updated)
- [ ] Date format correct (YYYY-MM-DD)
- [ ] Quick Links section present (where applicable)
- [ ] No broken internal links

### Type-Specific Rules

| Doc Type | Required Sections |
|----------|-------------------|
| exploration.md | Context, Themes, Key Questions |
| research-*.md | Research Question, Findings, Analysis |
| adr-*.md | Context, Decision, Consequences |
| ... | ... |

---

## Error Output Format

<!-- FILL: Define error format -->

```
# Text format (default)
ERROR: Missing required section "Decision" in adr-001.md:1
ERROR: Invalid date format "Jan 14, 2026" in research-summary.md:4 (expected YYYY-MM-DD)
WARNING: No Quick Links section in README.md

# JSON format (--json flag)
{
  "file": "adr-001.md",
  "errors": [...],
  "warnings": [...]
}
```

---

## Requirements Impact

<!-- FILL: Document requirements affected -->

**Requirements Addressed:**
- FR-19 through FR-25 (validation features)
- NFR-11, NFR-12 (validation quality)
- C-10 through C-12 (validation constraints)

---

## References

- [Research: Validation Approach](../../research/template-doc-infrastructure/research-validation-approach.md)
- [Existing: check-release-readiness.sh](../../../scripts/check-release-readiness.sh)

---

**Last Updated:** 2026-01-14
