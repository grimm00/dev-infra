# ADR-005: Command Integration Pattern

**Status:** ✅ Accepted  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 3 (Integration)

---

## Context

23 Cursor commands currently embed 154 inline templates, causing format drift and duplication. With template infrastructure in place (ADR-001 through ADR-004), we need to define how commands integrate with the new generation and validation tools.

**Related Research:**
- [Research: Command Integration](../../research/template-doc-infrastructure/research-command-integration.md)
- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - Finding 9

**Related Requirements:**
- FR-26: Commands invoke `dt-doc-gen` instead of inline templates
- FR-27: Commands invoke `dt-doc-validate` before commit
- FR-28: Three placeholder types (variable, AI-required, expansion)
- FR-29: Two-mode templates with expansion zones
- FR-30: Incremental migration (one command at a time)
- NFR-13: Backwards compatible migration
- NFR-14: Scripts faster than AI generation
- C-13: Commands remain orchestrators
- C-14: AI generates content, not structure

---

## Decision

**Decision:** Commands remain workflow orchestrators but delegate structure generation to scripts:

1. **Commands invoke `dt-doc-gen`** for document structure (not inline templates)
2. **AI fills placeholders** (`<!-- AI: -->` and `<!-- EXPAND: -->`)
3. **Commands invoke `dt-doc-validate`** before commit
4. **Incremental migration** (one command at a time, fallback available)
5. **Two-mode support** via expansion zones for `/explore` and `/research`

This maintains command orchestration role while achieving consistent document structure.

---

## Consequences

### Positive

- **Consistent structure:** All generated docs follow template standard (ADR-002)
- **DRY templates:** 154 inline templates → 17 external templates
- **Clear responsibility:** Scripts = structure, AI = content
- **Token efficiency:** Scripts generate structure (0 tokens), AI focuses on content
- **Validation:** `dt-doc-validate` catches drift before commit
- **Incremental:** Commands can migrate one at a time

### Negative

- **Two-step generation:** Script + AI instead of single AI generation
- **External dependency:** Commands depend on `dt-*` tools being installed
- **Migration effort:** 23 commands need updates over time
- **Coordination:** Template and command updates must stay in sync

---

## Alternatives Considered

### Alternative 1: Keep Inline Templates

**Description:** Continue current pattern with 154 inline templates.

**Pros:**
- No migration needed
- Self-contained commands
- Immediate AI feedback

**Cons:**
- 154 duplication points for format drift
- No validation possible
- Inconsistency grows over time

**Why not chosen:** This is the core problem we're solving. Research confirmed format drift and tooling failures from inconsistent docs.

---

### Alternative 2: AI-Only Generation with Validation

**Description:** AI generates docs as today, validation catches drift.

**Pros:**
- No command changes
- Single-step generation
- Validation provides feedback

**Cons:**
- AI still generates structure (inconsistent)
- Fix cycle frustrating (generate → validate → fix → validate)
- Wastes tokens on structure generation

**Why not chosen:** Doesn't solve root cause. AI should focus on content, not recreating structure each time.

---

### Alternative 3: Full Script Generation (No AI)

**Description:** Scripts generate complete docs including content.

**Pros:**
- Perfectly consistent
- Zero tokens
- Fully deterministic

**Cons:**
- Loses AI value (analysis, insights, creative content)
- Docs become formulaic
- No context-aware content

**Why not chosen:** AI-generated content is valuable. We want AI for thinking, not for formatting.

---

### Alternative 4: Hybrid (Scripts + AI) with Clear Boundaries

**Description:** Scripts generate structure, AI fills content placeholders.

**Pros:**
- Best of both: consistent structure + creative content
- Clear responsibility split
- Token efficient (structure is free)
- Validates at meaningful boundaries

**Why chosen:** Optimal balance. Scripts excel at deterministic structure, AI excels at analysis and creative content.

---

## Decision Rationale

**Key Factors:**

1. **Root cause fix:** Addresses duplication (154 → 17 templates)
2. **Responsibility clarity:** Scripts = structure, AI = content
3. **Token efficiency:** Structure generation costs 0 tokens
4. **Incremental path:** Commands can migrate one at a time
5. **Two-mode support:** Expansion zones handle setup → conduct flow

**Research Support:**

| Finding | Implication |
|---------|-------------|
| Finding 1: 154 inline templates | Confirms duplication problem |
| Finding 3: Two-mode needs expansion zones | Templates need `<!-- EXPAND: -->` markers |
| Finding 4: Commands invoke bash | Existing pattern for script invocation |
| Finding 7: Command-script split | Commands = orchestrators, scripts = tools |

---

## Integration Architecture

```
┌────────────────────────────────────────────────────────────────────┐
│  Command (e.g., /explore)                                          │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 1. Parse arguments (topic, mode)                              │  │
│  │ 2. Invoke dt-doc-gen for structure                            │  │
│  │ 3. Read generated structure                                   │  │
│  │ 4. Fill AI placeholders (<!-- AI: -->, <!-- EXPAND: -->)      │  │
│  │ 5. Write completed document                                   │  │
│  │ 6. Invoke dt-doc-validate                                     │  │
│  │ 7. Commit if valid                                            │  │
│  └──────────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────┘
              │                               │
              ▼                               ▼
┌─────────────────────────┐     ┌─────────────────────────────────┐
│  dt-doc-gen             │     │  AI (via Cursor)                │
│  ─────────────────────  │     │  ─────────────────────────────  │
│  • Template selection   │     │  • Fill <!-- AI: --> zones      │
│  • ${VAR} expansion     │     │  • Fill <!-- EXPAND: --> zones  │
│  • Mode handling        │     │  • Context-aware content        │
│  • Output file creation │     │  • Analysis and insights        │
└─────────────────────────┘     └─────────────────────────────────┘
              │                               │
              └───────────────┬───────────────┘
                              ▼
┌────────────────────────────────────────────────────────────────────┐
│  dt-doc-validate                                                    │
│  ──────────────────────────────────────────────────────────────────│
│  • Verify structure compliance                                      │
│  • Check required sections                                          │
│  • Validate status/date formats                                     │
│  • Report actionable errors                                         │
└────────────────────────────────────────────────────────────────────┘
```

---

## Command Workflow Changes

### Before (Current Pattern)

```markdown
## Step 2: Create Scaffolding

Create the exploration scaffolding:

**File:** `admin/explorations/[topic]/exploration.md`

\`\`\`markdown
# Exploration: [Topic]

**Status:** 🔴 Scaffolding
**Created:** YYYY-MM-DD
...
\`\`\`
```

### After (New Pattern)

```markdown
## Step 2: Generate Scaffolding

Generate the exploration structure:

\`\`\`bash
dt-doc-gen exploration ${TOPIC} --mode setup --output admin/explorations/
\`\`\`

Read the generated files and fill AI placeholders:
- Replace `<!-- AI: Write 2-3 sentence summary -->` with actual summary
- Replace `<!-- AI: Identify 3-5 themes -->` with discovered themes

## Step 6: Validate Before Commit

\`\`\`bash
dt-doc-validate exploration admin/explorations/${TOPIC}/
\`\`\`
```

---

## Two-Mode Template Support

For `/explore` and `/research` commands with setup → conduct flow:

### Setup Mode

Template has expansion zones marked but not filled:

```markdown
## 🔍 Initial Themes

### Theme 1: ${THEME_1_NAME}

<!-- AI: Brief 1-2 sentence description -->

<!-- EXPAND: themes
Add detailed analysis in conduct mode:
- Connections to other themes
- Implications and risks
- Related questions
-->
```

**Script action:** Expand `${VAR}`, preserve `<!-- AI: -->` and `<!-- EXPAND: -->`
**AI action:** Fill `<!-- AI: -->` zones only

### Conduct Mode

AI expands the expansion zones:

```markdown
## 🔍 Initial Themes

### Theme 1: Authentication Complexity

Modern authentication requires balancing security with user experience...

<!-- EXPAND: themes → FILLED -->

**Detailed Analysis:**

The authentication theme connects to several critical areas:

1. **Security implications**: Multi-factor authentication adds friction...
2. **Integration patterns**: OAuth2/OIDC vs. custom auth...
3. **User experience**: Balance between security and convenience...

**Key Questions:**
- How do we handle session management across microservices?
- What's the migration path from legacy auth?
```

**Script action:** Identify `<!-- EXPAND: -->` zones for AI
**AI action:** Fill both `<!-- AI: -->` and `<!-- EXPAND: -->` zones

---

## Migration Strategy

### Phase 1: Template Extraction (No Command Changes)

**Actions:**
- Create template files in `scripts/doc-gen/templates/`
- Validate templates produce identical output to current commands
- No changes to commands

**Timeline:** 1-2 weeks
**Risk:** Low (parallel development)

### Phase 2: Pilot Migration (2 Commands)

**Commands:** `/explore`, `/research` (two-mode, highest value)

**Actions:**
- Update commands to invoke `dt-doc-gen`
- Add `dt-doc-validate` before commit step
- Keep inline template as fallback (commented out)
- Validate workflow works end-to-end

**Timeline:** 2-3 weeks
**Risk:** Medium (pilot reveals issues)

### Phase 3: Incremental Rollout (Remaining Commands)

**Order:**
1. High-value docs: `/decision`, `/transition-plan` (planning docs)
2. Common workflows: `/handoff`, `/fix-plan` (frequent use)
3. Status updates: `/post-pr`, `/status` (simple structure)
4. Remaining: All others

**Actions:**
- Migrate one command per sprint
- Remove inline template fallback after validation
- Update command documentation

**Timeline:** 2-3 months
**Risk:** Low (incremental, proven pattern)

### Phase 4: Cleanup

**Actions:**
- Remove all inline templates from commands
- Commands reference templates by name only
- Update command documentation to reflect new pattern

**Timeline:** 1 week (after all commands migrated)

---

## Placeholder Standard

Per ADR-002, three placeholder types:

| Type | Syntax | When Expanded | By Whom |
|------|--------|---------------|---------|
| **Variable** | `${VAR}` | Generation time | dt-doc-gen (envsubst) |
| **AI Content** | `<!-- AI: instruction -->` | After generation | AI in command |
| **Expansion Zone** | `<!-- EXPAND: scope -->` | Conduct mode | AI in command |

**Placeholder lifecycle:**

```
Template (dev-infra)
    │
    │ dt-doc-gen --mode setup
    ▼
Generated Doc (${VAR} expanded, AI placeholders preserved)
    │
    │ AI fills <!-- AI: --> zones
    ▼
Setup Complete (structure + AI content, EXPAND zones preserved)
    │
    │ dt-doc-gen --mode conduct OR AI reads EXPAND zones
    ▼
Conduct Complete (all zones filled)
    │
    │ dt-doc-validate
    ▼
Validated Doc (ready to commit)
```

---

## Command Responsibility Matrix

| Responsibility | Before | After |
|----------------|--------|-------|
| Workflow orchestration | Command | Command ✓ |
| User prompts | Command | Command ✓ |
| Document structure | AI (inline template) | Script (dt-doc-gen) |
| Creative content | AI | AI ✓ |
| Analysis/insights | AI | AI ✓ |
| Validation | None | Script (dt-doc-validate) |
| Commit/push | Command | Command ✓ |

**Commands remain orchestrators.** Only structure generation and validation move to scripts.

---

## Requirements Impact

**Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-26 | Commands invoke `dt-doc-gen` (documented in workflow changes) |
| FR-27 | Commands invoke `dt-doc-validate` before commit |
| FR-28 | Three placeholder types standardized |
| FR-29 | `<!-- EXPAND: -->` zones for two-mode commands |
| FR-30 | 4-phase incremental migration plan |
| NFR-13 | Fallback available during migration |
| NFR-14 | Scripts are sub-second, AI generation is seconds |
| C-13 | Commands remain workflow orchestrators |
| C-14 | AI fills placeholders, doesn't generate structure |

---

## Implementation Notes

**For dev-infra (this feature):**
- Create templates for pilot commands (`/explore`, `/research`)
- Document template-command mapping
- Create migration guide for command authors

**For dev-toolkit (separate feature):**
- Implement `dt-doc-gen` and `dt-doc-validate`
- Test with pilot commands

**For command migration (per-command work):**
- Update command markdown to invoke scripts
- Test end-to-end workflow
- Remove inline templates after validation

---

## References

- [Research: Command Integration](../../research/template-doc-infrastructure/research-command-integration.md)
- [ADR-001: Architectural Placement](adr-001-architectural-placement.md)
- [ADR-002: Template Structure Standard](adr-002-template-structure-standard.md)
- [ADR-003: Generation Architecture](adr-003-generation-architecture.md)
- [ADR-004: Validation Architecture](adr-004-validation-architecture.md)
- [Requirements Document](../../research/template-doc-infrastructure/requirements.md)

---

**Last Updated:** 2026-01-14
