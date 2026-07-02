# Research Topics — migrate-concern

**Created:** 2026-07-02

---

## 📋 Topics Identified

### Topic 1: Subagent vs. deterministic script vs. hybrid shape

**Question:** Should `migrate-concern` be a subagent, a Python/shell script with template rendering, or a hybrid (script with agent fallback for edge cases)?
**Priority:** High
**Context:** The core work (read source → transform → write → commit) is mechanical enough that a script is the simplest thing that could work; only non-standard source shapes need judgment. This choice reshapes every other theme (inputs schema, dispatch surface, testability, reusability). Companion spike recommended.

### Topic 2: Inputs schema and source-mode fetch layer

**Question:** Does the dispatcher pre-extract the triage row and pass raw source content, or does the subagent read `planning/inputs/triage-table.md` and resolve the three source modes (int-opp file path, `gh issue view`, chat transcript lookup) itself?
**Priority:** High
**Context:** Determines the coupling boundary between dispatcher and subagent. Pre-extraction keeps the subagent stateless and pure; letting it read triage-table itself keeps the dispatcher lightweight but couples the subagent to a specific plan-tree layout.

### Topic 3: Concern-doc structure and link-back header convention

**Question:** What's the canonical concern-doc structure — and does the link-back header differ across the three source modes (int-opp path, remote issue URL, chat transcript ID)?
**Priority:** High
**Context:** Whatever convention lands becomes the format Group 1's channel ADR codifies, and future non-migration concerns will follow it. Discuss-sourced concerns (like 88f83db8) are especially interesting because they have no source doc — the concern doc IS the primary artifact, so the header needs extra "how to interpret this" scaffolding.

### Topic 4: Dispatch entry point and cross-repo execution posture

**Question:** What's the dispatch surface — extend `/agent-dispatch` (currently dev-infra + `group-cycle` shaped), build a new `/migrate-concern-dispatch`, or invoke via Task tool from `/discuss`? And how does the subagent express "operate against `~/Projects/agentic-ocean`" — input arg, working directory, env var, or fixed home-relative path?
**Priority:** Medium-High
**Context:** Cross-repo agent execution is new territory. A companion mini-spike (single-file write + commit in `~/Projects/agentic-ocean` dispatched from a dev-infra worktree) validates the mechanics cheaply.

### Topic 5: Scope of dev-infra-side link-back edits

**Question:** Does `migrate-concern` also add "migrated-to" markers in the dev-infra source int-opps (Groups 5–8 Tasks 13/15/17), or is that a separate dev-infra-side pass handled by `group-cycle` in its own cycle?
**Priority:** Medium
**Context:** If in-scope, `migrate-concern` needs write access to BOTH repos — which strengthens the "this is an agent, not a script" case. If out-of-scope, dev-infra-side edits become their own group-cycle dispatches after Groups 5–8 complete, adding operational overhead.

### Topic 6: Unit-of-work and batching cadence

**Question:** What's the unit of work per dispatch — one concern doc, one group's worth (2–5 docs), or all of Groups 3–8's docs?
**Priority:** Medium
**Context:** Affects the human PR-review cadence in agentic-ocean (per-group dispatches = 6 PRs; per-doc = ~30 PRs; single dispatch = 1 mega-PR). Also affects commit strategy and blast radius on failure.

### Topic 7: Retry / idempotency semantics on partial failure

**Question:** If a mid-group dispatch fails (e.g., 3rd of 5 docs has a malformed source), what happens — commit-what-succeeded + STOP + report, or roll back? And how does re-dispatch detect "this doc already exists" without re-authoring?
**Priority:** Medium
**Context:** Depends on Topic 6's unit-of-work choice. If per-doc, less critical (re-dispatch trivially skips). If per-group, needs a marker file or manifest so re-dispatch resumes correctly rather than starting over.

---

## 🚀 Next Steps

Use `/research --from-explore migrate-concern` to investigate these topics. Recommended order: **Topic 1 first** (subagent shape reshapes everything else), then Topics 2–3 in parallel (inputs + concern-doc format can be researched independently), then Topics 4–7 once Topic 1 lands.

If Topic 1 leans "spike to know", `/spike --from-explore migrate-concern topic-1` builds happy-path prototypes of both the script and agent shapes for comparison.

---

**Last Updated:** 2026-07-02
