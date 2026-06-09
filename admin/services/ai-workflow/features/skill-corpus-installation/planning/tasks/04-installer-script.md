# Installer Script

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Installer Script
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-06-09

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 11: Implement `install.sh`
  - Read the **multi-source** mapping from config, create symlinks from editor paths → corpora; idempotent re-runs (FR-INST-1, FR-INST-6, NFR-INST). Symlink mode (Group 1 GO).

- [ ] Task 12: Implement uninstall
  - Remove symlinks without touching the corpora (FR-INST-3; `stow -D` equivalent / reversibility).

- [ ] Task 13: Add standard flags
  - `--dry-run`, `--force`, `--verbose` per repo script standards.

- [ ] Task 14: Implement the **"no core→personal references" check**
  - At install, fail/warn if a core artifact references something living only in the personal repo (ADR-001 invariant). Prevents core-only clones from silently breaking.

- [ ] Task 15: Bats tests
  - Cover install, uninstall, idempotency, copy-mode fallback, and the core→personal lint.

---

## 🎯 Goals

1. A self-contained installer ships in the corpus repo (Tier 2 ready).
2. Installation is idempotent and fully reversible.

---

## ✅ Completion Criteria

- [ ] `install.sh` creates the multi-source mapped links idempotently
- [ ] Uninstall removes links, leaves corpora intact
- [ ] Standard flags implemented
- [ ] Core→personal reference check enforced at install (ADR-001 invariant)
- [ ] Bats suite passes (install / uninstall / idempotency / fallback / core→personal lint)

---

## 🔗 Dependencies

- Group 1 (spike) — symlink vs copy decision.
- Group 3 (mapping/config) — the installer reads `installer.yaml`.

---

**Last Updated:** 2026-06-09
