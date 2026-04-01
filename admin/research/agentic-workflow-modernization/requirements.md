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

## 🔗 Related Documents

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
