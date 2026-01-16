# Template Doc Infrastructure - Phase 3: Validation Rules

**Phase:** 3 - Validation Rules  
**Duration:** 3-4 hours  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** Phase 1 complete, ADR-004 accepted

---

## 📋 Overview

Define validation rules for each doc type, providing the specification for `dt-doc-validate` implementation.

**Success Definition:** dev-toolkit team can implement `dt-doc-validate` from specification.

---

## 🎯 Goals

1. **Document common rules** - Status header, dates, indicators
2. **Document type-specific rules** - Required sections per doc type
3. **Define error format** - Actionable messages with file, location, fix
4. **Create rule reference** - Per-type validation rules

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan template-doc-infrastructure --expand --phase 3` to add detailed tasks.

### Task Categories

- [ ] **Common Rules Documentation** - Status, dates, indicators
- [ ] **Type-Specific Rules** - Required sections per doc type (6 types)
- [ ] **Error Format Specification** - Message structure, examples
- [ ] **Rule Reference Files** - Per-type validation definitions

---

## ✅ Completion Criteria

- [ ] Common validation rules documented
- [ ] Type-specific rules for all 6 doc types
- [ ] Error message format defined
- [ ] Rule reference files created
- [ ] Validation spec complete for tooling team

---

## 📦 Deliverables

- `scripts/doc-gen/templates/VALIDATION.md` - Validation rules spec
- `scripts/doc-gen/templates/validation-rules/exploration.yaml` - Exploration rules
- `scripts/doc-gen/templates/validation-rules/research.yaml` - Research rules
- `scripts/doc-gen/templates/validation-rules/decision.yaml` - Decision rules
- `scripts/doc-gen/templates/validation-rules/planning.yaml` - Planning rules
- `scripts/doc-gen/templates/validation-rules/handoff.yaml` - Handoff rules
- `scripts/doc-gen/templates/validation-rules/fix.yaml` - Fix rules

---

## 🔗 Dependencies

### Prerequisites

- [ ] Phase 1: Template Creation (templates exist to validate)
- [x] ADR-004: Validation Architecture (defines validation approach)
- [x] Research: Validation Approach (defines rules)

### Blocks

- dev-toolkit: `dt-doc-validate` implementation (needs validation spec)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Phase 1: Template Creation](phase-1.md)
- [ADR-004: Validation Architecture](../../../decisions/template-doc-infrastructure/adr-004-validation-architecture.md)
- [Research: Validation Approach](../../../research/template-doc-infrastructure/research-validation-approach.md)

---

**Last Updated:** 2026-01-14  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan template-doc-infrastructure --expand --phase 3`
