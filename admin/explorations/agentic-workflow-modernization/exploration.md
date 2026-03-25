# Exploration: Agentic Workflow Modernization

**Status:** 🟠 In Progress
**Created:** 2026-03-25

---

## 🎯 What We're Exploring

Dev-infra has 26+ Cursor commands, 3 always-applied `.mdc` rule files, and no user-created skills. The Cursor ecosystem has since formalized a three-layer model (rules guide, skills do, commands trigger), and third-party systems like Superpowers have emerged with opinionated workflow enforcement. This exploration maps the territory: where dev-infra's existing system aligns with, diverges from, or exceeds these patterns -- and what a modernization path looks like.

The core tension: dev-infra's command system was built before skills existed. Some commands are behavioral guidance (better as rules or skills), some are procedural workflows (natural skills), and some are genuinely trigger-style commands. The rules files carry significant always-on context cost. The question is how to decompose and redistribute across the three layers without losing the sophistication that's already there.

---

## 🔍 Themes

### Theme 1: Rules Decomposition and Context Efficiency

The three `.mdc` files (`main.mdc`, `workflow.mdc`, `template.mdc`) load into every conversation regardless of task relevance. They contain a mix of:

- **Passive behavioral guidance** (project identity, branching strategy, commit format, documentation standards) -- genuinely belongs in always-on rules
- **Procedural knowledge** (release process, PR review workflow, TDD patterns, template validation steps) -- better suited to on-demand loading via skills
- **Current project state** (version, completed features, in-progress work) -- arguably belongs in rules but could be auto-generated

The skills model offers progressive disclosure: agent sees name + description, loads full content only when relevant. This directly addresses the context overhead problem. But the decomposition isn't trivial -- some procedural knowledge is tightly coupled to behavioral guidance (e.g., "always follow Git Flow" is a rule, but the detailed branching strategy is procedural).

**Connections:**
- Relates to Theme 3 (Superpowers comparison) -- Superpowers' skills also use progressive loading
- Relates to Theme 5 (what stays as commands) -- decomposition affects what's left

**Concerns:**
- Risk of over-decomposing: too many small skills could be harder to maintain than a few comprehensive rules
- Discovery problem: if the agent doesn't load a skill when it should, the workflow breaks silently
- Migration complexity: rules have been refined over months; splitting them risks losing nuance

---

### Theme 2: Commands-to-Skills Migration Path

Dev-infra's 26+ commands span a wide spectrum of complexity:

- **Simple triggers** (`/commit`, `/review`) -- appropriate as commands
- **Moderate workflows** (`/fix-plan`, `/fix-implement`, `/pr`) -- could be either commands or skills
- **Complex procedural workflows** (`/explore`, `/research`, `/task`, `/transition-plan`) -- natural candidates for skills with progressive disclosure and auto-detection

The skills model adds two capabilities commands don't have: (1) agent auto-detection based on context, and (2) progressive loading of reference materials. Both are relevant for the complex workflows. A `/task` skill could be detected when the agent sees implementation plan files; an `/explore` skill could activate when the agent detects unstructured thoughts.

The agentskills.io standard also makes skills cross-platform (Claude Code, Codex, Gemini CLI). Commands are Cursor-specific. If dev-infra templates are meant to be tool-agnostic, skills are the more portable format.

**Connections:**
- Relates to Theme 1 (rules decomposition) -- some rule content may become skill reference material
- Relates to Theme 4 (what dev-infra has that the ecosystem doesn't)
- Issue #72 is relevant here -- if `/explore --conduct` is removed, the explore workflow changes what a skill version would look like

**Concerns:**
- Commands and skills share the `/` menu in Cursor, but the invocation semantics differ
- Auto-detection could trigger workflows the user didn't intend (the `/discuss` insight: conflating thinking with doing)
- Not all 26 commands need migration -- the question is which ones benefit most from the skills model

---

### Theme 3: Superpowers Overlap and Differentiation

Superpowers implements a seven-phase opinionated workflow (brainstorming → worktrees → planning → subagents → TDD → review → branch finishing). Dev-infra independently arrived at most of these patterns:

| Superpowers Phase | Dev-Infra Equivalent | Dev-Infra Advantage |
|-------------------|---------------------|---------------------|
| Brainstorming | `/explore`, `/discuss` | Separates read-only thinking from artifact creation |
| Git worktrees | Worktree workflow | Integrated with draft PR flow |
| Planning | `/plan-review`, `/transition-plan`, `/task` | More granular, feature-plan-aware |
| Subagent-driven dev | (no equivalent) | — |
| TDD | `/task` (built-in TDD) | Integrated with task tracking |
| Code review | `/review` + `/commit` | Explicit human pause, two-step |
| Branch finishing | `/post-pr`, `/pr --ready` | Draft PR integration |

The key philosophical difference: Superpowers enforces workflow automatically via skills that trigger without user invocation. Dev-infra's system is modular and explicitly invoked. There's a case for both approaches, and potentially a hybrid.

Superpowers' "subagent-driven development" (fresh context per task) is the one area with no dev-infra equivalent. Cursor's native Task tool now supports this pattern. This may be a genuine gap.

**Connections:**
- Relates to Theme 2 (migration path) -- adopting the auto-detection model partially closes the gap with Superpowers
- Relates to Theme 5 (what stays as commands) -- some enforcement could become automatic

**Concerns:**
- Adopting Superpowers wholesale would mean replacing a highly customized system with an opinionated one
- Superpowers is third-party and may evolve in directions that don't align with dev-infra's goals
- Auto-enforcement risks the same problem `/discuss` was created to solve: premature formalization

---

### Theme 4: Unique Value to Preserve

Several dev-infra patterns have no equivalent in the broader ecosystem and should be explicitly preserved in any modernization:

- **`/discuss` (read-only discussion mode)** -- The insight that agentic coding conflates thinking with doing is genuinely novel. No workflow system, including Superpowers, formalizes this distinction.
- **Granular exploration pipeline** -- `/explore` → `/research` → `/decision` → `/transition-plan` is richer than any single "brainstorming" phase. The toolbox model from issue #72 makes this even stronger.
- **Review-then-commit two-step** -- The explicit human pause between AI changes and committing is more disciplined than automatic review.
- **Hub-and-spoke documentation** -- Feature planning, status tracking, and documentation-driven development have no ecosystem equivalent.
- **Separation of exploration modes** -- Setup vs amend (post issue #72) preserves the mapping-vs-investigating distinction.

These aren't just "nice to haves" -- they represent hard-won process insights. A modernization that loses them would be a regression.

**Connections:**
- Relates to Theme 2 (migration path) -- these should be preserved as skills or commands, not dissolved
- Relates to Theme 3 (Superpowers) -- these are differentiators, not gaps

**Concerns:**
- Portability: if these stay as Cursor commands, they don't travel to other platforms
- Maintenance burden: 26+ commands is significant to maintain across two templates and dev-infra itself

---

### Theme 5: What Stays as Commands

Not everything should migrate. The rules/skills/commands taxonomy suggests:

- **Rules** -- Passive behavioral guidance (project identity, standards, conventions)
- **Skills** -- Procedural multi-step workflows with reference materials (explore, research, task)
- **Commands** -- Simple triggers the user explicitly invokes (`/commit`, `/review`, `/status`)

Some commands are genuinely just saved prompts. `/commit` reads a draft message and commits. `/status` reports project state. These don't benefit from auto-detection or progressive disclosure. They should remain commands.

The interesting middle ground: commands like `/pr` and `/fix-plan` that are moderate complexity. They're multi-step but not heavy enough to justify skill infrastructure. The threshold question is: would this benefit from auto-detection or reference materials?

**Connections:**
- Relates to Theme 2 (migration path) -- this is the sorting criteria
- Relates to Theme 1 (rules decomposition) -- rules + skills + commands should cover everything currently in rules + commands

**Concerns:**
- The `/` menu mixing skills and commands could be confusing if some `/` items are skills and some are commands
- Maintaining both skills and commands for the same workflows during migration creates duplication

---

### Theme 6: Subagent Integration

Cursor's native Task tool spins up isolated subagents with fresh context. Superpowers uses this as "subagent-driven development" -- one task per subagent, each reviewed against the plan.

Dev-infra's `/task` command currently runs everything in a single conversation context. For larger features with many tasks, this means context accumulates and degrades. Subagent-per-task could:

- Give each task a clean context window
- Allow parallel task execution
- Enforce task isolation (one task can't accidentally affect another)
- Improve review quality (each task is self-contained)

This is potentially the highest-impact gap between dev-infra's current system and the ecosystem.

**Connections:**
- Relates to Theme 3 (Superpowers) -- this is Superpowers' most novel contribution
- Relates to Theme 2 (migration path) -- a skills-based `/task` could integrate subagent delegation

**Concerns:**
- Subagent context is limited -- no access to conversation history or user messages
- Coordination between subagents requires careful task specification
- Not all tasks benefit from isolation; some need prior context

---

## ❓ Key Questions

1. **Which rules content should decompose into skills vs. stay as always-on rules?** What's the sorting criteria, and how do we handle content that straddles the boundary?

2. **Which of the 26 commands benefit most from skills migration?** Need to assess each against: auto-detection value, progressive disclosure value, cross-platform portability value, and migration cost.

3. **Should dev-infra adopt any Superpowers concepts directly, or just draw inspiration?** Specifically: should auto-enforcement (skills triggering without user invocation) be part of the model, or does explicit invocation remain a design principle?

4. **How does issue #72's toolbox model affect the skills architecture?** If explore loses `--conduct`, the explore skill becomes simpler. Does the toolbox model (explore maps, research/spike investigate) map cleanly to a skills-based architecture?

5. **What does subagent integration look like for `/task`?** Can the task workflow delegate individual implementation tasks to subagents while maintaining plan awareness?

6. **What's the migration strategy?** All-at-once vs. incremental? Which commands first? How to maintain backward compatibility during transition?

7. **How does cross-platform portability factor in?** Is dev-infra committed to Cursor, or should the workflow system work across Claude Code, Codex, and other tools?

8. **What's the maintenance cost delta?** 26 commands + 3 rules vs. N skills + leaner rules + fewer commands. Is the total maintenance burden better or worse?

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| Rules → skills decomposition | MEDIUM | No | Can be evaluated through analysis, not runtime behavior |
| Command → skill migration (single command) | MEDIUM-HIGH | Consider | Converting one command (e.g., `/explore`) to a skill and testing auto-detection behavior would validate the approach |
| Superpowers installation & evaluation | MEDIUM | Consider | Installing Superpowers in a test project and observing its behavior firsthand would inform the comparison |
| Subagent-per-task delegation | HIGH | **Yes** | Subagent behavior (context limitations, coordination) can only be evaluated through runtime experimentation |
| Cross-platform skill portability | MEDIUM | Consider | Testing a skill in Claude Code vs Cursor would reveal portability gaps |

**Risk Assessment:**

| Risk Level | Determination | Rationale |
|------------|---------------|-----------|
| HIGH | **Spike first** | Hard to pivot once committed |
| MEDIUM-HIGH | **Consider spike** | Benefits from hands-on validation |
| MEDIUM | Research only | Can be analyzed from documentation |
| LOW | Research only | Clear path, low risk |

**Spike Candidates:**
- Subagent-per-task delegation -- `/spike subagent-task-delegation`
- Single command-to-skill migration -- `/spike command-to-skill-migration`

---

## 🚀 Next Steps

1. If spike candidates warrant it, run `/spike subagent-task-delegation` to test Cursor's Task tool for task-level delegation
2. Review research topics in `research-topics.md`
3. Use `/research agentic-workflow-modernization --from-explore` to investigate individual topics
4. Address issue #72 changes to `/explore` as a parallel or prerequisite workstream

---

**Last Updated:** 2026-03-25
