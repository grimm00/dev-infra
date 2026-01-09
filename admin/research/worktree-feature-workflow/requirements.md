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

### FR-5: Definition of Done Criteria

**Description:** Feature branches MUST have clear "Definition of Done" criteria before merging.

**For Features:**
- Complete implementation
- Tests pass (if applicable)
- Documentation updated
- Reviewed and approved

**For Explorations:**
- Decision reached (proceed, no-action, or abandon)
- Documentation complete
- Reviewed for value/accuracy

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-6: Merge "No-Action" Explorations

**Description:** Explorations that conclude with "no action" SHOULD be merged if they have learning value.

**Rationale:** Preserves learning and prevents repeated exploration of the same ideas.

**Distinction:**
- "No action" (deliberate decision) → Merge docs
- "Abandoned" (no decision) → Delete branch

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-7: Holistic PR Review

**Description:** PRs MUST be reviewed holistically - code and documentation together.

**Rationale:** 
- Reviewers need full context (the "why" and "how")
- Enables better review decisions
- Ensures atomic, complete changes

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

**Priority:** High

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

### NFR-3: Time-Boxed Features

**Description:** Feature branches SHOULD be time-boxed (target: less than 1 week).

**Rationale:** 
- Prevents develop drift issues
- Reduces merge conflicts
- Encourages small, focused features

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-4: Prompt Abandoned Branch Deletion

**Description:** Abandoned feature branches SHOULD be deleted promptly after the decision to abandon.

**Rationale:** Prevents clutter and signals clear intent.

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-5: Sourcery Ignore Process Docs

**Description:** sourcery.yml SHOULD ignore `admin/**` for cleaner code review.

**Rationale:** Focuses automated review on code, not process documentation.

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

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

### C-3: Long-Running Branches Require Merges

**Description:** Long-running feature branches (> 1 week) require periodic merges from develop.

**Impact:** Cannot rebase long-running branches; must use merge strategy.

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

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
