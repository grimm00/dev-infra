# ADR-002: Skill Architecture

**Status:** Accepted
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Context

ADR-001 selected ~16 skills across 4 stages. This ADR decides how those skills are structured: directory layout, naming conventions, family organization, and how multi-mode commands are decomposed.

Key constraints:

- FR-7: Multi-mode commands decompose into separate skills, one per workflow
- FR-8: SKILL.md must be operationally complete without companion files
- FR-6: Hybrid skills encode both procedural steps and behavioral contract
- FR-21: Descriptions route, bodies enforce (dual-location pattern)
- C-2: SKILL.md limited to 500 lines
- C3-2: Skill families use explicit parent reference, not automatic inheritance (spike-validated)
- CP-1: Explicit over implicit

---

## Decision

**Family directories for multi-mode commands, flat for single-mode.** Directory structure reflects actual workflow relationships (commands with modes), not conceptual role groupings.

### Directory Layout

```
.claude/skills/
├── explore/
│   ├── SKILL.md                    ← family index: orientation, shared contract
│   ├── explore-start/SKILL.md      ← setup mode
│   └── explore-amend/SKILL.md      ← amend mode
├── research/
│   ├── SKILL.md                    ← family index: orientation, shared contract
│   ├── research-setup/SKILL.md     ← setup mode
│   ├── research-conduct/SKILL.md   ← conduct mode
│   └── research-consolidate/SKILL.md ← consolidate mode
├── discuss/SKILL.md
├── int-opp/SKILL.md
├── spike/SKILL.md
├── decision/SKILL.md
├── transition-plan/SKILL.md
├── plan-review/SKILL.md
├── review/SKILL.md
├── commit/SKILL.md
├── handoff/SKILL.md
├── narrative/SKILL.md
└── reflect/SKILL.md
```

### Naming Conventions

- **Multi-mode skills:** `{command}-{mode}` (e.g., `explore-start`, `research-conduct`)
- **Single-mode skills:** `{command}` (e.g., `discuss`, `commit`)
- **Family parent:** Same name as the command group directory (e.g., `explore/SKILL.md`)
- All names use kebab-case, matching the command invocation name

### Family Parent SKILL.md

Parent serves two purposes (C3-2):

1. **Agent progressive disclosure:** Lists available sub-skills with brief descriptions, reducing search from 16 flat descriptions to family orientation then specific child
2. **Shared behavioral contract:** Family-level conventions that children opt into via explicit reference

Children include a line: `**Before responding, read .claude/skills/{family}/SKILL.md for family conventions.**`

This is explicit (CP-1), not automatic inheritance (spike-validated).

### Skill Internal Structure

Every SKILL.md follows this structure:

```markdown
---
description: "[routing info: what, when to use, when NOT to use]"
disable-model-invocation: true
---

[Optional: explicit parent reference for family members]

## Purpose
[One-line summary]

## Workflow
[Step-by-step instructions — procedural content]

## Behavioral Contract
[Observable, bounded rules — behavioral content]
[Only for hybrid/behavioral skills]

## Gotchas
[Cases where the model would do something plausible but wrong]

## References
[Pointers to companion files in assets/, if any]
```

Hybrid skills (FR-6) explicitly separate `## Workflow` from `## Behavioral Contract` so the agent can distinguish procedural steps from behavioral guardrails.

### Role-Group Mental Model

The Thinker / Researcher / Planner / Reviewer role model (C1-3) is used for:

- **Conversion ordering** (ADR-001 stages)
- **Skill design reasoning** (what does a Researcher need that a Reviewer doesn't?)
- **Documentation and onboarding** (grouping in help text or orientation docs)

It is NOT encoded in the directory structure. The file system reflects actual command-mode relationships, not conceptual role categories.

---

## Consequences

### Positive

- Families only where there's a natural multi-mode relationship — no forced grouping
- Spike-validated pattern (explicit parent reference works, automatic inheritance doesn't)
- Human-browsable: related skills are adjacent in the tree
- Agent-efficient: parent SKILL.md provides progressive disclosure
- Consistent naming: `{command}-{mode}` is predictable and discoverable
- Platform-portable: works on both Cursor (manual attachment) and Claude Code (auto-discovery)

### Negative

- Mixed structure (2 families + 12 flat skills) is less uniform than all-flat or all-nested
- Parent SKILL.md is additional maintenance per family
- Children must remember to include the explicit parent reference line

---

## Alternatives Considered

### Alternative A: Fully Flat

All 16 skills at the same level, naming prefix as the only grouping signal.

**Why not chosen:** Loses progressive disclosure and human-browsable grouping. At 16 skills the flat list is manageable but provides no organizational signal beyond naming. Families add minimal overhead for multi-mode commands and were validated by the spike.

### Alternative C: Role-Group Directories

Three-level nesting with role groups (thinker/, researcher/, etc.) as top-level directories.

**Why not chosen:** Over-engineers the file system. Role groups are a mental model for design reasoning, not a directory structure concern. Three-level nesting was not spike-tested and creates depth that agents navigate poorly. The role model informs how we think about skills, not where we store them.

---

## Requirements Impact

| Requirement | Impact |
|-------------|--------|
| FR-7 (multi-mode decomposition) | Directly satisfied — explore and research decomposed into separate skills |
| FR-8 (self-contained) | Structural constraint on every SKILL.md — must work without companion files |
| FR-6 (hybrid encoding) | Addressed by explicit Workflow / Behavioral Contract section split |
| FR-21 (dual-location description) | Description routes, body enforces — built into skill template |
| C-2 (500-line limit) | Companion files in assets/ for overflow; core workflow must fit in SKILL.md |
| C3-2 (skill families) | Validated pattern: explicit parent reference, directory grouping |
| CP-1 (explicit over implicit) | Children explicitly opt into parent contract |

---

## References

- [ADR-001: V1 Skill Selection](adr-001-v1-skill-selection.md)
- [V1 Scope](v1-scope.md) — C1-3, C3-2, CP-1
- [Nested Skill Discovery Spike](../../explorations/agentic-workflow-modernization/spike/nested-skill-discovery.md)
- [Requirements](../../research/agentic-workflow-modernization/requirements.md)

---

**Last Updated:** 2026-04-14
