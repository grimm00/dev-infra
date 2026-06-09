# Status & Next Steps — Skill Corpus Installation (ADR-002)

**Status:** 🔴 Not Started
**Last Updated:** 2026-06-09

---

## 📊 Progress Summary

**Overall:** 7/21 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| Symlink Loading Spike | ✅ Complete | 3/3 tasks | C-INST-1 **GO** (Cursor 3.7.19: discovery + live-edit verified). `~/.claude/` deferred to int-opp. See `spike-c-inst-1-findings.md`. |
| Corpus Repository Structure | ✅ Complete | 4/4 tasks | Two repos live: [agentic-ocean](https://github.com/grimm00/agentic-ocean) (public) + [agentic-ocean-personal](https://github.com/grimm00/agentic-ocean-personal) (private). Classified, bootstrapped (nightly), trimmed, migrated-split, READMEs, pushed. |
| Installer Mapping & XDG Config | 🔴 Not Started | 0/3 tasks | `installer.yaml` **multi-source** + `~/.config/agentic-ocean/` |
| Installer Script | 🔴 Not Started | 0/5 tasks | `install.sh` — idempotent, reversible, Bats-tested; + core→personal lint |
| Source Install & Multi-Machine (Tier 2) | 🔴 Not Started | 0/3 tasks | two-repo `clone → install` (private auth); retire proj-cli placeholder |
| Documentation & ADR Acceptance | 🔴 Not Started | 0/3 tasks | Guide + cross-links; ADR-002 → Accepted |

---

## 🚀 Next Steps

1. ✅ Group 1 (Symlink Loading Spike) complete (2026-06-09) — C-INST-1 resolved GO; symlink mode is the primary installer mechanism.
2. ✅ Plan re-partitioned (2026-06-09, 19→21 tasks) per `plan-review-2026-06-09.md` + ADR-001 — Groups 2–5 now reflect two repos, proj-cli-nightly bootstrap, multi-source mapping, the core→personal lint, and private-repo clone.
3. ✅ Group 2 (Corpus Repository Structure) **complete** (2026-06-09) — both repos exist, populated, and pushed (core public / personal private).
4. **Next: Group 3** (Installer Mapping & XDG Config) — expand, then build the multi-source `installer.yaml` + `~/.config/agentic-ocean/`. Group 3 onward authors files **in the corpus repo** (`agentic-ocean/install.sh`, etc.), not dev-infra.

**Cleanups done (2026-06-09):** `.dev-infra.yml` `version`/`created` placeholders filled in both repos (`0.11.0+nightly.88fc037`); `foobar` test command deleted from `~/.cursor/commands/` (now 21 = the migrated split). `expected_skills` kept as the core set — correct (those are the skills used when *working in* the repo). Remaining: `~/.cursor/` originals await the installer cutover (Groups 4–5).
4. The symlink-vs-copy decision is settled (symlink primary) — Groups 3–4 assume symlink mode, copy-mode is the documented contingency.

**Deferred (not v1):** `~/.claude/` symlink verification → `admin/planning/opportunities/internal/dev-infra/improvements/claude-path-symlink-verification.md`.

---

## 📝 Notes

- Plan generated from ADR-002 (Installation & Distribution Architecture) on 2026-06-09.
- **Planning root:** dev-infra layout, plain `planning/` under a new `ai-workflow/features/skill-corpus-installation/` feature (placement chosen 2026-06-09: groups installation with the corpus / skill-package-controller work rather than as a stage of skill-template-separation).
- **ADR location:** ADR-002 (source) and ADR-003 (downstream) were curated to develop at their original `meta/features/skill-template-separation/decisions/` paths to preserve research lineage; this plan references ADR-002 cross-feature.
- **ADR-002 status:** 🔴 Proposed at plan-creation time — acceptance is Task 19 (same pattern as ADR-001, which was accepted in its final group).
- **Scope boundary:** ADR-003 (per-repo profile schema) is a *separate* future plan. This plan only installs the `~/.config/agentic-ocean/repos/` symlink target; the profile schema/migration is out of scope.
- **Tier 3 (plugin publish) is deferred** per ADR-002 — not represented as a group.

---

**Last Updated:** 2026-06-09
