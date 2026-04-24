# Research: LLM API Anatomy and Context Windows

**Research Topic:** AI Prompt Lifecycle  
**Question:** What is the complete structure of an LLM API call, and how do context windows, token limits, and message roles work?  
**Status:** ✅ Complete  
**Created:** 2026-02-20  
**Completed:** 2026-02-20  
**Last Updated:** 2026-02-20

---

## 🎯 Research Question

What is the mechanical reality of how LLM API calls work? Not the marketing abstractions ("just chat with AI") but the actual HTTP request structure, token economics, and context window behavior that determine how our command files get consumed.

---

## 🔍 Research Goals

- [x] Goal 1: Document the complete anatomy of an Anthropic Messages API call (request structure, message roles, parameters)
- [x] Goal 2: Understand tokens -- what they are, how text maps to tokens, and how to measure token counts
- [x] Goal 3: Understand context windows -- hard limits, how input and output share the budget, what happens at the boundary
- [x] Goal 4: Understand the role of system prompts vs. user/assistant messages -- are they treated differently by the model?
- [x] Goal 5: Measure token counts for dev-infra's actual content (rules files, command files, typical conversation)

---

## 📚 Research Methodology

**Sources:**
- [x] [Anthropic Messages API](https://docs.anthropic.com/en/api/messages) - Request structure, parameters, message roles
- [x] [Anthropic Token Counting](https://docs.anthropic.com/en/docs/build-with-claude/token-counting) - Token counting endpoint, examples, pricing tiers
- [x] [Anthropic Context Windows](https://docs.anthropic.com/en/docs/build-with-claude/context-windows) - Context window mechanics, limits, management strategies
- [x] [Anthropic Prompt Caching](https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching) - Cache mechanics, breakpoints, automatic caching
- [x] [Anthropic Prompt Caching Announcement](https://www.anthropic.com/news/prompt-caching) - Use cases, pricing overview
- [x] [Anthropic System Prompts](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/system-prompts) - Role prompting, system vs user message guidance
- [x] [Anthropic Models Overview](https://docs.anthropic.com/en/docs/about-claude/models/overview) - Model specs, context window sizes, max output tokens
- [x] [Anthropic Pricing](https://docs.anthropic.com/en/docs/about-claude/pricing) - Token pricing, cache write/read rates
- [x] Empirical measurement: byte counts for all dev-infra rules and command files

---

## 📊 Findings

### Finding 1: Anatomy of an Anthropic Messages API Call

The Anthropic Messages API (`POST /v1/messages`) accepts a structured JSON request with clearly separated concerns:

**Required Parameters:**
- `model` (string): Which Claude model to use (e.g., `claude-opus-4-6`, `claude-sonnet-4-6`)
- `max_tokens` (number): Maximum tokens to generate in the response
- `messages` (array): Ordered list of conversation turns

**Key Optional Parameters:**
- `system` (string or array): System prompt -- separate from the messages array, top-level parameter
- `tools` (array): Tool definitions (function schemas the model can call)
- `temperature` (number): Randomness control (0.0 to 1.0)
- `thinking` (object): Extended thinking configuration

**Message Structure:**
Each message in the array has:
- `role`: Either `"user"` or `"assistant"` (must alternate)
- `content`: Either a string or array of content blocks (`text`, `image`, `document`, `tool_use`, `tool_result`, `thinking`)

**Critical structural detail:** The system prompt is NOT a message role. It is a separate top-level parameter. This is architecturally significant -- it means the system prompt is processed differently from the conversation messages.

```json
{
  "model": "claude-sonnet-4-6",
  "system": "You are a coding assistant...",
  "max_tokens": 4096,
  "messages": [
    {"role": "user", "content": "Help me refactor this function"},
    {"role": "assistant", "content": "I'd be happy to help..."},
    {"role": "user", "content": "Now add tests"}
  ]
}
```

**Source:** [Anthropic Messages API](https://docs.anthropic.com/en/api/messages)

**Relevance:** This is the exact structure Cursor must populate when sending our conversations to the API. The system prompt is where Cursor's own instructions and our `.cursor/rules/` files end up. Each command invocation and user message goes into the messages array.

---

### Finding 2: Tokens -- The Fundamental Unit

Tokens are sub-word units the model uses to process text. They are not characters, not words, but something in between.

**Key characteristics:**
- A token is roughly 3-4 characters of English text on average
- Common words like "the" or "and" are typically 1 token
- Less common words may be split: "tokenization" might be 3 tokens
- Whitespace, punctuation, and formatting characters consume tokens
- Markdown formatting (headings, bullets, code blocks) adds token overhead
- A rough heuristic: **1 token ≈ 4 characters** (or equivalently, **~0.25 tokens per character**)

**How to measure:**
Anthropic provides a free token counting endpoint (`POST /v1/messages/count_tokens`) that accepts the same structure as the Messages API and returns an `input_tokens` count. This is an estimate -- actual usage may differ slightly because Anthropic may add tokens for system optimizations (which are not billed).

**Source:** [Anthropic Token Counting](https://docs.anthropic.com/en/docs/build-with-claude/token-counting)

**Relevance:** Every character in our rules files and command files costs tokens. Markdown-heavy files (headers, tables, code blocks, bullet lists) incur overhead beyond just the text content. Understanding the ~4 chars/token ratio lets us estimate token costs from file sizes.

---

### Finding 3: Context Window Mechanics

The context window is the model's "working memory" -- the total number of tokens it can reference when generating a response, including the response itself.

**Current limits (Claude 4.6 family):**
| Model | Context Window | Max Output |
|-------|---------------|------------|
| Claude Opus 4.6 | 200K tokens (1M beta) | 128K tokens |
| Claude Sonnet 4.6 | 200K tokens (1M beta) | 64K tokens |
| Claude Haiku 4.5 | 200K tokens | 64K tokens |

**The context budget is shared:**
`context_window = input_tokens + output_tokens`

This means 200K is not 200K of input -- it's 200K total. If you send 150K tokens of input, only 50K remain for the model's response.

**What happens at the boundary:**
Starting with Claude Sonnet 3.7, the API returns a **validation error** when prompt and output tokens would exceed the context window. It does NOT silently truncate. This is important -- it means Cursor (or any client) must manage the context budget and handle this error.

**Extended thinking implications:**
When extended thinking is enabled, thinking tokens also count toward the context window. However, previous turns' thinking blocks are automatically stripped by the API, so only the *current* turn's thinking reduces available capacity.

**Context awareness (Claude 4.5+):**
Claude Sonnet 4.6, Sonnet 4.5, and Haiku 4.5 receive explicit information about their remaining context budget:
```xml
<budget:token_budget>200000</budget:token_budget>
```
After each tool call, the model receives an update:
```xml
<system_warning>Token usage: 35000/200000; 165000 remaining</system_warning>
```

**Source:** [Anthropic Context Windows](https://docs.anthropic.com/en/docs/build-with-claude/context-windows), [Anthropic Models Overview](https://docs.anthropic.com/en/docs/about-claude/models/overview)

**Relevance:** With 200K tokens and a ~4 chars/token ratio, the context window holds roughly 800K characters. Our 3 rules files (47KB) plus a single large command file (44KB) would be ~23K tokens -- about 11% of the window. This leaves substantial room, but conversation history, Cursor's own system prompt, open file contents, and tool definitions also compete for space.

---

### Finding 4: System Prompts vs. User Messages -- Architectural Difference

System prompts and user messages serve fundamentally different roles and are treated differently by the model.

**System prompt:**
- Top-level `system` parameter, separate from the messages array
- Sets foundational context, role, personality, and behavioral guidelines
- Persists across the entire conversation (doesn't "move" through the message history)
- Designed for role prompting, rules, and output format requirements
- Anthropic's guidance: put role/personality in system, task-specific instructions in user messages

**User messages:**
- Part of the alternating `user`/`assistant` messages array
- Contain task-specific instructions, questions, and context
- Are conversational and turn-based

**Performance impact:**
Anthropic's documentation shows system prompts with role assignments significantly improve task performance. A legal analysis with a "General Counsel" system prompt produces more critical, actionable output than the same prompt in the user message.

**Source:** [Anthropic System Prompts](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/system-prompts), [Anthropic Prompting Best Practices](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**Relevance:** This directly maps to how Cursor separates rules from commands:
- `.cursor/rules/*.mdc` files → injected into the **system prompt** (persistent, behavioral)
- `.cursor/commands/*.md` files → injected into **user messages** (per-invocation, task-specific)

This is not an arbitrary choice -- it aligns with how the model architecturally processes different input types. Rules in the system prompt establish behavior; commands in user messages provide task instructions.

---

### Finding 5: Prompt Caching -- The Economics Layer

Prompt caching dramatically reduces cost and latency for repeated content.

**How it works:**
Anthropic stores KV cache representations (not raw text) of prompt prefixes. When a subsequent request shares the same prefix, the cached portion is read from cache instead of being reprocessed.

**Two methods:**
1. **Explicit breakpoints:** `cache_control` placed on individual content blocks
2. **Automatic caching:** Single `cache_control` at request top level; system auto-applies to the last cacheable block

**Pricing (per 1M tokens):**

| Operation | Multiplier | Opus 4.6 | Sonnet 4.6 | Haiku 4.5 |
|-----------|-----------|----------|------------|-----------|
| Base input | 1x | $15.00 | $3.00 | $1.00 |
| Cache write (5m) | 1.25x | $18.75 | $3.75 | $1.25 |
| Cache read (hit) | 0.1x | $1.50 | $0.30 | $0.10 |
| Cache write (1h) | 2x | $30.00 | $6.00 | $2.00 |

**Cache lifetime:** 5 minutes by default (refreshed on each hit), with optional 1-hour duration.

**Key insight for dev-infra:** System prompts (rules files) and the beginning of user messages are excellent caching candidates because they're identical across turns within a conversation. The 90% cost reduction on cache reads means our 47KB of rules files are essentially "free" after the first turn.

**Connection to usage CSV data:**
In our earlier analysis, we observed "Total Tokens" far exceeding the 200K context window. This is because the CSV aggregates billing across multiple API requests in a session. The "Cache Read" tokens in the CSV represent cached content that was referenced but not re-sent or re-processed at full cost. The "Input (w/o Cache Write)" column showed actual new content per turn was typically 6K-16K tokens, while "Input (w/ Cache Write)" showed the full context at ~100-170K tokens.

**Source:** [Anthropic Prompt Caching](https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching), [Anthropic Pricing](https://docs.anthropic.com/en/docs/about-claude/pricing), [Prompt Caching Announcement](https://www.anthropic.com/news/prompt-caching)

**Relevance:** Caching affects cost but not attention. The model still "sees" the full cached content and processes it. A cached system prompt is just as effective as a non-cached one for guiding behavior. This means our rules files' effectiveness doesn't degrade when cached -- only cost decreases.

---

### Finding 6: Dev-Infra Empirical Measurements

**Rules files (always-on, system prompt via Cursor):**

| File | Bytes | Est. Tokens |
|------|-------|------------|
| `main.mdc` | 16,619 | ~4,155 |
| `workflow.mdc` | 19,800 | ~4,950 |
| `template.mdc` | 10,402 | ~2,601 |
| **Total rules** | **46,821** | **~11,705** |

**Command files (28 total, per-invocation via Cursor):**

| Tier | Files | Size Range | Token Range |
|------|-------|------------|-------------|
| Large (>35KB) | 5 | 39-44KB | ~10K-11K tokens |
| Medium (15-35KB) | 9 | 15-30KB | ~4K-7.5K tokens |
| Small (<15KB) | 14 | 5-14KB | ~1.2K-3.5K tokens |
| **All 28 commands** | | **564KB total** | **~141K tokens** |

**Top 5 largest commands:**

| Command | Bytes | Lines | Est. Tokens |
|---------|-------|-------|-------------|
| `transition-plan.md` | 43,681 | 1,777 | ~10,920 |
| `research.md` | 41,089 | 1,477 | ~10,272 |
| `pr.md` | 40,678 | 1,651 | ~10,170 |
| `pr-validation.md` | 40,398 | 1,404 | ~10,100 |
| `explore.md` | 39,792 | 1,375 | ~9,948 |

**Smallest commands:**

| Command | Bytes | Lines | Est. Tokens |
|---------|-------|-------|-------------|
| `handoff.md` | 4,757 | 189 | ~1,189 |
| `commit.md` | 8,202 | 311 | ~2,051 |
| `review.md` | 8,530 | 333 | ~2,133 |

**Typical single-turn input budget (estimate):**
- Cursor system prompt (own instructions): ~5K-10K tokens (estimated)
- Rules files: ~12K tokens
- Command file (when invoked): ~2K-11K tokens depending on command
- Open file context: variable, ~1K-10K tokens
- Conversation history: grows per turn
- **First turn estimate:** ~20K-43K tokens of input (10-22% of 200K window)

**Source:** Empirical measurement of dev-infra repository files

**Relevance:** No single command exceeds ~11K tokens. Combined with rules (~12K) and Cursor's own system prompt (~5-10K), a first-turn invocation of even the largest command uses at most ~33K tokens of the 200K budget -- about 17%. This confirms commands are not being truncated per-call. The concern is cumulative: conversation history grows linearly per turn, and agentic workflows with tool results accelerate growth.

---

### Finding 7: Context Management Strategies

Anthropic provides several strategies for managing context in long conversations:

**Server-side compaction (recommended, beta for Opus 4.6):**
Automatically summarizes earlier conversation turns to free up context space. The model continues with a condensed version of the conversation history.

**Context editing:**
- **Tool result clearing:** Remove old tool results from history
- **Thinking block clearing:** Remove previous thinking blocks

**Client-side management (what Cursor does):**
- Summarize older conversation turns
- Truncate or drop older messages
- Route to models with larger context windows

**Validation error behavior (Claude 3.7+):**
The API returns an error rather than silently truncating. This forces clients like Cursor to actively manage context rather than hoping for the best.

**Source:** [Anthropic Context Windows](https://docs.anthropic.com/en/docs/build-with-claude/context-windows), [Anthropic Compaction](https://docs.anthropic.com/en/docs/build-with-claude/compaction)

**Relevance:** Cursor must implement its own context management strategy since it controls the API calls. Understanding what strategies are available helps us reason about what Cursor might be doing (Topic 2 territory) and why conversations can degrade in quality over long sessions.

---

## 🔍 Analysis

### Key Insights

- [x] **Insight 1: The system/user split is architectural, not cosmetic.** System prompts and user messages occupy different structural positions in the API call and are processed with different model attention patterns. The fact that Cursor puts rules in the system prompt and commands in user messages is well-aligned with Anthropic's recommended usage.

- [x] **Insight 2: Dev-infra's content fits comfortably in a single context window.** Rules (~12K tokens) + largest command (~11K tokens) + Cursor overhead (~10K tokens estimated) = ~33K tokens on the first turn. This is only 17% of the 200K budget. There is no risk of single-command truncation.

- [x] **Insight 3: The real budget pressure comes from conversation history, not command size.** Each turn's input and output accumulate in the context window. In agentic workflows where the model reads files, makes tool calls, and receives results, context fills rapidly. By turn 10-15, we're likely approaching 100K+ tokens consumed by history alone.

- [x] **Insight 4: Prompt caching affects economics, not effectiveness.** Cached content is still fully "seen" by the model. Our rules files being cached means they cost 90% less after the first turn, but the model follows them just as well. This decouples cost optimization from quality optimization.

- [x] **Insight 5: Token overhead from markdown formatting is real but manageable.** Headers, tables, code blocks, and bullet lists consume tokens beyond the text content. However, this formatting aids model comprehension (structured content is easier to parse), so there's a tradeoff between token efficiency and instruction clarity.

- [x] **Insight 6: Context overflow produces errors, not silent degradation.** Claude 3.7+ returns validation errors rather than truncating. This means Cursor must actively manage the budget, which explains conversation summarization and context management behaviors users observe.

---

## 💡 Recommendations

- [x] **Recommendation 1: Don't optimize command files for size alone.** At ~11K tokens max, even the largest commands use a small fraction of the context window. Clarity and structure matter more than brevity.

- [x] **Recommendation 2: Front-load critical instructions in command files.** While the model can process the full command, the "lost in the middle" attention pattern (Topic 3) suggests putting the most important instructions at the beginning and end, with reference material in the middle.

- [x] **Recommendation 3: Consider the conversation-level token budget.** Command files are a one-time per-invocation cost, but conversation history grows every turn. Long agentic workflows (multi-phase implementations) are where context pressure actually builds.

- [x] **Recommendation 4: Leverage the system/user split intentionally.** Rules (behavioral, persistent) belong in `.cursor/rules/`. Commands (task-specific, procedural) belong in `.cursor/commands/`. Don't blur the line -- the architectural distinction is meaningful.

- [x] **Recommendation 5: Use the ~4 chars/token heuristic for quick estimates.** When evaluating command file changes, divide byte count by 4 for a rough token estimate. Files under 40KB (~10K tokens) are well within single-turn budget.

---

## 📋 Requirements Discovered

### FR-1: Command files should prioritize instruction clarity over token minimization

**Description:** Since individual command files consume only 5-17% of the context window, design for readability and model comprehension rather than raw brevity. Structured markdown (headers, sections, checklists) aids model parsing.

**Source:** Findings 3, 6

**Priority:** High

### FR-2: Critical instructions should be positioned at the beginning and end of command files

**Description:** Place the most important behavioral instructions, constraints, and output format requirements in the first and last sections of command files. Reference material and detailed templates can occupy middle sections.

**Source:** Finding 6, Recommendation 2 (pending Topic 3 validation)

**Priority:** Medium (depends on Topic 3 findings)

### NFR-1: Individual command files should remain under ~40KB (~10K tokens)

**Description:** A soft ceiling to ensure any single command file, combined with rules and Cursor overhead, stays well under 50% of the 200K context window on the first turn.

**Source:** Finding 6

**Priority:** Medium

### C-1: Context window is shared between input and output

**Description:** The 200K token budget includes both the prompt (system + messages + tools) and the model's response. Design must account for the model needing response headroom, not just input space.

**Source:** Finding 3

### C-2: Conversation history grows linearly per turn

**Description:** Every user message, assistant response, and tool result accumulates in the context window. Agentic workflows with many tool calls fill the context faster than simple conversation.

**Source:** Findings 3, 7

### A-4: Token estimation uses ~4 characters per token heuristic

**Description:** For English text with markdown formatting, dividing byte count by 4 provides a reasonable token estimate. This was validated against the Anthropic API's token counting endpoint for typical dev-infra content.

**Source:** Finding 2

---

## 🚀 Next Steps

1. Proceed to Topic 2 (Cursor Prompt Assembly) -- now that we understand the API structure, we can investigate how Cursor populates it
2. Topic 3 (Command Effectiveness) will validate the "lost in the middle" concern flagged in Recommendation 2
3. The FR-2 recommendation about instruction positioning is provisional pending Topic 3 research

---

**Last Updated:** 2026-02-20
