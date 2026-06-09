# Corpus Repository Structure

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Corpus Repository Structure
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 4: Define the corpus repo layout and name
  - Decide top-level structure (`skills/`, `commands/`, `agents/`) and repo name (ADR-002 uses `ai-workflow`).

- [ ] Task 5: Initialize the corpus repo and migrate the global corpus into it
  - Move the currently-untracked global corpus (`~/.cursor/skills/`, `~/.cursor/commands/`, `~/.cursor/agents/`, `~/.claude/skills/`) into the new repo as tracked source.

- [ ] Task 6: Add corpus README + independent versioning conventions
  - Document the corpus as its own product (ADR-001) with its own version/release story, independent of dev-infra.

---

## 🎯 Goals

1. The skill corpus has a real, versioned home (not untracked global files).
2. The repo is structured so the installer (Group 4) can map editor paths to subdirs.

---

## ✅ Completion Criteria

- [ ] Corpus repo exists with a defined layout
- [ ] Global corpus migrated in as tracked source
- [ ] README + versioning conventions documented

---

## 🔗 Dependencies

- Group 1 (spike) — confirms whether the installer will symlink or copy, which informs nothing structural here but gates the overall approach.

---

**Last Updated:** 2026-06-09
