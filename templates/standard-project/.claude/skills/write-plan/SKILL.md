---
name: write-plan
description: >-
  Create or expand implementation planning documents (implementation-plan.md,
  status-and-next-steps.md, tasks/) from ADRs, artifacts, reflection output, or
  design docs. Setup mode scaffolds the tree; Expand mode deepens one task group.
  Use when the user wants /transition-plan, planning scaffolding, or to expand a
  planning group. Read references/structure.yaml for output shape; copy templates
  from assets/ rather than inventing filenames.
disable-model-invocation: true
---

# Write-Plan

Replace the `/transition-plan` command with a **two-phase skill**: **Setup**
(scaffold planning tree) and **Expand** (add detail to one group file). Both
phases share path detection, YAML frontmatter rules, and output layout — see
`references/structure.yaml`.

---

## When to use

- After decisions or design work and the user wants an actionable task plan.
- User says `/transition-plan`, “scaffold implementation plan”, “expand group N”.
- Staged work needs `planning/…` or `planning-stageN/…` under a feature.

## When not to use

- No source material (ADR, artifact, reflection, or design) agreed — gather
  inputs first.
- Only code changes, no planning tree — use implementation tasks, not this skill.

---

## Path detection

Pick **one** planning root and use it for the whole invocation:

| Layout | Planning root |
|--------|----------------|
| Dev-infra feature | `admin/services/[service]/features/[feature]/` + **`planning/`** or **`planning-stage{N}/`** |
| Template maintainer | `docs/maintainers/planning/features/[feature]/` |

**Staged planning:** If the feature already uses `planning-stage2/`, `planning-stage3/`, etc., create **sibling** directories — do not silently merge into an old stage without user confirmation.

**Detection:** If `admin/services/` applies, prefer feature-local paths. Otherwise use maintainer docs layout. Document the chosen subdirectory in `status-and-next-steps.md` Notes.

---

## Preconditions (stop if unmet)

1. **Topic / feature name** is known or inferable from context.
2. **Input mode** identified: `from_adr` | `from_artifacts` | `from_reflection` | `from_design`.
3. Source paths exist and are readable.

---

## Input modes

| Mode | Read |
|------|------|
| **from_adr** | ADR files under `decisions/…`; optional `research/…/requirements.md` |
| **from_artifacts** | Given artifact (checklist, handoff doc, transition brief) |
| **from_reflection** | Reflection doc; if project expects generated artifacts first, surface that dependency |
| **from_design** | `design.md` or Section excerpts: goals, stages, open questions → task groups |

Extract: decisions, requirements, success criteria, constraints, and suggested group boundaries.

---

## Setup workflow

**Goal:** Create `implementation-plan.md`, `status-and-next-steps.md`, and
`tasks/NN-group-slug.md` skeletons.

1. **Load sources** per Input modes above.
2. **Choose transition type:** feature (default), release (source path or content mentions release/version), or ci-cd if pipeline-only scope.
3. **Organize task groups:** 2–8 tasks per group; **global** task numbering 1…N across all groups; kebab-case group filenames.
4. **Author `implementation-plan.md`:**
   - YAML frontmatter: `task_count`, `groups` (name, file, task ids), `tasks_files`.
   - Body: checkbox list matching `task_count` exactly. See `assets/implementation-plan.md`.
5. **Author `status-and-next-steps.md`:** progress table + next steps. See `assets/status-and-next-steps.md`.
6. **Author each `tasks/NN-….md`:** copy `assets/task-group-skeleton.md`; fill titles and one-line hints only (**no** long TDD blocks yet). Header `**Status:** 🔴 Scaffolding (needs expansion)`.
7. **Commit guidance:** suggest `docs([feature]): …` or project convention; do not require dev-infra-specific branch polish unless the repo uses it.

---

## Expand workflow

**Goal:** One group file gains detailed steps, acceptance criteria, and files.

**Trigger:** User specifies group index (1-based) or group name; optional `--all` for small plans only.

1. **Locate group file** from frontmatter `groups[].file`.
2. **Verify status** is scaffolding. If already `✅ Expanded`, skip or re-expand only on explicit request.
3. **Classify group type** for order of detail:
   | Type | Order |
   |------|-------|
   | Code + tests | RED → GREEN → REFACTOR in task text |
   | Scripts | tests → script → integration |
   | Docs / planning only | outline → link → verify |
4. **Rewrite each task** with Purpose, Steps/TDD, Files, Acceptance.
5. **Update header:** `**Status:** ✅ Expanded`; remove scaffolding banner.
6. **Commit** with a scoped message describing the expanded group.

---

## Behavioral contract

- **Observable:** Every task checkbox in `implementation-plan.md` maps to exactly one row in a group file; filenames match `tasks_files`.
- **Bounded:** If multiple features match, **stop** and ask which `feature/` directory; do not guess across unrelated features.
- **Outcome-framed:** Deliver files under the chosen planning root; use templates in `assets/`.
- **Delta-only:** Do not paste full multi-hundred-line templates into chat — **copy from `assets/`** on disk.
- **Failure-aware:** Missing requirements, missing source, or existing `implementation-plan.md` → surface options (abort, new stage dir, `--force` if project allows).

---

## Gotchas

1. **Frontmatter must match body:** `task_count` equals checkbox count; `groups[].tasks` partition 1…N.
2. **Expand is not Setup:** never delete `implementation-plan.md` when expanding a group.
3. **`from_reflection` chaining** may depend on another workflow producing artifacts — call that out instead of inventing content.
4. **Release transitions** reuse the **same file shapes**; only grouping semantics change.
5. **`--all` expand** is context-heavy — prefer one group at a time for N > 3 groups.
6. **Staged dirs:** dev-infra Stage 3 uses `planning-stage3/` not `planning/`; mirror sibling pattern the feature already uses.

---

## Related

- **decision** — upstream ADRs.
- **plan-review** — validate plan before execution.
- Source command archived in dev-infra: `.cursor/commands/transition-plan.md`.

---

**Canonical shape:** `references/structure.yaml`  
**Copyable templates:** `assets/implementation-plan.md`, `assets/status-and-next-steps.md`, `assets/task-group-skeleton.md`
