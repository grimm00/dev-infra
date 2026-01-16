# Template Doc Infrastructure - Phase 1: Template Creation

**Phase:** 1 - Template Creation  
**Duration:** 6-8 hours  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** ADRs complete

---

## 📋 Overview

Create all 17 template files organized by workflow category, following the structure defined in ADR-002.

**Success Definition:** All templates created and matching current command output.

---

## 🎯 Goals

1. **Create exploration templates** - README, exploration.md, research-topics.md
2. **Create research templates** - README, research-topic.md, summary, requirements
3. **Create decision templates** - README, adr-NNN.md, summary
4. **Create planning templates** - README, feature-plan.md, phase-N.md, status
5. **Create other templates** - Handoff, fix-batch, reflection

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan template-doc-infrastructure --expand --phase 1` to add detailed tasks.

### Task Categories

- [ ] **Exploration Templates (3)** - Hub, exploration, research-topics
- [ ] **Research Templates (4)** - Hub, topic, summary, requirements
- [ ] **Decision Templates (3)** - Hub, ADR, summary
- [ ] **Planning Templates (4)** - Hub, feature-plan, phase, status
- [ ] **Other Templates (3)** - Handoff, fix-batch, reflection

---

## ✅ Completion Criteria

- [ ] 17 template files created in `scripts/doc-gen/templates/`
- [ ] Templates use `${VAR}` syntax for script variables
- [ ] Templates use `<!-- AI: -->` for AI content markers
- [ ] Templates use `<!-- EXPAND: -->` for expansion zones
- [ ] Templates match current command output format

---

## 📦 Deliverables

- `scripts/doc-gen/templates/exploration/README.md.tmpl`
- `scripts/doc-gen/templates/exploration/exploration.md.tmpl`
- `scripts/doc-gen/templates/exploration/research-topics.md.tmpl`
- `scripts/doc-gen/templates/research/README.md.tmpl`
- `scripts/doc-gen/templates/research/research-topic.md.tmpl`
- `scripts/doc-gen/templates/research/research-summary.md.tmpl`
- `scripts/doc-gen/templates/research/requirements.md.tmpl`
- `scripts/doc-gen/templates/decision/README.md.tmpl`
- `scripts/doc-gen/templates/decision/adr.md.tmpl`
- `scripts/doc-gen/templates/decision/decisions-summary.md.tmpl`
- `scripts/doc-gen/templates/planning/README.md.tmpl`
- `scripts/doc-gen/templates/planning/feature-plan.md.tmpl`
- `scripts/doc-gen/templates/planning/phase.md.tmpl`
- `scripts/doc-gen/templates/planning/status-and-next-steps.md.tmpl`
- `scripts/doc-gen/templates/other/handoff.md.tmpl`
- `scripts/doc-gen/templates/other/fix-batch.md.tmpl`
- `scripts/doc-gen/templates/other/reflection.md.tmpl`

---

## 🔗 Dependencies

### Prerequisites

- [x] ADR-002: Template Structure Standard (defines templates)
- [x] Research: Template Inventory (identifies 17 templates)

### Blocks

- Phase 2: Format Specification (needs templates to reference)
- Phase 3: Validation Rules (needs templates to validate)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [ADR-002: Template Structure Standard](../../../decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [Research: Template Inventory](../../../research/template-doc-infrastructure/research-template-inventory.md)

---

**Last Updated:** 2026-01-14  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan template-doc-infrastructure --expand --phase 1`
