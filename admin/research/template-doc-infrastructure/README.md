# Template Doc Infrastructure - Research Hub

**Purpose:** Research for template-based documentation infrastructure  
**Status:** ✅ Research Complete (7/7 Topics)  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-14

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings ⭐
- **[Requirements](requirements.md)** - 36 FRs, 18 NFRs, 18 Constraints, 4 Assumptions

### Research Documents

| Priority  | Topic                              | Document                                                                         | Status      |
| --------- | ---------------------------------- | -------------------------------------------------------------------------------- | ----------- |
| 🔴 High   | Template Inventory & Structure     | [research-template-inventory.md](research-template-inventory.md)                 | ✅ Complete |
| 🔴 High   | Generation Script Architecture     | [research-generation-architecture.md](research-generation-architecture.md)       | ✅ Complete |
| 🔴 High   | Architectural Placement (Four-Arm) | [research-architectural-placement.md](research-architectural-placement.md)       | ✅ Complete |
| 🟡 Medium | Validation Approach                | [research-validation-approach.md](research-validation-approach.md)               | ✅ Complete |
| 🟡 Medium | Command Integration                | [research-command-integration.md](research-command-integration.md)               | ✅ Complete |
| 🟡 Medium | Cursor CLI & Model Selection       | [research-cursor-cli-model-selection.md](research-cursor-cli-model-selection.md) | ✅ Complete |
| 🟢 Low    | Template Format                    | [research-template-format.md](research-template-format.md)                       | ✅ Complete |

---

## 🎯 Research Overview

This research addresses how to build template-based documentation infrastructure that ensures consistent doc structure across all workflows (`/explore`, `/research`, `/decision`, `/handoff`, `/task-phase`, `/fix`).

**Strategic Insight:** This exploration evolved into **workflow orchestration architecture** where scripts handle structure + context gathering (0 tokens) and AI handles creative content only (targeted tokens). Estimated 50-60% token savings.

**Key Questions:**

1. ✅ What doc types need templates and what structure should each have?
2. ✅ How should generation scripts be structured?
3. ✅ How should validation work?
4. ✅ How do templates integrate with existing commands?
5. ✅ What format should templates use?
6. ✅ Where should this tooling live? (Four-Arm Question)
7. ✅ How should scripts invoke Cursor with model selection?

**Research Topics:** 7 topics  
**High Priority Complete:** 3/3 topics ✅  
**Medium Priority Complete:** 3/3 topics ✅  
**Low Priority Complete:** 1/1 topics ✅  
**Status:** ✅ All research complete - ready for decision phase

---

## 📊 Research Status

### High Priority

| Research Topic                     | Status      | Key Finding                                    |
| ---------------------------------- | ----------- | ---------------------------------------------- |
| Template Inventory & Structure     | ✅ Complete | 17 doc types, 5 common patterns                |
| Generation Script Architecture     | ✅ Complete | Shared library + sed-based templates           |
| Architectural Placement (Four-Arm) | ✅ Complete | Templates in dev-infra, tooling in dev-toolkit |

### Medium Priority

| Research Topic               | Status      | Key Finding                                 |
| ---------------------------- | ----------- | ------------------------------------------- |
| Validation Approach          | ✅ Complete | Layered validation, on-demand CLI primary   |
| Command Integration          | ✅ Complete | 154 inline templates, incremental migration |
| Cursor CLI & Model Selection | ✅ Complete | No CLI API; config-based model selection    |

### Low Priority

| Research Topic  | Status      | Key Finding                           |
| --------------- | ----------- | ------------------------------------- |
| Template Format | ✅ Complete | envsubst with `${VAR}` format         |

---

## 💡 Key Findings

### From Topic 1: Template Inventory

- **17 doc types** identified across 6 workflows
- **5 common patterns** should be standardized (status header, quick links, status tables, next steps, related links)
- **Hub-and-spoke** is the universal organization pattern
- **Two-mode generation** (scaffolding + expansion) is the emerging standard

### From Topic 2: Generation Architecture

- **Shared library pattern** recommended (DRY, maintainable)
- **Template files** stored separately from scripts
- **sed-based variable expansion** (simple, no dependencies)
- **Hybrid integration** - scripts generate base, AI customizes
- **Validation as important as generation**

### From Topic 3: Validation Approach

- **Layered architecture** - library → CLI → commands
- **On-demand CLI primary** (`dt-doc-validate`) - developer controls timing
- **Pre-commit optional** - user-configurable enhancement, not required
- **Actionable errors** - file path, specific issue, fix suggestion
- **Type-specific validation** - different rules per doc type

### From Topic 4: Command Integration

- **154 inline templates** across 23 commands (confirms duplication problem)
- **Incremental migration** - Phase 1: extract, Phase 2: integrate, Phase 3: cleanup
- **Commands remain orchestrators** - scripts are tools they invoke
- **Placeholder types** - `{{VAR}}`, `<!-- AI: -->`, `<!-- EXPAND: -->`
- **Start with /explore and /research** - most complex, highest value

### From Topic 7: Cursor CLI & Model Selection

- **Cursor CLI is file-open only** - no `--model`, `--prompt`, or `--context` flags
- **MCP is tool-TO-AI** - doesn't help with script-TO-AI invocation
- **Alternative tools exist** - Aider, LLM CLI, Claude API provide what we need
- **Config-based model selection** - `models.yaml` can prepare for future
- **Not a blocker** - current interactive commands work fine

### From Topic 5: Template Format

- **envsubst recommended** - simple, portable, no dependencies
- **`${VAR}` syntax** - envsubst-compatible, visually distinct from AI placeholders
- **Three placeholder types** - `${VAR}` (script), `<!-- AI: -->` (content), `<!-- EXPAND: -->` (zones)
- **No complex engines needed** - jinja2/gomplate are overkill for doc generation
- **Gradual migration** - can transition from current `[...]` format

### Strategic Insights (From Discussion)

- **Scripts as orchestration layer** - not just generation, full workflow control
- **Token efficiency** - scripts generate structure (0 tokens), AI fills creative content (~50-60% savings)
- **Model selection by task type** - opus for deep thinking, sonnet for routine, composer for code
- **Four-arm placement question** - tooling should NOT live in dev-infra (template factory)

---

## 🔗 Related

- **[Exploration](../../explorations/template-doc-infrastructure/README.md)** - Source exploration (7 themes)
- **[Handoff Command Exploration](../../explorations/handoff-command/README.md)** - Related exploration (will use template infrastructure)
- **[Strategic Architecture Handoff](../../../tmp/handoff-strategic-architecture-2026-01-13.md)** - Context from main worktree

---

## 🚀 Next Steps

1. ✅ ~~Conduct research on high-priority topics (Topics 1-2, 6)~~
2. ✅ ~~Conduct research on validation approach (Topic 3)~~
3. ✅ ~~Conduct research on command integration (Topic 4)~~
4. ✅ ~~Conduct research on Cursor CLI & model selection (Topic 7)~~
5. ✅ ~~Conduct research on template format (Topic 5)~~
6. Review [research-summary.md](research-summary.md) and [requirements.md](requirements.md)
7. Use `/decision template-doc-infrastructure --from-research` to make decisions:
   - Template architecture (17 doc types, 5 patterns)
   - Generation script architecture (shared library)
   - Architectural placement (four-arm question)
   - Validation architecture
   - Command integration pattern
   - Model selection configuration
   - Template format (envsubst with `${VAR}`)
8. Decisions will create ADR documents

---

**Last Updated:** 2026-01-14
