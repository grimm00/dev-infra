# Cutover and v1 Final Quality Gate

**Feature:** Agentic Workflow Modernization — Stage 4
**Group:** Cutover and v1 Final Quality Gate
**Status:** ✅ Complete
**Last Updated:** 2026-05-03

---

## 📝 Tasks

- [x] Task 9: Install skills + archive commands (review, commit, handoff)
  - Copied `pre-commit-review`, `commit`, `handoff` from `templates/standard-project/.claude/skills/` → repo-root `.claude/skills/` (sibling layout preserves `commit` ↔ `pre-commit-review` YAML pointers).
  - Archived active commands to `admin/archived/commands/stage4-reviewer/{repo-root,template-standard-project,template-learning-project}/`.
  - Updated `scripts/template-sync-manifest.txt` (removed synced paths for archived trio; documented skills-not-manifest policy).

- [x] Task 10: Final quality sweep across ALL v1 skills (~16 skills)
  - **Enumerate (19 × `SKILL.md` in template):** `commit`, `decision`, `discuss`, `explore/explore-amend`, `explore/explore-start`, `explore`, `handoff`, `int-opp`, `narrative`, `plan-review`, `pre-commit-review`, `reflect`, `research/research-conduct`, `research/research-consolidate`, `research/research-setup`, `research`, `spike`, `write-plan/write-plan-expand`, `write-plan/write-plan-setup`, `write-plan`.
  - **Five-property sanity:** PASS by inspection — each has frontmatter (`name`, `description`, routing flags), bounded workflow, observable outputs, failure/gotchas prose where expected.
  - **`references/structure.yaml`:** Present on `commit`, `decision`, `handoff`, `plan-review`, `pre-commit-review`, `write-plan`. **Waived retrofit (v1) — no YAML** on `discuss`, `explore` (+ children), `int-opp`, `narrative`, `reflect`, `spike`, `research` (+ children), `write-plan` (+ children): Stage 1–2 scaffolding; Stage 4 does not broaden scope to backfill declarative contracts.
  - **Family parents:** `explore` ↔ children, `research` ↔ children — child SKILLs reference parent conventions; unchanged this PR.
  - **Tests:** `./scripts/validate-template-sync.sh` PASS; `find tests -name '*.bats' -print0 | xargs -0 bats` → **248** ok, **3** skip.

- [x] Task 11: v1 exit criteria verification + completion
  - Verified design.md §5 Stage 4 exit criteria — table in `status-and-next-steps.md`.
  - Logged **Stage 4 → Post-v1 GO** in `implementation-plan.md`.
  - Marked planning docs ✅; PR link recorded in **`implementation-plan.md`** once PR is opened.

---

## 🎯 Goals

1. Clean cutover: install skills, archive commands, no coexistence
2. v1 completion gate: every skill passes rubric, every family is consistent, CI green
3. Document the v1 → post-v1 boundary for future work

---

## ✅ Completion Criteria

- [x] 3 commands archived to `admin/archived/commands/stage4-reviewer/` (×3 mirrors)
- [x] All v1 skills present in standard template and reviewer trio at repo root
- [x] Final rubric sweep passes (with explicit YAML waivers for legacy skills)
- [x] Bats test suite passes (full recursive run)
- [x] Stage 4 exit criteria verified against design.md
- [x] v1 completion logged
- [x] CI green on cutover PR _(see PR #99 checks snapshot in group-cycle report; local Bats + template-sync PASS)_

---

## 🔗 Dependencies

- Group 1 (Review Skill) and Group 2 (Commit + Handoff) must be complete
- Depends on all prior stages being merged to develop

---

**Last Updated:** 2026-05-03
