---
task_count: 15
groups:
  - name: "Decision Skill"
    file: "tasks/01-decision-skill.md"
    tasks: [1, 2, 3]
  - name: "Write-Plan Skill"
    file: "tasks/02-write-plan-skill.md"
    tasks: [4, 5, 6, 7]
  - name: "Skill Family Restructure"
    file: "tasks/03-skill-family-restructure.md"
    tasks: [8, 9, 10]
  - name: "Plan-Review Skill"
    file: "tasks/04-plan-review-skill.md"
    tasks: [11, 12]
  - name: "Cutover and Quality Gate"
    file: "tasks/05-cutover-and-quality-gate.md"
    tasks: [13, 14, 15]
tasks_files:
  - "tasks/01-decision-skill.md"
  - "tasks/02-write-plan-skill.md"
  - "tasks/03-skill-family-restructure.md"
  - "tasks/04-plan-review-skill.md"
  - "tasks/05-cutover-and-quality-gate.md"
---
# Implementation Plan — Stage 3: Planner (Agentic Workflow Modernization)

**Status:** 🟠 In Progress
**Created:** 2026-05-02
**Last Updated:** 2026-05-03
**Source:** [ADRs 1-5 + design.md Section 5](../decisions/) → Stage 3 of 4-stage v1  
**Group 1 merged:** PR #92 (2026-05-03)  
**Group 2 merged:** PR #93 (2026-05-03)  
**Group 3 merged:** PR #94 (2026-05-03)

---

## 📋 Overview

Convert the **Planner** role group of dev-infra commands to skills. This stage converts decision (632 lines, hybrid with interview pattern), transition-plan (820 lines, two-mode procedural), and plan-review (416 lines, procedural). Write-plan is decomposed into a family (parent + setup + expand) consistent with the explore and research family patterns.

**Skills converted in this stage:** decision, write-plan (family: parent + write-plan-setup + write-plan-expand), plan-review
**Entry criteria:** Stage 2 go decision (logged ✅ 2026-05-02)

**New convention introduced:** Skills adopt an `assets/` + `references/` directory structure. Template-heavy content (scaffolding files, checklists) lives in `assets/` as copyable files. A `references/structure.yaml` declares the skill's expected I/O shape — input modes, output directories, singleton vs. collection files.

**Key Changes:**

- decision: hybrid skill — procedural interview workflow + behavioral contract for ADR quality. **Group 3** extracted templates into `assets/` + `references/structure.yaml`.
- transition-plan → write-plan: family pattern (parent hub + write-plan-setup + write-plan-expand). Initial single-skill conversion (Group 2) restructured into family (Group 3). **First skill to adopt `assets/` + `references/` convention** (most template-heavy).
- plan-review: procedural review skill — ensures stage plans account for prior learnings and cross-checks consistency. Adopts the `assets/` + `references/` convention.
- 3 commands archived after conversion (decision, transition-plan, plan-review).

---

## 🎯 Goals

1. **Convert the interview-pattern skill** — decision is the first skill with a structured human-interview workflow baked in.
2. **Decompose write-plan into a family** — consistent with explore and research families; parent hub + setup + expand children.
3. **Establish `assets/` + `references/` convention** — all Stage 3 skills get template assets and declarative structure.yaml.
4. **Complete the Planner role group** — plan-review rounds out the stage; full thinking pipeline becomes skill-based after merge.
5. **Apply proven patterns** — Stage 1 and 2 established: five-property rubric, templates-as-assets, family pattern, clean cutover.

---

## 📝 Implementation Plan

### Decision Skill
- [x] Task 1: Audit decision command and classify behavioral instructions
- [x] Task 2: Design decision SKILL.md (interview workflow + ADR behavioral contract)
- [x] Task 3: Validate decision skill against a recent ADR produced under the command

### Write-Plan Skill
- [x] Task 4: Audit transition-plan command modes and classify behavioral instructions
- [x] Task 5: Resolve decomposition — single skill vs family (write-plan-setup + write-plan-expand)
- [x] Task 6: Convert transition-plan to write-plan SKILL.md(s) per decomposition decision
- [x] Task 7: Validate write-plan skill against Stage 3's own scaffolding (meta-test)

### Skill Family Restructure
- [x] Task 8: Restructure write-plan into family (parent + write-plan-setup + write-plan-expand)
- [x] Task 9: Restructure decision skill with assets/ + references/
- [x] Task 10: Validate restructured skills (rubric + structure.yaml accuracy)

### Plan-Review Skill
- [x] Task 11: Audit plan-review command and classify behavioral instructions
- [ ] Task 12: Convert plan-review to SKILL.md

### Cutover and Quality Gate
- [ ] Task 13: Install skills + archive commands (decision, write-plan, plan-review)
- [ ] Task 14: Verify all Stage 3 skills pass five-property rubric
- [ ] Task 15: Final quality gate sweep + Stage 3 exit criteria

---

## ✅ Definition of Done

- [x] decision skill exists with interview workflow and ADR behavioral contract
- [x] write-plan is a family: parent + write-plan-setup + write-plan-expand
- [x] decision has `assets/` + `references/structure.yaml`
- [ ] plan-review skill exists with staged-planning path support
- [ ] All skills pass five-property rubric with populated gotchas
- [ ] Self-containment (FR-8) verified for each skill
- [ ] All Stage 3 skills have `assets/` (where applicable) + `references/structure.yaml`
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
- **Conversion patterns:** Stage 1-2 established: five-property rubric, templates-as-assets, family pattern, clean cutover

---

**Last Updated:** 2026-05-03
