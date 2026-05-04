# Narrative: Stage 4 — The Last Three Commands and the v1 Finish Line

**PRs:** #97, #98, #99
**Date:** 2026-05-03 → 2026-05-04

---

## Why This Matters

Stage 4 converted the last three commands — review, commit, and handoff — to skills. After this, every step in the thinking pipeline is skill-based: from exploring a problem space (`explore-start`) through researching questions (`research-conduct`), making architectural decisions (`decision`), writing implementation plans (`write-plan-setup`), reviewing them (`plan-review`), reviewing changes before committing (`pre-commit-review`), committing (`commit`), and handing off context between sessions (`handoff`). The commands-era thinking pipeline no longer exists.

This is the v1 completion boundary defined in `design.md` Section 5: thinking = skills, implementation = commands. Four stages, 52 tasks, 16 PRs, 19 SKILL.md files. The thesis proposed in ADR-001 — that ~1,500 lines of always-on context could be replaced by on-demand skills that load only when invoked — is now fully realized for the thinking pipeline.

But Stage 4 wasn't just a mechanical cutover. It was the stage where the agent pipeline itself was debugged, where a skill got renamed mid-flight because the original name was wrong, and where the human realized the skills shouldn't be validated in the factory that built them.

---

## What Made This One Different

Stage 4 was the fastest stage: 11 tasks across 3 groups, all completed in a single session. Stages 1–3 each had 15 tasks and 4–5 groups. The speed wasn't accidental — it reflected accumulated pattern confidence. By Stage 4, the conversion workflow (audit → classify → convert → validate → cutover) was muscle memory for both human and agent. The `assets/` + `references/structure.yaml` convention was designed in from day one, not retrofitted.

Three things made this stage distinct from its predecessors:

**The naming problem.** The `review` command was initially converted as a `review` skill. Then a `/discuss` session surfaced the ambiguity: "review" implies code quality review (what Sourcery does), not a pre-commit staging checkpoint (what the skill actually does). The realization came from thinking about using the skill outside dev-infra — in external repos where there's no PR pipeline, just a developer wanting the IDE to be the gate. The rename to `pre-commit-review` happened mid-stage, between Groups 1 and 2, requiring updates across planning docs, the worktree branch, and the skill's own `structure.yaml`.

**The agent couldn't see Sourcery.** The `group-cycle.agent.md` pipeline told the agent to poll `gh api repos/{owner}/{repo}/pulls/{pr}/comments` for Sourcery's review. But Sourcery posts as a *pull request review*, not a regular comment — a different API endpoint entirely. The agent dutifully polled, got nothing, reported "no Sourcery review," and moved on. The human ran `dt-review 99` manually and got the actual findings. The fix was to make the agent poll with `dt-review` itself — the tool that already knows how to extract Sourcery's output regardless of where GitHub puts it.

**The v1 quality sweep was the first full-corpus audit.** Prior stages swept only their own skills. Task 10 enumerated all 19 SKILL.md files across every stage. The sweep explicitly waived `references/structure.yaml` retrofit for Stage 1–2 skills — a pragmatic boundary. The convention didn't exist when those skills were built, and retrofitting 13 skills wasn't Stage 4's job. The waiver was documented, not silent.

---

## How It Was Built

### The Review-Commit Coupling

The most interesting design question in Stage 4 was the `pre-commit-review` → `commit` coupling. These two skills form a workflow pair: review stages changes and produces a diff analysis; commit reads that analysis and produces a commit. The coupling is through artifact shape, not code dependency. `commit`'s `references/structure.yaml` declares a `reads_from` pointer to `pre-commit-review`'s output contract. If review's artifact format changes, the YAML schema surfaces the mismatch before runtime does.

This is the `assets/` + `references/` convention working as intended: skills declare what they produce and consume. Plan-review can verify these declarations match reality. The coupling is explicit, traceable, and checkable — three properties the old command-pair relationship (where commit just assumed review's output existed somewhere) never had.

### The `plan-review` Absorption

Between Groups 1 and 2, the deprecated `pre-phase-review` command was formally absorbed into `plan-review`. The old command was a between-groups checkpoint; `plan-review` already had the semantics to serve that role. The absorption meant updating `group-cycle.agent.md` Step 0 to call `plan-review` instead of the old command, and extending `plan-review`'s "When to use" section to include "between task-group dispatches." One skill, two invocation patterns (standalone review and between-groups checkpoint), same artifact output.

### Three PRs, Three Agent Dispatches

| PR | Group | Tasks | Key Deliverable |
|----|-------|-------|-----------------|
| #97 | Review Skill | 1–3 | `pre-commit-review/SKILL.md` — hybrid skill with procedural staging + behavioral diff analysis |
| #98 | Commit + Handoff | 4–8 | `commit/SKILL.md` (review-coupled) + `handoff/SKILL.md` (independent, create + resume modes) |
| #99 | Cutover + v1 Gate | 9–11 | Skills vendored at repo root, commands archived, 19-skill corpus sweep, exit criteria verified |

Each group was dispatched via `group-cycle.agent.md` to a `composer-2-fast` subagent running in an isolated git worktree. The pipeline — Step 0 closeout, Step 1 expansion, Step 2 execution, Step 3 PR, Step 4 validation, Step 6 report — ran without human code intervention on any group.

### Discoveries That Changed the Pipeline

**dt-review as the polling mechanism.** The fix to `group-cycle.agent.md` Step 4b replaced `gh api` comment polling with `dt-review` polling: wait 15 seconds, run `dt-review`, check for substantive content, retry up to 4 attempts. This is the third iteration of the Sourcery polling logic — first was a fixed 60-second wait (Stage 2), then 15-second interval polling of `gh api` (Stage 3), now `dt-review` as both detector and extractor (Stage 4). Each iteration came from watching the agent fail at the previous version.

**CI snapshot, not CI gate.** A related pipeline fix: Step 4a was clarified to record CI status as a *snapshot* (passing, failing, or pending) rather than waiting for completion. Sourcery landing is the only gate; CI results are informational. The agent had been waiting for full CI runs to complete, adding unnecessary latency to every group cycle.

---

## What Was Learned

### For the Project

**The skills work — but not where they were tested.** All 19 skills were validated structurally: five-property rubric, `structure.yaml` where applicable, self-containment (FR-8), Bats test suite (248 passed), template sync validation. But structural validation doesn't test whether a skill produces a *useful* review or *helpful* handoff document. That testing belongs in a real project — the pi-hole DNS project in the same org — where the skills face real diffs, real session boundaries, and real cost constraints. The factory that builds the tools isn't the right place to test whether they're sharp.

**The agent pipeline converges through failure.** The Sourcery polling logic has been wrong in three different ways across four stages. Each fix came from watching the agent do the wrong thing and understanding *why* it was wrong (fixed wait → missed fast reviews; API polling → wrong endpoint; immediate poll → Sourcery hasn't posted yet). The pipeline definition is now better because it was exercised 16 times across 16 PRs. The ceremony-as-code pattern works, but it requires debugging the ceremony the same way you debug code: observe, hypothesize, fix, re-observe.

**Naming matters more than you think at conversion time.** The `review` → `pre-commit-review` rename wasn't cosmetic. It changed how the skill is understood: not "review your code for quality" but "stage and review changes before committing." The rename clarified the use case (pre-commit gate for external repos) and prevented confusion with Sourcery's actual code review. Names carry assumptions. When converting commands to skills, question the name — it was chosen in a different context.

### For the Engineer

**v1 is the beginning, not the end.** The thinking pipeline is skill-based. The implementation commands (`/task`, `/pr`, `/fix-plan`) remain as commands. Template sync (FR-9) is deferred. The learning-project doesn't have skills yet. `structure.yaml` doesn't exist on Stage 1–2 skills. The pipeline synthesis gap (no automatic triggers for narrative/int-opp/reflect) is documented but unresolved. v1 drew a clean line — and the post-v1 backlog is well-understood because every stage documented what it deferred.

**The hardest part of this stage was the parts that weren't in the plan.** The `pre-commit-review` rename, the `plan-review` absorption of `pre-phase-review`, the dt-review polling fix, the CI snapshot clarification — none of these were in the Stage 4 implementation plan. They emerged from `/discuss` sessions, from watching the agent work, from manually running `dt-review 99` and realizing the agent couldn't see what you could see. The plan handled the mechanical work perfectly. The human handled the parts that required noticing something was off.

---

## The Commits

```
da628f5 feat(agentic-workflow-modernization): Cutover and v1 Final Quality Gate (Group 3) (#99)
a2ae38a feat(agentic-workflow-modernization): Commit and Handoff Skills (Group 2) (#98)
7dad411 docs(agentic-workflow-modernization): rename review skill to pre-commit-review in planning docs
155a15e docs(agentic-workflow-modernization): create Stage 4 implementation plan scaffolding
4af67f5 feat(agentic-workflow-modernization): Review Skill (Group 1) (#97)
```

---

## Related Artifacts

| Artifact | Location |
|----------|----------|
| Stage 4 implementation plan | `admin/services/ai-workflow/features/agentic-workflow-modernization/planning-stage4/implementation-plan.md` |
| Stage 4 status | `admin/services/ai-workflow/features/agentic-workflow-modernization/planning-stage4/status-and-next-steps.md` |
| Plan review (scaffolding) | `planning-stage4/plan-review-2026-05-03.md` |
| Plan review (Group 3 checkpoint) | `planning-stage4/plan-review-2026-05-04.md` |
| Sourcery reviews | `admin/feedback/sourcery/pr97.md` through `pr99.md` |
| Pipeline synthesis gap (int-opp) | `admin/planning/opportunities/internal/dev-infra/learnings/agentic-workflow-stage3-pipeline-synthesis-gap.md` |
| Stage 3 narrative | `admin/services/ai-workflow/narratives/agentic-workflow-stage3/narrative.md` |
| Source design | `admin/services/ai-workflow/features/agentic-workflow-modernization/designs/design.md` (Section 5) |

---

**Last Updated:** 2026-05-04
