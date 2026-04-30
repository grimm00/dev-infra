# Topic 5: Command Dependency Analysis - Research Document

**Purpose:** Determine which commands reference phase concepts and define the refactoring scope for workflow simplification  
**Status:** ✅ Complete  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-13

---

## 📋 Quick Links

- **[Workflow Simplification Exploration](../../explorations/workflow-simplification/README.md)** - Parent exploration hub
- **[Research Topics](../../explorations/workflow-simplification/research-topics.md)** - All 5 research topics
- **[Deferred Tasks (Task 56, 57)](../../feedback/deferred-tasks.md)** - Related centralization tasks

---

## 🎯 Research Goal

Determine how deeply "phase" concepts are embedded in commands and rules to inform workflow simplification. The current system uses `feature-plan.md` → `phase-N.md` → tasks. We want to know:

1. Which commands have **hard dependencies** (logic relies on phase structure/files)
2. Which commands have **soft references** (documentation/text only)
3. Which commands would **break** if we removed `phase-N.md` files
4. Which commands would need to be **renamed** (e.g., `/task-phase` → `/task`)

---

## 🔍 Search Methodology

**Searched:**

- `.cursor/commands/*.md` - All 23 command files
- `.cursor/rules/*.mdc` - main.mdc, workflow.mdc, template.mdc
- `scripts/` - template-sync-manifest.txt, doc-gen templates, validation rules

**Search terms:** `phase`, `phase-N`, `feature-plan`, `phase-N.md`, `phase-N-review.md`

---

## 📊 Dependency Matrix

| Command | Dependency Type | Details |
|---------|-----------------|---------|
| **`/task-phase`** | **HARD** | Core logic: reads `phase-N.md` to get tasks, expects `phase-1.md`/`phase-2.md` structure. Branch validation expects `feat/*-phase-N-*`. Updates phase status in `phase-N.md`. Would **BREAK** without phase files. **RENAME candidate.** |
| **`/task-improvement`** | **HARD** | Reads `phase-N.md` from `docs/maintainers/planning/ci/[improvement]/phase-N.md`. Same task-implementation pattern as task-phase. Would **BREAK** without phase files. |
| **`/transition-plan`** | **HARD** | Creates `phase-N.md` scaffolding, expands phases with `--expand --phase N`, parses `phase-*.md` for expansion. Outputs phase documents. Would **BREAK** - it *produces* phase files. |
| **`/pre-phase-review`** | **HARD** | Reads `phase-N.md` and `feature-plan.md`, creates `phase-N-review.md`. Entire purpose is phase document review. Would **BREAK** without phase files. **RENAME candidate.** |
| **`/address-review`** | **HARD** | Reads `phase-N-review.md`, updates `phase-N.md`. Tightly coupled to pre-phase-review workflow. Would **BREAK** without phase files. |
| **`/pr --phase`** | **HARD** | Phase mode: expects `phase-N.md` paths, branch pattern `feat/*-phase-N-*`, validates phase document status. Would **BREAK** phase mode without phase files. |
| **`/post-pr --phase`** | **HARD** | Updates `phase-N.md` status, `status-and-next-steps.md` phase progress. Would **BREAK** phase mode without phase files. |
| **`/pr-validation`** | **HARD** | Reads `phase-N.md` for status validation, checks phase document completeness. Would **BREAK** for phase PRs without phase files. |
| **`/status`** | **HARD** | Reads/writes `phase-N.md` for `--phase-start`, `--phase-complete`, `--task-complete`. Phase-centric status tracking. Would **BREAK** phase operations without phase files. |
| **`/task-release`** | **SOFT** | References `/task-phase` as similar workflow. No direct phase file reads. Would need workflow update if task-phase changes. |
| **`/fix-implement`** | **SOFT** | Example mentions `feat/release-readiness-phase-2`. References `/task-phase` as similar. Fix batches use different structure (`fix/pr##/`). |
| **`/reflect`** | **SOFT** | Template variables `${CURRENT_PHASE}`, `${PHASE_NAME}` in reflection output. Doc-gen templates reference phase. |
| **`/explore`** | **SOFT** | Handoff template examples may reference phase. |
| **`/research`** | **SOFT** | Cross-reference only. |
| **`/decision`** | **SOFT** | May reference phase structure in transition-plan creation. |
| **`/fix-plan`** | **NONE** | No phase references found. |
| **`/review`** | **SOFT** | Mentioned in task-phase workflow. |
| **`/commit`** | **SOFT** | Mentioned in task-phase workflow. |
| **`/int-opp`** | **SOFT** | May document phase learnings. |
| **`/post-release`** | **SOFT** | Release phases (Phase 1, 2, 3 of release process) - different concept. |
| **`/cursor-rules`** | **SOFT** | Documentation. |
| **`/reflection-artifacts`** | **SOFT** | May reference phase in artifact types. |

---

## 📋 Rules Files Dependency Summary

| File | Dependency Type | Details |
|------|-----------------|---------|
| **workflow.mdc** | **HARD** | Defines phase paths, `/pr --phase`, status checklist for `phase-N.md`, pre-phase-review workflow, feature-plan structure with phases. |
| **main.mdc** | **SOFT** | Lists `/task-phase`, `/pre-phase-review`, `/address-review`. File naming examples (`phase-1-foundation.md`). |
| **template.mdc** | **SOFT** | No direct phase/feature-plan references in structure. Learning template uses "stage" not "phase". |

---

## 📋 Scripts / Doc-Gen Dependency Summary

| Location | Dependency Type | Details |
|----------|-----------------|---------|
| **template-sync-manifest.txt** | **HARD** | Lists `pre-phase-review.md`, `task-phase.md` as sync files. |
| **planning.yaml** | **HARD** | Validates `feature-plan.md`, `phase-*.md` structure. Rules: `PHASE_NUMBER`, `PHASE_FEATURE_REF`, scaffolding detection. |
| **planning templates** | **HARD** | `phase.md.tmpl`, `feature-plan.md.tmpl`, `status-and-next-steps.md.tmpl` - produce phase documents. |
| **VARIABLES.md** | **SOFT** | Documents `${PHASE_NUMBER}`, `${PHASE_NAME}`, `${CURRENT_PHASE}`. |
| **handoff.yaml** | **SOFT** | Example: `feat/user-auth-phase-2`. |

---

## 🚨 Commands That Would BREAK

If we removed `phase-N.md` files entirely:

1. **`/task-phase`** - No task source. Core implementation command.
2. **`/task-improvement`** - No task source for CI improvements.
3. **`/transition-plan`** - Produces phase files; expansion logic assumes them.
4. **`/pre-phase-review`** - No document to review.
5. **`/address-review`** - No phase document to update.
6. **`/pr --phase N`** - No phase document for validation/template.
7. **`/post-pr --phase N`** - No phase document to update status.
8. **`/pr-validation`** (phase mode) - No phase document for status check.
9. **`/status`** (phase operations) - No phase documents to read/update.

**Total: 9 commands with hard breakage.**

---

## 📝 Commands That Would Need RENAMING

| Current Name | Rationale |
|--------------|-----------|
| **`/task-phase`** | Name encodes phase concept. If we flatten to "task" or "work item", rename to `/task` or `/task-implement`. |
| **`/pre-phase-review`** | Name encodes phase. Could become `/pre-implementation-review` or `/plan-review`. |
| **`/address-review`** | Not phase-named but tightly coupled to pre-phase-review. May need rename if pre-phase-review changes. |

---

## 🔗 Alignment with Deferred Tasks

**Task 56: Centralize docs-only vs code-phase detection rules**

- **Location:** Duplicated across `/task-phase`, `/task-release`, `/task-improvement`
- **Alignment:** ✅ Directly aligned. Workflow simplification would consolidate these commands or their shared logic. A "shared reference doc" for detection rules fits the simplification scope.

**Task 57: Centralize temp directory path conventions**

- **Location:** Three-path temp directory conventions repeated across multiple commands
- **Alignment:** ✅ Aligned. Path conventions (`docs/maintainers/planning/features/`, `phases/`, `ci/`) are phase-structure-dependent. Simplification may reduce path variants.

---

## 📐 Refactoring Scope Estimate

| Scope | Effort | Rationale |
|-------|--------|-----------|
| **HIGH** | 9 commands + 3 rules + scripts | 9 commands have hard dependencies. Rules and doc-gen templates encode phase structure. Renaming 2-3 commands. |
| **MEDIUM** | Path consolidation, status tracking | Multiple path patterns (feature-specific, project-wide, CI). Status document structure. |
| **LOW** | Soft references | ~10 commands with soft refs; documentation updates. |

**Overall: HIGH effort** - Phase concepts are deeply embedded. A "simplification" that removes phase files would require:

1. **Alternative task source** - Replace `phase-N.md` with something (e.g., flat task list in transition-plan, or new artifact).
2. **9 command refactors** - Logic changes, not just text updates.
3. **Path/structure consolidation** - Reduce feature/phase/ci path variants.
4. **Doc-gen template updates** - planning.yaml, phase.md.tmpl, etc.
5. **Rules updates** - workflow.mdc, main.mdc.

**Mitigation:** A phased approach could:
- **Phase A:** Introduce `/task` as alias, support both phase-N and flat task source (transition-plan sections).
- **Phase B:** Deprecate phase-N for new features; keep for existing.
- **Phase C:** Remove phase-N support after migration.

---

## 📚 Key Findings Summary

1. **9 commands have hard phase dependencies** - They read, write, or validate `phase-N.md` files.
2. **`/task-phase` is the hub** - Most other phase commands orbit around it (pre-phase-review → address-review → task-phase → pr → post-pr).
3. **Three path patterns** - Feature-specific, project-wide, CI improvements. All use `phase-N.md`.
4. **Doc-gen is phase-aware** - planning.yaml validates phase structure; templates produce phase documents.
5. **Deferred Tasks 56 & 57 align** - Centralizing detection rules and path conventions fits simplification scope.

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] **FR-5: Alternative task source required.** If `phase-N.md` is removed, an alternative artifact must provide the ordered task list that `/task` reads from. The transition plan (single document) is the leading candidate.
- [x] **FR-6: 9 commands need refactoring.** `/task-phase`, `/task-improvement`, `/transition-plan`, `/pre-phase-review`, `/address-review`, `/pr`, `/post-pr`, `/pr-validation`, `/status` all have hard dependencies on `phase-N.md` and must be updated to work with the new structure.
- [x] **FR-7: 2-3 commands need renaming.** `/task-phase` → `/task` (or similar), `/pre-phase-review` → `/plan-review` (or similar). `/address-review` may also need renaming.
- [x] **FR-8: Template sync manifest must be updated.** `template-sync-manifest.txt` lists `task-phase.md` and `pre-phase-review.md` as sync files. Renaming these commands requires updating the manifest.
- [x] **FR-9: Doc-gen templates must be updated.** `planning.yaml`, `phase.md.tmpl`, `feature-plan.md.tmpl`, `status-and-next-steps.md.tmpl` encode phase structure and must be replaced or updated.

### Non-Functional Requirements

- [x] **NFR-3: Phased deprecation approach.** Refactoring 9 commands at once is high-risk. A phased approach (introduce new alongside old, deprecate, then remove) reduces risk.
- [x] **NFR-4: Soft references are low-effort.** ~10 commands have soft references (documentation mentions). These are documentation-only updates and can be batched.

### Constraints

- [x] **C-3: Rules files have hard phase dependencies.** `workflow.mdc` defines phase paths, PR phase mode, status checklist for `phase-N.md`, and pre-phase-review workflow. Must be updated in sync with command changes.
- [x] **C-4: Deferred Tasks 56 and 57 should be addressed concurrently.** Centralizing detection rules (Task 56) and temp directory path conventions (Task 57) fits naturally within this refactor scope and avoids duplicate effort.

### Assumptions

- [x] **A-3: `/task-phase` is the hub command.** Most other phase-dependent commands orbit around it (pre-phase-review → address-review → task-phase → pr → post-pr). Refactoring `/task-phase` first unlocks the others.

---

## 🚀 Next Steps

1. **Topic 2 (Task Command Interface Design):** Design the `/task` interface that replaces `/task-phase`.
2. **Topic 3 (Transition Plan Output Format):** Define the flat task source that replaces `phase-N.md`.
3. **Decision:** After all research, determine simplification approach (full removal vs. phased deprecation).
4. **Spike consideration:** `/task-phase` → `/task` rename if flat task model is chosen.

---

**Last Updated:** 2026-02-14  
**Status:** ✅ Complete  
**Next:** Topic 2 (Task Command Interface Design)
