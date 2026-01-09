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
**Status:** 🟠 In Progress (3/5 complete)

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

### Finding 4: Review Gate - Definition of Done

Feature branches need clear "Definition of Done" criteria:
- **Features:** Complete implementation + tests + docs + review
- **Explorations:** Decision reached + docs complete + review

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

---

### Finding 5: "No Action" ≠ "Abandoned"

**Key distinction:**
- **"No Action"** = Deliberate decision after research → Merge docs for learning value
- **"Abandoned"** = Ran out of time/priority changed → Delete branch (no value)

Preserving "no action" decisions prevents repeated exploration of the same ideas.

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

---

### Finding 6: Holistic PR Review

Review code + docs together for:
- Full context (the "why" and "how")
- Atomic changes (feature complete in one merge)
- Better decisions (context enables better feedback)

**Source:** [research-review-gate-pattern.md](research-review-gate-pattern.md)

---

### Finding 7: Full Isolation for Feature Docs

Self-contained feature branches should include ALL feature-specific docs:
- Exploration, research, ADRs, planning
- All merge together atomically

Abandoned features leave no trace in develop.

**Source:** [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md)

---

### Finding 8: Clear Category Separation

| Category | Location |
|----------|----------|
| Feature-specific (exploration, research, ADRs, planning) | Feature branch |
| Global (rules, commands, templates, user docs) | Develop |
| Cross-feature (shared concepts) | Develop |

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
- [x] Insight 6: Full isolation is preferred - all feature docs on feature branch
- [x] Insight 7: Clear category separation (feature-specific vs global)
- [x] Insight 8: Features should be independent - shared docs go on develop
- [x] Insight 9: Single atomic merge maintains traceability
- [x] Insight 10: This pattern is validated by this very exploration

**From Topic 3 (Review Gate):**
- [x] Insight 11: "No action" ≠ "abandoned" - deliberate decisions have learning value
- [x] Insight 12: Time-boxing features (days, not weeks) prevents most drift issues
- [x] Insight 13: Different branch types need different review focus
- [x] Insight 14: Holistic review is the core benefit of self-contained branches
- [x] Insight 15: Clear decision tree prevents branch accumulation

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
- FR-8 to FR-11: Feature docs (exploration, research, ADRs, planning) MUST be on feature branch
- FR-12: Global docs (rules, commands, templates) MUST remain on develop
- FR-13: Cross-feature docs MUST be on develop
- NFR-6: Features SHOULD be independent (no cross-branch doc references)
- NFR-7: Feature merges SHOULD be atomic (all docs + code together)

**From Topic 3 (Review Gate):**
- FR-5: Feature branches MUST have clear "Definition of Done" criteria
- FR-6: "No-action" explorations SHOULD be merged for learning value
- FR-7: PRs MUST be reviewed holistically (code + docs together)
- NFR-3: Features SHOULD be time-boxed (target: < 1 week)
- NFR-4: Abandoned branches SHOULD be deleted promptly
- NFR-5: sourcery.yml SHOULD ignore `admin/**` for cleaner review
- C-3: Long-running branches (> 1 week) require periodic develop merges

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
- [x] Recommendation 8: Feature-specific = exploration, research, ADRs, planning
- [x] Recommendation 9: Global = rules, commands, templates, user docs
- [x] Recommendation 10: Merge atomically (all docs with code in single PR)
- [x] Recommendation 11: Avoid cross-feature doc references
- [x] Recommendation 12: If docs are shared, they belong on develop

**From Topic 3 (Review Gate):**
- [x] Recommendation 13: Define clear "Definition of Done" for features and explorations
- [x] Recommendation 14: Merge "no-action" exploration docs for learning value
- [x] Recommendation 15: Time-box explorations (max 1 week) to prevent drift
- [x] Recommendation 16: Use rebase for short branches, merge for long branches
- [x] Recommendation 17: Review holistically (code + docs together)
- [x] Recommendation 18: Configure Sourcery to ignore process docs (`admin/**`)
- [x] Recommendation 19: Delete abandoned branches promptly

---

## 📊 Research Status

| # | Research Topic | Priority | Status |
|---|----------------|----------|--------|
| 1 | Worktree Naming Conventions | 🔴 High | ✅ Complete |
| 2 | Self-Contained Feature Branches | 🔴 High | ✅ Complete |
| 3 | Review Gate Pattern | 🟡 Medium | ✅ Complete |
| 4 | sourcery.yml Configuration | 🟡 Medium | 🔴 Not Started |
| 5 | Context Switching and Discovery | 🟡 Medium | 🔴 Not Started |

---

## 🚀 Next Steps

1. ✅ ~~Topic 1: Worktree Naming Conventions~~ (Complete)
2. ✅ ~~Topic 2: Self-Contained Feature Branches~~ (Complete)
3. ✅ ~~Topic 3: Review Gate Pattern~~ (Complete)
4. Continue with Topics 4-5
5. Review requirements in `requirements.md`
6. Use `/decision worktree-feature-workflow --from-research` to make decisions

---

**Last Updated:** 2026-01-09
