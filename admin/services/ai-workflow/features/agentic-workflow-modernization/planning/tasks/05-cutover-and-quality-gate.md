# Cutover and Quality Gate

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Cutover and Quality Gate
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-04-24

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan agentic-workflow-modernization --expand --group 5` to add detailed implementation notes.

- [ ] Task 15: Delete converted command files
  - Remove `.cursor/commands/discuss.md`
  - Remove `.cursor/commands/explore.md`
  - Remove `.cursor/commands/int-opp.md`
  - Remove `.cursor/commands/narrative.md`
  - Update template counterparts: `templates/standard-project/.cursor/commands/`, `templates/learning-project/.cursor/commands/` (verify if they exist)
  - Per C2-1: clean cutover, no coexistence wrappers

- [ ] Task 16: Run regression test on discuss skill against recent /discuss usage
  - Invoke the new `/discuss` skill in real scenarios from this very session (rich source material)
  - Compare output quality to the command-era /discuss interactions captured in this session's history
  - Document observed differences (better, worse, neutral)
  - This is the C5-3 quality benchmark check — the explicit go/no-go for Stages 2-4

- [ ] Task 17: Final quality gate sweep across all 5 skills + foundation work; verify Stage 1 exit criteria met
  - Verify Stage 1 exit criteria from design.md Section 5:
    - All 5 skills pass five-property rubric ✓
    - Discuss regression test passes ✓
    - Explore family pattern validated ✓
    - AGENTS.md + CLAUDE.md in place ✓
    - `.mdc` rules slimmed ✓
  - Verify CI passes after cutover
  - Update `admin/services/ai-workflow/features/agentic-workflow-modernization/planning/status-and-next-steps.md` with Stage 1 completion
  - Decide: proceed to Stage 2 (Researcher) or pause for evaluation

---

## 🎯 Goals

1. Complete the clean cutover (C2-1): commands gone, skills in place
2. Validate the C5-3 quality benchmark: discuss skill ≥ discuss command quality
3. Make the Stage 1 → Stage 2 go/no-go decision with evidence

---

## ✅ Completion Criteria

- [ ] All 4 command files deleted (discuss, explore, int-opp, narrative)
- [ ] CI passes
- [ ] Discuss regression test documented (observed quality vs command-era baseline)
- [ ] Stage 1 exit criteria from design.md Section 5 verified
- [ ] Decision logged: proceed to Stage 2, or pause for adjustment
- [ ] Status document updated to reflect Stage 1 completion

---

## 🔗 Dependencies

- Groups 1-4 must all be complete
- Final group; gates the Stage 1 → Stage 2 transition

---

**Last Updated:** 2026-04-24
