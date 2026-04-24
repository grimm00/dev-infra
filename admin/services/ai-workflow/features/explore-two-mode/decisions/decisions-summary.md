# Decisions Summary - Explore Two-Mode Enhancement

**Purpose:** Summary of all decisions made  
**Status:** 🔴 Proposed  
**Created:** 2026-01-10  
**Last Updated:** 2026-01-10

---

## 📋 Decisions Overview

Four architecture decisions for enhancing the `/explore` command with two-mode pattern, input sources, worktree integration, and scaffolding boundaries.

**Decision Points:** 4 decisions  
**Status:** 🔴 Proposed (awaiting approval)

---

## 🎯 Key Decisions

### Decision 1: Two-Mode Pattern

**Decision:** Adopt Setup + Conduct pattern using `--conduct` flag.

| Mode | Output | Status Indicator |
|------|--------|------------------|
| Setup | ~60-80 lines scaffolding | `🔴 Scaffolding` |
| Conduct | ~200-300 lines expanded | `✅ Expanded` |

**Status:** 🔴 Proposed

**ADR:** [adr-001-two-mode-pattern.md](adr-001-two-mode-pattern.md)

---

### Decision 2: Input Sources

**Decision:** Support multiple input sources with raw text as primary.

| Priority | Source | Flag |
|----------|--------|------|
| 1 | Raw text | `--input [text\|file]` |
| 2 | start.txt | `--from-start` |
| 3 | Reflections | `--from-reflect [file]` |
| 4 | Interactive | (prompt) |

**Status:** 🔴 Proposed

**ADR:** [adr-002-input-sources.md](adr-002-input-sources.md)

---

### Decision 3: Worktree Integration

**Decision:** Lazy worktree creation - prompt on Conduct Mode transition.

| Mode | Worktree | Rationale |
|------|----------|-----------|
| Setup | ❌ Not needed | Light investment, acceptable on develop |
| Conduct | 🌳 Prompted | Real investment, aligns with ADR-002 |

**Flags:**
- `--worktree` - Create without prompting
- `--no-worktree` - Skip prompt, stay on current branch

**Status:** 🔴 Proposed

**ADR:** [adr-003-worktree-integration.md](adr-003-worktree-integration.md)

---

### Decision 4: Scaffolding Boundaries

**Decision:** Apply transition-plan-two-mode boundaries (~60-80 / ~200-300 lines).

**Setup Mode Creates:**
```
explorations/[topic]/
├── README.md           (~20 lines)
├── exploration.md      (~40-50 lines)
└── research-topics.md  (~20-30 lines)
```

**Status:** 🔴 Proposed

**ADR:** [adr-004-scaffolding-boundaries.md](adr-004-scaffolding-boundaries.md)

---

## 📋 Requirements Impact

All 24 functional requirements and 13 non-functional requirements are addressed by these decisions.

**Key Requirements Addressed:**
- FR-CC-1: Conduct Flag ✅ (ADR-001)
- FR-IS-1: Unstructured Text Input ✅ (ADR-002)
- FR-WT-1: Lazy Worktree Creation ✅ (ADR-003)
- FR-SB-1: Scaffolding Size ✅ (ADR-004)

**See:** [requirements.md](../../research/explore-two-mode/requirements.md) for complete requirements

---

## 🔗 Command Pipeline Position

```
┌─────────┐    ┌──────────┐    ┌──────────┐    ┌─────────────────┐
│ /explore│ → │ /research│ → │ /decision│ → │ /transition-plan│ → ...
└─────────┘    └──────────┘    └──────────┘    └─────────────────┘
     ↑
  Entry point for ideation
  - Accepts raw, unstructured input
  - Organizes thoughts into themes
  - Extracts research questions
  - Outputs: research-topics.md
```

---

## 🚀 Next Steps

1. Review ADR documents
2. Approve or modify decisions
3. Use `/transition-plan --from-adr admin/decisions/explore-two-mode/` to create implementation plan
4. Update existing `explore-two-mode` feature plan with expanded scope

---

**Last Updated:** 2026-01-10
