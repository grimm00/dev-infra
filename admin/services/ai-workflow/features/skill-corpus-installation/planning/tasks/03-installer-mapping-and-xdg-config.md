# Installer Mapping & XDG Config

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Installer Mapping & XDG Config
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 7: Define the `installer.yaml` mapping schema
  - Schema mapping editor paths (e.g. `~/.cursor/skills/`, `~/.claude/skills/`) → corpus subdirs (FR-INST-2, FR-INST-6).

- [ ] Task 8: Establish the `~/.config/ai-workflow/` config home + example mapping
  - XDG config location holding `installer.yaml` and (later) `repos/` profiles; ship a documented example mapping.

- [ ] Task 9: Document XDG config vs corpus-project separation
  - Explain Theme 10: config is config (`~/.config/`), corpus is a project — the installer bridges them.

---

## 🎯 Goals

1. A declarative, human-editable mapping drives installation (no hardcoded paths).
2. Config lives at the XDG-correct location, separate from the corpus.

---

## ✅ Completion Criteria

- [ ] `installer.yaml` schema defined and documented
- [ ] `~/.config/ai-workflow/` home established with an example mapping
- [ ] Config-vs-corpus separation documented

---

## 🔗 Dependencies

- Group 2 (corpus structure) — mapping targets the corpus subdirs defined there.

---

**Last Updated:** 2026-06-09
