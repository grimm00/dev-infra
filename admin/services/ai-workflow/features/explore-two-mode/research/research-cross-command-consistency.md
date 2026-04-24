# Research: Cross-Command Consistency

**Research Topic:** Explore Two-Mode Enhancement  
**Question:** What UX patterns should be consistent across all two-mode commands?  
**Status:** ✅ Complete  
**Priority:** 🟡 Medium  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

What UX patterns should be consistent across all two-mode commands?

**Context:** `/research`, `/transition-plan`, and `/explore` should feel consistent to users. Need to define shared patterns for flags, status indicators, and incremental progress.

---

## 🔍 Research Goals

- [x] Goal 1: Compare flag patterns across two-mode commands (`--conduct` vs `--expand`)
- [x] Goal 2: Standardize status indicators (`🔴 Scaffolding` → `✅ Expanded`)
- [x] Goal 3: Define incremental progress patterns (`--topic-num` vs `--phase`)
- [x] Goal 4: Evaluate need for shared "two-mode pattern" documentation page

---

## 📚 Research Methodology

**Sources:**
- [x] `/research` command two-mode implementation
- [x] `/transition-plan` command two-mode implementation (ADR-001)
- [x] Current `/explore` command implementation

**Sub-questions to investigate:**
- Should all use `--conduct` or should `/explore` use `--expand`?
- Should status indicators be identical (`🔴 Scaffolding` → `✅ Expanded`)?
- How should incremental progress work (`--topic-num` vs `--phase`)?
- Should there be a shared "two-mode pattern" documentation page?

---

## 📊 Findings

### Finding 1: Current Flag Patterns Are Inconsistent

| Command | Mode 1 Flag | Mode 2 Flag | Incremental |
|---------|-------------|-------------|-------------|
| `/research` | (default) | `--conduct` | `--topic-num N` |
| `/transition-plan` | (default) | `--expand` | `--phase N` |
| `/explore` | (default) | N/A (none yet) | N/A |

**Source:** Command documentation audit

**Relevance:** Need to standardize on one approach

---

### Finding 2: "Conduct" vs "Expand" Have Different Semantics

| Term | Semantic | Best For |
|------|----------|----------|
| `--conduct` | "Do the research/exploration" | `/research`, `/explore` |
| `--expand` | "Fill in the scaffolding" | `/transition-plan` (phases) |

**Analysis:**
- `/research --conduct` = "conduct the research" ✓
- `/explore --conduct` = "conduct the exploration" ✓
- `/transition-plan --expand` = "expand the scaffolding" ✓

Both terms are semantically appropriate for their contexts.

**Source:** Semantic analysis

**Relevance:** Consider keeping both terms (semantic appropriateness) vs forcing consistency

---

### Finding 3: Status Indicators Are Consistent

Both commands use the same pattern:

```markdown
# Scaffolding state
**Status:** 🔴 Scaffolding (needs expansion)

# Expanded state  
**Status:** ✅ Expanded
```

**Source:** ADR-002, command documentation

**Relevance:** ✅ Already consistent - maintain this

---

### Finding 4: Incremental Progress Patterns Make Sense Per-Context

| Command | Incremental Flag | Context |
|---------|------------------|---------|
| `/research` | `--topic-num N` | Research has multiple topics |
| `/transition-plan` | `--phase N` | Plans have phases |
| `/explore` | N/A needed | Single exploration document |

`/explore` doesn't need incremental progress because:
- Single exploration.md document
- research-topics.md is structure, not content to expand

**Source:** Command structure analysis

**Relevance:** Don't force incremental pattern where not needed

---

## 🔍 Analysis

**Consistency vs Semantic Appropriateness:**

The key insight is that two-mode commands fall into two categories:

| Category | Commands | Mode 2 Term | Semantics |
|----------|----------|-------------|-----------|
| **Research-style** | `/research`, `/explore` | `--conduct` | "Do the investigation" |
| **Planning-style** | `/transition-plan` | `--expand` | "Fill in the details" |

**Recommendation:** Keep semantic appropriateness, document the pattern.

**Key Insights:**
- [x] Insight 1: `--conduct` is semantically appropriate for research-style commands
- [x] Insight 2: `--expand` is semantically appropriate for planning-style commands
- [x] Insight 3: Status indicators are already consistent - keep them
- [x] Insight 4: Incremental progress only where structurally needed

---

## 💡 Recommendations

- [x] Recommendation 1: Use `--conduct` for `/explore` (matches `/research` semantics)
- [x] Recommendation 2: Keep status indicators consistent (`🔴 Scaffolding` → `✅ Expanded`)
- [x] Recommendation 3: Don't add incremental flag to `/explore` (not needed)
- [x] Recommendation 4: Create shared "Two-Mode Pattern" documentation page
- [x] Recommendation 5: Document that `--conduct` = research-style, `--expand` = planning-style

---

## 📋 Requirements Discovered

**Functional Requirements:**

- [x] FR-CC-1: `/explore` MUST use `--conduct` flag (not `--expand`)
- [x] FR-CC-2: Status indicators MUST match pattern: `🔴 Scaffolding` → `✅ Expanded`
- [x] FR-CC-3: `/explore` SHOULD NOT have incremental progress flag

**Non-Functional Requirements:**

- [x] NFR-CC-1: Two-mode commands SHOULD have shared documentation
- [x] NFR-CC-2: Flag semantics SHOULD be contextually appropriate

---

## 🚀 Next Steps

1. ✅ Research complete
2. Create shared two-mode pattern documentation
3. After all research, use `/decision explore-two-mode --from-research`

---

**Last Updated:** 2026-01-09

