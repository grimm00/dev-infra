# Explore Two-Mode - Phase 3: Worktree Integration

**Phase:** 3 - Worktree Integration  
**Duration:** ~1.5 hours  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** Phase 1 complete, ADR-003 approved

---

## 📋 Overview

Implement lazy worktree creation that prompts on conduct mode, aligning with ADR-002 (self-contained feature branches) while keeping setup mode lightweight.

**Success Definition:** Setup mode stays on develop; conduct mode prompts for worktree creation with override flags.

---

## 🎯 Goals

1. **Lazy Creation** - Setup mode does NOT create worktree
2. **Conduct Prompt** - Prompt for worktree on `--conduct`
3. **Explicit Flags** - `--worktree` (auto) and `--no-worktree` (skip)
4. **Integration** - Work with existing `scripts/worktrees.sh`

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan explore-two-mode --expand --phase 3` to add detailed TDD tasks.

### Task Categories

- [ ] **Prompt Logic** - Add worktree prompt on conduct mode
- [ ] **--worktree Flag** - Auto-create without prompting
- [ ] **--no-worktree Flag** - Skip prompt, stay on current branch
- [ ] **Script Integration** - Integrate with worktrees.sh
- [ ] **Documentation** - Update command docs with worktree behavior

---

## ✅ Completion Criteria

- [ ] `/explore [topic]` (setup) does NOT prompt for worktree
- [ ] `/explore [topic] --conduct` prompts "Create worktree?"
- [ ] `/explore [topic] --conduct --worktree` creates without prompting
- [ ] `/explore [topic] --conduct --no-worktree` skips prompt
- [ ] Worktree follows naming convention: `worktrees/feat-[topic]`
- [ ] Branch follows naming convention: `feat/[topic]`

---

## 📦 Deliverables

- Worktree integration in explore.md
- Updated worktrees.sh (if needed)
- Command documentation updates

---

## 🔗 Dependencies

### Prerequisites

- Phase 1: Command Structure (complete) - needs conduct mode
- ADR-003: Worktree Integration (approved)
- Worktree Feature Workflow (v0.8.0)

### Blocks

- Phase 4: Template Updates (needs worktree logic)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 2](phase-2.md)
- [Next Phase: Phase 4](phase-4.md)
- [ADR-003](../../../decisions/explore-two-mode/adr-003-worktree-integration.md)
- [Worktree Workflow ADR-002](../../../decisions/worktree-feature-workflow/adr-002-self-contained-feature-branches.md)

---

**Last Updated:** 2026-01-10  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan explore-two-mode --expand --phase 3`
