# Migrate skill-bug concerns

**Feature:** agentic-ocean-concerns-intake
**Group:** 3 — Migrate skill-bug concerns
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-07-02

> ⚠️ **Scaffolding:** Run `write-plan-expand` to add detailed implementation notes.
>
> **Executor:** `migrate-concern` subagent (Track β), operating against
> `~/Projects/agentic-ocean/`. See design-decisions.md D2/D3.

---

## 📝 Tasks

- [ ] Task 8: Author 4 concern docs in agentic-ocean from dev-infra #74, #79, #101, #105
  - Bug-shaped concerns about `/task`, `/decision`, `research-setup`. Each concern doc lands at `agentic-ocean/concerns/<subdir>/<slug>.md` (subdir per Group 1's taxonomy — working lean: `skill-bugs/`).
  - Doc body preserves the original problem statement and includes a link-back header pointing to the source dev-infra issue URL.
  - Committed in agentic-ocean; batch into a single PR (or one commit per doc, batched into one PR — subagent's call, defined in Track β).

- [ ] Task 9: Cross-link and close dev-infra originals
  - Comment on each dev-infra issue with the agentic-ocean concern-doc path (e.g., `concerns/skill-bugs/task-scaffolding-warn.md`) and, once the agentic-ocean PR lands, the corresponding commit or file URL on `main`.
  - Close the dev-infra issue as migrated.

---

## 🎯 Goals

1. Move the lowest-risk batch of skill concerns first — bug-shaped, well-scoped, easy to verify.
2. Exercise the `migrate-concern` subagent (Track β) on the simplest input shape before harder batches (Groups 5–8).

---

## ✅ Completion Criteria

- [ ] 4 concern docs authored + committed in agentic-ocean (one per dev-infra issue)
- [ ] All 4 dev-infra issues closed with cross-link comment
- [ ] Triage table updated with destination doc paths

---

## 🔗 Dependencies

- **Group 1** (channel dir must exist in agentic-ocean before docs land — flat-root shape per D1)
- **Track α** (this task-spec rewrite; already in flight or complete)
- **Track β** (`migrate-concern` subagent installed at `~/.cursor/agents/migrate-concern.agent.md`)

---

**Last Updated:** 2026-07-02
