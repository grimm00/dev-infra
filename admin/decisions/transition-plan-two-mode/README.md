# Transition-Plan Two-Mode Pattern - Decisions Hub

**Purpose:** Decisions for redesigning `/transition-plan` with setup + expand modes  
**Status:** 🟡 In Progress  
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
| ADR-002 | Scaffolding Content Design | [Scaffolding Design](../../research/transition-plan-two-mode/research-scaffolding-design.md) | ⏳ Pending |
| ADR-003 | Command Structure Refactoring | [Command Structure](../../research/transition-plan-two-mode/research-command-structure.md) | ⏳ Pending |

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
| 2 | Scaffolding Content Design | ✅ Complete | ⏳ Pending |
| 3 | Command Structure Refactoring | ✅ Complete | ⏳ Pending |

**Progress:** 1/3 ADRs created

---

## 🚀 Next Steps

1. ✅ ADR-001 created (Pattern Analysis)
2. 🔴 Create ADR-002 (Scaffolding Design): `/decision transition-plan-two-mode --from-research research-scaffolding-design.md`
3. 🔴 Create ADR-003 (Command Structure): `/decision transition-plan-two-mode --from-research research-command-structure.md`
4. Review and approve all ADRs
5. Use `/transition-plan --from-adr` to create implementation plan

---

**Last Updated:** 2025-12-29
