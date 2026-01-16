# Feature: Template Doc Infrastructure

**Feature:** Template-Based Documentation Infrastructure  
**Status:** 🟠 In Progress  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-16

---

## 📋 Quick Links

### Planning Documents

- **[Transition Plan](transition-plan.md)** - Implementation roadmap (🔴 Not Started)
- **[Phase 1: Template Creation](phase-1.md)** - Create 17 templates (✅ Complete)
- **[Phase 2: Format Specification](phase-2.md)** - Document standards (🔴 Scaffolding)
- **[Phase 3: Validation Rules](phase-3.md)** - Define validation spec (🔴 Scaffolding)

### Research & Decisions

- **[Exploration](../../../explorations/template-doc-infrastructure/README.md)** - Initial exploration (✅ Complete)
- **[Research](../../../research/template-doc-infrastructure/README.md)** - 7 research topics (✅ Complete)
- **[Decisions](../../../decisions/template-doc-infrastructure/README.md)** - 5 ADRs (✅ Complete)

### Related Work (dev-toolkit)

- **dev-toolkit Feature:** Tooling implementation (dt-doc-gen, dt-doc-validate)
- **Command Migration:** Per-command updates after tooling available

---

## 🎯 Overview

This feature implements the **template portion** of the template-based documentation infrastructure. Per ADR-001, templates live in dev-infra while tooling lives in dev-toolkit.

**Scope (dev-infra):**
- 17 template files organized by workflow category
- Format specification and placeholder conventions
- Validation rules per doc type (spec for tooling)

**Out of Scope (dev-toolkit):**
- `dt-doc-gen` CLI implementation
- `dt-doc-validate` CLI implementation
- Command migration

---

## 📊 Phase Summary

| Phase | Name | Status | Deliverables |
|-------|------|--------|--------------|
| [Phase 1](phase-1.md) | Template Creation | ✅ Complete | 17 template files |
| [Phase 2](phase-2.md) | Format Specification | 🔴 Scaffolding | Placeholder docs, format spec |
| [Phase 3](phase-3.md) | Validation Rules | 🔴 Scaffolding | Validation spec per doc type |

**Total Estimated Effort:** 12-16 hours

---

## ✅ Success Criteria

- [x] All 17 templates created in `scripts/doc-gen/templates/`
- [ ] Format specification documented
- [ ] Placeholder conventions documented
- [ ] Validation rules defined per doc type
- [ ] Templates produce identical output to current command behavior

---

## 🔗 Dependencies

### Prerequisites

- ✅ Exploration complete
- ✅ Research complete (7 topics)
- ✅ Decisions complete (5 ADRs)

### Enables

- dev-toolkit: `dt-doc-gen` implementation
- dev-toolkit: `dt-doc-validate` implementation
- Command migration (after tooling available)

---

## 🔗 Related Documents

- [Requirements](../../../research/template-doc-infrastructure/requirements.md) - 36 FRs, 18 NFRs, 18 Cs
- [ADR-001: Architectural Placement](../../../decisions/template-doc-infrastructure/adr-001-architectural-placement.md)
- [ADR-002: Template Structure Standard](../../../decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [ADR-005: Command Integration](../../../decisions/template-doc-infrastructure/adr-005-command-integration.md)

---

**Last Updated:** 2026-01-16  
**Status:** 🟠 In Progress  
**Next:** Expand Phase 2 scaffolding
