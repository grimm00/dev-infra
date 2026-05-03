# Plan-Review Skill

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Plan-Review Skill
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/write-plan agentic-workflow-modernization --expand --group 3` to add detailed implementation notes.

- [ ] Task 8: Audit plan-review command and classify behavioral instructions
  - Read `.cursor/commands/plan-review.md` (416 lines)
  - Classify instructions against precision tiers
  - Produce audit artifact at `planning-stage3/artifacts/plan-review-command-audit.md`
  - Key gap to address: path detection doesn't support `planning-stageN/` directories

- [ ] Task 9: Convert plan-review to SKILL.md
  - Procedural skill — review checklist with prior-learnings integration
  - Must support staged planning directories (`planning-stage1/`, `planning-stage2/`, etc.)
  - Apply five-property rubric; populate gotchas
  - Install in `templates/standard-project/.claude/skills/plan-review/SKILL.md`

---

## 🎯 Goals

1. Complete the Planner role group with a review skill that catches cross-stage gaps
2. Fix the path detection limitation (staged planning directories)
3. Ensure plan-review enforces prior-learnings carry-forward at stage boundaries

---

## ✅ Completion Criteria

- [ ] Audit artifact with tier classification
- [ ] plan-review SKILL.md in templates with rubric pass and gotchas
- [ ] Staged planning path support (`planning-stageN/`)
- [ ] Self-containment (FR-8) verified

---

## 🔗 Dependencies

- Benefits from patterns established in decision and write-plan conversions (Groups 1-2)
- No hard dependency on Groups 1-2

---

**Last Updated:** 2026-05-02
