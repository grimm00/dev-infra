# Transition-Plan Skill

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Transition-Plan Skill
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan agentic-workflow-modernization --expand --group 2` to add detailed implementation notes.

- [ ] Task 4: Audit transition-plan command modes and classify behavioral instructions
  - Read `.cursor/commands/transition-plan.md` (820 lines — largest Stage 3 command)
  - Map setup mode vs expand mode: identify shared logic, mode-specific logic, mode boundaries
  - Classify instructions against precision tiers; note which are mode-specific
  - Produce audit artifact at `planning-stage3/artifacts/transition-plan-command-audit.md`

- [ ] Task 5: Resolve decomposition — single skill vs family
  - design.md Section 6 open question: "may decompose into transition-plan-setup and transition-plan-expand, or stay single if modes are thin enough"
  - Use audit data: if modes share <30% behavioral instructions, family pattern (like research); if >70% shared, single skill with mode sections
  - Document decision with rationale in task file

- [ ] Task 6: Convert transition-plan to SKILL.md(s) per decomposition decision
  - If single: `templates/standard-project/.claude/skills/transition-plan/SKILL.md`
  - If family: parent + `transition-plan-setup/SKILL.md` + `transition-plan-expand/SKILL.md`
  - Apply five-property rubric; populate gotchas
  - Consider `--from-design` as a natural input mode addition (this stage used design.md as input)

- [ ] Task 7: Validate transition-plan skill against Stage 3's own scaffolding
  - Meta-test: this stage's planning was created using the command; validate the skill can produce equivalent output
  - Static comparison of scaffolding capabilities
  - Document verdict in task file's Validation Log

---

## 🎯 Goals

1. Resolve the transition-plan decomposition open question with evidence
2. Convert the largest Stage 3 command without quality loss
3. Meta-validate: the skill should be able to produce what the command produced for this stage

---

## ✅ Completion Criteria

- [ ] Audit artifact with mode mapping and tier classification
- [ ] Decomposition decision documented with rationale
- [ ] SKILL.md(s) in templates with rubric pass and gotchas
- [ ] Validation log with meta-test verdict

---

## 🔗 Dependencies

- No hard dependency on Group 1 (decision), but shared audit patterns apply
- Decomposition decision (Task 5) gates Task 6

---

**Last Updated:** 2026-05-02
