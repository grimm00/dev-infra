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

### FR-5: Feature Exploration on Feature Branch

**Description:** Feature exploration documentation MUST be created on the feature branch, not develop.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-6: Feature Research on Feature Branch

**Description:** Feature research documentation MUST be created on the feature branch, not develop.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-7: Feature ADRs on Feature Branch

**Description:** Feature-specific Architecture Decision Records MUST be created on the feature branch.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-8: Feature Planning on Feature Branch

**Description:** Feature planning documentation MUST be created on the feature branch.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-9: Global Docs on Develop

**Description:** Global documentation (rules, templates, commands) MUST remain on develop branch.

**Rationale:** These affect all work and are not feature-specific.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-10: Cross-Feature Docs on Develop

**Description:** Documentation that spans multiple features MUST be on develop, not feature branches.

**Rationale:** Prevents coupling features through shared docs on feature branches.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

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

### NFR-3: Short-Lived Feature Branches

**Description:** Feature branches SHOULD be short-lived (days, not weeks) to minimize develop drift.

**Rationale:** Long-running branches accumulate drift and merge conflicts.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-4: Prompt Abandoned Branch Deletion

**Description:** Abandoned feature branches SHOULD be deleted promptly after the decision to abandon.

**Rationale:** Prevents clutter and signals clear intent.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-5: Holistic PR Review

**Description:** Pull requests SHOULD be reviewed holistically (code + docs together).

**Rationale:** Reviewers need full context to make informed decisions.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

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

### C-3: Feature Branch Coupling

**Description:** Feature branches should not depend on documentation in other feature branches.

**Impact:** Cross-feature docs must be on develop; features wait for dependencies to merge.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

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

### A-3: Features are Small and Focused

**Description:** Feature branches represent small, focused units of work (days, not weeks).

**Impact:** Self-contained branches work best when features are small.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

---

### A-4: Clean Git History is Valuable

**Description:** Having only successful features in develop's git history is valuable.

**Impact:** Justifies the full isolation approach (abandoned features leave no trace).

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

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
