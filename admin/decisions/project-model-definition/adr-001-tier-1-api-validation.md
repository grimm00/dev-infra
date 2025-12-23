# ADR-001: Tier 1 API Contract Validation

**Status:** Accepted  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23

---

## Context

The four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod) requires a unified project model. Before implementing new features or changes, we needed to validate that the existing Tier 1 API contract between work-prod (provider) and proj-cli (consumer) is complete and ready for integration.

**Related Research:**

- [Research Summary](../../research/project-model-definition/research-summary.md)
- [Tier 1 API Contract Research](../../research/project-model-definition/research-tier-1-api-contract.md)

**Related Requirements:**

- [Requirements Document](../../research/project-model-definition/requirements.md) - FR-1, FR-1a, FR-1b, FR-1c

---

## Decision

**Decision:** The Tier 1 API Contract is validated and ready for integration. No changes are needed - both work-prod and proj-cli are implementation-ready.

**Ownership:**

| Arm | Role | Responsibilities |
|-----|------|------------------|
| **work-prod** | API Provider | Maintains API endpoints, database, business logic |
| **proj-cli** | API Consumer | Implements client, consumes API, provides CLI interface |

---

## Consequences

### Positive

- **Immediate integration:** proj-cli can begin using work-prod API immediately
- **No blocking changes:** Both sides are already aligned
- **Validated contract:** 691-line OpenAPI spec provides authoritative documentation
- **Bulk import ready:** `/projects/import` endpoint supports inventory sync
- **Complete CRUD:** All create, read, update, delete operations implemented

### Negative

- **Tier 2 deferred:** Classification/organization alignment deferred to separate decisions
- **No API versioning yet:** Future breaking changes will need versioning strategy

---

## Alternatives Considered

### Alternative 1: Wait for Tier 2 Alignment

**Description:** Delay Tier 1 integration until classification/organization fields are aligned.

**Pros:**

- Complete alignment in one phase
- No interim state

**Cons:**

- Delays valuable functionality
- Tier 1 fields are independent of Tier 2 alignment
- Blocks proj-cli development unnecessarily

**Why not chosen:** Tier 1 (7 fields) is independent of Tier 2 alignment. The 7 Tier 1 fields (`id`, `name`, `path`, `description`, `remote_url`, `created_at`, `updated_at`) are ready now.

---

### Alternative 2: Rebuild API from Scratch

**Description:** Design new API contract and implement from scratch.

**Pros:**

- Clean slate design
- Could incorporate all tiers at once

**Cons:**

- Significant rework of working code
- Delays delivery by weeks
- Existing API is well-designed

**Why not chosen:** Research confirmed the existing API is complete, well-documented (OpenAPI spec), and follows best practices. No reason to rebuild.

---

## Decision Rationale

**Key Factors:**

1. **Research validation:** Comprehensive audit confirmed full API alignment
2. **Gap analysis:** Zero gaps found between work-prod API and proj-cli client
3. **Documentation:** 691-line OpenAPI 3.0.3 spec provides authoritative contract
4. **Implementation:** Both sides already implemented and tested

**Research Support:**

- Finding 1: OpenAPI spec exists and is complete
- Finding 3: proj-cli API client already implements full contract
- Gap Analysis: Zero gaps in create, list, get, update, delete, archive, import, search

---

## Requirements Impact

**Requirements Validated:**

- FR-1: Tier 1 API Contract - ✅ VALIDATED
- FR-1a: Required Fields on Create (`name` only) - ✅ VALIDATED
- FR-1b: HTTP Status Code Handling - ✅ VALIDATED
- FR-1c: Deduplication Awareness (`remote_url`) - ✅ VALIDATED
- NFR-1: API Compatibility - ✅ VALIDATED
- NFR-1b: Configurable API URL - ✅ VALIDATED

**No new requirements:** This decision validates existing implementation.

---

## Implementation Notes

**No implementation needed** - this is a validation decision confirming readiness.

**Next steps:**

1. proj-cli can proceed with Tier 1 operations
2. Work-prod API is stable for Tier 1 fields
3. Future Tier 2/3 changes will be additive (non-breaking)

---

## References

- [Research Summary](../../research/project-model-definition/research-summary.md)
- [Tier 1 API Contract Research](../../research/project-model-definition/research-tier-1-api-contract.md)
- [Requirements Document](../../research/project-model-definition/requirements.md)
- [work-prod OpenAPI Spec](../../../../work-prod/backend/openapi.yaml)
- [proj-cli API Client](../../../../proj-cli/src/proj/api_client.py)

---

**Last Updated:** 2025-12-23

