# Explore Two-Mode - Phase 1: Command Structure

**Phase:** 1 - Command Structure  
**Duration:** ~2 hours  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** ADR-001, ADR-004 approved

---

## 📋 Overview

Implement the two-mode pattern (Setup + Conduct) in the `/explore` command with consistent scaffolding boundaries.

**Success Definition:** `/explore` creates scaffolding by default; `--conduct` expands with detail.

---

## 🎯 Goals

1. **Two-Mode Structure** - Implement Setup (default) and Conduct (`--conduct`) modes
2. **Scaffolding Template** - Create ~60-80 line exploration scaffolding
3. **Conduct Template** - Create ~200-300 line expanded exploration
4. **Status Indicators** - `🔴 Scaffolding` → `✅ Expanded`

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan explore-two-mode --expand --phase 1` to add detailed TDD tasks.

### Task Categories

- [ ] **Command Structure** - Add mode selection logic to explore.md
- [ ] **Scaffolding Output** - Create exploration scaffolding template
- [ ] **Conduct Output** - Create expanded exploration template
- [ ] **Status Management** - Add status indicator logic
- [ ] **Directory Structure** - Update exploration file structure

---

## ✅ Completion Criteria

- [ ] `/explore [topic]` creates scaffolding (~60-80 lines)
- [ ] `/explore [topic] --conduct` expands to ~200-300 lines
- [ ] Status shows `🔴 Scaffolding` after setup, `✅ Expanded` after conduct
- [ ] Placeholder message guides user to conduct mode
- [ ] research-topics.md created in setup mode

---

## 📦 Deliverables

- Updated `.cursor/commands/explore.md`
- Exploration scaffolding template
- Conduct expansion template

---

## 🔗 Dependencies

### Prerequisites

- ADR-001: Two-Mode Pattern (approved)
- ADR-004: Scaffolding Boundaries (approved)

### Blocks

- Phase 2: Input Sources (needs command structure)
- Phase 3: Worktree Integration (needs conduct mode)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Next Phase: Phase 2](phase-2.md)
- [ADR-001](../../../decisions/explore-two-mode/adr-001-two-mode-pattern.md)
- [ADR-004](../../../decisions/explore-two-mode/adr-004-scaffolding-boundaries.md)

---

**Last Updated:** 2026-01-10  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan explore-two-mode --expand --phase 1`
