# Research Summary - Explore Two-Mode Enhancement

**Purpose:** Summary of all research findings  
**Status:** ✅ Complete  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-09

---

## 📋 Research Overview

Research for enhancing the `/explore` command with:
1. Two-mode pattern (Setup + Conduct)
2. Explicit input sources (`start.txt`, reflections, raw text)
3. Topic unification (`--topic [name] --type`)
4. Command improvement organization

**Research Topics:** 6 topics  
**Research Documents:** 6 documents  
**Status:** ✅ Complete

---

## 📊 Research Progress

| # | Topic | Priority | Status |
|---|-------|----------|--------|
| 1 | Command Improvement Organization | 🔴 High | ✅ Complete |
| 2 | Topic Unification Pattern | 🔴 High | ✅ Complete |
| 3 | Explore Input Sources | 🔴 High | ✅ Complete |
| 4 | Scaffolding Boundaries | 🟡 Medium | ✅ Complete |
| 5 | Existing Feature Integration | 🟡 Medium | ✅ Complete |
| 6 | Cross-Command Consistency | 🟡 Medium | ✅ Complete |

---

## 🔍 Key Findings

### Finding 1: Command Improvements ARE Features (Topic 1)

Per ADR-001 "Template Factory" identity, command improvements that affect template users are **template features**, not internal tooling. Commands ship in templates, making their enhancements part of the product.

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

---

### Finding 2: Topic/Type Pattern Should Be Standardized (Topic 2)

Commands should standardize on:
- **"topic"** = the subject name (what you're working on)
- **"type"** = the category (feature, ci, release, exploration)
- Positional args should stay for simplicity; `--topic` as explicit alternative
- **Mode flags** (`--conduct`, `--expand`) control action; **type/scope flags** control where/which

**Industry CLI patterns (git, kubectl, npm) validate:**
- Auto-detection aligns with git/npm approach
- Explicit `--type` when needed follows kubectl pattern
- Hard cutover migration acceptable for documentation-based commands

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md) (expanded via conduct mode)

---

### Finding 3: /explore Uniquely Handles Unstructured Input (Topic 3)

Unlike other commands that expect structured input, `/explore` can uniquely accept **raw, unstructured thoughts**. This positions `/explore` as the entry point for the ideation pipeline, with two-mode as "thought organizer."

Input sources to support:
- Raw text (stdin, inline, file) - **primary**
- `start.txt` - project initialization context
- Reflection documents - actionable suggestions
- Worktree files (new pattern) - development context

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

---

### Finding 4: Scaffolding Pattern from ADR-002 Applies (Topic 4)

The transition-plan-two-mode scaffolding pattern applies to `/explore`:
- Setup Mode: ~60-80 lines (themes, questions, structure)
- Conduct Mode: ~200-300 lines (detailed exploration)
- research-topics.md created in Setup Mode (structure, not content)

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

---

### Finding 5: Existing Feature Plan Should Remain (Topic 5)

The existing `explore-two-mode` feature plan is a valid implementation target. This exploration is the "Phase 1" work the feature plan called for. After decisions, update the feature plan with expanded scope.

**Source:** [research-existing-feature-integration.md](research-existing-feature-integration.md)

---

### Finding 6: Use --conduct Flag for /explore (Topic 6)

Cross-command consistency analysis:
- Use `--conduct` for `/explore` (matches `/research` semantics)
- Keep status indicators: `🔴 Scaffolding` → `✅ Expanded`
- Don't add incremental progress flag (not structurally needed)

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

---

## 💡 Key Insights

- [x] Insight 1: **Command improvements are template features** per ADR-001
- [x] Insight 2: **"Topic" = name, "Type" = category** - standardize vocabulary
- [x] Insight 3: **/explore uniquely handles unstructured input** - two-mode as thought organizer
- [x] Insight 4: **start.txt is natural structured input** - project's initial brain dump
- [x] Insight 5: **ADR-002 scaffolding pattern applies** - ~60-80 lines setup
- [x] Insight 6: **Existing feature plan is valid** - this exploration fulfills Phase 1
- [x] Insight 7: **`--conduct` for research-style, `--expand` for planning-style**
- [x] Insight 8: **Worktree files as untracked project context** - new pattern
- [x] Insight 9: **Mode flags and type/scope flags serve different purposes** - document clearly
- [x] Insight 10: **Industry CLI patterns validate auto-detection** - git, kubectl, npm precedent
- [x] Insight 11: **Hard cutover migration acceptable** - documentation-based commands

---

## 📋 Requirements Summary

**See:** [requirements.md](requirements.md) for complete requirements document

**Key Requirements:**

| Category | Count |
|----------|-------|
| Functional Requirements | 20 |
| Non-Functional Requirements | 11 |
| Process Requirements | 3 |
| Constraints | 4 |

---

## 🎯 Recommendations

1. ✅ Keep command improvements in `features/` - they're template features
2. ✅ Standardize vocabulary: "topic" = name, "type" = category
3. ✅ Support raw text input as primary mode for `/explore`
4. ✅ Add `--from-start` flag for start.txt input
5. ✅ Create exploration scaffolding template (~60-80 lines)
6. ✅ Create research-topics.md in Setup Mode
7. ✅ Use `--conduct` flag for `/explore`
8. ✅ Keep existing feature plan, update with expanded scope
9. ✅ Create shared "Two-Mode Pattern" documentation page

---

## 🚀 Next Steps

1. ✅ All 6 research topics complete
2. Use `/decision explore-two-mode --from-research` to make decisions
3. After decisions, use `/transition-plan --from-adr` to create implementation plan
4. Update existing feature plan with expanded scope

---

**Last Updated:** 2026-01-09 (Topic 2 expanded via conduct mode)

