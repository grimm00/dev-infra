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

**Description:** Commands that create worktrees MUST output a `cursor <path>` command for easy opening.

**Example output:**
```
✅ Worktree created: feat-my-feature

To open in new Cursor window:
cursor worktrees/feat-my-feature
```

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md), [research-context-switching-and-discovery.md](research-context-switching-and-discovery.md)

**Priority:** High

**Status:** 🔴 Pending

**Note:** Consolidated from FR-4 and FR-18 (duplicate requirements)

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

### FR-8: Feature Exploration on Feature Branch

**Description:** Feature exploration documentation MUST be created on the feature branch, not develop.

**Location:** `admin/explorations/[feature]/`

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-9: Feature Research on Feature Branch

**Description:** Feature research documentation MUST be created on the feature branch, not develop.

**Location:** `admin/research/[feature]/`

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-10: Feature ADRs on Feature Branch

**Description:** Feature-specific Architecture Decision Records MUST be created on the feature branch.

**Location:** `admin/decisions/[feature]/`

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-11: Feature Planning on Feature Branch

**Description:** Feature planning documentation MUST be created on the feature branch.

**Location:** `admin/planning/features/[feature]/`

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-12: Global Docs on Develop

**Description:** Global documentation (rules, commands, templates, user docs) MUST remain on develop branch.

**Global docs include:**
- `.cursor/rules/` - AI rules
- `.cursor/commands/` - Workflow commands
- `templates/` - Project templates
- `docs/` - User documentation

**Rationale:** These affect all work and are not feature-specific.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-13: Cross-Feature Docs on Develop

**Description:** Documentation that spans multiple features MUST be on develop, not feature branches.

**Rationale:** Prevents coupling features through shared docs on feature branches.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

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

### FR-14: Create .sourcery.yaml

**Description:** `.sourcery.yaml` MUST be created in dev-infra root to configure Sourcery code review.

**Source:** [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-15: Sourcery Ignore admin/**

**Description:** `.sourcery.yaml` MUST ignore `admin/**` to prevent noise from process documentation.

**Configuration:**
```yaml
ignore:
  - admin/**
  - tmp/**
```

**Source:** [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-16: Include in Templates

**Description:** `.sourcery.yaml` MUST be included in both templates for consistent experience.

**Locations:**
- `templates/standard-project/.sourcery.yaml`
- `templates/learning-project/.sourcery.yaml`

**Source:** [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-17: Add to Template Sync Manifest

**Description:** `.sourcery.yaml` SHOULD be added to template sync manifest to keep templates in sync.

**Source:** [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-6: Feature Independence

**Description:** Features SHOULD be independent - no cross-branch documentation references.

**Rationale:** Prevents circular dependencies between feature branches.

**If docs are shared:** They belong on develop, not a feature branch.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-7: Atomic Feature Merges

**Description:** Feature merges SHOULD be atomic - all docs + code merge together in single PR.

**Rationale:** 
- Maintains traceability
- Complete feature history arrives together
- Reviewers see full context

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-19: Handoff Documents

**Description:** Handoff documents SHOULD be created in `tmp/handoff.md` for session continuity.

**Content:**
- Current focus/status
- Key files to reference
- Next actions
- Resume command

**Source:** [research-context-switching-and-discovery.md](research-context-switching-and-discovery.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-8: No Code Analysis Impact

**Description:** Sourcery ignore patterns SHOULD NOT affect code analysis quality.

**Verification:** Ignoring `.md` files and `admin/**` only affects doc review, not code refactoring/quality.

**Source:** [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-20: Open Draft PR After First Commit

**Description:** Features SHOULD open a draft PR after the first meaningful commit to enable continuous Sourcery feedback.

**Workflow:**
```
First commit → Push → Open Draft PR → Continuous feedback on each push
```

**Source:** [research-phase-based-review.md](research-phase-based-review.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-21: Draft PRs for Early Feedback

**Description:** Draft PRs SHOULD be used for early Sourcery feedback throughout feature development.

**Benefits:**
- Continuous feedback on every push
- No merge pressure until complete
- Single PR number for entire feature

**Source:** [research-phase-based-review.md](research-phase-based-review.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-22: /pr Command Draft Support

**Description:** The `/pr` command SHOULD support a `--draft` flag for creating initial draft PRs.

**Usage:**
```bash
/pr --draft --feature my-feature
```

**Source:** [research-phase-based-review.md](research-phase-based-review.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-9: Use Native Tools for Context Switching

**Description:** Context switching SHOULD use native tools (git, cursor CLI).

**Tools:**
- `git worktree list` for discovery
- `cursor <path>` for opening
- `cd <path>` for terminal navigation

**Rationale:** Don't over-engineer - native tools are sufficient.

**Source:** [research-context-switching-and-discovery.md](research-context-switching-and-discovery.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-10: Use Git Worktree List for Discovery

**Description:** Worktree discovery SHOULD use `git worktree list` (no custom tooling).

**Rationale:** Git provides comprehensive worktree information:
- Full path
- Commit hash
- Branch name
- Porcelain format for scripting

**Source:** [research-context-switching-and-discovery.md](research-context-switching-and-discovery.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-11: Push Frequently for Incremental Feedback

**Description:** Features SHOULD push frequently to get incremental Sourcery feedback throughout development.

**Rationale:** More frequent pushes = more feedback opportunities = earlier bug detection.

**Source:** [research-phase-based-review.md](research-phase-based-review.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-12: Single PR Per Feature

**Description:** Self-contained features SHOULD use a single PR (not per-phase PRs).

**Rationale:** Aligns with self-contained philosophy - all code + docs merge atomically.

**Source:** [research-phase-based-review.md](research-phase-based-review.md)

**Priority:** High

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

### C-4: Draft PR Requires GitHub (or Similar)

**Description:** Draft PR workflow requires a platform that supports draft pull requests.

**Supported platforms:**
- GitHub
- GitLab (merge request drafts)
- Bitbucket (draft pull requests)

**Impact:** Self-hosted Git servers without PR support cannot use this workflow.

**Source:** [research-phase-based-review.md](research-phase-based-review.md)

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
