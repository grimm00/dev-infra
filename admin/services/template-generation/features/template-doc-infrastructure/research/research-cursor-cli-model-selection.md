# Research: Cursor CLI Programmatic Invocation & Model Selection

**Research Topic:** Template Doc Infrastructure  
**Question:** How should scripts invoke Cursor programmatically with model selection based on task type?  
**Status:** ✅ Complete (Limited - Implementation Investigation Needed)  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-14

---

## 🎯 Research Question

How can workflow orchestration scripts invoke Cursor (or other AI tools) programmatically, passing context and selecting optimal models based on task type? This enables the full hybrid architecture where scripts handle structure/context and AI handles creative content.

---

## 🔍 Research Goals

- [x] Goal 1: Investigate Cursor CLI capabilities for agent invocation
- [x] Goal 2: Determine how to pass context (files, manifests) to AI via CLI
- [x] Goal 3: Determine how to select models via CLI flags or configuration
- [x] Goal 4: Evaluate alternative tools for programmatic AI invocation
- [x] Goal 5: Design model selection configuration for task types

---

## 📚 Research Methodology

**Sources:**
- [x] Cursor CLI usage in codebase (`scripts/worktrees.sh`, `scripts/shell-functions.sh`)
- [x] Cursor documentation review (limited public API documentation)
- [x] Alternative tools evaluation (Aider, Claude API, LLM CLI)
- [x] MCP (Model Context Protocol) pattern analysis

---

## 🎯 Model Selection Context

**From Discussion - Task Type → Model Mapping:**

| Task Type                    | Model            | Reasoning               |
| ---------------------------- | ---------------- | ----------------------- |
| explore, research, decision  | claude-opus-4    | Deep thinking, analysis |
| naming, creative             | gemini-2.5-pro   | Divergent creativity    |
| pr, post-pr, release-prep    | claude-sonnet-4  | Structured, routine     |
| task-phase, implement        | composer-1       | Code implementation     |

---

## 📊 Findings

### Finding 1: Cursor CLI is Limited to File/Project Opening

**Current Cursor CLI capabilities:**

```bash
# What's possible today:
cursor /path/to/project     # Open project in Cursor
cursor /path/to/file.ts     # Open file in Cursor
cursor --help               # Limited options
```

**What's NOT available (as of research date):**
- No `--model` flag for model selection
- No `--prompt` flag for agent invocation
- No `--context` flag for passing file manifests
- No headless/non-interactive mode for agent tasks
- No public API for programmatic agent execution

**Source:** Codebase analysis (`scripts/worktrees.sh`, `scripts/shell-functions.sh`)

**Relevance:** Cursor's current CLI cannot directly support our desired workflow.

---

### Finding 2: MCP Pattern is Tool-TO-AI, Not AI-FROM-Script

**MCP (Model Context Protocol) purpose:**

```
┌─────────────────────────────────────────────────────────┐
│ MCP Architecture (Current)                              │
│                                                         │
│  Cursor AI Agent  ────────→  MCP Server                 │
│       │                         │                       │
│       │ (AI invokes tool)       │ (Tool provides data)  │
│       ▼                         ▼                       │
│   "browser_navigate"      Returns page content          │
└─────────────────────────────────────────────────────────┘

What we want:

┌─────────────────────────────────────────────────────────┐
│ Desired Architecture (Script → AI)                      │
│                                                         │
│  Shell Script  ──────────→  AI Agent                    │
│       │                         │                       │
│       │ (Script invokes AI)     │ (AI returns content)  │
│       ▼                         ▼                       │
│  dt-doc-gen explore         Returns exploration.md      │
└─────────────────────────────────────────────────────────┘
```

MCP provides tools TO the AI, not programmatic invocation OF the AI.

**Source:** MCP pattern analysis, Cursor documentation

**Relevance:** MCP doesn't solve our programmatic invocation need.

---

### Finding 3: Alternative Tools Exist with CLI Model Selection

**Aider (aider-chat):**

```bash
# Model selection via CLI
aider --model claude-3-opus-20240229 --files file1.py file2.py

# Model selection via config
# .aider.model: claude-3-opus-20240229
```

**Features:**
- `--model` flag for model selection
- `--files` for context passing
- `--message` for non-interactive prompts
- Watch mode for file changes
- Git integration built-in

**LLM CLI (llm Python package):**

```bash
# Model selection
llm -m gpt-4 "prompt here"
llm -m claude-3-opus "analyze this" < file.txt

# Can pipe context
cat context.md | llm -m claude-3-sonnet "fill in placeholders"
```

**Claude API (direct):**

```bash
# Via curl
curl -X POST https://api.anthropic.com/v1/messages \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{"model": "claude-opus-4-20250514", "messages": [...]}'
```

**Source:** Alternative tool documentation

**Relevance:** Alternative tools provide the programmatic model selection we need.

---

### Finding 4: Hybrid Architecture Requires External AI Invocation

Given Cursor's CLI limitations, the hybrid architecture needs adaptation:

**Option A: Stay in Cursor (Current Commands)**

```
┌────────────────────────────────────────────────────────────┐
│  Cursor Command (e.g., /explore)                           │
│  - Commands invoke scripts for structure                   │
│  - AI fills content interactively (no model selection)     │
│  - Human triggers workflow via command                     │
└────────────────────────────────────────────────────────────┘
```

**Limitation:** No programmatic model selection - uses whatever model is configured in Cursor settings.

**Option B: External CLI Tool (Aider/LLM)**

```
┌────────────────────────────────────────────────────────────┐
│  Shell Script (dt-workflow)                                │
│  - Script generates structure                              │
│  - Script invokes aider/llm with --model flag              │
│  - AI fills content programmatically                       │
│  - Script validates and commits                            │
└────────────────────────────────────────────────────────────┘
```

**Benefit:** Full programmatic control, model selection per task.
**Tradeoff:** Requires external tool installation, API keys.

**Option C: Hybrid (Commands + Future Cursor API)**

```
┌────────────────────────────────────────────────────────────┐
│  Current: Commands handle workflow, AI fills interactively │
│  Future:  When Cursor exposes API, migrate to programmatic │
│  Strategy: Abstract model selection in config for future   │
└────────────────────────────────────────────────────────────┘
```

**Source:** Architecture analysis

**Relevance:** Must choose practical path given Cursor limitations.

---

### Finding 5: Model Selection Configuration Pattern

Regardless of invocation method, model selection can be configured:

**Configuration file pattern (`~/.config/dt-workflow/models.yaml`):**

```yaml
# Task type to model mapping
task_models:
  # Deep thinking tasks
  explore: claude-opus-4-20250514
  research: claude-opus-4-20250514
  decision: claude-opus-4-20250514
  
  # Creative tasks
  naming: gemini-2.5-pro
  creative: gemini-2.5-pro
  
  # Routine tasks
  pr: claude-sonnet-4-20250514
  post-pr: claude-sonnet-4-20250514
  release-prep: claude-sonnet-4-20250514
  
  # Code implementation
  task-phase: composer-1
  implement: composer-1

# Fallback model
default: claude-sonnet-4-20250514
```

**Script usage:**

```bash
#!/bin/bash
# dt-model-select: Get model for task type

TASK_TYPE="$1"
MODEL=$(yq ".task_models.$TASK_TYPE // .default" ~/.config/dt-workflow/models.yaml)
echo "$MODEL"
```

**Source:** Configuration pattern design

**Relevance:** Enables model selection regardless of invocation method.

---

### Finding 6: Recommended Path Forward

Given current limitations:

| Phase | Approach | Model Selection |
|-------|----------|-----------------|
| **Phase 1 (Now)** | Commands + Cursor interactive | Via Cursor settings (manual) |
| **Phase 2 (Near-term)** | Commands + config file | Config specifies preferred model |
| **Phase 3 (Future)** | Scripts + external tool OR Cursor API | Programmatic selection |

**Phase 1 (Now):** Continue with Cursor commands. Document model recommendations in command docs. Users manually select model in Cursor settings.

**Phase 2 (Near-term):** Create `models.yaml` config. Commands can suggest model via comment/message. User still manually switches.

**Phase 3 (Future):** When tooling is ready (Cursor API or external tool), scripts invoke AI programmatically with model selection.

**Source:** Strategic analysis

**Relevance:** Provides incremental path that doesn't block current work.

---

## 🔍 Analysis

**Key Insights:**
- [x] **Insight 1:** Cursor CLI is file-open only - no agent invocation API
- [x] **Insight 2:** MCP is tool-TO-AI, not script-TO-AI - wrong direction
- [x] **Insight 3:** Alternative tools (Aider, LLM CLI, Claude API) provide what we need
- [x] **Insight 4:** Config-based model selection can be implemented now, invocation later
- [x] **Insight 5:** Current commands work fine without programmatic invocation
- [x] **Insight 6:** This is enhancement, not blocker - implement incrementally

**Current Architecture Assessment:**

```
┌──────────────────────────────────────────────────────────────┐
│                    CURRENT (Works Today)                      │
│                                                              │
│  /explore → dt-doc-gen → structure → AI fills → validate    │
│                             │                                │
│                     (AI runs interactively                   │
│                      in Cursor session)                      │
└──────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────┐
│                    FUTURE (When Ready)                        │
│                                                              │
│  dt-workflow → structure → invoke-ai → fill → validate      │
│                              │                               │
│                   (Programmatic with model                   │
│                    selection per task type)                  │
└──────────────────────────────────────────────────────────────┘
```

---

## 💡 Recommendations

- [x] **R1:** Don't block template infrastructure on programmatic AI invocation
- [x] **R2:** Commands continue to work interactively (current pattern is valid)
- [x] **R3:** Create model selection config (`models.yaml`) as preparation
- [x] **R4:** Document recommended model per command type in command docs
- [x] **R5:** Defer programmatic invocation to future feature (dev-toolkit spike)
- [x] **R6:** Monitor Cursor API developments for future integration
- [x] **R7:** Consider Aider/LLM CLI integration as Phase 3 option

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-31:** Model selection configuration file must map task types to preferred models
- **FR-32:** Command documentation must include recommended model for optimal results
- **FR-33:** Future programmatic invocation must support model selection per task type

### Non-Functional Requirements

- **NFR-15:** Programmatic AI invocation is enhancement, not blocker for template infrastructure
- **NFR-16:** Model selection configuration must be user-customizable

### Constraints

- **C-15:** Cursor CLI does not currently support programmatic agent invocation
- **C-16:** Programmatic AI invocation requires external tool (Aider/LLM CLI) or future Cursor API

### Assumptions

- **A-3:** Cursor may expose programmatic API in future versions
- **A-4:** Users are willing to manually switch models in Cursor settings for optimal results

---

## 🚀 Next Steps

1. Add FR-31 through FR-33 to requirements.md
2. Add NFR-15, NFR-16 to requirements.md
3. Add C-15, C-16 to requirements.md
4. Add A-3, A-4 to requirements.md
5. Create `models.yaml` schema as part of dev-toolkit planning
6. Document model recommendations in command docs
7. Track Cursor API developments for future integration

---

**Last Updated:** 2026-01-14

---

## 📝 Research Notes

**Why this research is "Limited":**

This topic requires hands-on investigation of Cursor's undocumented capabilities and/or integration with external tools. The findings here are based on:
- Current public Cursor documentation
- Codebase analysis of existing Cursor usage
- General knowledge of AI coding tools
- Logical deduction from MCP architecture

A future spike/POC should:
1. Test Cursor's latest CLI flags
2. Prototype Aider integration
3. Evaluate LLM CLI for doc generation
4. Monitor Cursor roadmap/changelogs for API announcements
