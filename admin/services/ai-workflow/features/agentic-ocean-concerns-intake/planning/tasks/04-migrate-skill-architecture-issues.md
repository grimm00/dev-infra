# Migrate skill-architecture concerns

**Feature:** agentic-ocean-concerns-intake
**Group:** 4 — Migrate skill-architecture concerns
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-07-02

> ⚠️ **Scaffolding:** Run `write-plan-expand` to add detailed implementation notes.
>
> **Executor:** `migrate-concern` subagent (Track β) for the 3 issue-sourced
> docs and the 1 discuss-sourced doc; the discuss-sourced input mode must be
> supported by the subagent per design-decisions.md D3.

---

## 📝 Tasks

- [ ] Task 10: Author 4 concern docs in agentic-ocean — 3 from dev-infra #71, #102, #114 + 1 from chat [88f83db8](88f83db8-f63e-4959-ad2f-50544fa87cce)
  - Larger architectural concerns landing under `agentic-ocean/concerns/<subdir>/` (subdir per Group 1's taxonomy — working lean: `skill-architecture/`).
    - **From #71:** `/manual-testing` command introduction; slim `/pr-validation`.
    - **From #102:** directory-based agents + unified dispatch. **Rewrite the "Recommended Approach" section** so the routing recommendation points at agentic-ocean rather than dev-infra.
    - **From #114:** research topic-directories + conduct chunks (partial completion semantics).
    - **From chat 88f83db8:** "Skills describe shape, not location; base-dir configurable via `references/structure.yaml`". Discuss-only source — no dev-infra doc to link back to; link header cites the chat transcript. Filename lean: `skills-describe-shape-not-location.md`.
  - Sits topically next to #102 (both are agent/skill architecture) — Group 1's subdir choice should keep them colocated.

- [ ] Task 11: Cross-link and close dev-infra originals
  - Same link-back convention as Group 3 for the 3 issue-sourced concern docs.
  - No dev-infra close needed for the 88f83db8-sourced doc (no source issue exists).

---

## 🎯 Goals

1. Migrate the architectural concerns that will most actively shape agentic-ocean's near-term roadmap.
2. Resolve the self-referential routing issue inside #102.
3. Give the "skills describe shape, not location" concern a durable home rather than leaving it in a chat transcript.

---

## ✅ Completion Criteria

- [ ] 4 concern docs authored + committed in agentic-ocean (3 from issues + 1 from chat)
- [ ] #102's transformed body rewritten to route to agentic-ocean
- [ ] All 3 dev-infra issues (#71, #102, #114) closed with cross-link comment
- [ ] Triage table updated with destination doc paths

---

## 🔗 Dependencies

- **Group 1** (channel dir must exist)
- **Track α** (this rewrite; and the 88f83db8 triage row exists in `inputs/triage-table.md`)
- **Track β** (`migrate-concern` subagent — must support both issue-sourced and discuss-sourced input modes per D3)

---

**Last Updated:** 2026-07-02
