---
task_count: 17
groups:
  - name: "Foundation (Rules + AGENTS.md)"
    file: "tasks/01-foundation.md"
    tasks: [1, 2, 3, 4]
  - name: "Discuss Conversion (Thesis Validation)"
    file: "tasks/02-discuss-conversion.md"
    tasks: [5, 6, 7]
  - name: "Explore Family"
    file: "tasks/03-explore-family.md"
    tasks: [8, 9, 10, 11]
  - name: "Single-Mode Skills"
    file: "tasks/04-single-mode-skills.md"
    tasks: [12, 13, 14]
  - name: "Cutover and Quality Gate"
    file: "tasks/05-cutover-and-quality-gate.md"
    tasks: [15, 16, 17]
tasks_files:
  - "tasks/01-foundation.md"
  - "tasks/02-discuss-conversion.md"
  - "tasks/03-explore-family.md"
  - "tasks/04-single-mode-skills.md"
  - "tasks/05-cutover-and-quality-gate.md"
---
# Implementation Plan — Stage 1: Thinker (Agentic Workflow Modernization)

**Status:** 🔴 Not Started
**Created:** 2026-04-24
**Last Updated:** 2026-04-24
**Source:** [ADRs 1-5 + design.md](../decisions/) → Stage 1 of 4-stage v1

---

## 📋 Overview

Convert the **Thinker** role group of dev-infra commands to skills, plus the foundation work (AGENTS.md + slimmed `.mdc` rules) that precedes the conversion. This is **Stage 1 of 4** in the agentic-workflow-modernization feature, designed to prove the behavioral precision thesis (C1-4) on the highest-judgment commands before committing to the remaining stages.

**Skills converted in this stage:** discuss, explore-start, explore-amend, int-opp, narrative
**Foundation work:** AGENTS.md + CLAUDE.md drafted; `.mdc` rules slimmed from ~1,500 to ~50 lines

**Key Changes:**

- Always-on context drops from ~1,500 lines to ~50 (ADR-003)
- 5 commands removed; 5 skills authored in `templates/standard-project/.claude/skills/` (ADR-005)
- First skill family pattern validated (`explore/` with parent + 2 children, ADR-002)
- Five-property quality rubric (FR-19) applied strictly during every conversion (ADR-004)

---

## 🎯 Goals

1. **Prove the thesis** — discuss skill must perform at least as well as the discuss command (C5-3). This is the go/no-go signal for Stages 2-4.
2. **Validate the family pattern** — explore family (parent + explore-start + explore-amend) demonstrates the multi-mode decomposition pattern works in practice.
3. **Establish the foundation** — AGENTS.md + slimmed rules give all subsequent stages a clean context layer to build on.
4. **Apply the quality rubric** — every skill passes the five-property rubric (observable, bounded, outcome-framed, delta-only, failure-aware) before being shipped.
5. **Demonstrate clean cutover** — when a command becomes a skill, the command file is deleted (C2-1). No coexistence wrappers.

---

## 📝 Implementation Plan

### Foundation (Rules + AGENTS.md)
- [x] Task 1: Audit current `.mdc` rules content and classify by destination (four-type separation per FR-4)
- [x] Task 2: Draft AGENTS.md with portable conventions (~150-200 lines, FR-1 inline)
- [x] Task 3: Draft CLAUDE.md mirroring AGENTS.md content (C-1, C-4)
- [x] Task 4: Slim `.mdc` rules to ~50 lines (Cursor-specific config only, FR-5 mutable state removed)

### Discuss Conversion (Thesis Validation)
- [x] Task 5: Audit discuss command for behavioral instructions; classify by precision tier (Topic 8 audit)
- [x] Task 6: Convert discuss to SKILL.md applying five-property rubric (FR-19) and dual-location pattern (FR-21)
- [x] Task 7: Populate gotchas section from Topic 8 audit findings + lived experience (FR-20)

### Explore Family
- [x] Task 8: Design parent `explore/SKILL.md` (orientation + family conventions for child skills)
- [x] Task 9: Convert explore-start (setup mode) with explicit parent reference (CP-1)
- [x] Task 10: Convert explore-amend with explicit parent reference (CP-1)
- [x] Task 11: Validate family pattern works on both Cursor and Claude Code (manual test)

### Single-Mode Skills
- [x] Task 12: Convert int-opp (single-mode procedural skill)
- [x] Task 13: Convert narrative (single-mode hybrid skill — procedural steps + behavioral contract)
- [x] Task 14: Verify both skills pass five-property rubric and self-containment requirement (FR-8)

### Cutover and Quality Gate
- [x] Task 15: Install skills + archive converted command files (.cursor/commands/{discuss,explore,int-opp,narrative}.md)
- [x] Task 16: Run regression test on discuss skill against recent /discuss usage; capture observed behavior
- [ ] Task 17: Final quality gate sweep across all 5 skills + foundation work; verify Stage 1 exit criteria met

---

## ✅ Definition of Done

- [ ] AGENTS.md and CLAUDE.md exist with synchronized content (~150-200 lines each)
- [ ] `.mdc` rules slimmed to ~50 lines containing only Cursor-specific config
- [ ] 5 skills exist in `templates/standard-project/.claude/skills/`: discuss, explore (parent), explore-start, explore-amend, int-opp, narrative (note: parent counts as a 6th file but represents the explore "skill family")
- [ ] All 5 skills pass the five-property quality rubric
- [ ] All 5 skills include populated gotchas sections
- [ ] Discuss skill demonstrates no quality regression vs discuss command (C5-3)
- [ ] Explore family pattern works (parent + 2 children, explicit parent reference confirmed)
- [ ] Removed command files: discuss.md, explore.md, int-opp.md, narrative.md
- [ ] No skills use platform-breaking features (FR-13)
- [ ] CI passes after cutover
- [ ] Stage 1 exit criteria from design.md Section 5 verified

---

## 🔗 Related

- **Source ADRs:** [ADR-001 through ADR-005](../decisions/)
- **Source design:** [design.md Section 5 (Staging Plan)](../designs/design.md)
- **Source requirements:** [requirements.md](../requirements.md) (FR-1, FR-4, FR-5, FR-8, FR-13, FR-19, FR-20, FR-21, C-1, C-2, C-4)
- **Source v1-scope:** [v1-scope.md](../v1-scope.md) (C5-1, C5-2, C5-3 quality bar)
- **Cross-cutting principle:** CP-1 (Explicit Over Implicit) applied throughout

---

**Last Updated:** 2026-04-30
