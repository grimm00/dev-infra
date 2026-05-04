# CONVENTIONS.md Gap: Shared Human+Agent Conventions File

**Source:** Decision interview Section 4.3 -- agentic-workflow-modernization (2026-04-13)
**Target:** dev-infra templates (all template types)
**Status:** 🔴 Not Started
**Priority:** LOW (deferred -- not blocking v1 modernization)
**Effort:** LOW (file creation + content migration from AGENTS.md)
**Created:** 2026-04-13
**Last Updated:** 2026-04-13

---

## Problem Statement

AGENTS.md in practice carries two kinds of content:

1. **Agent-specific behavioral config** -- tool restrictions, context loading rules, behavioral defaults, skill discovery preferences
2. **Shared conventions** -- coding standards, testing patterns, release process, PR formatting, naming conventions

The shared conventions are useful to both humans and agents. Humans read AGENTS.md for conventions because no other file serves that purpose. This burdens AGENTS.md with content that isn't agent-specific.

## Observation

The observation came from real workplace experience: AGENTS.md in team repos (e.g., helm-charts) ended up being primarily a conventions file because that gap existed. The agent-specific content (behavioral defaults, when to auto-load skills) was secondary to the conventions content.

## Proposed Solution

Introduce `CONVENTIONS.md` as a shared human+agent conventions file:

- **CONVENTIONS.md** -- shared conventions readable by both humans and agents (coding standards, naming, PR format, testing patterns, release process)
- **AGENTS.md** -- agent-specific behavioral config that points to CONVENTIONS.md for shared content
- **CLAUDE.md** -- Claude Code-specific features (unchanged from C-4)

This means AGENTS.md becomes lighter and more focused. Agents that read CONVENTIONS.md get the same shared knowledge humans get. The dual-file strategy (C-4) expands to a three-file strategy with clearer separation of concerns.

## Why Deferred

This gap was discovered during the agentic-workflow-modernization research but is not a requirement of that modernization. V1 can proceed with the existing AGENTS.md + CLAUDE.md strategy. CONVENTIONS.md is a template improvement that benefits all projects, not just the skill conversion.

## Connection

- **C-4 (dual-file strategy):** CONVENTIONS.md would refine C-4 into a three-file model
- **FR-1 (AGENTS.md inline content):** CONVENTIONS.md reduces what AGENTS.md needs to carry inline
- **Four-arm architecture:** CONVENTIONS.md in templates means all dev-infra-generated projects get shared conventions from day one

---

**Last Updated:** 2026-04-13
