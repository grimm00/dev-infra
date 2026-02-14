# Research Summary - Workflow Simplification

**Purpose:** Summary of all research findings for workflow simplification  
**Status:** 🟠 In Progress  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-14

---

## 📋 Research Overview

Research for simplifying the feature/phase/task hierarchy given the draft PR workflow (1 PR per feature) and spike-driven decisions.

**Research Topics:** 5 topics  
**Research Documents:** 5 documents  
**Status:** 🟠 In Progress (4/5 complete)

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

### Topic 3: Transition Plan Output Format (✅ Complete)

**Finding:** Three industry formats were evaluated (flat checkbox, grouped checkbox, rich task entries). Format B (grouped checkbox list with optional section headings) is the clear winner -- it works for small features (8 tasks) and large features (40+ tasks), is trivially machine-parseable via `- [ ]` / `- [x]` patterns, and renders with GitHub progress bars. The current N+3 file structure (`feature-plan.md` + `transition-plan.md` + N `phase-N.md` + `status-and-next-steps.md`) reduces to exactly 2 files: `implementation-plan.md` + `status-and-next-steps.md`. The `/transition-plan` expand mode can be eliminated -- TDD detail is a runtime concern managed by `/task`, not a planning concern.

**Recommendation:** Adopt Format B with global continuous task numbering, optional `###` group headings, and a single `/transition-plan` output mode. Name the document `implementation-plan.md`. Keep `status-and-next-steps.md` separate for runtime tracking.

**Requirements extracted:** FR-15 (document format), FR-16 (global numbering), FR-17 (optional groups), FR-18 (single output mode), FR-19 (2-file directory), NFR-6 (GitHub rendering), NFR-7 (document length), C-6 (format contract), A-5 (TDD runtime), A-6 (group-phase mapping).

**Source:** [topic-3-transition-plan-output-format.md](topic-3-transition-plan-output-format.md)

---

### Topic 4: Template Impact Assessment (🔴 Not Started)

*Findings to be added after research is conducted.*

---

## 💡 Key Insights (So Far)

- [x] **1-PR workflow made phase docs ceremonial.** When phases don't map to PRs, phase documents lose their primary function.
- [x] **Command-simplification proved the flat model works.** No phase files, phases inline, feature completed successfully.
- [x] **Status tracking is the proven pattern.** `status-and-next-steps.md` consistently has higher update frequency and richer content than phase files.
- [x] **Refactoring cost is HIGH but necessary.** 9 commands need updating, but the alternative is perpetuating ceremony in every generated project.
- [x] **75% of `/task-phase` is already task-generic.** The rename is primarily path resolution + naming, not a logic rewrite. Lower risk than the 9-command count suggests.
- [x] **Hybrid interface is optimal.** `/task next` for flow, `/task N` for resume, bare `/task` for status. Industry patterns (Taskwarrior, Taskfile) validate this approach.
- [x] **Format B (grouped checkbox) is the winning document format.** Works for 8-task and 40-task features. Trivially parseable. GitHub-compatible. Optional `###` headings replace mandatory phase files.
- [x] **N+3 files collapse to 2 files.** `implementation-plan.md` + `status-and-next-steps.md` replaces `feature-plan.md` + `transition-plan.md` + N `phase-N.md` + `status-and-next-steps.md`.
- [x] **TDD detail is runtime, not planning.** Expand mode can be eliminated -- `/task` manages RED/GREEN/REFACTOR at implementation time.
- [ ] *Additional insights pending from Topic 4.*

---

## 📋 Requirements Summary

**19 Functional Requirements, 7 Non-Functional Requirements, 6 Constraints, 6 Assumptions** extracted so far from Topics 1, 2, 3, and 5.

**See:** [requirements.md](requirements.md) for complete requirements document

---

## 🎯 Recommendations (So Far)

- [x] **Simplify to single planning document** per feature (from Topic 1)
- [x] **Preserve status-and-next-steps.md** pattern (from Topic 1)
- [x] **Use phased deprecation** approach for removing phase-N.md support (from Topic 5)
- [x] **Hybrid `/task` interface** -- `next` for flow, `N` for explicit, bare for status (from Topic 2)
- [x] **Stub `/task-phase`** with deprecation notice; remove in next major version (from Topic 2)
- [x] **Simplify branch/commit naming** -- drop phase numbers from both (from Topic 2)
- [x] **Adopt Format B** -- grouped checkbox list with optional `###` headings (from Topic 3)
- [x] **Name document `implementation-plan.md`** -- replaces feature-plan + transition-plan + phase-N trio (from Topic 3)
- [x] **Keep `status-and-next-steps.md` separate** -- runtime tracking stays distinct from plan (from Topic 3)
- [x] **Eliminate expand mode** -- `/transition-plan` produces one file in one mode (from Topic 3)
- [ ] *Additional recommendations pending from Topic 4.*

---

## 🚀 Next Steps

1. ~~Conduct Topic 2 (Task Command Interface Design)~~ ✅
2. ~~Conduct Topic 3 (Transition Plan Output Format)~~ ✅
3. Conduct Topic 4 (Template Impact Assessment)
4. Synthesize all findings and recommendations
5. Use `/decision workflow-simplification --from-research` when complete

---

**Last Updated:** 2026-02-14
