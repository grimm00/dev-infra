---
task_count: 11
groups:
  - name: "Review Skill"
    file: "tasks/01-review-skill.md"
    tasks: [1, 2, 3]
  - name: "Commit and Handoff Skills"
    file: "tasks/02-commit-and-handoff-skills.md"
    tasks: [4, 5, 6, 7, 8]
  - name: "Cutover and v1 Final Quality Gate"
    file: "tasks/03-cutover-and-v1-quality-gate.md"
    tasks: [9, 10, 11]
tasks_files:
  - "tasks/01-review-skill.md"
  - "tasks/02-commit-and-handoff-skills.md"
  - "tasks/03-cutover-and-v1-quality-gate.md"
---
# Implementation Plan — Stage 4: Reviewer (Agentic Workflow Modernization)

**Status:** 🔴 Not Started
**Created:** 2026-05-03
**Last Updated:** 2026-05-03
**Source:** [design.md Section 5 — Stage 4: Reviewer](../designs/design.md) + Stage 3 learnings

---

## 📋 Overview

Convert the **Reviewer** role group of dev-infra commands to skills, completing v1 of the agentic workflow modernization. This stage converts review (334 lines, hybrid with diff analysis behavioral contract), commit (312 lines, procedural, tightly coupled to review), and handoff (190 lines, procedural). All three are flat skills — no family decomposition needed.

**Skills converted in this stage:** pre-commit-review, commit, handoff
**Entry criteria:** Stage 3 go decision (logged ✅ 2026-05-03)

**Conventions carried forward from Stage 3:** All Stage 4 skills adopt the `assets/` + `references/structure.yaml` convention from day one. Review has a summary template (`assets/`); handoff has a handoff template (`assets/`). Commit reads review's artifacts at runtime but doesn't have its own templates — `structure.yaml` declares its coupling to review's output shape.

**Key characteristics:**

- pre-commit-review: hybrid skill — procedural staging workflow (identify files, stage, capture diff, present) + behavioral contract (what to look for in diff, when to stop, never auto-commit). The review-then-commit pause is the core value proposition.
- commit: procedural skill — reads review context (same-session or cross-session), verifies staged files, commits with draft message, cleans up. Tightly coupled to review's artifact shape.
- handoff: procedural skill — gathers git context, creates handoff document from template, presents to user. Has `--resume` mode for reading back. Independent of review/commit.
- After this stage: all ~16 thinking pipeline skills are skill-based. Implementation commands (`/task`, `/pr`, `/fix-plan`) remain as commands. This is the v1 completion boundary.

---

## 🎯 Goals

1. **Convert the review-then-commit workflow** — review is the hybrid (procedural + behavioral); commit is the procedural second half. Together they encode the "pause to review agentic changes" pattern.
2. **Convert handoff for session continuity** — procedural skill producing transient artifacts for context preservation across sessions.
3. **Apply `assets/` + `references/structure.yaml` from day one** — no retrofitting. Stage 3 lesson: these conventions should be designed in, not bolted on.
4. **Complete v1** — final quality sweep across all ~16 skills. The entire thinking pipeline becomes skill-based after merge.
5. **Archive the last Reviewer commands** — clean cutover; `admin/archived/commands/stage4-reviewer/` follows the Stage 3 archival convention.

---

## 📝 Implementation Plan

### Review Skill
- [ ] Task 1: Audit review command and classify behavioral instructions
- [ ] Task 2: Convert review to SKILL.md (hybrid: procedural staging + behavioral diff analysis)
- [ ] Task 3: Validate review skill against review artifact patterns

### Commit and Handoff Skills
- [ ] Task 4: Audit commit command and classify instructions
- [ ] Task 5: Convert commit to SKILL.md (procedural, review-coupled)
- [ ] Task 6: Audit handoff command and classify instructions
- [ ] Task 7: Convert handoff to SKILL.md (procedural)
- [ ] Task 8: Validate commit↔review integration and handoff skill

### Cutover and v1 Final Quality Gate
- [ ] Task 9: Install skills + archive commands (review, commit, handoff)
- [ ] Task 10: Final quality sweep across ALL v1 skills (~16 skills)
- [ ] Task 11: v1 exit criteria verification + completion

---

## ✅ Definition of Done

- [ ] pre-commit-review skill exists with procedural staging workflow and behavioral diff analysis contract
- [ ] commit skill exists with review-artifact coupling (same-session + cross-session)
- [ ] handoff skill exists with create + resume modes
- [ ] All Stage 4 skills have `assets/` (where applicable) + `references/structure.yaml`
- [ ] All Stage 4 skills pass five-property rubric with populated gotchas
- [ ] Self-containment (FR-8) verified for each skill
- [ ] 3 commands archived to `admin/archived/commands/stage4-reviewer/`
- [ ] CI passes after cutover
- [ ] Final quality sweep: all ~16 v1 skills pass five-property rubric
- [ ] All thinking pipeline commands removed — skills only
- [ ] Stage 4 exit criteria from design.md Section 5 verified
- [ ] v1 completion: full thinking pipeline is skill-based; implementation commands remain as commands

---

## 🔗 Related

- **Stage 3 plan:** [../planning-stage3/implementation-plan.md](../planning-stage3/implementation-plan.md) (complete)
- **Stage 3 learnings:** [../planning-stage3/status-and-next-steps.md](../planning-stage3/status-and-next-steps.md)
- **Pipeline synthesis gap (int-opp):** [../../learnings/agentic-workflow-stage3-pipeline-synthesis-gap.md](../../../planning/opportunities/internal/dev-infra/learnings/agentic-workflow-stage3-pipeline-synthesis-gap.md)
- **Source design:** [design.md Section 5 — Stage 4: Reviewer](../designs/design.md)
- **Conversion patterns:** Stages 1-3 established: five-property rubric, `assets/` + `references/structure.yaml`, family pattern (not needed here), clean cutover, archival to `admin/archived/commands/`

---

**Last Updated:** 2026-05-03
