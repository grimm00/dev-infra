# Plan-Review Skill

**Feature:** Agentic Workflow Modernization (Stage 3: Planner)
**Group:** Plan-Review Skill
**Status:** ✅ Active/Complete
**Last Updated:** 2026-05-03

---

## 📝 Tasks

- [x] Task 11: Audit plan-review command and classify behavioral instructions
  - Read `.cursor/commands/plan-review.md` (416 lines)
  - Classify instructions against precision tiers
  - Produce audit artifact at `planning-stage3/artifacts/plan-review-command-audit.md`
  - Key gap to address: path detection doesn't support `planning-stageN/` directories
  - **Identify checklist/reference content** that belongs in `assets/` or `references/`

- [x] Task 12: Convert plan-review to SKILL.md
  - **Skill directory structure:**
    ```
    skills/plan-review/
    ├── SKILL.md                          # behavioral contract + review workflow
    ├── assets/
    │   └── review-checklist.md           # copyable checklist template (if applicable)
    └── references/
        └── structure.yaml               # declares inputs, review dimensions, output shape
    ```
  - Must support staged planning directories (`planning-stage1/`, `planning-stage2/`, etc.)
  - `references/structure.yaml` must declare: expected input structure (plan + prior stage artifacts), review dimensions, output format
  - **Prior-learnings carry-forward:** the skill must explicitly check whether a new stage's plan accounts for learnings from the prior stage (narratives, PR feedback, spike findings)
  - Apply five-property rubric; populate gotchas
  - Install in `templates/standard-project/.claude/skills/plan-review/SKILL.md`

---

## 🎯 Goals

1. Complete the Planner role group with a review skill that catches cross-stage gaps
2. Fix the path detection limitation (staged planning directories)
3. Ensure plan-review enforces prior-learnings carry-forward at stage boundaries
4. **Adopt the `assets/` + `references/` convention** established by write-plan (Group 2) and validated by Group 3

---

## ✅ Completion Criteria

- [x] Audit artifact with tier classification
- [x] plan-review SKILL.md in templates with rubric pass and gotchas
- [x] Staged planning path support (`planning-stageN/`)
- [x] `references/structure.yaml` with input/output schema
- [x] Self-containment (FR-8) verified

---

## 🔗 Dependencies

- Benefits from patterns established in Groups 1-3
- **Depends on Group 3:** family pattern and assets/references convention finalized for write-plan and decision
- No hard dependency on Group 1

---

**Last Updated:** 2026-05-03
