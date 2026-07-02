# Status & Next Steps — agentic-ocean-concerns-intake

**Status:** 🟡 Planned — design decisions captured; execution pending on Tracks α, β
**Last Updated:** 2026-07-02

> **Design decisions:** see [`design-decisions.md`](design-decisions.md) for
> channel shape (flat-root markdown), execution split (3 tracks), the
> `migrate-concern` subagent scope, and the 88f83db8 concern intake.

---

## 📊 Progress Summary

**Overall:** 0/25 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| 1. Concerns channel shape in agentic-ocean | 🔴 Scaffolding | 0/4 tasks | Gates Groups 5–8 (the int-opp migrations). Group 1 must finish before any BOTH/learnings work |
| 2. Dev-infra source-side prep | 🔴 Scaffolding | 0/3 tasks | Independent of Group 1; #78/#113 splits + MOOT closes |
| 3. Migrate skill-bug issues | 🔴 Scaffolding | 0/2 tasks | Smallest bug-shaped issues; lowest risk batch to run first |
| 4. Migrate skill-architecture issues | 🔴 Scaffolding | 0/2 tasks | #102 requires rewriting its own "Recommended Approach" section |
| 5. Migrate corpus mechanics int-opps | 🔴 Scaffolding | 0/2 tasks | Depends on Group 1 (channel exists for link-backs) |
| 6. Migrate pipeline/design int-opps (batch A) | 🔴 Scaffolding | 0/2 tasks | Depends on Group 1 |
| 7. Migrate pipeline/design int-opps (batch B) | 🔴 Scaffolding | 0/2 tasks | Depends on Group 1 |
| 8. Learnings-as-concerns + BOTH cases | 🔴 Scaffolding | 0/4 tasks | Depends on Group 1; the int-opps don't squash cleanly into issues |
| 9. Hubs + verification + status doc | 🔴 Scaffolding | 0/4 tasks | Final group; runs after every migration group |

---

## 🚀 Next Steps (three-track plan-of-plans)

Execution now splits into three tracks per [`design-decisions.md`](design-decisions.md).
Tracks α, β, and γ-Group-1 can run in parallel; Groups 3–8 join on all three.

### Track α — dev-infra plan hygiene (small, do first)

1. Add 88f83db8 row to `planning/inputs/triage-table.md` (per D4).
2. Rewrite Tasks 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20 across the six
   task files listed in D5 — replace "file agentic-ocean issues" language
   with "author concern doc under `agentic-ocean/concerns/<subdir>/`".
3. Update `planning/implementation-plan.md` overview ("~29 fresh corpus-side
   issues" → "~29 fresh corpus-side concern docs").
4. Resolve D6 — move the scaffolding + this decision doc onto `develop`
   (docs PR from followup branch, or fresh `feat/agentic-ocean-concerns-intake`
   branch — pick per AGENTS.md Git Flow).

### Track β — `migrate-concern` subagent (new feature/exploration)

Design + install the narrow subagent per D3. Probably starts as an
exploration under
`admin/services/ai-workflow/explorations/migrate-concern-subagent/`, promotes
to a feature once inputs schema and behavior are pinned down. Terminal
artifact is `~/.cursor/agents/migrate-concern.agent.md`.

### Track γ — intake execution (waits on α + β for Groups 3–8)

- **Group 1** — human, in `~/Projects/agentic-ocean`. Survey + `/decision` +
  scaffold `concerns/` dir + hub README + commit + (optional draft) PR.
  Judgment work; do not dispatch.
- **Group 2** — `group-cycle` from dev-infra worktree. Independent of Group 1
  and of Tracks α/β; safe to run in parallel.
- **Groups 3–8** — `migrate-concern` subagent, dispatched per group after
  Group 1, Track α, and Track β are all complete.
- **Group 9** — `group-cycle` from dev-infra worktree after Groups 3–8 land.

---

## 📝 Notes

- **Plan source:** chat-only `/discuss` session 2026-06-22, materialized to `planning/inputs/triage-table.md` as the on-disk source artifact before scaffolding.
- **Input mode:** `from_artifacts` (the triage table).
- **Planning root convention:** `admin/services/ai-workflow/features/agentic-ocean-concerns-intake/planning/` (dev-infra feature layout, non-staged — no prior `planning-stageN/` siblings).
- **Cross-repo nature:** Plan lives in dev-infra (source of the migration). Execution writes to agentic-ocean (issue filing + channel scaffolding) and dev-infra (issue splits, MOOT closes, int-opp link-backs, hub updates). Each expanded group should be explicit about which repo its tasks touch.
- **Dependency on `agentic-ocean` repo state:** The migration assumes agentic-ocean stays roughly in its current shape (flat corpus + `docs/`, no `admin/` tree). If a separate restructure lands first, Group 1's options need re-evaluation.
- **HISTORICAL items not in scope:** Completed int-opps and feature-cycle retrospectives stay in dev-infra. The plan only acts on open concerns.
- **Subagent opportunity (now formalized):** Groups 3–8 are mechanical (read
  source artifact → author concern doc → commit in agentic-ocean). The
  `migrate-concern` subagent (Track β, per design-decisions.md D3) captures
  this. Original note called it out as a dogfooding tie-in to issue #102
  (agent architecture) — that tie-in stands.
- **Cross-repo scope shifted:** original plan assumed Groups 3–8 could file
  `gh` issues in agentic-ocean from a dev-infra worktree. D1 (flat-root
  markdown) invalidates that shortcut; every Group 3–8 task now needs write
  access to `~/Projects/agentic-ocean`, hence Track β.

---

**Last Updated:** 2026-07-02
