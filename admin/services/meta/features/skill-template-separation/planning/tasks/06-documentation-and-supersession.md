# Documentation & Supersession

**Feature:** Skill-Template Separation (ADR-001)
**Group:** Documentation & Supersession
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-22

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 23: Mark `global-command-distribution` feature README as superseded by ADR-001
  - Per Topic 6 audit recommendation, add a one-line "Superseded by skill-template-separation ADR-001 (2026)" note.
  - Do NOT delete the old feature docs — they preserve provenance.

- [ ] Task 24: Update dev-infra AGENTS.md / docs to reflect template minimalism + manifest pattern
  - Note that templates no longer bundle skills; describe the `expected_skills` mechanism.
  - Update the Template Standards section to reflect the new minimal approach.

- [ ] Task 25: Cross-link ADR-001 from four-arm-architecture and skill-template-separation hubs
  - Four-arm-architecture's ADRs implicitly assumed dev-infra owned the corpus — link ADR-001 as the extension that resolves the "what ships where" question.
  - Update or create a hub README on develop that points to ADR-001 (matching the curated doc-surface goal).

---

## 🎯 Goals

1. Old feature documentation reflects its supersession.
2. Project conventions (AGENTS.md) reflect the new template philosophy.
3. The four-arm-architecture's distribution story is closed by ADR-001's reference.

---

## ✅ Completion Criteria

- [ ] `global-command-distribution/README.md` annotated as superseded
- [ ] dev-infra AGENTS.md updated; review confirms accuracy
- [ ] Cross-references in place from four-arm-architecture and the feature hub

---

## 🔗 Dependencies

- Group 5 (proj-cli Validation) — last group runs only after the implementation is real, not just declared.

---

**Last Updated:** 2026-05-22
