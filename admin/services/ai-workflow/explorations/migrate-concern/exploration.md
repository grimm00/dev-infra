# Exploration: migrate-concern

**Created:** 2026-07-02
**Source:** `/discuss` session 2026-07-02 (design-decisions D3 + Track α task-file rewrites) — see [session provenance](../../features/agentic-ocean-concerns-intake/planning/design-decisions.md#session-provenance)

---

## 🎯 What We're Exploring

The **`migrate-concern` subagent** is Track β of the
[`agentic-ocean-concerns-intake`](../../features/agentic-ocean-concerns-intake/)
feature — a narrow, one-shot subagent that authors concern-doc markdown files
in `~/Projects/agentic-ocean/concerns/<subdir>/` from source triage rows and
commits them there. D3 fixed its outer shape (narrow, this-feature-only,
archived after intake). This exploration surfaces the design questions *inside*
that narrow scope.

---

## 🔍 Themes

### Theme 1: Subagent shape vs. tool/script boundary

- The core work is very mechanical: read a source file → transform to concern
  doc with a link-back header → write to `agentic-ocean/concerns/<subdir>/<slug>.md` → commit.
- That shape reads much more "tool" than "agent" — a Python or shell script
  with a Jinja/mustache template could do most of it deterministically.
- But some inputs are non-deterministic: an int-opp doc with an unusual
  "What Worked Well / Needs Improvement" structure, or an issue whose body
  needs summarizing (not verbatim copying), needs judgment.
- Also affects reusability: a tool is easier to invoke from CI or from other
  future migrations; an agent is easier to hand a fuzzy input to.
- The choice affects EVERYTHING downstream — inputs schema, dispatch surface,
  batching, testability. Worth explicit consideration before building.

### Theme 2: Inputs schema and source-mode handling

- D3 proposed inputs `(triage_row_id, source_path, target_subdir)` but noted
  three distinct source modes: **dev-infra file path** (int-opps),
  **remote issue number** (dev-infra `#74`, `#79`, etc.), and
  **chat transcript ID** (`88f83db8`, discuss-only concerns).
- Each mode has a different fetch shape: file read vs. `gh issue view` vs.
  chat-transcript lookup at `~/.cursor/projects/.../agent-transcripts/`.
- Open: does the dispatcher pre-extract the triage row and pass raw content,
  or does the subagent read `planning/inputs/triage-table.md` itself and
  resolve the source? Trade-off between coupling and reusability.
- Open: does `target_subdir` come from the dispatcher (per Group 1 taxonomy)
  or from the triage row (via a new column)? Currently the task files say
  "subdir per Group 1's taxonomy" without hard-wiring.
- Whatever schema is chosen becomes the contract the dispatcher must satisfy
  — probably encoded in the same shape as `group-cycle.agent.md`'s Inputs table.

### Theme 3: Concern-doc structure and link-back header convention

- Every concern doc needs a consistent header block: source URL / path,
  migration date, triage row reference, source mode (int-opp / issue / discuss).
- The three source modes want slightly different headers — an int-opp
  concern points back to a file path (survives forever), an issue-sourced
  concern points to a URL (survives as long as GitHub does), a
  discuss-sourced concern points to a chat transcript ID (opaque to
  outsiders — needs extra "here's how to read this" context).
- Body shape also varies: int-opps have structured "Problem Statement" +
  "What Worked Well / Needs Improvement" sections worth preserving verbatim
  or summarizing; issues have free-form bodies; discuss-sourced concerns
  have NO source doc — the concern doc IS the primary artifact.
- Whatever convention is chosen becomes the format Group 1's channel ADR
  documents, and future non-migration concerns will follow it too.

### Theme 4: Cross-repo execution posture

- The subagent must write to `~/Projects/agentic-ocean` (not the dev-infra
  worktree where it's dispatched from). Options: pass `agentic-ocean` path
  as an input, expect it at a fixed home-relative path, set a working
  directory before dispatch.
- Dispatch entry point: extend existing `/agent-dispatch` (which is
  dev-infra-shaped and calls `group-cycle`), build a new
  `/migrate-concern-dispatch`, or invoke the agent directly via Task tool
  from a `/discuss` session.
- Branch/worktree posture in agentic-ocean is unclear. Does the subagent
  create a `feat/concerns-intake` branch? Reuse an existing one across
  dispatches? Author to `main`/`develop` directly?
- **Boundary question (contested):** Groups 5–8 Task 13/15/17 also add
  "migrated-to markers" in the dev-infra-side source int-opps. Does
  `migrate-concern` do that too (requiring write access to BOTH repos), or
  is that a separate dev-infra-side pass (via `group-cycle` in a later
  group cycle)? Answer affects Theme 1's "tool vs. agent" question too.

### Theme 5: Batching, atomicity, and idempotency

- D3 said "PR creation is a non-goal — batch multiple concern docs into one
  PR manually" but didn't specify commit boundaries. Does one dispatch =
  one concern doc, one group, or one PR-worth of work?
- If one dispatch = one group (e.g., Group 5 = 5 concern docs), what
  happens on partial failure — say the 3rd doc's source is malformed? Does
  the subagent commit the first 2, STOP + report, and rely on re-dispatch
  to skip the completed 2?
- Idempotency requires the subagent to detect "this concern doc already
  exists at target path" before re-authoring. Naive checks (path exists?)
  can miss half-authored docs. Marker file? Manifest of authored docs?
- PR ownership is human (per D3), but that means each group's dispatch
  leaves a series of commits on a feature branch in agentic-ocean waiting
  for the human to PR — and the human's PR review is where concern-doc
  quality actually gets checked. Batching cadence affects that review load.

---

## ❓ Key Questions

1. Should `migrate-concern` be a subagent, a deterministic script, or a hybrid (script with agent fallback for edge cases)?
2. Does the dispatcher pre-extract the triage row and pass raw content, or does the subagent read `triage-table.md` itself?
3. What's the canonical link-back header format for concern docs — and does it differ across the three source modes (int-opp path / issue# / chat transcript)?
4. What's the dispatch entry point — extend `/agent-dispatch`, build `/migrate-concern-dispatch`, or invoke via Task tool from `/discuss`?
5. Does `migrate-concern` also add dev-infra-side "migrated-to" link-back markers, or is that a separate dev-infra-side pass?
6. What's the unit of work per dispatch — one concern doc, one group, or one PR-worth?
7. What are the retry/idempotency semantics on partial failure?

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| Theme 1 — Subagent shape vs. tool/script | **HIGH** | **Yes** | Foundational decision; hard to pivot after building either. Small spike (build a tool version *and* an agent-def version of the "author one concern doc from one int-opp" happy path) surfaces the tradeoff cheaply. |
| Theme 2 — Inputs schema and source-mode handling | MEDIUM | No | Design work; low technical risk. Can be settled via `/research` + `/decision` without prototyping. |
| Theme 3 — Concern-doc structure and link-back header | LOW | No | Author a sample concern doc for one triage row (any of the three modes) as part of Group 1's ADR — iterate on the shape there. No prototyping needed. |
| Theme 4 — Cross-repo execution posture | **MEDIUM-HIGH** | **Consider** | Cross-repo agent execution is genuinely new territory in this workspace. A one-shot spike ("agent dispatched from dev-infra worktree writes and commits one file in `~/Projects/agentic-ocean`") de-risks the mechanics before building the real subagent. Overlaps with the Theme 1 spike. |
| Theme 5 — Batching, atomicity, idempotency | MEDIUM | No | Operational semantics; will emerge from real usage. Worth a deliberate design pass in `/research` but not a spike — the mechanics are known. |

**Risk framework:** HIGH = spike first (hard to pivot), MEDIUM-HIGH = consider spike, MEDIUM/LOW = research only.

---

## 🚀 Next Steps

Review this exploration, then:

- `/explore-amend` to add themes from downstream discovery (e.g., after Group 1's channel ADR reveals concrete subdir taxonomy or link-back conventions)
- `/research --from-explore migrate-concern` to investigate the higher-priority questions (recommended: start with Theme 1 — the subagent-vs-tool question, since it reshapes the other themes)
- `/spike` for Theme 1 (build both a script version and an agent-def version of the happy path) — the recommended answer to "if you want to know, you build it"
- Proceed directly to implementation if the exploration is sufficient (not recommended — Theme 1 is unsettled)

---

**Last Updated:** 2026-07-02
