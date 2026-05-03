# Decision Skill

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Decision Skill
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan agentic-workflow-modernization --expand --group 1` to add detailed implementation notes.

- [ ] Task 1: Audit decision command and classify behavioral instructions
  - Read `.cursor/commands/decision.md` (632 lines) and classify every instruction against the three precision tiers (Tier 1/2/3)
  - Identify the interview workflow structure: question sequence, ADR template filling, decision-interview.md pattern
  - Produce audit artifact at `planning-stage3/artifacts/decision-command-audit.md`

- [ ] Task 2: Design decision SKILL.md (interview workflow + ADR behavioral contract)
  - Hybrid skill: procedural interview flow + behavioral contract for ADR quality
  - Bake in the interview pattern from this feature's own research (design.md Section 5 calls this out)
  - Apply five-property rubric to all behavioral instructions; populate gotchas
  - Install in `templates/standard-project/.claude/skills/decision/SKILL.md`

- [ ] Task 3: Validate decision skill against a recent ADR produced under the command
  - Static comparison: behavioral coverage, interview flow, ADR quality output
  - Reference artifact: one of ADR-001 through ADR-005 (produced under command era)
  - Document go/no-go verdict in task file's Validation Log

---

## 🎯 Goals

1. Produce the first skill with a structured human-interview workflow
2. Maintain ADR quality — no regression from command-era decisions

---

## ✅ Completion Criteria

- [ ] Audit artifact produced with tier classification
- [ ] decision SKILL.md in templates with interview workflow + ADR contract
- [ ] Five-property rubric passes, gotchas populated
- [ ] Validation log with go/no-go verdict

---

## 🔗 Dependencies

- Stage 2 complete (go decision logged)
- No dependency on other Stage 3 groups

---

**Last Updated:** 2026-05-02
