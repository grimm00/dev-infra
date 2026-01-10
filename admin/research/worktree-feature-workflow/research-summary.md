# Research Summary - Worktree Feature Workflow

**Purpose:** Summary of all research findings for worktree feature workflow  
**Status:** ✅ Complete  
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

**Research Topics:** 6 topics  
**Research Documents:** 6 documents  
**Status:** ✅ Complete (6/6 complete)

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

### Finding 9: Sourcery Reviews Docs (Problem Confirmed)

Sourcery currently reviews documentation in PRs (confirmed in `admin/feedback/sourcery/pr58.md`).
This creates noise when docs are committed with code.

**Source:** [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md)

---

### Finding 10: .sourcery.yaml Solution

Create `.sourcery.yaml` with ignore patterns:
```yaml
ignore:
  - admin/**
  - tmp/**
```

Ignoring docs does NOT affect code analysis quality.

**Source:** [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md)

---

### Finding 11: Native Tools Suffice for Context Switching

No custom tooling needed:
- `git worktree list` for discovery
- `cursor <path>` for opening
- Window titles for identification
- Handoff docs for session continuity

**Source:** [research-context-switching-and-discovery.md](research-context-switching-and-discovery.md)

---

### Finding 12: /worktree Command Only Valuable for Scaffolding

A `/worktree` command is only worthwhile if it:
1. Creates worktree
2. Creates branch
3. Scaffolds exploration docs
4. Outputs cursor command

Otherwise, native git + cursor suffice.

**Source:** [research-context-switching-and-discovery.md](research-context-switching-and-discovery.md)

---

### Finding 13: Draft PRs Preserve Early Feedback Without Merging

Draft PRs enable:
- Continuous Sourcery feedback on every push
- No merge pressure until feature is complete
- Single PR number for entire feature
- Atomic merge of all code + docs together

**Source:** [research-phase-based-review.md](research-phase-based-review.md)

---

### Finding 14: The Real Value is Per-Push Feedback

The current workflow's value isn't the merge itself, but getting feedback before code solidifies. Draft PRs achieve the same:
- Push to feature branch → Sourcery reviews
- Fix issues → Push again → New review
- Iterate until quality is good

**Source:** [research-phase-based-review.md](research-phase-based-review.md)

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

**From Topic 4 (sourcery.yml):**
- [x] Insight 16: No `.sourcery.yaml` exists yet
- [x] Insight 17: Sourcery currently reviews docs (problem confirmed)
- [x] Insight 18: Ignoring docs has no impact on code analysis
- [x] Insight 19: `admin/**` is the key pattern for self-contained workflow
- [x] Insight 20: Should include in templates for consistency

**From Topic 5 (Context Switching):**
- [x] Insight 21: `git worktree list` provides complete discovery
- [x] Insight 22: `cursor` CLI enables easy opening
- [x] Insight 23: Context switching is just directory navigation
- [x] Insight 24: Handoff documents solve session continuity
- [x] Insight 25: Don't over-engineer - native tools are sufficient

**From Topic 6 (Phase-Based Review):**
- [x] Insight 26: Draft PRs preserve feedback without requiring phase merges
- [x] Insight 27: Value is per-push feedback, not per-merge
- [x] Insight 28: Single draft PR aligns with self-contained philosophy
- [x] Insight 29: Minimal changes needed to existing commands
- [x] Insight 30: Sourcery CLI not needed - draft PR approach is superior

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

**From Topic 4 (sourcery.yml):**
- FR-14: `.sourcery.yaml` MUST be created in dev-infra root
- FR-15: `.sourcery.yaml` MUST ignore `admin/**`
- FR-16: `.sourcery.yaml` MUST be included in both templates
- FR-17: `.sourcery.yaml` SHOULD be added to template sync manifest
- NFR-8: Ignore patterns SHOULD not affect code analysis quality

**From Topic 5 (Context Switching):**
- FR-18: Commands creating worktrees MUST output `cursor <path>`
- FR-19: Handoff documents SHOULD be in `tmp/handoff.md`
- NFR-9: Context switching SHOULD use native tools
- NFR-10: Discovery SHOULD use `git worktree list`

**From Topic 6 (Phase-Based Review):**
- FR-20: Features SHOULD open draft PR after first commit
- FR-21: Draft PRs SHOULD be used for early Sourcery feedback
- FR-22: `/pr` command SHOULD support `--draft` flag
- NFR-11: Features SHOULD push frequently for incremental feedback
- NFR-12: Single PR per feature (not per phase)
- C-4: Requires GitHub (or similar with draft PR support)

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

**From Topic 4 (sourcery.yml):**
- [x] Recommendation 20: Create `.sourcery.yaml` in dev-infra root
- [x] Recommendation 21: Ignore `admin/**` and `tmp/**`
- [x] Recommendation 22: Include `.sourcery.yaml` in both templates
- [x] Recommendation 23: Add to template sync manifest
- [x] Recommendation 24: Keep user docs reviewed (unless too noisy)

**From Topic 5 (Context Switching):**
- [x] Recommendation 25: Use `git worktree list` for discovery
- [x] Recommendation 26: Use `cursor <path>` for opening worktrees
- [x] Recommendation 27: Commands should output `cursor` command
- [x] Recommendation 28: Use `tmp/handoff.md` for session continuity
- [x] Recommendation 29: Only build `/worktree` command if it scaffolds docs
- [x] Recommendation 30: Don't over-engineer - native tools suffice

**From Topic 6 (Phase-Based Review):**
- [x] Recommendation 31: Use draft PR workflow for self-contained features
- [x] Recommendation 32: Open draft PR after first meaningful commit
- [x] Recommendation 33: Push frequently for incremental Sourcery feedback
- [x] Recommendation 34: Mark ready for review only when feature complete
- [x] Recommendation 35: Keep single PR per feature (not per phase)
- [x] Recommendation 36: Update `/pr` command to support `--draft` flag

---

## 📊 Research Status

| # | Research Topic | Priority | Status |
|---|----------------|----------|--------|
| 1 | Worktree Naming Conventions | 🔴 High | ✅ Complete |
| 2 | Self-Contained Feature Branches | 🔴 High | ✅ Complete |
| 3 | Review Gate Pattern | 🟡 Medium | ✅ Complete |
| 4 | sourcery.yml Configuration | 🟡 Medium | ✅ Complete |
| 5 | Context Switching and Discovery | 🟡 Medium | ✅ Complete |
| 6 | Phase-Based Review | 🔴 High | ✅ Complete |

---

## 🚀 Next Steps

1. ✅ ~~Topic 1: Worktree Naming Conventions~~ (Complete)
2. ✅ ~~Topic 2: Self-Contained Feature Branches~~ (Complete)
3. ✅ ~~Topic 3: Review Gate Pattern~~ (Complete)
4. ✅ ~~Topic 4: sourcery.yml Configuration~~ (Complete)
5. ✅ ~~Topic 5: Context Switching and Discovery~~ (Complete)
6. ✅ ~~Topic 6: Phase-Based Review~~ (Complete)
7. **All research complete!**
8. Review requirements in `requirements.md`
9. Use `/decision worktree-feature-workflow --from-research` to make decisions

---

**Last Updated:** 2026-01-09
