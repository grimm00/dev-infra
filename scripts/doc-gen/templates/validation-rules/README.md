# Validation Rules

**Purpose:** Machine-readable validation rules for `dt-doc-validate` implementation in dev-toolkit.  
**Status:** ✅ Complete  
**Created:** 2026-01-16  
**Last Updated:** 2026-01-16

---

## 📋 Overview

This directory contains YAML-formatted validation rules that define the structure and content requirements for each document type. These rules are consumed by the `dt-doc-validate` CLI tool in dev-toolkit.

**Architecture Reference:** [ADR-004: Validation Architecture](../../../../admin/decisions/template-doc-infrastructure/adr-004-validation-architecture.md)

---

## 📁 Files

| File | Document Types | Required Sections |
|------|----------------|-------------------|
| `exploration.yaml` | exploration, exploration_hub, research_topics | What We're Exploring, Themes, Key Questions |
| `research.yaml` | research_topic, research_summary, requirements, research_hub | Research Question, Findings, Recommendations |
| `decision.yaml` | adr, decisions_summary, decisions_hub | Context, Decision, Consequences |
| `planning.yaml` | feature_plan, phase, status_and_next_steps, planning_hub | Overview, Goals, Tasks |
| `handoff.yaml` | handoff, reflection | Current State, Next Actions |
| `fix.yaml` | fix_batch | Issues in This Batch, Overview |

---

## 📊 Coverage Summary

| Category | Subtypes | YAML File | Covered |
|----------|----------|-----------|---------|
| **Exploration** | 3 | exploration.yaml | ✅ |
| **Research** | 4 | research.yaml | ✅ |
| **Decision** | 3 | decision.yaml | ✅ |
| **Planning** | 4 | planning.yaml | ✅ |
| **Handoff** | 2 | handoff.yaml | ✅ |
| **Fix** | 1 | fix.yaml | ✅ |
| **Total** | **17 subtypes** | **6 files** | ✅ |

---

## 🔧 Implementation Notes for dev-toolkit

### YAML Schema

Each YAML file follows this structure:

```yaml
# Document subtype definition
subtype_name:
  description: "Human-readable description"
  path_pattern: "glob pattern for file location"
  
  common_rules:
    - rule_id: COMMON_STATUS_HEADER
      enabled: true
    - rule_id: COMMON_CREATED_DATE
      enabled: true
  
  metadata_rules:
    - rule_id: CUSTOM_METADATA_RULE
      severity: WARNING | ERROR
      pattern: "regex pattern"
      error_code: ERROR_CODE
      error_message: "User-facing message"
      fix_suggestion: "How to fix"
  
  required_sections:
    - section_id: unique_id
      pattern: "^## Section Header"
      error_code: MISSING_SECTION
      error_message: "Missing 'Section' section"
      fix_suggestion: "Add '## Section' section after X"
  
  optional_sections:
    - pattern: "^## Optional Section"
      description: "What this section is for"
  
  content_patterns:
    - pattern_id: unique_id
      pattern: "content regex"
      severity: WARNING | ERROR | INFO
      error_message: "What's wrong"
      fix_suggestion: "How to fix"
```

### Type Detection

Implement type detection in this order:

1. **Path-based detection** (primary): Match file path against `path_pattern`
2. **Content-based detection** (fallback): Check title patterns (e.g., `# ADR-NNN:`)
3. **Override flag** (`--type`): Explicit type specification

### Validation Order

For each document:

1. **Common rules first:** Status header, dates, indicators
2. **Metadata rules:** Type-specific metadata fields
3. **Required sections:** Must have all specified sections
4. **Content patterns:** Additional content checks
5. **Optional sections:** INFO only, no errors

### Stale Date Thresholds

Different document types have different staleness thresholds:

| Doc Type | Threshold | Rationale |
|----------|-----------|-----------|
| status_and_next_steps | 7 days | Should be updated frequently |
| phase | 14 days | Active development |
| handoff | 7 days | Session-specific |
| adr | 60 days | May be stable longer |
| requirements | 60 days | May be stable longer |
| Default | 30 days | Standard threshold |

### Exit Codes

| Code | Meaning | When |
|------|---------|------|
| `0` | Success | All files passed (warnings OK) |
| `1` | Validation Error | One or more errors |
| `2` | System Error | Bad args, file not found, etc. |

---

## 🔗 Related Files

- **[VALIDATION.md](../VALIDATION.md)** - Human-readable validation spec with error format
- **[FORMAT.md](../FORMAT.md)** - Template format specification
- **[VARIABLES.md](../VARIABLES.md)** - Variable reference
- **[AUTHORING.md](../AUTHORING.md)** - Template authoring guide
- **[ADR-004](../../../../admin/decisions/template-doc-infrastructure/adr-004-validation-architecture.md)** - Validation architecture decision

---

## ✅ Verification Checklist

Verification commands:

```bash
# Check all YAML files created
ls scripts/doc-gen/templates/validation-rules/*.yaml

# Count patterns per file
for f in scripts/doc-gen/templates/validation-rules/*.yaml; do 
  echo "$f: $(grep -c 'pattern:' "$f") patterns"
done

# List all document subtypes
grep -h "^[a-z_]*:" scripts/doc-gen/templates/validation-rules/*.yaml | sort | uniq
```

---

**Last Updated:** 2026-01-16
