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

### FR-15 (AMENDED): Tiered Implementation Plan Structure

**Description:** `/transition-plan` must produce structure based on task count: Simple (1-8 tasks) → single `implementation-plan.md`; Medium (9-15 tasks) → single file with `###` groups; Complex (16+ tasks) → hub `implementation-plan.md` + `tasks/[group].md` files. All tiers use Format B (GFM checkboxes). Amended from original "always single file" based on reassessment of AI context cost, progressive disclosure, and concurrent editing concerns.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-16: Global Continuous Task Numbering

**Description:** Tasks are numbered sequentially across the entire document or hub (Task 1 through Task N), not restarted per group. This ensures `/task N` unambiguously references a specific task regardless of which group it belongs to or which file it's in.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-17: Group Headings as Optional Context

**Description:** `### Group Name` headings provide human-readable structure but are not parsed or required by `/task`. Small features may omit groups entirely. At complex tier, groups become separate files under `tasks/`.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-18 (AMENDED): `/transition-plan` Produces Feature Blueprint

**Description:** The command reads ADR/requirements, counts tasks and groups, determines the tier (simple/medium/complex), and produces the appropriate file structure. Includes machine-readable metadata (YAML frontmatter) declaring tier, task count, group count, and structure. Replaces the current setup + expand two-step workflow.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-19 (AMENDED): Feature Directory Structure Scales by Tier

**Description:** Simple: `implementation-plan.md` + `status-and-next-steps.md` (2 files). Medium: same 2 files. Complex: `implementation-plan.md` (hub) + `tasks/[group].md` files + `status-and-next-steps.md` (3+ files). All tiers reduce from current N+3 file structure.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-20: Feature Blueprint with Explicit Tier Metadata

**Description:** `implementation-plan.md` must include YAML frontmatter declaring: tier (simple/medium/complex), task count, group count, and file structure (single-file or hub-and-groups with file list). This metadata is the contract between `/transition-plan` (producer) and `/task` (consumer).

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-21: Codified Tier Thresholds

**Description:** `/transition-plan` must apply documented thresholds (1-8 = simple, 9-15 = medium, 16+ = complex) automatically based on task count from ADR/requirements. User can override with `--tier` flag. Thresholds have sensible defaults but are configurable.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-22 (REVISED): Tier Specification as Single Source of Truth

**Description:** A machine-readable tier configuration in dev-infra (e.g., `tier-config.yaml` or section in `planning.yaml`) defines thresholds (1-8 = simple, 9-15 = medium, 16+ = complex), corresponding file structures, and template mappings. Both Cursor commands and dev-toolkit CLI read this specification. Replaces the original "Scaffolding Script" requirement -- dev-infra owns specs, dev-toolkit owns implementation.

**Source:** [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md) (revised from [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md))

**Priority:** High

**Status:** 🔴 Pending

---

### FR-23 (CONFIRMED): Replace Planning Doc-Gen Templates

**Description:** Replace `feature-plan.md.tmpl` + `phase.md.tmpl` with tier-aware templates: `implementation-plan.md.tmpl` (simple/medium), `implementation-plan-hub.md.tmpl` (complex hub), `task-group.md.tmpl` (complex group files). Update `status-and-next-steps.md.tmpl` to remove phase-centric progress table. Update `planning.yaml` validation rules with new subtypes (`implementation_plan`, `task_group`).

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 9 amendment), confirmed by [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-24 (CONFIRMED): New Template Variables for Tier System

**Description:** Add variables to the doc-gen variable contract: `${TIER}` (simple/medium/complex), `${TASK_COUNT}`, `${GROUP_COUNT}`, `${STRUCTURE}` (single-file/hub-and-groups), `${GROUP_FILES}` (list of group file paths for complex tier), `${GROUP_NAME}`, `${TASK_RANGE}`. These are used in YAML frontmatter and template rendering.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 9 amendment), confirmed by [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-25: Migration Guide for Existing Projects

**Description:** A migration guide (e.g., `docs/MIGRATION-v0.10.md` or equivalent section in release notes) must document: what changed in the planning structure, how to update an existing project generated from a previous template version, and how to handle in-progress features that use phase files.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-26: Template Workflow Documentation Update

**Description:** 4-5 workflow documentation files in each template (`WORKFLOW-FEATURE-DEVELOPMENT.md`, `WORKFLOW-OVERVIEW.md`, `WORKFLOW-EXPLORATION-RESEARCH-DECISION.md`, `WORKFLOW-CICD-IMPROVEMENT.md`, and `planning/features/README.md`) must be updated to replace phase-based workflow descriptions with the new task-based flow. Estimated ~400-500 lines of targeted changes.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-27: Example Document Replacement

**Description:** `examples/example-feature-plan.md` must be replaced with `examples/example-implementation-plan.md` demonstrating the tiered structure (at least one tier, preferably medium as the most instructive).

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-28: Planning Hub Updates

**Description:** `planning/features/README.md` and `planning/README.md` must be updated to remove phase template references, update directory structure examples, and update the Feature Planning Checklist to reference `implementation-plan.md` instead of `phase-N.md`.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-29: Validation Rule Migration

**Description:** `planning.yaml` must be updated: add `implementation_plan` and `task_group` document types, deprecate (then later remove) the `phase` document type, update `status_and_next_steps` progress table validation to use task counts instead of phase counts. During transition, accept both old and new formats.

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-30: Machine-Readable Tier Configuration

**Description:** Dev-infra must provide a machine-readable tier configuration (e.g., `tier-config.yaml` or a section in `planning.yaml`) that defines: tier thresholds (1-8 = simple, 9-15 = medium, 16+ = complex), file structure per tier, and template mappings per tier. This config is the contract between dev-infra (producer) and dev-toolkit + Cursor commands (consumers).

**Source:** [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

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

### NFR-7 (AMENDED): AI Context Efficiency

**Description:** At simple/medium tiers, `/task` reads one file. At complex tier, `/task` reads the hub (for task index) then only the relevant group file (for task detail). This keeps context consumption proportional to the work being done, not the total feature size. Amended from original "manageable document length" which imposed an arbitrary 300-line cap.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-8 (REVISED): Tier Specification Consumable by Both IDE and CLI

**Description:** The tier specification (templates + tier config + validation rules) must be readable by AI agents (via Cursor command specs), by dev-toolkit CLI (via `DT_TEMPLATES_PATH`), and by CI (for validation). The spec is the interface; how it's consumed is the consumer's concern. Replaces "Scaffolding Script Callable from Both IDE and CLI."

**Source:** [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md) (revised from [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md))

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

### C-7: `/task` Must Handle Both Single-File and Hub+Group Structures

**Description:** At simple/medium tiers, tasks are in a single file. At complex tier, the hub has a task index and tasks live in group files. `/task` reads the YAML frontmatter blueprint metadata to determine which structure it's operating on, then resolves the correct file for the requested task number.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 8 amendment)

---

### C-8 (CONFIRMED): Doc-Gen Template Replacement Is a Breaking Change

**Description:** Replacing `feature-plan.md.tmpl` and `phase.md.tmpl` with the tier-aware templates is a breaking change for dev-toolkit's `dt-doc-gen` and any validation rules compiled from `planning.yaml`. Dev-toolkit's `templates.sh` type mappings, `type-detection.sh` path patterns, and compiled `.bash` rules all need coordinated updates. The `template-sync-manifest.txt` must also be updated for any shared template files.

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md) (Finding 9 amendment), confirmed by [topic-6-dev-infra-code-boundary.md](topic-6-dev-infra-code-boundary.md)

---

### C-9 (CONFIRMED): Dev-Infra Templates Are the Single Source of Truth

**Description:** Dev-toolkit discovers templates from dev-infra via `DT_TEMPLATES_PATH` (defaulting to `~/Projects/dev-infra/scripts/doc-gen/templates`). Any template changes in dev-infra must be propagated to dev-toolkit's template discovery, type detection, and validation rule compilation. Dev-infra owns the contract; dev-toolkit consumes it. Scope confirmed: specs only (templates + validation rules + tier config), not scripts.

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

1. ~~Conduct Topic 4 research -- extract remaining requirements~~ ✅
2. ~~Conduct Topic 6 research -- resolve tentative requirements~~ ✅
3. All 6 topics complete -- requirements fully captured (30 FRs, 10 NFRs, 10 Cs, 9 As)
4. Use `/decision workflow-simplification --from-research` to create ADRs

---

**Last Updated:** 2026-02-14
