# Research Topics - Explore Two-Mode Enhancement

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-30

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions.

---

### Research Topic 1: Command Improvement Organization

**Question:** Should command improvement features be consolidated, and what directory structure is appropriate?

**Why:** Currently have 4 separate `*-two-mode` features. Consolidation could reduce duplication and improve discoverability.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Are command improvements "features" or "internal tooling"?
- Would a `commands/improvements/` directory be better than `features/`?
- How does consolidation affect the transition-plan-two-mode (already complete)?
- What should happen to existing scattered feature directories?

---

### Research Topic 2: Topic Unification Pattern

**Question:** How should `--topic [name] --type` pattern work across commands?

**Why:** Currently commands use `--feature`, `--ci`, or implicit type detection. A unified pattern could simplify usage.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- What commands currently use type-specific flags (`--feature`, `--ci`)?
- What would the mapping from `--type` to directory path look like?
- How does this interact with auto-detection (when no type specified)?
- Should `--topic` replace the positional argument in commands?

---

### Research Topic 3: Explore Input Sources

**Question:** What explicit input sources should `/explore` accept?

**Why:** Unlike `/research --from-explore`, the `/explore` command has no `--from-*` options. Adding input sources would improve workflow.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- What content does `start.txt` provide that's useful for exploration?
- What other documents could seed explorations (reflections, feature plans, ADRs)?
- How should the command extract exploration context from each source type?
- Should there be a `--from-start` or `--from-project-init` flag?

---

### Research Topic 4: Two-Mode Scaffolding Boundaries

**Question:** What content boundaries should `/explore` use for Setup vs Conduct mode?

**Why:** Need consistent, predictable output sizes like transition-plan-two-mode achieved (~60-80 lines setup, ~200-300 conduct).

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- What sections go in scaffolding vs detailed exploration?
- Should research-topics.md be created in Setup or Conduct mode?
- How much context should Setup mode include?
- Should Setup mode prompt for key questions or leave them for Conduct?

---

### Research Topic 5: Existing Feature Plan Integration

**Question:** How should we handle the existing `explore-two-mode` feature plan?

**Why:** There's already an `admin/planning/features/explore-two-mode/` with narrower scope. Need to decide integration approach.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- Should existing feature be expanded or archived?
- How do we avoid duplicate planning work?
- Should this exploration supersede the existing feature plan?
- What's the best way to consolidate research and decisions?

---

### Research Topic 6: Cross-Command Consistency

**Question:** What UX patterns should be consistent across all two-mode commands?

**Why:** `/research`, `/transition-plan`, and `/explore` should feel consistent to users.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- Should all use `--conduct` or should `/explore` use `--expand`?
- Should status indicators be identical (`🔴 Scaffolding` → `✅ Expanded`)?
- How should incremental progress work (`--topic-num` vs `--phase`)?
- Should there be a shared "two-mode pattern" documentation page?

---

## 🎯 Research Workflow

1. Use `/research explore-two-mode --from-explore explore-two-mode` to create research structure
2. Research documents created in `admin/research/explore-two-mode/`
3. Use `/research explore-two-mode --conduct` to conduct research
4. After research complete, use `/decision explore-two-mode --from-research` to make decisions

---

## 📊 Priority Summary

| Priority | Topics |
|----------|--------|
| **High** | 1 (Organization), 2 (Topic Unification), 3 (Input Sources) |
| **Medium** | 4 (Scaffolding Boundaries), 5 (Feature Integration), 6 (Cross-Command Consistency) |

---

## 📝 Notes on Research Approach

### Recommended Research Order

1. **Topic 1 (Organization)** first - impacts where we put everything else
2. **Topic 3 (Input Sources)** - core new capability
3. **Topic 2 (Topic Unification)** - depends on organization decision
4. **Topics 4-6** can proceed in parallel after 1-3

### Evidence to Gather

- Review how `/research` and `/transition-plan` handle their two-mode patterns
- Audit current commands for `--feature`, `--ci`, `--topic` usage
- Analyze `start.txt` structure across templates
- Check reflection document structure for extractable exploration seeds

---

**Last Updated:** 2025-12-30

