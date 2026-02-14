# Topic 1: Feature Plan Structure Usage - Research Document

**Purpose:** Determine if the `feature-plan.md` + `phase-N.md` structure is actually used or just ceremony  
**Status:** ✅ Complete  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-13

---

## 📋 Quick Links

- **[Workflow Simplification Research Hub](README.md)** - Parent research hub
- **[Research Topics](../../explorations/workflow-simplification/research-topics.md)** - All 5 topics
- **[Topic 5: Command Dependency Analysis](topic-5-command-dependency-analysis.md)** - Phase concept embedding

---

## 🎯 Research Goal

**Key Question:** Were phase documents updated *during* implementation (e.g. checking off tasks, adding notes)? Or were they created once and never touched?

**Context:** With the new 1-PR-per-feature (draft PR) workflow, phase documents are no longer PR boundaries. We want to verify whether they remain useful or have become ceremony.

---

## 🔍 Methodology

1. **Identified completed features** in `admin/planning/features/`
2. **Analyzed git history** for `phase-N.md` and `status-and-next-steps.md` files
3. **Examined content** for valuable notes added during work vs. initial task lists
4. **Compared workflows:** PR-per-phase (release-readiness) vs. 1-PR-per-feature (worktree, command-simplification)

---

## 📊 Findings by Feature

### 1. Release Readiness (PR-per-phase workflow)

**Workflow:** 5 separate PRs (#32, #35, #41, #42) — one PR per phase  
**Location:** `admin/planning/features/release-readiness/`

| File | Commit Count | Update Pattern |
|------|--------------|----------------|
| phase-1.md | 7 | Initial + task checkoffs + post-merge |
| phase-2.md | **12** | Many task-by-task commits: "mark task 1 complete", "mark task 2 complete", etc. |
| phase-3.md | 10 | Task checkoffs during implementation |
| phase-4.md | 4 | Status updates, post-merge |
| phase-5.md | 6 | Status updates, post-merge |
| status-and-next-steps.md | **14** | Updated during each phase, contains fix tracking, PR references |

**Content Analysis:** Phase files contain checked-off task lists, completion dates, PR merge references. `status-and-next-steps.md` has rich content: fix batches, deferred tasks, milestone summaries.

**Verdict:** **Active Usage** — Phase documents were integral to the PR-per-phase workflow. Task checkoffs were committed as work progressed.

---

### 2. Worktree Feature Workflow (1-PR-per-feature, draft PR)

**Workflow:** 1 draft PR for entire feature  
**Location:** `admin/planning/features/worktree-feature-workflow/`

| File | Commit Count | Update Pattern |
|------|--------------|----------------|
| phase-1.md | 5 | Create → expand scaffolding → feat(phase-1) implementation |
| phase-2.md | 4 | Create → expand → feat (implementation in same commit as template changes) |
| phase-3.md | 5 | Expand → feat → "mark changes committed complete" |
| phase-4.md | 7 | Expand → "mark Phase 4 and feature complete" |
| status-and-next-steps.md | **9** | More updates than individual phase files |

**Content Analysis:** Phase files were expanded with detailed tasks *before* implementation. Few granular task-checkoff commits. Phase completion was marked in batch ("mark Phase 4 and feature complete") rather than task-by-task.

**Verdict:** **Mixed Usage** — Phase files used for planning (scaffolding expansion) and high-level completion tracking. Less granular than release-readiness. Status file updated more frequently.

---

### 3. Command Simplification (No phase files)

**Workflow:** 1 PR (#54), completed successfully  
**Location:** `admin/planning/features/command-simplification/`

**Structure:** 
- `feature-plan.md` — Phases described **inline** (Phase 1: ADR, Phase 2: Template Updates, etc.)
- `status-and-next-steps.md` — Single progress tracking file
- **No `phase-N.md` files**

| File | Commit Count | Update Pattern |
|------|--------------|----------------|
| feature-plan.md | 3 | Create → version migration → release |
| status-and-next-steps.md | (part of feature dir) | Task checklist, implementation summary |

**Content Analysis:** `feature-plan.md` contains phases as sections, not separate files. `status-and-next-steps.md` has completed task checklist, files changed summary, next steps. Feature completed successfully without phase documents.

**Verdict:** **Simplified Structure Worked** — No phase files. Phases inline in feature-plan. Status file sufficient for tracking.

---

### 4. Transition-Plan Two-Mode (1-PR-per-feature, 2 PRs)

**Workflow:** 2 PRs (#55, #56) for Phases 1-2 and Phases 3-4  
**Location:** `admin/planning/features/transition-plan-two-mode/`

| File | Commit Count | Update Pattern |
|------|--------------|----------------|
| phase-1.md | ~4 | Create → expand → post-merge docs |
| phase-2.md | ~4 | Same pattern |
| phase-3.md | ~4 | Same pattern |

**Content Analysis:** Phase-1.md **still has unchecked task boxes** (`- [ ]`) despite PR #55 and #56 being merged. Implementation was completed but phase documents were **never updated** with task checkoffs during work.

**Verdict:** **Write-Once** — Phase files created and expanded, but not maintained during implementation. Work completed; phase docs left stale.

---

### 5. Templates Enhancement

**Workflow:** Part of release #43  
**Location:** `admin/planning/features/templates-enhancement/`

| File | Commit Count | Update Pattern |
|------|--------------|----------------|
| phase-1.md through phase-5.md | 3-5 each | Single commit: `chore: Release v1.4.0 (#43)` — phase files **created with all checkboxes already complete** |

**Verdict:** **Write-Once (Retroactive)** — Phase files created *after* work was done, as documentation of completed work. Never used during implementation.

---

## 📈 Summary: Active Usage vs. Write-Once

| Feature | Workflow | Phase Doc Usage | status-and-next-steps |
|---------|----------|-----------------|------------------------|
| Release Readiness | PR-per-phase (5 PRs) | **Active** — task checkoffs | **Active** — 14 commits |
| Worktree Feature Workflow | 1-PR draft | **Mixed** — expansion + completion marks | **Active** — 9 commits |
| Command Simplification | 1-PR | **N/A** — no phase files | Used (inline in feature-plan) |
| Transition-Plan Two-Mode | 2 PRs | **Write-Once** — unchecked boxes remain | — |
| Templates Enhancement | Release batch | **Write-Once (retroactive)** | — |

---

## 🔑 Key Insights

1. **PR-per-phase drove active usage:** Release-readiness had many phase doc commits because each phase had its own PR. Phase doc updates were part of the PR workflow.

2. **1-PR-per-feature reduces phase doc updates:** Worktree and transition-plan-two-mode show fewer or no task checkoffs. When all work lands in one (or two) PRs, phase doc maintenance is deprioritized.

3. **Command-simplification succeeded without phase files:** Phases inline in feature-plan + status-and-next-steps was sufficient. No loss of capability.

4. **status-and-next-steps.md is consistently valuable:** Updated more than phase files in active features. Contains fix tracking, PR references, milestone summaries. Higher signal-to-ceremony ratio.

5. **Phase files can become stale:** Transition-plan-two-mode phase-1 has unchecked boxes despite completed work. Templates-enhancement phase files were created retroactively.

---

## 📋 Content Value Assessment

**Phase documents contain:**
- Initial task lists (from transition-plan expansion)
- Checkboxes (when maintained)
- Completion dates, PR references (when updated)
- Implementation notes (worktree phase-1 has "Implementation Notes" section — valuable)

**When phase docs are write-once:** They duplicate the initial plan. No runtime value added. Status-and-next-steps or commit history provides completion evidence.

**When phase docs are active:** They provide task-level progress visibility. Useful for `/task-phase` command, PR validation, handoff context.

---

## 🎯 Recommendation

**Based on evidence: Simplify**

| Option | Rationale |
|--------|-----------|
| **Keep** | Not recommended — 1-PR workflow has reduced phase doc maintenance; command-simplification proved simpler structure works |
| **Simplify** | **Recommended** — Consolidate to `feature-plan.md` (phases inline or flat task list) + `status-and-next-steps.md`. Preserve status file; phase files are optional. |
| **Remove** | Viable — command-simplification had no phase files. Requires `/task-phase` and related commands to support flat structure (see Topic 2, Topic 5). |

**Suggested direction:**
1. **Flatten to single planning document** — `feature-plan.md` or `implementation-plan.md` with ordered task list (from Topic 3 research)
2. **Keep status-and-next-steps.md** — Consistently valuable across all features
3. **Make phase-N.md optional** — Transition-plan could produce flat output; phase structure for complex features only
4. **Update commands** — `/task-phase` → `/task` with flat task reference (Topic 2)

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] **FR-1: Single planning document per feature.** The planning structure should consolidate `feature-plan.md` + `phase-N.md` into a single document with an ordered task list. Evidence: command-simplification succeeded with phases inline; phase files are write-once under 1-PR workflow.
- [x] **FR-2: Preserve status tracking file.** `status-and-next-steps.md` is consistently the most-updated file across all features (14 commits in release-readiness, 9 in worktree). Must be retained or its role absorbed.
- [x] **FR-3: Optional phase grouping.** Complex features (release-readiness: 5 phases, 5 PRs) benefited from phase structure. The simplified model must support optional grouping (sections/headings) without requiring separate files.
- [x] **FR-4: Task list must be machine-parseable.** `/task` command needs to read task items from the planning document. Checkboxes (`- [ ]` / `- [x]`) are the proven format for progress tracking.

### Non-Functional Requirements

- [x] **NFR-1: Scale from simple to complex.** Must work for both small features (3-5 tasks, command-simplification) and large features (15+ tasks across 5 phases, release-readiness).
- [x] **NFR-2: Lower barrier to entry.** Fewer files = less boilerplate for generated projects. Templates should be simpler after this change.

### Constraints

- [x] **C-1: 9 commands have hard phase dependencies.** (From Topic 5) Any structural change must account for `/task-phase`, `/transition-plan`, `/pre-phase-review`, `/address-review`, `/pr`, `/post-pr`, `/pr-validation`, `/status`, `/task-improvement`.
- [x] **C-2: Existing projects need migration path.** Breaking change must include migration guidance or backward compatibility.

### Assumptions

- [x] **A-1: 1-PR-per-feature is the standard workflow.** Draft PR workflow (v0.8.0) is the default going forward; PR-per-phase is deprecated.
- [x] **A-2: status-and-next-steps.md pattern is proven.** Consistently valuable; should be preserved in some form.

---

## 🔗 Related

- **[Topic 2: Task Command Interface Design](topic-2-task-command-interface-design.md)** — How would `/task` work with flat structure?
- **[Topic 3: Transition Plan Output Format](topic-3-transition-plan-output-format.md)** — Flat work breakdown format
- **[Topic 5: Command Dependency Analysis](topic-5-command-dependency-analysis.md)** — Commands that depend on phase structure

---

**Last Updated:** 2026-02-14  
**Status:** ✅ Complete  
**Next:** Topic 2 (Task Command Interface Design) or Topic 3 (Transition Plan Output Format)
