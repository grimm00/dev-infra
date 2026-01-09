# Requirements - Worktree Feature Workflow

**Source:** Research on worktree feature workflow  
**Status:** Draft  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 📋 Overview

This document captures requirements discovered during research on the worktree feature workflow.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Directory-Branch Name Mirroring

**Description:** Worktree directory names MUST mirror their associated branch names with slashes replaced by hyphens.

**Example:**
- Branch: `feat/worktree-feature-workflow`
- Directory: `worktrees/feat-worktree-feature-workflow`

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Project-Relative Location

**Description:** Worktrees MUST be created in a `worktrees/` directory that is project-relative (not in `.cursor/` or home directory).

**Rationale:** 
- Avoids Cursor confirmation prompts
- Keeps worktrees associated with project
- Enables `git worktree list` from any worktree

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-3: Gitignore Configuration

**Description:** The `worktrees/` directory MUST be added to `.gitignore` to prevent tracking.

**Implementation:**
```gitignore
# Git worktrees
worktrees/
```

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-4: Command Output for Easy Opening

**Description:** Commands that create worktrees SHOULD output a `cursor <path>` command for easy opening.

**Example output:**
```
✅ Worktree created: feat-my-feature

To open in new Cursor window:
cursor worktrees/feat-my-feature
```

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Meaningful Names Required

**Description:** Worktree directory names MUST be meaningful and descriptive. Generic names like `temp`, `test`, or `wip` are NOT allowed.

**Rationale:** Window titles display directory name; meaningful names provide context.

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-2: Type Prefix Convention

**Description:** Directory names SHOULD use type prefixes that match the branch type for categorization.

**Standard prefixes:**
- `feat-*` - new features
- `fix-*` - bug fixes
- `hotfix-*` - urgent production fixes
- `docs-*` - documentation
- `chore-*` - maintenance

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: No Slashes in Directory Names

**Description:** Directory names cannot contain slashes (file system limitation).

**Impact:** Branch names with slashes must be converted (e.g., `feat/foo` → `feat-foo`).

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

---

### C-2: Cursor Confirmation Prompts

**Description:** Directories under `.cursor/` trigger confirmation prompts in Cursor.

**Impact:** Must use `worktrees/` (not `.cursor/worktrees/`) to avoid prompts.

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md) (exploration insight)

---

## 💭 Assumptions

### A-1: Per-Window Focus Workflow

**Description:** Users will open each worktree in its own Cursor window for focused work.

**Impact:** Window titles become primary identifiers; naming is critical.

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

---

### A-2: Git Worktree List Suffices for Discovery

**Description:** `git worktree list` provides sufficient discoverability without additional documentation.

**Impact:** No need to manually document active worktrees.

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Exploration](../../explorations/worktree-feature-workflow/exploration.md)

---

## 🚀 Next Steps

1. Continue research for remaining topics
2. Extract additional requirements
3. Categorize and prioritize requirements
4. Use `/decision worktree-feature-workflow --from-research` to make decisions

---

**Last Updated:** 2026-01-09
