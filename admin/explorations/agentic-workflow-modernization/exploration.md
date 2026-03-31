# Exploration: Agentic Workflow Modernization

**Status:** 🟠 In Progress
**Created:** 2026-03-25
**Amended:** 2026-03-25 - Added themes from /discuss session (templates as structural schemas, orchestration and tracker state)
**Restructured:** 2026-03-25 - Merged overlapping themes, added constraints section, reordered by dependency, added conversion mechanics theme
**Amended:** 2026-03-25 - Added Theme 6 (dual-distribution model), updated Themes 2-3 and reference section with marketplace findings

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

Superpowers (marketed as "Hex" in the DRW UP Claude Marketplace) implements a seven-phase opinionated workflow (brainstorming → worktrees → planning → subagents → TDD → review → branch finishing). **Hex is already deployed in the team marketplace** (v2.1.0) alongside dev-infra's commands. Dev-infra independently arrived at most of these patterns:

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

**Key finding from /discuss:** The format gap is smaller than expected. A real-world skill has been built (`update-pr-description` in the DRW UP Claude Marketplace), confirming the format is understood. The same SKILL.md works in both Cursor (`.cursor/skills/`) and Claude Code (`.agents/skills/`). The skill directory structure naturally accommodates reference materials, templates, and configs -- meaning dev-infra's doc templates can live *inside* the skill as structural schemas.

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

1. **Team (work):** The DRW UP Claude Marketplace is the distribution channel for Claude Code skills. The team already uses this marketplace (Hex, daily-summary, deploy-app-to-k8s, review-briefing, etc.). Publishing dev-infra's workflow skills here makes them accessible to teammates who use Claude Code as their primary agent. The marketplace provides versioning, metadata (`plugin.json`), install mechanisms, and discovery.

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

## ❓ Key Questions

1. **How should rules and commands redistribute across the three-layer model?** What's the sorting criteria for rules content (always-on vs on-demand) and command content (command vs skill)?

2. **Should dev-infra adopt auto-detection, stay explicit, or go hybrid?** This gates the redistribution criteria. How do you get the discipline benefits of auto-enforcement without the premature formalization problem?

3. **What does a command-to-skill conversion look like in practice?** File format, directory structure, reference materials, 500-line limit, detection descriptions, testing, template sync.

4. **Can templates serve as structural schemas for agent-validated artifacts?** What does a template-as-schema look like? How do agents reference and validate against it? What's the overhead vs the consistency gain?

5. **What do subagent integration and pipeline orchestration look like?** Can `/task` delegate to subagents? Can tracker state enable automated pipeline handoff? Where are the human checkpoints?

6. **How should dev-infra manage dual distribution (templates + marketplace)?** What's the workflow for developing a skill locally, testing in Cursor, and publishing to the Claude marketplace? Which skills are team-appropriate vs personal-only? How does sync work between the two channels?

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

**Spike Candidates (ordered by dependency):**
1. Command-to-skill conversion -- `/spike command-to-skill-migration` (unblocks Theme 1 and 3)
2. Subagent-per-task delegation -- `/spike subagent-task-delegation` (unblocks Theme 5)
3. Pipeline orchestration -- `/spike pipeline-orchestrator` (depends on #2)

---

## 🚀 Next Steps

1. Resolve issue #72 (explore refactor) as a prerequisite -- it changes the shape of the explore workflow that would be a spike target
2. Spike command-to-skill conversion using one representative command
3. Research auto-detection vs explicit invocation (Topic 2) -- this is the gating design decision
4. Research three-layer redistribution (Topic 1) once the auto-detection decision is made
5. Spike subagent delegation and orchestration as a later workstream

---

**Last Updated:** 2026-03-25
