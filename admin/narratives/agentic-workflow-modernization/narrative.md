# Narrative: Agentic Workflow Modernization — From Commands to Roles

**Date:** 2026-03-25
**Branch:** `develop`

---

## Why This Matters

Dev-infra is a template factory that encodes workflow discipline into project templates. Over 10 months, it accumulated 26 Cursor commands, 3 always-applied rule files, and a sophisticated pipeline for taking ideas from exploration through to implementation. The commands encode genuine process innovations: read-only discussion mode (`/discuss`), granular exploration pipelines, review-then-commit discipline, and documentation-driven development.

But the ecosystem moved. Cursor formalized a three-layer model (rules guide, skills do, commands trigger). Claude Code emerged as a primary agent platform at DRW. The team built an internal plugin marketplace. Superpowers (deployed as "Hex" in the marketplace) established an opinionated workflow with subagent-driven development. And the author's own 26 commands were being curl'd into other repos as untracked files — a signal that the value was real but the distribution model was broken.

Coming back to the project after time away, the question was: is dev-infra behind, or is it still relevant?

---

## What Made This One Different

This wasn't a typical feature exploration. It started as a gap analysis ("what do skills and Superpowers offer that we don't have?") and evolved into something deeper: an architectural rethinking of how the entire workflow system operates.

The surprise was directional. The expectation was that the ecosystem had leapfrogged dev-infra. The reality was that dev-infra had independently arrived at most of the same patterns as Superpowers — and in several cases, had gone further. The read-only discussion mode, the granular exploration pipeline, and the review-then-commit two-step have no equivalents in Hex or any other published workflow system.

The real gap wasn't in *what* dev-infra did, but in *how it packaged and executed it*: single-conversation commands vs portable cross-platform skills, and sequential human-driven invocation vs subagent-driven delegation.

| Dimension | Dev-Infra (Before) | Ecosystem (Now) | Gap |
|-----------|-------------------|-----------------|-----|
| Workflow definition | Cursor commands (`.md` files) | Skills (SKILL.md + references + metadata) | Format and portability |
| Distribution | Template seeding, ad-hoc curl | Marketplace with versioning and install | Distribution model |
| Execution model | One agent, one conversation | Subagent-per-task, fresh context | Isolation and parallelism |
| Context management | Always-on rules (500+ lines) | Progressive disclosure (load on demand) | Context efficiency |
| Platform | Cursor-only | Cross-platform (Cursor + Claude Code) | Portability |
| Unique advantages | `/discuss`, granular pipeline, review discipline | Auto-detection, subagent coordination | Philosophy |

---

## How the Thinking Evolved

### Act 1: Ecosystem Reconnaissance

The session began with two questions: what are "skills" and what is "Superpowers"? Research revealed the three-layer taxonomy (rules guide, skills do, commands trigger) and Superpowers' seven-phase workflow. Mapping dev-infra's commands against Superpowers showed extensive overlap — brainstorming, worktrees, planning, TDD, review, branch finishing all had dev-infra equivalents. The one genuine gap: subagent-driven development.

The initial assessment proposed three paths: evolve in place (decompose rules into skills), migrate commands to skills (Path B), or adopt Superpowers. The instinct aligned with Path B.

### Act 2: The Exploration

Six themes were mapped: three-layer redistribution, auto-detection vs explicit invocation, conversion mechanics, structural schemas, subagent integration, and orchestration. The themes went through a scoping review that merged overlaps, elevated constraints, and exposed a missing theme (conversion mechanics). Research topics were reordered by dependency, with auto-detection as the gating decision.

Two ideas emerged from discussion that expanded the scope:

**Templates as structural schemas.** The insight that templates aren't just generators — they could serve as living structural contracts that agents validate against throughout a document's lifecycle. A "type system for knowledge artifacts." This connects to how agents maintain consistency across sessions and how orchestration validates completeness.

**Orchestration with materialized workflow state.** The existing status indicators in documents (`🔴`, `🟠`, `✅`) are proto-tracker state. A tracker file that encodes pipeline progress could coordinate subagents, with human checkpoints at key decision gates.

### Act 3: The Marketplace Discovery

The exploration pivoted when the DRW UP Claude Marketplace entered the picture. Key discoveries:

- **Hex (Superpowers) is already deployed** in the team marketplace (v2.1.0). The comparison isn't theoretical — it's "my workflow vs the thing my teammates already use."
- **A skill has already been built.** The `update-pr-description` skill exists in the marketplace, confirming the format is understood.
- **The format bridge is real.** The same SKILL.md works in Cursor (`.cursor/skills/`) and Claude Code (`.agents/skills/`). No conversion step needed.
- **`disable-model-invocation: true`** in SKILL.md frontmatter allows per-skill opt-out of auto-detection. This supports a hybrid model without a global architecture decision.
- **The skill directory structure accommodates reference materials.** Doc templates, configs, and structural schemas can live *inside* the skill. The workflow becomes a self-contained package.

This collapsed several open questions. Portability: answered. Conversion format: known. Distribution model: marketplace + templates. The research topics were updated accordingly.

### Act 4: The Architectural Shift

The deepest insight came from reflecting on how subagents actually work and what dev-infra's artifacts actually are.

**The reframe:** Dev-infra's artifacts (explorations, research docs, decisions, implementation plans) aren't just documentation for human handoff between sessions. They're **interface contracts between agents**. The exploration document is the input specification for the research agent. The implementation plan is the task specification for the implementation agent. The system has been building an inter-agent communication protocol — it just called it "documentation."

**The context flip:** The old worry was "what if we lose context between sessions?" The new frame: fresh context is a *feature*. Each subagent gets exactly what it needs via artifacts. No accumulated bias, no context degradation. Artifacts are the stable interface; conversations are ephemeral.

**The execution model shift:** Dev-infra has been a system of *instructions to one agent* (commands in a conversation). It needs to evolve into a system of *roles for multiple agents* (skills as subagent role definitions). Each skill defines what an agent role does, what artifacts it consumes, and what artifacts it produces. The structural schema defines the output contract. The orchestrator coordinates handoff.

This is the three-layer architecture:

1. **Skills** (behavioral contracts) — what each agent role does
2. **Artifacts with schemas** (interface contracts) — the stable handoff layer
3. **Orchestrator** (coordination) — tracker file + loop that manages the pipeline

Layer 1 is the immediate work. Layer 2 is mostly built. Layer 3 is the vision.

---

## What Was Learned

### For the Project

- **Dev-infra's workflow innovations are genuinely ahead of the ecosystem** in several areas (discussion mode, granular pipeline, review discipline). The modernization is about better packaging and execution, not about catching up.
- **The skill format is the convergence point.** Same SKILL.md works in Cursor and Claude Code. The marketplace provides distribution. Templates provide local seeding. This is the target format.
- **Artifacts have been inter-agent interfaces all along.** The hub-and-spoke documentation, the status indicators, the template structures — these are proto-schemas for an agent-driven pipeline. Formalizing them as structural schemas completes the picture.
- **Issue #72 (explore refactor) is a prerequisite** — it simplifies the explore workflow before converting it to a skill.

### For the Engineer

- **The apprentice paradox.** Being junior in domain knowledge while advanced in process knowledge creates real friction in organizations that only evaluate the first kind. But the work speaks for itself — especially when the industry converges on the same patterns you independently developed.
- **Don't underestimate what you've built.** The assumption coming back was "I'm probably behind." The reality was the opposite. Time away from a project can distort your sense of its value.
- **`/discuss` proved its value in this very session.** Multiple ideas (structural schemas, orchestration, the marketplace insight, the artifacts-as-interfaces reframe) emerged through discussion and were promoted to formal artifacts only when they were ready. The command did exactly what it was designed to do: separate thinking from doing.
- **Narratives capture what other artifacts miss.** The exploration document has the themes. The research topics have the questions. But the *story* of how the thinking evolved — the sequence of insights, the moments of realization — only exists in a narrative.

---

## The Commits

```
9893a20 docs(explore): create agentic-workflow-modernization exploration
a2a0449 docs(explore): amend agentic-workflow-modernization with themes 7-8
ba6548d docs(explore): restructure agentic-workflow-modernization exploration
84ea688 docs(explore): amend agentic-workflow-modernization with marketplace context
```

---

## Related Artifacts

| Artifact | Location |
|----------|----------|
| Exploration | `admin/explorations/agentic-workflow-modernization/exploration.md` |
| Research Topics | `admin/explorations/agentic-workflow-modernization/research-topics.md` |
| Issue #72 (Explore Refactor) | GitHub issue #72 |
| Issue #73 (Command Drift) | GitHub issue #73 |
| Issue #75 (Narrative Command) | GitHub issue #75 |
| Issue #76 (Portable Commands) | GitHub issue #76 |
| Marketplace Skill | `update-pr-description` in DRW UP Claude Marketplace |
| Hex (Superpowers) | `plugins/workflows/hex/` in DRW UP Claude Marketplace |

---

**Last Updated:** 2026-03-25
