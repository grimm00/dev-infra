# Corpus Classification — Core vs Personal (Task 4)

**Feature:** Skill Corpus Installation (ADR-002)
**Task:** Group 2 / Task 4
**Status:** ✅ Complete
**Date:** 2026-06-09

Applies the [ADR-001](../decisions/adr-001-corpus-repo-split-model.md) boundary test to
the authored corpus inventory (`corpus-repo-reference.md`). Output drives Tasks 5–6
(bootstrap + migrate-split).

**Boundary test:** an item is **core** if (a) general-purpose/durable **or** (b) any core
item depends on it; otherwise **personal**. **Invariant:** no core→personal dependencies.

---

## Skills (19)

| Skill | Class | Reason |
|-------|-------|--------|
| commit | core | general; pre-commit-review twin |
| decision | core | general workflow |
| discuss | core | general workflow |
| explore | core | general workflow |
| handoff | core | general workflow |
| int-opp | core | general workflow |
| narrative | core | general workflow |
| plan-review | core | general; depended on by `group-cycle.agent` |
| pre-commit-review | core | general; depended on by `commit`/agents |
| reflect | core | general workflow |
| research | core | general workflow |
| spike | core | general workflow |
| update-pr-description | **core** | **dependency-forced** — `group-cycle.agent` Step 3 calls it |
| write-plan | core | general workflow |
| apprentice-eod | personal | apprenticeship-scoped; natural expiration |
| apprentice-standup | personal | apprenticeship-scoped; natural expiration |
| capture-discussion | personal | ad-hoc/personal |
| ticket-create | personal | employer/ticket-convention-coupled |
| ticket-intake | personal | employer/ticket-convention-coupled |

**Core: 14 · Personal: 5**

---

## Commands (22)

| Command | Class | Reason |
|---------|-------|--------|
| address-review, agent-dispatch, cursor-rules, fix-implement, fix-plan, fix-review, post-pr, post-release, pr, pr-validation, pre-phase-review, reflection-artifacts, release-finalize, release-prep, status, task, task-improvement, task-phase, task-release, transition-plan | core | general dev-infra workflow commands |
| work-dispatch | personal | work-ticket cycles in non-dev-infra repos; depends on `ticket-intake` |
| foobar | personal (ad-hoc) | scratch/test command — **delete candidate**; do not migrate unless intentional |

**Core: 20 · Personal: 2** (one a delete candidate)

---

## Agents (3)

| Agent | Class | Reason |
|-------|-------|--------|
| group-cycle.agent | core | general group-cycle pipeline (PR + CI ceremony) |
| group-cycle-work.agent | personal | ticket-driven *work* variant; depends on `ticket-intake` |
| research-orchestrator/ | core | general research orchestration |

**Core: 2 · Personal: 1**

---

## Dependency Sweep (invariant check)

Swept all skills/commands/agents for references to personal-classified items
(`apprentice-*`, `ticket-create`, `ticket-intake`, `capture-discussion`). Hits:

| Referencing item | References | Verdict |
|------------------|-----------|---------|
| `group-cycle-work.agent` (personal) | `ticket-intake` (personal) | ✅ personal→personal — allowed |
| `work-dispatch` (personal) | `ticket-intake` (personal) | ✅ personal→personal — allowed |

**The core `group-cycle.agent` was NOT flagged** — it has no personal dependency.
**Invariant holds: zero core→personal references.** No reclassification needed.

---

## Notable observations

1. **A coherent "work" sub-cluster exists** — `group-cycle-work.agent`, `work-dispatch`,
   `ticket-create`, `ticket-intake`. All personal, all employer/ticket-coupled, and
   internally dependent. ADR-001 commits to **two** repos, so these go in `personal` for
   now — but if the personal repo later grows unwieldy, this cluster is the natural seam
   for a future third "work" repo. Out of scope here; flagged for awareness.
2. **`foobar`** is almost certainly scratch — recommend deleting it rather than migrating.
   Confirm before Task 6.
3. **`update-pr-description` core membership is the headline fix** — its absence from a
   personal-only checkout is what caused the agent gaps on the other machine.

---

## Tallies (for Task 6 reconciliation)

| | Core | Personal |
|--|------|----------|
| Skills | 14 | 5 |
| Commands | 20 | 2 (incl. `foobar` delete-candidate) |
| Agents | 2 | 1 |
| **Total** | **36** | **8** |

---

**Last Updated:** 2026-06-09
