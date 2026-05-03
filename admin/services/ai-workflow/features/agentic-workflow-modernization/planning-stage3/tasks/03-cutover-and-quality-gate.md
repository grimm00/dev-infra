# Cutover and Quality Gate

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Cutover and Quality Gate
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/write-plan agentic-workflow-modernization --expand --group 3` to add detailed implementation notes.

- [ ] Task 8: Install skills + archive commands (decision, write-plan)
  - Same pattern as Stage 1-2 cutover: copy from templates to root `.claude/skills/`, archive commands to `.cursor/commands/archived/`
  - Archive in both template directories (standard-project, learning-project)
  - Update `scripts/template-sync-manifest.txt`
  - plan-review is **not** archived — it remains a live command (deferred from this stage)

- [ ] Task 9: Verify all Stage 3 skills pass five-property rubric
  - Rubric sweep: observable, bounded, outcome-framed, delta-only, failure-aware
  - Verify gotchas populated in each skill
  - Verify self-containment (FR-8)

- [ ] Task 10: Final quality gate sweep + Stage 3 exit criteria
  - Verify exit criteria from design.md Section 5 (adjusted: plan-review deferred)
  - decision skill includes interview workflow
  - Run `bats tests/` locally
  - Mark Stage 3 complete in status docs
  - Log Stage 3 → Stage 4 decision with evidence

---

## 🎯 Goals

1. Complete the clean cutover (same pattern as Stages 1-2)
2. Make the Stage 3 → Stage 4 decision with evidence

---

## ✅ Completion Criteria

- [ ] Skills installed at root `.claude/skills/`
- [ ] 2 commands archived (decision, transition-plan)
- [ ] Template commands archived
- [ ] CI passes after cutover
- [ ] All skills pass rubric sweep
- [ ] Stage 3 exit criteria verified
- [ ] Stage 3 → Stage 4 decision logged

---

## 🔗 Dependencies

- Groups 1-2 must all be complete
- Final group; gates the Stage 3 → Stage 4 transition

---

**Last Updated:** 2026-05-02
