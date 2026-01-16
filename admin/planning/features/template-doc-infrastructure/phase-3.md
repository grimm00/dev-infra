# Template Doc Infrastructure - Phase 3: Validation Rules

**Phase:** 3 - Validation Rules  
**Duration:** 3-4 hours  
**Status:** 🟠 In Progress  
**Started:** 2026-01-16  
**Prerequisites:** Phase 1 complete, ADR-004 accepted

---

## 📋 Overview

Define validation rules for each doc type, providing the specification for `dt-doc-validate` implementation in dev-toolkit.

**Success Definition:** dev-toolkit team can implement `dt-doc-validate` from specification.

---

## 🎯 Goals

1. **Document common rules** - Status header, dates, indicators
2. **Document type-specific rules** - Required sections per doc type
3. **Define error format** - Actionable messages with file, location, fix
4. **Create rule reference** - Per-type validation YAML definitions

---

## 📝 Tasks

### Task 1: Create VALIDATION.md - Common Rules

**Purpose:** Document the common validation rules that apply to all doc types.

**File:** `scripts/doc-gen/templates/VALIDATION.md`

- [x] Create VALIDATION.md document structure
- [x] Document status header validation (pattern, valid indicators)
- [x] Document date format validation (Created, Last Updated)
- [x] Document status indicator validation (🔴, 🟠, 🟡, 🟢, ✅)
- [x] Include regex patterns for each check
- [x] Reference ADR-004 for authoritative rules

**Content to Include:**

```markdown
# Validation Rules Specification

## Common Rules (All Doc Types)

| Check | Pattern | Example |
|-------|---------|---------|
| Status Header | `\*\*Status:\*\* [🔴🟠🟡🟢✅]` | `**Status:** 🟠 In Progress` |
| Created Date | `\*\*Created:\*\* \d{4}-\d{2}-\d{2}` | `**Created:** 2026-01-14` |
| Last Updated | `\*\*Last Updated:\*\* \d{4}-\d{2}-\d{2}` | `**Last Updated:** 2026-01-14` |
```

**Deliverable:** `scripts/doc-gen/templates/VALIDATION.md` (common rules section)

---

### Task 2: Add Type-Specific Rules to VALIDATION.md

**Purpose:** Document the required sections for each of the 6 doc types.

- [x] Document Exploration rules (What We're Exploring, Themes, Key Questions)
- [x] Document Research rules (Research Question, Findings, Recommendations)
- [x] Document Decision/ADR rules (Context, Decision, Consequences)
- [x] Document Planning rules (Overview, Goals, Phase subtypes)
- [x] Document Handoff rules (Current State, Next Actions)
- [x] Document Fix rules (Issues Table, Overview)

**Type-Specific Rules from ADR-004:**

| Doc Type | Required Sections |
|----------|-------------------|
| **Exploration** | `## 🎯 Problem`, `## 🌊 Themes`, `## ❓ Key Questions` |
| **Research** | `## 🎯 Research Question`, `## 📊 Findings`, `## 💡 Recommendations` |
| **ADR** | `## Context`, `## Decision`, `## Consequences` |
| **Hub (README)** | `## 📋 Quick Links` |
| **Feature Plan** | `## 📋 Overview`, `## 🎯 Success Criteria`, `## 📅 Phases` |
| **Handoff** | `## 📍 Current State`, `## 🚀 Next Steps` |

**Deliverable:** `scripts/doc-gen/templates/VALIDATION.md` (type-specific section)

---

### Task 3: Add Error Format Specification

**Purpose:** Document the error message format for actionable validation feedback.

- [x] Define text error format (default output)
- [x] Define JSON error format (`--json` flag)
- [x] Document error severity levels (ERROR, WARNING)
- [x] Include error code conventions (MISSING_SECTION, INVALID_FORMAT, etc.)
- [x] Provide fix suggestion guidelines

**Error Format from ADR-004:**

**Text format:**
```
[ERROR] Missing required section: ## 📊 Findings
  File: admin/research/my-topic/research-summary.md
  Fix:  Add "## 📊 Findings" section after Research Goals
```

**JSON format:**
```json
{
  "file": "...",
  "type": "research",
  "errors": [{ "code": "MISSING_SECTION", "message": "...", "fix": "..." }],
  "warnings": [],
  "passed": false
}
```

**Deliverable:** `scripts/doc-gen/templates/VALIDATION.md` (error format section)

---

### Task 4: Create Directory Structure and Exploration Rules YAML

**Purpose:** Create validation-rules directory and first rule file.

**Files:**
- `scripts/doc-gen/templates/validation-rules/` (directory)
- `scripts/doc-gen/templates/validation-rules/exploration.yaml`

- [ ] Create validation-rules directory
- [ ] Create exploration.yaml with rule definitions
- [ ] Define required sections as patterns
- [ ] Define optional sections
- [ ] Include example valid/invalid snippets

**YAML Structure:**

```yaml
type: exploration
description: Exploration document validation rules

common_rules:
  - status_header
  - created_date
  - last_updated

required_sections:
  - pattern: "## 🎯 Problem"
    error: "Missing Problem section"
    fix: "Add '## 🎯 Problem' section"
  - pattern: "## 🌊 Themes"
    error: "Missing Themes section"
    fix: "Add '## 🌊 Themes' section"
  - pattern: "## ❓ Key Questions"
    error: "Missing Key Questions section"
    fix: "Add '## ❓ Key Questions' section"

optional_sections:
  - "## 💭 Initial Thoughts"
  - "## 🚀 Next Steps"
```

**Deliverable:** `scripts/doc-gen/templates/validation-rules/exploration.yaml`

---

### Task 5: Create Research Rules YAML

**Purpose:** Define validation rules for research documents.

**File:** `scripts/doc-gen/templates/validation-rules/research.yaml`

- [ ] Create research.yaml with required sections
- [ ] Include research-topic and research-summary variants
- [ ] Define requirements.md validation rules
- [ ] Document hub (README.md) rules

**Deliverable:** `scripts/doc-gen/templates/validation-rules/research.yaml`

---

### Task 6: Create Decision Rules YAML

**Purpose:** Define validation rules for ADR documents.

**File:** `scripts/doc-gen/templates/validation-rules/decision.yaml`

- [ ] Create decision.yaml with ADR required sections
- [ ] Include decisions-summary validation rules
- [ ] Define hub (README.md) rules
- [ ] Document ADR-specific patterns (Status, Batch)

**Deliverable:** `scripts/doc-gen/templates/validation-rules/decision.yaml`

---

### Task 7: Create Planning Rules YAML

**Purpose:** Define validation rules for planning documents.

**File:** `scripts/doc-gen/templates/validation-rules/planning.yaml`

- [ ] Create planning.yaml with feature-plan rules
- [ ] Include phase document validation
- [ ] Define status-and-next-steps rules
- [ ] Document hub (README.md) rules

**Deliverable:** `scripts/doc-gen/templates/validation-rules/planning.yaml`

---

### Task 8: Create Other Rules YAML Files

**Purpose:** Define validation rules for handoff and fix documents.

**Files:**
- `scripts/doc-gen/templates/validation-rules/handoff.yaml`
- `scripts/doc-gen/templates/validation-rules/fix.yaml`

- [ ] Create handoff.yaml with required sections
- [ ] Create fix.yaml with fix-batch validation rules
- [ ] Include reflection document rules in handoff or separate file

**Deliverables:**
- `scripts/doc-gen/templates/validation-rules/handoff.yaml`
- `scripts/doc-gen/templates/validation-rules/fix.yaml`

---

### Task 9: Add CLI Reference to VALIDATION.md

**Purpose:** Document the dt-doc-validate CLI interface for implementers.

- [ ] Document CLI usage patterns
- [ ] Document flags (--type, --json, --quiet, --verbose)
- [ ] Document exit codes (0, 1, 2)
- [ ] Include usage examples

**CLI Interface from ADR-004:**

```bash
# Validate single file
dt-doc-validate admin/research/my-topic/research-summary.md

# Validate directory
dt-doc-validate admin/research/my-topic/

# Override type detection
dt-doc-validate --type exploration admin/explorations/my-topic/

# JSON output
dt-doc-validate --json admin/research/my-topic/

# Quiet mode (exit code only)
dt-doc-validate --quiet admin/research/my-topic/
```

**Deliverable:** `scripts/doc-gen/templates/VALIDATION.md` (CLI section)

---

### Task 10: Verify Spec Completeness

**Purpose:** Ensure validation spec is complete for tooling implementation.

- [ ] Verify all 6 doc types have YAML rules
- [ ] Cross-reference with ADR-004 requirements
- [ ] Verify error codes are consistent
- [ ] Add implementation notes for dev-toolkit
- [ ] Update spec links and references

**Verification Commands:**

```bash
# Check all YAML files created
ls scripts/doc-gen/templates/validation-rules/*.yaml

# Verify required sections count per type
grep -c "pattern:" scripts/doc-gen/templates/validation-rules/*.yaml
```

**Deliverable:** Verified and complete validation specification

---

## 📊 Progress Tracking

| Task                              | Status         | Notes |
| --------------------------------- | -------------- | ----- |
| Task 1: Common Rules              | ✅ Complete    |       |
| Task 2: Type-Specific Rules       | ✅ Complete    |       |
| Task 3: Error Format              | ✅ Complete    |       |
| Task 4: Exploration YAML          | 🔴 Not Started |       |
| Task 5: Research YAML             | 🔴 Not Started |       |
| Task 6: Decision YAML             | 🔴 Not Started |       |
| Task 7: Planning YAML             | 🔴 Not Started |       |
| Task 8: Handoff/Fix YAML          | 🔴 Not Started |       |
| Task 9: CLI Reference             | 🔴 Not Started |       |
| Task 10: Verify Completeness      | 🔴 Not Started |       |

---

## ✅ Completion Criteria

- [ ] Common validation rules documented (status, dates, indicators)
- [ ] Type-specific rules for all 6 doc types
- [ ] Error message format defined (text + JSON)
- [ ] 6 YAML rule files created
- [ ] CLI interface documented
- [ ] Validation spec complete for tooling team

---

## 📦 Deliverables

- `scripts/doc-gen/templates/VALIDATION.md` - Validation rules specification
- `scripts/doc-gen/templates/validation-rules/exploration.yaml` - Exploration rules
- `scripts/doc-gen/templates/validation-rules/research.yaml` - Research rules
- `scripts/doc-gen/templates/validation-rules/decision.yaml` - Decision rules
- `scripts/doc-gen/templates/validation-rules/planning.yaml` - Planning rules
- `scripts/doc-gen/templates/validation-rules/handoff.yaml` - Handoff rules
- `scripts/doc-gen/templates/validation-rules/fix.yaml` - Fix rules

---

## 🔗 Dependencies

### Prerequisites

- [x] Phase 1: Template Creation (templates exist to validate)
- [x] Phase 2: Format Specification (placeholder conventions defined)
- [x] ADR-004: Validation Architecture (defines validation approach)
- [x] Research: Validation Approach (defines rules)

### Blocks

- dev-toolkit: `dt-doc-validate` implementation (needs validation spec)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Phase 1: Template Creation](phase-1.md)
- [Phase 2: Format Specification](phase-2.md)
- [ADR-004: Validation Architecture](../../../decisions/template-doc-infrastructure/adr-004-validation-architecture.md)
- [Research: Validation Approach](../../../research/template-doc-infrastructure/research-validation-approach.md)

---

**Last Updated:** 2026-01-16  
**Status:** 🟠 In Progress  
**Next:** Complete Task 1: Common Rules
