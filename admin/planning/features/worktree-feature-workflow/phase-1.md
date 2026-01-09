# Worktree Feature Workflow - Phase 1: Configuration

**Phase:** 1 - Configuration  
**Duration:** ~30 minutes  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** None

---

## 📋 Overview

Set up `.gitignore` and `.sourcery.yaml` in dev-infra root to enable the worktree workflow.

**Success Definition:** Dev-infra has proper gitignore entries and Sourcery configuration.

---

## 🎯 Goals

1. **Add gitignore entries** - Exclude `worktrees/` and `tmp/` from git tracking
2. **Create .sourcery.yaml** - Configure Sourcery to ignore process documentation

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan worktree-feature-workflow --expand --phase 1` to add detailed tasks.

### Task Categories

- [ ] **Gitignore Updates** - Add worktrees/ and tmp/ to .gitignore
- [ ] **Sourcery Configuration** - Create .sourcery.yaml with ignore patterns
- [ ] **Verification** - Confirm configuration works

---

## ✅ Completion Criteria

- [ ] `.gitignore` includes `worktrees/` entry
- [ ] `.gitignore` includes `tmp/` entry  
- [ ] `.sourcery.yaml` exists in root
- [ ] `.sourcery.yaml` ignores `admin/**`
- [ ] `.sourcery.yaml` ignores `tmp/**`

---

## 📦 Deliverables

- Updated `.gitignore` file
- New `.sourcery.yaml` file

---

## 🔗 Dependencies

### Prerequisites

- None (first phase)

### Blocks

- Phase 2 (Template Updates) - needs `.sourcery.yaml` as reference

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Next Phase: Phase 2](phase-2.md)
- [ADR-004: Sourcery Configuration](../../decisions/worktree-feature-workflow/adr-004-sourcery-configuration.md)

---

**Last Updated:** 2026-01-09  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan worktree-feature-workflow --expand --phase 1`
