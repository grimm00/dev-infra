# ADR-002: OpenAPI as Single Source of Truth

**Status:** Accepted  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23

---

## Context

With work-prod providing the API and proj-cli consuming it, we need a clear standard for how the API contract is documented and maintained. The question is: what should be the authoritative source for API contract documentation?

**Related Research:**

- [Research Summary](../../research/project-model-definition/research-summary.md)
- [Tier 1 API Contract Research](../../research/project-model-definition/research-tier-1-api-contract.md)

**Related Requirements:**

- [Requirements Document](../../research/project-model-definition/requirements.md) - NFR-1a

---

## Decision

**Decision:** Use the work-prod OpenAPI 3.0.3 specification (`backend/openapi.yaml`) as the single source of truth for the API contract.

**Ownership:**

| Arm | Role | Responsibilities |
|-----|------|------------------|
| **work-prod** | Spec Owner | Maintains `backend/openapi.yaml`, updates on API changes |
| **proj-cli** | Spec Consumer | References spec for client implementation |
| **dev-infra** | Standard Keeper | Documents this standard, ensures compliance |

---

## Consequences

### Positive

- **Single source:** One authoritative document for API contract
- **Industry standard:** OpenAPI 3.0.3 is widely supported
- **Tooling support:** Enables code generation, validation, documentation
- **Version control:** Changes tracked in git with work-prod
- **Self-documenting:** Spec includes descriptions, examples, schemas
- **Already exists:** 691-line spec already complete and maintained

### Negative

- **Maintenance burden:** work-prod must update spec when API changes
- **Sync risk:** If spec falls out of sync with implementation, contract is broken
- **Single owner:** proj-cli depends on work-prod to keep spec current

---

## Alternatives Considered

### Alternative 1: Code-First (No Spec)

**Description:** Let the implementation be the contract - no separate specification.

**Pros:**

- Less maintenance
- No sync issues

**Cons:**

- No explicit contract document
- Harder to understand API without reading code
- No tooling support
- Harder for new consumers to integrate

**Why not chosen:** Explicit contract documentation is valuable for multi-arm architecture. OpenAPI spec already exists and is well-maintained.

---

### Alternative 2: Separate Contract in dev-infra

**Description:** Maintain the API contract specification in dev-infra, separate from implementation.

**Pros:**

- Central location for all ecosystem documentation
- dev-infra owns all standards

**Cons:**

- Spec separated from implementation increases sync risk
- Two places to update on changes
- work-prod team would need to coordinate with dev-infra

**Why not chosen:** Keeping spec with implementation (work-prod) reduces sync risk and simplifies maintenance workflow.

---

### Alternative 3: Auto-Generated from Code

**Description:** Generate OpenAPI spec automatically from Flask/Python code annotations.

**Pros:**

- Always in sync with implementation
- Less manual maintenance

**Cons:**

- May miss documentation details
- Requires specific tooling setup
- Generated specs often less readable
- Current manual spec is high quality

**Why not chosen:** Current manually-maintained spec is comprehensive (691 lines) with excellent documentation. Auto-generation would likely reduce quality.

---

## Decision Rationale

**Key Factors:**

1. **Existing asset:** 691-line OpenAPI 3.0.3 spec already exists and is high quality
2. **Industry standard:** OpenAPI is the de facto standard for REST API documentation
3. **Proximity to code:** Keeping spec in work-prod alongside implementation reduces sync risk
4. **Clear ownership:** work-prod owns API, should own its documentation

**Research Support:**

- Finding 1: Comprehensive OpenAPI 3.0.3 specification exists
- Recommendation 2: Use OpenAPI spec as contract reference

---

## Requirements Impact

**Requirements Validated:**

- NFR-1a: OpenAPI as Source of Truth - ✅ VALIDATED

**Process Requirements (New):**

- **PR-1:** work-prod MUST update `backend/openapi.yaml` when API changes
- **PR-2:** API changes without spec updates should be flagged in code review
- **PR-3:** proj-cli should validate client against spec on major changes

---

## Implementation Notes

**No implementation needed** - this establishes a standard for existing practices.

**Guidelines for work-prod:**

1. Update `backend/openapi.yaml` in same PR as API changes
2. Include request/response examples for new endpoints
3. Document error responses for all operations
4. Use semantic versioning in spec `info.version`

**Guidelines for proj-cli:**

1. Reference `work-prod/backend/openapi.yaml` for client implementation
2. Validate client behavior matches spec
3. Report spec discrepancies as issues to work-prod

---

## References

- [Research Summary](../../research/project-model-definition/research-summary.md)
- [Tier 1 API Contract Research](../../research/project-model-definition/research-tier-1-api-contract.md)
- [Requirements Document](../../research/project-model-definition/requirements.md)
- [work-prod OpenAPI Spec](../../../../work-prod/backend/openapi.yaml)

---

**Last Updated:** 2025-12-23


