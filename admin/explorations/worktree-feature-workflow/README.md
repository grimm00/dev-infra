# Worktree Feature Workflow

**Purpose:** Refined git worktree workflow for self-contained feature development  
**Status:** 🔴 Exploration  
**Last Updated:** 2026-01-09

---

## 📋 Quick Links

### Exploration Phase

- **[Exploration Document](exploration.md)** - What we're exploring and why (🔴 Active)
- **[Research Topics](research-topics.md)** - Topics to investigate (🔴 Ready)

### Research Phase (Future)

- Research documents will be created in `admin/research/worktree-feature-workflow/`

### Decision Phase (Future)

- ADRs will be created in `admin/decisions/worktree-feature-workflow/`

---

## 🎯 Overview

This exploration addresses workflow improvements for feature development using git worktrees:

| Concern | Problem | Proposed Solution |
|---------|---------|-------------------|
| **Worktree naming** | Cursor creates random names (`wxw`) | Manual creation with meaningful names |
| **Doc isolation** | Docs committed to develop prematurely | All docs on feature branch |
| **Review gate** | Ideas that fail pollute history | PR as review gate before merge |
| **Sourcery noise** | Docs flagged in code reviews | sourcery.yml ignores doc paths |

---

## 📊 Current Status

| Phase | Status | Notes |
|-------|--------|-------|
| Exploration | 🔴 Active | Initial capture complete |
| Research | ⏸️ Pending | 5 topics identified |
| Decision | ⏸️ Pending | After research |
| Implementation | ⏸️ Pending | After decisions |

---

## 🔗 Related

- **[WORKTREE-GUIDE.md](../../../docs/WORKTREE-GUIDE.md)** - Existing worktree documentation
- **[explore-two-mode](../explore-two-mode/)** - Related command enhancement exploration

---

**Created:** 2026-01-09  
**Next:** Research phase when ready
