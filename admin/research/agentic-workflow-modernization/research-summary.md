# Research Summary - Agentic Workflow Modernization

**Purpose:** Summary of all research findings
**Status:** 🔴 Research
**Created:** 2026-03-25
**Last Updated:** 2026-03-25

---

## 📋 Research Overview

Research into redistributing dev-infra's workflow architecture across a four-layer model: AGENTS.md (portable conventions), platform-specific rules, skills (SKILL.md), and commands (simple triggers).

Two spikes were conducted prior to structured research and inform all topics:
- **Spike A: AGENTS.md Portability** -- Partially validated; Claude Code CLI does not read AGENTS.md natively
- **Spike B: Command-to-Skill Conversion** -- Validated; two skill archetypes (procedural, behavioral); `disable-model-invocation: true` required for explicit-only skills

**Research Topics:** 10
**Spiked:** Topic 9 (AGENTS.md portability)
**Deferred:** Topic 10 (Roadmap layer scope)
**Active:** Topics 1-8
**Status:** 🔴 Research

---

## 🔍 Key Findings

### Spike A: AGENTS.md is Real but Not Universally Portable

AGENTS.md is a growing standard (60k+ repos, Linux Foundation) but has significant platform limitations. Cursor reads it at lowest precedence. Claude Code CLI does not read it natively. File references are not followed -- content must be inline.

**Source:** [spike-learnings.md](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### Spike B: Two Distinct Skill Archetypes Identified

Procedural skills (sequential steps, reference files for templates) and behavioral skills (role assumption, engagement rules, `disable-model-invocation: true`). The `/discuss` command converted cleanly from 267 to 143 lines. Conversion acts as a precision audit for vague behavioral instructions.

**Source:** [spike-learnings.md](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### Topics 1-8: Pending

*Findings to be added as research is conducted.*

### Topic 1: Auto-Detection vs Explicit Invocation (✅ Complete)

**Recommendation: Hybrid model -- explicit for workflows, auto-detect for passive background knowledge.**

The research converges on a clear answer supported by platform convergence (both Cursor and Claude Code 2.1 landed on explicit-first independently), empirical failure rates (context-loading-to-application gaps make auto-detection unreliable for critical workflows), and the architecture of dev-infra's commands (workflow-triggered, not ambient).

Key finding: `disable-model-invocation: true` works reliably for repo/template-distributed skills but has a known bug for marketplace-distributed skills (complete invisibility from command palette). This creates a constraint on the dual-distribution model.

Criteria for auto-detect eligibility (all four required):
1. Read-only background knowledge
2. No side effects if loaded uninvited
3. Domain-scoped (relevant only in certain contexts)
4. Not a workflow a user would want to invoke on-demand

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md)

### Topic 2: Redistribution Criteria (🔴 Not Started)
*Findings to be added.*

### Topic 3: Conversion Mechanics (🔴 Not Started)
*Findings to be added.*

### Topic 4: Structural Schemas (🔴 Not Started)
*Findings to be added.*

### Topic 5: Cross-Platform Portability (🔴 Not Started)
*Findings to be added.*

### Topic 6: Dual-Distribution Workflow (🔴 Not Started)
*Findings to be added.*

### Topic 7: Conversation as Orchestration (🔴 Not Started)
*Findings to be added.*

### Topic 8: Behavioral Contracts (🔴 Not Started)
*Findings to be added.*

---

## 💡 Key Insights (from Spikes)

- [x] Insight: AGENTS.md is not a drop-in replacement for always-applied `.mdc` rules -- it is a separate, lower-priority, inline-only layer
- [x] Insight: Two skill archetypes exist and require different conversion approaches and invocation strategies
- [x] Insight: `disable-model-invocation: true` is mandatory for behavioral skills like `/discuss`
- [ ] Insight: Auto-detection criteria (Topic 1 -- pending)
- [ ] Insight: Redistribution rubric (Topic 2 -- pending)

---

## 📋 Requirements Summary

See [requirements.md](requirements.md) for complete requirements document.

**Current counts (from spikes):**
- Functional Requirements: 3 (draft, from spike learnings)
- Non-Functional Requirements: 0
- Constraints: 2
- Assumptions: 2

---

## 🚀 Next Steps

1. Conduct Topic 1 (auto-detection) -- gating decision
2. Conduct Topic 2 (redistribution rubric) after Topic 1
3. Conduct Topic 3 (conversion mechanics)
4. Run Topics 4-8 as parallel subagents (meta-experiment for Topic 7)

---

**Last Updated:** 2026-03-25
