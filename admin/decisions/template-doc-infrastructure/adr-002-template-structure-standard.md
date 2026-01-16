# ADR-002: Template Structure Standard

**Status:** 🔴 Proposed  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 1 (Foundation)

---

## Context

Documentation infrastructure requires standardized templates for all document types. Research identified 17 distinct document types across 6 workflows and 5 common structural patterns. We need to decide on the template structure standard.

**Related Research:**
- [Research: Template Inventory](../../research/template-doc-infrastructure/research-template-inventory.md)
- [Research: Template Format](../../research/template-doc-infrastructure/research-template-format.md)
- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - Findings 1, 2, 11

**Related Requirements:**
- FR-1: Templates for all 17 doc types
- FR-2: Required sections with placeholder markers
- FR-3: Version header for template schema
- FR-4: Section markers for content generation
- FR-5: Optional sections clearly marked
- FR-34: envsubst-compatible `${VAR}` format
- FR-35: Distinguishable placeholder types
- FR-36: Placeholder convention documentation
- NFR-1: Template structure parseable for validation
- NFR-2: Templates readable without pre-processing
- NFR-3: Templates work with current sed-based generation
- NFR-17: Readable templates without processing
- NFR-18: Minimal learning curve for authors

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

### Alternative 1: Minimal Structure (Just Headings)

**Description:** Templates define only section headings, no content guidance.

**Pros:**
- Maximum flexibility
- Simple templates
- Easy to maintain

**Cons:**
- No guidance for content
- Inconsistent outputs
- Hard to validate

**Why not chosen:** [To be filled]

---

### Alternative 2: Rigid Templates (Full Content)

**Description:** Templates include all content with only variable placeholders.

**Pros:**
- Maximum consistency
- Easy to validate
- Predictable output

**Cons:**
- No flexibility for AI expansion
- Templates become stale
- Doesn't support two-mode pattern

**Why not chosen:** [To be filled]

---

### Alternative 3: Hybrid (Structure + Expansion Zones)

**Description:** Templates define structure + section types:
- `${VAR}` for script-time variables
- `<!-- AI: instruction -->` for AI content
- `<!-- EXPAND: scope -->` for AI expansion zones

**Pros:**
- Clear structure for validation
- Flexibility for AI content
- Supports two-mode pattern

**Cons:**
- More complex templates
- Multiple placeholder types

**Why not chosen:** [Or: Why chosen - to be filled]

---

## Decision Rationale

<!-- FILL: Explain why this decision was made -->

**Key Factors:**
- [Factor 1]
- [Factor 2]

**Research Support:**
- Finding 1: 17 doc types identified
- Finding 2: 5 common patterns
- Finding 11: envsubst for simple expansion

---

## Template Categories

<!-- FILL: List the 17 doc types and their categories -->

| Category | Count | Doc Types |
|----------|-------|-----------|
| Hub Templates | 4 | [List] |
| Exploration | 2 | [List] |
| Research | 3 | [List] |
| Decision | 3 | [List] |
| Planning | 3 | [List] |
| Other | 2 | [List] |

---

## Five Common Patterns

<!-- FILL: Define the 5 patterns -->

1. **Status Header Block:** [Definition]
2. **Quick Links Section:** [Definition]
3. **Status Tables:** [Definition]
4. **Next Steps Section:** [Definition]
5. **Related Links Section:** [Definition]

---

## Placeholder Convention

<!-- FILL: Define placeholder types -->

| Type | Syntax | Expanded By | Example |
|------|--------|-------------|---------|
| Script variable | `${VAR}` | envsubst | [Example] |
| AI content | `<!-- AI: -->` | AI | [Example] |
| Expansion zone | `<!-- EXPAND: -->` | AI | [Example] |

---

## Requirements Impact

<!-- FILL: Document requirements affected -->

**Requirements Addressed:**
- FR-1 through FR-5 (template structure)
- FR-34 through FR-36 (template format)
- NFR-1 through NFR-3, NFR-17, NFR-18 (template quality)

---

## References

- [Research: Template Inventory](../../research/template-doc-infrastructure/research-template-inventory.md)
- [Research: Template Format](../../research/template-doc-infrastructure/research-template-format.md)
- [Requirements](../../research/template-doc-infrastructure/requirements.md)

---

**Last Updated:** 2026-01-14
