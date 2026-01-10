# Decision Two-Mode Pattern - Feature Hub

**Purpose:** Apply two-mode pattern (Setup + Expand) to `/decision` command  
**Status:** 🟡 Planned  
**Priority:** 🟢 Low  
**Created:** 2025-12-30  
**Source:** reflection-transition-plan-two-mode-2025-12-29.md

---

## 📋 Quick Links

- **[Feature Plan](feature-plan.md)** - Feature overview and goals
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress tracking

### Related

- **[/decision Command](../../../../.cursor/commands/decision.md)** - Current command implementation
- **[/transition-plan Command](../../../../.cursor/commands/transition-plan.md)** - Pattern source
- **[Explore Two-Mode](../explore-two-mode/)** - Should be completed first

---

## 🎯 Feature Overview

Refactor `/decision` to use Setup + Expand pattern for ADR creation.

**Problem:** Current `/decision` produces ADRs in single pass without review checkpoint.

**Solution:** Implement two-mode pattern:
- **Setup Mode (default):** Create ADR scaffolding
- **Expand Mode (`--expand`):** Fill scaffolding with detailed content

**Note:** This should be implemented after `/explore` two-mode is complete.

---

## 📊 Feature Status

| Phase | Name | Status | Effort |
|-------|------|--------|--------|
| Phase 1 | Design | 🔴 Not Started | ~1 hour |
| Phase 2 | Implementation | 🔴 Not Started | ~2 hours |

**Total Estimated Effort:** ~3 hours

---

## ⚠️ Prerequisites

- [ ] `/explore` two-mode pattern complete

---

## 🚀 Next Steps

1. Wait for `/explore` two-mode completion
2. Follow same pattern as transition-plan
3. Create ADR scaffolding vs detail boundaries

---

**Last Updated:** 2025-12-30

