# Research: Auto-Detection vs Explicit Invocation

**Research Topic:** Agentic Workflow Modernization
**Question:** Should dev-infra's workflow model adopt auto-detection (agent decides when to invoke workflows), stay fully explicit, or go hybrid?
**Status:** ✅ Complete
**Priority:** High (GATE -- all other decisions depend on this)
**Created:** 2026-03-25
**Completed:** 2026-03-25

---

## 🎯 Research Question

Should dev-infra adopt auto-detection (agent automatically invokes skills when context suggests it), stay fully explicit (user always invokes), or go hybrid (per-skill opt-in/out)?

This is the gating decision: the redistribution rubric (Topic 2) and skill description design (Topic 8) both depend on which model is chosen.

---

## 🔍 Research Goals

- [x] Understand `disable-model-invocation: true` behavior: does it fully suppress auto-detection on both Cursor and Claude Code?
- [x] Review Hex/Superpowers' auto-detection patterns: what triggers automatic workflow invocation, and what are the failure modes?
- [x] Define criteria for when auto-detection is appropriate vs harmful for dev-infra's specific commands
- [x] Evaluate the hybrid model: per-skill opt-in/out without a global architecture decision
- [x] Assess whether Cursor's Ask mode and Claude Code's existing modes provide sufficient read-only behavior to replace `/discuss`

---

## 📚 Research Methodology

**Sources consulted:**
- [x] Cursor official docs: [Agent Skills](https://cursor.com/docs/skills) -- frontmatter field reference, invocation behavior
- [x] AgentThinking.ai: [How Cursor Finds Skills](https://agenticthinking.ai/blog/skill-discovery/) -- discovery mechanics
- [x] Paddo.dev: [Claude Skills: The Controllability Problem](https://paddo.dev/blog/claude-skills-controllability-problem/) -- failure modes, auto vs explicit analysis
- [x] AgentPatterns.ai: [SKILL.md Frontmatter Reference](https://agentpatterns.ai/tool-engineering/skill-frontmatter-reference/) -- all frontmatter fields
- [x] Web search: Superpowers auto-detection triggers, session hook patterns
- [x] Cursor Forum: [disable-model-invocation bug report](https://forum.cursor.com/t/disable-model-invocation-true-completely-hides-plugin-delivered-skills-from-command-palette/155748) -- known bug for marketplace-delivered skills
- [x] DAPLab: [9 Critical Failure Patterns of Coding Agents](https://daplab.cs.columbia.edu/general/2026/01/08/9-critical-failure-patterns-of-coding-agents.html) -- broader auto-detection failures

---

## 📊 Findings

### Finding 1: `disable-model-invocation: true` Works for Repo Skills, Broken for Marketplace Plugins

Cursor's official documentation confirms: `disable-model-invocation: true` in SKILL.md frontmatter makes the skill available **only** when explicitly invoked via `/skill-name`. The agent will not automatically apply it based on context. This works correctly for project-level skills stored in `.cursor/skills/` or `.agents/skills/`.

**However, there is a known active bug:** for skills delivered through Cursor marketplace plugins, setting `disable-model-invocation: true` completely hides the skill from the `/` command palette, making it unable to be invoked at all -- neither automatically nor manually. The bug has been reported (forum post, March 2026) and is unresolved as of research date.

**Source:** [Cursor Docs: Agent Skills](https://cursor.com/docs/skills); [Cursor Forum bug report](https://forum.cursor.com/t/disable-model-invocation-true-completely-hides-plugin-delivered-skills-from-command-palette/155748)

**Relevance:** Dev-infra's distribution model uses templates (`.agents/skills/`) for local distribution, not marketplace plugins. This means `disable-model-invocation: true` works reliably for dev-infra's primary distribution channel. However, the bug has direct implications for the dual-distribution model (Topic 6): marketplace distribution of behavioral skills like `/discuss` would break invocation entirely.

---

### Finding 2: Two Frontmatter Flags for Invocation Control

The SKILL.md standard supports two distinct invocation control flags:

| Flag | Effect |
|------|--------|
| `disable-model-invocation: true` | Skill is only included when explicitly invoked via `/skill-name`. Agent does not auto-apply. |
| `user-invocable: false` | Skill is automatic-only -- intended for background knowledge that loads silently, never for explicit invocation. |

The asymmetry matters: `disable-model-invocation` is the flag for **procedural and behavioral skills that should be user-triggered**. `user-invocable: false` is for passive reference material (e.g., domain conventions that load automatically when relevant).

**Source:** [AgentPatterns.ai: SKILL.md Frontmatter Reference](https://agentpatterns.ai/tool-engineering/skill-frontmatter-reference/)

**Relevance:** Dev-infra's commands naturally split into these two categories. `/discuss`, `/review`, `/commit`, `/pr` are user-triggered workflows. Passive conventions (code style, branch naming) could theoretically be `user-invocable: false` background knowledge. This is exactly the hybrid model.

---

### Finding 3: Auto-Invocation Is Non-Deterministic and Breaks Context Engineering

Auto-invocation uses LLM semantic reasoning to decide whether a skill is relevant -- not algorithmic matching. This creates three failure modes:

1. **Can't force-invoke**: When you need a skill but the model doesn't match it to your request, it silently doesn't load.
2. **Can't prevent invocation**: When you're doing something adjacent to a skill's domain, the model may load it unexpectedly, consuming tokens and polluting the context window.
3. **Silent token overflow**: If the skill description token budget overflows (many skills loaded), descriptions are silently truncated before the model reads them, causing skills to never trigger -- with no error messages.

The broader implication: "Context engineering means controlling what competes for the model's attention. Auto-invoked skills break that discipline."

**Source:** [Paddo.dev: Claude Skills: The Controllability Problem](https://paddo.dev/blog/claude-skills-controllability-problem/)

**Relevance:** Dev-infra's commands are intentionally invoked. The user types `/review` or `/pr` because they want that workflow now. Auto-detection undermines this: the agent might try to run `/pr` logic when the user is simply asking a question about git branching, or might miss invoking `/review` when code changes are ready. For structured, named workflows, explicit is safer.

---

### Finding 4: Superpowers Uses a Session Hook to Force Explicit Workflow Loading

Superpowers does not rely on passive skill semantic matching. Instead, it injects a **mandatory session start hook** that loads a core routing skill into every new conversation. This routing skill explicitly teaches the agent to check for relevant workflow skills before acting -- making the "check" itself explicit rather than relying on ambient inference.

The seven-phase workflow (Brainstorming → Design → TDD → Debugging → Review...) is enforced as **hard gates** -- each stage is a required checkpoint, not an auto-triggered suggestion. This is closer to explicit invocation at the workflow level, even though the surface API doesn't require the user to type `/brainstorm`.

**Source:** Web search, Superpowers documentation

**Relevance:** Superpowers' session hook is a viable middle path: instead of per-skill auto-detection, a single "meta-skill" is always loaded and routes to other skills explicitly. This is the orchestration layer approach. For dev-infra, this could mean a single always-loaded routing rule rather than auto-detection on every individual skill.

---

### Finding 5: Claude Code 2.1 Converged on Explicit-First as the Default

Claude Code 2.1 merged skills with slash commands. Skills now appear in the slash command menu by default, making explicit `/skill-name` invocation the default while preserving optional automatic activation. This represents Claude Code's resolution to the controllability problem: **explicit is the default; auto-detect is opt-in**.

This convergence is significant: the two platforms (Cursor + Claude Code) are landing on the same model independently -- explicit invocation as the safe default, auto-detection only for background/ambient knowledge.

**Source:** [Paddo.dev: Claude Skills: The Controllability Problem](https://paddo.dev/blog/claude-skills-controllability-problem/) (January 2026 update note)

**Relevance:** Dev-infra's decision to go hybrid/explicit is aligned with where both platforms are heading. This is not a contrarian choice -- it reflects the industry consensus emerging in early 2026.

---

### Finding 6: Auto-Detection Is Legitimate for Domain-Specific Background Knowledge in Large Codebases

Auto-detection does have a legitimate use case: large codebases (~1M LOC monorepos) with many domain-specific patterns that would bloat CLAUDE.md if added inline. Skills load ~50 tokens of metadata initially; full instructions load only when relevance is matched. For patterns that are relevant only in certain directories or contexts, auto-detection provides progressive disclosure without bloating always-on context.

The key distinction: this use case is for **background knowledge** (e.g., "when in the payments/ directory, load the PCI compliance conventions skill"), not for **user-triggered workflows** (e.g., "when the user is done with changes, run the PR creation workflow").

**Source:** [Paddo.dev: Claude Skills: The Controllability Problem](https://paddo.dev/blog/claude-skills-controllability-problem/)

**Relevance:** Dev-infra's skills are primarily workflow-oriented, not domain background knowledge. The auto-detect use case doesn't apply to most of dev-infra's command set. However, passive conventions files (code style, naming conventions, hub-and-spoke pattern) *could* legitimately be auto-detected background knowledge -- if they are extracted from `.mdc` rules and reformatted as `user-invocable: false` skills.

---

### Finding 7: Broader Agentic Failure Modes Include Auto-Invocation Rule Compliance Gaps

Research across 500+ autonomous sessions identifies that agents consistently fail to apply auto-invocation rules even when those rules are explicitly present in context. Agents can cite the rules verbatim after violations, demonstrating the rules loaded -- but didn't apply during execution. This "disconnect between context loading and context application" is a systemic failure mode of ambient/auto-detection architectures.

**Source:** [DAPLab: 9 Critical Failure Patterns of Coding Agents](https://daplab.cs.columbia.edu/general/2026/01/08/9-critical-failure-patterns-of-coding-agents.html); [Claude Code GitHub Issue #31203](https://github.com/anthropics/claude-code/issues/31203)

**Relevance:** Even if dev-infra tried auto-detection for workflows, the empirical record shows it doesn't hold reliably. The model loads the rule but doesn't guarantee applying it at the right moment. For critical workflows (PR creation, review, commit), this gap is unacceptable.

---

## 🔍 Analysis

The research converges on a clear answer: **dev-infra should use the hybrid model, with explicit invocation as the default and auto-detection only for passive background knowledge.**

The five forces driving this conclusion:

1. **Platform convergence:** Both Cursor and Claude Code 2.1 landed on explicit-first independently. Following this is aligning with the ecosystem, not swimming against it.

2. **`disable-model-invocation` works for repo-level distribution:** The flag is reliable for `.agents/skills/` delivery (dev-infra's primary distribution path). The marketplace bug doesn't affect template-distributed skills.

3. **Dev-infra's commands are workflow-triggered, not ambient:** `/review`, `/pr`, `/explore`, `/discuss` are actions the user decides to take. They are not passive background knowledge. Auto-detection would misfire on adjacent context.

4. **Empirical failure rate:** Context-loading-to-context-application gaps make auto-detection unreliable for critical workflows. The user knowing when to invoke is more reliable than the model guessing.

5. **The hybrid model is the design space:** The two flags (`disable-model-invocation` for explicit, `user-invocable: false` for auto) already encode the hybrid model. Dev-infra can adopt them per-skill without a global architecture decision.

**The one legitimate auto-detect case:** Passive conventions (code style, documentation patterns, hub-and-spoke rules) extracted from `.mdc` rules could be `user-invocable: false` background knowledge skills. This keeps the always-on rule files lean while still surfacing conventions when relevant.

**Key Insights:**
- [x] Insight: The hybrid model is the industry consensus in 2026 -- explicit for workflows, auto-detect for background knowledge. Dev-infra should adopt both flags with clear criteria for each.
- [x] Insight: `disable-model-invocation: true` is safe for repo-distributed skills but has a known marketplace bug. The dual-distribution model (Topic 6) needs to account for this: behavioral skills must not be marketplace-distributed until the bug is fixed.
- [x] Insight: The `/discuss` skill's `disable-model-invocation: true` is not just a stylistic choice -- it's a hard requirement. Auto-detecting read-only discussion mode would fire at wrong moments and break the discuss contract entirely.
- [x] Insight: Superpowers' session hook approach (a meta-skill that routes to other skills) is worth investigating as an alternative to per-skill auto-detection for pipeline workflows.

---

## 💡 Recommendations

- [x] **Adopt the hybrid model:** Use `disable-model-invocation: true` for all user-triggered workflow skills (the majority of dev-infra's command set). Reserve auto-detection for passive background knowledge only.

- [x] **Criteria for auto-detect eligibility:**
  1. The skill is read-only background knowledge (conventions, patterns, standards)
  2. Loading it uninvited does not initiate side effects (no file creation, no git operations)
  3. It is genuinely domain-scoped (relevant only in certain directories or file types)
  4. It is not a workflow a user would want to invoke on-demand
  If all four are true: auto-detect (`user-invocable: false`). Otherwise: explicit (`disable-model-invocation: true`).

- [x] **Do not marketplace-distribute behavioral skills until the bug is fixed:** The `disable-model-invocation` marketplace bug means any behavioral skill (like `/discuss`) distributed via marketplace plugin would be completely invisible. Repo/template distribution is the safe path.

- [x] **Use Cursor Ask mode only as a session-level alternative, not a replacement for `/discuss`:** Ask mode is Cursor-specific and requires a mode switch -- it doesn't carry the behavioral contract (pushback, no formalization) that `/discuss` encodes. The skill is still the portable, inline-invocable option.

---

## 📋 Requirements Discovered

- [x] **FR-4:** All user-triggered workflow skills must set `disable-model-invocation: true`. Auto-detection is prohibited for skills that initiate side effects (file writes, git operations, subagent dispatch).
  **Priority:** High

- [x] **FR-5:** Passive background knowledge extracted from always-on rules may use `user-invocable: false` for auto-detected loading. Must meet all four auto-detect eligibility criteria (read-only, no side effects, domain-scoped, not on-demand).
  **Priority:** Medium

- [x] **C-3:** Marketplace distribution of skills with `disable-model-invocation: true` is blocked by a known Cursor bug (March 2026, unresolved). Skills requiring this flag must be distributed via repo/template path only until the bug is resolved.
  **Priority:** High (constraint on dual-distribution model, Topic 6)

---

## 🚀 Next Steps

1. Feed findings into Topic 2 (redistribution rubric): the criteria table above (four auto-detect eligibility criteria) is the sorting key for the rules → skills redistribution
2. Feed C-3 constraint into Topic 6 (dual-distribution): marketplace distribution path has a known blocker for explicit-only skills
3. The hybrid model recommendation settles the gating question for all other topics

---

**Last Updated:** 2026-03-25
