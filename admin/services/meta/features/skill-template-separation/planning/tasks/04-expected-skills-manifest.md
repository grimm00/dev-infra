# expected_skills Manifest in Templates

**Feature:** Skill-Template Separation (ADR-001)
**Group:** expected_skills Manifest in Templates
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-22

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 15: Define `expected_skills` field schema in `.dev-infra.yml`
  - Add a top-level `expected_skills:` list (strings of skill identifiers) to the `.dev-infra.yml` schema.
  - Decide: bare names (`explore`) or namespaced (`ai-workflow/explore`)? Document the choice.

- [ ] Task 16: Populate `expected_skills` in `templates/standard-project/.dev-infra.yml`
  - List the skills the standard template's AGENTS.md and conventions assume (explore, research, write-plan, decision, commit, pre-commit-review, handoff, etc.).

- [ ] Task 17: Populate `expected_skills` in `templates/learning-project/.dev-infra.yml`
  - Mirror the standard list, adjusting for any learning-template-specific assumptions.

- [ ] Task 18: Document the field in template README and `.dev-infra.yml` reference docs
  - Explain the field's purpose, format, and `proj-cli` validation behavior.

---

## 🎯 Goals

1. `.dev-infra.yml` declares the skill corpus the template assumes (FR-BNDL-2).
2. Both templates have a populated, accurate `expected_skills` list.
3. The field is documented for users and future maintainers.

---

## ✅ Completion Criteria

- [ ] Schema updated and documented
- [ ] Both templates' `.dev-infra.yml` files contain the field with realistic entries
- [ ] Reference docs updated; cross-linked from template READMEs

---

## 🔗 Dependencies

- Group 2 (Template Cleanup) — populates the manifest only after the bundled skills are gone.
- Group 3 (Manifest Retirement) — runs after; the new manifest replaces the old sync-based approach.

---

**Last Updated:** 2026-05-22
