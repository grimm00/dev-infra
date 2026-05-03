# Write-Plan Skill

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Write-Plan Skill
**Status:** ✅ Expanded
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [x] Task 4: Audit transition-plan command modes and classify behavioral instructions
  - **Purpose:** Evidence for decomposition and template extraction before SKILL work.
  - **Steps:**
    1. Read `.cursor/commands/transition-plan.md` end-to-end; map Setup vs Expand vs shared regions.
    2. Classify major sections per ADR-004 tiers; flag template fences for `assets/`.
    3. Estimate behavioral overlap between modes (sequential pipeline vs independent workflows).
    4. Write `planning-stage3/artifacts/transition-plan-command-audit.md`.
  - **Files:** `planning-stage3/artifacts/transition-plan-command-audit.md`
  - **Acceptance:** Artifact has mode matrix, tier table, template inventory, five-property notes.

- [x] Task 5: Resolve decomposition — single skill vs family
  - **Purpose:** Close design.md Section 6 open question with data.
  - **Steps:**
    1. Apply audit heuristic: shared **contract** (paths, YAML, output shape) vs mode-specific steps.
    2. Compare to research family rationale (independent lifecycles vs sequential phases).
    3. Record decision + rationale below (**Decomposition decision**).
  - **Files:** This section + audit recommendation (cross-check).
  - **Acceptance:** Single vs family stated; references audit; aligns with Task 6 layout.

- [x] Task 6: Convert transition-plan command to write-plan SKILL.md(s) per decomposition decision
  - **Purpose:** Ship portable skill with `assets/` + `references/structure.yaml`.
  - **Steps:**
    1. Add `templates/standard-project/.claude/skills/write-plan/SKILL.md` (Setup + Expand, input modes including `from_design`).
    2. Add `assets/implementation-plan.md`, `assets/status-and-next-steps.md`, `assets/task-group-skeleton.md` from command templates.
    3. Add `references/structure.yaml` (inputs, planning roots including `planning-stageN/`, outputs).
    4. Apply five-property rubric; populate gotchas (≥6).
  - **Files:** `templates/standard-project/.claude/skills/write-plan/**`
  - **Acceptance:** Directory matches convention; no 800-line template paste inside SKILL.

- [x] Task 7: Validate write-plan skill against Stage 3's own scaffolding
  - **Purpose:** Meta-test that the skill could reproduce this stage’s planning tree shape.
  - **Steps:**
    1. Compare `assets/*` to `planning-stage3/implementation-plan.md`, `status-and-next-steps.md`, and group file headers.
    2. Cross-check `references/structure.yaml` to actual dirs (`tasks/`, singletons, `planning-stage3` note).
    3. Record **Validation Log** verdict.
  - **Files:** This task file (Validation Log)
  - **Acceptance:** GO/NO-GO with concrete file references.

---

## 🎯 Goals

1. Resolve the write-plan decomposition open question with evidence
2. Convert the largest Stage 3 command without quality loss
3. **Establish the `assets/` + `references/` skill directory convention** — write-plan is the ideal first adopter because it's the most template-heavy skill
4. Meta-validate: the skill should be able to produce what the command produced for this stage

---

## ✅ Completion Criteria

- [x] Audit artifact with mode mapping, tier classification, and template inventory
- [x] Decomposition decision documented with rationale
- [x] SKILL.md in templates with rubric pass and gotchas
- [x] `assets/` directory with copyable templates
- [x] `references/structure.yaml` with output schema
- [x] Validation log with meta-test verdict

---

## Decomposition decision (Task 5)

**Verdict:** **Single skill:** `write-plan` with two workflows (**Setup** and **Expand**) in one `SKILL.md`.

**Evidence (from audit):**
- Setup-only and Expand-only *steps* split roughly 40% / 22% of instruction units, with ~38% shared tables and contracts — raw counts alone suggest a family, but the **shared rubric surface** (path roots, frontmatter validity, file naming, error classes) is what agents must not get wrong in either phase.
- Expand **depends** on Setup artifacts; the modes are **sequential phases** of one capability, unlike **research** (research-setup / research-conduct / research-consolidate as separable invocations).

**design.md §6:** “May decompose into write-plan-setup and write-plan-expand, or stay single if modes are thin enough” — modes are **thick in prose** but **thin as separate products**; a family would duplicate structure.yaml and path rules or force a parent read for every child, yielding little clarity gain.

**If we chose family anyway:** Parent + two children with `read ../SKILL.md` pattern — **deferred** unless product feedback demands separate invocations.

---

## 📋 Validation Log (Task 7)

**Date:** 2026-05-02  
**Reference tree:** `planning-stage3/`

| Check | Result | Notes |
|-------|--------|-------|
| `implementation-plan.md` shape vs `assets/implementation-plan.md` | Pass | Same frontmatter keys, overview + goals + checkbox sections + Definition of Done; Stage 3 file has extra “Related” block — skill template includes Related placeholder. |
| `status-and-next-steps.md` vs asset | Pass | Progress table + Next Steps + Notes pattern matches; Stage 3 uses emoji status columns consistent with template. |
| Group file scaffold vs `task-group-skeleton.md` | Pass | `tasks/03-plan-review-skill.md` still on scaffolding banner (not yet expanded) — matches pre-expand skeleton intent; expanded groups match post-expand expectation. |
| `references/structure.yaml` | Pass | Declares `tasks/`, singletons, `planning-stageN/` note, input_modes including `from_design`. |
| SKILL self-containment (FR-8) | Pass | Core workflows readable without reading `.cursor/commands/transition-plan.md`; command referenced only as “archived” pointer. |

**Verdict:** **GO**

**Rationale:** Assets and YAML describe the Stage 3 tree; minor optional sections (extra Related links) are placeholders in assets and acceptable variance. Live regeneration would need source content (ADRs/design); static structural parity holds.

---

## 🔗 Dependencies

- No hard dependency on Group 1 (decision), but shared audit patterns apply
- **Group 1 follow-up:** decision skill template extraction into `assets/` (Group 2 convention establishes pattern; decision work deferred per Group 1 task file)

---

**Last Updated:** 2026-05-02
