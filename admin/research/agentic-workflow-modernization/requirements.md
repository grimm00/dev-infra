# Requirements - Agentic Workflow Modernization

**Source:** Research on agentic workflow modernization
**Status:** Draft
**Created:** 2026-03-25
**Last Updated:** 2026-03-25

---

## 📋 Overview

This document captures requirements discovered during research on redistributing dev-infra's workflow architecture across the four-layer model.

**Research Source:** [research-summary.md](research-summary.md)
**Spike Source:** [spike-learnings.md](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

## ✅ Functional Requirements

### FR-1: Explicit-Only Skills Must Suppress Auto-Detection

**Description:** Skills that are designed for explicit human invocation (e.g., behavioral skills like `/discuss`) must set `disable-model-invocation: true` in their SKILL.md frontmatter. The system must not invoke these automatically based on context inference.

**Source:** [spike-learnings.md (Spike B)](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Behavioral Skills Must Define Precise Engagement Contracts

**Description:** Behavioral skills must replace vague persona phrases (e.g., "play devil's advocate") with specific, actionable behavioral instructions. Instructions must distinguish genuine critical engagement from manufactured contrarianism.

**Source:** [spike-learnings.md (Spike B, Finding 5)](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-3: AGENTS.md Content Must Be Inline

**Description:** Content intended for AGENTS.md must be written inline -- not as file references or pointers. The AGENTS.md spec and Cursor's implementation do not follow file references; content must be present in the AGENTS.md file itself to be reliably fed to agents.

**Source:** [spike-learnings.md (Spike A, Finding 4)](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Priority:** High

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

*(To be added as research is conducted)*

---

## ⚠️ Constraints

### C-1: Claude Code CLI Portability Requires a Separate Layer

**Description:** AGENTS.md alone is insufficient for Claude Code CLI portability. A separate `CLAUDE.md` file (or equivalent) is required for always-on context in Claude Code CLI usage.

**Source:** [spike-learnings.md (Spike A, Finding 3)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### C-3: Marketplace Distribution of Explicit-Only Skills Is Blocked

**Description:** Skills with `disable-model-invocation: true` cannot be distributed via Cursor marketplace plugins due to a known bug (reported March 2026, unresolved): the flag completely hides plugin-delivered skills from the `/` command palette, making them invisible and uninvokable. Skills requiring this flag must be distributed via repo/template path only until the bug is resolved.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 1; [Cursor Forum bug report](https://forum.cursor.com/t/disable-model-invocation-true-completely-hides-plugin-delivered-skills-from-command-palette/155748)

---

### C-2: SKILL.md Body Limited to 500 Lines

**Description:** The Cursor skills specification limits SKILL.md to 500 lines. Complex commands with reference templates must externalize content to reference files within the skill directory.

**Source:** [spike-learnings.md (Spike B, Finding 3)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

## 💭 Assumptions

### A-1: Cursor Reads AGENTS.md at Lowest Priority

**Description:** When AGENTS.md and `.mdc` always-applied rules are both present, Cursor feeds both to the agent but treats `.mdc` rules with higher precedence. AGENTS.md content may be overridden by conflicting `.mdc` content.

**Source:** [spike-learnings.md (Spike A, Finding 2)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### A-2: Skills Are Compatible Between Cursor and Claude Code for Procedural Archetypes

**Description:** Procedural skills (sequential steps, no platform-specific behavioral instructions) are assumed compatible across platforms. Platform-specific behavior differences in behavioral skills (e.g., `disable-model-invocation` semantics) require further validation (Topic 5).

**Source:** [spike-learnings.md (Spike B)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### FR-6: Rules Content Must Be Separated Into Four Types

**Description:** The content currently in always-apply `.mdc` rules must be categorized and redistributed by type: (1) portable conventions (git flow, naming, structure) → AGENTS.md; (2) Cursor-specific behavioral config (agent response style, guardrails) → trimmed `.mdc` rule; (3) procedural reference material (workflow descriptions, checklists) → skill `references/` files; (4) mutable project state (version numbers, completion status, planned features) → removed from always-on context entirely.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 2, Finding 5

**Priority:** High

**Status:** 🔴 Pending

---

### FR-7: Multi-Mode Commands Must Use Strategy A Decomposition

**Description:** Commands with ≥3 modes or >500 lines (e.g., `/explore`, `/research`, `/pr`, `/task`) must be implemented as a skill using Strategy A: SKILL.md core (≤500 lines, handles routing and key guardrails) plus a `references/` directory containing per-mode detail documents. The single user-facing invocation surface (`/skill-name`) must be preserved. Per-mode reference files load progressively on demand.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 3, Finding 4

**Priority:** High

**Status:** 🔴 Pending

---

### FR-8: Mutable Project State Must Be Removed from Always-On Context

**Description:** Current version numbers, release history, task completion status, and planned feature lists must be removed from always-apply `.mdc` rules. This content goes stale on every release and forces the agent to reason with outdated information. Replace with a single pointer: "Current state: see admin/planning/status-and-next-steps.md" and provide the file explicitly when needed.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 2

**Priority:** High

**Status:** 🔴 Pending

---

### FR-9: Hybrid Skills Must Encode Both Steps and Behavioral Contract

**Description:** Commands that combine procedural steps with behavioral disposition guidance (e.g., `/task` with TDD cycle steps + "only one task in-progress at a time") must be implemented as hybrid skills. The SKILL.md description must communicate both the procedural archetype and the behavioral contract. The body must explicitly separate the step-by-step instructions from the behavioral guardrails.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 3, Analysis

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-4: Workflow Skills Must Disable Auto-Detection

**Description:** All user-triggered workflow skills (skills that initiate side effects such as file writes, git operations, or subagent dispatch) must set `disable-model-invocation: true` in their SKILL.md frontmatter. Auto-detection is prohibited for these skills -- invocation must be explicitly initiated by the user via `/skill-name`.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 1, Finding 3, Finding 7

**Priority:** High

**Status:** 🔴 Pending

---

### FR-5: Passive Background Knowledge May Use Auto-Detection

**Description:** Passive background knowledge extracted from always-on rules (e.g., code conventions, documentation patterns, hub-and-spoke structural rules) may use `user-invocable: false` for automatic loading. The skill must meet all four auto-detect eligibility criteria: (1) read-only, (2) no side effects if loaded uninvited, (3) domain-scoped to relevant contexts, (4) not a workflow a user would invoke on-demand.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 2, Finding 6

**Priority:** Medium

**Status:** 🔴 Pending

---

## ⚠️ Constraints (continued)

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Spike Learnings](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

## 🚀 Next Steps

1. Conduct Topics 1-8 research; extract additional requirements
2. Run `--consolidate` after all topics complete
3. Use `/decision agentic-workflow-modernization --from-research` to make architectural decisions

---

**Last Updated:** 2026-03-25
