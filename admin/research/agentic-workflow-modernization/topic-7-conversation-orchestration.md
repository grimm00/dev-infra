# Research: Conversation as Lightweight Orchestration

**Research Topic:** Agentic Workflow Modernization
**Question:** Can the discussion chat serve as the primary orchestration layer for dispatching subagents -- and what does that architecture look like?
**Status:** ✅ Complete
**Priority:** Medium-High
**Note:** This topic IS the meta-experiment: running Topics 1-6 serially in conversation tested the concept empirically.
**Created:** 2026-03-25
**Completed:** 2026-04-09

---

## 🎯 Research Question

Rather than building a formal orchestration pipeline, can the discussion/planning chat act as an orchestrator: the human and agent co-decide when to dispatch subagents, what context to hand them, and how to consolidate their output? What are the limits of this model?

---

## 🔍 Research Goals

- [x] Research existing multi-agent orchestration patterns: centralized orchestrator vs emergent/conversational
- [x] Identify what the discussion chat provides as an orchestrator: shared context, dispatch decision, consolidation
- [x] Identify what it lacks: persistence, retry logic, parallel execution guarantees, formal state tracking
- [x] Determine the breakover point: when does conversational orchestration become insufficient and a pipeline layer is needed?
- [x] Document the meta-experiment learnings: did running research topics through conversation work? What friction emerged?

---

## 📚 Research Methodology

**Context already established:**
- The original plan was to run Topics 4-8 as parallel subagents to test conversational orchestration empirically
- In practice, topics were conducted serially within conversation sessions (Topics 1-6 completed across multiple sessions)
- "Conversation as lightweight orchestration" emerged as Theme 7 in exploration
- Cursor's `Task` tool enables subagent dispatch from within the main agent context

**Sources consulted:**
- [x] Web search: multi-agent orchestration patterns (LangGraph, CrewAI, AutoGen comparison)
- [x] Web search: emergent orchestration vs pipeline orchestration, human-in-the-loop patterns
- [x] Web search: Claude Code subagent and agent teams architecture, context limits
- [x] Web search: Cursor subagent Task tool behavior, context management best practices
- [x] Web search: single-agent vs multi-agent coding workflows for solo developers
- [x] [Claude Code Agent Teams Docs](https://code.claude.com/docs/en/agent-teams) -- experimental team orchestration
- [x] [Cursor Subagents Docs](https://cursor.com/docs/context/subagents) -- built-in and custom subagent types
- [x] Empirical observation: the agentic-workflow-modernization research itself (6 topics across multiple sessions)

---

## 📊 Findings

### Finding 1: Three Orchestration Tiers Exist, and Conversation Lives at Tier 1

The industry has converged on a tiered model for multi-agent orchestration:

| Tier | Agents | Model | When |
|------|--------|-------|------|
| **Tier 1** | 1-3 | Keyboard-guided, in-process coordination | Solo developer, single session, human judgment at each step |
| **Tier 2** | 3-10 | Local orchestrator with isolated worktrees | Team or complex feature, dashboard for monitoring |
| **Tier 3** | 10+ | Cloud async, no local setup | Enterprise CI/CD, large-scale refactoring |

Dev-infra's conversational orchestration is firmly **Tier 1**: one human, one main agent, with occasional subagent dispatch for focused tasks. This is not a limitation -- it's the appropriate tier for a solo developer working on methodology and templates.

The research confirms: "three focused agents consistently outperform one generalist agent working three times as long" -- but only for parallelizable work with clear boundaries. Dev-infra's research workflow is inherently sequential (Topic N informs Topic N+1), making parallel dispatch counterproductive for most phases.

**Source:** [htdocs.dev: From Conductor to Orchestrator](https://htdocs.dev/posts/from-conductor-to-orchestrator-a-practical-guide-to-multi-agent-coding-in-2026); [Solid Web: Agentic Coding Workflows](https://solid-web.com/agentic-coding-workflows-multi-agent-vs-single/)

---

### Finding 2: The Conversation Provides Four Things a Pipeline Doesn't

The conversational model has inherent advantages over formal pipeline orchestration for dev-infra's workflow:

1. **Judgment at every step.** The human decides what to research next, whether findings are credible, and when to stop. A pipeline would automate this judgment away, which for research is actively harmful.

2. **Context accumulation.** Each research topic builds on the previous. The conversation carries forward "Topic 3 Finding 9 was wrong" corrections that a pipeline couldn't anticipate. The human's mental model of the overall picture is the orchestration state.

3. **Lateral movement.** `/discuss` sessions emerge naturally when something doesn't feel right. The pipeline model assumes a fixed sequence; the conversation model allows the user to pause, question, and redirect.

4. **Low ceremony.** No infrastructure to maintain, no DAG definitions, no typed state schemas. The user says `/research --conduct --topic-num 6` and work begins. The cost of orchestration is zero.

**Relevance:** These advantages are specific to research, planning, and design workflows -- not to code generation or testing, where automation has higher value.

---

### Finding 3: The Conversation Lacks Three Things a Pipeline Provides

The conversational model has clear gaps:

1. **Persistence across sessions.** When a session ends, the orchestration state (what's done, what's next, what corrections carry forward) exists only in committed artifacts and the user's memory. There is no formal "resume from where I left off" mechanism. The `/handoff` command partially addresses this but depends on the user remembering to invoke it.

2. **Parallel execution.** Cursor's Task tool can dispatch subagents in parallel, but the main agent's context window absorbs all results. Claude Code reports that sessions with 36+ background agents consumed the majority of the context window with task notifications alone. For dev-infra's research workflow, parallel subagent dispatch would mean running multiple web-search-heavy research topics simultaneously -- feasible but risky for context exhaustion.

3. **Formal progress tracking.** The "what's done" state lives in the research hub README status table, updated manually after each topic. A pipeline would track this automatically. The manual approach works but requires discipline -- missed status updates create confusion when resuming after a break.

**Source:** [Claude Code Issue #24976](https://github.com/anthropics/claude-code/issues/24976) (context limit exhaustion); [Claude Code Issue #27482](https://github.com/anthropics/claude-code/issues/27482) (task result size)

---

### Finding 4: The Meta-Experiment Outcome -- Serial Conversation Worked, Parallel Was Unnecessary

The original plan was to test conversational orchestration by running Topics 4-8 as parallel subagents. In practice, topics were conducted serially across multiple conversation sessions:

- Topics 1-4: Conducted serially in earlier sessions
- Topic 5: Conducted in a session that also identified the design gap and corrected Topic 3 Finding 9
- Topic 6: Conducted in the current session
- Topic 7: This document

**What worked:**
- Serial research within conversation sessions was natural and effective
- The `/discuss` command provided valuable lateral movement (design gap discovery, proj-cli boundary questioning)
- Cross-topic corrections (Topic 5 correcting Topic 3) happened naturally because the human carried the mental model
- The research hub README and requirements.md served as adequate "external state" between sessions

**What was friction:**
- Resuming after a break required re-reading context (the `/discuss` session opening this thread was the user "getting back up to speed")
- The user identified a tendency to "hand off unformed thinking" to the agent -- conversational orchestration works best when the human does their own judgment work
- No mechanism to compare parallel outputs (the original parallel subagent plan would have needed a consolidation step)

**Key learning:** The serial conversational model is sufficient for dev-infra's research workflow. The original hypothesis that parallel subagents were needed was incorrect -- the research topics have sequential dependencies (Topic 5 depends on Topic 3's findings, Topic 6 depends on Topic 5's portability conclusions) that make parallelism counterproductive.

---

### Finding 5: Subagent and Agent Team Models Are Complementary, Not Competitive

The ecosystem now offers three distinct coordination models:

| Model | Cursor | Claude Code | Best For |
|-------|--------|-------------|----------|
| **Subagents** | Task tool (foreground/background) | Subagents (within session) | Focused tasks where only the result matters |
| **Agent Teams** | Not available | Experimental (v2.1.32+) | Complex work needing inter-agent discussion |
| **Conversational** | Human + main agent + `/discuss` | Human + Claude session | Judgment-heavy workflows, research, planning |

For dev-infra's skills, the relevant question isn't "which model" but "which model for which workflow phase":

- **Research/planning/design:** Conversational (Tier 1). Human judgment is the bottleneck, not compute.
- **Implementation (code generation):** Subagents (Tier 1-2). Parallel file changes benefit from isolation.
- **Validation (testing, CI):** Pipeline (formal). Automated, no human judgment needed.

**Source:** [Claude Code Agent Teams Docs](https://code.claude.com/docs/en/agent-teams); [Cursor Subagents Docs](https://cursor.com/docs/context/subagents)

---

### Finding 6: The Breakover Point Is Not Agent Count -- It's State Complexity

The industry literature frames the breakover point as "how many agents" (Tier 1: 1-3, Tier 2: 3-10, Tier 3: 10+). But for dev-infra's use case, the real breakover is **state complexity**:

**Conversation is sufficient when:**
- The workflow is human-paced (one session at a time, hours between sessions)
- The state fits in committed artifacts (status tables, requirements docs, hub READMEs)
- Cross-session continuity comes from reading those artifacts (not from pipeline state)
- The number of "active threads" is 1-2 at a time

**Conversation becomes insufficient when:**
- Multiple people need to coordinate on the same workflow
- Tasks have formal dependencies that must be enforced (not just remembered)
- Retry/recovery is needed for automated steps (CI, deployment)
- The workflow spans more than ~10 active items that a single human can track mentally

For dev-infra today (solo developer, research workflow, 8 topics tracked in a status table), conversation is well within the sufficiency zone. The breakover would occur if dev-infra's methodology were adopted by a team (multiple people researching different topics simultaneously) or if the implementation phase involved parallel code generation across many files.

**Source:** [Bytex: From Prompts to Durable Workflow Engines](https://bytex.net/blog/from-prompts-to-durable-workflow-engines/); [Solid Web: One Agent vs Many](https://solid-web.com/agentic-coding-workflows-multi-agent-vs-single/)

---

### Finding 7: The `/discuss` → `/research` → `/commit` Cycle Is Already an Implicit Pipeline

An underappreciated finding: dev-infra's command system already implements a lightweight pipeline -- it just uses the conversation as the execution engine rather than a formal orchestrator:

```
/discuss  → Human judgment, no side effects
    ↓ (human decides to act)
/research → Structured research with web search, findings, requirements
    ↓ (human reviews)
/review   → Stage changes, capture diff, draft commit message
    ↓ (human approves)
/commit   → Finalize commit, push

State between steps: conversation context + committed artifacts
Orchestrator: human + agent in dialogue
Retry mechanism: human says "that's wrong, try again"
```

This is functionally equivalent to a pipeline with human-approval gates -- it just doesn't have the infrastructure overhead of typed state, DAG definitions, or checkpoint serialization.

The value of formalizing this into a pipeline is low for dev-infra's current scale. The value would increase if:
- The workflow needed to be teachable to other developers (documentation of the pipeline)
- Steps needed to be skipped or reordered programmatically
- Automated validation between steps was desired

---

## 🔍 Analysis

### The Orchestration Spectrum

```
Pure Conversation                                        Pure Pipeline
     │                                                        │
     │  ← DEV-INFRA IS HERE                                   │
     │     (research, planning,                                │
     │      design workflows)                                  │
     │                                                         │
     │              ← IMPLEMENTATION WOULD BE HERE             │
     │                 (code generation, testing)               │
     │                                                         │
     │                              ← CI/CD IS HERE            │
     │                                 (automated, no human)   │
     │                                                         │
     ▼                                                         ▼
  Human judgment           Hybrid               Automated
  at every step         (guardrails)           (deterministic)
```

Dev-infra's workflows sit at different points on this spectrum:
- Research, planning, design: far left (conversational)
- Implementation with TDD: center (human-guided but structured)
- Validation and CI: far right (automated pipeline)

The agentic workflow modernization should not try to move research workflows rightward on this spectrum. The conversation model works because research is judgment-intensive and sequential.

### What Dev-Infra Should Build (and Not Build)

**Should build:**
- Better cross-session continuity (the `/handoff` command exists but isn't consistently used)
- Explicit "resume context" at session start (the agent reads status tables and requirements automatically)
- Clear documentation of the implicit pipeline so future users understand the workflow

**Should NOT build:**
- A formal pipeline orchestrator for research/planning workflows
- Parallel subagent dispatch for sequential research topics
- DAG-based task tracking for a solo developer's methodology workflow

**Key Insights:**
- [x] Insight 1: Conversational orchestration is the right model for research/planning/design -- don't over-engineer it
- [x] Insight 2: The breakover point is state complexity, not agent count -- dev-infra is well within the conversational sufficiency zone
- [x] Insight 3: The implicit pipeline (discuss → research → review → commit) already works; formalizing it adds overhead without proportional value
- [x] Insight 4: Parallel subagent dispatch is counterproductive for sequential research topics with inter-topic dependencies
- [x] Insight 5: Different workflow phases (research vs implementation vs validation) belong at different points on the orchestration spectrum

---

## 💡 Recommendations

- [x] **Keep conversational orchestration for research/planning/design.** Don't build pipeline infrastructure for these workflows. The implicit pipeline through commands is sufficient.

- [x] **Improve cross-session continuity.** The main friction in conversational orchestration is resuming after a break. The `/handoff` command should be invoked consistently, and sessions should start by reading the research hub status table and latest topic status.

- [x] **Document the implicit pipeline.** The command sequence (discuss → explore → research → decision → design → transition-plan → task) is a pipeline with human judgment gates. Document this for users of the methodology so they understand the workflow without needing a formal orchestrator.

- [x] **Reserve subagent dispatch for implementation.** When the skills migration reaches implementation, subagents become valuable for parallel file changes. For now, research doesn't benefit from parallelism.

- [x] **Define the breakover criteria.** If dev-infra's methodology is adopted by a team or the implementation phase involves parallel code generation, document when to add formal orchestration (multiple concurrent researchers, >10 active tasks, cross-dependency enforcement needed).

---

## 📋 Requirements Discovered

- [x] **NFR-3: Research/Planning/Design Workflows Must Remain Conversationally Orchestrated.** The agentic workflow modernization must not introduce pipeline infrastructure for judgment-intensive workflows (research, planning, design, discussion). These workflows are human-paced, sequential, and judgment-dependent. The implicit pipeline through commands (discuss → research → review → commit) provides adequate structure. Formal orchestration (DAGs, typed state, checkpointing) is reserved for implementation and CI/CD phases.
  **Source:** Findings 1, 2, 4 (meta-experiment outcome)
  **Priority:** High (architectural constraint)

- [x] **FR-22: Skills Must Document Their Position on the Orchestration Spectrum.** Each skill's SKILL.md should indicate whether the workflow is conversationally orchestrated (human judgment at each step), hybrid (structured with human gates), or automated (pipeline, no human needed). This helps users and agents understand how much autonomy to apply and whether subagent dispatch is appropriate.
  **Source:** Finding 5, Analysis (orchestration spectrum)
  **Priority:** Low (nice-to-have metadata, not blocking)

- [x] **FR-23: Session Resume Must Load Current Workflow State.** When a conversation session begins and the user references a topic (e.g., `/research --conduct --topic-num 7`), the agent must read the research hub README status table and the latest requirements summary before beginning work. This compensates for the conversational model's lack of persistent state by grounding the agent in the committed artifacts.
  **Source:** Finding 3 (persistence gap), Finding 4 (meta-experiment friction)
  **Priority:** Medium

---

## 🚀 Next Steps

1. Feed NFR-3 into the design document: conversational orchestration as an architectural constraint for research/planning
2. Feed FR-22 into the skill conversion work: orchestration spectrum metadata
3. Feed FR-23 into skill design: session-start context loading behavior
4. Feed Finding 7 into the design gap int-opp: the implicit pipeline should be documented in the `/design` command output

---

**Last Updated:** 2026-04-09
