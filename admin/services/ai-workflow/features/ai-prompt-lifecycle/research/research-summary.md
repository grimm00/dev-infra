# Research Summary - AI Prompt Lifecycle

**Purpose:** Summary of all research findings on LLM prompt mechanics and command design  
**Status:** 🟠 In Progress  
**Created:** 2026-02-20  
**Last Updated:** 2026-02-20

---

## 📋 Research Overview

Understanding the full lifecycle of an LLM prompt -- from API structure through IDE assembly to model consumption -- to make evidence-based decisions about how dev-infra's command files should be designed.

**Research Topics:** 5 topics  
**Research Documents:** 5 documents  
**Completed:** 1 of 5

---

## 🔍 Key Findings

### Topic 1: LLM API Anatomy and Context Windows (✅ Complete)

**7 findings documented.** Key takeaways:

1. **System prompt is architecturally separate from messages.** The Anthropic API uses a top-level `system` parameter distinct from the `messages` array. This maps directly to Cursor's separation of rules (system prompt) and commands (user messages).

2. **Dev-infra content fits comfortably in context.** Rules (~12K tokens) + largest command (~11K) + Cursor overhead (~10K est.) = ~33K tokens on first turn, only 17% of the 200K window.

3. **Context pressure comes from conversation history, not command size.** Each turn accumulates input and output tokens. Agentic workflows with tool calls fill context rapidly.

4. **Prompt caching reduces cost by 90%, not effectiveness.** Cached content is fully processed by the model. Rules files become cheap after turn 1 but work identically.

5. **Claude 3.7+ returns errors (not silent truncation) at context limits.** Cursor must actively manage the budget.

**Source:** [topic-1-llm-api-anatomy.md](topic-1-llm-api-anatomy.md)

---

### Topic 2: Cursor Prompt Assembly (🔴 Not Started)

*Findings to be added after research is conducted.*

### Topic 3: Command Effectiveness at Scale (🔴 Not Started)

*Findings to be added after research is conducted.*

### Topic 4: Claude Code Architecture (🔴 Not Started)

*Findings to be added after research is conducted.*

### Topic 5: AI Tool Instruction Patterns (🔴 Not Started)

*Findings to be added after research is conducted.*

---

## 💡 Key Insights

- [x] The system/user split in the API is architectural, not cosmetic -- rules and commands serve fundamentally different roles
- [x] No single command risks truncation (~11K max vs 200K window)
- [x] The real context budget concern is conversation-level, not command-level
- [x] Token economics (caching) are decoupled from model attention/effectiveness
- [ ] How Cursor manages context as conversations grow (Topic 2)
- [ ] Whether attention degrades across long command files (Topic 3)
- [ ] How Claude Code and other tools structure their instructions (Topics 4-5)

---

## 📋 Requirements Summary

**From Topic 1:**
- FR-1: Prioritize instruction clarity over token minimization (High)
- FR-2: Position critical instructions at command file boundaries (Medium, pending Topic 3)
- NFR-1: Individual commands should remain under ~40KB (~10K tokens) (Medium)
- C-1: Context window is shared between input and output
- C-2: Conversation history grows linearly per turn
- A-4: ~4 chars/token heuristic for estimation

**See:** [requirements.md](requirements.md) for complete requirements document

---

## 🎯 Recommendations

- [x] Don't optimize command files for size alone
- [x] Front-load critical instructions (pending Topic 3 validation)
- [x] Consider conversation-level token budget for long workflows
- [x] Leverage system/user split intentionally (rules vs. commands)
- [x] Use ~4 chars/token heuristic for quick estimates

---

## 🚀 Next Steps

1. Conduct Topic 2 (Cursor Prompt Assembly)
2. Conduct Topic 3 (Command Effectiveness at Scale)
3. Conduct Topics 4-5 (landscape survey)
4. Consolidate requirements
5. Use `/decision ai-prompt-lifecycle --from-research` to make decisions

---

**Last Updated:** 2026-02-20
