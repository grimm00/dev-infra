# Migrate pipeline/design int-opps (batch A)

**Feature:** agentic-ocean-concerns-intake
**Group:** 6 — Migrate pipeline/design int-opps (batch A)
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-07-02

> ⚠️ **Scaffolding:** Run `write-plan-expand` to add detailed implementation notes.
>
> **Executor:** `migrate-concern` subagent (Track β).

---

## 📝 Tasks

- [ ] Task 14: Author 4 concern docs in agentic-ocean for pipeline/design int-opps (batch A)
  - Source files (under `admin/planning/opportunities/internal/dev-infra/improvements/`):
    - `artifact-emission-strategy.md`
    - `design-step-in-pipeline.md`
    - `pipeline-phase-start-signals.md`
    - `quality-attribute-catalog.md`
  - Each concern doc lands at `agentic-ocean/concerns/<subdir>/<slug>.md` (subdir per Group 1's taxonomy — working lean: `pipeline-design/`).
  - Theme: pipeline structure and the new `/design` skill.

- [ ] Task 15: Add migrated-to markers + agentic-ocean concern-doc paths in source int-opps
  - Same convention as Group 5 Task 13.

---

## 🎯 Goals

1. Consolidate the "shape of the pipeline" concerns in agentic-ocean where the skills that implement the pipeline live.
2. Make the `/design` skill addition discoverable as an open work item from the corpus side.

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
