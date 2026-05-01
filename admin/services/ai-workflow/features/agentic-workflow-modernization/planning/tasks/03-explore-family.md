# Explore Family

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Explore Family
**Status:** 🟠 In Progress
**Last Updated:** 2026-04-30

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan agentic-workflow-modernization --expand --group 3` to add detailed implementation notes.

- [x] Task 8: Design parent `explore/SKILL.md` (orientation + family conventions)
  - Create `templates/standard-project/.claude/skills/explore/SKILL.md`
  - Parent provides: orientation (what the explore family does), available children list, family-level conventions for child skills to opt into
  - This is a "skill family parent" per ADR-002, validated by the nested skill discovery spike
  - Frontmatter follows same pattern as child skills

- [ ] Task 9: Convert explore-start (setup mode) with explicit parent reference (CP-1)
  - Create `templates/standard-project/.claude/skills/explore/explore-start/SKILL.md`
  - Body includes explicit instruction: "Before responding, read `../SKILL.md` for family conventions"
  - Apply five-property rubric (FR-19), dual-location description (FR-21), gotchas (FR-20)
  - Source: setup-mode logic from existing `/explore` command

- [ ] Task 10: Convert explore-amend with explicit parent reference (CP-1)
  - Create `templates/standard-project/.claude/skills/explore/explore-amend/SKILL.md`
  - Same explicit parent reference pattern as explore-start
  - Source: amend-mode logic from existing `/explore --amend`
  - Note: explore conduct mode is deprecated per C1-2 — do NOT create explore-conduct skill

- [ ] Task 11: Validate family pattern works on both Cursor and Claude Code (manual test)
  - Invoke `/explore-start` and `/explore-amend` in Cursor; verify parent reference loads correctly
  - Invoke same skills in Claude Code (if accessible); verify parent auto-discovery works
  - Reference: spike at `spikes/nested-skill-discovery.md` already validated the pattern

---

## 🎯 Goals

1. Validate the skill family pattern (ADR-002): parent + children with explicit reference, not automatic inheritance
2. Demonstrate multi-mode decomposition (FR-7): one skill per workflow, not one skill with mode flags
3. Confirm the spike's findings hold in production-style usage

---

## ✅ Completion Criteria

- [ ] `explore/SKILL.md` exists as family parent
- [ ] `explore/explore-start/SKILL.md` exists with explicit parent reference
- [ ] `explore/explore-amend/SKILL.md` exists with explicit parent reference
- [ ] All three skills pass five-property rubric
- [ ] Family pattern validated manually on Cursor (parent reference loads)
- [ ] No `explore-conduct` skill created (C1-2 deprecation)
- [ ] Children can be invoked independently (parent reference is opt-in, not required at runtime)

---

## 🔗 Dependencies

- Group 1 (Foundation): AGENTS.md must exist
- Group 2 (Discuss): pattern established in discuss conversion (rubric application, gotchas, dual-location) is reused here
- Critical: this group is the second go/no-go — if family pattern doesn't work cleanly, Stage 2 (research/, which has 3 children) is at risk

---

**Last Updated:** 2026-04-24
