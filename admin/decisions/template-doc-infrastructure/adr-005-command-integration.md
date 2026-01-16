# ADR-005: Command Integration Pattern

**Status:** 🔴 Proposed  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 3 (Integration)

---

## Context

23 Cursor commands currently embed 154 inline template instances. We need to decide how commands should integrate with the new template infrastructure (generation scripts, validation).

**Related Research:**
- [Research: Command Integration](../../research/template-doc-infrastructure/research-command-integration.md)
- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - Findings 4, 9

**Related Requirements:**
- FR-26: Commands invoke generation scripts via bash blocks
- FR-27: Commands call validation before commit
- FR-28: Script placeholders (`${VAR}`) distinct from AI placeholders
- FR-29: Expansion zones in two-mode commands
- FR-30: Incremental migration (one command at a time)
- NFR-13: Backwards compatibility during migration
- NFR-14: Script invocation faster than AI template generation
- C-13: Commands remain orchestrators, scripts are tools
- C-14: AI must not generate document structure

---

## Decision

<!-- FILL: State the decision clearly -->

**Decision:** [To be filled]

---

## Consequences

### Positive

<!-- FILL: List positive consequences -->

- [Positive consequence 1]
- [Positive consequence 2]

### Negative

<!-- FILL: List negative consequences -->

- [Negative consequence 1]
- [Negative consequence 2]

---

## Alternatives Considered

### Alternative 1: Keep Inline Templates

**Description:** Continue embedding templates in command markdown files.

**Pros:**
- No migration work
- Self-contained commands
- Currently works

**Cons:**
- 154 template instances to maintain
- Format drift inevitable
- Inconsistent outputs

**Why not chosen:** [To be filled]

---

### Alternative 2: Full Migration (Big Bang)

**Description:** Migrate all 23 commands at once.

**Pros:**
- One-time effort
- Consistent after migration
- No dual-support needed

**Cons:**
- High risk
- Large change
- Hard to rollback

**Why not chosen:** [To be filled]

---

### Alternative 3: Incremental Migration

**Description:** Migrate one command at a time over multiple releases.

**Phase 1:** Extract templates to files (no command changes)
**Phase 2:** Commands call scripts (with fallback to inline)
**Phase 3:** Remove inline templates (after validation)

**Pros:**
- Low risk per change
- Easy rollback
- Gradual learning

**Cons:**
- Longer total duration
- Dual-support period
- Complexity managing both patterns

**Why not chosen:** [Or: Why chosen - to be filled]

---

## Decision Rationale

<!-- FILL: Explain why this decision was made -->

**Key Factors:**
- [Factor 1]
- [Factor 2]

**Research Support:**
- Finding 4: Hybrid command integration
- Finding 9: 154 inline templates identified

---

## Integration Pattern

<!-- FILL: Define the pattern -->

```
┌─────────────────────────────────────────────────────────────┐
│ Cursor Command (e.g., /explore)                             │
│                                                             │
│ 1. Parse input (topic, flags)                               │
│ 2. Call dt-doc-gen to create structure                      │
│    └─ bash: dt-doc-gen exploration $TOPIC                   │
│ 3. AI fills content in expansion zones                      │
│ 4. Call dt-doc-validate to check compliance                 │
│    └─ bash: dt-doc-validate path/to/file.md                 │
│ 5. Git commit                                               │
└─────────────────────────────────────────────────────────────┘
```

---

## Placeholder Types

<!-- FILL: Define placeholder types -->

| Type | Syntax | Expanded By | Example |
|------|--------|-------------|---------|
| Script variable | `${VAR}` | dt-doc-gen | `${DATE}`, `${TOPIC}` |
| AI content | `<!-- AI: instruction -->` | AI | `<!-- AI: Summarize findings -->` |
| Expansion zone | `<!-- EXPAND: scope -->` | AI (Conduct) | `<!-- EXPAND: Research methodology -->` |

---

## Migration Phases

<!-- FILL: Define migration phases -->

### Phase 1: Extract Templates

- Create external template files
- No command changes
- Validate templates work with generator

**Risk:** None (no command changes)

### Phase 2: Integrate Commands

- Update commands to call dt-doc-gen
- Keep inline templates as fallback
- Start with high-impact commands

**Priority commands:**
1. `/explore` - Two-mode, complex templates
2. `/research` - Two-mode, multiple templates
3. `/decision` - ADR templates

**Risk:** Low (fallback available)

### Phase 3: Cleanup

- Remove inline templates
- Update command documentation
- Final validation

**Risk:** Low (after thorough testing)

---

## Commands Audit

<!-- FILL: Document command audit results -->

| Command | Templates | Priority | Migration Phase |
|---------|-----------|----------|-----------------|
| /explore | 3 | High | Phase 2a |
| /research | 4 | High | Phase 2a |
| /decision | 3 | High | Phase 2b |
| ... | ... | ... | ... |

**Total:** 23 commands, 154 template instances

---

## Requirements Impact

<!-- FILL: Document requirements affected -->

**Requirements Addressed:**
- FR-26 through FR-30 (command integration)
- NFR-13, NFR-14 (migration quality)
- C-13, C-14 (command role)

---

## References

- [Research: Command Integration](../../research/template-doc-infrastructure/research-command-integration.md)
- [Command Audit Results](../../research/template-doc-infrastructure/research-command-integration.md#command-audit)

---

**Last Updated:** 2026-01-14
