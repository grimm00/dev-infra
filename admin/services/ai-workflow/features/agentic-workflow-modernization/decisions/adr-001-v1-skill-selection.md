# ADR-001: V1 Skill Selection and Ordering

**Status:** Accepted
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Context

The agentic workflow modernization converts dev-infra's `.cursor/commands/` to `.claude/skills/`. The interview established the "thinking pipeline" as the v1 scope (C1-1) with a "small polished" quality target (C7-3), but did not enumerate exactly which skills or in what order.

22 consolidated requirements and 22 interview conclusions constrain the selection. Key inputs:

- C1-1: V1 is the thinking pipeline
- C1-2: Explore conduct mode is deprecated (overlap with research)
- C1-3: Role-based models (Thinker, Researcher, Planner, Reviewer) inform grouping
- C7-3: Small polished v1, thinking pipeline only
- C7-4: 8-16+ hrs/week, stages should be session-completable
- C2-2: Mixed state (some skills, some commands) is acceptable and serves as go/no-go signal

---

## Decision

**Staged v1 with role groups as stages.** Convert one role group per stage, each completable in 1-2 focused sessions. Four stages, executed sequentially:

### Stage 1 — Thinker (~4 skills)

| Skill | Source Command | Type |
|-------|---------------|------|
| discuss | `/discuss` | Behavioral (single mode) |
| explore-start | `/explore` (setup mode) | Procedural |
| explore-amend | `/explore --amend` | Procedural |
| int-opp | `/int-opp` | Procedural |

**Why first:** Most behavioral, most used, discuss already has spike validation (Spike B: 267 -> 143 lines). Proves the behavioral precision thesis (C1-4) and the five-property rubric (C5-1) on the highest-judgment skills. Smallest blast radius.

### Stage 2 — Researcher (~4 skills)

| Skill | Source Command | Type |
|-------|---------------|------|
| research-setup | `/research` (setup mode) | Procedural |
| research-conduct | `/research --conduct` | Hybrid (procedural + behavioral) |
| research-consolidate | `/research --consolidate` | Procedural |
| spike | `/spike` | Hybrid |

**Why second:** Most complex multi-mode command (research). Validates FR-7 (multi-mode decomposition) and FR-6 (hybrid encoding) on the hardest case. Research add-topic is folded into research-setup as a sub-workflow, not a separate skill.

### Stage 3 — Planner (~3 skills)

| Skill | Source Command | Type |
|-------|---------------|------|
| decision | `/decision` | Hybrid (procedural + interview pattern) |
| transition-plan | `/transition-plan` | Procedural (two modes) |
| plan-review | `/plan-review` | Procedural |

**Why third:** Depends on patterns validated in Stages 1-2. The decision skill itself gets the interview pattern baked in.

### Stage 4 — Reviewer (~3 skills)

| Skill | Source Command | Type |
|-------|---------------|------|
| review | `/review` | Hybrid (procedural + behavioral) |
| commit | `/commit` | Procedural |
| handoff | `/handoff` | Procedural |

**Why last:** Lowest behavioral complexity, most mechanical. These skills benefit from patterns established in earlier stages but don't gate them.

### Cross-Cutting Skills (slotted into stages)

| Skill | Slotted Into | Rationale |
|-------|-------------|-----------|
| narrative | Stage 1 | Closely related to Thinker workflows |
| reflect | Stage 2 | Feeds into research and exploration |

### Total: ~16 skills across 4 stages

### Explicitly Excluded from V1

| Command | Reason |
|---------|--------|
| `/task`, `/task-phase` | Implementation, not thinking pipeline (C1-1) |
| `/fix-plan`, `/fix-implement`, `/fix-review` | Fix management, deferred |
| `/pr`, `/pr-validation`, `/post-pr` | Release workflow, deferred |
| `/task-release`, `/release-prep`, `/release-finalize`, `/post-release` | Release automation, deferred |
| `/address-review` | Paired with plan-review, low standalone value |
| `/status` | State surfacing, deferred to CLI (C6-1) |
| `/explore --conduct` | Deprecated per C1-2 |

---

## Consequences

### Positive

- Each stage is completable in 1-2 focused sessions (C7-4)
- Mixed command/skill state after each stage provides a natural go/no-go signal (C2-2)
- Stage 1 proves the thesis before committing to the full pipeline
- Role grouping aligns with C1-3 mental model
- Quality stays high because each stage is small enough for strict rubric application (C5-1)

### Negative

- 4 stage boundaries add some overhead (stage planning, transition commits)
- Cross-cutting skills (narrative, reflect) don't fit cleanly into one role group
- ~16 skills is closer to "full thinking pipeline" than "3-5 skills" -- but staged delivery keeps each increment small

---

## Alternatives Considered

### Alternative A: Minimal First Stage (3-5 skills, one role group)

Convert only Thinker group, defer everything else.

**Why not chosen:** Too narrow to validate multi-mode decomposition (FR-7) or hybrid encoding (FR-6). Would prove behavioral precision but not architectural patterns. The staged approach provides the same "prove it first" benefit via Stage 1 while committing to the full pipeline.

### Alternative B: Full Thinking Pipeline in One Pass (~15 skills)

Convert everything at once, no staging.

**Why not chosen:** Violates C7-4 (session-completable stages). Quality would slip across 15+ conversions in a sustained effort. No feedback loop until everything is done. The staged approach gives the same end state with better pacing.

---

## Requirements Impact

| Requirement | Impact |
|-------------|--------|
| C1-1 (thinking pipeline) | Directly satisfied -- all thinking pipeline commands included |
| C1-2 (explore conduct deprecated) | Satisfied -- not in any stage |
| C7-3 (small polished v1) | Satisfied per stage; full v1 is ~16 skills but delivered incrementally |
| C7-4 (session-completable) | Satisfied -- each stage is 3-4 skills |
| C2-2 (mixed state acceptable) | Leveraged -- each stage boundary is a natural checkpoint |

---

## References

- [V1 Scope](v1-scope.md) -- Interview conclusions
- [Requirements](../../research/agentic-workflow-modernization/requirements.md)
- [Spike B Learnings](../../explorations/agentic-workflow-modernization/spike-learnings.md)

---

**Last Updated:** 2026-04-14
