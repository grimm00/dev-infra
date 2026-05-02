# Research Family Foundation

**Feature:** Agentic Workflow Modernization (Stage 2: Researcher)
**Group:** Research Family Foundation
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-02

---

## 📝 Tasks

- [ ] Task 1: Audit research command modes and classify behavioral instructions
  - Read `.cursor/commands/research.md` (1,531 lines)
  - Identify all modes: setup, conduct, consolidate, add-topic
  - Classify each behavioral instruction using the precision tier framework (Topic 8 audit pattern from Stage 1)
  - Map which instructions belong to which child skill
  - Document the audit in chat (same pattern as Task 5 in Stage 1)

- [ ] Task 2: Design parent `research/SKILL.md` (orientation + family conventions)
  - Follow the explore family pattern established in Stage 1
  - Parent provides: family overview, when to use each child, shared conventions
  - Parent does NOT contain procedural steps — those live in children
  - Reference: `.claude/skills/explore/SKILL.md` as the proven template
  - Author in `templates/standard-project/.claude/skills/research/SKILL.md`

- [ ] Task 3: Convert research-setup (scaffolding mode)
  - Extract setup-mode instructions from research command audit (Task 1)
  - research-setup creates the research directory structure, topic list, and initial scaffolding
  - Include research-add-topic behavior here (pending Task 6 verification)
  - Apply five-property rubric (FR-19)
  - Populate gotchas section
  - Author in `templates/standard-project/.claude/skills/research/research-setup/SKILL.md`

---

## 🎯 Goals

1. Establish the research family structure (parent + children directory layout)
2. Validate that the explore family pattern scales to a larger family (3 children vs 2)
3. Get the scaffolding skill working so research-conduct has a foundation to build on

---

## ✅ Completion Criteria

- [ ] Research command audit complete with mode/instruction classification
- [ ] Parent SKILL.md authored with family conventions
- [ ] research-setup skill passes five-property rubric
- [ ] Family directory structure in place: `research/SKILL.md`, `research/research-setup/SKILL.md`

---

## 🔗 Dependencies

- Stage 1 complete (family pattern proven on explore)
- No dependencies on other Stage 2 groups

---

**Last Updated:** 2026-05-02
