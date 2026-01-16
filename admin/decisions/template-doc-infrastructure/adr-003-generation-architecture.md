# ADR-003: Generation Architecture

**Status:** 🔴 Proposed  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 2 (Implementation)

---

## Context

Template documentation infrastructure needs scripts to generate documents from templates. Research identified a shared library architecture with sed/envsubst-based variable expansion. We need to decide on the generation architecture.

**Related Research:**
- [Research: Generation Architecture](../../research/template-doc-infrastructure/research-generation-architecture.md)
- [Research: Template Format](../../research/template-doc-infrastructure/research-template-format.md)
- [Research: Cursor CLI & Model Selection](../../research/template-doc-infrastructure/research-cursor-cli-model-selection.md)
- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - Findings 3, 4, 5, 6, 10, 11

**Related Requirements:**
- FR-6: Single entry point with subcommand interface
- FR-7: Template file path passed to generator
- FR-8: Scaffolding and full generation modes
- FR-9: Optional --validate flag for post-generation validation
- FR-10: Consistent output format (created file path, any warnings)
- FR-31: Model selection configuration file
- FR-32: Command documentation includes recommended model
- FR-33: Future programmatic model selection support
- NFR-4: Generation completes in <500ms for scaffolding
- NFR-5: Standard bash (no exotic dependencies)
- NFR-6: Compatible with macOS and Linux
- NFR-7: Scriptable (no interactive prompts in non-interactive mode)
- NFR-8: Error messages actionable and clear
- NFR-15: Model selection not blocking
- NFR-16: User-customizable model config
- C-17: No Python/binary dependencies for templates
- C-18: No syntax conflicts with markdown/shell

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

### Alternative 1: Inline Templates (Current Pattern)

**Description:** Keep templates embedded in Cursor commands as heredocs.

**Pros:**
- No external dependencies
- Self-contained commands
- Currently works

**Cons:**
- 154 inline templates = massive duplication
- Format drift between commands
- Hard to maintain consistency

**Why not chosen:** [To be filled]

---

### Alternative 2: External Templates + jinja2

**Description:** Templates as files, rendered with jinja2.

**Pros:**
- Powerful templating (conditionals, loops)
- Industry standard
- Rich ecosystem

**Cons:**
- Python dependency
- Overkill for simple variable expansion
- Learning curve for authors

**Why not chosen:** [To be filled]

---

### Alternative 3: External Templates + envsubst

**Description:** Templates as files, rendered with envsubst.

**Pros:**
- Simple, no dependencies (gettext)
- Standard POSIX syntax (`${VAR}`)
- Fast execution

**Cons:**
- No conditionals/loops
- No default values in syntax

**Why not chosen:** [Or: Why chosen - to be filled]

---

### Alternative 4: External Templates + sed

**Description:** Templates as files, rendered with sed.

**Pros:**
- No dependencies
- Proven in current scripts
- Full regex power

**Cons:**
- Platform differences (GNU vs BSD)
- Complex escaping
- Less readable

**Why not chosen:** [To be filled]

---

## Decision Rationale

<!-- FILL: Explain why this decision was made -->

**Key Factors:**
- [Factor 1]
- [Factor 2]

**Research Support:**
- Finding 3: Shared library architecture
- Finding 4: Hybrid command integration
- Finding 11: envsubst recommended

---

## Generation Architecture

<!-- FILL: Define the architecture -->

```
scripts/doc-gen/
├── lib/
│   ├── common.sh         # Shared utilities
│   ├── render.sh         # Template rendering (envsubst)
│   └── validate.sh       # Validation functions
├── templates/            # Template files by workflow
│   ├── exploration/
│   ├── research/
│   ├── decision/
│   ├── planning/
│   └── common/
├── dt-doc-gen            # Unified entry point
└── dt-doc-validate       # Validation entry point
```

---

## Generation Modes

<!-- FILL: Define modes -->

| Mode | Purpose | When Used |
|------|---------|-----------|
| Scaffolding | Create structure with placeholders | Setup mode |
| Full | Fill all content | Conduct mode |

---

## Model Selection (Future Enhancement)

<!-- FILL: Document model selection approach -->

**Current:** Manual model selection in Cursor settings

**Future:** Config-based model selection (`models.yaml`)

| Task Type | Recommended Model |
|-----------|-------------------|
| explore, research, decision | claude-opus-4 |
| naming, creative | gemini-2.5-pro |
| pr, post-pr, release-prep | claude-sonnet-4 |
| task-phase, implement | composer-1 |

**Status:** Enhancement, not blocker (per NFR-15)

---

## Requirements Impact

<!-- FILL: Document requirements affected -->

**Requirements Addressed:**
- FR-6 through FR-10 (generation features)
- FR-31 through FR-33 (model selection)
- NFR-4 through NFR-8 (generation quality)
- NFR-15, NFR-16 (model selection)
- C-17, C-18 (dependency constraints)

---

## References

- [Research: Generation Architecture](../../research/template-doc-infrastructure/research-generation-architecture.md)
- [Research: Template Format](../../research/template-doc-infrastructure/research-template-format.md)
- [Research: Cursor CLI & Model Selection](../../research/template-doc-infrastructure/research-cursor-cli-model-selection.md)

---

**Last Updated:** 2026-01-14
