# Quality Attribute Catalog for Design Step

**Source:** /discuss session — agentic-workflow-modernization design phase (2026-04-14)
**Target:** dev-infra workflow pipeline (all templates)
**Status:** 🔴 Not Started
**Priority:** MEDIUM
**Effort:** LOW (document creation, referenced by /design command)
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Problem Statement

The `/design` step's Section 2 (Cross-Cutting Quality Attributes) currently derives its quality attributes ad hoc per feature. Each design reinvents which attributes matter. There is no standing reference to draw from, which means:

1. Attributes may be missed because nobody remembered to check them
2. Different features assess different attributes inconsistently
3. New learnings about quality concerns (e.g., lifecycle management) have no persistent home

The agentic-workflow-modernization design used 5 attributes (usability, shippability, maintainability, migration safety, backward compatibility). A lifecycle concern surfaced during review that wasn't in the original set. A standing catalog would have prompted that check.

---

## Proposed Solution

Create a persistent `docs/QUALITY-ATTRIBUTES.md` (or `admin/planning/QUALITY-ATTRIBUTES.md`) containing a curated catalog of quality attributes. The `/design` command references this catalog during Section 2, and the designer selects which attributes apply.

### Catalog Structure

Each attribute includes:

- **Name** — short label
- **Description** — what it means in dev-infra's context
- **When Applicable** — what kinds of features need this check
- **Typical Questions** — prompts for the designer to assess

### Initial Catalog (from this project + prior art)

| Attribute | When Applicable | Source |
|-----------|----------------|--------|
| Usability | Always | Design step int-opp |
| Shippability | Multi-stage features | Design step int-opp |
| Maintainability | Always | Design step int-opp |
| Migration Safety | Changes to existing patterns | Design step int-opp |
| Backward Compatibility | Features with downstream consumers | Design step int-opp |
| Lifecycle | Distributable artifacts (install, update, uninstall) | Discussion 2026-04-14 |
| Testability | Features with logic or behavioral contracts | TDD practices |
| Portability | Cross-platform features | Topic 5 research |
| Context Efficiency | Agent-facing features | NFR-7 (workflow-simplification) |
| Observability | Runtime or stateful features | General engineering |
| Security | Features handling secrets or access | General engineering |

### How It Evolves

- New attributes added when discovered (like lifecycle was today)
- Attributes gain "typical questions" from real design experience
- The catalog grows from project learnings, not from theory

### Integration with `/design`

The design command's Section 2 would include: "Scan the quality attribute catalog (`docs/QUALITY-ATTRIBUTES.md`) and select applicable attributes for this feature."

Section 7 (NFR Checklist) would reference the same catalog for sign-off.

### Retroactive Application

A design can be re-evaluated against the catalog at any time. If new attributes are added after a design is complete, the design can be audited against the updated catalog to identify gaps. This supports iterative design improvement without requiring a full redesign.

---

## Related

- [design-step-in-pipeline.md](design-step-in-pipeline.md) — The design step int-opp (mentions "standing NFRs" as an option)
- [requirements-and-design-prior-art.md](../learnings/requirements-and-design-prior-art.md) — Team engineering proposal that informed quality thinking
- [design.md](../../../../designs/agentic-workflow-modernization/design.md) — First real design document (uses 5 attributes)

---

**Last Updated:** 2026-04-14
