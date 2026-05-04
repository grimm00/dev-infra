# Review Skill

**Feature:** Agentic Workflow Modernization — Stage 4
**Group:** Review Skill
**Status:** ✅ Complete
**Last Updated:** 2026-05-03

---

## 📝 Tasks

- [x] Task 1: Audit review command and classify behavioral instructions
  - Classify review.md (334 lines) against the five-property rubric
  - Separate procedural steps (file identification, staging, artifact capture) from behavioral guidance (what to look for, when to stop)
  - Produce audit artifact at `planning-stage4/artifacts/review-command-audit.md`

- [x] Task 2: Convert review to SKILL.md (hybrid: procedural staging + behavioral diff analysis)
  - Create `templates/standard-project/.claude/skills/pre-commit-review/SKILL.md`
  - Extract summary.md template into `assets/summary-template.md`
  - Create `references/structure.yaml` declaring review artifact output shape
  - Preserve the core behavioral contract: STOP after presenting review, never auto-commit
  - Retain path detection logic (dev-infra / template / lightweight) as procedural steps

- [x] Task 3: Validate review skill against review artifact patterns
  - Verify five-property rubric compliance
  - Confirm `references/structure.yaml` accurately declares review outputs
  - Cross-check that review's behavioral "stop" contract is explicit and unambiguous

---

## 🎯 Goals

1. Produce a hybrid skill that preserves the review-then-commit pause as an explicit behavioral contract
2. Extract the summary.md template into `assets/` per Stage 3 convention
3. Declare review's output shape in `structure.yaml` so commit can reference it

---

## ✅ Completion Criteria

- [x] Audit artifact produced
- [x] pre-commit-review SKILL.md passes five-property rubric
- [x] `assets/` and `references/structure.yaml` present and accurate
- [x] "Never auto-commit" behavioral contract preserved

---

## 🔗 Dependencies

- None (Group 1 — first group in Stage 4)
- Inherits conventions from Stage 3: `assets/` + `references/structure.yaml`, five-property rubric, archival path

---

**Last Updated:** 2026-05-03
