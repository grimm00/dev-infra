# Branch Setup & Doc Curation

**Feature:** Skill-Template Separation (ADR-001)
**Group:** Branch Setup & Doc Curation
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-22

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 1: Create new feature branch from develop
  - Branch off the current `develop` (e.g., `feat/skill-template-separation` or similar) before any implementation work.
  - The current `docs/skill-template-separation-research` branch keeps the research/exploration; the new branch carries only hard artifacts.

- [ ] Task 2: Selectively transfer ADR-001 to the new branch
  - Copy `admin/services/meta/features/skill-template-separation/decisions/adr-001-separation-model.md` only.
  - Do NOT transfer ADR-002, ADR-003, decisions hub README, decision-interview, or decisions-summary.

- [ ] Task 3: Selectively transfer planning tree to the new branch
  - Copy `admin/services/meta/features/skill-template-separation/planning/` (this whole directory: implementation-plan, status-and-next-steps, tasks/).

- [ ] Task 4: Decide how ADR-001's research references are handled on develop
  - ADR-001 references `../research/research-*.md` files that won't exist on develop.
  - Choose: strip references / keep with broken-link note pointing to research branch / add a "see git log" pointer.

- [ ] Task 5: Verify the new branch contains only curated hard artifacts
  - Confirm absence of `research/`, `explorations/`, sibling ADR files, decision hub artifacts, and any unrelated meta files.

---

## 🎯 Goals

1. Establish a feature branch from develop with a deliberately small doc surface (Theme 6 in practice).
2. Curate exactly what merges to develop: ADR-001 + planning tree only.
3. Resolve the broken-reference question for ADR-001 ahead of merge.

---

## ✅ Completion Criteria

- [ ] New feature branch exists and is pushed to remote
- [ ] Branch contains ADR-001 + planning tree, nothing else from this feature dir
- [ ] Reference-handling decision documented (in ADR-001 itself or in status-and-next-steps)

---

## 🔗 Dependencies

- None — this group is the entry point for all subsequent implementation work.

---

**Last Updated:** 2026-05-22
