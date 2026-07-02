# Hubs + verification + status doc

**Feature:** agentic-ocean-concerns-intake
**Group:** 9 — Hubs + verification + status doc
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-22

> ⚠️ **Scaffolding:** Run `write-plan-expand` to add detailed implementation notes.

---

## 📝 Tasks

- [ ] Task 22: Update int-opp hub READMEs in dev-infra
  - Add a "Migrated to agentic-ocean" section in both `admin/planning/opportunities/internal/dev-infra/improvements/README.md` and `learnings/README.md` listing the migrated items with destination links. Future writers see this and route new corpus-side concerns directly.

- [ ] Task 23: Update `agentic-workflow-modernization` status doc to record the migration
  - Add a milestone entry in the modernization feature's `status-and-next-steps.md` noting that concerns have routed to agentic-ocean as of this date.

- [ ] Task 24: Enumerate filed agentic-ocean issues vs triage
  - Mechanical verification pass: for every MIGRATE/BOTH row in `planning/inputs/triage-table.md`, confirm a destination issue URL is recorded. Flag any gaps.

- [ ] Task 25: Final commit pass + cleanup orphaned references
  - Sweep for any dangling references to migrated issues; ensure consistent commit history; mark feature complete in status doc.

---

## 🎯 Goals

1. Make the migration discoverable from dev-infra so the next contributor doesn't re-litigate it.
2. Verify completeness — no concerns dropped, no destinations missing.

---

## ✅ Completion Criteria

- [ ] Both int-opp hub READMEs include the migrated-to section
- [ ] `agentic-workflow-modernization` status doc records the migration milestone
- [ ] Verification pass produces a zero-gap report
- [ ] Final commits landed; feature status marked complete

---

## 🔗 Dependencies

- All prior groups (1–8)

---

**Last Updated:** 2026-06-22
