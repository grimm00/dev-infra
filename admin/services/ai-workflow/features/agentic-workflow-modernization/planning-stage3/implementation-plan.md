---
task_count: 10
groups:
  - name: "Decision Skill"
    file: "tasks/01-decision-skill.md"
    tasks: [1, 2, 3]
  - name: "Write-Plan Skill"
    file: "tasks/02-write-plan-skill.md"
    tasks: [4, 5, 6, 7]
  - name: "Cutover and Quality Gate"
    file: "tasks/03-cutover-and-quality-gate.md"
    tasks: [8, 9, 10]
tasks_files:
  - "tasks/01-decision-skill.md"
  - "tasks/02-write-plan-skill.md"
  - "tasks/03-cutover-and-quality-gate.md"
---
# Implementation Plan — Stage 3: Planner (Agentic Workflow Modernization)

**Status:** 🔴 Not Started
**Created:** 2026-05-02
**Last Updated:** 2026-05-02
**Source:** [ADRs 1-5 + design.md Section 5](../decisions/) → Stage 3 of 4-stage v1

---

## 📋 Overview

Convert the **Planner** role group of dev-infra commands to skills. This stage converts decision (632 lines, hybrid with interview pattern) and transition-plan (820 lines, two-mode procedural). plan-review is deferred to a future cycle pending usability assessment. The open question from design.md — whether transition-plan decomposes into two skills or stays single — is resolved during implementation.

**Skills converted in this stage:** decision, write-plan (possibly write-plan-setup + write-plan-expand)
**Deferred:** plan-review (low recent usage, path detection doesn't support staged planning directories)
**Entry criteria:** Stage 2 go decision (logged ✅ 2026-05-02)

**Key Changes:**

- decision: hybrid skill — procedural interview workflow + behavioral contract for ADR quality. Bakes in the interview pattern from this feature's own research.
- transition-plan → write-plan: largest command (820 lines). Two modes (setup/expand) — assess decomposition vs single skill during audit.
- 2 commands archived after conversion (decision, transition-plan).

---

## 🎯 Goals

1. **Convert the interview-pattern skill** — decision is the first skill with a structured human-interview workflow baked in. Validates hybrid encoding at a new level of interactivity.
2. **Resolve the write-plan decomposition question** — design.md Section 6 defers this to implementation time. The audit decides: single skill (if modes are thin enough) or family (setup + expand).
3. **Apply proven patterns** — Stage 1 and 2 established: five-property rubric, templates-as-assets, family pattern, clean cutover, regression test. Reuse, don't reinvent.

---

## 📝 Implementation Plan

### Decision Skill
- [ ] Task 1: Audit decision command and classify behavioral instructions
- [ ] Task 2: Design decision SKILL.md (interview workflow + ADR behavioral contract)
- [ ] Task 3: Validate decision skill against a recent ADR produced under the command

### Write-Plan Skill
- [ ] Task 4: Audit transition-plan command modes and classify behavioral instructions
- [ ] Task 5: Resolve decomposition — single skill vs family (write-plan-setup + write-plan-expand)
- [ ] Task 6: Convert transition-plan to write-plan SKILL.md(s) per decomposition decision
- [ ] Task 7: Validate write-plan skill against Stage 3's own scaffolding (meta-test)

### Cutover and Quality Gate
- [ ] Task 8: Install skills + archive commands (decision, write-plan)
- [ ] Task 9: Verify all Stage 3 skills pass five-property rubric
- [ ] Task 10: Final quality gate sweep + Stage 3 exit criteria

---

## ✅ Definition of Done

- [ ] decision skill exists with interview workflow and ADR behavioral contract
- [ ] write-plan decomposition decided and implemented (single or family)
- [ ] All skills pass five-property rubric with populated gotchas
- [ ] Self-containment (FR-8) verified for each skill
- [ ] 2 commands archived: decision.md, transition-plan.md
- [ ] CI passes after cutover
- [ ] Stage 3 exit criteria from design.md Section 5 verified (adjusted: plan-review deferred)

---

## 🔗 Related

- **Stage 2 plan:** [../planning-stage2/implementation-plan.md](../planning-stage2/implementation-plan.md) (complete)
- **Stage 2 learnings:** [../planning-stage2/status-and-next-steps.md](../planning-stage2/status-and-next-steps.md)
- **Source ADRs:** [ADR-001 through ADR-005](../decisions/)
- **Source design:** [design.md Section 5 — Stage 3: Planner](../designs/design.md)
- **Open question:** [design.md Section 6 — Transition-plan mode decomposition](../designs/design.md)
- **Deferred:** plan-review — low usage, path detection gaps; convert in a future cycle
- **Conversion patterns:** Stage 1-2 established: five-property rubric, templates-as-assets, family pattern, clean cutover

---

**Last Updated:** 2026-05-02
