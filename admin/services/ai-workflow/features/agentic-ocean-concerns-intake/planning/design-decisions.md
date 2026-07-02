# Design Decisions — agentic-ocean-concerns-intake

**Status:** ✅ Captured
**Session:** 2026-07-02 `/discuss` (halted `/agent-dispatch` pre-flight)
**Last Updated:** 2026-07-02

---

## Context

The intake plan was scaffolded on 2026-06-22 (25 tasks / 9 groups) but never
expanded or executed. When `/agent-dispatch agentic-ocean-concerns-intake
01-concerns-channel-shape` was invoked on 2026-07-02, pre-flight surfaced two
blockers:

1. **Untracked scaffolding** — the plan tree existed only in the working tree.
   RESOLVED: committed to `docs/skill-corpus-installation-followup` at `ddb35bd`
   before this discussion started.
2. **Cross-repo execution mismatch** — Groups 1 + 3–8 have deliverables in
   `grimm00/agentic-ocean`, but the `group-cycle` agent is
   dev-infra-worktree-shaped. **This doc captures the resolution.**

A new concern from [88f83db8](88f83db8-f63e-4959-ad2f-50544fa87cce) ("skills
describe shape, not location") post-dates the 2026-06-22 triage and needs to
slot into the plan (see D4).

---

## Decisions

### D1 — Concerns channel shape: flat-root markdown

The concerns channel in `agentic-ocean` will be a **flat-root markdown tree** at
`agentic-ocean/concerns/…`, organized into topical subdirs (e.g.
`skill-architecture/`, `skill-bugs/`, `corpus-mechanics/`, `pipeline-design/`,
`learnings/`). Exact subdir taxonomy is Group 1's call — this decision only
fixes the root shape and file format.

**Alternatives considered** (from Task 1's original three, plus one added
during this session):

- **`gh` issues only** (with labels + templates) — rejected: loses composability
  with the corpus's markdown-first documentation posture; concerns need to be
  reference-able from ADRs and other markdown.
- **`admin/services/` mirror of dev-infra** — rejected: too heavy for
  agentic-ocean's current flat repo shape (`corpus/`, `docs/`, `scripts/`,
  `tests/`, bootstrap scripts, no `admin/` tree).
- **Per-artifact colocation** (concern lives next to the skill/agent it
  touches) — rejected: hurts discoverability of the open-concern surface for
  contributors landing on the repo cold.

Group 1's `/decision` in `agentic-ocean` is the durable record of this choice.
This doc is the dev-infra-side context (the "why we walked into that decision
with this lean").

### D2 — Execution split across three tracks

The intake plan cannot be executed by a single dispatch of the current
`group-cycle` agent. The execution splits by repo boundary and by
judgment-vs-ceremony:

| Groups | Executor | Repo | Rationale |
|--------|----------|------|-----------|
| **1** — channel scaffolding + ADR | Human | agentic-ocean | Judgment work; `/decision` needs human-in-the-loop |
| **2, 9** — dev-infra prep + hubs/verification | `group-cycle` (as-shipped) | dev-infra | Pure dev-infra; matches existing agent shape |
| **3–8** — author ~24 concern docs from triage rows | New `migrate-concern` subagent | agentic-ocean | Mechanical + repeatable; current group-cycle can't write to a second repo |

### D3 — `migrate-concern` subagent: narrow scope

Purpose-built for this feature. Archived (or fully deleted) once intake
completes. **No general-purpose cross-repo agent this pass** — the full
`/group-cycle-work` variant from [88f83db8](88f83db8-f63e-4959-ad2f-50544fa87cce)
is deliberately deferred until we have real usage data from this narrow
version.

**Proposed shape (formalize in Track β):**

- **Inputs:**
  - `triage_row_id` — key into `planning/inputs/triage-table.md`
  - `source_path` — dev-infra path to source int-opp doc, OR remote issue
    number, OR chat transcript ID (for discuss-only concerns like 88f83db8)
  - `target_subdir` — subdir under `agentic-ocean/concerns/`
- **Behavior:**
  - Read source; transform to concern doc with a link-back header
    (source URL/path, migration date, triage row reference)
  - Write to `~/Projects/agentic-ocean/concerns/<subdir>/<slug>.md`
  - Commit in agentic-ocean with a conventional message
    (`docs(concerns): migrate <slug> from dev-infra <source>`)
- **Non-goals:**
  - PR creation in agentic-ocean (batch multiple concern docs into one PR
    manually)
  - Cross-repo worktree management
  - Bidirectional sync

### D4 — 88f83db8 concern folds in as a new triage row

New row for `planning/inputs/triage-table.md`:

- **Source:** [88f83db8 discuss thread](88f83db8-f63e-4959-ad2f-50544fa87cce)
  — "skills describe shape, not location; base-dir configurable via
  `references/structure.yaml`"
- **Classification:** MIGRATE
- **Target:** `agentic-ocean/concerns/skill-architecture/skills-describe-shape-not-location.md`
- **Related:** sits next to the migrated dev-infra
  [#102](https://github.com/grimm00/dev-infra/issues/102) (agent architecture)
- **Source-doc note:** discuss-only; no int-opp doc exists yet — the
  concern-doc author IS the primary artifact (not a migration of an existing
  doc). The `migrate-concern` subagent needs to handle this input mode.

### D5 — Task-spec rewrite for flat-root wording

Task files below currently reference "file agentic-ocean issues" (a gh-issue
framing that predates D1). Under flat-root they need "author concern doc under
`agentic-ocean/concerns/<subdir>/`" language:

- [`tasks/03-migrate-skill-bug-issues.md`](tasks/03-migrate-skill-bug-issues.md) — Tasks 8, 9
- [`tasks/04-migrate-skill-architecture-issues.md`](tasks/04-migrate-skill-architecture-issues.md) — Tasks 10, 11
- [`tasks/05-migrate-corpus-mechanics-intopps.md`](tasks/05-migrate-corpus-mechanics-intopps.md) — Tasks 12, 13
- [`tasks/06-migrate-pipeline-design-intopps-a.md`](tasks/06-migrate-pipeline-design-intopps-a.md) — Tasks 14, 15
- [`tasks/07-migrate-pipeline-design-intopps-b.md`](tasks/07-migrate-pipeline-design-intopps-b.md) — Tasks 16, 17
- [`tasks/08-learnings-and-both-cases.md`](tasks/08-learnings-and-both-cases.md) — Tasks 19, 20

Also [`planning/implementation-plan.md`](implementation-plan.md)'s overview
("~29 fresh corpus-side issues") needs to become "~29 fresh corpus-side
concern docs" (and similar phrasing throughout).

**These rewrites are Track α (dev-infra plan hygiene) — required before any
Group 3–8 execution regardless of executor.**

### D6 — Branch strategy for dispatch (TBD)

The scaffolding + this decision doc live on
`docs/skill-corpus-installation-followup`. `group-cycle` dispatch requires the
plan tree on `develop` (or on the `base_branch` passed to it). **Path TBD:**

- **Option A** — docs PR from followup branch → develop (simpler; carries
  other in-progress work on that branch along for the ride)
- **Option B** — cherry-pick just the scaffolding + decision commits to a
  fresh `feat/agentic-ocean-concerns-intake` branch → PR to develop (cleaner;
  matches AGENTS.md Git Flow — this is feature-shaped work)

Deferred to next session.

---

## Three-Track Plan-of-Plans

| Track | Description | Blocks |
|-------|-------------|--------|
| **α — dev-infra plan hygiene** | Rewrite 8 task specs for flat-root wording (D5); update implementation-plan overview; add 88f83db8 row to triage-table.md (D4); resolve D6 (move scaffolding to develop) | γ Groups 3–8 |
| **β — `migrate-concern` subagent** | New exploration → feature: design + install narrow subagent to `~/.cursor/agents/migrate-concern.agent.md` per D3 | γ Groups 3–8 |
| **γ — intake execution** | Group 1 (human, agentic-ocean); Group 2 (group-cycle, dev-infra); Groups 3–8 (`migrate-concern`, agentic-ocean); Group 9 (group-cycle, dev-infra) | — |

**Dependency graph:**

- Group 1 → Groups 3–8 (channel must exist in agentic-ocean for concern docs
  to land in it, and for link-back targets)
- Group 2 ⟂ everything (independent; can run in parallel with Group 1 and
  Tracks α/β)
- Track α → Groups 3–8 (task specs must be flat-root-shaped before author)
- Track β → Groups 3–8 (subagent must exist before dispatch)
- Groups 3–8 → Group 9 (hubs and verification wait on the migration completing)

**Parallelization:** Group 1, Group 2, Track α, and Track β can all run
concurrently. Groups 3–8 are the join point.

---

## Session Provenance

- **This session:** 2026-07-02 `/discuss` — halted `/agent-dispatch` pre-flight
  for `agentic-ocean-concerns-intake` / `01-concerns-channel-shape`; produced
  this doc.
- **Original triage:** 2026-06-22 `/discuss` →
  [`planning/inputs/triage-table.md`](inputs/triage-table.md).
- **Related chat threads:**
  - [Skills describe shape, not location](88f83db8-f63e-4959-ad2f-50544fa87cce)
    — the concern folded in via D4; also the earliest sketch of the
    `/group-cycle-work` variant deliberately deferred by D3.
  - [Agentic-ocean rename + template separation](9eaf7e05-b50b-47e2-a792-e862b70360c3)
    — repo naming context (why the target is `grimm00/agentic-ocean`, not
    `grimm00/ai-workflow`).
- **Related in-repo work:**
  - [`skill-package-controller` exploration](../../../explorations/skill-package-controller/README.md)
    — the "controller resolves paths once" future architecture that would
    eventually subsume the shape-vs-location fix noted in D4.

---

**Last Updated:** 2026-07-02
