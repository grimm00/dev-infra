# Git Worktree Multi-Agent Development Guide

**Purpose:** Guide for using git worktrees with multiple Cursor agents  
**Status:** ✅ Active  
**Last Updated:** 2025-12-09

---

## 📋 Overview

Git worktrees enable multiple working directories from the same repository, allowing different Cursor agents to work on different branches simultaneously. This unlocks powerful parallel development workflows.

**Key Benefits:**
- ✅ Multiple agents work in parallel without branch switching
- ✅ Each agent stays focused on its specialized role
- ✅ No git conflicts between agents
- ✅ Faster development cycles

---

## 🏗️ Current Setup

### Worktree Structure

```
/Users/cdwilson/Projects/dev-infra/          [develop]  → Planning & Coordination (Sonnet)
├── .cursor/worktrees/dev-infra/
│   ├── implementation/  [feat/*]  → Feature Implementation (Composer)
│   ├── fixes/           [fix/*]   → Quick Fixes (Haiku)
│   └── mfn/             [main]    → Release Management (Sonnet)
```

### Role Assignments

| Worktree | Path | Branch | Agent | Role |
|----------|------|--------|-------|------|
| **Main Repo** | `/Users/cdwilson/Projects/dev-infra` | `develop` | Sonnet | Planning, docs, reviews |
| **Implementation** | `.cursor/worktrees/dev-infra/implementation` | `feat/*` | Composer | TDD implementation |
| **Fixes** | `.cursor/worktrees/dev-infra/fixes` | `fix/*` | Haiku | Quick fixes |
| **Releases** | `.cursor/worktrees/dev-infra/mfn` | `main`/`release/*` | Sonnet | Release prep |

---

## 🚀 How to Use

### Opening Worktrees

**Copy these paths to open in Cursor:**

```
Planning:       /Users/cdwilson/Projects/dev-infra
Implementation: /Users/cdwilson/Projects/dev-infra/.cursor/worktrees/dev-infra/implementation
Fixes:          /Users/cdwilson/Projects/dev-infra/.cursor/worktrees/dev-infra/fixes
Releases:       /Users/cdwilson/.cursor/worktrees/dev-infra/mfn
```

**Steps:**
1. File → Open Folder in Cursor
2. Paste one of the paths above
3. Select agent (bottom-right corner)
4. Repeat for each worktree you want open

---

## 📊 Workflow Examples

### Example 1: Parallel Development

**Scenario:** Implement Phase 3, Task 3 while planning Phase 4

**Window A (Sonnet - Planning):**
```bash
# Path: /Users/cdwilson/Projects/dev-infra
# Branch: develop

# Plan Phase 4
cat admin/planning/features/release-readiness/phase-4.md
# Analyze, create detailed task breakdown

# Monitor implementation progress
git log --oneline feat/release-readiness-phase-3 -5
```

**Window B (Composer - Implementation):**
```bash
# Path: .cursor/worktrees/dev-infra/implementation
# Branch: feat/release-readiness-phase-3-assessment-structure

# Implement Task 3
/task-phase 3 3

# Write tests (RED) → Implement (GREEN) → Refactor
```

**Result:** 🎉 Phase 4 planned while Phase 3 implemented!

---

### Example 2: PR Review + Fix

**Scenario:** Review PR #32, create fix plan, implement fixes

**Window A (Sonnet - Review):**
```bash
/pr-validation 32
/fix-plan 32 --priority HIGH
# Analyze Sourcery feedback
```

**Window B (Haiku - Fixes):**
```bash
# Switch to fixes worktree
# Create fix branch if needed

/fix-implement pr32-batch-high-low-01
# Quick turnaround on fixes
```

**Result:** 🎉 Fixes implemented while review continues!

---

## 🛠️ Management Commands

### Create New Worktree

```bash
cd /Users/cdwilson/Projects/dev-infra

# For new feature
git worktree add .cursor/worktrees/dev-infra/my-feature feat/my-feature

# With new branch
git worktree add -b feat/new-feature .cursor/worktrees/dev-infra/new-feature
```

### Switch Feature Branch

```bash
# Remove old implementation worktree
git worktree remove implementation

# Add new one
git worktree add .cursor/worktrees/dev-infra/implementation feat/new-feature
```

### Clean Up

```bash
# Remove worktree
git worktree remove <worktree-name>

# Prune stale
git worktree prune
```

---

## ⚠️ Important Rules

1. **One branch per worktree** - Can't checkout same branch in multiple worktrees
2. **Commit frequently** - Each worktree is independent, sync via commits
3. **Push to share** - Other worktrees see changes after you push
4. **Main repo = coordination** - Use main repo for git operations and planning

---

## 📚 Detailed Documentation

For complete documentation including workflow patterns, troubleshooting, and advanced tips, see the full guide in `docs/WORKTREE-GUIDE.md` (created but may need manual placement).

---

## 🎯 Quick Start

1. **Open Main Repo:**
   - Path: `/Users/cdwilson/Projects/dev-infra`
   - Agent: Sonnet
   - Use for: Planning, reviews, docs

2. **Open Implementation:**
   - Path: `/Users/cdwilson/Projects/dev-infra/.cursor/worktrees/dev-infra/implementation`
   - Agent: Composer
   - Use for: `/task-phase` implementation work

3. **Try it:**
   - Planning window: Plan next phase
   - Implementation window: Implement current phase
   - See parallel work in action! ✨

---

**Last Updated:** 2025-12-09
