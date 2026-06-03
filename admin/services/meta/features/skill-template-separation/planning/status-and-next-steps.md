# Status & Next Steps — Skill-Template Separation (ADR-001)

**Status:** 🟠 In Progress
**Last Updated:** 2026-06-03

---

## 📊 Progress Summary

**Overall:** 10/25 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| Branch Setup & Doc Curation | ✅ Complete | 5/5 tasks | Merged PR #106 (2026-06-03) |
| Template Cleanup | ✅ Complete | 5/5 tasks | PR pending; 82 bundled files removed; absence Bats added |
| Template-Sync-Manifest Retirement | 🔴 Not Started | 0/4 tasks | Required after Group 2 for full CI green |
| expected_skills Manifest in Templates | 🔴 Not Started | 0/4 tasks | New `.dev-infra.yml` field |
| proj-cli Validation | 🔴 Not Started | 0/4 tasks | Warn-not-error behavior |
| Documentation & Supersession | 🔴 Not Started | 0/3 tasks | global-command-distribution superseded; AGENTS.md updated |

---

## 🚀 Next Steps

1. Complete Group 2 PR (template cleanup + absence tests) → merge to `develop`.
2. Group 3: retire `template-sync-manifest.txt` and `validate-template-sync.sh` (restores CI after command removal).
3. Continue group-by-group (Groups 4–6).

---

## 📝 Notes

- Plan generated from `decisions/adr-001-separation-model.md` on 2026-05-22.
- **Doc surface intent:** ADR-001 + planning tree on `develop`; research on `docs/skill-template-separation-research`.
- ADR-002 and ADR-003 out of scope for this plan.

## 🧭 Decisions Made

- **Reference handling (Group 1 Task 4):** Strategy (c) — blockquote notes on research-branch artifacts.
- **Group 1 merge:** PR #106 landed ADR-001 + planning tree on `develop` (2026-06-03).

## 📋 Deferred (PR #106)

- Absolute-path sweep in 11 develop-side files — tracked in `admin/feedback/deferred-tasks.md` (PR106-Overall-#1-followup).
- Research permalink conversion — deferred per Strategy (c); see `admin/feedback/sourcery/pr106.md`.

---

**Last Updated:** 2026-06-03
