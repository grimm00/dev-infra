# Template Doc Infrastructure - Phase 3 Learnings

**Project:** dev-infra  
**Feature:** template-doc-infrastructure  
**Phase:** 3 - Validation Rules  
**Date:** 2026-01-16  
**Status:** ✅ Complete  
**Last Updated:** 2026-01-16

---

## 📋 Overview

Phase 3 defined comprehensive validation rules for the `dt-doc-validate` CLI tool, creating both human-readable specification (VALIDATION.md) and machine-readable YAML rule files covering all 17 document subtypes across 6 categories.

**Deliverables:**
- VALIDATION.md (~1,030 lines) - Human-readable spec with CLI reference
- 6 YAML rule files (~1,120 lines total) - Machine-readable validation rules
- validation-rules/README.md (~160 lines) - Implementation guide

**Total:** ~2,310 lines of specification documentation

---

## ✅ What Worked Exceptionally Well

### 1. Ground-Up YAML Rule Generation

**Why it worked:**
Starting with actual template files as ground truth and generating YAML rules from them ensured accuracy. No guesswork about section names or patterns.

**What made it successful:**
- Read each template file before writing its YAML rules
- Extracted exact section headers with emoji prefixes
- Validated against ADR-004 requirements after generation

**Template implications:**
- Always reference source documents when creating validation rules
- Pattern: Read → Extract → Validate → Document

**Key examples:**
```yaml
# From actual template: "## 🎯 Research Question"
required_sections:
  - section_id: research_question
    pattern: "^## 🎯 Research Question"
```

**Benefits:**
- Zero discrepancies between templates and rules
- Confidence in validation accuracy
- Easy to update when templates change

---

### 2. Progressive Task Structure (Small to Large)

**Why it worked:**
Phase tasks progressed from foundations (common rules) through specifics (type-specific, error format) to implementation (YAML files) to verification.

**What made it successful:**
- Tasks 1-3: Foundation (VALIDATION.md sections)
- Tasks 4-8: Implementation (6 YAML files)
- Task 9: Integration (CLI reference)
- Task 10: Verification (completeness check)

**Template implications:**
- Documentation phases benefit from foundation → implementation → verification flow
- Bundle related YAML files as single tasks (planning.yaml covers 4 subtypes)

**Benefits:**
- Each task built on previous
- Natural review points between sections
- Clear progress indicators

---

### 3. Consistent YAML Schema Across All Files

**Why it worked:**
Defining a consistent YAML schema early (in exploration.yaml) made subsequent files predictable and maintainable.

**What made it successful:**
- Standard structure: `description`, `path_pattern`, `common_rules`, `metadata_rules`, `required_sections`, `optional_sections`, `content_patterns`, `examples`
- Consistent naming conventions across files
- Reusable `common_rules` references

**Template implications:**
- Define schema before creating multiple similar files
- Document schema in README for implementers

**Key examples:**
```yaml
# Consistent structure in all 6 files
subtype_name:
  description: "..."
  path_pattern: "..."
  common_rules:
    - rule_id: COMMON_STATUS_HEADER
      enabled: true
  required_sections:
    - section_id: ...
      pattern: "..."
      error_code: MISSING_SECTION
      error_message: "..."
      fix_suggestion: "..."
```

**Benefits:**
- Implementers can learn schema once, apply everywhere
- Easy to add new document types
- Consistent error handling

---

### 4. Layered Documentation (Spec + YAML + README)

**Why it worked:**
Three complementary documentation layers serve different audiences:
- VALIDATION.md: Complete spec for understanding rules
- YAML files: Machine-readable for implementation
- README.md: Quick reference for implementers

**What made it successful:**
- Each layer has distinct purpose
- Cross-references between layers
- No duplication of critical information

**Template implications:**
- Complex specs benefit from multiple representation formats
- READMEs serve as entry points, not complete documentation

**Benefits:**
- Human-readable and machine-readable in sync
- Implementers choose appropriate reference
- Easier maintenance (update one source)

---

## 🟡 What Needs Improvement

### 1. Initial Section Name Discrepancies

**What the problem was:**
ADR-004 listed different section names than actual templates used (e.g., "Problem" vs "What We're Exploring").

**Why it occurred:**
ADR-004 was written before templates were finalized. Templates evolved during Phase 1.

**Impact:**
Had to correct VALIDATION.md type-specific rules to match actual templates.

**How to prevent:**
- Generate specs from templates, not from earlier planning docs
- Add verification step: "Do these patterns match actual templates?"

**Template changes needed:**
- Add checklist item: "Verify patterns against source files" in validation spec tasks

---

### 2. Task Scope Variation

**What the problem was:**
Some tasks (e.g., Task 8: handoff.yaml + fix.yaml) covered 2 files while others covered 1. Planning.yaml alone covered 4 subtypes.

**Why it occurred:**
Tasks were organized by document category, not by estimated effort.

**Impact:**
Inconsistent task durations (some quick, some longer).

**How to prevent:**
- Estimate effort per subtype, not per category
- Consider splitting large tasks (planning → feature_plan + phase + status + hub)

**Template changes needed:**
- Phase planning should estimate by subtype count, not category count

---

### 3. Stale Date Threshold Documentation

**What the problem was:**
Different document types have different staleness thresholds (7-60 days), but this wasn't clearly documented until Task 10.

**Why it occurred:**
Discovered during YAML creation that status docs need 7-day threshold vs 60 days for ADRs.

**Impact:**
Had to document thresholds in README as implementation note, not in main spec.

**How to prevent:**
- Document threshold rationale in ADR-004 or VALIDATION.md Type-Specific Rules section

**Template changes needed:**
- Add stale threshold rationale to validation spec documentation

---

## 💡 Unexpected Discoveries

### 1. Content Patterns Complement Section Rules

**Finding:**
Some validation needs go beyond section presence. Content patterns (e.g., `### FR-NN:` for requirements, issues table headers for fix batches) catch structural issues within sections.

**Why it's valuable:**
- Sections can exist but have wrong structure
- Content patterns catch deeper issues
- Enables more precise validation

**How to leverage:**
- Add content_patterns to YAML schema
- Document common patterns (tables, numbered items, checklists)

---

### 2. Alternate Path Patterns Needed

**Finding:**
Documents may exist in multiple locations (e.g., handoffs in `tmp/` or `admin/handoffs/`). YAML rules need alternate_patterns support.

**Why it's valuable:**
- Supports project-specific conventions
- Enables migration from old to new paths
- Flexibility without breaking validation

**How to leverage:**
- Include `alternate_patterns` field in YAML schema
- Document in implementation notes

---

### 3. Reference Values Section Useful

**Finding:**
Adding reference sections for status values, priority values, and effort values in YAML files provides implementers with complete context.

**Why it's valuable:**
- Implementers don't need to look elsewhere
- Self-contained validation rules
- Easy to extend (add new status value)

**How to leverage:**
- Include `*_values` sections for enumerated fields
- Document valid values with descriptions

---

## ⏱️ Time Investment Analysis

**Actual Time Breakdown:**

| Task | Estimated | Actual | Notes |
|------|-----------|--------|-------|
| Task 1: Common Rules | 20 min | ~25 min | Added detailed patterns |
| Task 2: Type-Specific Rules | 30 min | ~35 min | Section name corrections |
| Task 3: Error Format | 20 min | ~20 min | Straightforward |
| Task 4: Exploration YAML | 15 min | ~15 min | First YAML, defined schema |
| Task 5: Research YAML | 15 min | ~12 min | Schema established |
| Task 6: Decision YAML | 15 min | ~12 min | Consistent pattern |
| Task 7: Planning YAML | 20 min | ~18 min | 4 subtypes |
| Task 8: Handoff/Fix YAML | 20 min | ~15 min | 2 files, simpler |
| Task 9: CLI Reference | 15 min | ~15 min | Examples from ADR-004 |
| Task 10: Verification | 15 min | ~12 min | README + cross-refs |
| **Total** | **~3 hours** | **~3 hours** | On target |

**What took longer:**
- Task 1-2: Section name verification against templates
- Reading templates before each YAML file

**What was faster:**
- Tasks 5-8: Schema established, copy-modify pattern
- Task 10: Most verification was confirming existing work

**Estimation lessons:**
- First YAML file takes longer (schema definition)
- Subsequent files benefit from established patterns
- Verification tasks often faster than estimated

---

## 📊 Metrics & Impact

**Code/Documentation metrics:**
- Lines of documentation: ~2,310 total
- YAML patterns defined: 125+
- Document subtypes covered: 17
- Error codes defined: 17

**Coverage metrics:**
- Document categories: 6/6 (100%)
- Subtypes: 17/17 (100%)
- ADR-004 requirements: All covered

**Developer experience:**
- dev-toolkit team has complete spec for implementation
- No ambiguity about validation rules
- Machine-readable rules enable automated implementation

---

## 🎯 Actionable Improvements for dev-infra Template

### Template Improvements

- [ ] **Add verification step to validation spec tasks**
  - Location: Task templates for validation/spec phases
  - Action: Include "Verify patterns against source files" checklist item
  - Prevents: Section name mismatches

- [ ] **Include subtype count in phase estimates**
  - Location: Phase planning templates
  - Action: Estimate effort per subtype, not per category
  - Prevents: Inconsistent task durations

- [ ] **Document reference value patterns**
  - Location: YAML schema documentation
  - Action: Show `*_values` pattern for enumerated fields
  - Enables: Self-contained validation rules

### Process Improvements

- [ ] **Generate specs from templates, not plans**
  - When creating validation specs, read actual templates first
  - ADRs/research may have outdated information

- [ ] **Define YAML schema before bulk creation**
  - First file establishes pattern
  - Subsequent files follow established schema

---

## 🔗 Related Documents

- [Phase 3 Document](../../../features/template-doc-infrastructure/phase-3.md)
- [VALIDATION.md](../../../../../../scripts/doc-gen/templates/VALIDATION.md)
- [validation-rules/README.md](../../../../../../scripts/doc-gen/templates/validation-rules/README.md)
- [ADR-004: Validation Architecture](../../../decisions/template-doc-infrastructure/adr-004-validation-architecture.md)

---

**Last Updated:** 2026-01-16
