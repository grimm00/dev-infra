---
task_count: 15
groups:
  - name: "Research Family Foundation"
    file: "tasks/01-research-family-foundation.md"
    tasks: [1, 2, 3]
  - name: "Research Child Skills"
    file: "tasks/02-research-child-skills.md"
    tasks: [4, 5, 6, 7]
  - name: "Standalone Skills (Spike + Reflect)"
    file: "tasks/03-standalone-skills.md"
    tasks: [8, 9, 10, 11]
  - name: "Cutover and Quality Gate"
    file: "tasks/04-cutover-and-quality-gate.md"
    tasks: [12, 13, 14, 15]
tasks_files:
  - "tasks/01-research-family-foundation.md"
  - "tasks/02-research-child-skills.md"
  - "tasks/03-standalone-skills.md"
  - "tasks/04-cutover-and-quality-gate.md"
---
# Implementation Plan — Stage 2: Researcher (Agentic Workflow Modernization)

**Status:** ✅ Complete
**Created:** 2026-05-02
**Last Updated:** 2026-05-02
**Source:** [ADRs 1-5 + design.md Section 5](../decisions/) → Stage 2 of 4-stage v1

---

## 📋 Overview

Convert the **Researcher** role group of dev-infra commands to skills. This stage validates multi-mode decomposition at scale: the research family (parent + 3 children) is the largest family in v1, and research-conduct is the most complex command being converted. Spike and reflect are standalone conversions that round out the stage.

**Skills converted in this stage:** research (parent), research-setup, research-conduct, research-consolidate, spike, reflect
**Entry criteria:** Stage 1 complete (go decision logged), family pattern proven on explore

**Key Changes:**

- Research family: parent + 3 children (largest family, validates pattern at scale)
- research-conduct: most complex hybrid skill — procedural steps + behavioral contract for source evaluation, finding quality, requirement discovery
- spike and reflect: standalone conversions (single-mode, same pattern as int-opp/narrative)
- 3 commands archived after conversion (research, spike, reflect)

---

## 🎯 Goals

1. **Validate multi-mode decomposition at scale** — research family (parent + 3 children) is larger than explore family (parent + 2). Does the pattern hold?
2. **Convert the most complex command** — research-conduct is the highest-complexity conversion in all of v1. If it converts without quality loss, everything else will.
3. **Regression test research-conduct** — same quality bar as discuss (C5-3): skill must perform at least as well as the command against a recent topic.
4. **Complete the Researcher role group** — spike and reflect round out the stage cleanly.

---

## 📝 Implementation Plan

### Research Family Foundation
- [x] Task 1: Audit research command modes and classify behavioral instructions
- [x] Task 2: Design parent `research/SKILL.md` (orientation + family conventions)
- [x] Task 3: Convert research-setup (scaffolding mode — creates research directory structure)

### Research Child Skills
- [x] Task 4: Convert research-conduct (most complex: source evaluation + finding quality + requirement discovery)
- [x] Task 5: Convert research-consolidate (procedural with merge logic)
- [x] Task 6: Verify research-add-topic belongs in research-setup or warrants separate skill
- [x] Task 7: Validate research family pattern works end-to-end (parent → setup → conduct → consolidate)

### Standalone Skills (Spike + Reflect)
- [x] Task 8: Audit spike command for behavioral instructions
- [x] Task 9: Convert spike to SKILL.md (time-boxed behavioral contract)
- [x] Task 10: Audit reflect command for behavioral instructions
- [x] Task 11: Convert reflect to SKILL.md (personal growth behavioral contract)

### Cutover and Quality Gate
- [x] Task 12: Install skills + archive commands (research, spike, reflect)
- [x] Task 13: Regression test research-conduct against recent topic research
- [x] Task 14: Verify all Stage 2 skills pass five-property rubric
- [x] Task 15: Final quality gate sweep + Stage 2 exit criteria

---

## ✅ Definition of Done

- [ ] Research family exists: parent + research-setup + research-conduct + research-consolidate
- [ ] Research family pattern validated end-to-end (setup → conduct → consolidate flow)
- [ ] research-conduct demonstrates no quality regression vs command (go/no-go signal)
- [ ] spike and reflect skills exist and pass five-property rubric
- [ ] All skills include populated gotchas sections
- [ ] 3 commands archived: research.md, spike.md, reflect.md
- [ ] research-add-topic placement decided (in research-setup or separate)
- [ ] CI passes after cutover
- [ ] Stage 2 exit criteria from design.md Section 5 verified

---

## 🔗 Related

- **Stage 1 plan:** [../planning/implementation-plan.md](../planning/implementation-plan.md) (complete)
- **Stage 1 learnings:** [../planning/status-and-next-steps.md](../planning/status-and-next-steps.md) (Stage 1 → Stage 2 decision)
- **Source ADRs:** [ADR-001 through ADR-005](../decisions/)
- **Source design:** [design.md Section 5 — Stage 2: Researcher](../designs/design.md)
- **Agent orchestration spike:** [../spikes/agent-orchestration/](../spikes/agent-orchestration/)
- **Conversion patterns:** Stage 1 established: five-property rubric, templates-as-assets, family pattern, clean cutover

---

**Last Updated:** 2026-05-02
