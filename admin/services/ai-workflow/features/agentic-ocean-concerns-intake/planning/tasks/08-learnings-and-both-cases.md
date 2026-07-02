# Learnings-as-concerns + BOTH cases

**Feature:** agentic-ocean-concerns-intake
**Group:** 8 — Learnings-as-concerns + BOTH cases
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-07-02

> ⚠️ **Scaffolding:** Run `write-plan-expand` to add detailed implementation notes.
>
> **Executor:** `migrate-concern` subagent (Track β) for Tasks 19 and 20; human
> for Task 18 (classification judgment) and Task 21 (dev-infra cross-link
> edits, which are dev-infra-side and can also be done by `group-cycle` or by
> the subagent depending on how it's designed).

---

## 📝 Tasks

- [ ] Task 18: Skim `worktree-feature-workflow/` learnings to confirm BOTH vs STAY
  - Read directory contents and classify; update `planning/inputs/triage-table.md` with the resolved recommendation.
  - Human task — classification is judgment work.

- [ ] Task 19: Author 3 concern docs in agentic-ocean from learnings docs
  - Source files (under `admin/planning/opportunities/internal/dev-infra/learnings/`):
    - `agentic-workflow-stage3-pipeline-synthesis-gap.md` (3 sub-concerns — split into 3 separate concern docs, or keep as 1 doc with 3 sections? Resolve when expanding this task.)
    - `orchestrating-from-develop-and-chat-as-agent-learnings.md` (2 sub-concerns — same splitting question)
    - `research-artifact-lifecycle-learnings.md`
  - Each concern doc lands at `agentic-ocean/concerns/<subdir>/<slug>.md` (subdir per Group 1's taxonomy — working lean: `learnings/`).
  - "3 concern docs" is the minimum count assuming no sub-splits; actual count may be up to 6 if sub-concerns split out.

- [ ] Task 20: Author 2–3 concern docs in agentic-ocean for BOTH int-opps (corpus-half)
  - Source files:
    - `admin/planning/opportunities/internal/dev-infra/improvements/conventions-md-gap.md`
    - `admin/planning/opportunities/internal/dev-infra/improvements/feature-work-bypassed-pr-via-docs-allowance.md`
    - `admin/planning/opportunities/internal/dev-infra/learnings/worktree-feature-workflow/` (only if Task 18 resolves it as BOTH)
  - Each concern doc scopes to the **corpus half** of the BOTH concern, land under `agentic-ocean/concerns/<subdir>/`. Subdir per Group 1 (mix of `skill-architecture/`, `pipeline-design/`, or a dedicated `both-cases/` — resolve when expanding).

- [ ] Task 21: Add cross-link markers in all dev-infra-side BOTH records
  - Source records stay in dev-infra (template/process half) with explicit pointer to the corpus-side concern-doc path.
  - This is dev-infra-side work — can go through `group-cycle` (as a docs commit) or through the `migrate-concern` subagent's dev-infra-annotation mode, TBD in Track β.

---

## 🎯 Goals

1. Migrate the highest-value, hardest-to-flatten concerns without losing their structured form.
2. Establish the BOTH cross-link pattern (concern lives in both repos, scoped per repo) as the durable convention.

---

## ✅ Completion Criteria

- [ ] `worktree-feature-workflow/` classification resolved in triage table
- [ ] 3+ learning-derived concern docs authored + committed in agentic-ocean
- [ ] 2–3 BOTH corpus-side concern docs authored + committed in agentic-ocean
- [ ] All dev-infra-side BOTH records cross-linked

---

## 🔗 Dependencies

- **Group 1** (channel dir must exist)
- **Track α** (this rewrite)
- **Track β** (`migrate-concern` subagent)
- Logically after Groups 3–7 (so the concern-doc conventions and any subdir refinements are established)

---

**Last Updated:** 2026-07-02
