# Exploration: Agentic Workflow Modernization

**Status:** 🟠 In Progress
**Created:** 2026-03-25
**Amended:** 2026-03-25 - Added themes from /discuss session (templates as structural schemas, orchestration and tracker state)
**Restructured:** 2026-03-25 - Merged overlapping themes, added constraints section, reordered by dependency, added conversion mechanics theme
**Amended:** 2026-03-25 - Added Theme 6 (dual-distribution model), updated Themes 2-3 and reference section with marketplace findings
**Amended:** 2026-03-25 - Added Themes 7-8 from /discuss session (conversation as orchestration, agent roles and behavioral contracts)
**Amended:** 2026-03-25 - Widened Theme 8 (agent identity + alignment), added Theme 9 (AGENTS.md as portable identity layer)
**Amended:** 2026-03-25 - Added Theme 10 (discussion session as five-stance orchestration layer, hooks extension model)

---

## 🎯 What We're Exploring

Dev-infra has 26+ Cursor commands, 3 always-applied `.mdc` rule files, and no user-created skills. The Cursor ecosystem has since formalized a three-layer model (rules guide, skills do, commands trigger), and third-party systems like Superpowers have emerged with opinionated workflow enforcement. This exploration maps the territory: where dev-infra's existing system aligns with, diverges from, or exceeds these patterns -- and what a modernization path looks like.

The core tension: dev-infra's command system was built before skills existed. Some commands are behavioral guidance (better as rules or skills), some are procedural workflows (natural skills), and some are genuinely trigger-style commands. The rules files carry significant always-on context cost. The question is how to decompose and redistribute across the three layers without losing the sophistication that's already there.

---

## 🛡️ Constraints: Unique Value to Preserve

These patterns have no equivalent in the broader ecosystem. Any modernization that loses them would be a regression. They apply as constraints across all themes.

- **`/discuss` (read-only discussion mode)** -- The insight that agentic coding conflates thinking with doing is genuinely novel. No workflow system, including Superpowers, formalizes this distinction.
- **Granular exploration pipeline** -- `/explore` → `/research` → `/decision` → `/transition-plan` is richer than any single "brainstorming" phase. The toolbox model from issue #72 makes this even stronger.
- **Review-then-commit two-step** -- The explicit human pause between AI changes and committing is more disciplined than automatic review.
- **Hub-and-spoke documentation** -- Feature planning, status tracking, and documentation-driven development have no ecosystem equivalent.
- **Separation of exploration modes** -- Setup vs amend (post issue #72) preserves the mapping-vs-investigating distinction.

---

## 📊 Reference: Superpowers / Hex Comparison

Superpowers (deployed as "Hex" in the team's internal Claude plugin marketplace) implements a seven-phase opinionated workflow (brainstorming → worktrees → planning → subagents → TDD → review → branch finishing). **Hex is already deployed in the team marketplace** (v2.1.0) alongside dev-infra's commands. Dev-infra independently arrived at most of these patterns:

| Superpowers Phase | Dev-Infra Equivalent | Dev-Infra Advantage |
|-------------------|---------------------|---------------------|
| Brainstorming | `/explore`, `/discuss` | Separates read-only thinking from artifact creation |
| Git worktrees | Worktree workflow | Integrated with draft PR flow |
| Planning | `/plan-review`, `/transition-plan`, `/task` | More granular, feature-plan-aware |
| Subagent-driven dev | (no equivalent) | — |
| TDD | `/task` (built-in TDD) | Integrated with task tracking |
| Code review | `/review` + `/commit` | Explicit human pause, two-step |
| Branch finishing | `/post-pr`, `/pr --ready` | Draft PR integration |

The key philosophical difference: Superpowers enforces workflow automatically via skills that trigger without user invocation. Dev-infra's system is modular and explicitly invoked. Superpowers' "subagent-driven development" (fresh context per task) is the one area with no dev-infra equivalent.

---

## 🔍 Themes

### Theme 1: Three-Layer Redistribution

The central question of this exploration: how to redistribute everything currently in rules + commands across the three-layer model (rules, skills, commands).

**Rules content to sort:**

The three `.mdc` files (`main.mdc`, `workflow.mdc`, `template.mdc`) load into every conversation regardless of task relevance. They contain a mix of:

- **Passive behavioral guidance** (project identity, branching strategy, commit format, documentation standards) -- genuinely belongs in always-on rules
- **Procedural knowledge** (release process, PR review workflow, TDD patterns, template validation steps) -- better suited to on-demand loading via skills
- **Current project state** (version, completed features, in-progress work) -- arguably belongs in rules but could be auto-generated

**Commands content to sort:**

The 26+ commands span a wide spectrum:

- **Simple triggers** (`/commit`, `/review`, `/status`) -- appropriate as commands; don't benefit from auto-detection or progressive disclosure
- **Moderate workflows** (`/fix-plan`, `/fix-implement`, `/pr`) -- could be either; threshold question is whether auto-detection or reference materials add value
- **Complex procedural workflows** (`/explore`, `/research`, `/task`, `/transition-plan`) -- natural candidates for skills with progressive disclosure and auto-detection

The skills model offers progressive disclosure (agent sees name + description, loads full content only when relevant) and auto-detection (agent decides when to invoke based on context). Both address real problems: context overhead for rules, and discoverability for commands.

**Connections:**
- Gated by Theme 2 (auto-detection decision) -- the sorting criteria depend on whether auto-detection is part of the model
- Informed by Theme 3 (conversion mechanics) -- practical constraints of the skill format may affect what's worth migrating

**Concerns:**
- Risk of over-decomposing: too many small skills could be harder to maintain than a few comprehensive rules
- Discovery problem: if the agent doesn't load a skill when it should, the workflow breaks silently
- Migration complexity: rules have been refined over months; splitting them risks losing nuance
- The `/` menu mixing skills and commands could be confusing
- Maintaining both skills and commands for the same workflows during migration creates duplication

---

### Theme 2: Auto-Detection vs Explicit Invocation

This is the core design decision that gates everything else. If the answer is "always explicit," skills are just portable commands with progressive loading. If the answer is "hybrid," the architecture changes fundamentally.

Superpowers enforces workflow automatically via skills that trigger without user invocation. Dev-infra's `/discuss` command exists precisely because auto-formalization is a problem -- the insight that agentic coding conflates thinking with doing. The tension between discipline (auto-enforcement) and autonomy (explicit invocation) is real.

Possible positions:

- **Always explicit** -- Skills replace commands for portability and progressive loading, but the user always invokes. Simplest migration, preserves dev-infra's philosophy.
- **Selective auto-detection** -- Some skills auto-detect (e.g., `/task` activates when implementation plan files are present), others stay explicit. Requires careful design of detection criteria.
- **Full auto-enforcement** -- Superpowers model. Agent decides the workflow. Conflicts with `/discuss` philosophy.

**Key finding from /discuss:** The SKILL.md frontmatter supports `disable-model-invocation: true`, which prevents auto-detection at the individual skill level. This means the choice isn't global -- each skill can independently opt in or out of auto-detection. This supports a hybrid model where most dev-infra skills are explicit-only while specific ones (e.g., structural validation) could auto-detect.

**Connections:**
- Gates Theme 1 (redistribution) -- the sorting criteria for commands-to-skills depends on this decision
- Relates to Theme 5 (orchestration) -- auto-detection at the skill level vs pipeline-level orchestration are related but different questions

**Concerns:**
- Auto-detection could trigger workflows the user didn't intend
- Selective auto-detection requires maintaining detection criteria alongside the skills themselves
- The hybrid model is the most flexible but also the most complex to reason about

---

### Theme 3: Command-to-Skill Conversion Mechanics

Before deciding *what* to migrate, we need to understand *how*. The skill format differs from commands: a `SKILL.md` with YAML frontmatter in a directory (with optional reference files) vs a single `.md` command file.

**Key finding from /discuss:** The format gap is smaller than expected. A real-world skill has been built (`update-pr-description` for the team's internal Claude marketplace), confirming the format is understood. The same SKILL.md works in both Cursor (`.cursor/skills/`) and Claude Code (`.agents/skills/`). The skill directory structure naturally accommodates reference materials, templates, and configs -- meaning dev-infra's doc templates can live *inside* the skill as structural schemas.

**The marketplace plugin format** wraps skills with distribution metadata:

```
plugin-name/
├── .claude-plugin/plugin.json   # metadata (name, version, author, keywords)
├── README.md                     # install/usage docs
└── skills/skill-name/
    └── SKILL.md                  # the actual skill (+ reference files)
```

Remaining practical questions:

- How do complex multi-mode commands (e.g., `/explore` with setup/amend) decompose into the skill format?
- How does the 500-line SKILL.md limit affect commands that are currently 500+ lines? (Progressive disclosure via reference files likely solves this)
- How does template sync validation work for skills across two templates + dev-infra?
- What's the description sweet spot for auto-detection without false positives?

**Connections:**
- Informs Theme 1 (redistribution) -- practical constraints of skill format affect what's worth migrating
- Relates to Theme 4 (schemas) -- schemas could be skill reference materials
- Issue #72 is relevant -- if `/explore --conduct` is removed, the explore skill becomes simpler

**Concerns:**
- The 500-line limit may force decomposition of complex commands that work well as monoliths
- Testing skills is different from testing commands -- no existing test infrastructure
- Template sync validation would need to handle skills as a third artifact type

---

### Theme 4: Templates as Structural Schemas

Dev-infra's templates currently serve as generators -- they define the initial shape of a document or project, then are forgotten. But templates could serve a second, more powerful role: **structural contracts** that agents reference throughout the lifecycle, not just at creation time.

In software, schemas (database schemas, API contracts, type systems) enforce structural agreement between independent actors. But in document-driven agentic workflows, there's no equivalent. When an agent edits an exploration document in a later session, it has no reference for "what is the expected shape of an exploration document?" It relies on lengthy command instructions or infers from the existing content.

If templates were treated as **living structural contracts**, agents could:

- Validate that a document still conforms to its expected shape after edits
- Understand what sections are expected without loading the full command instructions
- Use the template as a lightweight reference (cheaper than loading the full skill/command)
- Enable orchestration (Theme 5) by providing machine-checkable completion criteria

This is essentially proposing a **type system for knowledge artifacts**. The template defines the type; the document is an instance.

**Connections:**
- Relates to Theme 3 (conversion mechanics) -- schemas could be skill reference materials
- Enables Theme 5 (orchestration) -- schemas are the contracts that make automated handoff trustworthy
- Connects to the `ai-prompt-lifecycle` exploration -- how agents consume context shapes how schemas should be exposed

**Concerns:**
- Rigidity vs flexibility: the more structure you add for automation, the more constrained humans become when deviating intentionally
- Schema drift: if templates evolve but existing documents don't get migrated, validation breaks
- Overhead: maintaining schemas alongside templates and commands adds another artifact to keep in sync

---

### Theme 5: Subagent Integration and Orchestration

*This theme combines the subagent-per-task question with the broader orchestration question, since orchestration depends on subagent capabilities.*

**Subagent-per-task:**

Cursor's native Task tool spins up isolated subagents with fresh context. Superpowers uses this as "subagent-driven development" -- one task per subagent, each reviewed against the plan. Dev-infra's `/task` command currently runs everything in a single conversation context. For larger features with many tasks, context accumulates and degrades. Subagent-per-task could give each task a clean context window, allow parallel execution, enforce isolation, and improve review quality.

**Pipeline orchestration:**

Dev-infra's explore → research → decision → transition-plan pipeline is currently human-driven. But it could be partially automated using **materialized workflow state** -- tracker files that encode what phase the work is in, what's been completed, and what's ready for the next step.

The status indicators already embedded in documents (`🔴 Scaffolding`, `🟠 In Progress`, `✅ Expanded`) are proto-tracker state. Combined with structural schemas (Theme 4), an orchestrator could read these markers to determine pipeline readiness, spawn appropriate agents, validate output, and determine the next step -- with human checkpoints at key decision points.

This maps to the earlier idea of a CLI running an infinite loop with agents and subagents -- each phase as a subagent invocation, with the tracker file as the baton.

**Dependency chain:** Schemas (Theme 4) enable validation → subagents enable task delegation → orchestration coordinates the pipeline.

**Connections:**
- Depends on Theme 4 (schemas) -- schemas make handoff trustworthy
- Depends on Theme 2 (auto-detection) -- orchestration is auto-detection at the pipeline level
- Relates to the Superpowers comparison -- Superpowers' auto-triggering is a simpler version of this

**Concerns:**
- Subagent context is limited -- no access to conversation history or user messages
- Coordination between subagents requires careful task specification
- Autonomy vs control: fully automated pipelines risk running ahead of human understanding
- Complexity: building a reliable orchestrator is significantly more work than maintaining manual commands
- The explore → research flow isn't always linear (issue #72's toolbox model). An orchestrator that assumes linearity would be too rigid
- Failure modes: what happens when an agent produces a document that doesn't validate?

---

### Theme 6: Dual-Distribution Model

Dev-infra serves two audiences that require different distribution channels:

1. **Team (work):** The team's internal Claude plugin marketplace is the distribution channel for Claude Code skills. The team already uses this marketplace (Hex, daily-summary, and domain-specific plugins). Publishing dev-infra's workflow skills here makes them accessible to teammates who use Claude Code as their primary agent. The marketplace provides versioning, metadata (`plugin.json`), install mechanisms, and discovery.

2. **Personal / local projects:** Dev-infra templates continue to seed new projects with `.cursor/skills/` (or `.cursor/commands/` for simple triggers). This serves personal projects, open source work, and any context where the team marketplace isn't relevant. Dev-infra remains the source of truth; the marketplace is a distribution target.

The critical insight: **the same SKILL.md artifact works in both channels.** Cursor reads from `.cursor/skills/`, Claude Code reads from `.agents/skills/`, and the marketplace wraps both with distribution metadata. Dev-infra develops and tests skills locally (Cursor), then packages for the marketplace (Claude plugin format) when ready to share.

This dual model means dev-infra's identity as a "template factory" expands: it produces not just project templates, but also **portable workflow skills** that can be distributed through multiple channels.

**Connections:**
- Directly addresses issue #73 (command drift) -- marketplace versioning solves freshness
- Directly addresses issue #76 (portable commands) -- skills replace the ad-hoc curl workflow
- Relates to Theme 1 (redistribution) -- the distribution model affects what stays as commands (simple triggers for Cursor only) vs skills (portable across channels)
- Relates to Theme 3 (conversion mechanics) -- the marketplace format is the target packaging

**Concerns:**
- Maintaining two distribution channels (templates + marketplace) could create sync drift at a different level
- Not all skills are appropriate for the team marketplace (some are personal workflow preferences)
- The marketplace has its own conventions and review expectations that may affect skill design

---

### Theme 7: Conversation as Lightweight Orchestration

The `/discuss` session surfaced a natural reframe: the chat itself is already an orchestration layer. Rather than building a formal pipeline orchestrator (Theme 5), the user drives orchestration conversationally -- providing context, dispatching subagents inline, and analyzing outputs as they arrive. The agent doesn't need tracker files or machine-readable state; the conversation *is* the state.

This is meaningfully different from Theme 5's vision of a CLI running automated loops. Conversation-as-orchestration is human-in-the-loop by design: the user reads results, decides what to do next, and launches the next subagent with context from the previous one. The chat window becomes the coordination surface.

This pattern already works today -- the Task tool can be invoked mid-conversation, outputs returned and analyzed, then follow-up tasks launched based on what was learned. The friction points are: subagents can't read conversation history (they need explicit context hand-off), outputs need to be somewhere they can be referenced (files or direct return), and parallel subagents require careful prompt construction to avoid overlap.

**Connections:**
- Complements Theme 5 (orchestration) -- conversation-driven is the low-infrastructure version; tracker-state is the higher-autonomy version
- Relates to Theme 2 (auto-detection) -- conversation-driven orchestration is inherently explicit, not auto-triggered
- The chat transcript itself becomes a lightweight artifact -- not a structured document, but a record of decisions and outputs

**Implications:**
- Research and spike topics could be run as parallel subagents within a single conversation, with the user synthesizing results
- This is viable *now* without any infrastructure build; it's the pragmatic entry point before investing in formal orchestration
- The `/discuss` command's read-only guarantee matters here: keeping discussion separate from execution preserves the user's ability to reason before dispatching

**Concerns:**
- Conversation state is ephemeral -- if the session ends, the orchestration context is lost unless artifacts were written
- Parallelism is limited by the user's ability to manage multiple subagent outputs in one session
- Context hand-off to subagents requires discipline: the user must write clear, self-contained task descriptions or the subagent lacks the context to do good work

---

### Theme 8: Agent Identity, Behavioral Contracts, and Alignment

Commands don't just trigger actions -- they establish behavioral contracts. `/discuss` doesn't just mean "read-only"; it means "be a collaborator who pushes back rather than validating whatever I say." The invocation carries an expectation about *how the agent should behave*, not just *what it should do*.

This generalizes. Each command in dev-infra's pipeline implies a distinct agent role:

- `/discuss` → **Collaborator**: engage critically, offer pushback, don't formalize
- `/explore` → **Mapper**: survey territory, organize thoughts, don't commit to solutions
- `/research` → **Investigator**: deep-dive specific questions, surface evidence
- `/spike` → **Experimentalist**: hands-on validation, throwaway mindset, learning-focused
- `/task` → **Implementer**: execute with discipline, TDD, review-then-commit
- `/review` → **Auditor**: read-only assessment, no changes

The behavioral contract is what makes `/discuss` consistently useful -- it's not just a mode switch, it's a role assignment that shapes how the agent interprets everything in the conversation. The contrast with Cursor's built-in "Ask mode" is instructive: Ask mode is a Cursor-specific switch with no behavioral semantics beyond read-only. `/discuss` infuses the agent with the *spirit* of discussion: intellectual engagement, willingness to disagree, and deliberate restraint from premature action.

**Agent identity at the rules/configuration level:** This goes deeper than individual commands. The Cursor agent (this chat) can be configured at the rules level to have a default disposition -- "your default role in this repo is collaborator; you read before writing; you spawn subagents only when explicitly directed." This is a different layer from commands invoking behavioral shifts: it's the agent being *constituted* with an identity, not just told what to do next. The architectural inversion this implies: instead of `/discuss` shifting away from an implementation-happy default, the default is collaborative and implementation commands (`/task`, `/pr`) are the explicit departures.

**Alignment as the purpose of documentation:** Human organizational alignment is ambient -- culture, osmosis, 1:1s. Agent alignment must be explicit and portable. Every subagent starts with zero context; alignment doesn't transfer automatically. This reframes dev-infra's documentation artifacts: narratives and explorations aren't just human-readable records -- they're **briefing documents** for agents. The constraints section ("Unique Value to Preserve") is an alignment artifact. A subagent given the narrative before doing work can make tradeoff decisions that align with the project's intent rather than optimizing locally. The *why* matters as much as the *what*, because agents given rules without rationale will follow the letter but not the spirit.

**The discussion agent as briefing writer:** When the discussion agent (this chat) holds the alignment context -- narratives, constraints, philosophical intent -- it becomes the natural source of task briefs for implementation subagents. It doesn't just orchestrate; it *transmits alignment* to workers who would otherwise start fresh. This is the project lead role: understand the whole, brief the parts.

**Connections:**
- Directly informs Theme 3 (conversion mechanics) -- the skill description isn't just a capability summary; it encodes the behavioral contract
- Relates to Theme 2 (auto-detection) -- behavioral contracts may be the clearest argument against auto-detection for certain roles (`/discuss` should never auto-trigger)
- Connects to Theme 7 (conversation orchestration) -- when dispatching subagents conversationally, explicit role assignments in task briefs improve output quality
- Connects to Theme 9 (AGENTS.md) -- the rules-level identity configuration needs a portable expression; AGENTS.md is the candidate

**Concerns:**
- Behavioral contracts are harder to test than functional ones -- how do you validate that an agent is "pushing back appropriately"?
- Role definitions could drift from actual behavior over time; they need to be grounded in real usage patterns
- Some roles have fuzzy boundaries (when does /explore become /research?)
- Configuring the agent's default as "collaborator" risks friction when the user needs to move fast -- the explicit mode-switch overhead may not always be worth the discipline gain

---

### Theme 9: AGENTS.md as Portable Identity Layer

Cursor's `.mdc` rules files are Cursor-specific. The agent identity configuration discussed in Theme 8 -- "collaborator by default, implementer on explicit command" -- only works in Cursor if expressed as `.mdc` rules. But `AGENTS.md` is emerging as a cross-platform convention: a markdown file at the repo root that is automatically included in agent context regardless of the tool (Cursor, Claude Code, OpenAI Codex, and others). It's the portable equivalent of always-applied rules.

The helm-charts repo's `AGENTS.md` illustrates what this looks like in practice today: entirely operational (structure, conventions, testing patterns, release process). It tells agents *what the repo is and how things are done* -- the conventions layer. What it lacks is the behavioral and directional layers that make agent work aligned rather than merely correct.

A layered `AGENTS.md` structure would address this gap:

- **Identity/Rules layer** -- behavioral defaults, the collaborator disposition, constraints on what the agent should never do. Points to a skill or states the behavioral contract inline. This is the portable equivalent of Cursor's always-applied behavioral rules.
- **Conventions layer** -- what the helm-charts file already has. Repo-specific, operational, how things are done.
- **Roadmap layer** -- directional context: what's in flight, what's planned, what's being explored. The alignment layer that enables tradeoff decisions without having to ask. *This may not need to be part of an initial implementation -- it's the most valuable but also the most expensive to maintain.*
- **Other** -- team context, ownership, escalation paths as needed.

The hub-and-spoke question applies here: does AGENTS.md contain all content inline (guaranteed to be read, harder to share across repos) or does it reference other files (more elegant, but depends on whether the agent follows the references)? This is an open empirical question -- platform behavior on file references in AGENTS.md needs testing.

The critical insight for dev-infra: if AGENTS.md carries the identity and conventions layers, and SKILL.md carries the procedural workflows, the `.mdc` rules files can be slimmed down to Cursor-specific concerns only (glob-based auto-attach, IDE-specific hints). The three-layer model becomes four: AGENTS.md (portable identity) + rules (Cursor-specific) + skills (portable procedural) + commands (simple triggers).

**Connections:**
- Directly enables Theme 8 (agent identity) -- AGENTS.md is the portable mechanism for expressing default behavioral disposition
- Relates to Theme 5 (cross-platform portability, Topic 5) -- AGENTS.md portability and file-reference behavior needs empirical testing
- Informs Theme 1 (redistribution) -- the sorting criteria changes if AGENTS.md is a first-class layer alongside rules/skills/commands
- Relates to Theme 6 (dual distribution) -- AGENTS.md ships with templates, not the marketplace; it's repo-local by nature

**Concerns:**
- AGENTS.md portability and platform support is not fully confirmed -- needs research to establish what tools actually read it and how consistently
- Hub-and-spoke AGENTS.md (with file references) may not work if platforms don't follow references; monolithic inline content is safer but harder to maintain
- A Roadmap layer in AGENTS.md would be high-value but high-maintenance; stale roadmap context may be worse than no roadmap
- Adding AGENTS.md as a fourth layer increases the total surface to maintain; only worth it if the portability gain is real

---

### Theme 10: The Discussion Session as Five-Stance Orchestration Layer

Theme 7 captured "conversation as lightweight orchestration" as an architectural pattern. A sharper realization emerged from using that pattern in practice: the discussion session doesn't just *enable* orchestration -- it *is* the orchestration layer. And it operates not as a pipeline phase but as a session that can occupy five distinct stances at any moment in the workflow:

1. **Discuss** -- Accumulating context, making judgments, thinking through implications. The session is building the shared understanding that makes delegation safe. No side effects.
2. **Materialize** -- Crystallizing conversation-only insights (preferences, nuances, unstated assumptions) into artifacts that cold-start subagents can consume. This is the interface preparation step. Without it, delegated work produces generic output that misses the context that only exists in the session.
3. **Delegate** -- Spinning subagents with specific artifacts as context and specific, bounded deliverables. The session hands off work while retaining judgment of the output.
4. **Review** -- Reading subagent output back into the parent conversation, challenging it, synthesizing it. The session reclaims judgment after delegation.
5. **Iterate** -- Amending artifacts, re-delegating, or advancing to decisions. The loop back.

These aren't sequential phases. The session can discuss → materialize → discuss again before delegating. It can review → loop back to discuss if the subagent output opened new questions. Materialize and discuss interleave until delegation is safe. The direction is a gradient, not a pipeline.

**The Hook Extension Model**

Hooks are how the conversation layer extends its reach into longer-running, lower-judgment work without requiring constant human attention. When the session has validated that a transition is mechanical -- no remaining judgment call -- it can define a hook: "when artifact X reaches state Y, trigger subagent Z." The hook executes without the session; the session re-engages when the hook returns output or hits an exception.

This is the automation layer built on top of conversational orchestration, not a replacement. The conversation decides *which* transitions are mechanical; the hooks execute them reliably. The session retains ownership of judgment; automation handles execution.

The hooks model is deliberately expensive to adopt early. A workflow needs several manual cycles through the conversation before it's possible to identify which transitions are truly mechanical and which still contain implicit judgment calls. Premature hooks automate decisions that should stay human.

**Artifacts as Formal Interface Contracts (Strongest Here)**

In conversational orchestration, artifacts are informal context -- the session covers for gaps in artifact quality through judgment and follow-up. In hook-based orchestration, the artifact is self-sufficient. The hook fires on a condition; the subagent starts cold; if the artifact is missing a field, there is no fallback. This is the context in which structural schemas (Theme 4/Topic 4) shift from quality improvement to correctness requirement. A schema-validated artifact is one a hook can depend on.

**The Name Question**

The command is called `/discuss`, and the name signals "thinking mode, not doing mode." That signal is valuable -- it shapes user behavior toward the read-only contract. But the session described here does substantially more than discuss: it accumulates the context subagents cannot replicate, navigates a five-stance orchestration cycle, decides when to materialize and when to delegate, and synthesizes delegated output back into project direction. Whether `/discuss` undersells this role -- or whether the name is precisely correct because it constrains expectations in the right direction -- is an open design question. The name is a behavioral contract as much as the skill description is.

**Connections:**
- Directly extends Theme 7 (conversation as orchestration) -- Theme 7 is the architectural pattern; Theme 10 is the operational model
- Relates to Theme 4 (structural schemas) -- schemas become correctness requirements in the hook-based model, not just quality improvements
- Connects to Theme 8 (behavioral contracts) -- the discussion session's behavioral contract is currently underspecified; Theme 10 identifies what's missing (the five stances, orchestration awareness)
- Connects to Theme 3 (conversion mechanics) -- the `/discuss` command conversion is incomplete; the skill needs the orchestration awareness layer
- Raises Theme 9 (AGENTS.md) consideration -- a session-init meta-skill (Option B) that injects the five-stance model into every conversation is distinct from a per-skill `/discuss` approach

**Concerns:**
- The hooks model is expensive early: premature automation of judgment calls is a documented failure pattern in agentic systems
- The five-stance model may add friction if encoded too rigidly; the value is in the mental model, not in formalizing every transition
- Option B (session-init meta-skill) is more powerful but has no tested implementation in dev-infra's context
- A name change for `/discuss` would be a breaking behavioral contract change -- users have built habits around the current name and expectations

---

## ❓ Key Questions

1. **How should rules and commands redistribute across the three-layer model?** What's the sorting criteria for rules content (always-on vs on-demand) and command content (command vs skill)?

2. **Should dev-infra adopt auto-detection, stay explicit, or go hybrid?** This gates the redistribution criteria. How do you get the discipline benefits of auto-enforcement without the premature formalization problem?

3. **What does a command-to-skill conversion look like in practice?** File format, directory structure, reference materials, 500-line limit, detection descriptions, testing, template sync.

4. **Can templates serve as structural schemas for agent-validated artifacts?** What does a template-as-schema look like? How do agents reference and validate against it? What's the overhead vs the consistency gain?

5. **What do subagent integration and pipeline orchestration look like?** Can `/task` delegate to subagents? Can tracker state enable automated pipeline handoff? Where are the human checkpoints?

6. **How should dev-infra manage dual distribution (templates + marketplace)?** What's the workflow for developing a skill locally, testing in Cursor, and publishing to the Claude marketplace? Which skills are team-appropriate vs personal-only? How does sync work between the two channels?

7. **Can the conversation itself serve as the orchestration layer?** What are the practical limits of dispatching subagents conversationally? What context hand-off discipline is required? When does this break down and require formal orchestration?

8. **How do agent identity and behavioral contracts translate into portable configuration?** Can the default disposition ("collaborator by default") be configured at the rules/AGENTS.md level? How do behavioral contracts in SKILL.md descriptions hold across platforms and sessions?

9. **Is AGENTS.md a reliable portable equivalent of Cursor's always-applied rules?** Which tools actually read it, and how consistently? Does it support hub-and-spoke references or must it be self-contained? What belongs in AGENTS.md vs `.mdc` rules vs SKILL.md?

10. **Does the Roadmap layer in AGENTS.md belong in v0.11.0?** What's the minimum viable roadmap section -- enough to enable agent alignment without becoming a maintenance burden?

11. **Does the `/discuss` skill need a second behavioral contract layer -- orchestration awareness?** The current contract (read-only, no side effects, engage critically) is the defensive layer. The five-stance model (discuss/materialize/delegate/review/iterate) is the affirmative layer: the skill should help the user navigate when to materialize and when to delegate, not just refrain from acting. And should the command still be called `/discuss`, or does the name now undersell its role as the judgment/orchestration layer of the entire workflow?

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| Three-layer redistribution | MEDIUM | No | Can be evaluated through analysis of existing rules/commands content |
| Auto-detection vs explicit | MEDIUM | No | Design decision informed by research into both models |
| Command-to-skill conversion | MEDIUM-HIGH | **Yes** | Converting one command (e.g., `/explore`) to a skill and testing auto-detection would validate the approach |
| Templates as structural schemas | MEDIUM-HIGH | Consider | Prototyping a schema for one artifact type (exploration) would reveal feasibility |
| Subagent-per-task delegation | HIGH | **Yes** | Subagent behavior (context limitations, coordination) can only be evaluated through runtime experimentation |
| Pipeline orchestration | HIGH | **Yes** | Too many unknowns in failure modes and agent coordination; depends on subagent spike results |
| Dual distribution workflow | LOW | No | The marketplace format is known; the workflow is a design question, not a technical risk |
| Conversation-as-orchestration | MEDIUM-HIGH | **Yes** | Practical limits (context hand-off, parallel subagent output management) can only be discovered through experimentation |
| Behavioral contracts in skill descriptions | MEDIUM | No | Design question; can be evaluated by drafting one skill description and comparing platform behavior |
| Discussion session as orchestration layer (five stances + hooks) | MEDIUM-HIGH | Consider | The five-stance model needs validation against real workflow cycles; hooks model requires empirical test to identify mechanical vs judgment transitions |
| AGENTS.md portability and platform support | MEDIUM-HIGH | **Yes** | Whether platforms follow file references and behave consistently can only be confirmed empirically |

**Spike Candidates (ordered by dependency):**
1. Command-to-skill conversion -- `/spike command-to-skill-migration` (unblocks Themes 1 and 3)
2. Conversation-as-orchestration -- `/spike conversation-orchestration` (unblocks Theme 7; run research topics as parallel subagents as the spike itself)
3. Subagent-per-task delegation -- `/spike subagent-task-delegation` (unblocks Theme 5)
4. Pipeline orchestration -- `/spike pipeline-orchestrator` (depends on #3)

---

## 🚀 Next Steps

1. Resolve issue #72 (explore refactor) as a prerequisite -- it changes the shape of the explore workflow that would be a spike target
2. Spike command-to-skill conversion using one representative command
3. Research auto-detection vs explicit invocation (Topic 1) -- this is the gating design decision
4. Research three-layer redistribution (Topic 2) once the auto-detection decision is made
5. Run research topics as parallel subagents -- this is itself the conversation-orchestration spike (Topic 7)
6. Spike subagent delegation and pipeline orchestration as a later workstream

---

**Last Updated:** 2026-03-25 (Amended: Theme 10 + Question 11 added)
