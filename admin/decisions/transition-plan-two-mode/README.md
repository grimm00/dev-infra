# Transition-Plan Two-Mode Pattern - Decisions Hub

**Purpose:** Decisions for redesigning `/transition-plan` with setup + expand modes  
**Status:** 🔴 Proposed  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## 📋 Quick Links

- **[Decisions Summary](decisions-summary.md)** - Summary of all decisions
- **[Research Hub](../../research/transition-plan-two-mode/README.md)** - Related research
- **[Requirements](../../research/transition-plan-two-mode/requirements.md)** - Requirements document
- **[Exploration](../../explorations/transition-plan-two-mode/README.md)** - Original exploration

### ADR Documents

| ADR | Decision | Status |
|-----|----------|--------|
| [ADR-001](adr-001-two-mode-pattern-adoption.md) | Adopt Two-Mode Pattern | 🔴 Proposed |

---

## 🎯 Decisions Overview

This decision addresses problems with the current `/transition-plan` command:

| Problem | Solution |
|---------|----------|
| Variable output | Simpler scaffolding = predictable |
| Inconsistent TDD | Dedicated expand mode |
| No human review | Review scaffolding before expanding |

**Decision:** Adopt the two-mode pattern (Setup + Expand) mirroring the `/research` command.

---

## 📊 Decision Status

| # | Decision | Status | ADR |
|---|----------|--------|-----|
| 1 | Adopt Two-Mode Pattern | 🔴 Proposed | [ADR-001](adr-001-two-mode-pattern-adoption.md) |

**Total Decisions:** 1  
**Status:** 🔴 Pending Approval

---

## 🚀 Next Steps

1. ✅ ADR created
2. 🔴 Review and approve ADR
3. Use `/transition-plan --from-adr admin/decisions/transition-plan-two-mode/adr-001-two-mode-pattern-adoption.md` to create implementation plan

---

**Last Updated:** 2025-12-29

