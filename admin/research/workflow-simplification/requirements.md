# Requirements - Workflow Simplification

**Source:** Research on workflow simplification (feature/phase/task hierarchy)  
**Status:** Final  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-14  
**Consolidated:** 2026-02-14

---

## 📋 Overview

This document captures requirements discovered during research on workflow simplification. Requirements were extracted across 6 research topics, then consolidated to remove redundancies, resolve superseded items, and fill gaps.

**Research Source:** [research-summary.md](research-summary.md)

**Consolidation Changes:**
- Merged: FR-15+FR-19 (tiered structure), FR-18+FR-20 (blueprint), FR-22+FR-30 (tier config)
- Removed: old FR-3 (superseded by FR-14), old FR-5 (redundant with FR-1+FR-8), old FR-9 (superseded by FR-18)
- Added: FR-25 (cursor rules file updates)
- Modified: FR-1 (tiered model), FR-4 (nuanced command breakdown), FR-9 (all renamed commands)
- Renumbered: all FRs sequentially after consolidation

---

## ✅ Functional Requirements

### FR-1: Tiered Planning Document Per Feature

**Description:** The planning structure should consolidate `feature-plan.md` + `phase-N.md` into `implementation-plan.md`. The structure is tiered by task count: Simple (1-8 tasks) uses a single file; Medium (9-15 tasks) uses a single file with group headings; Complex (16+ tasks) uses a hub file + `tasks/[group].md` files. Evidence: command-simplification succeeded with phases inline; phase files are write-once under 1-PR workflow.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md), refined by [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Preserve Status Tracking

**Description:** `status-and-next-steps.md` is consistently the most-updated file across all features (14 commits in release-readiness, 9 in worktree). Must be retained as a separate file at all tiers -- runtime tracking stays distinct from the implementation plan.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-3: Machine-Parseable Task List

**Description:** `/task` command needs to read task items from the planning document. GFM checkboxes (`- [ ]` / `- [x]`) are the proven format for progress tracking. The document structure must be parseable by automation.

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-4: Command Refactoring Scope

**Description:** The workflow simplification requires: 2 command renames (`task-phase` → `task`, `pre-phase-review` → `plan-review`), ~11 commands with content updates (phase references in docs, `--phase` flags, phase path resolution), and 2 deprecation stubs. The refactoring is documentation-heavy, not structural -- 75% of `/task-phase` logic (TDD, task grouping, commit strategy) is task-generic and carries forward unchanged.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md), refined by [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-5: Command Renaming

**Description:** `/task-phase` → `/task` (or similar), `/pre-phase-review` → `/plan-review` (or similar). Both renames require new command files and deprecation stubs for the old names.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-6: Template Sync Manifest Update

**Description:** `template-sync-manifest.txt` lists `task-phase.md` and `pre-phase-review.md` as sync files. Renaming these commands requires updating the manifest (remove old entries, add new entries + deprecation stubs) and both template copies.

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-7: Hybrid Task Selection Interface

**Description:** `/task` must support three modes: `next` (sequential -- finds first unchecked task), `N` (explicit numbered -- implements specific task), and bare `/task` (status/list -- shows task progress). All modes read from the same planning document (or hub + group files at complex tier).

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-8: Implementation Plan as Task Source

**Description:** `/task` reads tasks from `implementation-plan.md` using checkbox parsing (`- [ ]` / `- [x]`). At simple/medium tier, all tasks are in one file. At complex tier, `/task` reads the hub for the task index, then the relevant `tasks/[group].md` file. Optional group headings (`###`) provide human context but are not required by the command.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md), [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-9: Deprecation Stubs for Renamed Commands

**Description:** Create deprecation stubs for all renamed commands: `task-phase.md` pointing to `/task`, `pre-phase-review.md` pointing to `/plan-review`. Each stub contains: "This command has been renamed to `/[new-name]`. [Migration instructions]." Remove stubs in next major version.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md), [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-10: Simplified Branch Naming

**Description:** Branch names should be `feat/[feature]-[desc]` (no phase number). With 1-PR-per-feature, the branch is the feature branch, not a phase branch.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-11: Simplified Commit Scope

**Description:** Commit messages should use feature/component scope (`feat(auth): ...`) not phase scope (`feat(phase-3): ...`). Task context comes from the planning document, not the commit scope.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### FR-12: Uniform Implementation Plan Structure

**Description:** `/transition-plan` must produce a uniform structure for every feature: `implementation-plan.md` (task index with GFM checkboxes) + `status-and-next-steps.md` + `tasks/` directory (task detail files). The `tasks/` directory scales naturally -- one file for small features, multiple grouped files for large ones. No tier detection or branching logic. Replaces the tiered approach (Simple/Medium/Complex) with a single predictable layout.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment). **Amended 2026-02-19:** Revised from tiered to uniform structure per ADR-001 amendment.

**Priority:** High

**Status:** 🔴 Pending

---

### FR-13: Global Continuous Task Numbering

**Description:** Tasks are numbered sequentially across the entire document or hub (Task 1 through Task N), not restarted per group. This ensures `/task N` unambiguously references a specific task regardless of which group it belongs to or which file it's in.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-14: Group Headings as Optional Context

**Description:** `### Group Name` headings provide human-readable structure but are not parsed or required by `/task`. Small features may omit groups entirely. At complex tier, groups become separate files under `tasks/`. This replaces the mandatory phase-file structure with an optional, lightweight alternative.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md). Absorbs old FR-3 (optional phase grouping).

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-15: `/transition-plan` Produces Feature Blueprint

**Description:** The command reads ADR/requirements, counts tasks and groups, and produces the uniform file structure (`implementation-plan.md` + `status-and-next-steps.md` + `tasks/`). The `implementation-plan.md` includes machine-readable YAML frontmatter declaring: task count, group count, and `tasks/` file list. This metadata is the contract between `/transition-plan` (producer) and `/task` (consumer). Replaces the current setup + expand two-step workflow with a single pass.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment). **Amended 2026-02-19:** Removed tier field from frontmatter per ADR-001 amendment.

**Priority:** High

**Status:** 🔴 Pending

---

### FR-16: ~~Codified Tier Thresholds~~ (Removed)

**Description:** ~~`/transition-plan` must apply documented thresholds (1-8 = simple, 9-15 = medium, 16+ = complex) automatically based on task count from ADR/requirements.~~

**Removed 2026-02-19:** Tier thresholds no longer needed. ADR-001 amendment adopted a uniform structure for all features regardless of task count.

**Priority:** ~~Medium~~ N/A

**Status:** ❌ Removed

---

### FR-17: Planning Specification as Single Source of Truth

**Description:** A machine-readable planning configuration in dev-infra (e.g., `planning.yaml`) defines the uniform structure (`implementation-plan.md` + `status-and-next-steps.md` + `tasks/`), the `tasks/` directory contract, and template mappings. Both Cursor commands and dev-toolkit CLI read this specification. Dev-infra owns specs; dev-toolkit owns implementation.

**Source:** [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md), [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md). **Amended 2026-02-19:** Revised from tier config to uniform structure specification per ADR-001 amendment.

**Priority:** High

**Status:** 🔴 Pending

---

### FR-18: Replace Planning Doc-Gen Templates

**Description:** Replace `feature-plan.md.tmpl` + `phase.md.tmpl` with tier-aware templates: `implementation-plan.md.tmpl` (simple/medium), `implementation-plan-hub.md.tmpl` (complex hub), `task-group.md.tmpl` (complex group files). Update `status-and-next-steps.md.tmpl` to remove phase-centric progress table. Update `planning.yaml` validation rules with new subtypes (`implementation_plan`, `task_group`).

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 9 amendment), confirmed by [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md). Absorbs old FR-9 (doc-gen templates must be updated).

**Priority:** High

**Status:** 🔴 Pending

---

### FR-19: New Template Variables for Tier System

**Description:** Add variables to the doc-gen variable contract: `${TIER}` (simple/medium/complex), `${TASK_COUNT}`, `${GROUP_COUNT}`, `${STRUCTURE}` (single-file/hub-and-groups), `${GROUP_FILES}` (list of group file paths for complex tier), `${GROUP_NAME}`, `${TASK_RANGE}`. These are used in YAML frontmatter and template rendering.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 9 amendment), confirmed by [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-20: Migration Guide for Existing Projects

**Description:** A migration guide (e.g., `docs/MIGRATION-v0.10.md` or equivalent section in release notes) must document: what changed in the planning structure, how to update an existing project generated from a previous template version, and how to handle in-progress features that use phase files.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-21: Template Workflow Documentation Update

**Description:** 4-5 workflow documentation files in each template (`WORKFLOW-FEATURE-DEVELOPMENT.md`, `WORKFLOW-OVERVIEW.md`, `WORKFLOW-EXPLORATION-RESEARCH-DECISION.md`, `WORKFLOW-CICD-IMPROVEMENT.md`, and `planning/features/README.md`) must be updated to replace phase-based workflow descriptions with the new task-based flow. Estimated ~400-500 lines of targeted changes.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-22: Example Document Replacement

**Description:** `examples/example-feature-plan.md` must be replaced with `examples/example-implementation-plan.md` demonstrating the tiered structure (at least one tier, preferably medium as the most instructive).

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-23: Planning Hub Updates

**Description:** `planning/features/README.md` and `planning/README.md` must be updated to remove phase template references, update directory structure examples, and update the Feature Planning Checklist to reference `implementation-plan.md` instead of `phase-N.md`.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-24: Validation Rule Migration

**Description:** `planning.yaml` must be updated: add `implementation_plan` and `task_group` document types, deprecate (then later remove) the `phase` document type, update `status_and_next_steps` progress table validation to use task counts instead of phase counts. During transition, accept both old and new formats.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-25: Cursor Rules File Updates

**Description:** `.cursor/rules/` files (`main.mdc`, `workflow.mdc`, `template.mdc`) in both dev-infra and both templates encode phase concepts extensively -- phase paths, PR phase mode, status checklist for `phase-N.md`, pre-phase-review workflow, and current project state descriptions. All three rules files must be updated to reflect the new planning structure. This is a documentation-only change but is high-surface-area (~200+ lines across 3 files per location).

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md) (C-3), [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Scale from Simple to Complex Features

**Description:** Must work for both small features (3-5 tasks, like command-simplification) and large features (15+ tasks across 5 phases, like release-readiness). Tiered structure (FR-12) is the mechanism for scaling.

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

**Description:** Refactoring ~11 commands at once is high-risk. A phased approach (introduce new alongside old, deprecate, then remove) reduces risk and allows incremental validation.

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

**Description:** TDD workflow, task grouping, commit strategy, common patterns, and error handling (~510 of ~745 meaningful lines) carry forward unchanged. Only path resolution and naming conventions (~235 lines) need updating, making the rename lower-risk than the command count suggests.

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

### NFR-7: AI Context Efficiency

**Description:** At simple/medium tiers, `/task` reads one file. At complex tier, `/task` reads the hub (for task index) then only the relevant group file (for task detail). This keeps context consumption proportional to the work being done, not the total feature size.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-8: Tier Specification Consumable by Both IDE and CLI

**Description:** The tier specification (templates + tier config + validation rules) must be readable by AI agents (via Cursor command specs), by dev-toolkit CLI (via `DT_TEMPLATES_PATH`), and by CI (for validation). The spec is the interface; how it's consumed is the consumer's concern.

**Source:** [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-9: Atomic Template Updates

**Description:** Changes must be applied to both templates simultaneously (standard-project first, then sync to learning-project via template-sync-manifest). No release should ship with divergent planning structures between templates.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-10: Zero Learning-Project Regressions

**Description:** Stage-based structure (stage0-N directories, practice-apps, reference) must be completely unaffected by planning simplification changes. No test should fail for learning-project-specific features.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** High

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Hard Phase Dependencies in Commands

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

**Description:** Cursor IDE custom commands are individual `.md` files with no aliasing, redirect, or deprecation metadata. Backward compatibility for renamed commands requires physical stub files.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

---

### C-6: `/task` Parsing Depends on Document Format Contract

**Description:** The `- [ ] Task N: Description` checkbox pattern is the contract between `/transition-plan` (producer) and `/task` (consumer). Any change to the document format must update both commands simultaneously to maintain compatibility.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

---

### C-7: `/task` Must Handle Both Single-File and Hub+Group Structures

**Description:** At simple/medium tiers, tasks are in a single file. At complex tier, the hub has a task index and tasks live in group files. `/task` reads the YAML frontmatter blueprint metadata to determine which structure it's operating on, then resolves the correct file for the requested task number.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

---

### C-8: Doc-Gen Template Replacement Is a Breaking Change

**Description:** Replacing `feature-plan.md.tmpl` and `phase.md.tmpl` with the tier-aware templates is a breaking change for dev-toolkit's `dt-doc-gen` and any validation rules compiled from `planning.yaml`. Dev-toolkit's `templates.sh` type mappings, `type-detection.sh` path patterns, and compiled `.bash` rules all need coordinated updates. The `template-sync-manifest.txt` must also be updated for any shared template files.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 9 amendment), confirmed by [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

---

### C-9: Dev-Infra Templates Are the Single Source of Truth

**Description:** Dev-toolkit discovers templates from dev-infra via `DT_TEMPLATES_PATH` (defaulting to `~/Projects/dev-infra/scripts/doc-gen/templates`). Any template changes in dev-infra must be propagated to dev-toolkit's template discovery, type detection, and validation rule compilation. Dev-infra owns the contract; dev-toolkit consumes it. Scope: specs only (templates + validation rules + tier config), not scripts.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 9 amendment), confirmed by [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

---

### C-10: In-Progress Features Coexist with New Structure

**Description:** Existing projects may have features using the old `phase-N.md` structure when they adopt the new template version. Commands must handle encountering old structure gracefully (at minimum, provide clear error messages pointing to migration guide rather than cryptic failures).

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

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

**Description:** Dev-toolkit is being rethought to provide programmatic support for Cursor commands (turning `.md` into scripts). When available, it will handle aliasing, deprecation, and version migration natively -- superseding the stub file approach for backward compatibility. The current lack of aliasing in Cursor is an acceptable interim gap.

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

---

### A-5: TDD Detail Is a Runtime Concern

**Description:** The planning document describes "what" (tasks); the `/task` command manages "how" (TDD RED/GREEN/REFACTOR execution at runtime). This eliminates the need for `/transition-plan --expand` mode. Pre-expanded TDD steps are redundant with `/task`'s built-in TDD workflow.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

---

### A-6: Group Headings Will Correspond to Previous Phases

**Description:** Teams migrating from `phase-N.md` files will naturally use group headings that match their former phases (e.g., `### Phase 1: Foundation`). This is acceptable and expected behavior, not a design requirement. Groups are optional and can use any naming convention.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

---

### A-7: Task Count Is Knowable at Planning Time

**Description:** The ADR and requirements documents provide enough information for `/transition-plan` to estimate the number of tasks and groups. The count doesn't need to be exact -- it drives a tier decision (simple/medium/complex), not a precise structure. Over- or under-estimation by 1-2 tasks at a tier boundary is acceptable.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

---

### A-8: Existing Projects Adopt New Structure for New Features Only

**Description:** We assume existing projects will use the new structure for new features but won't retroactively convert completed or in-progress features. The migration guide supports this "new features only" approach. Historical phase-N.md files remain in place.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

---

### A-9: AI Agent Sufficiency During Gap Period

**Description:** We assume the period between shipping the new planning structure and dev-toolkit implementing `dt-scaffold-feature` is manageable via AI agents reading the `/transition-plan` command spec. No temporary bridge script is needed. This is consistent with how all 24 existing commands operate (AI reads spec, produces output).

**Source:** [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)

---

## 🚀 Next Steps

1. ~~Extract requirements from all topics~~ ✅
2. ~~Consolidate requirements (remove redundancies, fill gaps)~~ ✅
3. Use `/decision workflow-simplification --from-research` to create ADRs

---

**Last Updated:** 2026-02-14
