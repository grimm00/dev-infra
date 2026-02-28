# Project Reflection - Command System Prior Art & Strategic Direction

**Scope:** Strategic assessment of dev-infra's command system against emerging AI coding ecosystem  
**Period:** v0.1.0 through v0.9.0 (full project history, with focus on recent production learnings)  
**Generated:** 2026-02-20

---

## 📊 Current State

### What Prompted This Reflection

Production work in a separate environment created a perspective shift. Working with real projects -- not just templates -- surfaced the question: **does the command system we've built already exist somewhere, maintained by someone with more resources and broader testing?**

This isn't a crisis of confidence. It's the natural maturity signal at v0.9.0 with 28 command files, some over 1,000 lines, defining multi-step workflows with state machines, inter-command contracts, and output templates.

### By the Numbers

- **Commands:** 28 workflow command files in `.cursor/commands/`
- **Rules:** 3 rule files in `.cursor/rules/` (~1,200 lines combined)
- **Releases:** 9 versions (v0.1.0 through v0.9.0)
- **Tests:** 110+ Bats tests
- **Template Types:** 2 (standard-project, learning-project)
- **Active Exploration:** Workflow simplification (on `feat/workflow-simplification` worktree)

### The Strategic Question

The commands are the core product of dev-infra as a template factory. They define a full pipeline: `/explore` -> `/spike` -> `/research` -> `/decision` -> `/transition-plan` -> `/task-phase` -> `/review` -> `/commit` -> `/pr`. If a framework or tool already provides this orchestration layer -- or is converging toward it -- the project needs to know before investing further.

---

## ✅ What's Working Well

### Production-to-Template Pipeline

**Pattern:** Commands born in production environments get generalized into dev-infra templates.  
**Evidence:** All 4 commands added in v0.9.0 (spike, review, commit, handoff) originated from real production needs.  
**Assessment:** This pipeline is genuinely valuable regardless of whether the command format changes.

### Workflow Pipeline Sophistication

**Pattern:** The explore -> research -> decision pipeline with feedback loops (amend, add-topic, consolidate) represents genuine domain-specific workflow design.  
**Assessment:** This is not something generic "AI instruction" tools provide. The workflow orchestration layer is distinct from rules/skills.

### Discussion as a Lateral Tool

**Pattern:** `/discuss` fills a real gap -- the ability to engage with AI without triggering artifact creation.  
**Assessment:** This addresses a genuine problem in agentic coding (premature formalization) that most frameworks don't acknowledge.

---

## 🔴 Key Strategic Question: What Layer Are We Operating At?

The command system exists at the intersection of three layers. Understanding which layer is genuinely novel (vs. reinventing the wheel) is the most important strategic question.

### Layer 1: AI Instruction (Rules, Prompts, Behavior Guidance)

**What we have:** `.cursor/rules/` files (main.mdc, workflow.mdc, template.mdc) -- project-level persistent instructions.

**What exists elsewhere:**
- **Claude Code: `CLAUDE.md`** -- Project-level markdown instructions loaded into every conversation. Functionally similar to our `.cursor/rules/` files.
- **Claude Code: "Skills"** -- Reusable instruction patterns. May be modular equivalents of what we encode in rules files.
- **Cursor: `.cursor/rules/`** -- The platform we're already using.
- **Aider: Conventions files** -- Similar concept, different format.
- **Windsurf: Rules** -- Similar concept.

**Assessment:** This layer is actively being standardized across platforms. Our rules files are solid but not unique. If a more battle-tested format emerges, adopting it would be straightforward.

**Risk:** Low. Rules are portable concepts regardless of format.

### Layer 2: Workflow Orchestration (Multi-Step Processes with State and Inter-Command Contracts)

**What we have:** 28 command files defining a complete development pipeline with:
- Mode detection (setup/conduct/amend)
- State transitions (scaffolding -> expanded -> amended)
- Inter-command contracts (explore's output feeds research's input)
- Feedback loops (research amends explorations)
- Quality gates (consolidation before decisions)
- Output templates with checklists

**What exists elsewhere:**
- **Claude Code:** No equivalent workflow orchestration (as of current knowledge)
- **Cursor commands:** The platform feature we're using, but the platform provides the mechanism, not the workflow content
- **Emerging frameworks:** Unknown -- this is the area needing investigation

**Assessment:** This is the layer most likely to be genuinely novel. The question is whether the AI coding ecosystem is converging toward workflow orchestration tools, or whether this remains a project-specific concern.

**Risk:** Medium-High. If something better exists, we've invested significantly in a bespoke solution. If nothing exists, we're ahead of the curve.

### Layer 3: Template Generation (Output Format Specifications)

**What we have:** Detailed output templates embedded in commands (exploration scaffolding, research documents, ADR formats, transition plans).

**What exists elsewhere:** Always project-specific. No framework will prescribe exploration or ADR formats.

**Assessment:** This layer is inherently custom. Not a concern for prior art.

**Risk:** None. This is always project-specific.

---

## 💡 Three Investigation Areas Identified

### Area A: Claude Code Ecosystem (Skills, CLAUDE.md, Agent Patterns)

**What to learn:**
- What exactly are Claude Code "skills"? Are they modular instruction sets or something more programmatic?
- How does `CLAUDE.md` differ from Cursor's `.cursor/rules/` in terms of model integration (does the model natively understand the format vs. treating it as injected context)?
- Is there a workflow orchestration layer in Claude Code, or is it purely rules-based?
- What is `agent.md`? Is it a superseded concept or something distinct from `CLAUDE.md`?

**Why this matters:** Claude Code may be the closest analog to what we're building. If their "skills" system provides workflow orchestration, our 28 commands might map to a more standardized format. If skills are just modular rules, our workflow layer remains distinct.

**Possible outcomes:**
1. **Skills ≈ our rules** -- Adopt format insights but our commands remain distinct
2. **Skills ≈ our commands** -- Significant overlap; evaluate migration
3. **Skills > our commands** -- More robust, tested, machine-parseable; adopt and adapt
4. **Skills < our commands** -- We've built something more sophisticated; continue independently

### Area B: Cursor IDE Request-Response Cycle

**What to learn:**
- When `/explore workflow-simplification --conduct` is invoked, what exactly gets assembled into the context window?
- How do command files get injected? (system prompt? user message? tool definition?)
- What's the token budget? How much of our 1,000+ line command files actually reaches the model?
- Do rules and commands compete for context space?
- Is there a priority/truncation system when context exceeds limits?

**Why this matters:** This is foundational knowledge. If our command files are being truncated before the model sees them, we're optimizing the wrong thing. If the full content reaches the model, understanding the injection mechanism informs how to structure commands for maximum effectiveness.

**Understanding this changes how we evaluate everything else:**
- If commands are injected as system prompts, format matters (markdown structure, heading hierarchy)
- If commands are injected as user messages, conversational framing matters
- If there's a token budget, command length directly affects quality
- If rules and commands share context space, there's a tradeoff between rich rules and rich commands

### Area C: Prior Art in AI Coding Workflow Frameworks

**What to learn:**
- Are there open-source projects that define multi-step AI coding workflows?
- Do any projects implement explore -> research -> decide -> implement pipelines?
- Are there "workflow-as-prompt" frameworks that orchestrate AI coding agents?
- How do projects like Aider, Continue.dev, or others handle structured development workflows?
- Are there academic or industry papers on structured AI-assisted development processes?

**Why this matters:** If no one else is building workflow orchestration for AI coding, we're either ahead of the curve or solving a problem only we have. If others are building it, we should learn from their patterns and potentially contribute to or adopt their approaches.

**Possible outcomes:**
1. **No prior art** -- Our approach is novel; consider documenting/sharing it
2. **Partial overlap** -- Some projects handle parts of what we do; evaluate integration
3. **Strong prior art** -- An existing framework handles most of what our commands do; evaluate adoption
4. **Divergent approaches** -- Others solve the same problem differently; evaluate which approach scales better

---

## 🎯 Recommended Investigation Approach

### Suggested Order: B -> A -> C

**Rationale:**

1. **Start with B (request-response cycle)** because it's foundational. Understanding how your commands get consumed by the model changes how you evaluate everything else. This is also the most contained investigation -- it's about understanding a specific technical mechanism.

2. **Then A (Claude Code ecosystem)** because it's the closest analog. Claude Code is built by Anthropic (the model provider), so their patterns likely reflect deep understanding of what works. This investigation is bounded -- it's one product to study.

3. **Finally C (broader prior art)** because it's the broadest search and benefits from context gained in A and B. After understanding how commands are consumed (B) and what the closest analog does (A), the prior art search becomes more focused.

### Investigation Format

Each area could be approached as:
- **Area B:** Focused research or spike (technical investigation, ~2-4 hours)
- **Area A:** Exploration with potential spike (study Claude Code docs/examples, ~1 day)
- **Area C:** Broader exploration then targeted research (~2-3 days)

### What This Is NOT

This investigation is not about abandoning the command system. It's about:
- Understanding the landscape before further investment
- Identifying patterns worth adopting
- Validating that the workflow orchestration layer is genuinely distinct
- Finding the right level of abstraction for commands going forward

---

## 🔍 Connection to Workflow Simplification

The `feat/workflow-simplification` worktree is already investigating whether the feature/phase/task hierarchy is over-engineered. This reflection adds a meta-layer: **is the command format itself the right abstraction?**

These two investigations are complementary:
- **Workflow simplification** asks: "Is the workflow right-sized?"
- **Prior art investigation** asks: "Is the workflow format right?"

Both could inform v0.10.0 planning. Workflow simplification may flatten the hierarchy (transition plan replaces feature plans), while prior art investigation may change how those flattened commands are expressed.

**Timing consideration:** The prior art investigation (especially Area B) might usefully precede further workflow simplification implementation, since understanding how commands are consumed could change what "simplified" means in practice.

---

## 📈 The Broader Pattern: Production-Driven Maturity

This reflection itself is evidence of a healthy pattern. The project has evolved through several phases:

1. **v0.1.0-v0.5.0:** Building the foundation (templates, scripts, CI/CD)
2. **v0.5.0-v0.7.0:** Adding sophistication (commands, workflows, release automation)
3. **v0.8.0-v0.9.0:** Integrating production learnings (worktree workflow, spike, review/commit)
4. **Now:** Stepping back to ask "are we building the right thing?" -- informed by production experience

Phase 4 is the most strategically important. The impulse to slow down and look around rather than add the 29th command is the right instinct. The ecosystem is moving fast, and what was novel 6 months ago may now be table stakes -- or still genuinely ahead of the curve. The only way to know is to look.

---

## 🚀 Suggested Next Steps

1. **Immediate:** Use this reflection as the basis for an `/explore` scaffolding on "command-system-prior-art" or similar topic
2. **Area B first:** Investigate Cursor's request-response cycle (smallest scope, foundational knowledge)
3. **Area A second:** Study Claude Code's skills/CLAUDE.md system (bounded investigation, closest analog)
4. **Area C third:** Broader prior art search (benefits from A+B context)
5. **Synthesize:** After all three, decide whether the command format needs evolution, adoption of external patterns, or validation that the current approach is sound

---

**Last Updated:** 2026-02-20  
**Next Reflection:** After completing the three investigation areas
