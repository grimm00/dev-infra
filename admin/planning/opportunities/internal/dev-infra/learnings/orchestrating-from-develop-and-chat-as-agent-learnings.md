# Dev-Infra Learnings — Orchestrating from Develop & Chat-as-Agent

**Project:** Dev-Infra
**Topic:** IDE working-directory positioning when orchestrating subagents; chat sessions as bounded-context agents
**Date:** 2026-06-04
**Last Updated:** 2026-06-04

---

## 📋 Overview

Surfaced during the skill-template-separation feature work (Groups 1–3 cycle): the user noticed that files open in their IDE — anchored to `worktrees/feat-skill-template-separation/` (PR #106's worktree, frozen at SHA `fc389d5`) — had gone stale relative to `develop` after PRs #107 and #108 merged. The subagents had been doing the actual work in their own worktrees, while the orchestrator's IDE position was stuck on a feature branch whose useful life had ended at PR #106 merge.

Unpacking the staleness surfaced two related insights:

1. **An IDE position has two distinct jobs** — workspace (you're doing the work) vs observation point (you're orchestrating work being done elsewhere). The same physical directory can serve either role, but they have different requirements. When the role shifts (e.g., when work delegation moves to subagent dispatches), the IDE position needs to shift too, or it goes stale silently.
2. **Each chat session is a bounded-context agent** — not an infinitely-long-lived collaborator. Session-scoped agents accumulate context within a session and lose it at session end. Dispatch-scoped subagents accumulate context within a single dispatch and lose it at return. The two differ only in *which boundary* they're bounded by. Conflating "the chat" with "the file tree the user is looking at" was the source of the staleness confusion — the chat agent was operating in a workspace whose original purpose had concluded.

Both insights point at the same resolving pattern: **"develop in develop"** — when orchestrating, sit in the main worktree on `develop`. The branch destined for production is also the branch you sit on to orchestrate work into production. Independently corroborated by the user's parallel work on Pi-Hole DNS on a Steam Deck (different domain, same pattern emerging unprompted).

---

## 💡 Unexpected Discoveries

### Each chat session is a bounded-context agent — same finite shape as a dispatched subagent

**Finding:** The mental model of "chat = ongoing dialogue with Claude" obscures what's actually happening at the workflow level. A chat session is an agent with two properties: (a) it accumulates context across turns within the session, (b) it has no memory of prior sessions. That makes it functionally identical to a dispatched subagent in shape — both are bounded-context agents. The only difference is *which boundary*: dispatch-scoped (one shot of context per dispatch) vs session-scoped (one shot of context per session). Once that's named, the workspace question stops being confusing — the agent's workspace is wherever its tools operate, and that's a choice that should be made deliberately, not inherited from "where I happened to open Cursor."

**How to leverage:** When deciding where to position the IDE, ask the same question you'd ask before a subagent dispatch: *what context does this agent need, and where should its working directory be for that context to be naturally available?* For orchestration, the answer is consistently "develop" — the branch where merged work lands, never goes stale, and naturally surfaces the latest state of everything.

### The "develop in develop" pattern was independently corroborated

**Finding:** The user discovered the same orchestrator-on-develop pattern while doing a completely separate piece of work on Pi-Hole DNS on a Steam Deck (running the group-cycle agent from `develop`, watching it create its own worktree). Two independent contexts converging on the same pattern is a stronger signal than one — suggests the pattern is structural to the dispatch model itself, not specific to dev-infra.

**How to leverage:** When the same workflow shape emerges across unrelated domains, it's worth promoting from "thing I figured out in one project" to "principle of agentic-workflow design." This one specifically belongs in the broader `dev-infra` workflow narrative as a default convention, not as project lore.

### Dispatch and Handoff are the same materialization-of-context pattern, applied at different boundaries

**Finding:** The `handoff` skill (transient artifact passed between chat sessions) and the subagent dispatch prompt (materialized context passed from parent agent to subordinate agent) are structurally the same operation: *give the next agent enough of your workspace + context to pick up where you left off*. They just cross different boundaries — handoff crosses session-to-session, dispatch crosses orchestrator-to-subordinate. Both exist because **agents don't inherit context automatically**; it has to be explicitly written down and handed off.

**How to leverage:** This is a unifying frame worth surfacing somewhere in the skill-ecosystem documentation. Whenever a new "how do I get information from one agent to another" question comes up, the answer is some form of context materialization — and there are now two skills (`handoff`, dispatch-via-prompt) demonstrating the pattern. Future skills/patterns can be evaluated against the same shape. (Caveat: the frame is sturdy enough to capture but hasn't been stress-tested against a counterexample — see Additional Notes.)

---

## 🟡 What Needs Improvement

### `agent-dispatch` command's pre-flight doesn't surface IDE-positioning guidance

**What the problem was:** The user invoked `/agent-dispatch` four times this session, each time from `worktrees/feat-skill-template-separation/` (the stale feature worktree). The pre-flight checks (develop sync, worktree audit, prior_pr verification, agent definition path, etc.) all passed, but none of them flagged: *"hey, you're orchestrating from a feature worktree whose PR has already merged — your IDE is going to feel stale as more PRs land. Consider running from the main worktree on develop."* The dispatch worked correctly (subagents create their own worktrees regardless), but the human-side experience accumulated confusion across the session that didn't surface until 3 PRs had landed.

**How to prevent:** Add a soft check to `/agent-dispatch` Step 1 (or a new Step 0): if the invoker's `cwd` is a feature worktree whose PR is already merged, emit a one-line "consider running from `[main-worktree-path]` (develop) — your current worktree's PR has merged and it'll go stale as new work lands." Don't block — just surface. The same check applies to any worktree where the branch's last commit precedes `origin/develop`'s last touch by more than one merge.

**Template changes needed:** `~/.cursor/commands/agent-dispatch.md` — add the soft pre-flight check. The text could be as small as a single recommendation line emitted only when the condition triggers.

### "Develop in develop" is project lore, not documented convention

**What the problem was:** The orchestrator-on-develop pattern is the right default but isn't written down anywhere in dev-infra's user-facing docs or workflow descriptions. It was discovered via confusion, corroborated via separate experience, and only then articulated. A new contributor (or a future-self picking up after a long gap) would hit the same staleness pattern and have to re-derive the answer.

**How to prevent:** Add a short "Orchestration position" note to the relevant workflow doc. Natural homes:
- `AGENTS.md` (worktree-workflow section) — already discusses worktree naming conventions; add a paragraph on positioning when dispatching subagents.
- `~/.cursor/agents/group-cycle.agent.md` (or its sibling `~/.cursor/commands/agent-dispatch.md`) — already names the worktree-setup convention for subagents; add the orchestrator-side convention as a complement.
- A new `docs/` page on "orchestrating subagents" if the topic grows further.

**Template changes needed:** Pick one of the above (probably `AGENTS.md` since it's already the convention hub) and add ~2 paragraphs.

### Handoff–dispatch relationship isn't surfaced anywhere

**What the problem was:** Both `handoff` (`templates/standard-project/.claude/skills/handoff/SKILL.md`) and the subagent dispatch pattern (encoded in `~/.cursor/agents/group-cycle.agent.md` + `~/.cursor/commands/agent-dispatch.md`) implement the same materialization-of-context concept across different boundaries. Nothing in either skill's docs notes the connection. A reader learning one of them in isolation misses the unifying principle and probably re-derives it later when encountering the other (as this session did).

**How to prevent:** Add a "Related: same pattern, different boundary" pointer in each skill's `## Related Skills` section (or equivalent), explicitly naming the other and the boundary it crosses. Optionally: add a short conceptual note somewhere (an exploration, an ADR, or a meta-doc) describing the unifying frame.

**Template changes needed:** Two small edits — one to `templates/standard-project/.claude/skills/handoff/SKILL.md`, one to `~/.cursor/agents/group-cycle.agent.md` (or wherever the dispatch convention canonically lives).

---

## 📝 Additional Notes

### The unifying frame is sturdy enough to capture, not yet sturdy enough to formalize

The conversation that surfaced these insights identified a unifying principle — *agents need their context materialized for them because they don't inherit it* — and three instances where the principle applies (chat sessions, handoffs, subagent dispatches). The next round of thinking that would validate (or break) the frame is asking: *what's the fourth instance, or the first counterexample?* That question is unresolved as of this capture. Examples worth probing later:
- Cursor's rules system (does adding a rule "materialize context" for the agent, or is it a different mechanism?)
- Skill files themselves (when an agent reads a skill, is that a context-materialization operation, or something else?)
- MCP tool definitions (an MCP server is materialized context for any client that connects, but the boundary is "tool-call time" rather than "agent-launch time")

These aren't questions to answer now; flagging them so the frame can be tested rather than just accepted on the strength of the three known instances.

### Don't generalize "stale worktree" too quickly

The specific failure mode this session hit was: *orchestrator's IDE pinned to a feature worktree whose PR had merged, accumulating staleness as more PRs landed on develop.* The fix (orchestrate from develop) addresses that mode. There may be other related failure modes that the same fix doesn't address — e.g., what if you're orchestrating one feature while you also have a long-running unmerged exploration on a different branch and want to occasionally check on it? "Always orchestrate from develop" is right for the steady state but might need exceptions for cross-feature contexts. Worth surfacing if the situation arises; not worth pre-emptively designing around it.

### Context of capture

Captured at the end of a `/discuss` session that itself followed a long session of subagent-dispatched implementation work (Groups 1–3 of `skill-template-separation`). The user said "I think it's worth an /int-opp before I leave this worktree" — the "leave this worktree" framing is itself a small piece of the learning: the user is about to move their IDE out of the now-stale `worktrees/feat-skill-template-separation/` to a better orchestration position. The capture is happening at exactly the moment when the workflow transition is being made deliberately for the first time.

### Related artifacts

- `admin/planning/opportunities/internal/dev-infra/learnings/research-artifact-lifecycle-learnings.md` — yesterday's capture; similar pattern (discovery surfaced during the same feature's work, captured before context evaporated).
- `~/.cursor/agents/group-cycle.agent.md` — the subagent definition that materializes context for dispatched groups; patched earlier in this session to use user-level command paths.
- `templates/standard-project/.claude/skills/handoff/SKILL.md` — the cross-session context-materialization skill.
- `admin/services/meta/features/skill-template-separation/` — the feature whose Groups 1–3 cycle surfaced this learning; specifically the post-PR-#106 worktree (`fc389d5`) that went stale.

---

## ⏱️ Time Investment

N/A — discovery captured at the moment of surfacing. The triggering `/discuss` round took roughly 40 minutes of back-and-forth across two timestamped exchanges; the underlying confusion had been accumulating across the previous day of dispatching work without an explicit articulation.

---

**Last Updated:** 2026-06-04
