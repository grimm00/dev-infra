# Installer Script

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Installer Script
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 10: Implement `install.sh`
  - Read the mapping from config, create symlinks from editor paths → corpus; idempotent re-runs (FR-INST-1, FR-INST-6, NFR-INST). Honor the Group 1 go/no-go (symlink vs copy mode).

- [ ] Task 11: Implement uninstall
  - Remove symlinks without touching the corpus (FR-INST-3; `stow -D` equivalent / reversibility).

- [ ] Task 12: Add standard flags
  - `--dry-run`, `--force`, `--verbose` per repo script standards.

- [ ] Task 13: Bats tests
  - Cover install, uninstall, idempotency, and the copy-mode fallback path.

---

## 🎯 Goals

1. A self-contained installer ships in the corpus repo (Tier 2 ready).
2. Installation is idempotent and fully reversible.

---

## ✅ Completion Criteria

- [ ] `install.sh` creates the mapped links idempotently
- [ ] Uninstall removes links, leaves corpus intact
- [ ] Standard flags implemented
- [ ] Bats suite passes (install / uninstall / idempotency / fallback)

---

## 🔗 Dependencies

- Group 1 (spike) — symlink vs copy decision.
- Group 3 (mapping/config) — the installer reads `installer.yaml`.

---

**Last Updated:** 2026-06-09
