# Worktree Feature Workflow - Research Topics

**Purpose:** Define research topics for worktree feature workflow exploration  
**Status:** 🔴 Ready  
**Last Updated:** 2026-01-09

---

## 📋 Research Topics

### Topic 1: Worktree Naming Conventions

**Question:** What naming conventions and locations work best for manually-created worktrees?

**Areas to investigate:**
- Naming patterns: `feat-<name>` vs `<feature-name>` vs `<type>-<name>`
- Location: `.cursor/worktrees/` vs project-relative vs home directory
- Discoverability: How to list/document active worktrees
- Cursor integration: Does Cursor work well with manual worktrees?
- Directory-to-branch mapping: Should directory name mirror branch name (e.g., `feat-foo` ↔ `feat/foo`)?
- Window title implications: How does naming affect window identification?

**Priority:** 🔴 High  
**Expected outcome:** Naming convention and location standard

**Session Insight (2026-01-09):**
> `worktrees/` directory (project-relative) avoids Cursor confirmation prompts that `.cursor/worktrees/` triggers.
> Window titles become the primary identifier when using per-window focus - reinforces importance of meaningful names.

---

### Topic 2: Self-Contained Feature Branches

**Question:** What content should live on feature branches vs develop?

**Areas to investigate:**
- Full isolation: ALL docs (exploration, research, decisions, planning) on feature branch
- Partial isolation: Only exploration/research, planning on develop
- Shared docs: How to handle docs that span multiple features
- Global updates: How to handle updates to rules, templates, etc.

**Priority:** 🔴 High  
**Expected outcome:** Clear guidelines for what goes where

---

### Topic 3: Review Gate Pattern

**Question:** How should the review gate workflow function?

**Areas to investigate:**
- Minimum viable feature: What's required to merge?
- Abandoned features: Should "no action" explorations be merged for learning?
- Long-running features: How to handle develop drift
- PR structure: How to review code + docs together

**Priority:** 🟡 Medium  
**Expected outcome:** Review gate workflow definition

---

### Topic 4: sourcery.yml Configuration

**Question:** How should sourcery.yml be configured to support this workflow?

**Areas to investigate:**
- Ignore paths: `admin/**`, `docs/maintainers/**`, others?
- Code analysis impact: Does ignoring docs affect Sourcery's understanding?
- Template inclusion: Should this be in templates or dev-infra only?
- Existing configuration: Check if sourcery.yml already exists

**Priority:** 🟡 Medium  
**Expected outcome:** sourcery.yml configuration for doc-aware PRs

---

### Topic 5: Context Switching and Discovery

**Question:** How to efficiently switch between worktrees and discover what's active?

**Areas to investigate:**
- Listing worktrees: `git worktree list` + enhancements
- Cursor switching: Best way to switch between worktrees in IDE
- Status visibility: How to see what's being worked on across worktrees
- Potential `/worktree` command: Would a command help?
- **`cursor` CLI integration:** Auto-open or copy/paste command output

**Priority:** 🟢 Low → 🟡 Medium (elevated based on session insights)  
**Expected outcome:** Context switching workflow with `cursor` CLI integration

**Session Insight (2026-01-09):**
> Per-window focus is optimal for work. Window titles become primary identifiers.
> Commands could output `cursor /path/to/worktree` for easy opening.

---

### Topic 6: Phase-Based Review in Self-Contained Workflow

**Question:** How do we maintain early bug detection (via Sourcery reviews) in a self-contained feature branch workflow?

**Areas to investigate:**
- Phase-based PRs: Should we still create them? To what branch?
- Sourcery CLI: Can it be used locally for early feedback?
- Draft PRs: Do they provide a middle ground?
- Isolation vs feedback: How to balance these competing needs?
- Current workflow value: What do we lose without phase-based PRs?

**Priority:** 🔴 High  
**Expected outcome:** Review workflow that preserves early bug detection

**Session Insight (2026-01-09):**
> Gap identified: Current workflow uses Sourcery reviews at each phase (via transition-plan).
> Self-contained branches may lose this early feedback if we wait for final PR.

---

## 📊 Topic Summary

| # | Topic | Priority | Status |
|---|-------|----------|--------|
| 1 | Worktree Naming Conventions | 🔴 High | ✅ Complete |
| 2 | Self-Contained Feature Branches | 🔴 High | ✅ Complete |
| 3 | Review Gate Pattern | 🟡 Medium | ✅ Complete |
| 4 | sourcery.yml Configuration | 🟡 Medium | ✅ Complete |
| 5 | Context Switching and Discovery | 🟡 Medium | ✅ Complete |
| 6 | Phase-Based Review | 🔴 High | 🔴 Not Started |

---

## 🚀 Next Steps

When ready to research:
```
/research worktree-feature-workflow --from-explore worktree-feature-workflow
```

---

**Last Updated:** 2026-01-09 (Session 2)
