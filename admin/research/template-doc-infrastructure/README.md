# Template Doc Infrastructure - Research Hub

**Purpose:** Research for template-based documentation infrastructure  
**Status:** 🟡 Research (4 Topics Complete)  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-14

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings ⭐
- **[Requirements](requirements.md)** - 25 FRs, 12 NFRs, 12 Constraints discovered

### Research Documents

| Priority  | Topic                              | Document                                                                         | Status         |
| --------- | ---------------------------------- | -------------------------------------------------------------------------------- | -------------- |
| 🔴 High   | Template Inventory & Structure     | [research-template-inventory.md](research-template-inventory.md)                 | ✅ Complete    |
| 🔴 High   | Generation Script Architecture     | [research-generation-architecture.md](research-generation-architecture.md)       | ✅ Complete    |
| 🔴 High   | Architectural Placement (Four-Arm) | [research-architectural-placement.md](research-architectural-placement.md)       | ✅ Complete    |
| 🟡 Medium | Validation Approach                | [research-validation-approach.md](research-validation-approach.md)               | ✅ Complete    |
| 🟡 Medium | Command Integration                | [research-command-integration.md](research-command-integration.md)               | 🔴 Not Started |
| 🟡 Medium | Cursor CLI & Model Selection       | [research-cursor-cli-model-selection.md](research-cursor-cli-model-selection.md) | 🔴 Not Started |
| 🟢 Low    | Template Format                    | [research-template-format.md](research-template-format.md)                       | 🔴 Not Started |

---

## 🎯 Research Overview

This research addresses how to build template-based documentation infrastructure that ensures consistent doc structure across all workflows (`/explore`, `/research`, `/decision`, `/handoff`, `/task-phase`, `/fix`).

**Strategic Insight:** This exploration evolved into **workflow orchestration architecture** where scripts handle structure + context gathering (0 tokens) and AI handles creative content only (targeted tokens). Estimated 50-60% token savings.

**Key Questions:**

1. ✅ What doc types need templates and what structure should each have?
2. ✅ How should generation scripts be structured?
3. ✅ How should validation work?
4. How do templates integrate with existing commands?
5. What format should templates use?
6. ✅ **Where should this tooling live? (Four-Arm Question)**
7. **How should scripts invoke Cursor with model selection?** ⭐ NEW

**Research Topics:** 7 topics  
**High Priority Complete:** 3/3 topics ✅  
**Medium Priority Complete:** 1/3 topics ✅  
**Status:** 🟡 Research (ready for decision phase)

---

## 📊 Research Status

### High Priority

| Research Topic                     | Status      | Key Finding                                    |
| ---------------------------------- | ----------- | ---------------------------------------------- |
| Template Inventory & Structure     | ✅ Complete | 17 doc types, 5 common patterns                |
| Generation Script Architecture     | ✅ Complete | Shared library + sed-based templates           |
| Architectural Placement (Four-Arm) | ✅ Complete | Templates in dev-infra, tooling in dev-toolkit |

### Medium Priority

| Research Topic               | Status         | Key Finding                                |
| ---------------------------- | -------------- | ------------------------------------------ |
| Validation Approach          | ✅ Complete    | Layered validation, on-demand CLI primary  |
| Command Integration          | 🔴 Not Started | -                                          |
| Cursor CLI & Model Selection | 🔴 Not Started | -                                          |

### Low Priority

| Research Topic  | Status         | Key Finding |
| --------------- | -------------- | ----------- |
| Template Format | 🔴 Not Started | -           |

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
3. Review [research-summary.md](research-summary.md) and [requirements.md](requirements.md)
4. Use `/decision template-doc-infrastructure --from-research` to make decisions:
   - Template architecture (17 doc types, 5 patterns)
   - Generation script architecture (shared library)
   - Architectural placement (four-arm question)
   - Validation architecture
   - Model selection strategy
5. Decisions will create ADR documents

**Note:** Remaining medium-priority topics (4, 7) and low-priority (5) can be researched during implementation if needed.

---

**Last Updated:** 2026-01-14
