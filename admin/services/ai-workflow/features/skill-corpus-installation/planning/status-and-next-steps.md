# Status & Next Steps — Skill Corpus Installation (ADR-002)

**Status:** 🔴 Not Started
**Last Updated:** 2026-06-09

---

## 📊 Progress Summary

**Overall:** 1/19 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| Symlink Loading Spike | 🟠 In Progress | 1/3 tasks | Task 1 fixture built (`~/.cursor/skills/spike-probe`); Task 2 needs live observation |
| Corpus Repository Structure | 🔴 Not Started | 0/3 tasks | Establish corpus repo; migrate global corpus |
| Installer Mapping & XDG Config | 🔴 Not Started | 0/3 tasks | `installer.yaml` + `~/.config/ai-workflow/` |
| Installer Script | 🔴 Not Started | 0/4 tasks | `install.sh` — idempotent, reversible, Bats-tested |
| Source Install & Multi-Machine (Tier 2) | 🔴 Not Started | 0/3 tasks | `clone → install`; retire proj-cli placeholder |
| Documentation & ADR Acceptance | 🔴 Not Started | 0/3 tasks | Guide + cross-links; ADR-002 → Accepted |

---

## 🚀 Next Steps

1. ✅ Group 1 (Symlink Loading Spike) expanded (2026-06-09) — tasks now carry Purpose/Steps/Files/Acceptance.
2. Execute Group 1 — it's a spike (no PR-worthy code yet); run it interactively to get the C-INST-1 go/no-go, since it needs a live Cursor session + editor config the agent-dispatch flow can't drive headlessly.
3. Expand remaining groups (2–6) via write-plan **Expand** once the spike outcome is known — the symlink-vs-copy decision shapes Groups 3–4.

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
