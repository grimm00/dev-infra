# Migrate corpus mechanics int-opps

**Feature:** agentic-ocean-concerns-intake
**Group:** 5 — Migrate corpus mechanics int-opps
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-07-02

> ⚠️ **Scaffolding:** Run `write-plan-expand` to add detailed implementation notes.
>
> **Executor:** `migrate-concern` subagent (Track β), operating against
> `~/Projects/agentic-ocean/`.

---

## 📝 Tasks

- [ ] Task 12: Author 5 concern docs in agentic-ocean for installer/corpus/skill-mechanics int-opps
  - Source files (under `admin/planning/opportunities/internal/dev-infra/improvements/`):
    - `claude-path-symlink-verification.md`
    - `corpus-update-sync-lifecycle.md`
    - `installer-managed-config-coexistence.md`
    - `skill-config-rendering.md`
    - `skill-toolbelt-colocated-scripts.md`
  - Each concern doc lands at `agentic-ocean/concerns/<subdir>/<slug>.md` (subdir per Group 1's taxonomy — working lean: `corpus-mechanics/`).
  - Doc body summarizes the int-opp's "Problem Statement" and includes a link-back header pointing to the source int-opp path in dev-infra.

- [ ] Task 13: Add migrated-to markers + agentic-ocean concern-doc paths in source int-opps
  - Add a header banner or footer in each migrated int-opp indicating it has been ported and pointing to the destination concern-doc path (e.g., `agentic-ocean/concerns/corpus-mechanics/corpus-update-sync-lifecycle.md`).

---

## 🎯 Goals

1. Move the corpus-mechanics concerns to the repo whose code they actually describe.
2. Preserve the int-opp's structured "What Worked Well / Needs Improvement / Discoveries" sections in dev-infra — concern docs summarize + link back, don't duplicate.

---

## ✅ Completion Criteria

- [ ] 5 concern docs authored + committed in agentic-ocean
- [ ] All 5 source int-opps annotated with destination path
- [ ] Triage table updated

---

## 🔗 Dependencies

- **Group 1** (channel dir must exist)
- **Track α** (this rewrite)
- **Track β** (`migrate-concern` subagent)

---

**Last Updated:** 2026-07-02
