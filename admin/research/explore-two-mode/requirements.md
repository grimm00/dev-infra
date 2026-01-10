# Requirements - Explore Two-Mode Enhancement

**Source:** Research on explore-two-mode  
**Status:** Draft  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-30

---

## 📋 Overview

This document captures requirements discovered during research on enhancing the `/explore` command with two-mode pattern, input sources, and topic unification.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Two-Mode Pattern

**Description:** `/explore` command should support Setup and Conduct modes

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Input Source - start.txt

**Description:** `/explore` should accept `start.txt` as an input source via `--from-start` flag

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-3: Input Source - Reflections

**Description:** `/explore` should accept reflection documents as input sources

**Source:** [research-explore-input-sources.md](research-explore-input-sources.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-4: Topic Unification

**Description:** Commands should support `--topic [name] --type` pattern for directory selection

**Source:** [research-topic-unification-pattern.md](research-topic-unification-pattern.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-5: Scaffolding Output

**Description:** Setup mode should produce ~60-80 line scaffolding documents

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-6: Conduct Output

**Description:** Conduct mode should expand scaffolding to ~200-300 lines

**Source:** [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-ORG-1: Command Improvements as Features

**Description:** Command improvements MUST be tracked as features (not CI) per ADR-001 Template Factory identity

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Priority:** High

**Status:** ✅ Validated

---

### FR-ORG-2: Consolidated Hub References

**Description:** Consolidated hub SHOULD reference related completed features (e.g., `transition-plan-two-mode`)

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-ORG-3: Archive Placeholder Features

**Description:** Placeholder features with minimal content MAY be archived when consolidated

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Priority:** Low

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Consistency with Existing Commands

**Description:** `/explore` two-mode pattern should be consistent with `/research` and `/transition-plan`

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-2: Backward Compatibility

**Description:** Existing `/explore` usage without flags should continue to work

**Source:** [research-existing-feature-integration.md](research-existing-feature-integration.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-3: Clear Status Indicators

**Description:** Documents should use consistent status indicators (`🔴 Scaffolding`, `✅ Expanded`)

**Source:** [research-cross-command-consistency.md](research-cross-command-consistency.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-ORG-1: ADR-001 Alignment

**Description:** Directory structure MUST align with ADR-001 Template Factory identity

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Priority:** High

**Status:** ✅ Validated

---

### NFR-ORG-2: Preserve Completed Work

**Description:** Consolidation SHOULD NOT require moving completed work with extensive history

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Priority:** High

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Command Improvement Organization

**Description:** Must decide on organization structure before implementing multiple command improvements

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

**Research Finding:** Recommended creating `features/command-two-mode-pattern/` as consolidated hub while preserving completed `transition-plan-two-mode` in place.

---

### C-2: Existing Feature Plan

**Description:** Must integrate with or supersede existing `explore-two-mode` feature plan

**Source:** [research-existing-feature-integration.md](research-existing-feature-integration.md)

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

1. Continue research for remaining topics (2-6)
2. Refine requirements as research progresses
3. Use `/decision explore-two-mode --from-research` when research is complete
4. Decisions may refine requirements

---

**Last Updated:** 2025-12-31

