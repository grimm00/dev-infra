# Status & Next Steps — Skill-Template Separation (ADR-001)

**Status:** 🟠 In Progress
**Last Updated:** 2026-06-04

---

## 📊 Progress Summary

**Overall:** 10/25 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| Branch Setup & Doc Curation | ✅ Complete | 5/5 tasks | Merged PR #106 (2026-06-03) |
| Template Cleanup | ✅ Complete | 5/5 tasks | Merged PR #107 (2026-06-03); 82 bundled files removed |
| Template-Sync-Manifest Retirement | 🟠 In Progress | 0/4 tasks | Restores `develop` CI (`validate-template-sync` red post-#107) |
| expected_skills Manifest in Templates | 🔴 Not Started | 0/4 tasks | New `.dev-infra.yml` field |
| proj-cli Validation | 🔴 Not Started | 0/4 tasks | Warn-not-error behavior |
| Documentation & Supersession | 🔴 Not Started | 0/3 tasks | global-command-distribution superseded; AGENTS.md updated |

---

## 🚀 Next Steps

1. Complete Group 3 PR (manifest + validator + CI step retirement) → merge to `develop` → expect Run Tests green.
2. Continue group-by-group (Groups 4–6).

---

## 📝 Notes

- Plan generated from `decisions/adr-001-separation-model.md` on 2026-05-22.
- **Doc surface intent:** ADR-001 + planning tree on `develop`; research on `docs/skill-template-separation-research`.
- ADR-002 and ADR-003 out of scope for this plan.
- **CI:** `quick-checks` / `validate-template-sync` fails on `develop` after PR #107 until Group 3 lands (admin override on #107).

## 🧭 Decisions Made

- **Reference handling (Group 1 Task 4):** Strategy (c) — blockquote notes on research-branch artifacts.
- **Group 1 merge:** PR #106 landed ADR-001 + planning tree on `develop` (2026-06-03).
- **Group 2 merge:** PR #107 removed bundled template tooling; absence Bats added (2026-06-03).

## 📋 Deferred (PR #106)

- Absolute-path sweep in 11 develop-side files — tracked in `admin/feedback/deferred-tasks.md` (PR106-Overall-#1-followup).
- Research permalink conversion — deferred per Strategy (c); see `admin/feedback/sourcery/pr106.md`.

---

**Last Updated:** 2026-06-04
