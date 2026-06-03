# Plan Review — Skill-Template Separation (Group 2)

**Feature:** skill-template-separation  
**Planning root:** `admin/services/meta/features/skill-template-separation/planning/`  
**Status:** ✅ Ready  
**Reviewed:** 2026-06-03  
**Scope:** Group 2 only (Tasks 6–10)

---

## 📋 Plan Structure

- [x] Implementation plan found and parseable
- [x] YAML frontmatter valid (`task_count: 25`, `groups`, `tasks_files`)
- [x] Every referenced task group file exists on disk
- [x] Checkbox census: Group 1 complete (5/5); Group 2 pending (0/5) — consistent with PR #106 merge
- [x] No orphan global task IDs for Group 2 range

---

## 📝 Task Group Review

### Group 2: Template Cleanup (Tasks 6–10)

- **Header status:** 🔴 Scaffolding → expanded in this cycle
- **Task count:** 5 (within 2–8 band)
- **Descriptions:** Adequate after expansion (TDD absence tests, explicit paths)
- **Dependencies section:** Group 1 complete on `develop` via PR #106 — prerequisite satisfied

---

## 🔗 Dependency Validation

- [x] No circular dependencies
- [x] Group 2 references only Group 1 (complete)
- [x] Group 3 (manifest retirement) correctly deferred — expect `validate-template-sync` to fail until Group 3; not a Group 2 blocker for scoped tests
- [x] Template README/doc prose updates deferred to Group 6 per implementation plan

---

## 🔄 Consistency Check

- [x] `status-and-next-steps.md` updated post–PR #106 (Group 1 ✅)
- [x] Task titles 6–10 align with `implementation-plan.md` checkboxes
- [x] `develop` still contains bundled `.claude/skills/` and `.cursor/commands/` under templates — Group 2 work is substantive, not a no-op

---

## 🎓 Prior-stage learning carry-forward

- [x] Group 1 decision: Strategy (c) for research links — no change required for Group 2
- [x] PR #106 Sourcery: absolute-path sweep deferred (`admin/feedback/deferred-tasks.md`) — out of scope
- [x] `template-sync-manifest.txt` still lists `.cursor/commands/*` — Group 3 owns retirement

---

## 🔴 Blockers

*(none)*

---

## 🟡 Warnings

- **CI coupling:** Removing template `.cursor/commands/` before Group 3 retires `template-sync-manifest.txt` will fail `validate-template-sync` until Group 3 lands. Mitigation: run scoped Bats (`template-bundled-tooling.bats`, `new-project.bats`) for Group 2 verification; full green CI expected after Group 3.

---

## 💡 Recommendations

- Expand `02-template-cleanup.md` with explicit inventory commands and TDD task ordering (audit → delete → Bats RED → GREEN).
- Add `tests/unit/template-bundled-tooling.bats` rather than overloading `new-project.bats` alone.

---

## ✅ Readiness Assessment

**Verdict:** ✅ Ready to execute Group 2 on `feat/skill-template-separation-02-template-cleanup`.

**Next:** Expand task file → remove bundled trees → add absence tests → one commit per task per group-cycle convention.
