# Research Child Skills

**Feature:** Agentic Workflow Modernization (Stage 2: Researcher)
**Group:** Research Child Skills
**Status:** ✅ Expanded
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [x] Task 4: Convert research-conduct (most complex hybrid skill)
  - **Purpose:** Replace `/research --conduct` with a child skill that keeps web research, documentation updates, and requirement extraction behind one observable behavioral contract (Tier 2 gaps from the audit tightened to Tier 1 where possible).
  - **Steps:**
    1. Read `planning-stage2/artifacts/research-command-audit.md` (Conduct rows) and Conduct Mode Workflow in `.cursor/commands/research.md`.
    2. Author `research/research-conduct/SKILL.md` with `read ../SKILL.md` preamble, procedural flow (identify scope → web research → fill docs → status → summary/requirements → hub → commit).
    3. Bound judgment-heavy areas: topic ordering (hub Priority column), query formulation (minimum queries tied to question / sub-questions / methodology).
    4. Add **Behavioral Contract** and **Gotchas**; every behavioral line MUST satisfy the five-property rubric (observable, bounded, outcome-framed, delta-only, failure-aware).
  - **Files:** `templates/standard-project/.claude/skills/research/research-conduct/SKILL.md`
  - **Acceptance:** Skill mirrors command conduct flow; web search mandatory; no setup/consolidate steps; rubric passes; gotchas populated from audit + command tips.

- [x] Task 5: Convert research-consolidate (procedural with merge logic)
  - **Purpose:** Replace `/research --consolidate` with a child skill that preserves human gates, replaces “mental model” with explicit tables, and keeps merge/remove/add/renumber logic reviewable.
  - **Steps:**
    1. Read audit Consolidate rows and Consolidate Mode Workflow in `.cursor/commands/research.md`.
    2. Author `research/research-consolidate/SKILL.md` with reconciliation → coverage tables → analysis → proposal STOP → apply → summary → commit.
    3. Replace implicit lineage (audit G4 / Tier 3) with required **Requirement lineage** and **Finding coverage** tables before analysis.
    4. Support `--dry-run` / natural-language “show proposal only”: present consolidation proposal without mutating `requirements.md`.
    5. Add **Behavioral Contract** and **Gotchas**; five-property rubric on behavioral instructions.
  - **Files:** `templates/standard-project/.claude/skills/research/research-consolidate/SKILL.md`
  - **Acceptance:** Preconditions match command; two STOP gates preserved; dry-run behavior documented; rubric passes.

- [ ] Task 6: Verify research-add-topic belongs in research-setup or warrants separate skill
  - **Purpose:** Close design.md open question with an explicit, documented placement decision.
  - **Steps:**
    1. Re-read add-topic workflow in `research-setup` and Add Topic rows in the audit (A1–A3).
    2. Decide: separate skill vs keep embedded.
  - **Files:** Rationale recorded in **Task 6 decision** below (no new skill unless warranted).
  - **Acceptance:** Decision states placement + rationale; parent/children references stay consistent.

- [ ] Task 7: Validate research family pattern works end-to-end
  - **Purpose:** Smoke the v1 family: parent orientation → setup → conduct → consolidate; CP-1 (children reference parent).
  - **Steps:**
    1. Read `research/SKILL.md`, `research-setup/SKILL.md`, `research-conduct/SKILL.md`, `research-consolidate/SKILL.md`.
    2. Confirm parent lists children and pipeline; each child starts with `read ../SKILL.md`; conduct does not duplicate setup/add-topic; consolidate does not duplicate conduct.
    3. *(Human / Cursor)* Optional: invoke skills with attachment in IDE per project workflow — record result in validation log below.
  - **Files:** Validation log in this document (**Task 7 validation log**).
  - **Acceptance:** All automated checks in the log pass; optional manual line noted honest (completed or deferred to human).

---

## 🎯 Goals

1. Convert the two most complex research modes (conduct and consolidate)
2. Resolve the research-add-topic placement question (design.md open question)
3. Validate the full research family works as a cohesive pipeline

---

## ✅ Completion Criteria

- [x] research-conduct passes five-property rubric
- [x] research-consolidate passes five-property rubric
- [ ] research-add-topic placement decided with documented rationale
- [ ] Full family flow tested: setup → conduct → consolidate
- [ ] All children reference parent correctly

---

## 🔗 Dependencies

- Group 1 (Research Family Foundation) must be complete
- Task 1 audit informs all conversions in this group

---

**Last Updated:** 2026-05-02
