# Research Topics - AI Prompt Lifecycle

**Status:** ✅ Expanded
**Created:** 2026-02-20
**Expanded:** 2026-02-20

---

## 📋 Research Topics

### Topic 1: LLM API Anatomy and Context Windows

**Question:** What is the complete structure of an LLM API call, and how do context windows, token limits, and message roles work?

**Context:** This is foundational knowledge. Without understanding the API structure, we can't reason about how our command files are consumed. The goal is to understand the mechanical reality, not the marketing abstractions.

**Priority:** High

**Rationale:** Everything else depends on this. The concepts of tokens, roles, context windows, and parameters are prerequisites for understanding Cursor-specific behavior.

**Suggested Approach:**
- Review Anthropic Messages API documentation (Claude is our primary model)
- Review OpenAI Chat Completions API for comparison
- Use a tokenizer tool to measure token counts for sample content (rules file, command file)
- Document the exact structure with concrete examples

### Topic 2: Cursor IDE Prompt Assembly

**Question:** How does Cursor assemble the full prompt when a user invokes a command, and how are rules, commands, open files, and conversation history prioritized?

**Context:** We have partial answers from first-person model observation (rules in system prompt, commands in user message, open files listed by path). But we need to understand the full pipeline, especially what happens when context exceeds the window.

**Priority:** High

**Rationale:** Directly actionable -- understanding this changes how we structure rules and commands. Also the least documented of the topics.

**Suggested Approach:**
- Search Cursor documentation and changelog for context management details
- Search Cursor community forums for developer insights on prompt assembly
- Review Cursor's open-source components (if any) for context assembly logic
- Cross-reference first-person observations with documented behavior
- Consider a spike if documentation proves insufficient

### Topic 3: Command File Effectiveness at Scale

**Question:** Are long command files (500-1000+ lines) fully consumed by the model, or is there diminishing returns or truncation at certain sizes?

**Context:** Our command files range from ~100 lines (simple commands) to 1,350+ lines (the /explore command). We need to know if the model's attention degrades across these long documents, especially for instructions in the middle sections.

**Priority:** High

**Rationale:** Direct design implication -- if there's a sweet spot for command length, we should target it. If attention degrades, we should front-load critical instructions.

**Suggested Approach:**
- Research "lost in the middle" phenomenon (Liu et al., 2023 and subsequent work)
- Research long-context model attention patterns specific to Claude
- Measure token counts for our actual command files
- Compare command compliance for instructions at different positions within long commands (if empirically testable)

### Topic 4: Claude Code Instruction Architecture

**Question:** How does Claude Code's CLAUDE.md and skills system work mechanically, and how does it compare to Cursor's rules/commands injection?

**Context:** Claude Code is built by Anthropic (the model creator), so their instruction patterns likely reflect deep understanding of what works. Understanding CLAUDE.md provides both a comparison point and potential best practices.

**Priority:** Medium

**Rationale:** Important for the broader "command system prior art" question, but not directly blocking our ability to improve current commands.

**Suggested Approach:**
- Review Claude Code documentation on CLAUDE.md
- Examine open-source repos that have published CLAUDE.md files
- Compare the content structure (rules-only vs. workflow instructions)
- Document differences in injection mechanism (if available)

### Topic 5: AI Coding Tool Instruction Patterns

**Question:** What patterns do other AI coding tools (Aider, Continue.dev, Windsurf, Copilot) use for structured instructions, and are there emerging standards?

**Context:** The AI coding tool landscape is evolving rapidly. Understanding what patterns others use helps us evaluate whether our approach is novel, standard, or outdated.

**Priority:** Medium

**Rationale:** Landscape awareness -- prevents reinventing the wheel and reveals proven patterns. Lower priority because it's broad and the specific tools may have limited documentation of their internals.

**Suggested Approach:**
- Review Aider's conventions and configuration system
- Review Continue.dev's instruction/rules system
- Check Windsurf's rules/instruction approach
- Look for community comparisons of AI coding tool configuration
- Identify any convergence toward standard formats

---

## 🎯 Research Workflow

1. Use `/research ai-prompt-lifecycle --from-explore ai-prompt-lifecycle` to scaffold research
2. Start with Topic 1 (foundational, well-documented)
3. Then Topic 2 (builds on Topic 1, may need community research)
4. Topics 4-5 in parallel with Topic 3
5. After research, use `/decision ai-prompt-lifecycle --from-research` for design decisions

---

**Last Updated:** 2026-02-20
