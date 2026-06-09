# Installer Mapping & XDG Config

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Installer Mapping & XDG Config
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 8: Define the `installer.yaml` **multi-source** mapping schema
  - Schema mapping editor paths (`~/.cursor/skills/` etc.) → subdirs across **two** source repos (core + personal) per ADR-001 (FR-INST-2, FR-INST-6). One mapping block per repo.

- [ ] Task 9: Establish the `~/.config/agentic-ocean/` config home + example mapping
  - XDG config location holding `installer.yaml` (core + personal blocks) and (later) `repos/` profiles; ship a documented example mapping.

- [ ] Task 10: Document XDG config vs corpus-project separation
  - Explain Theme 10: config is config (`~/.config/`), corpus is a project — the installer bridges them.

---

## 🎯 Goals

1. A declarative, human-editable mapping drives installation (no hardcoded paths).
2. Config lives at the XDG-correct location, separate from the corpus.

---

## ✅ Completion Criteria

- [ ] `installer.yaml` schema defined and documented
- [ ] `~/.config/agentic-ocean/` home established with an example mapping
- [ ] Config-vs-corpus separation documented

---

## 🔗 Dependencies

- Group 2 (corpus structure) — mapping targets the corpus subdirs defined there.

---

**Last Updated:** 2026-06-09
