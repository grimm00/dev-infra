# Research Topics - Transition-Plan Two-Mode Pattern

**Purpose:** List of research topics/questions to investigate  
**Status:** 🟡 Research Setup Complete  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before implementing the two-mode pattern.

---

### Research Topic 1: Two-Mode Pattern Analysis

**Question:** How does the `/research` command implement its two-mode pattern, and what patterns should we adopt?

**Why:** Understanding the proven pattern will inform our implementation.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- What triggers the switch between modes?
- How does the command detect existing structure?
- What metadata (if any) tracks mode state?
- How does it handle partial completion?

---

### Research Topic 2: Scaffolding Content Design

**Question:** What should setup mode scaffolding contain vs. leave empty for expand mode?

**Why:** Too much in scaffolding defeats the purpose; too little provides no value.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Should phase headers include empty task lists or just headers?
- Should goals be populated in scaffolding or during expansion?
- Should prerequisites be identified in scaffolding?
- What's the minimum viable scaffolding?

---

### Research Topic 3: TDD Detection Logic

**Question:** How should the command automatically determine when `--tdd` vs `--no-tdd` applies?

**Why:** Users shouldn't have to specify for every phase; intelligent defaults are better.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- What patterns indicate code phases (need TDD)?
- What patterns indicate docs-only phases (skip TDD)?
- Should phase names/content drive detection?
- What's the fallback when detection is ambiguous?

---

### Research Topic 4: Expansion State Tracking

**Question:** How should the command track which phases have been expanded?

**Why:** Avoid double-expansion and provide clear status to users.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- Should expansion state be in the phase file itself?
- Should there be a separate tracking file?
- How to detect if scaffolding has been manually modified?
- What happens if user manually adds content to scaffolding?

---

### Research Topic 5: Global Command Versioning

**Question:** Should global commands have version tracking, and how?

**Why:** As the first fully-utilized global command, we need to establish patterns.

**Priority:** Low

**Status:** 🔴 Not Started

**Sub-questions:**
- Should commands have a version header?
- How to handle version mismatches between global and project?
- Should there be a "command compatibility" check?
- How to communicate updates to users?

---

### Research Topic 6: Command Structure Refactoring

**Question:** What structural changes to the command file are needed to support two modes?

**Why:** The current 1096-line file may need reorganization.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Should setup and expand modes be in separate sections?
- How should the workflow overview change?
- What new sections are needed (mode selection, etc.)?
- Should the step-by-step process be split by mode?

---

## 🎯 Research Workflow

1. ✅ ~~Use `/research transition-plan-two-mode --from-explore transition-plan-two-mode` to create research structure~~
2. Research documents created in `admin/research/transition-plan-two-mode/`
3. Use `/research transition-plan-two-mode --conduct` to conduct research
4. After research complete, use `/decision transition-plan-two-mode --from-research` to make decisions

---

## 📊 Priority Summary

| Priority | Topics |
|----------|--------|
| **High** | 1 (Pattern Analysis), 2 (Scaffolding Design), 6 (Command Structure) |
| **Medium** | 3 (TDD Detection), 4 (Expansion Tracking) |
| **Low** | 5 (Global Versioning) |

---

**Last Updated:** 2025-12-29

