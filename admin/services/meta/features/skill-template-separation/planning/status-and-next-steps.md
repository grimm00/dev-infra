# Status & Next Steps — Skill-Template Separation (ADR-001)

**Status:** 🟠 In Progress
**Last Updated:** 2026-05-22

---

## 📊 Progress Summary

**Overall:** 5/25 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| Branch Setup & Doc Curation | ✅ Complete | 5/5 tasks | Plan B executed; stale research scaffolds replaced with ADR-001 + planning |
| Template Cleanup | 🔴 Not Started | 0/5 tasks | Mostly already deleted in working tree; this formalizes it |
| Template-Sync-Manifest Retirement | 🔴 Not Started | 0/4 tasks | Includes CI workflow updates |
| expected_skills Manifest in Templates | 🔴 Not Started | 0/4 tasks | New `.dev-infra.yml` field |
| proj-cli Validation | 🔴 Not Started | 0/4 tasks | Warn-not-error behavior |
| Documentation & Supersession | 🔴 Not Started | 0/3 tasks | global-command-distribution superseded; AGENTS.md updated |

---

## 🚀 Next Steps

1. Push the `feat/skill-template-separation` branch and open a PR to `develop` for Group 1 (review of the curated artifacts).
2. After Group 1 PR merges: expand Group 2 (Template Cleanup) and proceed.
3. Continue group-by-group on this branch (single PR per group, all targeting `develop`).

---

## 📝 Notes

- Plan generated from `decisions/adr-001-separation-model.md` on 2026-05-22.
- Planning subdir: `admin/services/meta/features/skill-template-separation/planning/` (default, not staged).
- **Doc surface intent:** This planning tree + ADR-001 are the only artifacts that merge to develop. Research and exploration stay on the `docs/skill-template-separation-research` branch.
- ADR-002 (installation architecture) and ADR-003 (per-repo profile schema) are explicitly out of scope for this plan — each will get its own.

## 🧭 Decisions Made

- **Reference handling (Group 1 Task 4):** Strategy (c) — kept the `../research/...` and `../decisions/adr-002...` style links in ADR-001 and `implementation-plan.md`, added a one-line blockquote note at the top of each affected section explaining the artifacts live on the research branch. Lightest touch; uniform breakage made one explanation sufficient.
- **Discovery during Group 1 Task 1:** develop already had stale research scaffolds (from PR #103) under this feature dir. Chose Option C — delete them as part of replacing-with-ADR-001 — so develop's state reflects the curation intent rather than zombie "🔴 Not Started" placeholders for research that's actually complete.

---

**Last Updated:** 2026-05-22
