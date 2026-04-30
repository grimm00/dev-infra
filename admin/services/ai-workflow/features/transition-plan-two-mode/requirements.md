# Requirements - Transition-Plan Two-Mode Pattern

**Source:** Research on transition-plan command redesign  
**Status:** Draft  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## 📋 Overview

This document captures requirements discovered during research on redesigning the `/transition-plan` command with a two-mode pattern.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Setup Mode Creates Scaffolding

**Description:** When `/transition-plan` runs in default (setup) mode, it should create minimal scaffolding documents.

**Source:** [Exploration - Initial Thoughts](../../explorations/transition-plan-two-mode/exploration.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Expand Mode Fills Details

**Description:** When `/transition-plan` runs with `--expand` flag, it should fill in scaffolding with detailed content.

**Source:** [Exploration - Initial Thoughts](../../explorations/transition-plan-two-mode/exploration.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-3: TDD Task Ordering in Expand Mode

**Description:** Expand mode with `--tdd` flag should order tasks with tests before implementation (RED → GREEN → REFACTOR).

**Source:** [Opportunity Document](../../planning/opportunities/internal/dev-infra/improvements/transition-plan-two-mode-pattern.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-4: Phase-Specific Expansion

**Description:** Users should be able to expand specific phases using `--phase N` flag.

**Source:** [Exploration - Proposed Flags](../../explorations/transition-plan-two-mode/exploration.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-5: Mode Switching via `--expand` Flag

**Description:** The command should switch from Setup mode to Expand mode when `--expand` flag is provided. This mirrors the `--conduct` flag in `/research`.

**Source:** [research-pattern-analysis.md](research-pattern-analysis.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-6: Phase-Specific Expansion via `--phase N`

**Description:** Allow expanding specific phases incrementally using `--phase N` flag. Track which phases have been expanded via content inspection.

**Source:** [research-pattern-analysis.md](research-pattern-analysis.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-7: Expand All via `--all` Flag

**Description:** Support batch expansion of all phases at once using `--all` flag. Useful when human review of scaffolding is complete.

**Source:** [research-pattern-analysis.md](research-pattern-analysis.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-8: Scaffolding Template (~60-80 lines)

**Description:** Create a separate scaffolding template for phase documents that includes only structure elements (header, overview, goals, task categories, criteria, dependencies) not detailed content.

**Source:** [research-scaffolding-design.md](research-scaffolding-design.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-9: Status Indicators for Scaffolding vs. Expanded

**Description:** Phase documents should have clear status indicators: `🔴 Scaffolding (needs expansion)` or `✅ Expanded`. Status should be in header metadata.

**Source:** [research-scaffolding-design.md](research-scaffolding-design.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-10: Placeholder Messages in Scaffolding

**Description:** Empty sections in scaffolding should include placeholder text that guides users to run the expansion command.

**Source:** [research-scaffolding-design.md](research-scaffolding-design.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### FR-11: Separate Setup Mode Workflow Section

**Description:** Rename current "Step-by-Step Process" section to "Setup Mode Workflow". Simplify to scaffolding creation only (no detailed phase expansion).

**Source:** [research-command-structure.md](research-command-structure.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-12: New Expand Mode Workflow Section

**Description:** Create complete new "Expand Mode Workflow" section with steps 1-7: Identify Phase → Read Scaffolding → Determine TDD → Expand Tasks → Update Status → Update Hub → Commit.

**Source:** [research-command-structure.md](research-command-structure.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-13: Mode-Specific Workflow Overview

**Description:** Update "Workflow Overview" section to have two subsections describing Setup Mode and Expand Mode, with clear guidance on when to use each.

**Source:** [research-command-structure.md](research-command-structure.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-14: Mode-Specific Usage Examples

**Description:** Add expand mode examples to Usage section showing `--expand`, `--phase N`, and `--all` flags with example commands.

**Source:** [research-command-structure.md](research-command-structure.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-15: Mode-Specific Scenarios

**Description:** Add scenarios section with mode-specific examples: Setup Scaffolding Only, Expand Single Phase, Expand All Phases, Full Workflow.

**Source:** [research-command-structure.md](research-command-structure.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Consistent Scaffolding Output

**Description:** Setup mode should produce consistent, predictable output regardless of when/how it runs.

**Source:** [Opportunity Document - Problem Statement](../../planning/opportunities/internal/dev-infra/improvements/transition-plan-two-mode-pattern.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-2: Human Review Between Modes

**Description:** The two-mode pattern should enable human review of scaffolding before expansion.

**Source:** [Opportunity Document - Benefits](../../planning/opportunities/internal/dev-infra/improvements/transition-plan-two-mode-pattern.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-3: Incremental Expansion

**Description:** Users should be able to expand phases incrementally without affecting other phases.

**Source:** [Opportunity Document - Benefits](../../planning/opportunities/internal/dev-infra/improvements/transition-plan-two-mode-pattern.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-4: Document-Based State Tracking

**Description:** Use document existence for setup state and status indicators for expansion state. No separate metadata files required.

**Source:** [research-pattern-analysis.md](research-pattern-analysis.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-5: Clear Documentation Separation

**Description:** Command documentation should have separate sections for Setup Mode Workflow and Expand Mode Workflow with mode-specific checklists and examples.

**Source:** [research-pattern-analysis.md](research-pattern-analysis.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-6: Scaffolding Consistency

**Description:** Scaffolding output should be identical for the same input. Simpler structure = more predictable/reliable output.

**Source:** [research-scaffolding-design.md](research-scaffolding-design.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-7: Scaffolding Size Limit

**Description:** Scaffolding phase documents should be ~60-80 lines. Full expanded documents should be ~200-300 lines (per existing pattern).

**Source:** [research-scaffolding-design.md](research-scaffolding-design.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-8: Command Structure Follows Proven Pattern

**Description:** The refactored command structure should mirror the `/research` command organization to ensure consistency across two-mode commands and leverage proven patterns.

**Source:** [research-command-structure.md](research-command-structure.md)

**Priority:** High

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Global Command Compatibility

**Description:** The redesigned command must work both as a global command (`~/.cursor/commands/`) and as a project command.

**Source:** [Exploration - Global Command Context](../../explorations/transition-plan-two-mode/exploration.md)

---

### C-2: Backwards Compatibility

**Description:** Existing workflows using `/transition-plan` should continue to work or have clear migration path.

**Source:** [Derived from command usage patterns]

---

## 💭 Assumptions

### A-1: Two-Mode Pattern is Proven

**Description:** The `/research` command's two-mode pattern (Setup + Conduct) is proven and suitable for adoption.

**Source:** [research-pattern-analysis.md](research-pattern-analysis.md) - Confirmed through analysis

---

### A-2: Users Want Review Opportunity

**Description:** Users benefit from reviewing scaffolding before detailed expansion.

**Source:** [Opportunity Document - Problem Statement](../../planning/opportunities/internal/dev-infra/improvements/transition-plan-two-mode-pattern.md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Exploration](../../explorations/transition-plan-two-mode/exploration.md)
- [Opportunity Document](../../planning/opportunities/internal/dev-infra/improvements/transition-plan-two-mode-pattern.md)
- [Pattern Analysis Research](research-pattern-analysis.md)
- [Scaffolding Design Research](research-scaffolding-design.md)
- [Command Structure Research](research-command-structure.md)

---

## 🚀 Next Steps

1. Continue research to discover additional requirements
2. Refine requirements based on findings
3. Use `/decision transition-plan-two-mode --from-research` to make decisions

---

**Last Updated:** 2025-12-29
