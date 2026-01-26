# ADR-001: Architectural Placement (Four-Arm Question)

**Status:** ✅ Accepted  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 1 (Foundation)

---

## Context

Template documentation infrastructure requires multiple components: templates, generation scripts, validation scripts, and command integration. The question is where these components should live within the four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod).

**The Four Arms:**

| Arm | Identity | Purpose |
|-----|----------|---------|
| **dev-infra** | Template Factory | Templates, patterns, shared contracts |
| **dev-toolkit** | Developer CLI | Bash utilities for daily development |
| **proj-cli** | Project Management | Python CLI for project lifecycle |
| **work-prod** | Data API | Flask backend for centralized data |

**Related Research:**
- [Research: Architectural Placement](../../research/template-doc-infrastructure/research-architectural-placement.md)
- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - Finding 7

**Related Requirements:**
- FR-15: Templates must reside in dev-infra
- FR-16: Tooling must reside in dev-toolkit
- FR-17: Tooling must fetch templates from dev-infra
- FR-18: Tooling must follow dt-* naming convention
- NFR-9: Independent versioning for templates and tooling
- NFR-10: Tooling must be compatible with templates from dev-infra
- C-7: Scripts generate structure, AI fills content
- C-8: No template duplication across repos
- C-9: No orchestration logic in dev-infra

---

## Decision

**Decision:** Split template documentation infrastructure across two repositories:
- **Templates** (source of truth) → **dev-infra** (`scripts/doc-gen/templates/`)
- **Tooling** (generation, validation, orchestration) → **dev-toolkit** (`bin/dt-doc-gen`, `bin/dt-doc-validate`)

This follows the established **source vs distribution** pattern from ADR-001 (Command Distribution Ownership) and aligns with dev-infra's "Template Factory" identity.

---

## Consequences

### Positive

- **Follows precedent:** Aligns with dt-review pattern (workflow tool in dev-toolkit)
- **Respects identity:** dev-infra remains "Template Factory" (ADR-001 Project Identity)
- **Independent versioning:** Template changes don't require tooling releases
- **Clear ownership:** dev-infra owns WHAT templates look like, dev-toolkit owns HOW to generate them
- **Mature infrastructure:** dev-toolkit has install.sh, dt-* naming, config management
- **Reusable tooling:** dt-doc-gen can work with templates from any source

### Negative

- **Cross-repo coordination:** Changes may require PRs in both repos
- **Template fetching:** Tooling must fetch templates from dev-infra
- **Versioning complexity:** Must track template version compatibility
- **Two worktrees needed:** Feature development may require parallel work

---

## Alternatives Considered

### Alternative 1: Everything in dev-infra

**Description:** Keep all template infrastructure (templates + tooling) in dev-infra.

**Pros:**
- Single source
- Simpler dependency
- Atomic changes to templates and tooling

**Cons:**
- Violates ADR-001 (Project Identity): "Internal tooling stays internal"
- Makes dev-infra bloated with non-template concerns
- Conflates templates (products) with tooling (internal infrastructure)

**Why not chosen:** Directly contradicts the established "Template Factory" identity. ADR-001 explicitly states that workflow tooling should not become template features.

---

### Alternative 2: Everything in dev-toolkit

**Description:** Keep all template infrastructure (templates + tooling) in dev-toolkit.

**Pros:**
- Follows dt-* convention
- Keeps tooling together
- Simpler distribution

**Cons:**
- Violates dev-infra's "Template Factory" identity
- Templates are not tooling - they're the product
- Breaks source-of-truth pattern for templates

**Why not chosen:** Templates belong in dev-infra as products. dev-toolkit should consume templates, not own them.

---

### Alternative 3: New Repository (workflow-tools)

**Description:** Create a new repository specifically for workflow tooling.

**Pros:**
- Clean separation
- Independent evolution
- No conflicts with existing identity

**Cons:**
- Yet another repository to manage
- Fragments the ecosystem
- No existing infrastructure

**Why not chosen:** Unnecessary complexity. dev-toolkit already exists and has the right identity for this tooling.

---

### Alternative 4: proj-cli (Python)

**Description:** Build tooling in proj-cli using Python.

**Pros:**
- Python ecosystem
- Rich CLI libraries (click, typer)
- Type safety

**Cons:**
- Different language (Python vs Bash)
- proj-cli is for project lifecycle, not doc workflows
- Doesn't fit conceptually

**Why not chosen:** Wrong domain. proj-cli is for project lifecycle management, not document generation workflows.

---

## Decision Rationale

**Key Factors:**

1. **ADR-001 (Project Identity)** explicitly excludes workflow tooling from dev-infra's scope
2. **ADR-001 (Command Distribution)** established the source/distribution separation pattern
3. **dt-review precedent** shows workflow tools belong in dev-toolkit
4. **dev-toolkit infrastructure** already handles dt-* commands, installation, config

**Research Support:**

| Finding | Implication |
|---------|-------------|
| Finding 1: Dev-infra = Template Factory | Tooling doesn't belong in dev-infra |
| Finding 2: Source vs Distribution pattern | Templates = source (dev-infra), Tooling = distribution (dev-toolkit) |
| Finding 3: dt-review lives in dev-toolkit | Clear precedent for placement |
| Finding 4: dev-toolkit has mature infra | Natural home for new tooling |
| Finding 5: Versioning benefits | Independent releases make sense |

---

## Component Placement

```
┌─────────────────────────────────────────────────────────────────┐
│                         dev-infra                                │
│                   (Template Factory - SOURCE)                    │
│                                                                  │
│  scripts/doc-gen/templates/                                      │
│  ├── exploration/                                                │
│  │   ├── README.md.tmpl                                         │
│  │   ├── exploration.md.tmpl                                    │
│  │   └── research-topics.md.tmpl                                │
│  ├── research/                                                   │
│  │   ├── README.md.tmpl                                         │
│  │   ├── research-topic.md.tmpl                                 │
│  │   ├── research-summary.md.tmpl                               │
│  │   └── requirements.md.tmpl                                   │
│  ├── decision/                                                   │
│  │   └── ...                                                    │
│  └── common/                                                     │
│      └── header.md.tmpl                                         │
│                                                                  │
│  (Templates ONLY - no tooling scripts)                          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Fetch templates
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        dev-toolkit                               │
│                   (Developer CLI - TOOLING)                      │
│                                                                  │
│  bin/                                                            │
│  ├── dt-doc-gen          # Generate docs from templates          │
│  ├── dt-doc-validate     # Validate doc structure                │
│  └── lib/                                                        │
│      ├── doc-common.sh   # Shared functions                      │
│      ├── doc-render.sh   # Template rendering (envsubst)         │
│      └── doc-validate.sh # Validation functions                  │
│                                                                  │
│  config/                                                         │
│  └── templates/          # Cached templates from dev-infra       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Requirements Impact

**Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-15 | Templates in dev-infra (`scripts/doc-gen/templates/`) |
| FR-16 | Tooling in dev-toolkit (`bin/dt-doc-gen`, `bin/dt-doc-validate`) |
| FR-17 | Tooling fetches templates from dev-infra releases |
| FR-18 | Commands named `dt-doc-gen`, `dt-doc-validate` |
| NFR-9 | Templates and tooling version independently |
| NFR-10 | Tooling designed to work with any template version |
| C-7 | Enforced by separation - scripts in dev-toolkit |
| C-8 | Single source in dev-infra, fetched by tooling |
| C-9 | No orchestration logic in dev-infra templates |

---

## Implementation Notes

**For dev-infra (this feature):**
- Create `scripts/doc-gen/templates/` directory structure
- Create 17 template files organized by workflow
- Document template format and placeholder conventions
- Version templates with dev-infra releases

**For dev-toolkit (separate feature):**
- Create `dt-doc-gen` command
- Create `dt-doc-validate` command
- Create `lib/doc-*.sh` shared functions
- Implement template fetching from dev-infra

---

## References

- [Research: Architectural Placement](../../research/template-doc-infrastructure/research-architectural-placement.md)
- [dev-infra ADR-001: Project Identity](../../dev-infra-identity-and-focus/adr-001-project-identity.md)
- [four-arm-architecture ADR-001: Command Distribution](../../four-arm-architecture/adr-001-command-distribution-ownership.md)
- [Requirements Document](../../research/template-doc-infrastructure/requirements.md)

---

**Last Updated:** 2026-01-14
