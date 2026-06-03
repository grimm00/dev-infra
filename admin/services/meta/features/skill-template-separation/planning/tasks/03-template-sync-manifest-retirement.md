# Template-Sync-Manifest Retirement

**Feature:** Skill-Template Separation (ADR-001)
**Group:** Template-Sync-Manifest Retirement
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-05-22

> ⚠️ Scaffolding only — run `write-plan-expand` on this file to flesh out steps and acceptance criteria.

---

## 📝 Tasks

- [ ] Task 11: Audit `scripts/template-sync-manifest.txt` for remaining valid entries
  - Most entries are commented or archived; confirm what (if anything) still has legitimate sync purpose.
  - Surface any non-skill files that still need syncing (e.g., `.sourcery.yaml`) and route them appropriately.

- [ ] Task 12: Remove or repurpose the manifest file
  - Delete the file if nothing remains, or shrink to just the residual non-skill entries with a clear note.

- [ ] Task 13: Remove or update `scripts/validate-template-sync.sh`
  - If the manifest is gone, delete the script and references in `scripts/README.md`.
  - If the manifest is repurposed, update the script accordingly.

- [ ] Task 14: Remove related CI workflow steps that consume the manifest
  - Search `.github/workflows/` for invocations of `validate-template-sync.sh`; remove or adjust.

---

## 🎯 Goals

1. `template-sync-manifest.txt` and `validate-template-sync.sh` no longer enforce sync that doesn't exist (FR-BNDL-4).
2. CI does not fail or run dead validation steps.

---

## ✅ Completion Criteria

- [ ] Manifest file removed or minimized to its remaining purpose
- [ ] Validation script removed or updated; `scripts/README.md` reflects the change
- [ ] CI workflows green without the dead steps

---

## 🔗 Dependencies

- Group 2 (Template Cleanup) — should land first so the manifest's targets actually no longer exist.

---

**Last Updated:** 2026-05-22
