# Transition-Plan Two-Mode Pattern - Decisions Hub

**Purpose:** Decisions for redesigning `/transition-plan` with setup + expand modes  
**Status:** ✅ Complete  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## 📋 Quick Links

- **[Decisions Summary](decisions-summary.md)** - Summary of all decisions
- **[Research Hub](../../research/transition-plan-two-mode/README.md)** - Related research
- **[Requirements](../../research/transition-plan-two-mode/requirements.md)** - Requirements document
- **[Exploration](../../explorations/transition-plan-two-mode/README.md)** - Original exploration

### ADR Documents

| ADR | Decision | Research Source | Status |
|-----|----------|-----------------|--------|
| [ADR-001](adr-001-flag-based-mode-switching.md) | Flag-Based Mode Switching | [Pattern Analysis](../../research/transition-plan-two-mode/research-pattern-analysis.md) | 🔴 Proposed |
| [ADR-002](adr-002-scaffolding-content-boundaries.md) | Scaffolding Content Boundaries | [Scaffolding Design](../../research/transition-plan-two-mode/research-scaffolding-design.md) | 🔴 Proposed |
| [ADR-003](adr-003-command-structure-refactoring.md) | Command Structure Refactoring | [Command Structure](../../research/transition-plan-two-mode/research-command-structure.md) | 🔴 Proposed |

---

## 🎯 Decisions Overview

This decision set addresses problems with the current `/transition-plan` command:

| Problem | Research Topic | ADR |
|---------|----------------|-----|
| How to switch between modes? | Pattern Analysis | ADR-001 |
| What content goes in scaffolding vs expansion? | Scaffolding Design | ADR-002 |
| How to restructure the command docs? | Command Structure | ADR-003 |

**Approach:** One ADR per research topic, each addressing a specific decision.

---

## 📊 Decision Status

| # | Decision | Research | Status |
|---|----------|----------|--------|
| 1 | Flag-Based Mode Switching | ✅ Complete | 🔴 Proposed |
| 2 | Scaffolding Content Boundaries | ✅ Complete | 🔴 Proposed |
| 3 | Command Structure Refactoring | ✅ Complete | 🔴 Proposed |

**Progress:** 3/3 ADRs created ✅

---

## 🚀 Next Steps

1. ✅ ADR-001 created (Pattern Analysis)
2. ✅ ADR-002 created (Scaffolding Design)
3. ✅ ADR-003 created (Command Structure)
4. 🔴 Review and approve all ADRs
5. Use `/transition-plan --from-adr` to create implementation plan

---

**Last Updated:** 2025-12-29
