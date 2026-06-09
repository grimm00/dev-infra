# Symlink Loading Spike

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Symlink Loading Spike
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 1: Build a minimal symlink test fixture
  - Symlink one real skill from a source dir into an editor path (`~/.cursor/skills/<name>`).
  - Keep it disposable/reversible so the spike leaves no residue.

- [ ] Task 2: Verify Cursor loads the symlinked skill in a live session
  - Confirm the skill is discovered/invocable via the symlink (the Cursor symlink bug is in *plugin* discovery — C-INST-1 tests whether skills use a different code path). Record a clear go/no-go.

- [ ] Task 3: Define the copy-mode fallback if symlink discovery fails
  - Specify the `cp`-based fallback the installer would use if Task 2 is no-go, so the rest of the plan can proceed either way.

---

## 🎯 Goals

1. Resolve C-INST-1 with runtime evidence before building the symlink farm.
2. Produce a go/no-go that the installer design (Group 4) depends on.

---

## ✅ Completion Criteria

- [ ] Symlink loading verified in a real Cursor session (or proven not to work)
- [ ] Go/no-go recorded with evidence
- [ ] Copy-mode fallback defined if symlinks fail

---

## 🔗 Dependencies

- None — this is the first group; everything downstream depends on its outcome.

---

**Last Updated:** 2026-06-09
