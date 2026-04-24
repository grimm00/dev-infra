# Spike Learnings: AGENTS.md Portability

**Exploration:** `../exploration.md`
**Created:** 2026-03-25
**Time-box:** ~1 hour (research-heavy spike; empirical testing deferred where noted)
**Result:** Partially Validated

---

## Questions Answered

- [x] Q1: Is AGENTS.md an established standard? -- **Yes.** 60,000+ repos, backed by the Linux Foundation's Agentic AI Foundation (Dec 2025), supported by 25+ tools.
- [x] Q2: Does Cursor read AGENTS.md? -- **Yes.** Treated as agent instructions in markdown. Loaded at lowest priority in the rules chain.
- [x] Q3: Does Claude Code read AGENTS.md? -- **No.** Claude Code only reads `CLAUDE.md`. AGENTS.md support is an open feature request (issue #34235, #6235). Workaround: have `CLAUDE.md` instruct the agent to read `AGENTS.md`, or use hooks.
- [x] Q4: Does AGENTS.md support file references (hub-and-spoke)? -- **Not in the spec.** File reference following is tool-dependent, not specified by the standard. The spec is plain markdown with no required schema.
- [x] Q5: Does AGENTS.md support subdirectory scoping? -- **Proposed but not standardized.** A `.agents/` directory proposal exists (GitHub issue #9) but hasn't been adopted. Each tool has its own directory convention (`.cursor/rules/`, `.github/instructions/`, etc.).
- [x] Q6: What's the precedence when both AGENTS.md and .cursor/rules exist? -- **`.cursor/rules` takes priority.** Full hierarchy: Team Rules > Project Rules (`.cursor/rules/*.mdc`) > User Rules > Legacy Rules (`.cursorrules`) > AGENTS.md (lowest).

---

## Key Findings

### Finding 1: AGENTS.md is Real, But Not Universal

AGENTS.md is a legitimate, widely-adopted standard -- not vaporware. 60k repos, Linux Foundation backing, cross-tool support. It's the emerging "README for agents." However, Claude Code -- one of the two platforms that matter most for dev-infra -- does not natively support it. This means the "one file, all platforms" promise doesn't hold today.

### Finding 2: Cursor Treats AGENTS.md as Lowest Priority

In Cursor, AGENTS.md sits at the bottom of the rules hierarchy. The existing `.cursor/rules/*.mdc` files (with `alwaysApply: true`) take precedence. This means AGENTS.md isn't a replacement for `.mdc` rules in Cursor -- it's supplementary. For dev-infra, this is actually fine: AGENTS.md handles the portable baseline; `.mdc` handles Cursor-specific features (glob patterns, activation modes, auto-attach).

### Finding 3: The Hub-and-Spoke Model Won't Work Via AGENTS.md Alone

The elegant layered AGENTS.md that points to skill directories and reference files isn't supported by the spec. File references in AGENTS.md are just text -- the agent may or may not follow them depending on the tool. The monolithic inline approach (all content in one file) is the safe bet for guaranteed delivery.

However, in practice, capable agents (like Cursor's) will likely read referenced files when asked about them -- they just aren't *auto-loaded*. The distinction is: auto-loaded context (guaranteed) vs. on-demand context (agent reads the file when it seems relevant). Skills handle on-demand loading natively.

### Finding 4: Claude Code Needs CLAUDE.md (Dual-File Strategy)

For Claude Code portability, dev-infra needs a `CLAUDE.md` alongside or instead of `AGENTS.md`. Two strategies:

1. **Dual-file:** Maintain both `AGENTS.md` (for Cursor, Codex, Copilot, etc.) and `CLAUDE.md` (for Claude Code). Risk: sync drift between two files.
2. **CLAUDE.md as shim:** A minimal `CLAUDE.md` that says "Read and follow AGENTS.md in this repository." This depends on Claude Code reliably following that instruction.
3. **Wait:** Claude Code AGENTS.md support is actively requested. It may ship in 2026.

### Finding 5: The Standard Favors Operational Content

Best practices for AGENTS.md emphasize executable commands, concrete conventions, and clear boundaries -- not behavioral identity or philosophical disposition. The "Identity/Rules layer" we envisioned (collaborator by default, pushback on assumptions) goes beyond current AGENTS.md conventions. It *can* go there, but it's not the pattern most tools are optimized for.

The recommended sections: agent role, project overview, dev setup, build/test commands, code style, PR conventions, security, boundaries (Always/Ask First/Never). This maps to our Conventions layer, not our Identity layer.

---

## Edge Cases Tested

| Case | Expected | Actual | Pass? |
|------|----------|--------|-------|
| AGENTS.md auto-loaded in Cursor | Yes | Yes (per docs, lowest priority) | Yes |
| AGENTS.md auto-loaded in Claude Code | Yes | No (CLAUDE.md only) | **No** |
| File references auto-followed | At least partially | Not in spec; tool-dependent | **No** |
| Subdirectory AGENTS.md | Supported | Proposed, not standardized | **No** |
| Coexists with .cursor/rules | Yes, merged | Yes, .mdc takes precedence | Yes |
| AGENTS.md replaces .mdc rules | N/A | No -- .mdc has priority and more features | N/A |

---

## Go / No-Go

**Recommendation:** Go with modifications

**Rationale:** AGENTS.md is worth adopting as a portable conventions layer. It's a real standard with broad tool support. However, the four-layer model needs adjustment:

1. **AGENTS.md** -- portable conventions (project overview, build/test, code style, PR conventions, boundaries). This is the "onboarding doc for any agent, any tool."
2. **CLAUDE.md** -- Claude Code-specific shim or duplicate (until native AGENTS.md support ships). Minimal: "Read AGENTS.md" + any Claude-specific config.
3. **`.cursor/rules/*.mdc`** -- Cursor-specific behavioral config (always-apply, glob patterns, activation modes). The Identity layer lives here for Cursor.
4. **Skills (SKILL.md)** -- portable procedural workflows. These handle progressive loading natively.

The behavioral identity ("collaborator by default") is best expressed in the platform-specific config (`.mdc` for Cursor, `CLAUDE.md` for Claude Code) because behavioral configuration depends on platform-specific mechanisms. AGENTS.md carries the portable, operational baseline that any agent should know.

**Modifications needed:**
- Don't attempt hub-and-spoke AGENTS.md with file references -- use inline content
- Create CLAUDE.md as a shim or minimal duplicate for Claude Code portability
- Keep `.mdc` rules for Cursor-specific behavioral config; don't try to migrate Identity layer to AGENTS.md
- The four-layer model becomes: AGENTS.md (portable ops) + platform config (`.mdc` / `CLAUDE.md`) + skills + commands

---

## Refined Questions

New questions revealed by this spike (feed back to research):

1. How reliable is the "CLAUDE.md shim" approach? Does Claude Code consistently follow instructions to read another file?
2. When Claude Code ships AGENTS.md support, will it follow the same precedence model as Cursor (CLAUDE.md > AGENTS.md)?
3. Should dev-infra's templates seed AGENTS.md alongside `.cursor/rules/`? What's the template impact?
4. The behavioral identity layer: can `.mdc` and `CLAUDE.md` share the same content via template sync, or do they need platform-specific versions?

---

## Spike Code

**Location:** `.` (this directory)
**Keep or discard:** Keep as reference (test plan + reference conventions file)

---

## Next Steps

- [ ] Create a minimal `AGENTS.md` for dev-infra (conventions layer only) as a real-world test
- [ ] Create a `CLAUDE.md` shim for Claude Code portability
- [ ] Proceed to Spike B: command-to-skill conversion (`/discuss` as the test case)
- [ ] Feed refined questions into Topic 5 (cross-platform portability) and Topic 9 research

---

**Last Updated:** 2026-03-25

---

---

# Spike Learnings: Command-to-Skill Conversion (Spike B)

**Exploration:** `../exploration.md`
**Created:** 2026-03-25
**Time-box:** ~1 hour
**Test case:** `/discuss` command → SKILL.md
**Result:** Validated

---

## Questions Answered

- [x] Q1: Can a high-behavioral-contract command be converted to a SKILL.md that preserves its behavioral fidelity? -- **Yes.** The Behavior Rules section translates almost directly. The "be a collaborator who pushes back" contract survives in the Role section.
- [x] Q2: Does the 500-line limit require decomposition for `/discuss`? -- **No.** 267-line command → 143-line SKILL.md. 46% reduction by removing motivational content (Why This Exists), common scenarios, integration pipeline diagrams, and redundant tips. Headroom for complex commands without reference files.
- [x] Q3: What is the right `disable-model-invocation` decision for a behavioral command? -- **Always true for `/discuss`.** Auto-detection would violate the behavioral contract -- the skill exists precisely to prevent premature auto-action. This is a categorical finding: any command whose value is the *deliberate choice to invoke it* must have `disable-model-invocation: true`.
- [x] Q4: What should the `description` field contain for a non-auto-detecting skill? -- **User-facing clarity, not detection optimization.** Since the skill won't auto-invoke, the description is for the user browsing the skills list and for the agent understanding the skill's purpose when the skill list is loaded. Write for understanding, not trigger matching.
- [x] Q5: Are reference files needed for `/discuss`? -- **No.** Common scenarios (60 lines) are illustrative, not load-bearing. Reference files are most valuable for skills with large templates or external configs, not for behavioral skills.

---

## Key Findings

### Finding 1: Two Distinct Skill Archetypes

`update-pr-description` and `discuss` represent two fundamentally different skill types that need different SKILL.md structures:

| Dimension | Procedural Skill (update-pr-description) | Behavioral Skill (discuss) |
|-----------|------------------------------------------|----------------------------|
| Structure | prerequisites → steps → output | role assumption → engagement rules → optional output |
| Core content | Executable commands, merge logic | Constraints, active behavior during conversation |
| Line count | 208 lines | 143 lines |
| Reference files | Not needed (logic is inline) | Not needed (behavior is inline) |
| `disable-model-invocation` | `true` (avoid false positives on "create PR") | `true` (violation of contract if auto-invoked) |
| Portability concern | Output format (gh CLI availability) | Behavioral fidelity across platforms |

The 26 dev-infra commands will decompose into these two archetypes (and hybrids). Recognizing the archetype upfront shapes the SKILL.md structure.

### Finding 2: What Gets Cut in Conversion

The 267 → 143 line reduction came from removing:
- **Why This Exists** (motivation): Useful for humans reading the command file, not needed by the agent executing the skill. An agent doesn't need to know the history of why the skill exists.
- **Common Scenarios** (4 examples, ~60 lines): Illustrative but not load-bearing. The agent doesn't execute scenarios; it follows constraints. If scenario guidance matters, it should be in the Role/During section, not as example narratives.
- **Integration pipeline diagram**: Useful for human understanding of where the command fits; the agent uses Related Skills for this instead.
- **Redundant tips**: "Be honest about uncertainty" is implied by the behavioral contract, not a separate instruction.

**Rule of thumb:** Everything that reads like "here's how a human thinks about this command" gets cut. Only what the agent needs to execute the skill correctly stays.

### Finding 3: The Behavioral Contract Compresses Well

The original 8-point Behavior Rules section (DO NOT/DO) compressed to the Absolute Constraints + Role sections with no loss of fidelity. The contract actually reads more clearly in the skill -- the original command buries the behavioral intent under motivational prose. The skill puts it front and center.

Key addition in the skill that wasn't explicit in the command: **"Every user message is a thought to engage with, not a directive to act on."** This is implied in the command but made explicit in the skill's Role section. The compression forced a clearer statement of the core contract.

### Finding 4: `disable-model-invocation: true` Is a First-Class Design Decision

For `/discuss` the decision is trivially obvious in retrospect: auto-detection would break the fundamental purpose of the skill. But this finding generalizes. For every command being converted, the first question should be:

> "Is part of this command's value the deliberate act of invoking it?"

If yes: `disable-model-invocation: true`. Candidates in dev-infra's command set:
- `/discuss` -- YES (deliberate mode-switch)
- `/review` -- YES (deliberate human pause before commit)
- `/commit` -- YES (deliberate finalization after review)
- `/explore` -- MAYBE (could auto-trigger on unstructured thoughts, but the user prefers explicit)
- `/task` -- MAYBE (could auto-trigger during implementation context)
- `/pr` -- NO (reasonable to auto-suggest when branch is ready)

### Finding 5: Behavioral Persona Instructions Are Underspecified -- Skills Force Precision

The spike SKILL.md inherited "play devil's advocate" from the original command. On review, this is a precision problem: the phrase implies the agent takes the opposing position *as a role*, which is contrarianism for its own sake. An agent following it might manufacture objections it doesn't actually believe just to seem rigorous.

The original command has a condition ("when the user seems to be confirming their own bias") but "play devil's advocate" still carries the connotation of performed opposition, not genuine critical engagement.

**The correct framing:** intellectual honesty over agreeableness. The agent should be *ready* to push back when it has specific grounds -- a logical gap, an unstated assumption, a named risk -- but should not suppress genuine concerns to keep the conversation smooth. If it can't name a specific concern, it shouldn't invent one.

**Better instruction:** *"Prioritize intellectual honesty over agreeableness: if you see a logical gap, an unstated assumption, or an argument that doesn't hold -- name it specifically. Don't manufacture disagreement, but don't suppress genuine concerns to keep the conversation smooth."*

The distinction: **reactive** pushback (triggered by something specific) vs **proactive** pushback (injected regardless to seem critical). The skill should express reactive with a low threshold.

**Generalization:** This same underspecification problem likely exists across dev-infra's other commands. Any instruction that reads like a behavioral persona -- "be thorough," "be creative," "play the skeptic" -- is underspecified and may produce inconsistent behavior. The conversion from command to skill is a forcing function for making these precise. That's an unexpected and valuable benefit of skill conversion beyond portability.

### Finding 6: Skills Are the Right Home for Behavioral Contracts Too

The initial framing of skills was "procedural workflows with progressive loading." But `/discuss` shows skills can also be **role assignments** -- they tell the agent what kind of agent to become, not just what procedure to follow. This is the "be a scientist" pattern formalized: the skill description and Role section set the agent's disposition for the duration of the session.

This reframes the redistribution rubric (Topic 2): the sorting criteria for commands isn't just "procedural vs simple trigger" but "procedural vs behavioral vs hybrid." Behavioral skills need the Role archetype; procedural skills need the steps archetype.

---

## Edge Cases Examined

| Case | Decision | Rationale |
|------|----------|-----------|
| Auto-invocation | Disabled (`disable-model-invocation: true`) | Would violate the behavioral contract |
| Common scenarios in SKILL.md | Removed | Not load-bearing; 143 lines without them |
| Reference files | Not needed | No templates or configs; behavior is inline |
| Why This Exists section | Removed | Motivational context for humans, not agents |
| Description field purpose | User-facing clarity | Not a detection trigger (auto-detect off) |

---

## Go / No-Go

**Recommendation:** Go

**Rationale:** Command-to-skill conversion is feasible and produces a cleaner behavioral contract than the original command format. The 500-line limit is not a practical constraint for most commands. The `disable-model-invocation` decision is the most important design choice and is easy to reason about once the question is framed correctly.

**What changes vs original plan:**
- Scope for Topic 3 (conversion mechanics) can expand to include the behavioral archetype -- not just the procedural case from `update-pr-description`
- The redistribution rubric (Topic 2) needs a three-way sort: procedural skill / behavioral skill / simple trigger (command), not two-way
- Reference files are most relevant for skills with large templates (e.g., `/explore` with its exploration.md template, research-topics.md template, etc.) -- that's where the structural schemas insight (Theme 4) connects most directly

---

## Refined Questions

1. Is the behavioral archetype reusable? Could a `role-context.md` reference file define the "discussant" role and be referenced by multiple related skills?
2. For hybrid commands (e.g., `/task` which is both procedural and has a behavioral component -- TDD discipline, review-then-commit), how does the skill structure handle both?
3. The 4 common scenarios in `/discuss` were cut -- but for more complex commands, do scenarios belong in a reference file or should they stay out entirely?
4. How does the marketplace `plugin.json` wrapping affect skill design? Does the description field in SKILL.md frontmatter differ from marketplace metadata?

### Finding 6: The Defensive Behavioral Contract Is Incomplete -- The Affirmative Layer Is Missing

The Spike B SKILL.md captured the defensive contract of `/discuss` cleanly: read-only, no side effects, engage critically, treat every user message as a thought to engage with not a directive to act on. This is correct and valuable. But a subsequent discussion session revealed it's the floor, not the ceiling.

The discussion session -- this parent conversation -- does substantially more than refuse to create files. It is the persistent orchestration layer for the entire workflow. It occupies five distinct stances at any moment:

| Stance | What the session is doing |
|--------|--------------------------|
| **Discuss** | Accumulating context, making judgments, thinking through implications. Building the understanding that makes delegation safe. |
| **Materialize** | Crystallizing conversation-only insights (preferences, nuances, unstated assumptions) into artifacts that cold-start subagents can consume. The interface preparation step before delegation. |
| **Delegate** | Handing off bounded work to subagents with specific artifacts as context and specific deliverables. Retaining judgment of the output. |
| **Review** | Reading subagent output back in, challenging it, synthesizing it. Reclaiming judgment after delegation. |
| **Iterate** | Amending artifacts, re-delegating, or advancing to decisions. The loop back into discuss or materialize. |

These aren't sequential phases. The session cycles between them non-linearly -- discuss and materialize can interleave many times before delegation happens. Review can loop back to discuss if subagent output opens new questions. The direction is a gradient, not a pipeline.

**What the current skill is missing:** The affirmative role. The skill knows what NOT to do. It doesn't help the user understand *when* they're ready to materialize, when materialization is good enough to delegate, or when a review output should trigger re-discussion vs advance to the next step. An orchestration-aware behavioral skill would name these stances and help the user navigate transitions between them -- without enforcing a rigid sequence.

**Two implementation options:**

- **Option A:** Encode the five-stance model in the `/discuss` SKILL.md itself. The skill becomes "orchestration-aware discussion mode" -- same read-only contract, but with active guidance on when to shift stances.
- **Option B:** Create a session-init meta-skill (Superpowers-style) that injects the five-stance model into every conversation at session start, regardless of whether `/discuss` is invoked. Every conversation in the project starts orchestration-aware. The `/discuss` skill stays focused on the read-only discussion contract.

Option B is more powerful (it covers all conversations, not just explicit `/discuss` invocations) but more expensive to implement and test. Option A is lower friction.

**The Name Question**

"Discuss" accurately names the read-only contract -- it signals "thinking mode, not doing mode" and shapes user behavior toward that contract. But it undersells the session's actual role. The session is the judgment layer, the context accumulator that subagents cannot replicate, the decision point for when to delegate and when to hold. Whether the name matters depends on what behavior we want to encourage:

- If the goal is preserving the read-only discipline → "discuss" is correct; changing it risks confusing the contract
- If the goal is signaling the full role → alternatives like `/think`, `/lead`, `/guide` better capture the orchestration layer
- Middle path: keep `/discuss` as the command name, but the SKILL.md description explicitly names the richer role it plays

The naming question has user-visible behavioral implications and is worth a deliberate decision rather than an incidental one. It is captured as part of Topic 11 (research-topics.md) for resolution alongside the skill design decision.

---

### Finding 7: Behavioral Contracts Operate at Two Levels -- Identity vs Skill

**Insight from:** `/discuss` session on `/task` hybrid archetype and agent identity

**The core distinction:**

A `/task` skill that says "apply TDD discipline" is not *teaching* TDD -- it's *activating* a professional identity the agent already carries. The skill is a role signal, not a tutorial. A skill that conflates the two ends up re-explaining foundational competence, bloating the file and making it instructional rather than disciplining.

**Two-level model:**

| Level | What it carries | Where it lives |
|-------|----------------|----------------|
| **Identity-level** | Professional competence: "you are a software developer who understands TDD, code quality, separation of concerns" | AGENTS.md / session-init meta-skill |
| **Skill-level** | Role activation and repo-specific constraints: "you are the implementer now; use feature branches; update status during work" | SKILL.md behavioral section |

**Practical implication for `/task`:**

The behavioral section of a `/task` skill should read as *constraints and activations*, not instructions. Good: "Apply TDD discipline as the implementer role." Bad: "TDD means writing a failing test first, then writing the minimum code to pass it, then refactoring..." The latter assumes the agent doesn't know TDD. The former trusts the identity layer.

**The Hex `.agents/` mechanism:**

Hex/Superpowers separates agent identity from individual skills by using `.agents/` for both. The `.agents/agents/` path (or equivalent) can hold agent configuration that defines the professional baseline. A `software-developer.md` agent definition establishes the foundational identity once; all skills that activate the implementer role build on top without repeating it.

**Impact on FR-9 (hybrid skill spec):**

FR-9 should distinguish between the two contract levels. A hybrid skill spec is not "a skill that has both procedural steps and behavioral instructions." It is a skill whose behavioral section activates role identity and applies repo-specific constraints, while the procedural section encodes workflow steps. The skill *trusts* the identity layer to supply competence; it doesn't rebuild it.

**Impact on the `/discuss` skill (Spike B):**

The draft `SKILL.md` for `/discuss` (143 lines) is a behavioral skill. It should similarly trust that the agent already knows what intellectual engagement means -- its behavioral section should activate the discussant role and constrain it (no side effects, push back thoughtfully, don't formalize prematurely) rather than explain what a good discussion looks like in the abstract. The current draft is close; this finding refines the framing.

---

## Spike Code

**Location:** `discuss-skill/`
**Files:**
- `SKILL.md` -- draft skill (143 lines)
**Keep or discard:** Keep as reference -- this is the template for behavioral skill conversion

---

## Next Steps

- [ ] Update exploration and research topics with behavioral archetype finding (amend Theme 1 and Topic 2)
- [ ] Design the hybrid archetype for commands like `/task` (procedural + behavioral)
- [ ] Run Phase 2 research: Topics 1-3 are now informed by both spikes
- [ ] When converting `/explore`, use reference files for its templates -- that's where the structural schemas insight lands
