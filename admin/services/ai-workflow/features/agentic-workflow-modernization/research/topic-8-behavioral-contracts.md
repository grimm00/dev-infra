# Research: Behavioral Contracts in Skill Descriptions

**Research Topic:** Agentic Workflow Modernization
**Question:** What makes a skill description a reliable behavioral contract vs a vague instruction?
**Status:** ✅ Complete
**Priority:** Medium
**Created:** 2026-03-25
**Completed:** 2026-04-10

---

## 🎯 Research Question

The `/discuss` skill conversion surfaced a precision problem: vague persona instructions ("play devil's advocate") are inherited and left underspecified. What makes a behavioral skill description one that holds across sessions, agents, and platforms?

**Pre-answered by Spike B (partial):** The phrase "play devil's advocate" was identified as problematic -- it implies contrarianism as a role. Better instruction: prioritize intellectual honesty and name genuine concerns specifically without manufacturing disagreement. The full research question is: how general is this finding?

---

## 🔍 Research Goals

- [x] Survey existing behavioral instructions across dev-infra commands for precision gaps (same type as "play devil's advocate")
- [x] Research what makes AI behavioral instructions reliable: specificity, role-framing, anti-patterns, examples
- [x] Develop a behavioral contract quality rubric: what properties must a behavioral skill description have?
- [x] Test whether the `/discuss` SKILL.md's refined instruction is demonstrably better than the original
- [x] Determine if the behavioral contract belongs in the skill description (frontmatter) vs the skill body

---

## 📚 Research Methodology

**Context already established:**
- Spike B identified the "play devil's advocate" precision issue
- Better instruction: "Prioritize intellectual honesty over agreeableness: if you see a logical gap, an unstated assumption, or an argument that doesn't hold -- name it specifically. Don't manufacture disagreement, but don't suppress genuine concerns."
- This finding is recorded in `spike-learnings.md`
- The discuss skill draft is at `spike/discuss-skill/SKILL.md`

**Sources consulted:**

- [x] Audited all 31 dev-infra command files for behavioral instruction patterns
- [x] Reviewed spike discuss skill draft (`spike/discuss-skill/SKILL.md`)
- [x] Reviewed Hex plugin skills (14 SKILL.md files at `~/.claude/plugins/cache/.../hex/2.1.0/skills/`)
- [x] Reviewed Superpowers plugin skills (14 SKILL.md files at `~/.claude/plugins/cache/.../superpowers/5.0.7/skills/`)
- [x] Web search: AI agent behavioral instructions best practices, precision prompting (2026)
- [x] Web search: Behavioral contract anti-patterns, persona vs outcome instructions
- [x] Web search: LLM behavioral consistency rubric evaluation, ReliabilityBench
- [x] Web search: Skill description testable verifiable instruction design patterns
- [x] [AgentPatterns.ai: The Prompt Tinkerer Anti-Pattern](https://agentpatterns.ai/anti-patterns/prompt-tinkerer/)
- [x] [AgentPatterns.ai: Skill Authoring Patterns](https://agentpatterns.ai/tool-engineering/skill-authoring-patterns/)
- [x] [Stop Writing Prompts, Start Writing Contracts (Iqbal, 2026)](https://medium.com/@zfrqbl/stop-writing-prompts-start-writing-contracts-be9ab2c1c125)
- [x] Cross-referenced with Topic 3 (conversion mechanics, SKILL.md completeness)
- [x] Cross-referenced with Topic 5 (cross-platform behavioral fidelity)

---

## 📊 Findings

### Finding 1: Dev-Infra's Behavioral Instructions Cluster Into Three Precision Tiers

An audit of all 31 dev-infra command files reveals that behavioral instructions (as opposed to procedural steps) concentrate in a small number of commands and fall into three precision tiers:

**Tier 1 -- Precise (outcome-based, testable):**
- "Every user message is a thought to engage with, not a directive to act on" (discuss)
- "You read before responding; you never create, modify, or delete anything" (discuss skill)
- "Throwaway mindset: don't polish spike code" (spike)
- "Always review the diff -- even if the summary looks good" (review)
- "Include exact commands, expected outputs, and success criteria" (pr-validation)

**Tier 2 -- Mixed (directional but unverifiable):**
- "The AI engages substantively with full project context" (discuss) -- "substantively" is undefined
- "Write as if explaining to a thoughtful colleague" (narrative) -- audience frame is clear but "thoughtful" is vague
- "Pay special attention to cross-group dependencies" (plan-review) -- "special" has no stopping rule
- "Be comprehensive but concise" (pr) -- inherently contradictory without resolution guidance

**Tier 3 -- Vague/Problematic (persona-based, untestable):**
- "Play devil's advocate when the user seems to be confirming their own bias" (discuss) -- persona role + subjective trigger
- "Identify connections the user might not have seen" (discuss) -- unbounded scope
- "Search thoroughly before asking user" (int-opp) -- "thoroughly" has no definition
- "Gather as much information as possible automatically" (int-opp) -- encourages scope creep
- "Be thorough with priority assessment" (pr-validation) -- unquantified
- "Think about how dev-infra will use the command" (int-opp) -- open-ended

**Distribution:** Out of 31 commands, only 6 have significant behavioral content (`discuss`, `narrative`, `reflect`, `pr-validation`, `int-opp`, `spike`). The other 25 are purely procedural with occasional vague qualifiers ("thorough," "careful"). The behavioral density problem is concentrated, not systemic.

**Relevance:** The conversion to skills is a natural precision audit. Each Tier 2/3 instruction must be elevated to Tier 1 or removed.

---

### Finding 2: The Industry Has Converged on "Contracts, Not Personas" for Production Agents

Multiple independent sources (2025-2026) agree: persona-based instructions ("you are a critical colleague," "play devil's advocate") degrade reliability in production systems. The industry has converged on a contract-based model instead:

**The Prompt Contract (Iqbal, 2026):**
Four enforced layers: Goal (testable success criteria), Constraints (boundary box enforced by code), Output Schema (typed interface), Failure Conditions (what constitutes breach). The meta-principle: "Prompting in production is interface design, not communication."

**The Prompt Tinkerer Anti-Pattern (AgentPatterns.ai):**
Endlessly refining prompts with prohibitions to prevent errors that structural controls would eliminate deterministically. The escalation ladder: prompt → skill → hook → tool restriction → accept and verify. Prompts are appropriate for "guidance where interpretation ranges are valid" but not for binary correctness.

**The Delta Principle (Anthropic, via AgentPatterns.ai):**
Write skill instructions as a delta from baseline model behavior. Only specify team conventions, domain-specific rules, and edge cases the model would otherwise get wrong. Instructions the model would follow correctly anyway "waste tokens and dilute the rules that matter."

**Persona Anti-Pattern (rephrase-it.com):**
"Persona conditioning can degrade performance when irrelevant to the task, introducing unnecessary bias and variance. Personas work for style guidance, not task-relevant performance." Large identity blocks with adjectives and backstory hurt reliability.

**System Prompt Length Ceiling (ibuidl.org, 2026):**
Performance degrades above ~800 tokens across major models. Mega-prompt manifestos (400+ lines) create internal contradictions and dilute signal-to-noise.

**Key distinction:** The issue is not that behavioral instructions are bad -- it's that persona-framed behavioral instructions compete with the model's training distribution and degrade predictably. Outcome-framed behavioral instructions (what the output must achieve, not what role to play) are more reliable.

**Source:** AgentPatterns.ai (Prompt Tinkerer), Iqbal (Prompt Contracts), rephrase-it.com (Anti-Prompting Guide), ibuidl.org (Prompt Engineering Patterns 2026)

---

### Finding 3: Hex/Superpowers Skills Use "Discipline Through Pre-Emption," Not Personas

Analysis of 28 SKILL.md files across the Hex (v2.1.0) and Superpowers (v5.0.7) plugins reveals a mature behavioral specification pattern that avoids traditional personas entirely:

**Pattern 1 -- Iron Laws (named, non-negotiable rules):**
ASCII art-fenced blocks like "NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST" in `systematic-debugging`. Named laws create a reference handle the model can cite when self-checking.

**Pattern 2 -- Rationalization Tables ("Thought → Reality"):**
Pre-empt known model failure modes by listing the excuses the model is likely to generate and pairing each with the correct behavior. Example from `using-hex`:

| Thought | Reality |
|---------|---------|
| "I'll just make a quick fix" | No fixes without investigation |
| "This is obvious, no need to verify" | Evidence before assertions always |

**Pattern 3 -- Forbidden Responses (behavioral constraints as utterance bans):**
`receiving-code-review` explicitly bans performative praise ("You're absolutely right!"), gratitude loops, and batch-implementation-without-verification. These are specified as allowed/forbidden utterances -- not a persona, but a behavior boundary.

**Pattern 4 -- Gate + Exact Next Skill (terminal state definition):**
Skills define exactly what happens at completion. `brainstorming` terminates with "invoke exactly one next skill" from a defined set. `executing-plans` has explicit STOP conditions: blocked mid-batch, unclear instructions, verification fails repeatedly.

**Pattern 5 -- Gotchas Section (highest-signal content):**
Anthropic explicitly identifies the `## Gotchas` section as "the highest-signal content in any skill" -- cases where the model would do something plausible but wrong. Built incrementally from real failures, each entry names the mistake and the correct alternative.

**What Hex/Superpowers do NOT use:** Traditional personas ("you are a..."), extended role-play instructions, or vague qualifiers ("be thorough," "be careful"). The closest to a role is `subagent-driven-development` (Lead / Implementer / Reviewers), but those are operational roles with handoffs and tools, not user-facing personas.

**Relevance:** This demonstrates that complex behavioral guidance can be achieved entirely through outcome constraints, pre-emption tables, and gate conditions -- without personas.

**Source:** Hex 2.1.0 skills (14 files), Superpowers 5.0.7 skills (14 files)

---

### Finding 4: The Behavioral Contract Has a Dual Location -- Description Routes, Body Enforces

Research across the skill ecosystem reveals a consistent dual-location pattern for behavioral contracts:

**Frontmatter `description` field:**
- Functions as routing metadata: when to load the skill, not how to behave
- Anthropic's guidance: description should contain triggers only ("Use when..."), not a workflow summary
- The `writing-skills` SKILL.md in Hex states this explicitly: the description should be triggers, so the model does not "follow the blurb" and skip the body
- However, some high-urgency norms do appear in descriptions (e.g., brainstorming: "You MUST use this before any creative work...")

**Body (full SKILL.md content):**
- Where enforceable detail lives: rules, phases, checklists, forbidden behaviors, integration edges
- Pseudo-markup blocks add emphasis layers: `<HARD-GATE>`, `<EXTREMELY-IMPORTANT>`, `<SUBAGENT-STOP>`
- The body is loaded progressively (per Topic 3 FR-12: SKILL.md must be operationally complete)

**The pattern for dev-infra skills:**

| Location | Content | Example |
|----------|---------|---------|
| `description` (frontmatter) | When to invoke + scope boundaries + negative triggers | "Use when the user wants to think through ideas without implementation. Do NOT use for task execution." |
| Body (opening) | Core principle in one sentence | "Every user message is a thought to engage with, not a directive to act on." |
| Body (rules) | Specific behavioral constraints | "DO: Name specific gaps. DON'T: Manufacture disagreement." |
| Body (gotchas) | Pre-empt known failure modes | "Gotcha: 'Play devil's advocate' triggers contrarianism. Instead: name genuine concerns." |
| Body (gates) | Terminal states and handoffs | "When to suggest capturing: user says 'that's a good point' or similar signal." |

**Relevance:** FR-2 (behavioral skills must define precise engagement contracts) should specify this dual-location pattern. The behavioral contract is not a single blob -- it has a routing layer and an enforcement layer.

**Source:** AgentPatterns.ai (Skill Authoring Patterns), Hex `writing-skills` meta-commentary, Anthropic's guide (via AgentPatterns.ai)

---

### Finding 5: A Behavioral Contract Quality Rubric Emerges from the Research

Synthesizing across all sources, a behavioral contract must have five properties to be reliable:

**Property 1 -- Observable (can you tell if the agent complied?):**
Bad: "engage substantively" (how would you verify?)
Good: "include at least one specific concern per user claim" (countable)
Test: Could a reviewer reading the output determine compliance without asking the agent?

**Property 2 -- Bounded (does the instruction have a stopping rule?):**
Bad: "identify connections the user might not have seen" (infinite scope)
Good: "after responding, note at most 2 connections to other ongoing work" (bounded)
Test: Could the agent determine when it has done "enough"?

**Property 3 -- Outcome-Framed (does it describe what to produce, not who to be?):**
Bad: "play devil's advocate" (role to inhabit)
Good: "if you see a logical gap, name it specifically; don't manufacture disagreement" (behavior to exhibit)
Test: Does the instruction reference an output characteristic or an identity characteristic?

**Property 4 -- Delta-Only (does it add information the model wouldn't have?):**
Bad: "be helpful and clear" (the model's default behavior)
Good: "when the user's concern contradicts a prior research finding, cite the finding by topic number" (domain-specific rule)
Test: Would the model behave differently without this instruction?

**Property 5 -- Failure-Aware (does it specify what NOT to do and what happens on ambiguity?):**
Bad: (no failure guidance)
Good: "If the user's message is ambiguous between a discussion point and an implementation request, ask for clarification rather than defaulting to either interpretation"
Test: Does the instruction handle the failure mode, not just the happy path?

**Scoring:** A behavioral instruction that meets all 5 properties is Tier 1 (reliable contract). Missing 1-2 properties = Tier 2 (needs revision). Missing 3+ properties = Tier 3 (replace or remove).

**Source:** Synthesized from Iqbal (Prompt Contracts), AgentPatterns.ai (Skill Authoring), Hex/Superpowers patterns, ReliabilityBench (end-state equivalence)

---

### Finding 6: The Spike B `/discuss` Revision Is Demonstrably Better -- and the Pattern Generalizes

The original `/discuss` command contains multiple Tier 3 instructions. The spike B SKILL.md revision elevates most to Tier 1/2. The improvement pattern generalizes:

| Original (discuss.md) | Revised (spike SKILL.md) | Rubric Assessment |
|---|---|---|
| "Play devil's advocate" | "Prioritize intellectual honesty... name genuine concerns specifically. Don't manufacture disagreement." | Tier 3 → Tier 1 (observable, outcome-framed, failure-aware) |
| "Engage substantively" | "You become a discussant: every user message is a thought to engage with, not a directive to act on" | Tier 3 → Tier 1 (bounded by interaction rule) |
| "Identify connections the user might not have seen" | "Surface connections and gaps" | Tier 3 → Tier 2 (still unbounded; needs "at most N" or a stopping condition) |
| "Note when a thought seems significant enough to capture" | "Offer pushback when the user seems to be confirming their own bias" | Tier 3 → Tier 2 (still subjective trigger; could add: "indicators of confirmation bias include: restating the same conclusion in different words, dismissing counterevidence without engagement") |

**The generalization:** Every Tier 3 → Tier 1 improvement follows the same transformation:
1. Replace the persona/role frame with an observable behavior
2. Add a failure mode ("don't manufacture disagreement")
3. Make the trigger condition specific (not "seems to be" but "when user does X")

**Remaining gaps in the spike draft:** Two instructions remain at Tier 2. These need the same treatment the "devil's advocate" line received.

**Relevance:** The conversion to skills should include a rubric pass on all behavioral instructions, not just the discuss skill.

**Source:** Spike B SKILL.md, dev-infra command audit, rubric (Finding 5)

---

### Finding 7: Consistency Across Sessions Requires Structural Anchors, Not Stronger Wording

ReliabilityBench (2026) and multi-turn consistency research reveal that behavioral consistency across sessions is NOT improved by making instructions more emphatic ("IMPORTANT:", "NEVER", "CRITICAL"). Instead, consistency requires structural anchors:

**What works for cross-session behavioral consistency:**
1. **Named rules** (Hex's "Iron Laws") -- the model can reference a named rule in its reasoning, creating a self-reinforcing loop
2. **Rationalization tables** -- pre-empt the specific excuses the model generates when drifting from intended behavior
3. **Gate conditions** -- binary checks at decision points ("before responding, verify: is this a discussion point or an implementation request?")
4. **Few-shot examples** -- 3 examples boost structured output compliance from 71% to 94% (ibuidl.org, 2026)
5. **Short instructions with external detail** -- the 800-token system prompt ceiling means behavioral contracts should be concise in the SKILL.md body, with extended guidance in `references/`

**What does NOT improve consistency:**
1. Adding "IMPORTANT:" or "NEVER" (social emphasis has no concept in the model)
2. Repeating the same instruction multiple times (redundancy dilutes other rules)
3. Longer persona blocks (degrades signal-to-noise)
4. Stacking negation rules (>5 negation rules is a Prompt Tinkerer symptom)

**Relevance for dev-infra:** Skills should use named rules, pre-emption tables, and gate conditions rather than emphasis markers. The escalation ladder (prompt → skill → hook → tool restriction → verify) should be applied when behavioral instructions prove unreliable.

**Source:** ReliabilityBench (arxiv 2601.06112), AgentPatterns.ai (Prompt Tinkerer), ibuidl.org (few-shot data)

---

### Finding 8: The "Write as Delta" Principle Significantly Reduces Behavioral Instruction Volume

Anthropic's internal skill authoring guidance (January 2026, via AgentPatterns.ai) identifies a key efficiency principle: "Write skill instructions as a delta from baseline model behavior. Only specify team conventions, domain-specific rules, and edge cases that the model would otherwise get wrong."

Applied to dev-infra's behavioral instructions:

**Remove (model already does this):**
- "Be helpful and clear" -- default behavior
- "Be comprehensive" -- default for analytical tasks
- "Think about implications" -- default reasoning behavior

**Keep (delta from default):**
- "Every message is a thought to engage with, not a directive" -- overrides the model's default "implement what was asked" behavior
- "Read before responding; never modify files" -- overrides the model's default tool-use behavior
- "Don't manufacture disagreement" -- overrides the "helpful contrarian" mode some models default to when asked to challenge

**Add (domain-specific rules the model wouldn't know):**
- "When a concern contradicts a prior research finding, cite the finding by topic number" -- dev-infra workflow knowledge
- "The user's `/discuss` session may span multiple topics; maintain thread coherence across topic shifts" -- session-level contract

**Estimated reduction:** Applying the delta principle to dev-infra's behavioral instructions would remove approximately 30-40% of current behavioral text, concentrating what remains on the instructions that actually change model behavior.

**Source:** Anthropic guide (via AgentPatterns.ai Skill Authoring Patterns)

---

## 🔍 Analysis

### The Behavioral Contract Spectrum

Dev-infra's behavioral instructions sit on a spectrum from fully structural (procedural steps, templates, checklists) to fully behavioral (persona, tone, engagement style). The research reveals where each type belongs:

```
Fully Structural                                          Fully Behavioral
│                                                                      │
│  task steps    templates    gate conditions    named rules    tone    │
│  checklists    schemas      pre-emption        examples     persona  │
│                              tables                                  │
│                                                                      │
│  ← RELIABLE (deterministic)          UNRELIABLE (probabilistic) →    │
│                                                                      │
│  Use: skill body    Use: skill body    Use: skill body    AVOID or   │
│       + references       (concise)         (concise)      replace    │
│                                                           with       │
│                                                           outcome    │
```

The key insight: behavioral instructions are not inherently unreliable. They become unreliable when they use persona framing, unbounded scope, or emphasis markers instead of observable outcomes, stopping rules, and failure modes.

### Dev-Infra's Conversion Opportunity

The audit reveals that dev-infra's behavioral instruction problem is concentrated (6 commands out of 31) and tractable (most Tier 3 instructions have clear Tier 1 rewrites). The conversion to skills provides a natural checkpoint to apply the rubric.

**Conversion priority by behavioral density:**

| Command | Behavioral Density | Tier 3 Count | Conversion Priority |
|---------|-------------------|--------------|---------------------|
| `discuss` | Very High | 5 | First (already spiked) |
| `narrative` | High | 2 | Second |
| `reflect` | Medium | 2 | Third |
| `int-opp` | Medium | 4 | Fourth |
| `pr-validation` | Low | 1 | Fifth |
| `spike` | Low | 0 | Sixth (already Tier 1) |

### The Hex/Superpowers Model as a Target Architecture

Hex/Superpowers skills demonstrate that complex behavioral guidance can be achieved without personas, through five structural mechanisms: Iron Laws, rationalization tables, forbidden responses, gate conditions, and gotchas sections. This is the target architecture for dev-infra's behavioral skills.

The transformation is: every persona instruction → an observable outcome + a failure mode + a stopping condition. The discuss skill spike already demonstrates this for the hardest case.

### Finding 9: The Escalation Ladder Applies to Both Tracks -- Agent and Human (Post-Research Amendment)

**Added:** 2026-04-10 (surfaced during `/discuss` connecting Topic 8 Finding 2 with Topic 7 Finding 8 and workflow-simplification NFR-7)

The Prompt Tinkerer escalation ladder (prompt → skill → hook → tool restriction → verify) was framed in Topic 8 Finding 2 as an agent-side concern: move deterministic rules out of the skill body into hooks and tools so the agent's context budget is reserved for judgment work.

But the dual-track model (Topic 7 Finding 8) reveals the same principle applies to the human participant. The human is currently:
- Reading long markdown files to reconstruct workflow state (the same "undirected context loading" that costs the agent tokens)
- Mentally tracking which topics are complete, which findings corrected earlier findings
- Carrying cross-project connections (proj-cli, work-prod, proj-clone) in working memory
- Parsing the same prose for both guidance and enforcement

A 400-line command file is fragile for the agent (accuracy degradation, lost-in-the-middle) AND fragile for the human (can't hold in working memory, skims, misses the critical line). The skill decomposition (Topic 3) fixes the agent side. The human side is addressed by **tooling** -- hooks and CLI that enforce deterministic rules and surface state.

**The three-state arc:**

| State | Agent Input | Human Input | Enforcement |
|-------|------------|-------------|-------------|
| **Current** | Long `.mdc` rules + `.md` commands | Same prose files | Prose ("make sure you do X") |
| **After skill conversion** | Lean skills + templates | Shorter skills, still prose rules | Prose in skill body |
| **After hooks/CLI integration** | Skills carry only judgment work | CLI surfaces state; hooks enforce rules | Deterministic (hooks, validation, CLI) |

**The convergence:** Both research efforts point here:
- **Agentic-workflow-modernization:** Delta principle (Topic 8), escalation ladder (Topic 8 Finding 2), progressive skill loading (Topic 1), one-skill-per-workflow (Topic 3)
- **Workflow-simplification:** NFR-7 (context proportional to work), tiered file structure (Topic 3), AI context waste quantification (~150 unused lines per `/task`)

**Implication for the design step:** The design step should explicitly allocate each piece of guidance to the right enforcement layer:
- **Skill body:** Judgment work (behavioral contracts, decision criteria, workflow sequence)
- **Hooks:** Deterministic rules (commit format, file boundaries, pre-conditions before tool use)
- **CLI tools:** State surfacing (where are we, what's next, what corrected what)
- **Human sync points:** Cross-project connections, UX intuition, priority judgment

This also validates the user's interest in proj-cli and proj-clone: those tools are the "deterministic infrastructure that reduces cognitive load on both tracks" that the modernized architecture points toward.

**Source:** `/discuss` session connecting Topic 8 Finding 2, Topic 7 Finding 8, workflow-simplification NFR-7

---

**Key Insights:**

- [x] Insight 1: Behavioral instruction precision is a concentrated problem (6 of 31 commands), not a systemic one. The conversion to skills is the natural audit checkpoint.
- [x] Insight 2: The industry has converged: contracts over personas, outcomes over roles, delta over comprehensive. This aligns with Spike B's finding and generalizes it.
- [x] Insight 3: Five properties define a reliable behavioral contract: observable, bounded, outcome-framed, delta-only, failure-aware. Instructions meeting all five are Tier 1.
- [x] Insight 4: Hex/Superpowers demonstrate the target architecture: named rules, rationalization tables, forbidden responses, gates, and gotchas -- no personas needed.
- [x] Insight 5: The behavioral contract has a dual location (description routes, body enforces) -- this is a structural pattern, not a style choice.
- [x] Insight 6: Cross-session consistency comes from structural anchors (named rules, examples, gates), not from emphasis markers ("IMPORTANT:", "NEVER").
- [x] Insight 7: The escalation ladder applies to both tracks (agent and human) -- hooks/CLI reduce cognitive load for both participants, not just token cost for the agent.

---

## 💡 Recommendations

- [x] **Apply the five-property rubric during skill conversion.** Every behavioral instruction in a skill should be assessed against: observable, bounded, outcome-framed, delta-only, failure-aware. Tier 3 instructions must be elevated to Tier 1 or removed. This is a quality gate, not a style preference.

- [x] **Adopt the Hex/Superpowers structural patterns for behavioral skills.** Specifically: named rules for non-negotiable behaviors, rationalization tables for known failure modes, gotchas sections built from real failures, and gate conditions at decision points. These patterns replace persona instructions with testable structure.

- [x] **Apply the delta principle to reduce behavioral instruction volume.** Remove instructions that restate default model behavior. Keep only team conventions, domain-specific rules, and edge cases. This reduces token cost and concentrates attention on the instructions that matter.

- [x] **Use the dual-location pattern for all behavioral skills.** Description (frontmatter) carries routing triggers and scope boundaries. Body carries enforceable behavioral rules. Do not put behavioral enforcement in the description -- it gets treated as a summary and skipped.

- [x] **Prioritize discuss, narrative, and reflect for behavioral precision audit.** These three skills have the highest density of Tier 3 instructions. The discuss spike already demonstrates the transformation pattern; apply it systematically to the other two.

- [x] **Add a gotchas section to every behavioral skill.** Initially populated from the Tier 3 instruction audit, then incrementally refined from real usage failures. This is the highest-signal section of any behavioral skill (per Anthropic's guidance).

---

## 📋 Requirements Discovered

- [x] **FR-24: Behavioral Skills Must Pass a Five-Property Quality Rubric.** Every behavioral instruction in a SKILL.md must be assessed against: (1) observable -- compliance is determinable from output, (2) bounded -- the agent can determine when it has done enough, (3) outcome-framed -- describes what to produce, not who to be, (4) delta-only -- adds information the model wouldn't have by default, (5) failure-aware -- specifies what NOT to do and how to handle ambiguity. Instructions failing 3+ properties must be rewritten or removed.
      **Source:** Findings 2, 5, 6 (industry convergence, rubric synthesis, spike validation)
      **Priority:** High (quality gate for behavioral skill conversion)

- [x] **FR-25: Behavioral Skills Must Include a Gotchas Section.** Every behavioral skill must include a `## Gotchas` section listing cases where the model would do something plausible but wrong. Each gotcha names the mistake and the correct alternative. The section is initially populated from the command audit (Tier 3 instructions) and incrementally refined from real usage.
      **Source:** Findings 3, 7 (Hex/Superpowers patterns, Anthropic guidance)
      **Priority:** Medium (high-signal content, but populatable incrementally)

- [x] **FR-26: Skill Descriptions Must Follow the Dual-Location Pattern.** The SKILL.md `description` frontmatter field must contain only routing information: what the skill does, when to invoke it, and negative triggers (when NOT to use it). Behavioral enforcement belongs in the body only. This prevents the model from treating the description as a behavioral summary and skipping the body.
      **Source:** Finding 4 (Hex writing-skills meta-commentary, AgentPatterns.ai)
      **Priority:** Medium (structural pattern affecting all skills, not just behavioral ones)

- [x] **FR-27: The Design Step Must Allocate Guidance to the Appropriate Enforcement Layer.** During skill design, each piece of guidance must be assigned to one of four layers: (1) skill body -- judgment work only (behavioral contracts, decision criteria, workflow sequence), (2) hooks -- deterministic rules (commit format validation, file boundary enforcement, pre-conditions before tool use), (3) CLI/tooling -- state surfacing (workflow position, completion status, cross-topic corrections), (4) human sync points -- cross-project connections, UX judgment, priority decisions. This allocation reduces cognitive load for both the agent (fewer tokens on non-judgment content) and the human (tooling replaces manual state reconstruction).
      **Source:** Finding 9 (escalation ladder on both tracks, three-state arc)
      **Priority:** Medium (design-phase constraint, not blocking skill conversion itself)

---

## 🚀 Next Steps

1. Feed FR-24 into the conversion workflow: the five-property rubric is a quality gate applied during each skill conversion
2. Feed FR-25 into the skill template: add `## Gotchas` as a required section in the SKILL.md template
3. Feed FR-26 into skill authoring standards: clarify description vs body content rules
4. Feed Finding 1 (command audit results) into conversion prioritization: discuss → narrative → reflect → int-opp
5. Run `--consolidate` -- all 8 topics are now complete

---

**Last Updated:** 2026-04-10
