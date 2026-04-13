# Narrative: Agentic Workflow Modernization — From Commands to Roles

**Date:** 2026-03-25 → 2026-04-10
**Branch:** `develop`

---

## Why This Matters

Dev-infra is a template factory that encodes workflow discipline into project templates. Over 10 months, it accumulated 26 Cursor commands, 3 always-applied rule files, and a sophisticated pipeline for taking ideas from exploration through to implementation. The commands encode genuine process innovations: read-only discussion mode (`/discuss`), granular exploration pipelines, review-then-commit discipline, and documentation-driven development.

But the ecosystem moved. Cursor formalized a three-layer model (rules guide, skills do, commands trigger). Claude Code emerged as a primary agent platform at the company. The team built an internal plugin marketplace. Superpowers (deployed as "Hex" in the marketplace) established an opinionated workflow with subagent-driven development. And the author's own 26 commands were being curl'd into other repos as untracked files — a signal that the value was real but the distribution model was broken.

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

The exploration pivoted when the team's internal Claude plugin marketplace entered the picture. Key discoveries:

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

### Act 5: The Identity and Alignment Turn

A subsequent discussion pushed the architecture further, from *what agents do* to *what agents are*.

**The cursor agent is configurable.** Cursor's "Agent" chat isn't just a command executor -- it's a configurable identity. Cursor's always-applied `.mdc` rules already do this implicitly (the "Response Style" section in `main.mdc` is behavioral configuration, buried under project context). But the insight was sharper: the rules layer could configure the agent's *default disposition* at the foundational level. Instead of `/discuss` shifting away from an implementation-happy default, the default could be collaborative -- and implementation commands (`/task`, `/pr`) would be the explicit departures. This is an architectural inversion.

**Agent alignment must be explicit.** Human organizations align through culture, osmosis, 1:1s. Agents can't. Every subagent starts with zero context; alignment doesn't transfer automatically. This reframed dev-infra's entire documentation artifact system: narratives and explorations aren't just human-readable records -- they're **briefing documents**. The constraints section ("Unique Value to Preserve") is an alignment artifact. A subagent given the narrative before working has the *why*, which shapes tradeoff decisions. The reason documentation-driven development works isn't just human maintainability -- it's that it makes agent alignment reproducible.

**The discussion agent as briefing writer.** When the discussion chat holds alignment context -- narratives, constraints, philosophical intent -- it becomes the natural source of task briefs for implementation subagents. Not just an orchestrator, but a *transmitter of alignment* to workers who would otherwise start fresh. This is the project lead role: understand the whole, brief the parts.

**AGENTS.md as the portable identity layer.** Cursor's `.mdc` rules are Cursor-specific. But `AGENTS.md` is emerging as a cross-platform convention read by multiple tools (Cursor, Claude Code, Codex). The helm-charts repo already has one -- operational content only (conventions, testing patterns, release process). What it lacks is the behavioral and directional layers. A layered AGENTS.md could provide:

- **Identity layer** -- behavioral defaults, the collaborator disposition, constraints
- **Conventions layer** -- what the helm-charts file already has
- **Roadmap layer** -- directional context for aligned tradeoff decisions (deferred; high value, high maintenance)

This creates a four-layer model: AGENTS.md (portable identity) + `.mdc` rules (Cursor-specific) + skills (portable procedural) + commands (simple triggers). The roadmap layer is the most strategically valuable but also the most expensive to maintain -- a minimum viable "current focus" statement may be sufficient for an initial implementation.

The full architecture now has a name: the **briefed agent system**. Distinct agents with defined roles, aligned through explicit artifacts, coordinated conversationally or through orchestration. The discussion chat is the project lead. The artifacts are the shared context. The skills are the role definitions. AGENTS.md is the onboarding document.

### Act 6: The Design Gap and a Portability Correction

After completing Topics 1-4 and two spikes, a `/discuss` session surfaced something that had been nagging: the pipeline has a structural gap. Research produces individual findings and requirements per-topic. Decision commits to an approach. Transition-plan decomposes into implementation tasks. But nothing composes the individual requirements into a coherent designed system. Nobody asks: "What does the user actually experience when we ship 60-80 skills? Is the naming discoverable? Can we ship Stage 1 without breaking people on the old commands?"

The gap has a name: **design**. It sits between decision and transition-plan.

```
/explore → /research → /decision → /design → /transition-plan → /task
```

Two specific problems made this visible:

**Cross-cutting NFRs aren't captured by per-topic research.** Usability, shippability, maintainability, migration safety -- these are quality attributes of the *designed system*, not findings from investigation. FR-1 through FR-15 are technical requirements discovered topic-by-topic. None of them ask "will the user enjoy using this?" or "can each stage be released independently?" Those questions need a design step that applies quality lenses to the whole.

**Staging is a design decision, not a task decomposition.** Agentic workflow modernization is too large to ship at once. "Slim the rules first, then convert 3 pilot skills, then migrate the rest" is a *design* decision about how the system evolves -- not something transition-plan should invent while also breaking down individual tasks. The staging question requires thinking about what the user's experience is at each stage boundary and whether the system is coherent there.

Two artifacts were created: an internal opportunity document capturing the systemic insight (the pipeline needs a `/design` command for any complex feature), and a design directory stub (`admin/designs/agentic-workflow-modernization/`) with a 7-section design document template ready to fill in after the remaining research completes. The sections: System Overview, Cross-Cutting Quality Attributes, Component Design, Interaction Design, Staging Plan, Open Questions / Risks, NFR Checklist.

The design document's most important innovation: Section 7 (NFR Checklist) is an accountability mechanism. It forces explicit sign-off against each quality attribute. "Did we address usability? Here's how. Shippability? Here's how." Without it, quality attributes are aspirational, not verified.

**Topic 5 (Cross-Platform Portability)** was also conducted in this session, yielding a critical correction: Topic 3 Finding 9 had claimed `disable-model-invocation: true` was Cursor-specific. It's not. Claude Code's official documentation explicitly supports it with identical semantics. This was the most pessimistic portability finding from earlier research -- and it was wrong. The actual portability story is substantially better than the earlier assessment suggested.

The full portability picture: skills (SKILL.md format, frontmatter, companion directories, invocation control) are **fully portable** between Cursor and Claude Code. The gap is only in the context layer (AGENTS.md vs CLAUDE.md, requiring a dual-file strategy) and in three Claude Code-specific features that break silently on Cursor (`context: fork`, `$ARGUMENTS`, `` !`command` ``). The practical distribution answer: `.claude/skills/` as the single canonical location, discovered by both platforms.

### Act 7: Distribution Reframed (Topics 5-6)

Topic 6 investigated the dual-distribution question: how should skills reach personal projects (via templates) versus the team (via marketplace)? The initial research proposed an elaborate model: a `marketplace/` directory inside dev-infra, a `publish-marketplace.sh` script, a CI check verifying source-to-marketplace sync, and a monorepo architecture.

Then the user read the findings.

The reframing came not from additional research but from the user's own concurrent thinking track -- they had been processing the research alongside their work on proj-cli and proj-clone. The insight was sharper and simpler than what the agent had produced: the team marketplace is not dev-infra's concern. Dev-infra is the superset. The team marketplace is a curated subset in a separate team-owned repo. Skills authored in `.claude/skills/` format are already 1:1 marketplace-compatible. Shipment is a cherry-pick and a PR. No publish script. No marketplace directory in dev-infra. No source-to-marketplace CI.

This collapsed three proposed requirements into one structural constraint (FR-19: skills must be authored in marketplace-compatible format) and outright withdrew FR-20 (source-to-marketplace CI). The "overbuilt" label on the original Finding 9 is a useful artifact: it shows what happens when the agent researches industry patterns without the user's simplifying judgment about what the project actually needs.

An empirical test confirmed a separate finding: creating a test skill at `.claude/skills/foo-test/SKILL.md` and invoking it as `/foo-test` in Cursor confirmed that Cursor discovers skills from the `.claude/skills/` directory. A further discovery: Cursor scans Claude Code's plugin cache and surfaces installed plugin skills with `plugin:skill` namespacing (the Hex plugin's skills appeared as `hex:brainstorm`, `hex:write-plan`, etc.). This means team marketplace skills are automatically available to Cursor users without any separate packaging step.

### Act 8: The Human Track Revealed (Topic 7)

Topic 7 was a meta-experiment. The research question -- "can conversation serve as the orchestration layer?" -- was answered by the research process itself. Topics 1-8 were conducted serially in conversation sessions. The parallel subagent hypothesis (run Topics 4-8 simultaneously) proved unnecessary because research topics had sequential dependencies: Topic 5 depended on Topic 3's findings, Topic 6 depended on Topic 5's portability conclusions, and so on.

The conversation model provided four things a pipeline couldn't: judgment at every step, cross-topic context accumulation, lateral movement via `/discuss`, and zero ceremony. It lacked three things: cross-session persistence, parallel execution, and formal progress tracking. For a solo developer's research workflow, the lacking features were non-blocking.

But the real insight came after the research was written up, during a `/discuss` session. The user observed that they had been reading Topic 7's findings while the agent was simultaneously conducting Topic 8 -- and that this wasn't unusual. Throughout the research, the human had been operating as a concurrent agent: reading prior topics, forming opinions, connecting dots to other projects, building mental models that only surfaced when they returned to chat. The Topic 6 reframing was the clearest evidence: that insight came entirely from the user's parallel processing, not from anything the agent researched.

This reframed the orchestration model. Topic 7 had described the workflow as serial: agent produces, human reviews, next step happens. The reality was dual-track:

```
Human track:  [reading] [thinking] [connecting to other projects] [forming opinion]
Agent track:  [researching] [writing findings] [updating requirements]
Sync points:  /discuss ←── where the tracks merge
```

The implication for skill design: sync-point skills (discuss, review, plan-review) should be designed knowing the human arrives with parallel processing results. The question isn't "here are the options, which do you pick?" but "what are you seeing from your side?"

### Act 9: Contracts, Not Personas (Topic 8)

Topic 8 started with a focused question -- "what makes a behavioral instruction reliable?" -- and produced the most actionable framework of the entire research.

An audit of all 31 dev-infra commands revealed that behavioral instruction precision was a concentrated problem, not a systemic one. Only 6 commands (discuss, narrative, reflect, int-opp, pr-validation, spike) had significant behavioral content. The other 25 were purely procedural. The problematic instructions clustered into recognizable patterns: persona framing ("play devil's advocate"), unbounded scope ("identify connections the user might not have seen"), and vague qualifiers ("be thorough," "search thoroughly").

The industry had converged on the answer. Multiple independent sources (2025-2026) agreed: persona-based instructions degrade reliability. The replacement is a contract model: Goal (testable success criteria), Constraints (boundary box enforced by code), Output Schema (typed interface), Failure Conditions (what constitutes breach). The meta-principle from Iqbal's "Stop Writing Prompts, Start Writing Contracts" (2026): "Prompting in production is interface design, not communication."

Analysis of 28 SKILL.md files across the Hex and Superpowers plugins revealed the target architecture. Complex behavioral guidance was achieved entirely without personas, through five structural mechanisms: named rules ("Iron Laws" in ASCII art fences), rationalization tables ("Thought → Reality" pre-emption of known failure modes), forbidden response lists (banning performative agreement), gate conditions (binary checks at decision points), and gotchas sections (cases where the model would do something plausible but wrong). Anthropic identified the gotchas section as "the highest-signal content in any skill."

A five-property quality rubric emerged: behavioral instructions must be (1) observable -- compliance determinable from output, (2) bounded -- the agent can determine when it has done enough, (3) outcome-framed -- describes what to produce, not who to be, (4) delta-only -- adds information the model wouldn't have by default, (5) failure-aware -- specifies what NOT to do.

The Spike B transformation ("play devil's advocate" → "name genuine concerns specifically; don't manufacture disagreement") validated the rubric and generalized: every Tier 3 instruction has a Tier 1 rewrite following the same pattern. Replace the persona with an observable behavior. Add a failure mode. Make the trigger condition specific.

Then the discussion sessions pushed the research further.

The user connected Topic 8's escalation ladder (prompt → skill → hook → tool restriction → verify) with their interest in CLI tools, hooks, and proj-cli. The insight: the escalation ladder applies to both tracks. A 400-line command file is fragile for the agent (accuracy degradation above 800 tokens, lost-in-the-middle effects) AND fragile for the human (can't hold in working memory, skims, misses the critical line). The skill decomposition fixes the agent side. Hooks and CLI fix the human side.

This crystallized into a three-state arc:

| State | Agent Input | Human Input | Enforcement |
|-------|------------|-------------|-------------|
| **Current** | Long `.mdc` rules + `.md` commands | Same prose files | Prose ("make sure you do X") |
| **After skill conversion** | Lean skills + templates | Shorter skills, still prose rules | Prose in skill body |
| **After hooks/CLI integration** | Skills carry only judgment work | CLI surfaces state; hooks enforce rules | Deterministic |

The user noted: "Even me as a human could benefit from hooks and automation to focus on work that matters." This is the clearest statement of the research's bottom line: the modernized architecture isn't just about making the agent more effective. It's about making both participants -- human and agent -- spend their attention on judgment, not on parsing prose for deterministic rules.

The two research efforts converge here. Workflow-simplification's NFR-7 (context consumption proportional to work) and agentic-workflow-modernization's escalation ladder are the same principle applied at different scales. The design step (FR-27) is where the allocation happens: skill body for judgment, hooks for deterministic rules, CLI for state surfacing, human sync points for cross-project connections.

### Act 10: The Narrative Gap

Between April 2 and April 10, three research topics were completed, the distribution model was reframed, two post-research amendments captured emergent insights (the dual-track observation and the escalation ladder), and multiple `/discuss` sessions produced refinements that changed requirements. None of it was reflected in this narrative.

The gap exemplifies the dual-track problem from Act 8. The human was processing insights -- reading research, forming reactions, connecting to other projects, having discussions that reshaped findings -- but the capture happened only in the research artifacts (topic documents, requirements, research summary). The story of how the thinking evolved went unrecorded.

This is partly a discipline problem (the user noted they hadn't been routinely using `/narrative`). But it's also a workflow design problem. The current pipeline doesn't have a natural trigger for narrative updates. `/review` captures diffs. `/commit` finalizes changes. `/post-pr` updates status documents. Nothing says "the story has advanced -- update the narrative."

The act of writing this update -- catching up on 8 days of research evolution in a single narrative extension -- is itself evidence. The insights don't flow as naturally when reconstructed after the fact. The Topic 6 reframing was a sharp moment when it happened; documented 8 days later, it reads as a bullet point. The dual-track observation was a genuine discovery during a `/discuss` session; captured retrospectively, it risks sounding like something that was always obvious.

The lesson: narratives should be extended incrementally, as part of the research workflow, not batched at the end. Whether this means `/research --conduct` should prompt a narrative update, or `/discuss --summary` should feed into the narrative, is a design question for the `/design` step.

### Act 11: The Decision Interview and What Emerged From It

With all 8 topics consolidated into 22 final requirements, the next pipeline step was decisions. But the user noticed something about the `/decision` command itself: it takes all requirements and has the agent produce ADRs with minimal human involvement. This was the same rubber-stamp problem that had been accumulating -- the agent does the analysis, the human approves. The dual-track model from Act 8 said both participants should bring their processing. The decision command wasn't doing that.

This triggered two int-opps in quick succession. First, a redesign of `/decision` around three patterns from decision science: an interview step (surface human priorities before the agent does analysis), options-not-answers (present 2-3 approaches with tradeoffs, not a recommendation), and thin-slice clustering (group requirements into decision clusters, decide each independently). Second, a broader observation about pipeline phases: they don't have explicit "start" signals. The decision interview -- a file the human fills out before the agent begins -- became the first example of a phase start signal.

The interview itself proved the concept immediately. Section 1 answers revealed that the v1 scope was the thinking pipeline (explore, research, transition-plan, review, commit, discuss, int-opp) -- not all 26 commands. This came from the human's priorities, not from technical analysis. The user also identified a friction point the research hadn't: explore's conduct mode overlaps with research and should be deprecated. And a "model" concept emerged -- using real-world professional roles (Release Manager, Researcher, Planner) as decomposition lenses for organizing skills. Not runtime agents, but domain models in the programming sense.

Section 2 removed constraints wholesale: sole user means clean cutover, no backward compatibility needed, mixed state is fine, no downstream dependencies. Section 3 validated the skill family architecture through a spike.

The spike tested whether parent SKILL.md behavioral contracts automatically propagate to child skills in nested directories. They don't -- Cursor provides zero implicit inheritance through directory nesting. But the user's conclusion was more interesting than the test result: "maybe this exercise and caution is a bit overblown... AI is quite like an actual agent, and I don't think it's a heavy mental burden to go 'check things in a parent file.'" The explicit reference pattern (child says "read the parent for family conventions") was trivially reliable and preferable to magic. The parent SKILL.md serves dual purpose: a progressive disclosure index for agents (reducing search from 80 flat descriptions to one family orientation), and a shared behavioral contract that children opt into explicitly.

From this spike emerged the session's sharpest insight: a cross-cutting principle that unified findings from across the entire research. **Explicit over implicit.** It appeared everywhere: `disable-model-invocation: true` over auto-detection, behavioral contracts over persona role-play, hooks over prose enforcement rules, explicit "read parent" over automatic inheritance, pre-commit hooks over "never commit without review" instructions. Each instance was the same move: take something implicit and probabilistic, make it explicit and deterministic. The research had been arriving at this principle from eight different angles without naming it. The decision interview discussions finally named it.

The principle was captured as CP-1 in the v1 scope document with a candidate NFR: "When a behavior can be enforced deterministically, it MUST NOT rely on probabilistic enforcement." This reframed FR-22 (enforcement layer allocation) from a medium-priority design concern to a foundational architectural principle.

---

## What Was Learned

### For the Project

- **Dev-infra's workflow innovations are genuinely ahead of the ecosystem** in several areas (discussion mode, granular pipeline, review discipline). The modernization is about better packaging and execution, not about catching up.
- **The skill format is the convergence point.** Same SKILL.md works in Cursor and Claude Code. The marketplace provides distribution. Templates provide local seeding. This is the target format.
- **Artifacts have been inter-agent interfaces all along.** The hub-and-spoke documentation, the status indicators, the template structures — these are proto-schemas for an agent-driven pipeline. Formalizing them as structural schemas completes the picture.
- **AGENTS.md is the portable identity layer.** The four-layer model (AGENTS.md + `.mdc` rules + skills + commands) gives each layer a clear role. The `.mdc` rules can slim down to Cursor-specific concerns; AGENTS.md carries the portable always-on context.
- **Documentation-driven development is also alignment infrastructure.** The real value of narratives, explorations, and constraints sections isn't just human readability -- it's that they make agent alignment reproducible across sessions and subagents.
- **The pipeline needs a design step.** Research → decision → transition-plan skips the holistic "how does this work as a system?" question. Cross-cutting quality attributes and staging need explicit design, not ad-hoc handling during task decomposition.
- **Portability is better than expected.** The skill layer is fully portable between Cursor and Claude Code. The gap is only in the context layer (AGENTS.md vs CLAUDE.md). The earlier pessimism about `disable-model-invocation` being Cursor-only was incorrect.
- **Issue #72 (explore refactor) is a prerequisite** — it simplifies the explore workflow before converting it to a skill.
- **Distribution simplifies to superset/subset.** Dev-infra is the superset of all skills. The team marketplace is a curated subset in a separate repo. No publish script, no marketplace directory, no source-to-marketplace CI in dev-infra. Skills in `.claude/skills/` format are already 1:1 marketplace-compatible.
- **The workflow is dual-track, not serial.** The human and agent work concurrently with async sync via `/discuss`. The human arrives at sync points with parallel processing results (cross-project connections, reframings, priority judgments) that the agent doesn't have. Sync-point skills should invite those results, not just present options.
- **The escalation ladder applies to both participants.** Hooks and CLI reduce cognitive load for the human (deterministic enforcement, state surfacing) just as they reduce token cost for the agent (fewer non-judgment instructions). The three-state arc -- prose → lean skills → hooks/CLI -- is the architectural roadmap.
- **Two research efforts converge.** Workflow-simplification's NFR-7 (context proportional to work) and agentic-workflow-modernization's escalation ladder are the same principle at different scales. The design step is where the allocation happens.
- **Behavioral contracts have a rubric.** Five properties: observable, bounded, outcome-framed, delta-only, failure-aware. The Hex/Superpowers plugin skills demonstrate the target: named rules, rationalization tables, gotchas -- no personas.
- **Explicit over implicit is the unifying principle.** Invocation control, behavioral contracts, enforcement mechanisms, context sharing, commit safety -- the research arrived at the same answer from eight angles. Make it explicit and deterministic. Don't depend on the probabilistic layer when the deterministic layer works.
- **Skill families work through explicit reference, not automatic inheritance.** Parent SKILL.md serves dual purpose: progressive disclosure index for agents and shared behavioral contract for children. The spike confirmed directory nesting provides zero implicit propagation -- and that's preferable.
- **The decision interview is the first pipeline start signal.** The human fills it out before the agent begins analysis. This pattern generalizes: each pipeline phase should have an explicit start artifact.

### For the Engineer

- **The apprentice paradox.** Being junior in domain knowledge while advanced in process knowledge creates real friction in organizations that only evaluate the first kind. But the work speaks for itself — especially when the industry converges on the same patterns you independently developed.
- **Don't underestimate what you've built.** The assumption coming back was "I'm probably behind." The reality was the opposite. Time away from a project can distort your sense of its value.
- **`/discuss` proved its value in this very session.** Multiple ideas (structural schemas, orchestration, the marketplace insight, the artifacts-as-interfaces reframe, agent identity, AGENTS.md) emerged through discussion and were promoted to formal artifacts only when they were ready. The command did exactly what it was designed to do: separate thinking from doing.
- **The "be a scientist" insight ages well.** What once felt like a clever chatbot trick -- giving an agent a role persona via markdown -- turns out to be the foundation of a serious multi-agent architecture. The difference is formalism, portability, and the understanding of *why* it works.
- **Narratives capture what other artifacts miss.** The exploration document has the themes. The research topics have the questions. But the *story* of how the thinking evolved — the sequence of insights, the moments of realization — only exists in a narrative.
- **The human is a co-researcher, not just a reviewer.** The dual-track model was visible throughout: reading research while the agent conducted the next topic, forming reframings from parallel thinking, connecting dots to other projects. The best insights (Topic 6 reframing, escalation ladder on both tracks) came from the human's concurrent processing, not from the agent's research.
- **Form your thoughts before handing them off.** A self-correction during the `/discuss` sessions: "lazily formed" discussion points that hand all the thinking to the agent aren't productive. The agent can help refine and challenge, but the human needs to do their own judgment work. The dual-track model works because both tracks are active.
- **The narrative gap is real.** Eight days of research, reframings, and emergent insights went uncaptured in the narrative. The retrospective reconstruction loses the sharpness of the moments. Narratives should be extended incrementally, not batched.
- **The interview is doing the human's judgment work.** Questions like "which 5 commands would you convert first?" forced priority thinking that the requirements doc couldn't. The honest "I don't know" on that question was itself a signal -- it revealed that the value proposition isn't format conversion but behavioral precision.
- **Naming the principle matters.** "Explicit over implicit" was visible in the research from Topic 1 onward, but it took the spike discussion to name it as a single principle. Naming it changed how everything else was understood -- it went from eight separate findings to one architectural stance.

---

## The Commits

```
529a5b8 docs(explore): create agentic-workflow-modernization exploration
7f6481f docs(explore): amend agentic-workflow-modernization with themes 7-8
994a854 docs(explore): restructure agentic-workflow-modernization exploration
2835cfa docs(explore): amend agentic-workflow-modernization with marketplace context
52fd914 docs(narrative): capture agentic-workflow-modernization session narrative
725448c docs(commands): add /narrative command for post-completion storytelling
37c2519 docs: anonymize company-specific references in exploration artifacts
cfc36ab docs(explore): amend with agent identity, AGENTS.md, and alignment themes
84dc9c9 docs(spike): document AGENTS.md portability spike learnings
e3020f8 docs(spike): document command-to-skill conversion spike learnings
b3871c1 docs(spike): add finding on behavioral persona underspecification
d3e2636 docs(research): scaffold agentic-workflow-modernization research
184c3a2 docs(research): conduct topic 1 - auto-detection vs explicit invocation
55265a6 docs(research): conduct topic 2 - three-layer redistribution criteria
b50c013 docs(explore): amend agentic-workflow-modernization with orchestration model
862b7fc docs(research): conduct Topic 3 -- command-to-skill conversion mechanics
9595842 docs(research): amend Topic 3 with three gaps from post-research discussion
003d3b8 docs(research): conduct Topic 4 -- templates as structural schemas
1155360 docs(explore): amend exploration with research findings from Topics 1-4
c9fd4cb docs(explore): capture identity-level vs skill-level behavioral contract distinction
f2a54fb docs(research): conduct Topic 5 portability, identify design gap, capture prior art
c138584 docs(research): conduct Topic 6 -- dual-distribution workflow
d5e5afa docs(research): conduct Topic 7 -- conversation as orchestration
5841bfc docs(research): consolidate agentic-workflow-modernization requirements
b60dec1 docs(int-opp): capture decision command human involvement gap
f6ad03e docs(int-opp): capture pipeline phase start signals gap
ae12386 docs(spike): document nested skill discovery and context sharing results
f8b02c7 docs(spike): capture explicit-over-implicit principle from spike discussion
[uncommitted] docs(narrative): extend narrative with Act 11 -- decision interview and principle
```

---

## Related Artifacts

| Artifact | Location |
|----------|----------|
| Exploration | `admin/explorations/agentic-workflow-modernization/exploration.md` |
| Research Topics | `admin/explorations/agentic-workflow-modernization/research-topics.md` |
| Spike Learnings | `admin/explorations/agentic-workflow-modernization/spike-learnings.md` |
| Research Hub | `admin/research/agentic-workflow-modernization/README.md` |
| Research Summary | `admin/research/agentic-workflow-modernization/research-summary.md` |
| Requirements | `admin/research/agentic-workflow-modernization/requirements.md` |
| Topic 6: Dual-Distribution | `admin/research/agentic-workflow-modernization/topic-6-dual-distribution.md` |
| Topic 7: Conversation Orchestration | `admin/research/agentic-workflow-modernization/topic-7-conversation-orchestration.md` |
| Topic 8: Behavioral Contracts | `admin/research/agentic-workflow-modernization/topic-8-behavioral-contracts.md` |
| Design Stub | `admin/designs/agentic-workflow-modernization/design.md` |
| Design Gap Int-Opp | `admin/planning/opportunities/internal/dev-infra/improvements/design-step-in-pipeline.md` |
| Decision Interview | `admin/decisions/agentic-workflow-modernization/decision-interview.md` |
| V1 Scope (incremental) | `admin/decisions/agentic-workflow-modernization/v1-scope.md` |
| Nested Skill Discovery Spike | `admin/explorations/agentic-workflow-modernization/spike/nested-skill-discovery.md` |
| Skill Family Test Fixtures | `.claude/skills/explore/` (parent + explore-test + explore-test-b) |
| Decision Command Int-Opp | `admin/planning/opportunities/internal/dev-infra/improvements/decision-command-human-involvement.md` |
| Pipeline Start Signals Int-Opp | `admin/planning/opportunities/internal/dev-infra/improvements/pipeline-phase-start-signals.md` |
| Cross-Platform Discovery Test | `.claude/skills/foo-test/SKILL.md` |
| Issue #72 (Explore Refactor) | GitHub issue #72 |
| Issue #73 (Command Drift) | GitHub issue #73 |
| Issue #75 (Narrative Command) | GitHub issue #75 |
| Issue #76 (Portable Commands) | GitHub issue #76 |
| Marketplace Skill | `update-pr-description` in team's internal Claude marketplace |
| Hex (Superpowers) | `plugins/workflows/hex/` in team's internal Claude marketplace |

---

**Last Updated:** 2026-04-13 (Amended: Act 11 — decision interview, skill family spike, explicit-over-implicit principle)
