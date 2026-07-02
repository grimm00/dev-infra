# Status & Next Steps — agentic-ocean-concerns-intake

**Status:** 🔴 Not Started (scaffolding only)
**Last Updated:** 2026-06-22

---

## 📊 Progress Summary

**Overall:** 0/25 tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| 1. Concerns channel shape in agentic-ocean | 🔴 Scaffolding | 0/4 tasks | Gates Groups 5–8 (the int-opp migrations). Group 1 must finish before any BOTH/learnings work |
| 2. Dev-infra source-side prep | 🔴 Scaffolding | 0/3 tasks | Independent of Group 1; #78/#113 splits + MOOT closes |
| 3. Migrate skill-bug issues | 🔴 Scaffolding | 0/2 tasks | Smallest bug-shaped issues; lowest risk batch to run first |
| 4. Migrate skill-architecture issues | 🔴 Scaffolding | 0/2 tasks | #102 requires rewriting its own "Recommended Approach" section |
| 5. Migrate corpus mechanics int-opps | 🔴 Scaffolding | 0/2 tasks | Depends on Group 1 (channel exists for link-backs) |
| 6. Migrate pipeline/design int-opps (batch A) | 🔴 Scaffolding | 0/2 tasks | Depends on Group 1 |
| 7. Migrate pipeline/design int-opps (batch B) | 🔴 Scaffolding | 0/2 tasks | Depends on Group 1 |
| 8. Learnings-as-concerns + BOTH cases | 🔴 Scaffolding | 0/4 tasks | Depends on Group 1; the int-opps don't squash cleanly into issues |
| 9. Hubs + verification + status doc | 🔴 Scaffolding | 0/4 tasks | Final group; runs after every migration group |

---

## 🚀 Next Steps

1. Review scaffolding — verify group/task breakdown against `planning/inputs/triage-table.md`.
2. Decide branch strategy — currently scaffolded on `docs/skill-corpus-installation-followup`; this is feature-shaped work so a `feat/agentic-ocean-concerns-intake` branch + worktree is likely the right move per AGENTS.md Git Flow conventions.
3. Expand Group 1 first — run `write-plan-expand` for `tasks/01-concerns-channel-shape.md`. It gates 5 of the other 8 groups.
4. Consider expanding Group 2 in parallel — it's independent of Group 1 and can run on its own track (small, dev-infra-side housekeeping).
5. After Group 1 lands the channel decision, expand groups in dependency order: 3 → 4 → 5 → 6 → 7 → 8 → 9.

---

## 📝 Notes

- **Plan source:** chat-only `/discuss` session 2026-06-22, materialized to `planning/inputs/triage-table.md` as the on-disk source artifact before scaffolding.
- **Input mode:** `from_artifacts` (the triage table).
- **Planning root convention:** `admin/services/ai-workflow/features/agentic-ocean-concerns-intake/planning/` (dev-infra feature layout, non-staged — no prior `planning-stageN/` siblings).
- **Cross-repo nature:** Plan lives in dev-infra (source of the migration). Execution writes to agentic-ocean (issue filing + channel scaffolding) and dev-infra (issue splits, MOOT closes, int-opp link-backs, hub updates). Each expanded group should be explicit about which repo its tasks touch.
- **Dependency on `agentic-ocean` repo state:** The migration assumes agentic-ocean stays roughly in its current shape (flat corpus + `docs/`, no `admin/` tree). If a separate restructure lands first, Group 1's options need re-evaluation.
- **HISTORICAL items not in scope:** Completed int-opps and feature-cycle retrospectives stay in dev-infra. The plan only acts on open concerns.
- **Subagent opportunity:** Groups 5–7 are mechanical (read source artifact → draft issue body → `gh issue create`). A small migration subagent could batch each group; consider as a dogfooding tie-in to issue #102 (agent architecture).

---

**Last Updated:** 2026-06-22
