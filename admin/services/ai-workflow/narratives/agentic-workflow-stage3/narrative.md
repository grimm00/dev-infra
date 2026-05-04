# Narrative: Stage 3 — Planner Skills and the Convention That Wasn't Planned

**PRs:** #92, #93, #94, #95, #96
**Date:** 2026-05-02 → 2026-05-03

---

## Why This Matters

Stage 3 converted the "Planner" role group — decision, transition-plan, and plan-review — from `.cursor/commands/` to `.claude/skills/`. These three commands form the full thinking pipeline: deciding what to build, planning how to build it, and reviewing whether the plan is sound. After this stage, every step from exploration through planning is skill-based. The commands-era thinking pipeline is gone.

But the conversion itself is less interesting than what happened along the way. Stage 3 started as a straightforward "audit, convert, cutover" and ended with a new structural convention (`assets/` + `references/structure.yaml`), a plan that grew from 4 groups to 5, and a learning about a gap in the agent pipeline that nobody had noticed through two prior stages.

---

## What Made This One Different

Stage 1 converted the Explorer skills. Stage 2 converted the Researcher skills. Both followed a predictable pattern: audit the command, classify its instructions against the precision rubric, convert to SKILL.md, cutover. Stage 3 broke the pattern in three ways.

**The commands were structurally different.** `decision` (632 lines) was the first command with a human interview workflow — it doesn't just generate files, it conducts a structured conversation before writing anything. `transition-plan` (820 lines) had two distinct operating modes: setup (scaffold a planning tree from nothing) and expand (deepen one task group). These weren't variations on "read context, produce output." They were multi-modal workflows that required different decomposition strategies.

**Mid-flight scope changes were the norm, not the exception.** The plan changed four times during execution:

| Change | When | Impact |
|--------|------|--------|
| `plan-review` deferred from Stage 3 | After Group 1 dispatch | Tasks dropped from 12 to 10 |
| `plan-review` restored | Before Group 2 dispatch | Tasks back to 12; task file re-created from scratch |
| `assets/` + `references/structure.yaml` convention introduced | Before Group 2 dispatch | All task files updated; new structural requirements for every skill |
| Group 3 inserted (Skill Family Restructure) | After Group 2 complete | Plan grew from 4 groups / 12 tasks to 5 groups / 15 tasks |

None of these were errors. Each was a real-time recognition that the plan didn't account for something. The `plan-review` restoration happened because we realized that without it, there was no mechanism to enforce cross-stage learning carry-forward. The `assets/` convention emerged from noticing that template-heavy skills (write-plan has three copyable planning documents) needed a separation between behavioral contract (SKILL.md) and copyable boilerplate (assets/).

**The subagent's decomposition decision was overridden.** The Group 2 subagent (`composer-2-fast`) decided that `write-plan` should be a single skill with both setup and expand modes embedded. This was internally consistent — the audit showed the modes shared enough context. But it broke pattern consistency with `explore` and `research`, which are families (parent hub + child skills). After the PR was merged, a `/discuss` session surfaced the inconsistency. The override was explicit: insert Group 3, split write-plan into a family, and apply the same restructuring to decision's inline templates. The subagent made a defensible local decision; the human applied a system-level consistency constraint it couldn't see.

---

## How It Was Built

### The Agent-Dispatched Pipeline

Every group except Group 3's planning was executed by dispatching the `group-cycle.agent.md` subagent. The pipeline: Step 0 (close out prior group's PR), Step 1 (expand task specs), Step 2 (execute tasks), Step 3 (create PR with structured body), Step 4 (poll Sourcery, run review, fix inline), Step 5 (open questions if any), Step 6 (report). Five dispatches, five PRs, no blockers that required human code intervention.

The agent pipeline improvements from earlier in the session (Sourcery polling at 15-second intervals instead of fixed 60-second waits, explicit `prior_pr` must-be-merged validation) proved immediately useful. Every dispatch completed without manual fixes to the ceremony.

### The Convention That Emerged Mid-Stage

The `assets/` + `references/structure.yaml` convention wasn't in the original plan. It emerged from a concrete problem: write-plan's SKILL.md would have needed to embed three full planning document templates inline. That's 200+ lines of boilerplate crowding the behavioral contract.

The solution: pull templates into an `assets/` subdirectory (copyable files the skill reads and adapts), and add a `references/structure.yaml` that declaratively describes what the skill produces — input modes, output directories, singleton vs. collection files. The YAML file serves as a machine-checkable contract: plan-review can read it to verify a skill's claimed outputs match reality.

Once the convention existed for write-plan, it was applied retroactively to decision (extracting its ADR template, interview scaffold, and hub README into `assets/`) and forward to plan-review (which got a review checklist asset and a structure.yaml declaring its review dimensions). This is why Group 3 exists — it was inserted specifically to restructure the two already-converted skills.

### The Archive Path Change

Between Groups 4 and 5, the human did independent cleanup: moving old archived commands from `.cursor/commands/archived/` (which cluttered the IDE's active command namespace) to `admin/archived/commands/`. The cutover task file was updated before Group 5 dispatch to point the subagent at the new canonical archive location. The subagent organized the archived commands by origin: `admin/archived/commands/stage3-planner/{repo-root,template-standard-project,template-learning-project}/`.

### Discoveries That Changed the Plan

**Plan-review's value is upstream-dependent.** We deferred plan-review initially because it seemed low-value — path detection was broken, and nobody had run it in months. Then we realized that Stage 3's own plan didn't account for Stage 2's learnings (the interview artifact, the decisions artifact) because nothing forced the check. Plan-review was the only skill designed to catch that gap. It was restored the same session it was deferred.

**The pipeline synthesis gap.** The most significant learning was that the group-cycle agent has no step for capturing what was learned during implementation. Narratives, int-opps, and reflections are all human-triggered. The pipeline's Step 6 (Report) produces a chat message, not a committed artifact. This means mid-implementation discoveries (the assets convention, the family decomposition override, the plan-review restoration) exist only in conversation context. Plan-review can't enforce "did you account for prior learnings?" if those learnings were never persisted.

This was captured as a formal int-opp (`admin/planning/opportunities/internal/dev-infra/learnings/agentic-workflow-stage3-pipeline-synthesis-gap.md`) and flagged as directly relevant to Stage 4, where narrative/int-opp/reflect are themselves converted to skills.

---

## What Was Learned

### For the Project

**The `assets/` + `references/structure.yaml` convention works.** After applying it to three skills with different structures (family with shared assets, single skill with extracted templates, review skill with a checklist), the pattern is stable. Stage 4 skills should adopt it from day one rather than retrofitting.

**Subagent decisions need human review at the system level.** The `composer-2-fast` subagent made a locally correct decomposition choice for write-plan. The inconsistency with explore/research family patterns was only visible from the human's cross-cutting perspective. The agent pipeline handles group-level execution well; system-level pattern consistency is still a human judgment call.

**Plan changes during execution are features, not failures.** Stage 3's plan changed four times. Each change made the deliverables better: more consistent structure, stronger cross-stage validation, cleaner separation of behavioral contract from copyable templates. The pipeline accommodated every change without ceremony overhead — insert a group, renumber tasks, update docs, dispatch.

### For the Engineer

**The thinking pipeline is now skill-based.** After Stage 3, a developer using dev-infra templates can explore a problem space, research specific questions, make architectural decisions, write implementation plans, expand task groups, and review plans for cross-stage consistency — all through skills with behavioral contracts, assets, and declarative structure files. The commands-era equivalents are archived.

**The hardest part of skill conversion isn't the conversion.** It's recognizing when the command's original structure doesn't fit the skill conventions. Decision needed an interview workflow that commands never encoded. Write-plan needed family decomposition that the command's two-mode design obscured. Plan-review needed staged-directory path support that the command never had. The audit-and-classify step caught these, but the solutions required design judgment, not mechanical translation.

---

## The Commits

```
521c5d1 docs(agentic-workflow-modernization): post-merge after PR #96
680572e Merge pull request #96 from grimm00/feat/agentic-workflow-stage3-g5
f5a97e6 Merge pull request #95 from grimm00/feat/agentic-workflow-stage3-g4
399a019 docs(int-opp): capture pipeline synthesis gap — agentic workflow stage 3
bbd2f95 Merge pull request #94 from grimm00/feat/agentic-workflow-stage3-g3
a478da2 docs(stage3): insert Group 3 — Skill Family Restructure
e638091 Merge pull request #93 from grimm00/feat/agentic-workflow-stage3-g2
95375a6 docs(agentic-workflow-modernization): update planning-stage3 after PR #92
eb1120a Merge pull request #92 from grimm00/feat/agentic-workflow-stage3-g1
```

---

## Related Artifacts

| Artifact | Location |
|----------|----------|
| Stage 3 implementation plan | `admin/services/ai-workflow/features/agentic-workflow-modernization/planning-stage3/implementation-plan.md` |
| Stage 3 status | `admin/services/ai-workflow/features/agentic-workflow-modernization/planning-stage3/status-and-next-steps.md` |
| Decision command audit | `planning-stage3/artifacts/decision-command-audit.md` |
| Transition-plan command audit | `planning-stage3/artifacts/transition-plan-command-audit.md` |
| Plan-review command audit | `planning-stage3/artifacts/plan-review-command-audit.md` |
| Pipeline synthesis gap (int-opp) | `admin/planning/opportunities/internal/dev-infra/learnings/agentic-workflow-stage3-pipeline-synthesis-gap.md` |
| Sourcery reviews | `admin/feedback/sourcery/pr92.md` through `pr96.md` |
| Source design | `admin/services/ai-workflow/features/agentic-workflow-modernization/designs/design.md` (Section 5) |

---

**Last Updated:** 2026-05-03
