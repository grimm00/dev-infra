# Plan Review — Skill-Template Separation (Group 5)

**Feature:** skill-template-separation  
**Planning root:** `admin/services/meta/features/skill-template-separation/planning/`  
**Status:** ✅ Ready  
**Reviewed:** 2026-06-09  
**Scope:** Group 5 only  

---

## 📋 Plan Structure

- [x] Implementation plan found and parseable
- [x] YAML frontmatter valid (`task_count: 25`, `groups`, `tasks_files`)
- [x] Every referenced task group file exists on disk
- [x] Checkbox census matches `task_count` (18/25 complete post-PR #109)
- [x] No orphan global task IDs

---

## 📝 Task Group Review

### Group 5: proj-cli Validation (Tasks 19–22)

- **Header status:** 🔴 Scaffolding — needs expansion (expected before Step 1)
- **Task count:** 4 (within 2–8 range)
- **Descriptions:** High-level bullets only; expansion required for TDD steps
- **Dependencies section:** Present — Group 4 prerequisite satisfied (PR #109 merged)

---

## 🔗 Dependency Validation

- [x] No circular dependencies
- [x] Group 5 depends on Group 4 (`expected_skills` in `.dev-infra.yml`) — prerequisite complete
- [x] External prerequisite documented: proj-cli repo (`/Users/cdwilson/Projects/proj-cli`) — implementation target for Tasks 20–21
- [x] Groups 1–4 complete before Group 5 execution

---

## 🔄 Consistency Check

- [x] Plan ↔ Status progress counts align (18/25 after Group 4 closeout)
- [x] Group 4 tasks 15–18 checked in implementation-plan
- [x] Frontmatter `groups[4].tasks: [19,20,21,22]` matches Group 5 task file numbering

---

## 🎓 Prior-stage learning carry-forward

*(Skipped — flat `planning/` layout, no `planning-stage{N}/` predecessor.)*

- [x] PR #109 deferred items acknowledged (`PR109-Overall-#2` → Group 6)
- [x] Bare identifier convention from Group 4 carried into Group 5 design notes

---

## 🔴 Blockers

*(none)*

---

## 🟡 Warnings

- **Cross-repo implementation:** Tasks 20–21 modify `proj-cli` (separate repository), not dev-infra tree. Companion PR required in proj-cli; dev-infra PR carries design, tests (Task 22), and planning updates.
- **Group 5 task file still scaffolding** — must expand before execution (Step 1).

---

## 💡 Recommendations

- Mirror git-init warn-not-error pattern in `proj-cli` `create.py` (post-`create_from_template`, pre-registry).
- Task 22 graceful-degradation test in dev-infra Bats: generate project, assert `.dev-infra.yml` + `AGENTS.md` present, no bundled skills, exit 0.

---

## ✅ Readiness Assessment

**Verdict:** ✅ Ready for Group 5 expansion and execution.

Group 4 manifest is merged. Dependencies satisfied. Cross-repo scope is documented as a warning, not a blocker — ADR-001 explicitly assigns validation to proj-cli.

---

**Reviewed by:** group-cycle agent  
**Next:** Expand `tasks/05-proj-cli-validation.md`, then execute Tasks 19–22
