# Template Doc Infrastructure - Phase 2: Format Specification

**Phase:** 2 - Format Specification  
**Duration:** 3-4 hours  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** Phase 1 complete

---

## 📋 Overview

Document template format, placeholder conventions, and variable definitions for tooling implementers.

**Success Definition:** dev-toolkit team can implement `dt-doc-gen` from specification.

---

## 🎯 Goals

1. **Document placeholder conventions** - ${VAR}, <!-- AI: -->, <!-- EXPAND: -->
2. **Document standard variables** - DATE, TOPIC, STATUS, FEATURE_NAME, etc.
3. **Document two-mode support** - Scaffolding vs full generation
4. **Create authoring guide** - How to create/modify templates

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan template-doc-infrastructure --expand --phase 2` to add detailed tasks.

### Task Categories

- [ ] **Placeholder Convention Docs** - Three types, syntax, examples
- [ ] **Variable Reference** - Standard variables, per-workflow variables
- [ ] **Two-Mode Documentation** - Setup vs full, expansion zones
- [ ] **Authoring Guide** - Template creation, testing, contribution

---

## ✅ Completion Criteria

- [ ] FORMAT.md documents all placeholder types
- [ ] VARIABLES.md lists all standard variables
- [ ] AUTHORING.md provides complete guide
- [ ] Two-mode support clearly explained
- [ ] Examples provided for each concept

---

## 📦 Deliverables

- `scripts/doc-gen/templates/FORMAT.md` - Format specification
- `scripts/doc-gen/templates/VARIABLES.md` - Variable definitions
- `scripts/doc-gen/templates/AUTHORING.md` - Template authoring guide

---

## 🔗 Dependencies

### Prerequisites

- [ ] Phase 1: Template Creation (templates exist to reference)
- [x] ADR-002: Template Structure Standard (defines placeholders)
- [x] ADR-003: Generation Architecture (defines envsubst usage)

### Blocks

- dev-toolkit: `dt-doc-gen` implementation (needs format spec)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Phase 1: Template Creation](phase-1.md)
- [ADR-002: Template Structure Standard](../../../decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [ADR-003: Generation Architecture](../../../decisions/template-doc-infrastructure/adr-003-generation-architecture.md)

---

**Last Updated:** 2026-01-14  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan template-doc-infrastructure --expand --phase 2`
