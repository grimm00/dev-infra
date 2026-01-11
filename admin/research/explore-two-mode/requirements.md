# Requirements - Explore Two-Mode Enhancement

**Source:** Research on explore-two-mode  
**Status:** Final  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-09

---

## 📋 Overview

This document captures requirements discovered during research on enhancing the `/explore` command with two-mode pattern, input sources, and topic unification.

**Research Source:** [research-summary.md](research-summary.md)

**Summary:**
- Functional Requirements: 24 (Topic 7 Worktree: +4 new)
- Non-Functional Requirements: 13 (Topic 7 Worktree: +2 new)
- Process Requirements: 3
- Constraints: 4
- Assumptions: 2

---

## ✅ Functional Requirements

### Topic 1: Command Improvement Organization

#### FR-ORG-1: Command Improvements as Features

**Description:** Command improvements MUST be tracked as features (not CI) per ADR-001 Template Factory identity

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Priority:** High

**Status:** ✅ Validated

---

#### FR-ORG-2: Consolidated Hub References

**Description:** Consolidated hub SHOULD reference related completed features (e.g., `transition-plan-two-mode`)

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### Topic 2: Topic Unification Pattern

#### FR-TU-1: Positional and Named Topic

**Description:** Commands MUST accept topic as positional argument OR `--topic` flag

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-TU-2: Type Flag Support

**Description:** Commands with category variance MUST support `--type` flag

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-TU-3: Auto-Detection Default

**Description:** Auto-detection MUST remain default behavior; explicit flags for override

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-TU-4: Mode and Scope Flag Separation

**Description:** Mode flags (`--conduct`, `--expand`) MUST be distinct from type/scope flags (`--type`, `--topic-num`)

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md) (expanded via conduct mode)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-TU-5: Explore Type Flag

**Description:** `/explore --type` MUST support values: exploration, research, feature

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md) (expanded via conduct mode)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-TU-6: Transition-Plan Flag Rename

**Description:** `/transition-plan` SHOULD rename `--feature` to `--topic` for consistency

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md) (expanded via conduct mode)

**Priority:** Low

**Status:** 🔴 Pending

---

### Topic 3: Explore Input Sources

#### FR-IS-1: Unstructured Text Input

**Description:** `/explore` MUST accept unstructured text input (stdin, inline, or file)

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-IS-2: start.txt Input Source

**Description:** `/explore` SHOULD support `--from-start` flag to read start.txt

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-IS-3: Reflection Input Source

**Description:** `/explore` MAY support `--from-reflect` flag to read reflection suggestions

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** Low

**Status:** 🔴 Pending

---

#### FR-IS-4: Theme Organization

**Description:** Setup Mode MUST organize unstructured input into themed sections

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-IS-5: Question Extraction

**Description:** Setup Mode MUST extract questions from unstructured input

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** High

**Status:** 🔴 Pending

---

### Topic 4: Scaffolding Boundaries

#### FR-SB-1: Scaffolding Size

**Description:** Setup Mode MUST produce scaffolding of ~60-80 lines

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-SB-2: Research Topics Creation

**Description:** Setup Mode MUST create research-topics.md with prioritized questions

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-SB-3: Conduct Mode Expansion

**Description:** Conduct Mode MUST expand to ~200-300 lines

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-SB-4: Placeholder Guidance

**Description:** Scaffolding MUST include placeholder message guiding to conduct mode

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### Topic 6: Cross-Command Consistency

#### FR-CC-1: Conduct Flag

**Description:** `/explore` MUST use `--conduct` flag (not `--expand`)

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-CC-2: Status Indicator Pattern

**Description:** Status indicators MUST match pattern: `🔴 Scaffolding` → `✅ Expanded`

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-CC-3: No Incremental Progress

**Description:** `/explore` SHOULD NOT have incremental progress flag (not structurally needed)

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### Topic 7: Worktree Integration (New)

#### FR-WT-1: Lazy Worktree Creation

**Description:** `/explore` Setup Mode MUST NOT require worktree; Conduct Mode SHOULD prompt for worktree creation

**Source:** User decision during research review (2026-01-10)

**Priority:** High

**Status:** 🔴 Pending

**Rationale:** Setup mode is light (organizing thoughts, suggesting topics) and acceptable on develop. Conduct mode represents real investment and should trigger worktree prompt per ADR-002.

---

#### FR-WT-2: Worktree Prompt on Conduct

**Description:** When running `/explore --conduct`, command SHOULD prompt: "Create worktree for this exploration?"

**Source:** User decision during research review (2026-01-10)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-WT-3: Skip Worktree Flag

**Description:** `/explore --conduct --no-worktree` MUST skip worktree prompt and continue on current branch

**Source:** User decision during research review (2026-01-10)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-WT-4: Automatic Worktree Flag

**Description:** `/explore --conduct --worktree` MUST create worktree without prompting

**Source:** User decision during research review (2026-01-10)

**Priority:** Medium

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### Topic 1: Command Improvement Organization

#### NFR-ORG-1: ADR-001 Alignment

**Description:** Directory structure MUST align with ADR-001 Template Factory identity

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Priority:** High

**Status:** ✅ Validated

---

### Topic 2: Topic Unification Pattern

#### NFR-TU-1: Syntax Consistency

**Description:** Command syntax MUST be consistent across all planning commands

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### NFR-TU-2: Vocabulary Documentation

**Description:** Documentation MUST clearly explain topic vs type distinction

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### NFR-TU-3: Command Help Text

**Description:** Command help text MUST show default behavior and override options

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md) (expanded via conduct mode)

**Priority:** Low

**Status:** 🔴 Pending

---

#### NFR-TU-4: Migration Documentation

**Description:** Migration to new flag names SHOULD use hard cutover with CHANGELOG documentation

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md) (expanded via conduct mode)

**Priority:** Low

**Status:** 🔴 Pending

---

### Topic 3: Explore Input Sources

#### NFR-IS-1: Source-Agnostic Processing

**Description:** Input processing SHOULD be source-agnostic (common output format)

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### NFR-IS-2: Error Guidance

**Description:** Error messages SHOULD guide users to correct input format

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### Topic 4: Scaffolding Boundaries

#### NFR-SB-1: Predictable Output

**Description:** Output sizes MUST be predictable across runs

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### NFR-SB-2: Structural Consistency

**Description:** Scaffolding structure MUST be consistent with other two-mode commands

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** High

**Status:** 🔴 Pending

---

### Topic 6: Cross-Command Consistency

#### NFR-CC-1: Shared Documentation

**Description:** Two-mode commands SHOULD have shared documentation page

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### NFR-CC-2: Semantic Flags

**Description:** Flag semantics SHOULD be contextually appropriate

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### Topic 7: Worktree Integration (New)

#### NFR-WT-1: ADR-002 Alignment

**Description:** Worktree integration MUST align with ADR-002 self-contained feature branches pattern

**Source:** User decision during research review (2026-01-10)

**Priority:** High

**Status:** 🔴 Pending

---

#### NFR-WT-2: Non-Disruptive Prompts

**Description:** Worktree prompts MUST be skippable and not block command execution

**Source:** User decision during research review (2026-01-10)

**Priority:** Medium

**Status:** 🔴 Pending

---

## 📋 Process Requirements

### Topic 5: Existing Feature Integration

#### PR-FI-1: Research to Feature Flow

**Description:** Exploration research SHOULD feed into existing feature plans

**Source:** [research-existing-feature-integration.md](research-existing-feature-integration.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### PR-FI-2: Feature Plan Updates

**Description:** Feature plans SHOULD be updated with expanded scope from research

**Source:** [research-existing-feature-integration.md](research-existing-feature-integration.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### PR-FI-3: ADR Linking

**Description:** ADRs SHOULD be linked from feature plan README

**Source:** [research-existing-feature-integration.md](research-existing-feature-integration.md)

**Priority:** Low

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Command Improvement Organization

**Description:** Must decide on organization structure before implementing multiple command improvements

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Research Finding:** Recommended keeping features in place while creating consolidated hub for grouping.

---

### C-2: Existing Feature Plan

**Description:** Must integrate with or update existing `explore-two-mode` feature plan

**Source:** [research-existing-feature-integration.md](research-existing-feature-integration.md)

**Research Finding:** Keep existing feature plan as implementation target; update with expanded scope after decisions.

---

### C-3: Topic-Num Semantic Preservation

**Description:** `/research --topic-num` semantic MUST be preserved (sub-selection, not unification)

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md) (expanded via conduct mode)

**Research Finding:** `--topic-num` serves a different purpose (sub-selection within research) and should not be changed.

---

### C-4: Positional Args Priority

**Description:** Positional arguments MUST remain the primary input method for simplicity

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md) (expanded via conduct mode)

**Research Finding:** Industry CLI patterns validate positional args for simplicity; named flags only for explicit override.

---

## 💭 Assumptions

### A-1: Two-Mode Pattern Proven

**Description:** Assume two-mode pattern from `/research` and `/transition-plan` is proven and should be adopted

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

---

### A-2: start.txt Available

**Description:** Assume `start.txt` exists in projects using dev-infra templates

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Documents](README.md)

---

## 🚀 Next Steps

1. ✅ Research complete
2. Use `/decision explore-two-mode --from-research` to make decisions
3. Decisions may refine requirements
4. Update existing feature plan with expanded scope

---

**Last Updated:** 2026-01-10 (Topic 7 Worktree Integration added)
