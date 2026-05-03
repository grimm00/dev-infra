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
  - **Identify checklist/reference content** that belongs in `assets/` or `references/`

- [ ] Task 9: Convert plan-review to SKILL.md
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
4. **Adopt the `assets/` + `references/` convention** established by write-plan (Group 2)

---

## ✅ Completion Criteria

- [ ] Audit artifact with tier classification
- [ ] plan-review SKILL.md in templates with rubric pass and gotchas
- [ ] Staged planning path support (`planning-stageN/`)
- [ ] `references/structure.yaml` with input/output schema
- [ ] Self-containment (FR-8) verified

---

## 🔗 Dependencies

- Benefits from patterns established in decision and write-plan conversions (Groups 1-2)
- **Depends on Group 2:** adopts the `assets/` + `references/` convention that write-plan establishes
- No hard dependency on Group 1

---

**Last Updated:** 2026-05-02
