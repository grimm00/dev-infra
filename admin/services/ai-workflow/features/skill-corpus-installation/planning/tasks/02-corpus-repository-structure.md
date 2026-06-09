# Corpus Repository Structure

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Corpus Repository Structure
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 4: Define layout + names for **both** repos
  - Core (`ai-workflow`) + personal (`ai-workflow-personal`), each `skills/ commands/ agents/`. Classify the inventory (`corpus-repo-reference.md`) via the [ADR-001](../decisions/adr-001-corpus-repo-split-model.md) boundary test.

- [ ] Task 5: Bootstrap both repos via `proj-cli` on **develop/nightly**
  - Generate each repo with proj-cli using the unreleased template + `expected_skills` validation (proj-cli #31 merged to develop). **Pin/record** the dev-infra + proj-cli develop SHAs used so the bootstrap is reproducible.

- [ ] Task 6: Migrate + **split** the global corpus
  - Core gets general/durable + depended-on-by-core (incl. `update-pr-description`); personal gets `apprentice-*`, `ticket-*`, `capture-discussion`. Drop the empty `~/.claude/skills/`. Verify the no-core→personal-dependency invariant holds.

- [ ] Task 7: Per-repo README + versioning
  - Each repo documented as its own product (ADR-001/ADR-002) with independent versioning. Mark the personal repo **private**.

---

## 🎯 Goals

1. Both corpus repos exist (core + personal) per ADR-001, generated consistently via proj-cli nightly.
2. The global corpus is migrated and correctly split, with the core→personal invariant intact.

---

## ✅ Completion Criteria

- [ ] Two repos exist with defined layouts and names
- [ ] Bootstrapped via proj-cli nightly; SHAs pinned/recorded
- [ ] Inventory migrated + split correctly (`update-pr-description` in core; personal items in personal)
- [ ] Per-repo README + versioning; personal repo private

---

## 🔗 Dependencies

- Group 1 (spike) ✅ — GO sets symlink mode (informs Groups 3–4).
- [ADR-001](../decisions/adr-001-corpus-repo-split-model.md) — the two-repo split + boundary test this group implements.
- **External (satisfied):** proj-cli `develop` carries `expected_skills` validation (#31 merged 2026-06-09); dev-infra `develop` carries the template changes.

---

**Last Updated:** 2026-06-09
