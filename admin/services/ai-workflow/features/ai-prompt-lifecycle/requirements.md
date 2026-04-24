# Requirements - AI Prompt Lifecycle

**Source:** Research on AI prompt lifecycle and command design implications  
**Status:** Draft  
**Created:** 2026-02-20  
**Last Updated:** 2026-02-20

---

## 📋 Overview

This document captures requirements discovered during research on LLM prompt mechanics and their implications for dev-infra command design.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Command File Clarity Over Minimization

**Description:** Command files should prioritize instruction clarity over token minimization. Since individual command files consume only 5-17% of the context window, design for readability and model comprehension rather than raw brevity. Structured markdown (headers, sections, checklists) aids model parsing.

**Source:** [topic-1-llm-api-anatomy.md](topic-1-llm-api-anatomy.md) - Findings 3, 6

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Critical Instruction Positioning

**Description:** Place the most important behavioral instructions, constraints, and output format requirements in the first and last sections of command files. Reference material and detailed templates can occupy middle sections.

**Source:** [topic-1-llm-api-anatomy.md](topic-1-llm-api-anatomy.md) - Finding 6, Recommendation 2

**Priority:** Medium (pending Topic 3 validation of "lost in the middle" concern)

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Command File Size Ceiling

**Description:** Individual command files should remain under ~40KB (~10K tokens) to ensure any single command, combined with rules and Cursor overhead, stays well under 50% of the 200K context window on the first turn.

**Source:** [topic-1-llm-api-anatomy.md](topic-1-llm-api-anatomy.md) - Finding 6

**Priority:** Medium

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Shared Context Budget

**Description:** The 200K token context window is shared between input (system prompt + messages + tools) and output (model response). Design must account for the model needing response headroom, not just input space.

**Source:** [topic-1-llm-api-anatomy.md](topic-1-llm-api-anatomy.md) - Finding 3

---

### C-2: Linear Context Growth

**Description:** Every user message, assistant response, and tool result accumulates in the context window. Agentic workflows with many tool calls fill the context faster than simple conversation.

**Source:** [topic-1-llm-api-anatomy.md](topic-1-llm-api-anatomy.md) - Findings 3, 7

---

## 💭 Assumptions

### A-1: Claude is the Primary Model

**Description:** Dev-infra commands are primarily consumed by Claude models (Sonnet, Opus) through Cursor IDE. Research prioritizes Claude-specific behavior, though findings should be model-aware.

**Source:** Project context

### A-2: Cursor is the Primary IDE

**Description:** Command files are consumed through Cursor IDE's prompt assembly pipeline. While commands are markdown (portable), the injection mechanism is Cursor-specific.

**Source:** Project context

### A-3: Prompt Caching is Active

**Description:** Cursor uses Anthropic's prompt caching, meaning large unchanged prompt sections (rules, commands) are likely cached. This affects token economics but not attention behavior.

**Source:** Usage CSV analysis (2026-02-20 discussion)

### A-4: Token Estimation Heuristic

**Description:** For English text with markdown formatting, dividing byte count by 4 provides a reasonable token estimate (~4 characters per token). Validated against typical dev-infra content structure.

**Source:** [topic-1-llm-api-anatomy.md](topic-1-llm-api-anatomy.md) - Finding 2

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Documents](README.md)
- [Exploration](../../explorations/ai-prompt-lifecycle/exploration.md)

---

## 🚀 Next Steps

1. Extract requirements as research topics are conducted
2. Use `/research ai-prompt-lifecycle --consolidate` after all topics complete
3. Use `/decision ai-prompt-lifecycle --from-research` to make decisions

---

**Last Updated:** 2026-02-20
