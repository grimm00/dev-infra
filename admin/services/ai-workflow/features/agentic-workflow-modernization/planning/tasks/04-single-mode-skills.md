# Single-Mode Skills

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Single-Mode Skills
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-04-24

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan agentic-workflow-modernization --expand --group 4` to add detailed implementation notes.

- [ ] Task 12: Convert int-opp (single-mode procedural skill)
  - Create `templates/standard-project/.claude/skills/int-opp/SKILL.md`
  - Single-mode flat skill (no family, no parent reference needed)
  - Procedural in nature: capture learnings, organize by project, create improvement checklists
  - Less behavioral than discuss but still has some judgment moments (project detection, opportunity classification)
  - Apply five-property rubric, dual-location description, gotchas

- [ ] Task 13: Convert narrative (single-mode hybrid skill)
  - Create `templates/standard-project/.claude/skills/narrative/SKILL.md`
  - Hybrid skill (FR-6): procedural steps for gathering context + behavioral contract for tone, structure, evidence-grounding
  - Source: existing `/narrative` command (this command is well-tested and used in this very session)
  - Behavioral guidance is non-trivial — narrative quality depends on tone calibration, story-arc identification, and evidence selection

- [ ] Task 14: Verify both skills pass five-property rubric and self-containment requirement (FR-8)
  - Re-read each SKILL.md; confirm every behavioral instruction is observable, bounded, outcome-framed, delta-only, failure-aware
  - Verify each skill works without companion files (FR-8)
  - Verify each skill is under 500 lines (C-2)
  - Spot-check links to AGENTS.md, related skills

---

## 🎯 Goals

1. Apply the patterns proven in Groups 2-3 to two more skills (one purely procedural, one hybrid)
2. Demonstrate the rubric and structure work for skills of varying behavioral complexity
3. Complete the Thinker role group (5 skills total: discuss, explore-start, explore-amend, int-opp, narrative)

---

## ✅ Completion Criteria

- [ ] `int-opp/SKILL.md` exists
- [ ] `narrative/SKILL.md` exists
- [ ] Both pass five-property rubric
- [ ] Both have populated gotchas sections
- [ ] Both under 500 lines and operationally complete without companion files
- [ ] Manual smoke test: each skill produces output equivalent to its source command

---

## 🔗 Dependencies

- Group 1 (Foundation): AGENTS.md exists
- Group 2 (Discuss): rubric application pattern established
- Group 3 (Explore Family): family-vs-flat decision pattern established
- These two skills don't have inter-dependencies; can be done in parallel within the group

---

**Last Updated:** 2026-04-24
