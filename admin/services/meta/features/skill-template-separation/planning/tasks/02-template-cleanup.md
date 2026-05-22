# Template Cleanup

**Feature:** Skill-Template Separation (ADR-001)
**Group:** Template Cleanup
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-22

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 6: Audit current template tree for skill/command/agent residue
  - Inventory `templates/standard-project/.claude/skills/`, `templates/standard-project/.cursor/commands/`, `.cursor/agents/`, etc., across both templates.
  - Most working-tree state already shows mass deletions; formalize by committing the absence.

- [ ] Task 7: Remove `templates/standard-project/.claude/skills/` if present
  - Delete the directory tree if it exists; ensure git tracks the deletion.

- [ ] Task 8: Remove `templates/standard-project/.cursor/commands/` if present
  - Same as Task 7 for the Cursor commands directory.

- [ ] Task 9: Remove any agent files from `templates/`
  - Hunt for stray `.agents/` directories or `*.agent.md` files in either template.

- [ ] Task 10: Update template validation tests to confirm absence
  - Add Bats tests asserting the absence of these directories so future regressions get caught.

---

## 🎯 Goals

1. Templates carry zero authoritative skill/command/agent copies (FR-OWN-2, FR-BNDL-1).
2. Validation tests prevent re-bundling regressions.

---

## ✅ Completion Criteria

- [ ] Template trees verified clean of bundled tooling
- [ ] Bats tests added asserting absence; tests pass in CI
- [ ] Generated project (via `./scripts/new-project.sh`) contains no skills/commands/agents

---

## 🔗 Dependencies

- Group 1 (Branch Setup) — work happens on the new feature branch.

---

**Last Updated:** 2026-05-22
