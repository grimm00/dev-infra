# Cutover and Quality Gate

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Cutover and Quality Gate
**Status:** ✅ Active/Complete
**Last Updated:** 2026-05-03

---

## 📝 Tasks

- [x] Task 13: Install skills + archive commands (decision, write-plan, plan-review)
  - Install skills: copy from `templates/standard-project/.claude/skills/` to root `.claude/skills/`
  - **Archive commands to `admin/archived/commands/`** (NOT `.cursor/commands/archived/` — that path was consolidated; see `chore: consolidate archived docs` commit on develop)
  - Archive in both template directories (standard-project, learning-project) — move `.cursor/commands/{decision,transition-plan,plan-review}.md` to `admin/archived/commands/`
  - Update `scripts/template-sync-manifest.txt`
  - **Verify each skill has the full directory structure:** SKILL.md + `assets/` (where applicable) + `references/structure.yaml`
  - write-plan family: parent + write-plan-setup + write-plan-expand all installed

- [x] Task 14: Verify all Stage 3 skills pass five-property rubric
  - Rubric sweep: observable, bounded, outcome-framed, delta-only, failure-aware
  - Verify gotchas populated in each skill
  - Verify self-containment (FR-8)
  - **Verify `references/structure.yaml` accuracy:** declared output shapes match what the skill actually produces

- [x] Task 15: Final quality gate sweep + Stage 3 exit criteria
  - Verify exit criteria from design.md Section 5: all skills pass quality gate, decision skill includes interview workflow
  - Verify user experience at boundary: full thinking pipeline is skill-based
  - **Verify `assets/` + `references/` convention is consistent** across all Stage 3 skills
  - **Verify write-plan family pattern** is consistent with explore and research families
  - Run `bats tests/` locally
  - Mark Stage 3 complete in status docs
  - Log Stage 3 → Stage 4 decision with evidence

---

## 🎯 Goals

1. Complete the clean cutover (same pattern as Stages 1-2)
2. Verify full thinking pipeline is skill-based (Stage 3 boundary)
3. **Validate the `assets/` + `references/` convention** works across all skills before it becomes the standard for Stage 4
4. Make the Stage 3 → Stage 4 decision with evidence

---

## ✅ Completion Criteria

- [x] Skills installed at root `.claude/skills/` (`decision/`, full `write-plan/` family, `plan-review/`)
- [x] 3 commands archived to `admin/archived/commands/stage3-planner/` (repo root + both templates)
- [x] Template commands removed after archive copy (`standard-project`, `learning-project`)
- [x] `scripts/template-sync-manifest.txt` excludes archived planner command paths (commented)
- [x] CI passes after cutover (GitHub Actions on PR [#96](https://github.com/grimm00/dev-infra/pull/96): quick-checks, ubuntu/macos suites, build-image PASS)
- [x] Stage 3 skills satisfy five-property rubric with populated Gotchas (validated on cutover branch; consistent with Tasks 10–12 / Group 3–4 audits)
- [x] Each Stage 3 skill has `references/structure.yaml`; outputs match SKILL contracts (`decision`, `write-plan` family, `plan-review`)
- [x] write-plan family mirrors explore/research: parent `SKILL.md` + subdirectory children with parent-read preamble
- [x] design.md §5 Stage 3 exit: quality gate satisfied; interview workflow retained in `decision/SKILL.md` + assets
- [x] **Stage 3 → Stage 4 decision:** GO — see `planning-stage3/status-and-next-steps.md` (2026-05-03)
- [x] Bats full suite locally: `find tests -name '*.bats' -print0 | xargs -0 bats` (248 tests, PASS)

---

## 🔗 Dependencies

- Groups 1-4 must all be complete
- Final group; gates the Stage 3 → Stage 4 transition

---

## 📌 Task 14–15 verification notes

- **`references/structure.yaml`:** `decision`, `write-plan`, and `plan-review` declare planning roots / outputs consistent with SKILL “Primary outputs” sections and report naming conventions.
- **FR-8 / self-containment:** Invocations require only SKILL + optional `assets/` / `references/` read — no reliance on archived `.cursor/commands/*.md`.
- **UX boundary:** After cutover (dev-infra + templates), explore/research/decision/write-plan/plan-review are skills; `/review`, `/commit`, `/handoff` remain commands per design.md Stage 4 entry.

---

**Last Updated:** 2026-05-03
