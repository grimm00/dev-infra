# ADR-005: Workflow Guides and Examples

**Status:** Proposed  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## Context

Templates currently have basic structure but lack workflow guides and examples. Users may not understand how to use workflow automation commands, exploration/research/decision workflows, or feature/CI/CD improvement workflows. Templates should include guides and examples to help users understand structure and workflows.

**Related Research:**
- [Research Summary](../../research/templates-enhancement/research-summary.md)
- [Other Template Enhancements Research](../../research/templates-enhancement/research-other-template-enhancements.md)

**Related Requirements:**
- [Requirements Document](../../research/templates-enhancement/requirements.md) - FR-6: Workflow Guides and Examples

---

## Decision

**Decision:** Include workflow guides and example documents in templates. Create guides covering:
- Exploration → Research → Decision → Planning workflow
- Feature development workflow
- CI/CD improvement workflow
- Status update workflow

Include example documents (exploration, research, ADR, feature plan) as reference. Guides should be in `docs/maintainers/` directory structure.

**Guides to Include:**
- Workflow overview guide
- Exploration/research/decision workflow guide
- Feature development workflow guide
- CI/CD improvement workflow guide
- Status update workflow guide

**Examples to Include:**
- Example exploration document
- Example research document
- Example ADR document
- Example feature plan

**Priority:** Lower priority - can be added incrementally after core structure is in place.

---

## Consequences

### Positive

- Better developer experience with guides
- Users understand workflows from the start
- Examples help users understand structure
- Reduces learning curve
- Better adoption of workflow automation

### Negative

- Additional documentation to maintain
- More template content
- Need to keep guides updated
- May become outdated over time

---

## Alternatives Considered

### Alternative 1: Don't Include Guides and Examples

**Description:** Don't include workflow guides and examples. Users learn from command documentation and experience.

**Pros:**
- Simpler templates
- Less to maintain
- Commands are self-documenting

**Cons:**
- Higher learning curve
- Users may not discover workflows
- Less adoption of workflow automation
- Inconsistent usage patterns

**Why not chosen:** Guides and examples significantly improve developer experience. Low overhead, high value. Better adoption of workflow automation.

---

### Alternative 2: Include Only Guides, No Examples

**Description:** Include workflow guides but not example documents.

**Pros:**
- Less template content
- Guides provide workflow understanding
- Examples can be created as needed

**Cons:**
- Users may not understand structure without examples
- Less concrete guidance
- Examples help users understand structure better

**Why not chosen:** Examples provide concrete guidance and help users understand structure. Low overhead, high value.

---

### Alternative 3: Include Only Examples, No Guides

**Description:** Include example documents but not workflow guides.

**Pros:**
- Less documentation to maintain
- Examples show structure
- Users can infer workflows from examples

**Cons:**
- Less explicit workflow guidance
- Users may not understand workflow sequence
- Guides provide better workflow understanding

**Why not chosen:** Guides provide explicit workflow guidance. Examples show structure. Both are valuable. Low overhead, high value.

---

## Decision Rationale

**Key Factors:**
- Guides significantly improve developer experience
- Examples help users understand structure
- Low overhead (documentation files)
- High value (better adoption, lower learning curve)
- Can be added incrementally

**Research Support:**
- Research finding: "Templates need workflow guides and example documents"
- Research finding: "Process documentation would help users"
- Research finding: "Example documents would help users understand structure"

---

## Requirements Impact

**Requirements Affected:**
- FR-6: Workflow Guides and Examples - ✅ Satisfied

**Requirements Refined:**
- Guides must cover exploration → research → decision → planning workflow
- Guides must cover feature development workflow
- Guides must cover CI/CD improvement workflow
- Examples must include exploration, research, ADR, feature plan

---

## References

- [Research Summary](../../research/templates-enhancement/research-summary.md)
- [Other Template Enhancements Research](../../research/templates-enhancement/research-other-template-enhancements.md)
- [Requirements Document](../../research/templates-enhancement/requirements.md)

---

**Last Updated:** 2025-12-07

