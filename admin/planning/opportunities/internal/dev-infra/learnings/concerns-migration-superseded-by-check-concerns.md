# Concerns Migration Superseded by `check-concerns` Skill

**Project:** Dev-Infra / Agentic-Ocean
**Topic:** Formal concerns migration attempted and abandoned; replaced by a routing skill
**Date:** 2026-07-16
**Last Updated:** 2026-07-16

---

## 📋 Overview

After the core corpus split (skill-corpus-installation Groups 1–6 → `grimm00/agentic-ocean`), the open agentic-workflow concerns still lived in dev-infra as 12 remote issues and ~20 int-opps. A `/discuss` session on 2026-06-22 produced a triage table classifying every item as MIGRATE / STAY / BOTH / MOOT / HISTORICAL under the rule "concern follows the artifact it modifies."

That triage produced a 25-task, 9-group formal migration plan under `admin/services/ai-workflow/features/agentic-ocean-concerns-intake/`. Two weeks later (2026-07-16), a follow-up `/discuss` session concluded that the plan was solving the wrong problem for a solo dev, and the entire scaffold was deleted in favor of a lightweight routing skill.

---

## 🟡 What Needs Improvement — Recognized in the Reset

### The migration plan solved a team-shaped problem, not a solo-dev one

**What the problem was:** The triage rule ("concern follows the artifact") optimizes for cross-team searchability — anyone looking at agentic-ocean sees the concern surface directly. As a solo dev, that discoverability was almost entirely notional: the person who'd search is the same person who authored the concern. The 25-task plan was a per-issue filing marathon in service of a benefit only a hypothetical second contributor would receive.

**How to prevent:** When scoping a workflow change, ask *"who benefits from the artifact and how many are there?"* before designing for the artifact's downstream consumer. If the answer is "one, the author, six months from now" — the artifact only needs to be findable, not fully triaged.

### Backlog clearance is the wrong framing when new observations keep arriving

**What the problem was:** The migration plan aimed to *clear* the existing backlog. But the fatigue driver wasn't the size of the backlog — it was that ongoing skill/agent improvements were freezing because every new observation triggered "should I migrate this now, or add to the pile?" The plan didn't address the trigger; it just proposed to move the pile once.

**How to prevent:** Frame concern surface work as *stop accumulating* (routing at capture time) before *clear existing* (migration). The former dissolves most of the latter.

---

## 💡 What Superseded It

### The `check-concerns` skill (agentic-ocean corpus)

Path: `corpus/skills/check-concerns/SKILL.md`.

Invocation from any repo: *"check concerns for [topic]"*. The skill searches on-disk concern surfaces in `~/Projects/dev-infra/admin/planning/opportunities/internal/dev-infra/` and `~/Projects/agentic-ocean/`, prints matching paths with one-line snippets, or says "no existing record." No follow-up questions, no synthesis, no side effects.

The routing pattern was designed for solo-dev fire-and-forget:
- On-disk grep (no `gh api`, no LLM synthesis)
- Explicit "no match" output (audit trail against silent failure)
- Manual pruning at implementation-finish time (git history preserves record)
- Bootstrap loop: the skill's own concern (about needing this routing) is the first thing it captures

Result: existing concerns stay where they are (int-opps in dev-infra, issues in agentic-ocean). Individual concerns get promoted to agentic-ocean issues only when work on them is imminent, not upfront. The 24-issue filing marathon is dissolved.

---

## 📝 Additional Notes

### What was deleted
- `admin/services/ai-workflow/features/agentic-ocean-concerns-intake/` — the 25-task plan tree (12 files: `implementation-plan.md`, `status-and-next-steps.md`, `inputs/triage-table.md`, and 9 task group scaffolds)

### What survives from the effort
- **The triage classification itself** was captured in the (now-deleted) `triage-table.md`. Its content is preserved in git history if ever needed. The functional replacement is the `check-concerns` skill invoked live per observation rather than pre-computed.
- **This learning** documents why the migration was attempted and why it was superseded, so the same instinct doesn't produce the same plan again.

### Context for the pattern
- The migration plan was scaffolded via `write-plan-setup` after a `/discuss` session that itself over-formalized what should have stayed a thought. The direct trigger for the reset was the observation that agent confirming-questions + long response cycles made the 25-task plan uncomfortable to chew on across sessions.
- Two `/discuss` sessions bracketed the whole cycle. The first (2026-06-22) produced the triage and the plan. The second (2026-07-16) reframed the problem and produced the skill. The pattern is worth naming: **formal planning is often a symptom of the wrong problem framing, not a solution to the right one.**

### Related artifacts
- `~/Projects/agentic-ocean/corpus/skills/check-concerns/SKILL.md` — the routing skill
- `admin/services/ai-workflow/explorations/agentic-workflow-modernization/exploration.md` — parent context; Themes 5, 7, 10 are the relevant background
- Prior learnings that would have benefited from having `check-concerns` at the time: `agentic-workflow-stage3-pipeline-synthesis-gap.md` (specifically the "int-opp is outward-facing; no inward-facing carry-forward" concern is partially resolved by routing)

---

**Last Updated:** 2026-07-16
