# Status & Next Steps — Skill-Template Separation (ADR-001)

**Status:** 🟠 In Progress
**Last Updated:** 2026-06-05

---

## 📊 Progress Summary

**Overall:** 18/25 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| Branch Setup & Doc Curation | ✅ Complete | 5/5 tasks | Merged PR #106 (2026-06-03) |
| Template Cleanup | ✅ Complete | 5/5 tasks | Merged PR #107 (2026-06-03); 82 bundled files removed |
| Template-Sync-Manifest Retirement | ✅ Complete | 4/4 tasks | Merged PR #108 (2026-06-04); `develop` Run Tests confirmed green post-merge |
| expected_skills Manifest in Templates | 🟠 In Progress | 4/4 tasks | PR pending — `.dev-infra.yml` + `docs/DEV-INFRA-YML.md` |
| proj-cli Validation | 🔴 Not Started | 0/4 tasks | Warn-not-error behavior |
| Documentation & Supersession | 🔴 Not Started | 0/3 tasks | global-command-distribution superseded; AGENTS.md updated |

---

## 🚀 Next Steps

1. **Merge Group 4 PR** — `expected_skills` manifest in templates.
2. **Group 5:** `proj-cli` validation (warn-not-error on missing expected skills).
3. **Group 6:** Documentation & supersession (mark `global-command-distribution` superseded, update AGENTS.md, cross-link from four-arm-architecture).

---

## 📝 Notes

- Plan generated from `decisions/adr-001-separation-model.md` on 2026-05-22.
- **Doc surface intent:** ADR-001 + planning tree on `develop`; research on `docs/skill-template-separation-research`.
- ADR-002 and ADR-003 out of scope for this plan.
- **CI:** Green on `develop` as of PR #108 merge (Run Tests `success` at 2026-06-04T16:40:38Z).
- **Group 4:** Bare skill identifiers chosen for `expected_skills` (matches `~/.cursor/skills/<name>/` layout); 13 entries mirror pre-#107 bundled corpus.

## 🧭 Decisions Made

- **Reference handling (Group 1 Task 4):** Strategy (c) — blockquote notes on research-branch artifacts.
- **Group 1 merge:** PR #106 landed ADR-001 + planning tree on `develop` (2026-06-03).
- **Group 2 merge:** PR #107 removed bundled template tooling; absence Bats added (2026-06-03). Merged with admin override on `validate-template-sync` failure, contingent on Group 3 landing the fix.
- **Group 3 merge:** PR #108 retired `template-sync-manifest.txt`, `validate-template-sync.sh`, dedicated Bats suite, and the CI workflow step that invoked them (2026-06-04). `develop` Run Tests confirmed green post-merge — Group 2's admin override is now resolved.
- **Group 4 identifier convention (Task 15):** Bare skill directory names (not namespaced) for `expected_skills` v1.

## 📋 Deferred

**From PR #106:**
- Absolute-path sweep in 11 develop-side files — tracked in `admin/feedback/deferred-tasks.md` (`PR106-Overall-#1-followup`).
- Research permalink conversion — deferred per Strategy (c); see `admin/feedback/sourcery/pr106.md`.

**From PR #108:**
- Task-doc `**Last Updated:**` deduplication — project-wide convention pattern across all 6 task docs (top metadata + trailing line). Tracked as `PR108-Overall-#2` in `admin/feedback/deferred-tasks.md` for a future convention-sweep PR.

---

**Last Updated:** 2026-06-05
