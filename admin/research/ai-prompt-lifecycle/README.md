# AI Prompt Lifecycle - Research Hub

**Purpose:** Research the mechanics of LLM prompt assembly and consumption to inform dev-infra command design  
**Status:** 🔴 Research  
**Created:** 2026-02-20  
**Last Updated:** 2026-02-20

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

- **[Topic 1: LLM API Anatomy](topic-1-llm-api-anatomy.md)** - API structure, tokens, context windows, message roles
- **[Topic 2: Cursor Prompt Assembly](topic-2-cursor-prompt-assembly.md)** - How Cursor assembles rules, commands, and context
- **[Topic 3: Command Effectiveness](topic-3-command-effectiveness.md)** - Long command file attention and effectiveness
- **[Topic 4: Claude Code Architecture](topic-4-claude-code-architecture.md)** - CLAUDE.md, skills, instruction injection
- **[Topic 5: AI Tool Instruction Patterns](topic-5-ai-tool-instruction-patterns.md)** - Cross-tool landscape survey

---

## 🎯 Research Overview

Understanding how LLM prompts work -- from the API level through Cursor-specific assembly -- to make informed decisions about how dev-infra's 28 command files should be structured. Includes foundational AI literacy (tokens, context windows) and practical design implications (command length, structure, injection mechanics).

**Research Topics:** 5 topics  
**Status:** 🔴 Research

---

## 📊 Research Status

| # | Research Topic | Priority | Status | Document |
|---|----------------|----------|--------|----------|
| 1 | LLM API Anatomy and Context Windows | 🔴 High | 🔴 Not Started | [topic-1-llm-api-anatomy.md](topic-1-llm-api-anatomy.md) |
| 2 | Cursor IDE Prompt Assembly | 🔴 High | 🔴 Not Started | [topic-2-cursor-prompt-assembly.md](topic-2-cursor-prompt-assembly.md) |
| 3 | Command File Effectiveness at Scale | 🔴 High | 🔴 Not Started | [topic-3-command-effectiveness.md](topic-3-command-effectiveness.md) |
| 4 | Claude Code Instruction Architecture | 🟡 Medium | 🔴 Not Started | [topic-4-claude-code-architecture.md](topic-4-claude-code-architecture.md) |
| 5 | AI Coding Tool Instruction Patterns | 🟡 Medium | 🔴 Not Started | [topic-5-ai-tool-instruction-patterns.md](topic-5-ai-tool-instruction-patterns.md) |

---

## 🚀 Next Steps

1. Conduct Topic 1 (foundational, well-documented)
2. Conduct Topic 2 (builds on Topic 1, may need community sources)
3. Conduct Topics 3-5 after foundation is solid
4. Consolidate requirements
5. Use `/decision ai-prompt-lifecycle --from-research` to make design decisions

---

**Last Updated:** 2026-02-20
