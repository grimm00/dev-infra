# Exploration: AI Prompt Lifecycle

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** 2026-02-20

---

## 🎯 What We're Exploring

We don't fully understand what happens between typing a message in Cursor and receiving a response. At a general level, the mechanics of how LLM prompts are assembled, sent, and processed aren't well understood -- and at the Cursor-specific level, we don't know how our `.cursor/commands/` and `.cursor/rules/` files get injected into that process. This matters because dev-infra's command system (28 command files, some 1000+ lines) is the core product, and we're designing these files without knowing how they're actually consumed. Understanding the lifecycle could change how we structure commands, what length is effective, and whether our format is optimal.

---

## 🔍 Initial Themes

### Theme 1: General LLM Request-Response Mechanics
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->
How does a chat message become a model response? What are system prompts, user messages, assistant messages? What is a context window and how does it work? What are tokens and how do they relate to the text we write? What is "prompt engineering" at a mechanical level vs. a marketing level?

### Theme 2: Cursor IDE Prompt Assembly
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->
When you type a message in Cursor (normal chat, agent mode, or command invocation), what gets assembled before it reaches the model? How are `.cursor/rules/` files injected? How are `.cursor/commands/` injected? What about open files, git status, linter output, and other IDE context? Is there a priority system when the total context exceeds the model's window?

### Theme 3: Implications for Command Design
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->
If we understand themes 1 and 2, what does that mean for how we write our 28 commands? Are 1000+ line command files effective or wasteful? Does the model treat command content differently from rules content? Is markdown structure (headings, checklists, tables) meaningful to the model or just human-readable formatting? Should commands be optimized for token efficiency or human readability?

### Theme 4: Claude Code, Skills, and Alternative Prompt Patterns
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->
How does Claude Code's CLAUDE.md / skills system compare to Cursor's rules/commands approach? Are there mechanical differences in how instructions reach the model? Is one format more "native" to the model? What can we learn from how other AI coding tools structure their instruction systems?

---

## ❓ Key Questions

1. What is the complete anatomy of an LLM API call (system prompt, messages, parameters)?
2. How does Cursor specifically assemble context when a command is invoked?
3. What is the effective context window size and how is it allocated across rules, commands, open files, and conversation history?
4. Do 1000+ line command files get truncated, summarized, or fully included?
5. Is there a meaningful difference between how rules (`.mdc`) and commands (`.md`) are injected?
6. How do other AI coding tools (Claude Code, Aider, Continue.dev) structure their instruction injection?

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| General LLM mechanics | LOW | No | Well-documented; research is sufficient |
| Cursor prompt assembly | MEDIUM-HIGH | Consider | Cursor's internals are less documented; may need hands-on investigation |
| Command design implications | LOW | No | Follows from understanding the above |
| Claude Code / alternative patterns | MEDIUM | No | Research via documentation and examples |

**Risk framework:** HIGH = spike first (hard to pivot), MEDIUM-HIGH = consider spike, MEDIUM/LOW = research only.

---

## 🚀 Next Steps

Run `/explore ai-prompt-lifecycle --conduct` to expand this exploration.
