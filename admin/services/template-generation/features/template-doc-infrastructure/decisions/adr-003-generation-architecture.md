# ADR-003: Generation Architecture

**Status:** ✅ Accepted  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 2 (Implementation)

---

## Context

Template documentation infrastructure needs scripts to generate documents from templates. Research identified multiple approaches: standalone scripts, shared libraries, unified entry points, and various template rendering options. We need to decide on the generation architecture.

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

**Decision:** Adopt a **shared library architecture with template files and unified entry point**:

1. **Shared library** (`lib/`) for common functions
2. **Template files** (`.tmpl`) for each document type
3. **Unified CLI** (`dt-doc-gen`) with subcommand interface
4. **envsubst** for variable expansion (simple, portable)
5. **Two generation modes:** scaffolding and full

This approach provides DRY code, maintainable templates, and consistent generation across all document types.

---

## Consequences

### Positive

- **DRY code:** Common functions shared via library
- **Maintainable templates:** Templates as separate files, easy to edit
- **Consistent CLI:** Single entry point (`dt-doc-gen exploration my-topic`)
- **Simple rendering:** envsubst is universally available, no dependencies
- **Two modes:** Support both scaffolding (setup) and full generation (conduct)
- **Testable:** Library functions can be unit tested with BATS
- **CI-friendly:** Clear exit codes, non-interactive mode

### Negative

- **Library management:** Must manage dependencies between lib files
- **Template proliferation:** 17+ template files to maintain
- **envsubst limitations:** No conditionals or loops (but not needed)
- **Cross-platform testing:** Must validate on both macOS and Linux

---

## Alternatives Considered

### Alternative 1: Standalone Scripts per Doc Type

**Description:** Separate script for each workflow (`gen-exploration.sh`, `gen-research.sh`, etc.)

**Pros:**
- Clear ownership - one script per workflow
- Easy to test in isolation
- Simple mental model

**Cons:**
- Code duplication (common patterns repeated)
- 5+ scripts to maintain
- No shared infrastructure

**Why not chosen:** Doesn't scale well. DRY principle violated as more doc types added.

---

### Alternative 2: Inline Templates (Current Pattern)

**Description:** Keep templates embedded in Cursor commands as heredocs.

**Pros:**
- No external dependencies
- Self-contained commands
- Currently works

**Cons:**
- 154 inline templates = massive duplication
- Format drift between commands
- Hard to maintain consistency
- No validation possible

**Why not chosen:** This is the core problem we're solving. Research identified 154 inline template instances causing inconsistency.

---

### Alternative 3: Complex Template Engine (jinja2)

**Description:** Use jinja2 or similar for advanced template features.

**Pros:**
- Full template power (conditionals, loops, filters)
- Industry standard
- Rich ecosystem

**Cons:**
- Python dependency
- Overkill for simple variable expansion
- Learning curve for template authors
- Violates NFR-5 (standard bash)

**Why not chosen:** Overkill. Research confirmed we don't need conditionals or loops. Simple variable expansion is sufficient.

---

### Alternative 4: sed-based Replacement

**Description:** Use sed for variable expansion with `{{VAR}}` syntax.

**Pros:**
- No dependencies
- Proven in current scripts (`new-project.sh`)
- Full regex power

**Cons:**
- Platform differences (GNU vs BSD sed)
- Complex escaping for special characters
- Less readable than envsubst

**Why not chosen:** Platform differences add complexity. envsubst is more portable and cleaner syntax.

---

## Decision Rationale

**Key Factors:**

1. **Simplicity over power:** envsubst is sufficient; no need for jinja2 complexity
2. **Maintainability:** Shared library + separate templates is most maintainable
3. **Portability:** envsubst works on macOS and Linux without modification
4. **Consistency with ADR-002:** Template structure already defines placeholder types

**Research Support:**

| Finding | Implication |
|---------|-------------|
| Finding 3: Shared library recommended | Use `lib/` for common functions |
| Finding 4: Hybrid command integration | Scripts generate, AI fills content |
| Finding 5: Scripts as orchestration | Scripts handle structure, AI handles creative |
| Finding 11: envsubst recommended | Simple, portable variable expansion |

---

## Generation Architecture

```
dev-toolkit/                        # Per ADR-001: Tooling in dev-toolkit
├── bin/
│   └── dt-doc-gen                  # Unified entry point (CLI)
├── lib/
│   ├── doc-common.sh               # Colors, logging, utilities
│   ├── doc-render.sh               # Template rendering (envsubst)
│   └── doc-templates.sh            # Template fetching/management
└── config/
    └── templates/                  # Cached templates from dev-infra
        ├── exploration/
        ├── research/
        ├── decision/
        └── planning/
```

**Template Source (per ADR-001):**

```
dev-infra/
└── scripts/doc-gen/templates/      # Template source of truth
    ├── exploration/
    │   ├── README.md.tmpl
    │   ├── exploration.md.tmpl
    │   └── research-topics.md.tmpl
    ├── research/
    │   ├── README.md.tmpl
    │   ├── research-topic.md.tmpl
    │   ├── research-summary.md.tmpl
    │   └── requirements.md.tmpl
    ├── decision/
    │   └── ...
    └── planning/
        └── ...
```

---

## CLI Interface

```bash
# Generate exploration scaffolding
dt-doc-gen exploration my-topic --mode setup

# Generate full research doc
dt-doc-gen research my-topic --mode full --topic-title "User Authentication"

# Generate with validation
dt-doc-gen exploration my-topic --validate

# Show what would be created (dry-run)
dt-doc-gen exploration my-topic --dry-run

# Use specific output directory
dt-doc-gen exploration my-topic --output admin/explorations/
```

**Subcommands:**

| Subcommand | Purpose | Templates |
|------------|---------|-----------|
| `exploration` | Generate exploration docs | README, exploration.md, research-topics.md |
| `research` | Generate research docs | README, research-*.md, summary, requirements |
| `decision` | Generate ADR docs | README, adr-NNN.md, summary |
| `planning` | Generate feature docs | README, feature-plan.md, phase-N.md |
| `handoff` | Generate handoff doc | handoff.md |

---

## Generation Modes

| Mode | Purpose | When Used | Content |
|------|---------|-----------|---------|
| **setup** | Create structure with placeholders | `/explore --setup`, `/research --setup` | `${VAR}` expanded, `<!-- AI: -->` preserved |
| **full** | Create structure + fill all content | ADRs, transition plans | `${VAR}` expanded, AI fills `<!-- AI: -->` zones |

**Mode flow:**

```
Setup Mode:
  Template → envsubst (${VAR}) → Output with AI placeholders

Full Mode:
  Template → envsubst (${VAR}) → AI fills <!-- AI: --> → Final output
```

---

## Template Rendering

**envsubst approach:**

```bash
render_template() {
    local template="$1"
    local output="$2"
    
    # Export variables
    export DATE=$(date +%Y-%m-%d)
    export TOPIC="$topic"
    export STATUS="🔴 Scaffolding"
    
    # Render with envsubst
    envsubst < "$template" > "$output"
}
```

**Variable types (per ADR-002):**

| Type | Syntax | Expanded By | Example |
|------|--------|-------------|---------|
| Script variable | `${VAR}` | dt-doc-gen (envsubst) | `${DATE}`, `${TOPIC}` |
| AI content | `<!-- AI: instruction -->` | AI (preserved by generator) | `<!-- AI: Summarize -->` |
| Expansion zone | `<!-- EXPAND: scope -->` | AI in Conduct mode | `<!-- EXPAND: Findings -->` |

---

## Model Selection (Future Enhancement)

Per research Finding 10, Cursor CLI doesn't support programmatic model selection. Config-based approach for future:

**Config file (`~/.config/dt-workflow/models.yaml`):**

```yaml
task_models:
  explore: claude-opus-4
  research: claude-opus-4
  decision: claude-opus-4
  pr: claude-sonnet-4
  task-phase: composer-1
default: claude-sonnet-4
```

**Status:** Enhancement, not blocker (per NFR-15). Command documentation will include recommended models (FR-32).

---

## Requirements Impact

**Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-6 | `dt-doc-gen` with subcommand interface |
| FR-7 | Templates passed via workflow type |
| FR-8 | `--mode setup` and `--mode full` flags |
| FR-9 | `--validate` flag calls dt-doc-validate |
| FR-10 | Consistent output: file path, warnings |
| FR-31 | Config file pattern defined (future) |
| FR-32 | Commands to document recommended models |
| NFR-4 | envsubst is fast (<500ms easily) |
| NFR-5 | Standard bash + envsubst (gettext) |
| NFR-6 | envsubst works on macOS and Linux |
| NFR-7 | Non-interactive by default |
| NFR-8 | Clear error messages with suggestions |
| C-17 | No Python/binary dependencies |
| C-18 | `${VAR}` doesn't conflict with markdown |

---

## Implementation Notes

**For dev-infra (this feature):**
- Create template files in `scripts/doc-gen/templates/`
- Define variable conventions in template documentation
- Version templates with dev-infra releases

**For dev-toolkit (separate feature):**
- Create `dt-doc-gen` CLI script
- Create `lib/doc-*.sh` shared functions
- Implement template fetching from dev-infra
- Implement envsubst-based rendering

---

## References

- [Research: Generation Architecture](../../research/template-doc-infrastructure/research-generation-architecture.md)
- [Research: Template Format](../../research/template-doc-infrastructure/research-template-format.md)
- [ADR-001: Architectural Placement](adr-001-architectural-placement.md)
- [ADR-002: Template Structure Standard](adr-002-template-structure-standard.md)
- [Requirements Document](../../research/template-doc-infrastructure/requirements.md)

---

**Last Updated:** 2026-01-14
