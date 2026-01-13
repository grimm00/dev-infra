# Explore Two-Mode Enhancement - Feature Hub

**Purpose:** Enhance `/explore` with two-mode pattern, input sources, and worktree integration  
**Status:** 🟠 In Progress  
**Priority:** 🔴 High  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-13

---

## 📋 Quick Links

### Planning Documents

- **[Feature Plan](feature-plan.md)** - Original feature overview
- **[Transition Plan](transition-plan.md)** - Implementation plan from ADRs ⭐ **NEW**
- **[Status & Next Steps](status-and-next-steps.md)** - Progress tracking

### Phase Documents

| Phase | Name | Status | Effort |
|-------|------|--------|--------|
| [Phase 1](phase-1.md) | Command Structure | ✅ Complete | ~2 hours |
| [Phase 2](phase-2.md) | Input Sources | ✅ Complete | ~2 hours |
| [Phase 3](phase-3.md) | Worktree Integration | 🔴 Scaffolding | ~1.5 hours |
| [Phase 4](phase-4.md) | Template & Documentation | 🔴 Scaffolding | ~1.5 hours |

**Total Estimated Effort:** ~7 hours

### Research & Decisions

- **[Exploration](../../../explorations/explore-two-mode/)** - Initial exploration
- **[Research](../../../research/explore-two-mode/)** - 7 research topics complete
- **[Decisions](../../../decisions/explore-two-mode/)** - 4 ADRs created ⭐ **NEW**
- **[Requirements](../../../research/explore-two-mode/requirements.md)** - 24 FRs, 13 NFRs

### Related

- **[/explore Command](../../../../.cursor/commands/explore.md)** - Current implementation
- **[/research Command](../../../../.cursor/commands/research.md)** - Two-mode pattern source
- **[Worktree Workflow](../../../../docs/WORKTREE-WORKFLOW.md)** - Worktree integration guide

---

## 🎯 Feature Overview

Enhance `/explore` to serve as the **ideation pipeline entry point**:

1. **Two-Mode Pattern** (ADR-001) - Setup creates scaffolding; Conduct expands
2. **Input Sources** (ADR-002) - Raw text, start.txt, reflections
3. **Worktree Integration** (ADR-003) - Lazy creation on conduct mode
4. **Scaffolding Boundaries** (ADR-004) - ~60-80 setup, ~200-300 conduct

**Problem:** Current `/explore` produces variable output without review checkpoint.

**Solution:** Two-mode pattern with lazy worktree creation and multiple input sources.

---

## 📊 Progress Summary

| Area | Status | Notes |
|------|--------|-------|
| Exploration | ✅ Complete | 7 topics identified |
| Research | ✅ Complete | 7 topics, 13 insights |
| Decisions | ✅ Complete | 4 ADRs created |
| Transition Plan | ✅ Complete | 4 phases scaffolded |
| Phase 1 | ✅ Complete | Implemented 2026-01-13 |
| Phase 2 | ✅ Complete | Implemented 2026-01-13 |
| Phase 3 | 🔴 Scaffolding | Needs expansion |
| Phase 4 | 🔴 Scaffolding | Needs expansion |

---

## 🔗 Command Pipeline Position

```
┌─────────┐    ┌──────────┐    ┌──────────┐    ┌─────────────────┐    ┌────────────┐
│ /explore│ → │ /research│ → │ /decision│ → │ /transition-plan│ → │ /task-phase│
└─────────┘    └──────────┘    └──────────┘    └─────────────────┘    └────────────┘
     ↑
  Entry point
  - Raw thoughts → structured themes
  - Outputs: research-topics.md
```

---

## 🚀 Next Steps

1. **Expand Phase 3:** `/transition-plan explore-two-mode --expand --phase 3` - Worktree integration
2. **Implement Phase 3:** `/task-phase 3 1` - Add worktree integration documentation
3. **Continue through phases sequentially**

---

**Last Updated:** 2026-01-13
