# Decisions Summary - Template Doc Infrastructure

**Purpose:** Summary of all architecture decisions  
**Status:** ✅ Complete  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14

---

## 📋 Decisions Overview

This document summarizes all architecture decisions for the template-based documentation infrastructure. Decisions are based on 7 completed research topics with 36 functional requirements, 18 non-functional requirements, and 18 constraints.

**Decision Points:** 5 ADRs  
**Status:** ✅ All Accepted

---

## 🎯 Key Decisions

### ADR-001: Architectural Placement (Four-Arm Question)

**Decision:** Split template documentation infrastructure across two repositories: **Templates** in dev-infra (source), **Tooling** in dev-toolkit (distribution).

**Status:** ✅ Accepted

**Key Points:**
- Templates in dev-infra (`scripts/doc-gen/templates/`) - source of truth
- Tooling in dev-toolkit (`bin/dt-doc-gen`, `bin/dt-doc-validate`)
- Follows dt-review precedent and ADR-001 (Project Identity)
- Independent versioning of templates and tooling

**ADR:** [adr-001-architectural-placement.md](adr-001-architectural-placement.md)

---

### ADR-002: Template Structure Standard

**Decision:** Adopt hybrid template structure with 17 templates, 5 common patterns, 3 placeholder types, and envsubst-compatible `${VAR}` syntax.

**Status:** ✅ Accepted

**Key Points:**
- 17 template files organized by workflow category
- 5 common patterns (status header, quick links, status tables, next steps, related links)
- 3 placeholder types: `${VAR}` (script), `<!-- AI: -->` (content), `<!-- EXPAND: -->` (zones)
- Supports two-mode generation (scaffolding + expansion)

**ADR:** [adr-002-template-structure-standard.md](adr-002-template-structure-standard.md)

---

### ADR-003: Generation Architecture

**Decision:** Adopt shared library architecture with template files and unified CLI (`dt-doc-gen`), using envsubst for variable expansion.

**Status:** ✅ Accepted

**Key Points:**
- Shared library (`lib/`) for common functions
- Template files (`.tmpl`) for each document type
- Unified CLI with subcommand interface (`dt-doc-gen exploration my-topic`)
- envsubst for simple, portable variable expansion
- Two modes: scaffolding (setup) and full (conduct)

**ADR:** [adr-003-generation-architecture.md](adr-003-generation-architecture.md)

---

### ADR-004: Validation Architecture

**Decision:** Adopt layered validation architecture with on-demand CLI (`dt-doc-validate`) as primary interface, CI enforcement, and optional pre-commit.

**Status:** ✅ Accepted

**Key Points:**
- Layer 1: Shared library (`lib/doc-validate.sh`)
- Layer 2: CLI tool (`dt-doc-validate`) as primary interface
- Layer 3: Commands call CLI (not own validation)
- On-demand primary, CI enforcement, pre-commit optional
- Actionable errors with file, location, fix suggestion

**ADR:** [adr-004-validation-architecture.md](adr-004-validation-architecture.md)

---

### ADR-005: Command Integration Pattern

**Decision:** Commands remain orchestrators but delegate structure generation to scripts (`dt-doc-gen`) and validation to `dt-doc-validate`. AI fills placeholders only.

**Status:** ✅ Accepted

**Key Points:**
- Commands invoke `dt-doc-gen` for structure (not inline templates)
- AI fills `<!-- AI: -->` and `<!-- EXPAND: -->` placeholders
- Commands invoke `dt-doc-validate` before commit
- Incremental 4-phase migration (extract → pilot → rollout → cleanup)
- Two-mode support via expansion zones for `/explore`, `/research`
- 154 inline templates → 17 external templates

**ADR:** [adr-005-command-integration.md](adr-005-command-integration.md)

---

## 📋 Requirements Coverage

| ADR | FRs Covered | NFRs Covered | Constraints |
|-----|-------------|--------------|-------------|
| ADR-001 | FR-15 to FR-18 | NFR-9, NFR-10 | C-7 to C-9 |
| ADR-002 | FR-1 to FR-5, FR-34 to FR-36 | NFR-1 to NFR-3, NFR-17, NFR-18 | - |
| ADR-003 | FR-6 to FR-10, FR-31 to FR-33 | NFR-4 to NFR-8, NFR-15, NFR-16 | C-17, C-18 |
| ADR-004 | FR-19 to FR-25 | NFR-11, NFR-12 | C-10 to C-12 |
| ADR-005 | FR-26 to FR-30 | NFR-13, NFR-14 | C-13, C-14 |

**Total Coverage:** 36/36 FRs, 18/18 NFRs, 18/18 Constraints ✅

---

## 🏗️ Implementation Impact

### dev-infra (This Repository)

**Templates & Specification:**

- [ ] Create template files in `scripts/doc-gen/templates/`
  - [ ] Exploration templates (README, exploration.md, research-topics.md)
  - [ ] Research templates (README, research-*.md, summary, requirements)
  - [ ] Decision templates (README, adr-NNN.md, summary)
  - [ ] Planning templates (README, feature-plan.md, phase-N.md)
  - [ ] Handoff template
- [ ] Document template format specification
- [ ] Document placeholder conventions
- [ ] Document validation rules per doc type

### dev-toolkit (Separate Feature)

**Tooling Implementation:**

- [ ] Create `dt-doc-gen` CLI script
  - [ ] Template fetching from dev-infra
  - [ ] envsubst-based variable expansion
  - [ ] Mode handling (setup vs full)
- [ ] Create `dt-doc-validate` CLI script
  - [ ] Common rules (status, dates, indicators)
  - [ ] Type-specific section validation
  - [ ] JSON and quiet output modes
- [ ] Create shared library (`lib/doc-*.sh`)
- [ ] Implement template caching

### Command Migration (Per-Command Work)

- [ ] Phase 1: Extract templates from commands
- [ ] Phase 2: Pilot with `/explore`, `/research`
- [ ] Phase 3: Incremental rollout to remaining commands
- [ ] Phase 4: Remove inline template fallbacks

---

## 🚀 Next Steps

1. Review and approve ADRs
2. Create transition plan using `/transition-plan --from-adr`
3. Implement in phases per ADR-005 migration plan

---

## 🔗 Related Documents

- [Research Summary](../../research/template-doc-infrastructure/research-summary.md)
- [Requirements](../../research/template-doc-infrastructure/requirements.md)
- [Exploration](../../explorations/template-doc-infrastructure/README.md)

---

**Last Updated:** 2026-01-14
