# Requirements - Workflow Simplification

**Source:** Research on workflow simplification (feature/phase/task hierarchy)  
**Status:** Draft  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-14

---

## 📋 Overview

This document captures requirements discovered during research on workflow simplification. Requirements are extracted as each research topic is conducted.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Single Planning Document Per Feature

**Description:** The planning structure should consolidate `feature-plan.md` + `phase-N.md` into a single document with an ordered task list. Evidence: command-simplification succeeded with phases inline; phase files are write-once under 1-PR workflow.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Preserve Status Tracking

**Description:** `status-and-next-steps.md` is consistently the most-updated file across all features (14 commits in release-readiness, 9 in worktree). Must be retained or its role absorbed into the single planning document.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-3: Optional Phase Grouping

**Description:** Complex features (release-readiness: 5 phases, 5 PRs) benefited from phase structure. The simplified model must support optional grouping (sections/headings within the single document) without requiring separate files.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-4: Machine-Parseable Task List

**Description:** `/task` command needs to read task items from the planning document. Checkboxes (`- [ ]` / `- [x]`) are the proven format for progress tracking. The document structure must be parseable by automation.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-5: Alternative Task Source Required

**Description:** If `phase-N.md` is removed, an alternative artifact must provide the ordered task list that `/task` reads from. The transition plan (single document) is the leading candidate.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-6: 9 Commands Need Refactoring

**Description:** `/task-phase`, `/task-improvement`, `/transition-plan`, `/pre-phase-review`, `/address-review`, `/pr`, `/post-pr`, `/pr-validation`, `/status` all have hard dependencies on `phase-N.md` and must be updated to work with the new structure.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-7: 2-3 Commands Need Renaming

**Description:** `/task-phase` -> `/task` (or similar), `/pre-phase-review` -> `/plan-review` (or similar). `/address-review` may also need renaming depending on final naming.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-8: Template Sync Manifest Must Be Updated

**Description:** `template-sync-manifest.txt` lists `task-phase.md` and `pre-phase-review.md` as sync files. Renaming these commands requires updating the manifest and both template copies.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-9: Doc-Gen Templates Must Be Updated

**Description:** `planning.yaml`, `phase.md.tmpl`, `feature-plan.md.tmpl`, `status-and-next-steps.md.tmpl` encode phase structure and must be replaced or updated to produce the new single-document format.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-10: Hybrid Task Selection Interface

**Description:** `/task` must support three modes: `next` (sequential -- finds first unchecked task), `N` (explicit numbered -- implements specific task), and bare `/task` (status/list -- shows task progress). All modes read from the same flat planning document.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-11: Flat Planning Document as Task Source

**Description:** `/task` reads tasks from a single planning document using checkbox parsing (`- [ ]` / `- [x]`). Optional group headings (`###`) provide human context but are not required by the command. No `phase-N.md` dependency.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-12: Deprecation Stub for `/task-phase`

**Description:** Create `task-phase.md` as a stub pointing users to `/task`. Content: "This command has been renamed to `/task`. Use `/task N` instead of `/task-phase N M`." Remove stub in next major version.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-13: Simplified Branch Naming

**Description:** Branch names should be `feat/[feature]-[desc]` (no phase number). With 1-PR-per-feature, the branch is the feature branch, not a phase branch.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-14: Simplified Commit Scope

**Description:** Commit messages should use feature/component scope (`feat(auth): ...`) not phase scope (`feat(phase-3): ...`). Task context comes from the planning document, not the commit scope.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### FR-15: Single Implementation Plan Document Format

**Description:** `/transition-plan` must produce a single `implementation-plan.md` file with Format B structure: metadata header, overview, grouped checkbox task list (`- [ ] Task N: Description`), definition of done, and notes section. Replaces current `feature-plan.md` + `transition-plan.md` + `phase-N.md` file set.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-16: Global Continuous Task Numbering

**Description:** Tasks are numbered sequentially across the entire document (Task 1 through Task N), not restarted per group heading. This ensures `/task N` unambiguously references a specific task regardless of which group it belongs to.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-17: Group Headings as Optional Context

**Description:** `### Group Name` headings within the Tasks section provide human-readable structure but are not parsed or required by `/task`. Small features (3-5 tasks) may omit groups entirely. Groups are informational context, not functional structure.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-18: `/transition-plan` Single Output Mode

**Description:** Eliminate the current setup + expand two-step workflow. `/transition-plan` reads ADR/requirements and produces one `implementation-plan.md` with fully described tasks in a single invocation. No scaffolding phase needed.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-19: Feature Directory Reduces to 2 Required Files

**Description:** Feature planning directory becomes `implementation-plan.md` (work breakdown) + `status-and-next-steps.md` (runtime tracking). Optional: `README.md` as hub for complex features. Replaces current N+3 file structure.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Scale from Simple to Complex Features

**Description:** Must work for both small features (3-5 tasks, like command-simplification) and large features (15+ tasks across 5 phases, like release-readiness). Optional grouping (FR-3) is the mechanism for scaling.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-2: Lower Barrier to Entry for Generated Projects

**Description:** Fewer files = less boilerplate for projects generated from templates. Templates should be simpler after this change. Aligns with "template factory" identity.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-3: Phased Deprecation Approach

**Description:** Refactoring 9 commands at once is high-risk. A phased approach (introduce new alongside old, deprecate, then remove) reduces risk and allows incremental validation.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-4: Soft References Are Low-Effort

**Description:** ~10 commands have soft references (documentation mentions of phase concepts). These are documentation-only updates and can be batched as a final cleanup step.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### NFR-5: 75% of `/task-phase` Logic Is Reusable

**Description:** TDD workflow, task grouping, commit strategy, common patterns, and error handling (~510 of ~745 meaningful lines) carry forward unchanged. Only path resolution and naming conventions (~235 lines) need updating, making the rename lower-risk than the 9-command count suggests.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-6: GitHub-Compatible Rendering

**Description:** The planning document format must use standard GFM task list checkboxes (`- [ ]` / `- [x]`) to enable GitHub's automatic progress bars and interactive checkbox toggling. Format must render correctly on GitHub without special tooling.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-7: Manageable Document Length

**Description:** Target ~120-180 lines for a typical feature (8-15 tasks). Must not exceed ~300 lines for large features (40+ tasks). If a feature exceeds this, it should be split into multiple features rather than accommodated by a longer document.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** Low

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: 9 Commands Have Hard Phase Dependencies

**Description:** `/task-phase`, `/transition-plan`, `/pre-phase-review`, `/address-review`, `/pr --phase`, `/post-pr --phase`, `/pr-validation`, `/status`, `/task-improvement` all have hard dependencies on `phase-N.md` files. Any structural change must update or replace these commands.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

---

### C-2: Existing Projects Need Migration Path

**Description:** Projects already generated from current templates use the phase file structure. Changes must include migration guidance or backward compatibility strategy.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

---

### C-3: Rules Files Have Hard Phase Dependencies

**Description:** `workflow.mdc` defines phase paths, PR phase mode, status checklist for `phase-N.md`, and pre-phase-review workflow. Must be updated in sync with command changes.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

---

### C-4: Deferred Tasks 56 and 57 Should Be Addressed Concurrently

**Description:** Centralizing detection rules (Task 56: docs-only vs code-phase) and temp directory path conventions (Task 57: three-path pattern) fits naturally within this refactor scope. Addressing them separately would create duplicate effort.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

---

### C-5: Cursor Has No Command Aliasing

**Description:** Cursor IDE custom commands are individual `.md` files with no aliasing, redirect, or deprecation metadata. Backward compatibility for `/task-phase` requires a physical stub file.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

---

### C-6: `/task` Parsing Depends on Document Format Contract

**Description:** The `- [ ] Task N: Description` checkbox pattern is the contract between `/transition-plan` (producer) and `/task` (consumer). Any change to the document format must update both commands simultaneously to maintain compatibility.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

---

## 💭 Assumptions

### A-1: 1-PR-Per-Feature Is the Standard Workflow

**Description:** The draft PR workflow (v0.8.0) is the default going forward. PR-per-phase is deprecated as a workflow pattern.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

---

### A-2: Status Tracking Pattern Is Proven

**Description:** `status-and-next-steps.md` is consistently valuable across all analyzed features. Its pattern (progress tracking, fix references, milestone summaries) should be preserved in whatever form the simplified structure takes.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

---

### A-3: `/task-phase` Is the Hub Command

**Description:** Most other phase-dependent commands orbit around `/task-phase` (pre-phase-review -> address-review -> task-phase -> pr -> post-pr). Refactoring `/task-phase` first unlocks the others.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

---

### A-4: Dev-Toolkit Will Provide Programmatic Command Support

**Description:** Dev-toolkit is being rethought to provide programmatic support for Cursor commands (turning `.md` into scripts). When available, it will handle aliasing, deprecation, and version migration natively -- superseding the stub file approach for backward compatibility. The current lack of aliasing in Cursor is an acceptable interim gap. The rethink is informed by a philosophical shift: commands are evolving from "automate a process" to "enforce a practice."

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md), [Workflow Evolution Reflection](../../planning/notes/reflections/reflection-new-commands-workflow-evolution-2026-02-13.md)

---

### A-5: TDD Detail Is a Runtime Concern

**Description:** The planning document describes "what" (tasks); the `/task` command manages "how" (TDD RED/GREEN/REFACTOR execution at runtime). This eliminates the need for `/transition-plan --expand` mode. Pre-expanded TDD steps are redundant with `/task`'s built-in TDD workflow.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

---

### A-6: Group Headings Will Correspond to Previous Phases

**Description:** Teams migrating from `phase-N.md` files will naturally use group headings that match their former phases (e.g., `### Phase 1: Foundation`). This is acceptable and expected behavior, not a design requirement. Groups are optional and can use any naming convention.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)

---

## 🚀 Next Steps

1. Conduct Topic 4 research -- extract remaining requirements
2. Refine requirements based on all findings
3. Use `/decision workflow-simplification --from-research` when complete

---

**Last Updated:** 2026-02-14
