# Research Summary - Workflow Simplification

**Purpose:** Summary of all research findings for workflow simplification  
**Status:** ✅ Complete  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-14

---

## 📋 Research Overview

Research for simplifying the feature/phase/task hierarchy given the draft PR workflow (1 PR per feature) and spike-driven decisions.

**Research Topics:** 5 topics  
**Research Documents:** 5 documents  
**Status:** ✅ Complete (5/5 complete)

---

## 🔍 Key Findings

### Topic 1: Feature Plan Structure Usage (✅ Complete)

**Finding:** Phase documents are actively used under PR-per-phase workflows but become write-once ceremony under 1-PR-per-feature workflows. Command-simplification feature succeeded with no phase files at all (phases inline in feature-plan). `status-and-next-steps.md` is consistently the most-updated and most-valuable planning artifact.

**Recommendation:** Simplify to single planning document + status file. Make phase-N.md optional.

**Requirements extracted:** FR-1 (single doc), FR-2 (preserve status), FR-3 (optional grouping), FR-4 (parseable tasks), NFR-1 (scale), NFR-2 (lower barrier), C-2 (migration path), A-1 (1-PR standard), A-2 (status pattern proven).

**Source:** [topic-1-feature-plan-usage.md](topic-1-feature-plan-usage.md)

---

### Topic 5: Command Dependency Analysis (✅ Complete)

**Finding:** 9 commands have hard dependencies on phase-N.md files and would break if removed. `/task-phase` is the hub; most other phase commands orbit it. 3 path patterns (feature-specific, project-wide, CI) all use phase-N.md. Doc-gen templates (planning.yaml, phase.md.tmpl) also encode phase structure.

**Recommendation:** HIGH effort refactor. Phased approach suggested: introduce `/task` as alias, support both structures, then deprecate phase-N.

**Requirements extracted:** FR-5 (alternative task source), FR-6 (9 commands refactor), FR-7 (2-3 command renames), FR-8 (sync manifest update), FR-9 (doc-gen template update), NFR-3 (phased deprecation), NFR-4 (soft refs low-effort), C-1 (9 hard deps), C-3 (rules files), C-4 (deferred tasks 56/57 concurrent), A-3 (task-phase is hub).

**Source:** [topic-5-command-dependency-analysis.md](topic-5-command-dependency-analysis.md)

---

### Topic 2: Task Command Interface Design (✅ Complete)

**Finding:** 75% of `/task-phase` logic (TDD, task grouping, commit strategy, patterns) is task-generic and survives renaming. The phase-dependent 25% is path resolution and naming conventions. A hybrid interface (`/task next` + `/task N` + bare `/task` for status) is optimal based on industry patterns (Taskwarrior, Taskfile, Cobra). Cursor has no command aliasing, so backward compatibility requires a stub file.

**Recommendation:** Create `/task` with hybrid interface. Stub `task-phase.md` with deprecation notice. Simplify branch names (drop phase number) and commit scopes (use feature/component, not phase).

**Requirements extracted:** FR-10 (hybrid interface), FR-11 (flat doc task source), FR-12 (deprecation stub), FR-13 (branch naming), FR-14 (commit scope), NFR-5 (75% reusable), C-5 (no aliasing).

**Source:** [topic-2-task-command-interface-design.md](topic-2-task-command-interface-design.md)

---

### Topic 3: Transition Plan Output Format (✅ Complete, AMENDED)

**Finding:** Three industry formats were evaluated (flat checkbox, grouped checkbox, rich task entries). Format B (grouped checkbox list with optional section headings) is the clear winner for the task format itself. However, post-research reassessment identified single-file bias: for complex features (16+ tasks), a single file causes AI context waste, progressive disclosure violations, and concurrent editing risk. The amended recommendation is a **tiered structure**: simple (1-8 tasks, single file), medium (9-15 tasks, single file with groups), complex (16+ tasks, hub + group files). `/transition-plan` determines the tier automatically from task count and produces a **feature blueprint** (YAML frontmatter metadata) that `/task` reads to understand the structure.

**Recommendation:** Adopt Format B at all tiers. Use tiered file structure based on codified task count thresholds. `/transition-plan` produces a blueprint with explicit tier metadata. `implementation-plan.md` is the entry point at all tiers. Keep `status-and-next-steps.md` separate.

**Requirements extracted:** FR-15 (tiered structure, amended), FR-16 (global numbering), FR-17 (optional groups), FR-18 (blueprint, amended), FR-19 (scales by tier, amended), FR-20 (tier metadata), FR-21 (codified thresholds), FR-22 (scaffolding script), FR-23 (replace planning templates), FR-24 (new template variables), NFR-6 (GitHub rendering), NFR-7 (AI context efficiency, amended), NFR-8 (script callable from IDE+CLI), C-6 (format contract), C-7 (handle both structures), C-8 (template breaking change), C-9 (dev-infra as single source), A-5 (TDD runtime), A-6 (group-phase mapping), A-7 (task count knowable).

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

---

### Topic 4: Template Impact Assessment (✅ Complete)

**Finding:** Both templates (standard-project and learning-project) are structurally identical for planning -- one change set covers both. The learning-project's stage-based structure (stage0-N directories) is completely orthogonal to the phase/task planning system and requires zero special handling. The change surface is documentation-heavy (4-5 workflow docs, ~400-500 lines of targeted updates), not structural -- no template directories need to be added or removed. 2 commands rename (task-phase → task, pre-phase-review → plan-review), ~11 commands get content updates, and 1 deprecation stub is added. Doc-gen validation rules (`planning.yaml`) are the structural contract defining the canonical change. The breaking change is moderate: new features in existing projects are unaffected; in-progress features using `--phase` flags need adjustment.

**Recommendation:** Treat as minor version bump (v0.10.0). Ship migration guide. Apply template changes atomically (standard-project first, sync to learning). Include deprecation stub for backward compatibility. Update validation rules first as the contract, then templates, then commands.

**Requirements extracted:** FR-25 (migration guide), FR-26 (workflow doc update), FR-27 (example replacement), FR-28 (planning hub updates), FR-29 (validation rule migration), NFR-9 (atomic template updates), NFR-10 (zero learning-project regressions), C-10 (old structure coexistence), A-8 (new features only adoption).

**Source:** [topic-4-template-impact-assessment.md](topic-4-template-impact-assessment.md)

---

## 💡 Key Insights (So Far)

- [x] **1-PR workflow made phase docs ceremonial.** When phases don't map to PRs, phase documents lose their primary function.
- [x] **Command-simplification proved the flat model works.** No phase files, phases inline, feature completed successfully.
- [x] **Status tracking is the proven pattern.** `status-and-next-steps.md` consistently has higher update frequency and richer content than phase files.
- [x] **Refactoring cost is HIGH but necessary.** 9 commands need updating, but the alternative is perpetuating ceremony in every generated project.
- [x] **75% of `/task-phase` is already task-generic.** The rename is primarily path resolution + naming, not a logic rewrite. Lower risk than the 9-command count suggests.
- [x] **Hybrid interface is optimal.** `/task next` for flow, `/task N` for resume, bare `/task` for status. Industry patterns (Taskwarrior, Taskfile) validate this approach.
- [x] **Format B (grouped checkbox) is the winning task format.** Trivially parseable. GitHub-compatible. Optional `###` headings replace mandatory phase files.
- [x] **Tiered file structure replaces one-size-fits-all.** Simple (1-8 tasks): single file. Medium (9-15): single file with groups. Complex (16+): hub + group files. Addresses AI context waste and progressive disclosure for complex features.
- [x] **Feature blueprint with codified tier thresholds.** `/transition-plan` counts tasks, applies thresholds, and produces YAML frontmatter metadata so `/task` knows the structure. No discretion -- thresholds are rules, not guidelines.
- [x] **TDD detail is runtime, not planning.** Expand mode can be eliminated -- `/task` manages RED/GREEN/REFACTOR at implementation time.
- [ ] **⚠️ Doc-gen templates + tier logic implementation -- ownership TBD.** Research assumed a `scaffold-feature.sh` script in dev-infra, but exploration Theme 5 questions whether dev-infra should maintain executable code for generated projects. The tier-aware templates are valid; the question is where the rendering/scaffolding logic lives (dev-infra script vs. dev-toolkit command vs. manifest-only).
- [x] **Two-way dev-infra ↔ dev-toolkit relationship confirmed.** Dev-infra owns standards (templates, validation rules). Dev-toolkit consumes them. The boundary between "spec" and "implementation" needs explicit definition (exploration Theme 5).
- [x] **Both templates share identical planning structure.** Standard and learning templates have the same `docs/maintainers/` hierarchy. A single change set covers both -- zero learning-project-specific work needed.
- [x] **Learning-project stages are orthogonal to phases.** Stages (content directories) and phases (planning documents) are completely separate concepts with zero interaction. Stage-based learning progression works naturally with flat task planning.
- [x] **Documentation is the largest change surface, not file structure.** No template directories need to be added or removed. ~400-500 lines of targeted workflow doc updates plus command file changes. This is a documentation-heavy change.
- [x] **Doc-gen validation rules are the structural contract.** `planning.yaml` defines what "valid" looks like. Updating it first ensures templates and commands can be validated during development.
- [x] **Breaking change is moderate and manageable.** New features: zero impact. In-progress features: `--phase` flags stop working. Historical features: unaffected. Deprecation stub provides guidance.

---

## 📋 Requirements Summary

**29 Functional Requirements (3 tentative), 10 Non-Functional Requirements (1 tentative), 10 Constraints (2 tentative), 8 Assumptions** extracted from all 5 topics (Topics 1, 2, 3 amended x2, 4, and 5). Tentative items depend on code boundary decision (exploration Theme 5).

**See:** [requirements.md](requirements.md) for complete requirements document

---

## 🎯 Recommendations (So Far)

- [x] **Simplify to single planning document** per feature (from Topic 1)
- [x] **Preserve status-and-next-steps.md** pattern (from Topic 1)
- [x] **Use phased deprecation** approach for removing phase-N.md support (from Topic 5)
- [x] **Hybrid `/task` interface** -- `next` for flow, `N` for explicit, bare for status (from Topic 2)
- [x] **Stub `/task-phase`** with deprecation notice; remove in next major version (from Topic 2)
- [x] **Simplify branch/commit naming** -- drop phase numbers from both (from Topic 2)
- [x] **Adopt Format B at all tiers** -- grouped checkbox list with optional `###` headings (from Topic 3)
- [x] **Tiered file structure** -- simple (single file), medium (single file + groups), complex (hub + group files) (from Topic 3 amendment)
- [x] **Feature blueprint with YAML frontmatter** -- `/transition-plan` produces explicit tier metadata (from Topic 3 amendment)
- [x] **Codified tier thresholds** -- 1-8 simple, 9-15 medium, 16+ complex; no discretion (from Topic 3 amendment)
- [x] **Name document `implementation-plan.md`** -- entry point at all tiers (from Topic 3)
- [x] **Keep `status-and-next-steps.md` separate** -- runtime tracking stays distinct from plan (from Topic 3)
- [x] **Eliminate expand mode** -- `/transition-plan` produces blueprint + files in one mode (from Topic 3)
- [ ] **⚠️ Scaffolding logic ownership TBD** -- tier logic needs an implementation home; dev-infra script vs. dev-toolkit command vs. manifest-only (from Topic 3 amendment, under exploration Theme 5)
- [x] **Replace planning doc-gen templates** -- `feature-plan.md.tmpl` + `phase.md.tmpl` → tier-aware templates with YAML frontmatter (from Topic 3 amendment; template design valid, ownership TBD)
- [x] **Minor version bump (v0.10.0)** -- dev-infra is pre-1.0; deprecation stub provides backward compatibility (from Topic 4)
- [x] **Ship migration guide** -- `docs/MIGRATION-v0.10.md` for existing projects (from Topic 4)
- [x] **Atomic template updates** -- standard-project first, sync to learning via manifest (from Topic 4)
- [x] **Update validation rules first** -- `planning.yaml` is the contract; templates and commands follow (from Topic 4)
- [x] **Workflow doc rewrite as separate task** -- highest effort, lowest risk; can be parallelized (from Topic 4)

---

## 🚀 Next Steps

1. ~~Conduct Topic 2 (Task Command Interface Design)~~ ✅
2. ~~Conduct Topic 3 (Transition Plan Output Format)~~ ✅
3. ~~Conduct Topic 4 (Template Impact Assessment)~~ ✅
4. All 5 topics complete -- ready for decision phase
5. Use `/decision workflow-simplification --from-research` to create ADRs

---

**Last Updated:** 2026-02-14
