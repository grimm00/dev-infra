# Plan Review — Skill-Template Separation (Group 3)

**Feature:** skill-template-separation  
**Planning root:** `admin/services/meta/features/skill-template-separation/planning/`  
**Status:** ✅ Ready  
**Reviewed:** 2026-06-04  
**Scope:** Group 3 only (Tasks 11–14)

---

## 📋 Plan Structure

- [x] Implementation plan found and parseable
- [x] Group 3 task file exists (`tasks/03-template-sync-manifest-retirement.md`)
- [x] Checkbox census: Groups 1–2 complete (10/10); Group 3 pending (0/4)
- [x] Prior group PR #107 merged to `develop` (2026-06-03)

---

## 📝 Task Group Review

### Group 3: Template-Sync-Manifest Retirement (Tasks 11–14)

- **Header status:** Expanded in this cycle
- **Task count:** 4 (within 2–8 band)
- **Descriptions:** Audit → delete manifest → delete validator + Bats → remove CI step
- **Dependencies:** Group 2 complete via PR #107 — bundled `.cursor/commands/` removed from templates

---

## 🔗 Dependency Validation

- [x] Group 2 prerequisite satisfied (template command trees gone)
- [x] `develop` CI failure on `validate-template-sync` is expected pre-Group-3 — load-bearing fix for this group
- [x] `.sourcery.yaml` still identical across templates but manifest retirement is whole-mechanism per ADR-001 FR-BNDL-4 (not shrink-to-one-entry)
- [x] `docs/TEMPLATE-SYNC.md` and `AGENTS.md` prose deferred to Group 6 per plan boundaries

---

## 🔄 Consistency Check

- [x] `template-sync-manifest.txt` still lists 20+ removed `.cursor/commands/*` paths — Task 11–12 addresses
- [x] `.github/workflows/test.yml` still runs `validate-template-sync.sh` — Task 14 addresses
- [x] `tests/unit/validate-template-sync.bats` coupled to retired script — Task 13 addresses

---

## 🔴 Blockers

*(none)*

---

## 🟡 Warnings

- **Stale user doc:** `docs/TEMPLATE-SYNC.md` will describe retired tooling until Group 6 — note in PR body, not a Group 3 blocker.

---

## ✅ Readiness Assessment

**Verdict:** ✅ Ready to execute Group 3 on `feat/skill-template-separation-03-template-sync-manifest-retirement`.

**Next:** Expand task file → delete manifest/validator/tests → remove CI step → verify Bats green locally.
