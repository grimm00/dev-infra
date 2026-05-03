---
task_count: 12
groups:
  - name: "Decision Skill"
    file: "tasks/01-decision-skill.md"
    tasks: [1, 2, 3]
  - name: "Transition-Plan Skill"
    file: "tasks/02-transition-plan-skill.md"
    tasks: [4, 5, 6, 7]
  - name: "Plan-Review Skill"
    file: "tasks/03-plan-review-skill.md"
    tasks: [8, 9]
  - name: "Cutover and Quality Gate"
    file: "tasks/04-cutover-and-quality-gate.md"
    tasks: [10, 11, 12]
tasks_files:
  - "tasks/01-decision-skill.md"
  - "tasks/02-transition-plan-skill.md"
  - "tasks/03-plan-review-skill.md"
  - "tasks/04-cutover-and-quality-gate.md"
---
# Implementation Plan — Stage 3: Planner (Agentic Workflow Modernization)

**Status:** 🔴 Not Started
**Created:** 2026-05-02
**Last Updated:** 2026-05-02
**Source:** [ADRs 1-5 + design.md Section 5](../decisions/) → Stage 3 of 4-stage v1

---

## 📋 Overview

Convert the **Planner** role group of dev-infra commands to skills. This stage converts decision (632 lines, hybrid with interview pattern), transition-plan (820 lines, two-mode procedural), and plan-review (416 lines, procedural). The open question from design.md — whether transition-plan decomposes into two skills or stays single — is resolved during implementation.

**Skills converted in this stage:** decision, transition-plan (possibly transition-plan-setup + transition-plan-expand), plan-review
**Entry criteria:** Stage 2 go decision (logged ✅ 2026-05-02)

**Key Changes:**

- decision: hybrid skill — procedural interview workflow + behavioral contract for ADR quality. Bakes in the interview pattern from this feature's own research.
- transition-plan: largest command (820 lines). Two modes (setup/expand) — assess decomposition vs single skill during audit.
- plan-review: procedural review skill, smallest of the three.
- 3 commands archived after conversion (decision, transition-plan, plan-review).

---

## 🎯 Goals

1. **Convert the interview-pattern skill** — decision is the first skill with a structured human-interview workflow baked in. Validates hybrid encoding at a new level of interactivity.
2. **Resolve the transition-plan decomposition question** — design.md Section 6 defers this to implementation time. The audit decides: single skill (if modes are thin enough) or family (setup + expand).
3. **Complete the Planner role group** — plan-review rounds out the stage; full thinking pipeline becomes skill-based after merge.
4. **Apply proven patterns** — Stage 1 and 2 established: five-property rubric, templates-as-assets, family pattern, clean cutover, regression test. Reuse, don't reinvent.

---

## 📝 Implementation Plan

### Decision Skill
- [ ] Task 1: Audit decision command and classify behavioral instructions
- [ ] Task 2: Design decision SKILL.md (interview workflow + ADR behavioral contract)
- [ ] Task 3: Validate decision skill against a recent ADR produced under the command

### Transition-Plan Skill
- [ ] Task 4: Audit transition-plan command modes and classify behavioral instructions
- [ ] Task 5: Resolve decomposition — single skill vs family (transition-plan-setup + transition-plan-expand)
- [ ] Task 6: Convert transition-plan to SKILL.md(s) per decomposition decision
- [ ] Task 7: Validate transition-plan skill against Stage 3's own scaffolding (meta-test)

### Plan-Review Skill
- [ ] Task 8: Audit plan-review command and classify behavioral instructions
- [ ] Task 9: Convert plan-review to SKILL.md

### Cutover and Quality Gate
- [ ] Task 10: Install skills + archive commands (decision, transition-plan, plan-review)
- [ ] Task 11: Verify all Stage 3 skills pass five-property rubric
- [ ] Task 12: Final quality gate sweep + Stage 3 exit criteria

---

## ✅ Definition of Done

- [ ] decision skill exists with interview workflow and ADR behavioral contract
- [ ] transition-plan decomposition decided and implemented (single or family)
- [ ] plan-review skill exists
- [ ] All skills pass five-property rubric with populated gotchas
- [ ] Self-containment (FR-8) verified for each skill
- [ ] 3 commands archived: decision.md, transition-plan.md, plan-review.md
- [ ] CI passes after cutover
- [ ] Stage 3 exit criteria from design.md Section 5 verified
- [ ] Full thinking pipeline is skill-based (user experience at boundary)

---

## 🔗 Related

- **Stage 2 plan:** [../planning-stage2/implementation-plan.md](../planning-stage2/implementation-plan.md) (complete)
- **Stage 2 learnings:** [../planning-stage2/status-and-next-steps.md](../planning-stage2/status-and-next-steps.md)
- **Source ADRs:** [ADR-001 through ADR-005](../decisions/)
- **Source design:** [design.md Section 5 — Stage 3: Planner](../designs/design.md)
- **Open question:** [design.md Section 6 — Transition-plan mode decomposition](../designs/design.md)
- **Conversion patterns:** Stage 1-2 established: five-property rubric, templates-as-assets, family pattern, clean cutover

---

**Last Updated:** 2026-05-02
