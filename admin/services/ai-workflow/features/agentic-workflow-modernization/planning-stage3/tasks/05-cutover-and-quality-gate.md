# Cutover and Quality Gate

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Cutover and Quality Gate
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/write-plan agentic-workflow-modernization --expand --group 5` to add detailed implementation notes.

- [ ] Task 13: Install skills + archive commands (decision, write-plan, plan-review)
  - Same pattern as Stage 1-2 cutover: copy from templates to root `.claude/skills/`, archive commands to `.cursor/commands/archived/`
  - Archive in both template directories (standard-project, learning-project)
  - Update `scripts/template-sync-manifest.txt`
  - **Verify each skill has the full directory structure:** SKILL.md + `assets/` (where applicable) + `references/structure.yaml`
  - write-plan family: parent + write-plan-setup + write-plan-expand all installed

- [ ] Task 14: Verify all Stage 3 skills pass five-property rubric
  - Rubric sweep: observable, bounded, outcome-framed, delta-only, failure-aware
  - Verify gotchas populated in each skill
  - Verify self-containment (FR-8)
  - **Verify `references/structure.yaml` accuracy:** declared output shapes match what the skill actually produces

- [ ] Task 15: Final quality gate sweep + Stage 3 exit criteria
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

- [ ] Skills installed at root `.claude/skills/`
- [ ] 3 commands archived (decision, transition-plan, plan-review)
- [ ] Template commands archived
- [ ] CI passes after cutover
- [ ] All skills pass rubric sweep
- [ ] All skills have `references/structure.yaml`
- [ ] write-plan family structure matches explore/research patterns
- [ ] Stage 3 exit criteria verified
- [ ] Stage 3 → Stage 4 decision logged

---

## 🔗 Dependencies

- Groups 1-4 must all be complete
- Final group; gates the Stage 3 → Stage 4 transition

---

**Last Updated:** 2026-05-02
