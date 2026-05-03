# Cutover and Quality Gate

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Cutover and Quality Gate
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/write-plan agentic-workflow-modernization --expand --group 4` to add detailed implementation notes.

- [ ] Task 10: Install skills + archive commands (decision, write-plan, plan-review)
  - Same pattern as Stage 1-2 cutover: copy from templates to root `.claude/skills/`, archive commands to `.cursor/commands/archived/`
  - Archive in both template directories (standard-project, learning-project)
  - Update `scripts/template-sync-manifest.txt`

- [ ] Task 11: Verify all Stage 3 skills pass five-property rubric
  - Rubric sweep: observable, bounded, outcome-framed, delta-only, failure-aware
  - Verify gotchas populated in each skill
  - Verify self-containment (FR-8)

- [ ] Task 12: Final quality gate sweep + Stage 3 exit criteria
  - Verify exit criteria from design.md Section 5: all skills pass quality gate, decision skill includes interview workflow
  - Verify user experience at boundary: full thinking pipeline is skill-based
  - Run `bats tests/` locally
  - Mark Stage 3 complete in status docs
  - Log Stage 3 → Stage 4 decision with evidence

---

## 🎯 Goals

1. Complete the clean cutover (same pattern as Stages 1-2)
2. Verify full thinking pipeline is skill-based (Stage 3 boundary)
3. Make the Stage 3 → Stage 4 decision with evidence

---

## ✅ Completion Criteria

- [ ] Skills installed at root `.claude/skills/`
- [ ] 3 commands archived
- [ ] Template commands archived
- [ ] CI passes after cutover
- [ ] All skills pass rubric sweep
- [ ] Stage 3 exit criteria verified
- [ ] Stage 3 → Stage 4 decision logged

---

## 🔗 Dependencies

- Groups 1-3 must all be complete
- Final group; gates the Stage 3 → Stage 4 transition

---

**Last Updated:** 2026-05-02
