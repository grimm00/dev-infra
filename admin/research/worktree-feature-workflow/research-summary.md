# Research Summary - Worktree Feature Workflow

**Purpose:** Summary of all research findings for worktree feature workflow  
**Status:** 🟠 In Progress  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 📋 Research Overview

This research investigates a refined git worktree workflow for feature development:

1. Manual worktree creation with meaningful names
2. Self-contained feature branches (all docs on feature branch)
3. Review gate pattern
4. sourcery.yml integration
5. Context switching with `cursor` CLI

**Research Topics:** 5 topics  
**Research Documents:** 5 documents  
**Status:** 🟠 In Progress (2/5 complete)

---

## 🔍 Key Findings

### Finding 1: Directory Names Should Mirror Branch Names

The optimal naming pattern is to mirror branch names with slashes replaced by hyphens:
- Branch: `feat/worktree-feature-workflow`
- Directory: `feat-worktree-feature-workflow`

This creates a predictable 1:1 mapping that works well with window titles.

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

---

### Finding 2: Use Project-Relative `worktrees/` Directory

Best practice is to use a dedicated `worktrees/` directory (project-relative) that is:
- Added to `.gitignore`
- Avoids Cursor confirmation prompts (unlike `.cursor/worktrees/`)
- Keeps the repository clean

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

---

### Finding 3: Git Worktree List Provides Discoverability

Built-in `git worktree list` command provides all needed discoverability:
- Shows full paths to all worktrees
- Shows current commit and branch
- Machine-parseable for scripting

No manual documentation of active worktrees needed.

**Source:** [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)

---

### Finding 4: Full Isolation is Preferred

Self-contained feature branches should include ALL feature-specific documentation:
- Exploration docs
- Research docs
- ADRs
- Planning docs

Benefits: Abandoned features leave no trace, reviewers see full context, atomic changes.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

---

### Finding 5: Document Category Separation

Not all docs belong on feature branches:

| Feature branch | Develop |
|----------------|---------|
| Feature exploration | Global rules |
| Feature research | Templates |
| Feature ADRs | Cursor commands |
| Feature planning | Project-wide docs |

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

---

## 💡 Key Insights

**From Topic 1 (Naming):**
- [x] Insight 1: Directory names should mirror branch names for predictability
- [x] Insight 2: Type prefixes (`feat-`, `fix-`, etc.) provide immediate context
- [x] Insight 3: `worktrees/` location avoids Cursor prompts and keeps repo clean
- [x] Insight 4: `git worktree list` provides built-in discoverability
- [x] Insight 5: Window titles display directory name, reinforcing meaningful naming

**From Topic 2 (Self-Contained):**
- [x] Insight 6: Full isolation is preferred over partial isolation
- [x] Insight 7: Feature docs travel WITH the feature (exploration, research, ADRs, planning)
- [x] Insight 8: Global docs (rules, templates, commands) stay on develop
- [x] Insight 9: Short-lived feature branches minimize drift issues
- [x] Insight 10: This pattern aligns with atomic commit principles

---

## 📋 Requirements Summary

**From Topic 1 (Naming Conventions):**
- FR-1: Directory names MUST mirror branch names (slash → hyphen)
- FR-2: Worktrees MUST be in `worktrees/` directory (project-relative)
- FR-3: `worktrees/` MUST be in `.gitignore`
- FR-4: Commands SHOULD output `cursor <path>` for easy opening
- NFR-1: No generic names (`temp`, `wip`)
- NFR-2: Use type prefixes matching branch type

**From Topic 2 (Self-Contained):**
- FR-5 to FR-8: Feature docs (exploration, research, ADRs, planning) MUST be on feature branch
- FR-9: Global docs (rules, templates, commands) MUST remain on develop
- FR-10: Cross-feature docs MUST be on develop
- NFR-3: Feature branches SHOULD be short-lived (days, not weeks)
- NFR-4: Abandoned branches SHOULD be deleted promptly
- NFR-5: PRs SHOULD be reviewed holistically (code + docs)

**See:** [requirements.md](requirements.md) for complete requirements document

---

## 🎯 Recommendations

**From Topic 1 (Naming):**
- [x] Recommendation 1: Use `worktrees/` directory for all worktrees
- [x] Recommendation 2: Name directories to mirror branch names
- [x] Recommendation 3: Use type prefixes for categorization
- [x] Recommendation 4: Add `worktrees/` to `.gitignore`
- [x] Recommendation 5: Use `git worktree list` for discoverability
- [x] Recommendation 6: Commands should output `cursor <path>` for opening

**From Topic 2 (Self-Contained):**
- [x] Recommendation 7: Use full isolation - ALL feature docs on feature branch
- [x] Recommendation 8: Keep feature branches short-lived (days, not weeks)
- [x] Recommendation 9: Global docs (rules, templates, commands) stay on develop
- [x] Recommendation 10: Review PRs holistically (code + docs together)
- [x] Recommendation 11: Delete abandoned branches promptly (no trace)

---

## 📊 Research Status

| # | Research Topic | Priority | Status |
|---|----------------|----------|--------|
| 1 | Worktree Naming Conventions | 🔴 High | ✅ Complete |
| 2 | Self-Contained Feature Branches | 🔴 High | ✅ Complete |
| 3 | Review Gate Pattern | 🟡 Medium | 🔴 Not Started |
| 4 | sourcery.yml Configuration | 🟡 Medium | 🔴 Not Started |
| 5 | Context Switching and Discovery | 🟡 Medium | 🔴 Not Started |

---

## 🚀 Next Steps

1. ✅ ~~Topic 1: Worktree Naming Conventions~~ (Complete)
2. ✅ ~~Topic 2: Self-Contained Feature Branches~~ (Complete)
3. Continue with remaining topics (Topics 3-5)
4. Review requirements in `requirements.md`
5. Use `/decision worktree-feature-workflow --from-research` to make decisions

---

**Last Updated:** 2026-01-09
