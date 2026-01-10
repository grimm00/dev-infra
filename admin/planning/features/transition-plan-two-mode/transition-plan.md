# Feature Transition Plan - Transition-Plan Two-Mode Pattern

**Feature:** Transition-Plan Two-Mode Pattern  
**Status:** 🔴 Not Started  
**Created:** 2025-12-29  
**Source:** [ADR-001](../../../decisions/transition-plan-two-mode/adr-001-flag-based-mode-switching.md), [ADR-002](../../../decisions/transition-plan-two-mode/adr-002-scaffolding-content-boundaries.md), [ADR-003](../../../decisions/transition-plan-two-mode/adr-003-command-structure-refactoring.md)  
**Type:** Feature

---

## 📋 Overview

Transform the `/transition-plan` command from a single-pass approach to a two-mode pattern (Setup + Expand), enabling human review between modes and consistent output.

**Target File:** `.cursor/commands/transition-plan.md`

**Current State:** 1095 lines, single-pass output  
**Target State:** ~1250 lines, two-mode with separate workflows

---

## 🎯 Transition Goals

1. Add Setup Mode with scaffolding output
2. Add Expand Mode with TDD detail
3. Restructure documentation with separate mode workflows
4. Add mode-specific scenarios and tips

---

## 🔧 Workflow Decisions

**Deliverable Location:**
- Work in: `dev-infra/.cursor/commands/transition-plan.md`
- Copy to: `~/.cursor/commands/transition-plan.md` (after merge)

**Version Control:**
- Research/ADR/Planning docs: `docs/*` → direct push to develop ✅
- Command implementation: `feat/transition-plan-two-mode` → **PR required**

**Release to Global:**
- Manual copy after PR merge to develop

---

## ✅ Pre-Transition Checklist

- [x] ADRs reviewed and approved (3 ADRs)
- [x] Requirements documented (16 requirements)
- [x] Phase documents created (4 phases)
- [x] Workflow decisions documented
- [ ] `/research` command reviewed as pattern source
- [ ] Current `/transition-plan` command backed up (implicit in git)

---

## 📅 Transition Steps

### Phase 1: Workflow Overview (~30 min)

**Goal:** Update Workflow Overview with mode subsections

**Prerequisites:**
- [ ] Review current Workflow Overview section
- [ ] Review `/research` command Workflow Overview

**Tasks:**
- [ ] Add "### Setup Mode (Default)" subsection
- [ ] Add "### Expand Mode (`--expand`)" subsection
- [ ] Document when to use each mode
- [ ] Add flags documentation (`--phase N`, `--all`)

**Definition of Done:**
- [ ] Workflow Overview has two mode subsections
- [ ] Mode descriptions are clear
- [ ] Flags are documented

---

### Phase 2: Setup Mode Workflow (~1-2 hours)

**Goal:** Refactor Step-by-Step Process for scaffolding only

**Prerequisites:**
- [ ] Phase 1 complete
- [ ] Scaffolding template designed (from ADR-002)

**Tasks:**
- [ ] Rename "Step-by-Step Process" to "Setup Mode Workflow"
- [ ] Simplify steps to scaffolding creation only
- [ ] Create scaffolding template section (~60-80 lines target)
- [ ] Add status indicator: `🔴 Scaffolding (needs expansion)`
- [ ] Add placeholder messages for expansion sections
- [ ] Update step numbering (reduce to 6 steps)

**Definition of Done:**
- [ ] Section renamed to "Setup Mode Workflow"
- [ ] Steps simplified to scaffolding only
- [ ] Scaffolding template documented
- [ ] Status indicators documented

---

### Phase 3: Expand Mode Workflow (~2 hours)

**Goal:** Create new Expand Mode section with TDD logic

**Prerequisites:**
- [ ] Phase 2 complete
- [ ] TDD ordering pattern documented

**Tasks:**
- [ ] Create "## Expand Mode Workflow (`--expand`)" section
- [ ] Add Step 1: Identify Phase to Expand
- [ ] Add Step 2: Read Phase Scaffolding
- [ ] Add Step 3: Determine TDD vs Non-TDD
- [ ] Add Step 4: Expand Tasks with Detail (TDD ordering)
- [ ] Add Step 5: Update Phase Status (`✅ Expanded`)
- [ ] Add Step 6: Update Hub Status
- [ ] Add Step 7: Commit Changes
- [ ] Document `--phase N` and `--all` flag handling

**Definition of Done:**
- [ ] Expand Mode Workflow section created
- [ ] 7 steps documented
- [ ] TDD ordering logic included
- [ ] Flag handling documented

---

### Phase 4: Supporting Content (~1 hour)

**Goal:** Update Usage, Scenarios, and Tips for two modes

**Prerequisites:**
- [ ] Phase 3 complete

**Tasks:**
- [ ] Update Usage section with expand mode examples
- [ ] Add Scenario: Setup Scaffolding Only
- [ ] Add Scenario: Expand Single Phase
- [ ] Add Scenario: Expand All Phases
- [ ] Add Scenario: Full Workflow
- [ ] Add "### When to Use Each Mode" to Tips
- [ ] Update Common Issues for two-mode workflow

**Definition of Done:**
- [ ] Usage section has mode-specific examples
- [ ] 4 mode-specific scenarios added
- [ ] Tips include mode selection guidance
- [ ] Common Issues updated

---

## 📝 Post-Transition

- [ ] All 4 phases complete
- [ ] Command tested manually (setup + expand)
- [ ] Documentation reviewed for accuracy
- [ ] PR created (`feat/transition-plan-two-mode`)
- [ ] PR reviewed and merged to develop
- [ ] Copy to global: `~/.cursor/commands/transition-plan.md`
- [ ] Requirements marked as implemented

---

## ✅ Definition of Done

- [ ] All phases complete
- [ ] `/transition-plan` supports two modes
- [ ] Setup mode creates scaffolding (~60-80 lines)
- [ ] Expand mode fills detail (~200-300 lines)
- [ ] `--phase N` and `--all` flags work
- [ ] Status indicators work (`🔴 Scaffolding` / `✅ Expanded`)
- [ ] Documentation follows `/research` pattern
- [ ] PR merged to develop

---

**Last Updated:** 2025-12-29

