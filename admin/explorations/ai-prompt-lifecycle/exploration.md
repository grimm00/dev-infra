# Exploration: AI Prompt Lifecycle

**Status:** ✅ Expanded
**Created:** 2026-02-20
**Expanded:** 2026-02-20

---

## 🎯 What We're Exploring

We don't fully understand what happens between typing a message in Cursor and receiving a response. At a general level, the mechanics of how LLM prompts are assembled, sent, and processed aren't well understood -- and at the Cursor-specific level, we don't know how our `.cursor/commands/` and `.cursor/rules/` files get injected into that process.

This matters because dev-infra's command system (28 command files, some 1000+ lines) is the core product, and we're designing these files without knowing how they're actually consumed. We've been optimizing for human readability and comprehensiveness, but the actual consumer is a language model operating within a fixed token budget. Understanding the lifecycle could change how we structure commands, what length is effective, and whether our format is optimal.

The motivation has a personal dimension too: this is foundational AI literacy. As someone building tools that orchestrate AI behavior, not understanding the plumbing underneath is like writing shell scripts without knowing what a process is. The goal is to fill that gap, starting from first principles and working up to the specific question of "how does Cursor consume my command files?"

---

## 🔍 Themes

### Theme 1: General LLM Request-Response Mechanics

At the most fundamental level, an LLM interaction is an API call. When you "chat" with an AI, you're not having a stateful conversation -- you're sending an HTTP request containing **the entire conversation so far** to a server, which returns a completion. There is no memory between calls; the model "remembers" because the client (Cursor, ChatGPT web UI, etc.) sends all previous messages with each new request.

**The anatomy of an API call:**

An LLM API request has three key components:

1. **System prompt** -- Instructions that set the model's behavior, persona, and constraints. This is text the user doesn't write but that shapes every response. In Cursor's case, this includes "You are an AI coding assistant" along with tool definitions, rules, and behavioral instructions.

2. **Messages array** -- An ordered list of `user` and `assistant` messages representing the conversation. Each message has a role (`system`, `user`, `assistant`, or `tool`) and content. The model sees ALL of these when generating its next response.

3. **Parameters** -- Configuration like `temperature` (randomness), `max_tokens` (response length limit), `model` (which model to use). These are set by the client application, not the user.

**Tokens and context windows:**

The model doesn't read characters or words -- it reads **tokens**. A token is roughly 3-4 English characters (so "exploration" might be 3 tokens, while "a" is 1 token). The **context window** is the total number of tokens the model can process in a single request+response. For Claude, this is currently up to 200K tokens (~150K words). Everything -- system prompt, conversation history, injected file contents, the model's own response -- must fit within this window.

The critical insight: the context window is a **hard budget**. If the total content exceeds it, something must be dropped. This is the client application's problem to solve, not the model's.

**What "prompt engineering" actually is:**

At a mechanical level, prompt engineering is writing text that will appear in the system prompt or messages array in a way that reliably produces desired model behavior. It's not magic -- it's the recognition that the model's output is a function of its input, and structuring that input well produces better output. Markdown headings, numbered lists, and clear section boundaries genuinely help the model parse structure, because models are trained on vast amounts of structured text.

**Connections:**
- The "messages array" concept directly explains why Cursor can send your conversation history, open files, and commands as part of a single request
- The context window budget means there's a real tradeoff between rich commands and room for actual conversation
- Token-based processing means 1000 lines of markdown costs real capacity that could be used for conversation context or file contents

**Implications:**
- Command length has a direct cost: every token in a command file is a token that can't be used for conversation history, file context, or the model's response
- The model sees commands as text, not as executable specifications -- the model "follows" a command because it's been trained to follow instructions, not because commands have special status
- Conversation history grows with each turn, progressively squeezing out room for other context

**Concerns:**
- We don't know exactly how Cursor manages the token budget when our commands + rules + conversation history + open files approach the window limit
- The "lost in the middle" phenomenon (documented in research) suggests models pay more attention to the beginning and end of long contexts than to the middle -- this could affect how 1000+ line commands are processed

---

### Theme 2: Cursor IDE Prompt Assembly

When you type a message in Cursor and hit send, the IDE assembles a prompt from multiple sources before sending it to the model. Based on direct observation (what I can see as the model receiving these requests), the assembled prompt includes:

**What gets injected (observed):**

1. **Cursor system instructions** -- A substantial system prompt from Cursor itself defining the model's role, available tools (Shell, Read, Write, Grep, etc.), behavioral rules, and formatting guidelines. This is NOT user-configurable -- it's Cursor's own framing.

2. **Rules files (`.cursor/rules/*.mdc`)** -- Files marked as "always applied" appear in a `<rules>` section within the system prompt. Each rule file's content is included with its filename noted. For dev-infra, all three rules files (main.mdc, workflow.mdc, template.mdc) appear to be fully included.

3. **User rules** -- Per-user configuration (from Cursor settings) injected separately.

4. **Command content** -- When a `/command` is invoked, its `.md` content appears as a `<cursor_commands>` block alongside the user's message. The full command file content is included, plus the user's additional text after the command name.

5. **IDE context** -- Open files, recently viewed files, git status (snapshot at conversation start), linter errors for edited files, terminal state, and cursor position. These appear in structured sections (`<open_and_recently_viewed_files>`, `<git_status>`, etc.).

6. **Conversation history** -- All previous user and assistant messages in the current session.

7. **Tool results** -- Outputs from tool calls (file reads, shell commands, search results) injected as they occur.

**Key structural observations:**

- **Rules are in the system prompt.** They're injected early, alongside Cursor's own instructions. This means they have high positional priority (models tend to weight earlier content more heavily).
- **Commands are in the user message.** They appear as a block within the user's turn, alongside whatever the user typed. This means they're co-located with the user's intent.
- **There is a priority/truncation system.** Open files show a `(total lines: N)` note and are listed but NOT fully included unless read with a tool. Recently viewed files are listed by path only. This suggests Cursor is selective about what gets automatically included vs. what requires explicit tool use to access.
- **Rules files appear to be fully included.** The three dev-infra rules files (~1,200 lines combined) are included in their entirety based on what I receive. This is possible because they fit within the context budget.
- **Command files appear to be fully included.** When you invoked `/explore`, the entire ~1,350 line command file was included in my context. When you invoked `/discuss`, its full ~266 lines appeared.

**What this means practically:**

The model receives: Cursor system instructions + rules files + conversation history + current user message (with command content) + IDE context metadata. All of this competes for the same context window.

**Connections:**
- Rules being in the system prompt explains why they feel "persistent" -- they're re-injected with every message
- Commands being in the user message explains why they feel "invoked" -- they appear only when you use the slash command
- The truncation patterns (file paths listed, contents not auto-loaded) show Cursor actively managing the token budget

**Implications:**
- Our three rules files (~1,200 lines) are included in EVERY message, consuming a fixed portion of the context budget whether or not they're relevant to the current task
- A 1000+ line command file is included in full when invoked, which is a significant one-time cost but doesn't persist across turns (only the turn it's invoked on, and in conversation history)
- As conversation history grows, there's less room for everything else -- this creates a natural "session degradation" where later turns have less context budget available
- The distinction between rules (system prompt, persistent) and commands (user message, per-invocation) is a meaningful architectural choice that we should design around

**Concerns:**
- At what point does Cursor start truncating rules or commands? We haven't hit this limit in practice, but with 1,200 lines of rules + a 1,350-line command + conversation history, we may be closer than we think
- Does Cursor do any summarization of conversation history in longer sessions? If so, earlier tool results and file reads may be lossy
- We don't know if Cursor's internal priority system favors rules over conversation history (or vice versa) when space runs out

---

### Theme 3: Implications for Command Design

Given what we understand from Themes 1 and 2, we can draw concrete implications for how dev-infra's 28 command files should be structured.

**On command length:**

A 1000+ line command file is not inherently wasteful IF the model receives it in full AND uses it effectively. Based on observation, Cursor does appear to include the full content. However, "receives" and "uses effectively" are different things. Research on long-context LLMs shows:

- Models can retrieve specific facts from long contexts reliably (the "needle in a haystack" test)
- But models are better at following instructions at the beginning and end of a document than in the middle
- Dense, repetitive content (like our command files' extensive error message tables and checklists) may have diminishing returns
- The model doesn't "memorize" the command -- it attends to it with varying intensity across the document

**On markdown structure:**

Markdown headings, tables, lists, and code blocks ARE meaningful to the model. Models are trained on enormous amounts of markdown-formatted text (GitHub READMEs, documentation, etc.), so they have strong priors about how to interpret markdown structure. This means:

- Headings create navigable sections the model can reference
- Tables are parsed as structured data
- Checklists signal required steps
- Code blocks signal expected output format
- This is genuinely effective -- it's not just human-readable decoration

**On the rules vs. commands distinction:**

Since rules live in the system prompt (persistent, every turn) and commands live in the user message (per-invocation), there's a design principle:

- **Rules should contain things the model needs to know for EVERY interaction** -- project identity, branching strategy, commit conventions, documentation standards
- **Commands should contain things the model needs for THIS specific task** -- step-by-step process, output templates, checklists, error handling
- Our current split roughly follows this principle, but some rules content (like the detailed release process in workflow.mdc) is only relevant during releases, yet it's included in every single turn

**On the "cathedral vs. shed" question:**

Some of our command files are comprehensive reference documents (1000+ lines with every edge case, error message, and scenario documented). This is valuable for humans but may not be optimal for the model. A possible alternative:

- **Concise command files** (~200-300 lines) with the core workflow, key rules, and output templates
- **Reference documentation** in separate files that the model can read with tools when needed
- This would reduce the per-invocation token cost while keeping the full reference accessible

**Connections:**
- The "lost in the middle" effect means command files should front-load the most critical instructions (behavior rules, mode detection, output format) and put reference material (scenarios, tips, edge cases) later
- The rules-in-system-prompt finding means we should audit what's in our rules files -- anything not needed every turn should move to commands or reference docs
- The conversation history growth pattern means long sessions with many tool calls will naturally push commands further from the model's "attention center"

**Implications:**
- Consider restructuring commands with a "critical section" (first 200 lines: what to do, how to do it, output format) and an "extended section" (remaining lines: scenarios, tips, edge cases)
- Audit rules files for content that should be command-specific rather than persistent
- Consider command length as a direct cost metric: every 100 lines is ~400-500 tokens that can't be used for conversation context
- The model doesn't need 15 example scenarios to understand a workflow -- 2-3 well-chosen examples are likely sufficient

**Concerns:**
- Shorter commands risk losing the precision that comprehensive commands provide (edge case handling, exact error messages)
- We don't have empirical data on the relationship between command length and output quality for OUR specific commands
- The "reference doc" approach adds a tool-call round trip that costs time and tokens itself

---

### Theme 4: Claude Code, Skills, and Alternative Prompt Patterns

Other AI coding tools solve the same problem -- "how do I give persistent, structured instructions to an AI coding agent?" -- with different approaches.

**Claude Code:**

Claude Code uses `CLAUDE.md` files placed in the repository root (and optionally in subdirectories). When you start a Claude Code session, these files are automatically loaded into context. Key differences from Cursor's approach:

- `CLAUDE.md` is a single file convention (not a directory of files)
- Subdirectory `CLAUDE.md` files provide scoped instructions (e.g., `frontend/CLAUDE.md` only applies when working in `frontend/`)
- There's no separate "commands" concept -- everything is instructions/rules
- Claude Code also has a `~/.claude/CLAUDE.md` for global personal preferences

The "skills" concept in Cursor refers to file-based instruction sets (often `SKILL.md` files) that can be loaded on demand. Our dev-infra repo already has skills defined (see `.cursor/skills-cursor/` in user settings). Skills are referenced in the system prompt as available resources the agent can read when relevant. They're NOT auto-injected -- the model decides whether to load them based on the task.

**Aider:**

Aider uses a `.aider.conf.yml` configuration file and an `--edit-format` system. It takes a fundamentally different approach: rather than giving the model broad instructions and letting it use tools, Aider constrains the model to a specific output format (diff format, whole file format, etc.) and handles all file operations itself. There's no equivalent to our command files because Aider's workflow is hard-coded in Python, not prompt-defined.

**The fundamental architectural question:**

Our command files are **prompt-defined workflows** -- the workflow logic lives in markdown that's injected into the model's context. The alternative is **code-defined workflows** where the workflow logic lives in application code and the model is called at specific steps with focused prompts.

| Approach | Example | Pros | Cons |
|----------|---------|------|------|
| Prompt-defined workflow | Our `.cursor/commands/` | Flexible, easy to iterate, human-readable | Consumes context, model compliance varies, no execution guarantees |
| Code-defined workflow | Aider's architecture | Precise control, smaller prompts per step, deterministic | Requires programming, harder to iterate, platform-specific |
| Hybrid | Claude Code + skills | Instructions set the frame, model decides depth | Depends on model's judgment about when to load skills |

**Connections:**
- Claude Code's `CLAUDE.md` is essentially our `.cursor/rules/` in a single file -- same concept, different format
- Claude Code's lack of a "commands" concept suggests they view workflow orchestration differently -- either it's unnecessary, or it's handled by the model's native instruction-following ability
- Aider's code-defined approach trades flexibility for reliability -- something to consider if we find prompt-defined workflows are unreliable at scale
- The skills pattern (load on demand, not auto-injected) is an interesting middle ground that could address our token budget concerns

**Implications:**
- The fact that Claude Code doesn't have a commands equivalent doesn't mean our approach is wrong -- it may mean Anthropic views the problem differently or hasn't encountered the need for multi-step workflow orchestration
- Our approach is inherently platform-dependent (Cursor's command system), while CLAUDE.md is more portable (any tool that reads repo files)
- If we ever switch platforms (or want commands to work across platforms), the prompt-defined workflow approach needs to be expressible in whatever format the new platform supports
- The skills pattern (demand-loaded reference material) is directly applicable to our "reference doc" idea from Theme 3

**Concerns:**
- We're building on Cursor's command system, which is a product feature that could change without notice
- Our 28 commands represent significant investment in a platform-specific format
- The AI coding tool landscape is moving fast -- investing more in command files increases switching costs
- We don't know whether Claude Code's simpler approach produces better or worse outcomes than our more structured approach

---

## ❓ Key Questions

### Question 1: What is the complete anatomy of an LLM API call?

**Context:** Understanding the mechanical structure of API calls is foundational to everything else. Without this, we can't reason about context windows, token budgets, or how our commands get consumed.

**Sub-questions:**
- What are the exact roles (system, user, assistant, tool) and how are they treated differently?
- How does the context window relate to the messages array?
- What parameters (temperature, top_p, max_tokens) affect output and how?
- How do tool definitions (function calling) fit into the API call structure?

**Research Approach:** Review Anthropic's and OpenAI's API documentation directly. This is well-documented territory.

### Question 2: How does Cursor specifically assemble context when a command is invoked?

**Context:** This is the most directly actionable question. We have partial answers from first-person model observation, but we need to understand the full assembly pipeline, especially truncation and priority behavior.

**Sub-questions:**
- What is the exact injection order (system prompt sections, rules, user message, command content)?
- When does truncation happen and what gets truncated first?
- Does Cursor summarize or compress conversation history in long sessions?
- How are tool results (file reads, search results) handled as the conversation grows?
- Is there a difference between Chat mode and Agent mode in terms of what gets assembled?

**Research Approach:** Combination of Cursor documentation review, community resources (Cursor forums, blog posts), and potentially a spike where we examine what the model receives under different conditions.

### Question 3: What is the effective context window size and how is it allocated?

**Context:** We know the theoretical limit (200K tokens for Claude), but the effective budget for commands is much smaller after accounting for Cursor's system prompt, rules, conversation history, and IDE context.

**Sub-questions:**
- How much of the context window does Cursor's own system prompt consume?
- How much do our three rules files (~1,200 lines) consume?
- How much does a typical command file consume?
- How much room is left for actual conversation + file context?
- Does Cursor use different models with different context windows for different features?

**Research Approach:** Empirical measurement -- we could estimate token counts for known context components using a tokenizer tool.

### Question 4: Do 1000+ line command files get fully consumed?

**Context:** We need to know if our comprehensive command files are being received and processed in full, or if there's truncation or diminishing attention at scale.

**Sub-questions:**
- Does Cursor truncate command content at a certain size?
- Does the model's attention degrade for instructions in the middle of a 1000-line document?
- Is there a "sweet spot" for command file length that balances comprehensiveness with attention quality?
- Would splitting a command into a core section + reference doc improve outcomes?

**Research Approach:** Research on long-context model attention patterns ("lost in the middle" studies), combined with practical testing of command compliance at different lengths.

### Question 5: How do rules (`.mdc`) and commands (`.md`) differ in injection?

**Context:** Our observation suggests rules go in the system prompt and commands go in the user message. This has real implications for how each should be structured.

**Sub-questions:**
- Does the system prompt vs. user message distinction affect how strongly the model follows each?
- Do models give higher weight to system prompt content?
- Should critical behavioral rules be in rules files (system prompt) rather than commands (user message)?
- What's the optimal split of content between rules and commands?

**Research Approach:** API documentation on system prompt behavior + Cursor documentation on rules/commands distinction.

### Question 6: How do other AI coding tools structure instruction injection?

**Context:** Understanding the landscape prevents reinventing the wheel and reveals proven patterns we might adopt.

**Sub-questions:**
- What does Claude Code's CLAUDE.md actually contain in real projects?
- How do Cursor skills differ from always-applied rules?
- Are there projects that have published their AI instruction configurations?
- Is there convergence toward a standard format?

**Research Approach:** Review Claude Code documentation, examine open-source projects with CLAUDE.md files, survey Cursor skill examples.

---

## 💡 Initial Thoughts

The most striking realization is that we've been building an increasingly sophisticated command system without understanding the fundamental mechanics of how it gets consumed. This is not unusual -- most software is built on abstractions we don't fully understand -- but it becomes a problem when we're making design decisions (command length, structure, content) that directly depend on those mechanics.

The first-person evidence from this very conversation is already informative: command files appear to be fully included (the `/explore` command's 1,350 lines were present), rules files are in the system prompt (persistent across turns), and Cursor actively manages what gets auto-included vs. what requires tool access. This gives us a starting point that desk research can build on.

The biggest open question isn't "do models read our commands?" (they do) but "does the model's attention degrade across a 1000-line command, and would shorter, more focused commands produce better outcomes?" This is partially answerable through research on attention patterns, but may ultimately need empirical testing with our specific commands.

**Opportunities:**
- Restructuring commands with a "critical section" front-loaded could improve model compliance at low cost
- Moving reference material (scenarios, edge cases, tips) to separate files loadable on demand could free significant context budget
- Understanding the rules-vs-commands injection difference enables more intentional design of what goes where
- This knowledge is transferable -- it applies to any AI-assisted development workflow, not just dev-infra

**Concerns:**
- Cursor's internal assembly logic is proprietary and could change at any time
- Empirical testing of command effectiveness is hard to control for (model behavior is non-deterministic)
- Over-optimizing for token efficiency could harm the human readability that makes commands maintainable
- The landscape is evolving rapidly -- findings from today may be obsolete in 6 months

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| General LLM mechanics | LOW | No | Well-documented; Anthropic and OpenAI API docs are comprehensive |
| Cursor prompt assembly | MEDIUM-HIGH | Consider | Cursor's internals are proprietary; first-person observation helps but community resources and docs needed |
| Command length effectiveness | MEDIUM | No | Research on long-context attention is available; empirical testing possible but hard to control |
| Rules vs. commands injection | MEDIUM | No | Partially answered by first-person observation; confirm with docs |
| Claude Code / alternative patterns | LOW | No | Well-documented; review CLAUDE.md docs and open-source examples |

**Risk Assessment:**

| Risk Level | Determination | Rationale |
|------------|---------------|-----------|
| HIGH | **Spike first** | Hard to pivot once committed |
| MEDIUM-HIGH | **Consider spike** | Benefits from hands-on validation |
| MEDIUM | Research only | Depends on other decisions |
| LOW | Research only | Clear path, low risk |

**Spike Candidates:**
- **Cursor prompt assembly** (MEDIUM-HIGH) -- If Cursor documentation proves insufficient, consider a spike where we systematically test what the model receives under different conditions (varying command sizes, conversation lengths, number of open files). Use `/spike cursor-context-assembly --from-explore ai-prompt-lifecycle` if research leaves gaps.

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Start with Topic 1 (LLM API Anatomy) -- it's foundational and well-documented
3. Then Topic 2 (Cursor Assembly) -- builds on Topic 1, may require community research
4. Topics 4-5 (Claude Code, other tools) can be researched in parallel with Topic 3
5. Use `/research ai-prompt-lifecycle --from-explore ai-prompt-lifecycle` to scaffold the research

---

## 🔗 Related

- **[Reflection: Command System Prior Art](../../planning/notes/reflections/reflection-command-system-prior-art-2026-02-20.md)** - Strategic assessment that motivated this exploration
- **[Workflow Simplification Exploration](../workflow-simplification/exploration.md)** - Related exploration about right-sizing the command/planning structure
- **[Cursor Rules](../../../.cursor/rules/)** - The actual rules files injected into the system prompt
- **[Cursor Commands](../../../.cursor/commands/)** - The 28 command files under investigation

---

**Last Updated:** 2026-02-20
