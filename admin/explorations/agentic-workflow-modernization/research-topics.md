# Research Topics - Agentic Workflow Modernization

**Status:** 🟠 In Progress
**Created:** 2026-03-25
**Restructured:** 2026-03-25 - Reordered by dependency, scoped narrower, removed spike-only items, flagged downstream topics
**Amended:** 2026-03-25 - Updated Topics 1, 3, 5 with marketplace findings; added Topic 6 (dual distribution)
**Amended:** 2026-03-25 - Added Topics 7-8 from /discuss session (conversation orchestration, behavioral contracts)
**Amended:** 2026-03-25 - Widened Topic 8 (agent identity + alignment); added Topics 9-10 (AGENTS.md portability, roadmap layer)

---

## 📋 Research Topics

### Topic 1: Auto-Detection vs Explicit Invocation

**Question:** Should dev-infra's workflow model adopt auto-detection (agent decides when to invoke workflows), stay fully explicit, or go hybrid?

**Priority:** High (gates all other decisions)

**Context:** Superpowers (Hex) enforces workflows automatically and is already deployed in the team marketplace. Dev-infra's `/discuss` command exists precisely because auto-formalization is a problem. The SKILL.md frontmatter supports `disable-model-invocation: true` for per-skill opt-out of auto-detection, enabling a hybrid model without a global decision. The question narrows to: which skills should auto-detect and which should be explicit-only?

**Method:** Research -- examine `disable-model-invocation` behavior across platforms, review Hex's auto-detection patterns, define criteria for when auto-detection is appropriate vs harmful

---

### Topic 2: Three-Layer Redistribution Criteria

**Question:** What sorting criteria determine whether content stays as always-on rules, becomes a skill, or remains a command?

**Priority:** High (depends on Topic 1 decision)

**Context:** The three `.mdc` files contain ~500+ lines of always-on context. The 26 commands span simple triggers to complex workflows. Need concrete sorting criteria, not just "it depends." Propose a rubric (e.g., "if it has reference materials → skill; if it's under 50 lines and always relevant → rule; if it's a one-shot trigger → command") and test it against representative samples from each tier.

**Scope:** Develop the rubric and apply it to a representative sample: 2-3 rules sections, 3-5 commands from different complexity tiers (e.g., `/commit`, `/pr`, `/explore`). Do NOT exhaustively assess all 26 commands -- the rubric should be generalizable.

**Method:** Research / analysis -- audit rule content, sample commands, propose and validate rubric

---

### Topic 3: Command-to-Skill Conversion Mechanics

**Question:** What does it concretely look like to convert a dev-infra command into a Cursor skill?

**Priority:** High

**Context:** A real-world skill has already been built (`update-pr-description` for the team's internal Claude marketplace), so the basic format is understood. The same SKILL.md works in Cursor (`.cursor/skills/`) and Claude Code (`.agents/skills/`). The remaining question is how *complex multi-mode commands* decompose -- commands like `/explore` (setup + amend modes, input sources, worktree integration) that are 500+ lines. The skill directory structure naturally supports reference files (templates, configs), which is where doc templates would live.

**Scope:** Focus on one complex command (e.g., `/explore` post-issue-#72) and design its skill equivalent: SKILL.md (core contract), reference files (templates, examples), `plugin.json` (marketplace metadata). Compare against `update-pr-description` as the known-good simple case.

**Method:** Research + spike candidate -- design on paper first, then `/spike command-to-skill-migration` to validate

---

### Topic 4: Templates as Structural Schemas

**Question:** Can dev-infra's templates serve as living structural contracts that agents validate against? What does this look like in practice?

**Priority:** Medium-High

**Context:** Currently templates define initial document shape and are forgotten. If agents could reference templates as structural schemas ("this is what an exploration should look like"), they'd produce more consistent outputs across sessions. This connects to skill reference materials (schemas could live as skill references) and to orchestration (schemas enable machine-checkable completion criteria).

**Scope:** Design a schema for one artifact type (exploration document). Define: what the schema contains, how an agent would reference it, what "validation" means in this context (hard fail vs soft guidance), and where the schema lives (skill reference? standalone file?).

**Method:** Research + consider spike -- analyze the concept, potentially prototype with exploration template

---

### Topic 5: Cross-Platform Portability

**Question:** What are the remaining portability gaps between Cursor and Claude Code for skill execution? Does the same SKILL.md behave identically on both platforms?

**Priority:** Medium (largely answered, but edge cases may exist)

**Context:** The core portability question is answered: the same SKILL.md works in Cursor (`.cursor/skills/`) and Claude Code (`.agents/skills/`). The team's internal Claude marketplace already distributes skills in this format. The remaining question is behavioral: do both platforms handle `disable-model-invocation`, reference file loading, and progressive disclosure the same way? Are there edge cases in how Cursor vs Claude Code parse frontmatter or load reference materials?

**Method:** Research -- targeted testing of specific behavioral differences, not broad standard evaluation

---

### Topic 6: Dual-Distribution Workflow

**Question:** How should dev-infra manage the develop → test → publish workflow across two distribution channels (templates for personal/local projects, Claude marketplace for team)?

**Priority:** Medium

**Context:** Dev-infra serves two audiences: personal/local projects (via templates that seed `.cursor/skills/`) and the team (via an internal Claude plugin marketplace with `plugin.json` + marketplace install). The same SKILL.md artifact works in both, but the distribution packaging differs. Questions: What's the workflow for developing locally, testing in Cursor, and publishing to the marketplace? Which skills are team-appropriate? How to keep the two channels in sync? Does dev-infra's existing template sync validation extend to cover skills?

**Method:** Research / design -- define the workflow, identify sync points, assess which skills to publish

---

### Topic 7: Conversation as Lightweight Orchestration

**Question:** What are the practical limits and required disciplines for using the chat conversation itself as the orchestration layer for multi-agent workflows?

**Priority:** Medium-High

**Context:** The /discuss session revealed that the chat is already a natural orchestration surface -- the user provides context, dispatches subagents inline via the Task tool, and synthesizes outputs conversationally. This is viable today without building formal infrastructure. The open questions are practical: what context hand-off must be included in each subagent task description for it to do good work? What happens when parallel subagents produce outputs that need to be compared? When does conversation-driven orchestration break down and require formal tracker state?

**Method:** Spike -- the limits can only be discovered by running multi-subagent workflows and observing failure modes. Start with research topics as parallel subagents.

---

### Topic 8: Behavioral Contracts in Skill Descriptions

**Question:** How do the behavioral expectations embedded in dev-infra's commands translate into SKILL.md descriptions that hold across platforms and sessions?

**Priority:** Medium

**Context:** Dev-infra's commands work because they establish behavioral contracts, not just capability descriptions. `/discuss` works because it infuses the agent with a collaborator role: pushback, no premature formalization, intellectual engagement. This is different from Cursor's Ask mode, which is a functional switch (read-only) with no behavioral semantics. If these behavioral contracts can be captured in skill descriptions, the commands gain portability and consistency. If not, the behavioral fidelity depends on platform-specific behavior.

**Scope:** Draft the skill description for one high-behavioral-contract command (`/discuss`) and test whether the behavior is consistent in Cursor vs Claude Code. Compare against a low-behavioral-contract command (`/commit`) as a control.

**Method:** Research + spike -- draft descriptions first, then empirically test behavioral consistency

---

### Topic 9: AGENTS.md Portability and Platform Support

**Question:** Is AGENTS.md a reliable portable equivalent of Cursor's always-applied rules? What do platforms actually do with it?

**Priority:** High (gates Theme 9 and the four-layer model)

**Context:** The helm-charts repo already has an AGENTS.md that functions as a conventions document. The open question is behavioral: which tools (Cursor, Claude Code, Codex) actually read AGENTS.md, how consistently, and does it support hub-and-spoke references to other files or must it be self-contained? If platforms don't follow file references, the elegant layered structure breaks down. If portability is inconsistent across tools, AGENTS.md can't serve as the foundation for cross-platform agent identity.

**Scope:** Test AGENTS.md behavior in Cursor and Claude Code. Specifically: (1) is it auto-loaded without configuration, (2) do file path references get followed and loaded, (3) is there any frontmatter or metadata support, (4) does subdirectory AGENTS.md work (per-directory scoping)?

**Method:** Spike -- empirical testing in a throwaway project on both platforms

---

### Topic 10: Roadmap Layer in AGENTS.md

**Question:** What's the right scope and format for a roadmap section in AGENTS.md, and does it belong in dev-infra's initial AGENTS.md implementation?

**Priority:** Low (explicitly deferred from initial implementation)

**Context:** A roadmap layer in AGENTS.md would give agents directional context -- what's in flight, what's planned, what's being explored -- enabling aligned tradeoff decisions without having to ask. The helm-charts AGENTS.md has no such layer; a new agent working there has no awareness of what's being planned. But a stale roadmap may be worse than no roadmap, and maintaining a roadmap section adds overhead. The question is: what's the minimum viable version that delivers alignment value without becoming a maintenance burden?

**Scope:** Design a minimal roadmap section format -- possibly just a pointer to a planning document or a 3-5 line "current focus" statement. Compare against the cost of keeping it current. Assess whether the value justifies inclusion in v0.11.0 or should be deferred.

**Method:** Research / design -- no spike needed; this is a format and scoping decision

---

## 🔬 Spike-Only Items (Not Research Topics)

These are addressed through spikes, not research. They're tracked in the exploration's spike determination table.

| Item | Spike | Depends On |
|------|-------|------------|
| Subagent-per-task delegation | `/spike subagent-task-delegation` | -- |
| Pipeline orchestration with tracker state | `/spike pipeline-orchestrator` | Subagent spike results |
| Superpowers hands-on evaluation | Install and try in throwaway project | -- (optional) |
| Conversation-as-orchestration limits | `/spike conversation-orchestration` | -- (run research topics as parallel subagents as the spike itself) |
| AGENTS.md platform behavior | `/spike agents-md-portability` | -- (test in throwaway project on Cursor + Claude Code) |

---

## ⏳ Downstream Validation (After Architecture Decisions)

These can only be answered after Topics 1-3 are resolved.

| Question | Depends On | When |
|----------|------------|------|
| What's the total maintenance cost delta? | Topics 1-3 (know the target architecture) | After redistribution rubric is applied |
| How does issue #72 interact with skills migration? | Issue #72 resolution + Topic 3 | After #72 is addressed |

---

## 🎯 Research Workflow

```
Topic 1: Auto-detection decision      ← GATE (narrowed by disable-model-invocation finding)
    ↓
Topic 2: Redistribution rubric        ← Apply to representative sample
    ↓
Topic 3: Conversion mechanics          ← Design one complex skill → spike to validate
    ↓
Topic 4: Structural schemas            ← Design one schema as skill reference material
    |
Topic 5: Portability edge cases        ← Behavioral differences between Cursor & Claude Code
    |
Topic 6: Dual-distribution workflow    ← Templates + marketplace sync design
    |
Topic 7: Conversation orchestration   ← Practical limits of chat-as-pipeline (also a spike)
    |
Topic 8: Behavioral contracts          ← Skill descriptions + agent identity configuration
    |
Topic 9: AGENTS.md portability        ← GATE for four-layer model (empirical spike)
    |
Topic 10: Roadmap layer scope         ← Deferred; design only, no spike needed

[After architecture decisions]
    ↓
Downstream: Maintenance cost, issue #72 interaction
    
[Parallel / independent]
Spike: Subagent delegation → Spike: Pipeline orchestration
```

---

**Last Updated:** 2026-03-25
