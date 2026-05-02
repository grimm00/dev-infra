# Research Child Skills

**Feature:** Agentic Workflow Modernization (Stage 2: Researcher)
**Group:** Research Child Skills
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [ ] Task 4: Convert research-conduct (most complex hybrid skill)
  - Extract conduct-mode instructions from research command audit (Task 1)
  - This is the most complex conversion in v1: procedural steps + behavioral contract for source evaluation, finding quality, and requirement discovery
  - Apply five-property rubric strictly — every behavioral instruction must be observable, bounded, outcome-framed, delta-only, failure-aware
  - Populate gotchas section from audit + lived experience
  - Author in `templates/standard-project/.claude/skills/research/research-conduct/SKILL.md`

- [ ] Task 5: Convert research-consolidate (procedural with merge logic)
  - Extract consolidate-mode instructions from research command audit (Task 1)
  - Procedural skill: merges findings from multiple research topics into a summary
  - Apply five-property rubric
  - Populate gotchas section
  - Author in `templates/standard-project/.claude/skills/research/research-consolidate/SKILL.md`

- [ ] Task 6: Verify research-add-topic belongs in research-setup or warrants separate skill
  - Review add-topic behavior from the research command
  - If it's a thin operation (just appending to topic list): keep in research-setup
  - If it has its own behavioral contract or complex logic: create `research/research-add-topic/SKILL.md`
  - Document the decision in chat with rationale

- [ ] Task 7: Validate research family pattern works end-to-end
  - Test the full flow: parent → setup → conduct → consolidate
  - Verify parent provides clear orientation to all children
  - Verify each child references the parent correctly (CP-1)
  - Test on Cursor (manual invocation with skill attachment)

---

## 🎯 Goals

1. Convert the two most complex research modes (conduct and consolidate)
2. Resolve the research-add-topic placement question (design.md open question)
3. Validate the full research family works as a cohesive pipeline

---

## ✅ Completion Criteria

- [ ] research-conduct passes five-property rubric
- [ ] research-consolidate passes five-property rubric
- [ ] research-add-topic placement decided with documented rationale
- [ ] Full family flow tested: setup → conduct → consolidate
- [ ] All children reference parent correctly

---

## 🔗 Dependencies

- Group 1 (Research Family Foundation) must be complete
- Task 1 audit informs all conversions in this group

---

**Last Updated:** 2026-05-02
