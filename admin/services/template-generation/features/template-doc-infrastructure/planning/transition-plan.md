# Transition Plan - Template Doc Infrastructure

**Feature:** Template-Based Documentation Infrastructure  
**Status:** 🔴 Not Started  
**Created:** 2026-01-14  
**Source:** [Decisions Summary](../../../decisions/template-doc-infrastructure/decisions-summary.md)  
**Type:** Feature

---

## 📋 Overview

This transition plan implements the **dev-infra portion** of template-based documentation infrastructure. Per ADR-001, templates and format specifications live in dev-infra, while tooling implementation belongs in dev-toolkit.

**Total Scope:**
- 17 template files across 6 workflow categories
- Format specification and placeholder conventions
- Validation rules for tooling implementation

**Related Work (Separate Features):**
- **dev-toolkit:** `dt-doc-gen`, `dt-doc-validate` implementation
- **Command Migration:** 23 commands updated after tooling available

---

## 🎯 Transition Goals

Based on ADR-002 (Template Structure Standard) and ADR-005 (Command Integration):

1. **Template Coverage:** Create all 17 templates for 6 workflows
2. **Consistency:** Ensure templates match current command output exactly
3. **Specification:** Document format for tooling implementers
4. **Validation Spec:** Define rules for `dt-doc-validate` implementation

---

## ✅ Pre-Transition Checklist

- [x] Exploration complete (7 themes, 6 questions)
- [x] Research complete (7 topics, 11 findings)
- [x] Decisions complete (5 ADRs accepted)
- [x] Requirements documented (36 FRs, 18 NFRs, 18 Cs)
- [ ] Feature directory created
- [ ] Phase documents created

---

## 📅 Implementation Phases

### Phase 1: Template Creation

**Goal:** Create all 17 template files organized by workflow category.

**Estimated Effort:** 6-8 hours

**Prerequisites:**
- [x] ADR-002 accepted (template structure)
- [x] Template inventory complete (17 templates identified)

**Tasks:**
- [ ] Create exploration templates (3 files)
- [ ] Create research templates (4 files)
- [ ] Create decision templates (3 files)
- [ ] Create planning templates (4 files)
- [ ] Create other templates (3 files)

**Deliverables:**
- `scripts/doc-gen/templates/exploration/` (3 templates)
- `scripts/doc-gen/templates/research/` (4 templates)
- `scripts/doc-gen/templates/decision/` (3 templates)
- `scripts/doc-gen/templates/planning/` (4 templates)
- `scripts/doc-gen/templates/other/` (3 templates)

**Definition of Done:**
- [ ] All 17 templates created
- [ ] Templates match current command output
- [ ] Directory structure follows ADR-002

**Phase Document:** [phase-1.md](phase-1.md)

---

### Phase 2: Format Specification

**Goal:** Document template format, placeholder conventions, and variable definitions.

**Estimated Effort:** 3-4 hours

**Prerequisites:**
- [ ] Phase 1 complete (templates exist)
- [x] ADR-002 accepted (placeholder types)

**Tasks:**
- [ ] Document placeholder conventions (`${VAR}`, `<!-- AI: -->`, `<!-- EXPAND: -->`)
- [ ] Document standard variables (DATE, TOPIC, STATUS, etc.)
- [ ] Document two-mode support (scaffolding vs full)
- [ ] Create template authoring guide

**Deliverables:**
- `scripts/doc-gen/templates/FORMAT.md` - Format specification
- `scripts/doc-gen/templates/VARIABLES.md` - Variable definitions
- `scripts/doc-gen/templates/AUTHORING.md` - Template authoring guide

**Definition of Done:**
- [ ] Format specification complete
- [ ] Variable definitions documented
- [ ] Authoring guide created
- [ ] Tooling team can implement dt-doc-gen from spec

**Phase Document:** [phase-2.md](phase-2.md)

---

### Phase 3: Validation Rules

**Goal:** Define validation rules for each doc type (spec for dt-doc-validate).

**Estimated Effort:** 3-4 hours

**Prerequisites:**
- [ ] Phase 1 complete (templates exist)
- [x] ADR-004 accepted (validation architecture)

**Tasks:**
- [ ] Document common validation rules (status header, dates, indicators)
- [ ] Document type-specific required sections
- [ ] Define error message format
- [ ] Create validation rule reference

**Deliverables:**
- `scripts/doc-gen/templates/VALIDATION.md` - Validation rules spec
- `scripts/doc-gen/templates/validation-rules/` - Per-type rule definitions

**Definition of Done:**
- [ ] Common rules documented
- [ ] Type-specific rules documented
- [ ] Error format defined
- [ ] Tooling team can implement dt-doc-validate from spec

**Phase Document:** [phase-3.md](phase-3.md)

---

## 📊 Phase Summary

| Phase | Name | Duration | Prerequisites | Deliverables |
|-------|------|----------|---------------|--------------|
| 1 | Template Creation | 6-8 hrs | ADRs complete | 17 templates |
| 2 | Format Specification | 3-4 hrs | Phase 1 | 3 spec docs |
| 3 | Validation Rules | 3-4 hrs | Phase 1, ADR-004 | Validation spec |

**Total:** 12-16 hours

---

## 🚀 Post-Transition Handoff

### To dev-toolkit (Separate Feature)

After Phase 3 complete, dev-toolkit can implement:

1. **`dt-doc-gen` CLI:**
   - Fetch templates from dev-infra
   - envsubst-based variable expansion
   - Mode handling (setup vs full)

2. **`dt-doc-validate` CLI:**
   - Common rules from VALIDATION.md
   - Type-specific rules from validation-rules/
   - Error format per spec

### To Command Migration (Per-Command Work)

After dev-toolkit tooling complete:

1. **Phase 1:** Extract templates from commands (verify match)
2. **Phase 2:** Pilot with `/explore`, `/research`
3. **Phase 3:** Rollout to remaining commands
4. **Phase 4:** Remove inline template fallbacks

---

## ✅ Definition of Done

- [ ] All 17 templates created and validated
- [ ] Format specification complete
- [ ] Validation rules defined
- [ ] Handoff to dev-toolkit documented
- [ ] Feature merged to develop

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Requirements](../../../research/template-doc-infrastructure/requirements.md)
- [ADR-001: Architectural Placement](../../../decisions/template-doc-infrastructure/adr-001-architectural-placement.md)
- [ADR-002: Template Structure Standard](../../../decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [ADR-004: Validation Architecture](../../../decisions/template-doc-infrastructure/adr-004-validation-architecture.md)
- [ADR-005: Command Integration](../../../decisions/template-doc-infrastructure/adr-005-command-integration.md)

---

**Last Updated:** 2026-01-14  
**Status:** 🔴 Not Started  
**Next:** Expand phase scaffolding with `/transition-plan template-doc-infrastructure --expand --phase 1`
