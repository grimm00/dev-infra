# Migrate pipeline/design int-opps (batch B)

**Feature:** agentic-ocean-concerns-intake
**Group:** 7 — Migrate pipeline/design int-opps (batch B)
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-07-02

> ⚠️ **Scaffolding:** Run `write-plan-expand` to add detailed implementation notes.
>
> **Executor:** `migrate-concern` subagent (Track β).

---

## 📝 Tasks

- [ ] Task 16: Author 4 concern docs in agentic-ocean for pipeline/design int-opps (batch B)
  - Source files (under `admin/planning/opportunities/internal/dev-infra/improvements/`):
    - `decision-command-human-involvement.md`
    - `research-prior-art-audit.md`
    - `pr-body-generation-primitive.md`
    - `post-pr-worktree-support.md`
  - Each concern doc lands at `agentic-ocean/concerns/<subdir>/<slug>.md` (subdir per Group 1's taxonomy — working lean: `pipeline-design/`; may sub-split from Group 6 if Group 1 chooses per-command taxonomy).
  - Theme: per-command / per-skill improvements.

- [ ] Task 17: Add migrated-to markers + agentic-ocean concern-doc paths in source int-opps
  - Same convention as Groups 5–6.

---

## 🎯 Goals

1. Migrate the remaining pure-MIGRATE int-opps so the source side is fully drained of corpus-bound concerns.

---

## ✅ Completion Criteria

- [ ] 4 concern docs authored + committed in agentic-ocean
- [ ] All 4 source int-opps annotated with destination path
- [ ] Triage table updated

---

## 🔗 Dependencies

- **Group 1** (channel dir must exist)
- **Track α** (this rewrite)
- **Track β** (`migrate-concern` subagent)

---

**Last Updated:** 2026-07-02
