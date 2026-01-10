# Explore Two-Mode Pattern - Feature Hub

**Purpose:** Apply two-mode pattern (Setup + Conduct) to `/explore` command  
**Status:** 🟡 Planned  
**Priority:** 🔴 High  
**Created:** 2025-12-30  
**Source:** reflection-transition-plan-two-mode-2025-12-29.md

---

## 📋 Quick Links

- **[Feature Plan](feature-plan.md)** - Feature overview and goals
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress tracking
- **[Transition-Plan Validation](transition-plan-validation.md)** - Evidence from PR #57 ⭐ **NEW**

### Related

- **[/explore Command](../../../../.cursor/commands/explore.md)** - Current command implementation
- **[/research Command](../../../../.cursor/commands/research.md)** - Pattern source (has `--conduct`)
- **[/transition-plan Command](../../../../.cursor/commands/transition-plan.md)** - Recent two-mode implementation
- **[Transition-Plan Two-Mode Learnings](../../opportunities/internal/dev-infra/learnings/transition-plan-two-mode/)** - Learnings to apply
- **[Template Sync Drift Fix](../../ci/template-sync-drift-fix/)** - Example of transition-plan in action (PR #57)

---

## 🎯 Feature Overview

Refactor `/explore` to use Setup + Conduct pattern, mirroring `/research` and `/transition-plan`.

**Problem:** Current `/explore` produces variable output sizes and doesn't provide a human review checkpoint before detailed exploration.

**Solution:** Implement two-mode pattern:
- **Setup Mode (default):** Create exploration scaffolding (~60-80 lines)
- **Conduct Mode (`--conduct`):** Fill scaffolding with detailed exploration (~200-300 lines)

---

## 📊 Feature Status

| Phase | Name | Status | Effort |
|-------|------|--------|--------|
| Phase 1 | Exploration & Research | 🔴 Not Started | ~1 hour |
| Phase 2 | Implementation | 🔴 Not Started | ~2 hours |

**Total Estimated Effort:** ~3 hours

---

## 🚀 Next Steps

1. Create exploration for `/explore` two-mode pattern
2. Research scaffolding vs conduct content boundaries
3. Create ADRs if needed
4. Implement following transition-plan pattern

---

**Last Updated:** 2025-12-30

