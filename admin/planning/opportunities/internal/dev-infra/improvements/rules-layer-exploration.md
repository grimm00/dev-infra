# Rules Layer Deserves Its Own Exploration

**Source:** Decision interview Section 4.1 -- agentic-workflow-modernization (2026-04-13)
**Target:** dev-infra workflow (all templates)
**Status:** 🔴 Not Started
**Priority:** LOW (deferred -- v1 slims rules, future exploration investigates what they're uniquely good at)
**Effort:** MEDIUM (exploration + research)
**Created:** 2026-04-13
**Last Updated:** 2026-04-13

---

## Problem Statement

The agentic-workflow-modernization research treated `.mdc` rules primarily as "the thing to slim" -- content to be sorted and redistributed across the four-layer model. But rules have unique capabilities that skills don't:

- **Glob-based auto-attachment:** Load only when specific files or directories are open
- **Always-on presence:** Every conversation, no invocation needed
- **Cursor-specific behavioral config:** Agent response style, guardrails, IDE integration

The research determined *what to remove* from rules (FR-4: four content types, FR-5: mutable state) but didn't explore *what rules are uniquely good at* and how to maximize that unique value.

## Proposed Action

Run a separate `/explore` on the rules layer after v1 skill conversion is complete. Questions to investigate:

- What content genuinely benefits from always-on presence vs on-demand loading?
- How should glob-based auto-attachment be used (per-directory conventions, file-type-specific guidance)?
- What's the right relationship between slim rules and the AGENTS.md identity layer?
- Can rules serve as the "hooks-like" enforcement layer for Cursor (since Cursor doesn't support Claude Code hooks)?

## Connection

- **FR-4 (rules content separation):** V1 slims rules. This exploration would determine what the slimmed rules should look like *after* that, based on understanding their unique strengths.
- **CP-1 (explicit over implicit):** Rules are the one place where always-on (implicit) loading is a feature, not a bug. Understanding when that's appropriate vs when explicit loading is better is the core question.

---

**Last Updated:** 2026-04-13
