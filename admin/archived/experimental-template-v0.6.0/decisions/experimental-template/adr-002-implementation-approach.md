# ADR-002: Implementation Approach

**Status:** Accepted  
**Created:** 2025-12-12  
**Accepted:** 2025-12-12  
**Last Updated:** 2025-12-12

---

## Context

Given the decision to create an experimental template (ADR-001), we must decide how to implement it. Research identified three approaches:

1. **Separate Template:** New `experimental-project/` directory alongside existing templates
2. **Template Flag:** Add `--experimental` flag to generator script
3. **Addon System:** Post-generation script to add experimental commands

Each has different implications for maintenance, user experience, and complexity.

**Related Research:**
- [Research Summary](../../research/experimental-template/research-summary.md)
- [Implementation Approach Research](../../research/experimental-template/research-implementation-approach.md)

**Related Requirements:**
- [Requirements Document](../../research/experimental-template/requirements.md)

---

## Decision

**Use the Separate Template approach: Create `templates/experimental-project/` alongside existing templates.**

Implementation details:
- New directory `templates/experimental-project/`
- Contains standard template content + experimental commands
- Generator script updated to offer as template choice
- CI drift detection to keep shared files in sync

---

## Consequences

### Positive

- **Aligns with existing pattern:** Already have standard-project and learning-project
- **Clear user experience:** Users choose template type at generation
- **Minimal generator changes:** Just add another template option
- **Independent evolution:** Experimental can evolve faster than standard
- **Template factory fit:** Templates as distinct products
- **Simple mental model:** "standard = stable, experimental = evolving"

### Negative

- **Sync challenge:** Must keep shared files in sync between templates
- **Potential drift:** Files may diverge without attention
- **Duplication:** Some content exists in both templates
- **Maintenance:** Changes to shared files need updating in both

### Mitigations

- **CI drift detection:** Automated validation catches drift early
- **Shared file documentation:** Clear list of which files must sync
- **PR checklist:** Remind developers to sync changes
- **Categorized files:** Clear distinction between shared vs experimental-only

---

## Alternatives Considered

### Alternative 1: Template Flag (`--experimental`)

**Description:** Add `--experimental` flag to generator that enables experimental commands in generated project.

```bash
./scripts/new-project.sh my-project --experimental
```

**Pros:**
- Single source of truth (no sync needed)
- More flexible (granular control possible)
- No file duplication

**Cons:**
- Increases generator complexity significantly
- Conditional logic scattered through templates
- Harder to maintain template clarity
- Testing more complex

**Why not chosen:** Adds significant complexity to generator and templates for minimal benefit. Conditionals make templates harder to understand.

---

### Alternative 2: Addon System

**Description:** Post-generation script that adds experimental commands to any project.

```bash
./scripts/new-project.sh my-project
./scripts/add-experimental-commands.sh my-project
```

**Pros:**
- Standard template stays clean
- Users explicitly opt-in with separate command
- Can add to existing projects

**Cons:**
- Two-step process (worse UX)
- New script to maintain
- May confuse users
- Harder to ensure consistency

**Why not chosen:** Two-step process is worse user experience. Doesn't align with template factory model where templates are complete products.

---

## Decision Rationale

**Key Factors:**

1. **Existing pattern:** Dev-infra already has multiple templates; this follows established pattern
2. **Generator simplicity:** Minimal changes to existing generator script
3. **Clear products:** Aligns with "template factory" identity - each template is a product
4. **User experience:** Simple choice at generation time, no flags to learn
5. **Research recommendation:** Implementation research recommended this approach

**Research Support:**
- Comparison matrix showed separate template as best fit for dev-infra
- Simple tools often use multiple template directories effectively
- Sync challenge is manageable with CI checks

---

## Requirements Impact

**Requirements Addressed:**
- FR-1: Template Generation (new template directory)
- FR-2: Generator Script Update (add template type option)
- FR-4: CI Drift Detection (validate shared file sync)
- NFR-1: Maintainability (CI-assisted sync keeps burden low)
- NFR-4: Cross-Platform Compatibility (no symlinks)
- C-4: Existing Validation (extends current CI)

**Requirements Refined:**
- PR-2: Shared File Documentation becomes critical for sync

---

## Implementation Guidelines

### Template Structure

```
templates/
├── standard-project/      # Stable template (existing)
├── learning-project/      # Educational template (existing)
└── experimental-project/  # Experimental template (NEW)
    ├── .cursor/
    │   └── commands/       # All commands including Evolving tier
    ├── docs/
    ├── ... (same structure as standard)
    └── README.md          # Includes stability disclaimers
```

### File Categories

| Category | Sync Behavior |
|----------|---------------|
| Shared Infrastructure | Must be identical |
| Shared Workflows | Must be identical |
| Stable Commands | Must be identical |
| Evolving Commands | Experimental only |
| Template Identity | Different by design |

### CI Drift Detection

```bash
# Example validation in CI
./scripts/validate-template-sync.sh
# Fails if shared files differ between templates
```

---

## References

- [Research Summary](../../research/experimental-template/research-summary.md)
- [Implementation Approach Research](../../research/experimental-template/research-implementation-approach.md)
- [Sync Strategy Research](../../research/experimental-template/research-sync-strategy.md)
- [Requirements Document](../../research/experimental-template/requirements.md)
- ADR-001: Experimental Template Creation

---

**Last Updated:** 2025-12-12

