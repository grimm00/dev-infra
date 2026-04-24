# ADR-003: Content Redistribution

**Status:** Accepted
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Context

Dev-infra currently uses three always-applied `.mdc` rules files (`main.mdc`, `workflow.mdc`, `template.mdc`) totaling ~1,500+ lines. These are loaded into every agent conversation regardless of task, consuming context window and mixing concerns. The interview established aggressive slimming is acceptable (C4-1), mutable state must be removed (C4-2), and AGENTS.md is needed alongside CLAUDE.md (C4-3).

Key requirements:

- FR-4: Rules content must be separated into four types
- FR-5: Mutable project state must be removed from always-on context
- FR-1: AGENTS.md content must be inline (no file references)
- FR-3: Passive background knowledge may use auto-detection
- C-1: CLAUDE.md needed for Claude Code portability
- C-4: Dual-file strategy (AGENTS.md + CLAUDE.md)
- A-1: Cursor reads AGENTS.md at lowest priority

---

## Decision

**Aggressive rules slimming for v1.** Redistribute content into four destinations per FR-4, leaving `.mdc` rules minimal.

### Four-Type Redistribution

| Content Type | Current Location | V1 Destination | Examples |
|---|---|---|---|
| **Portable conventions** | `main.mdc`, `workflow.mdc` | AGENTS.md + CLAUDE.md | Git flow, naming, hub-and-spoke pattern, commit format |
| **Cursor-specific config** | `main.mdc` | Trimmed `.mdc` rule (~50 lines) | Response style, mode-switching hints, tool preferences |
| **Procedural reference** | `workflow.mdc`, `template.mdc` | Skill bodies and `assets/` | Command workflows, checklists, templates |
| **Mutable project state** | `main.mdc` (Current Project State section) | Removed entirely | Version numbers, completion status, planned features |

### What Stays in `.mdc` Rules

Only Cursor-specific behavioral config that has no other home:

- Agent response style preferences
- Tool usage preferences (e.g., "prefer specialized tools over terminal")
- Mode-switching hints (plan mode for complex tasks)
- Pointer to AGENTS.md for shared conventions

Target: ~50 lines total, down from ~1,500+.

### What Goes to AGENTS.md / CLAUDE.md

Portable conventions shared between human and agent:

- Git Flow branching strategy and commit format
- Hub-and-spoke documentation pattern
- Status indicators and date format
- File naming conventions (kebab-case)
- Project structure overview (directory map)
- Template development standards

Content is written inline (FR-1), not as file references. AGENTS.md and CLAUDE.md are kept in sync (C-4) -- initially manually, with template sync validation as a future enforcement mechanism.

### What Gets Removed

Mutable project state (FR-5):

- Current version number and release history
- Task completion status and planned features
- "Current Project State" section entirely

Replaced with a single pointer: `Current state: see admin/planning/status-and-next-steps.md`

### Passive Background Knowledge

Background knowledge extracted from rules (e.g., documentation patterns, structural conventions) may become auto-detected skills (FR-3) in the future. For v1, this content moves to AGENTS.md where it's always available without consuming skill slots.

---

## Consequences

### Positive

- Context window savings: ~1,500 lines reduced to ~50 always-on lines
- Agents no longer reason with stale project state
- Shared conventions are portable across platforms (AGENTS.md + CLAUDE.md)
- Skills carry their own procedural content, reducing dependency on rules
- Clean separation: rules for platform config, AGENTS.md for conventions, skills for workflows

### Negative

- AGENTS.md + CLAUDE.md dual maintenance (C-4) until a generation script or sync tool exists
- Some conventions may be missed during the redistribution -- requires careful audit
- Cursor reads AGENTS.md at lowest priority (A-1), so `.mdc` rules must not contradict it

---

## Alternatives Considered

### Alternative B: Rules as Transition Bridge

Keep rules somewhat intact during v1, slim incrementally as skills prove out.

**Why not chosen:** The interview was clear about aggressive slimming (C4-1). There's no backward compatibility constraint (C2-1), so no reason to maintain a bridge. The transition bridge approach adds complexity without benefit for a sole user.

---

## Requirements Impact

| Requirement | Impact |
|-------------|--------|
| FR-4 (four-type separation) | Directly satisfied -- all four types mapped to destinations |
| FR-5 (remove mutable state) | Directly satisfied -- removed entirely with pointer replacement |
| FR-1 (AGENTS.md inline) | Directly satisfied -- content written inline |
| FR-3 (passive auto-detect) | Deferred -- background knowledge starts in AGENTS.md, may become skills later |
| C-1, C-4 (dual-file) | Satisfied -- both files maintained with synchronized content |

---

## References

- [V1 Scope](v1-scope.md) -- C4-1, C4-2, C4-3
- [Requirements](../../research/agentic-workflow-modernization/requirements.md)
- [Topic 2: Redistribution Criteria](../../research/agentic-workflow-modernization/topic-2-redistribution-criteria.md)

---

**Last Updated:** 2026-04-14
