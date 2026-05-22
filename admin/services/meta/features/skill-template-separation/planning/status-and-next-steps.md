# Status & Next Steps — Skill-Template Separation (ADR-001)

**Status:** 🔴 Not Started
**Last Updated:** 2026-05-22

---

## 📊 Progress Summary

**Overall:** 0/25 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| Branch Setup & Doc Curation | 🔴 Not Started | 0/5 tasks | Theme 6 in practice — curate what merges to develop |
| Template Cleanup | 🔴 Not Started | 0/5 tasks | Mostly already deleted in working tree; this formalizes it |
| Template-Sync-Manifest Retirement | 🔴 Not Started | 0/4 tasks | Includes CI workflow updates |
| expected_skills Manifest in Templates | 🔴 Not Started | 0/4 tasks | New `.dev-infra.yml` field |
| proj-cli Validation | 🔴 Not Started | 0/4 tasks | Warn-not-error behavior |
| Documentation & Supersession | 🔴 Not Started | 0/3 tasks | global-command-distribution superseded; AGENTS.md updated |

---

## 🚀 Next Steps

1. Review scaffolding — verify group/task breakdown aligns with ADR-001 scope.
2. Expand groups — run `write-plan-expand` starting with Group 1 (Branch Setup) since it gates everything else.
3. Begin implementation on the new feature branch once Group 1 is expanded.

---

## 📝 Notes

- Plan generated from `decisions/adr-001-separation-model.md` on 2026-05-22.
- Planning subdir: `admin/services/meta/features/skill-template-separation/planning/` (default, not staged).
- **Doc surface intent:** This planning tree + ADR-001 are the only artifacts that merge to develop. Research and exploration stay on the `docs/skill-template-separation-research` branch.
- ADR-002 (installation architecture) and ADR-003 (per-repo profile schema) are explicitly out of scope for this plan — each will get its own.

---

**Last Updated:** 2026-05-22
