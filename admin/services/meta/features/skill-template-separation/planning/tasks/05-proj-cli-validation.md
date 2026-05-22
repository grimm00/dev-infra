# proj-cli Validation

**Feature:** Skill-Template Separation (ADR-001)
**Group:** proj-cli Validation
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-22

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 19: Design `proj-cli` `expected_skills` validation step (warn-not-error)
  - Where in the setup flow does validation run? (After project generation, before first agent invocation?)
  - What does "skill is installed" mean? (Presence at `~/.cursor/skills/<name>/` or via the lookup chain from ADR-003?)

- [ ] Task 20: Implement validation logic in `proj-cli` setup flow
  - Read `expected_skills` from generated `.dev-infra.yml`; for each entry, check installed state.
  - Emit a warning for missing skills; never block setup.

- [ ] Task 21: Add install-guidance message text pointing to the corpus
  - Tell the user where to find the corpus repo and how to install it (placeholder until ADR-002 lands).

- [ ] Task 22: Test graceful degradation (generated project works without skills installed)
  - Generate a project with no skills installed; confirm CI passes and AGENTS.md still orients the agent.

---

## 🎯 Goals

1. `proj-cli` validates `expected_skills` and warns on missing entries (FR-BNDL-3).
2. Missing skills never block project setup (NFR-BNDL-1: graceful degradation).
3. Users get clear install guidance.

---

## ✅ Completion Criteria

- [ ] Validation step implemented and unit-tested
- [ ] Graceful-degradation test scenario passes
- [ ] Install-guidance text reviewed and merged

---

## 🔗 Dependencies

- Group 4 (expected_skills Manifest) — validation needs the field to exist in `.dev-infra.yml`.

---

**Last Updated:** 2026-05-22
