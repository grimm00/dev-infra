# Concerns channel shape in agentic-ocean

**Feature:** agentic-ocean-concerns-intake
**Group:** 1 — Concerns channel shape in agentic-ocean
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-22

> ⚠️ **Scaffolding:** Run `write-plan-expand` (or legacy `/transition-plan [feature] --expand --group 1`) to add detailed implementation notes.

---

## 📝 Tasks

- [ ] Task 1: Survey agentic-ocean structure and draft 3 channel-shape options
  - Confirm current layout (flat `corpus/`, `docs/`, no `admin/` tree); draft per-artifact / admin-mirror / flat-root options.

- [ ] Task 2: Pick option via `/decision` in agentic-ocean
  - Run `/decision concerns-channel-shape` with the three options as alternatives; capture ADR in agentic-ocean.

- [ ] Task 3: Scaffold the chosen channel (dirs + hub README) in agentic-ocean
  - Create directory layout + a hub README explaining intake conventions and link-back format.

- [ ] Task 4: Commit channel scaffolding to agentic-ocean
  - Conventional commit (`docs(concerns):` or similar) on a feature branch in agentic-ocean; reference the ADR.

---

## 🎯 Goals

1. Resolve the open precondition for Groups 5–8 (where concerns physically live in agentic-ocean).
2. Produce an ADR in agentic-ocean so the channel choice is durable rather than implicit.

---

## ✅ Completion Criteria

- [ ] ADR exists in agentic-ocean documenting the channel choice and rationale
- [ ] Channel directory and hub README exist in agentic-ocean and reference the ADR
- [ ] Commit landed on a feature branch in agentic-ocean (draft PR optional)

---

## 🔗 Dependencies

- None upstream; this group gates Groups 5–8 (BOTH/learnings migrations need link-back targets in the channel)

---

**Last Updated:** 2026-06-22
