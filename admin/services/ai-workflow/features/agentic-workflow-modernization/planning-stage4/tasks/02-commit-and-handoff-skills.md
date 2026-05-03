# Commit and Handoff Skills

**Feature:** Agentic Workflow Modernization — Stage 4
**Group:** Commit and Handoff Skills
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-03

---

## 📝 Tasks

- [ ] Task 4: Audit commit command and classify instructions
  - Classify commit.md (312 lines) against the five-property rubric
  - Document coupling to pre-commit-review: same-session context, cross-session artifact reading, auto-detect
  - Produce audit artifact at `planning-stage4/artifacts/commit-command-audit.md`

- [ ] Task 5: Convert commit to SKILL.md (procedural, review-coupled)
  - Create `templates/standard-project/.claude/skills/commit/SKILL.md`
  - Create `references/structure.yaml` — declare dependency on pre-commit-review's artifact shape (cross-reference pre-commit-review's `structure.yaml`)
  - No `assets/` needed (commit produces commits, not templates)
  - Preserve three discovery modes: same-session context, explicit folder, auto-detect

- [ ] Task 6: Audit handoff command and classify instructions
  - Classify handoff.md (190 lines) against the five-property rubric
  - Separate procedural steps (context gathering, document writing) from template content
  - Produce audit artifact at `planning-stage4/artifacts/handoff-command-audit.md`

- [ ] Task 7: Convert handoff to SKILL.md (procedural)
  - Create `templates/standard-project/.claude/skills/handoff/SKILL.md`
  - Extract handoff template into `assets/handoff-template.md`
  - Create `references/structure.yaml` declaring handoff artifact output shape
  - Preserve `--resume` mode as a distinct workflow path

- [ ] Task 8: Validate commit↔review integration and handoff skill
  - Verify commit's `structure.yaml` correctly references review's output shape
  - Verify handoff skill passes five-property rubric independently
  - Confirm all three skills (pre-commit-review, commit, handoff) are self-contained per FR-8

---

## 🎯 Goals

1. Convert commit with explicit coupling to review's artifact contract (not implementation coupling)
2. Convert handoff as an independent procedural skill with create + resume modes
3. Validate that the review→commit integration works through declared artifact shapes, not implicit assumptions

---

## ✅ Completion Criteria

- [ ] Both audit artifacts produced
- [ ] commit SKILL.md passes five-property rubric
- [ ] handoff SKILL.md passes five-property rubric
- [ ] commit `references/structure.yaml` declares review dependency
- [ ] handoff `assets/` and `references/structure.yaml` present and accurate
- [ ] FR-8 self-containment verified for all three Stage 4 skills

---

## 🔗 Dependencies

- Group 1 (Review Skill) must be complete — commit references pre-commit-review's `structure.yaml` output shape
- Handoff tasks (6-7) are independent of review/commit and could theoretically parallelize

---

**Last Updated:** 2026-05-03
