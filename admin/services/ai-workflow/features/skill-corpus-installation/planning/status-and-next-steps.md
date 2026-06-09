# Status & Next Steps — Skill Corpus Installation (ADR-002)

**Status:** 🔴 Not Started
**Last Updated:** 2026-06-09

---

## 📊 Progress Summary

**Overall:** 3/21 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| Symlink Loading Spike | ✅ Complete | 3/3 tasks | C-INST-1 **GO** (Cursor 3.7.19: discovery + live-edit verified). `~/.claude/` deferred to int-opp. See `spike-c-inst-1-findings.md`. |
| Corpus Repository Structure | 🔴 Not Started | 0/4 tasks | **Two** repos (core + personal, ADR-001); proj-cli nightly bootstrap; split migration |
| Installer Mapping & XDG Config | 🔴 Not Started | 0/3 tasks | `installer.yaml` **multi-source** + `~/.config/ai-workflow/` |
| Installer Script | 🔴 Not Started | 0/5 tasks | `install.sh` — idempotent, reversible, Bats-tested; + core→personal lint |
| Source Install & Multi-Machine (Tier 2) | 🔴 Not Started | 0/3 tasks | two-repo `clone → install` (private auth); retire proj-cli placeholder |
| Documentation & ADR Acceptance | 🔴 Not Started | 0/3 tasks | Guide + cross-links; ADR-002 → Accepted |

---

## 🚀 Next Steps

1. ✅ Group 1 (Symlink Loading Spike) complete (2026-06-09) — C-INST-1 resolved GO; symlink mode is the primary installer mechanism.
2. ✅ Plan re-partitioned (2026-06-09, 19→21 tasks) per `plan-review-2026-06-09.md` + ADR-001 — Groups 2–5 now reflect two repos, proj-cli-nightly bootstrap, multi-source mapping, the core→personal lint, and private-repo clone.
3. **Expand Group 2** (Corpus Repository Structure) via write-plan **Expand**, then execute. Note: most of Groups 2–5 produce artifacts in the **external corpus repo(s)**, not dev-infra — so they won't follow the in-dev-infra `/task` + PR flow cleanly.
4. The symlink-vs-copy decision is settled (symlink primary) — Groups 3–4 assume symlink mode, copy-mode is the documented contingency.

**Deferred (not v1):** `~/.claude/` symlink verification → `admin/planning/opportunities/internal/dev-infra/improvements/claude-path-symlink-verification.md`.

---

## 📝 Notes

- Plan generated from ADR-002 (Installation & Distribution Architecture) on 2026-06-09.
- **Planning root:** dev-infra layout, plain `planning/` under a new `ai-workflow/features/skill-corpus-installation/` feature (placement chosen 2026-06-09: groups installation with the corpus / skill-package-controller work rather than as a stage of skill-template-separation).
- **ADR location:** ADR-002 (source) and ADR-003 (downstream) were curated to develop at their original `meta/features/skill-template-separation/decisions/` paths to preserve research lineage; this plan references ADR-002 cross-feature.
- **ADR-002 status:** 🔴 Proposed at plan-creation time — acceptance is Task 19 (same pattern as ADR-001, which was accepted in its final group).
- **Scope boundary:** ADR-003 (per-repo profile schema) is a *separate* future plan. This plan only installs the `~/.config/ai-workflow/repos/` symlink target; the profile schema/migration is out of scope.
- **Tier 3 (plugin publish) is deferred** per ADR-002 — not represented as a group.

---

**Last Updated:** 2026-06-09
