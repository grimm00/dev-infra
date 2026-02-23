# Verification

**Feature:** Workflow Simplification
**Group:** Verification
**Status:** 🔴 Not Started
**Last Updated:** 2026-02-19

---

## 📝 Tasks

- [ ] Task 17: Verify standard-project generation and new feature workflow (create feature, plan, implement).
  - Generate a new project with `new-project.sh`
  - Create a test feature using `/transition-plan`
  - Verify `implementation-plan.md` + `tasks/` structure is generated
  - Run `/task next` to verify task execution flow
  - Validate with `dt-doc-validate` (or manual check against planning.yaml rules)

- [ ] Task 18: Verify learning-project generation (regression test to ensure stages are unaffected).
  - Generate a new learning project with `new-project.sh`
  - Verify stage directories (`stage0-fundamentals`, `stage1-topic`, etc.) are intact
  - Verify planning structure uses new uniform layout
  - Run existing bats tests to confirm no regressions (NFR-10)

---

## 🔗 Dependencies

- Tasks 17-18 depend on all previous groups being complete

---

**Last Updated:** 2026-02-19
