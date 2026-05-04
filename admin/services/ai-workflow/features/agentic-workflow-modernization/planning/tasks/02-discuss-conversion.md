# Discuss Conversion (Thesis Validation)

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Discuss Conversion (Thesis Validation)
**Status:** ✅ Complete
**Completed:** 2026-04-30
**Last Updated:** 2026-04-30

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan agentic-workflow-modernization --expand --group 2` to add detailed implementation notes.

- [x] Task 5: Audit discuss command for behavioral instructions; classify by precision tier
  - Read `.cursor/commands/discuss.md` in full
  - Apply Topic 8's tier classification: Tier 1 (Precise — keep as-is), Tier 2 (Mixed — rewrite), Tier 3 (Vague/Problematic — rewrite or remove)
  - Output: a tier-classified inventory of every behavioral instruction in the discuss command
  - Reference: Spike B already validated a transformation (267 → 143 lines); use it as guidance

- [x] Task 6: Convert discuss to SKILL.md applying five-property rubric (FR-19) and dual-location pattern (FR-21)
  - Create `templates/standard-project/.claude/skills/discuss/SKILL.md`
  - Frontmatter: dual-location description (routing only), `disable-model-invocation: true` (FR-2)
  - Body: separate `## Workflow` from `## Behavioral Contract` (FR-6 hybrid encoding)
  - Apply five-property rubric to every behavioral instruction: observable, bounded, outcome-framed, delta-only, failure-aware
  - Verify SKILL.md is operationally complete without companion files (FR-8)
  - Stay under 500-line limit (C-2)

- [x] Task 7: Populate gotchas section from Topic 8 audit findings + lived experience (FR-20)
  - Add `## Gotchas` section with named failure modes and correct alternatives
  - Source: Topic 8 audit (~15 Tier 3 instructions identified) + personal experience using /discuss
  - Each gotcha: names the mistake and the correct alternative

---

## 🎯 Goals

1. Prove the behavioral precision thesis (C1-4) on the most behavioral command in the suite
2. Demonstrate the five-property rubric is testable and produces measurable improvements
3. Establish the quality benchmark for all subsequent skill conversions (C5-3)

---

## ✅ Completion Criteria

- [x] `discuss/SKILL.md` exists in `templates/standard-project/.claude/skills/`
- [x] All behavioral instructions pass the five-property rubric
- [x] Gotchas section populated with at least 5 documented failure modes (8 documented)
- [x] SKILL.md under 500 lines and operationally complete without companion files (201 lines)
- [x] No platform-breaking features used (FR-13)
- [ ] Manual smoke test: invoking the skill produces equivalent behavior to the command (deferred — runs in Group 5 cutover)

---

## 🔗 Dependencies

- Group 1 (Foundation): AGENTS.md must exist before discuss skill body can rely on shared conventions being available
- Critical path: this group is the go/no-go signal for Stages 2-4. If discuss conversion produces quality regression, pause and reassess before continuing.

---

**Last Updated:** 2026-04-30
