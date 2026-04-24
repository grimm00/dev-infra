# ADR-002: Contract Coordination Strategy

**Status:** ✅ Accepted  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## Context

The Four-Arm Architecture has shared contracts (API schemas, data models, command definitions) that need coordination across projects. The key tension is maintaining standalone usability for external users while ensuring internal consistency.

**The question:** How should dev-infra coordinate shared schemas and business logic across all four arms?

**Related Research:**
- [Research: Shared Contracts and Business Logic](../../research/four-arm-architecture/research-shared-contracts.md)
- [Research Summary](../../research/four-arm-architecture/research-summary.md)

**Related Requirements:**
- FR-SC-1 through FR-SC-4 (Shared Contracts functional requirements)
- NFR-SC-1 through NFR-SC-3 (Shared Contracts non-functional requirements)
- C-SC-1, C-SC-2 (Shared Contracts constraints)

---

## Decision

**Use standards-based coordination (extending the existing OpenAPI pattern) rather than technical sync mechanisms or centralized contract infrastructure.**

### Coordination Model

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        dev-infra                                         │
│                   (Standard Keeper)                                      │
│                                                                          │
│  Documents standards, ensures cross-arm compliance                       │
│  Location: admin/planning/standards/                                     │
└─────────────────────────────────────────────────────────────────────────┘
                                │
                                │ documents/enforces
                                ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                        Spec Owners                                       │
│                                                                          │
│  work-prod: OpenAPI spec owner (backend/openapi.yaml)                   │
│  dev-infra: Cursor commands owner (templates/.cursor/commands/)          │
└─────────────────────────────────────────────────────────────────────────┘
                                │
                                │ consumed by
                                ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                        Spec Consumers                                    │
│                                                                          │
│  proj-cli: API consumer (references OpenAPI spec)                       │
│  dev-toolkit: Command consumer (installs from dev-infra)                │
│  Generated projects: Template consumers                                  │
└─────────────────────────────────────────────────────────────────────────┘
```

### Contract Ownership Matrix

| Contract | Spec Owner | Spec Consumers | Standard Location |
|----------|-----------|----------------|-------------------|
| **API Schema** | work-prod | proj-cli | `standards/openapi-source-of-truth/` |
| **Cursor Commands** | dev-infra | dev-toolkit, projects | (needs new standard) |
| **Project Model** | work-prod (via OpenAPI) | proj-cli | `standards/openapi-source-of-truth/` |
| **Database Schema** | work-prod | (none - internal) | N/A |
| **proj-cli Config** | proj-cli | (none - internal) | N/A |

### Process Requirements (Following OpenAPI Pattern)

1. **PR-1:** Spec owners MUST update their contracts when making implementation changes
2. **PR-2:** Code review SHOULD flag changes without corresponding contract updates
3. **PR-3:** Spec consumers SHOULD validate their implementations match the spec

---

## Consequences

### Positive

- **No new infrastructure:** Extends existing OpenAPI standard pattern
- **Proven approach:** OpenAPI standard has been working well
- **Appropriate scale:** Process-based standards work for small teams
- **Standalone preserved:** Each project embeds its own contracts
- **Low overhead:** No sync mechanisms, registries, or automated checks

### Negative

- **Manual compliance:** Relies on developer discipline
- **No automated validation:** Contract drift possible without detection
- **Documentation burden:** Standards must be documented and maintained

---

## Alternatives Considered

### Alternative 1: Central Contracts Repository

**Description:** Create `admin/contracts/` in dev-infra with all shared schemas.

**Pros:**
- Single source of truth for all contracts
- Clear location for contract definitions

**Cons:**
- Contracts become divorced from their implementations
- External users need to understand contract location
- Adds maintenance burden without proportional benefit

**Why not chosen:** Contracts are better maintained by their implementers. The OpenAPI spec works well living in work-prod.

---

### Alternative 2: Published Contract Packages

**Description:** Publish contracts as npm/pip packages that consumers install.

**Pros:**
- Type-safe contracts
- Version-locked dependencies
- Automated compatibility checking

**Cons:**
- Publication overhead
- Package management complexity
- Overkill for current scale

**Why not chosen:** Too complex for a single developer with 4 projects. Appropriate only if team/complexity grows significantly.

---

### Alternative 3: Consumer-Driven Contract Testing

**Description:** Implement Pact or similar consumer-driven contract testing.

**Pros:**
- Automated contract validation
- Catches breaking changes
- Industry standard for microservices

**Cons:**
- Significant setup overhead
- Requires CI/CD integration across all repos
- Overkill for current scale

**Why not chosen:** Appropriate for larger teams with many consumers. Current scale benefits from simpler process standards.

---

### Alternative 4: Technical Sync Mechanisms

**Description:** Automated tools to sync contracts between repositories.

**Pros:**
- Ensures consistency
- Reduces manual work

**Cons:**
- Complex to implement
- Debugging sync issues is hard
- Creates tight coupling

**Why not chosen:** Process-based standards are simpler and more maintainable for small teams.

---

## Decision Rationale

**Key Factors:**

1. **Existing success:** The OpenAPI standard pattern is already working
2. **Scale appropriateness:** Complex infrastructure is overkill for one developer
3. **Standalone requirement:** Each project must work independently
4. **Embedded contracts:** External users shouldn't need to fetch contracts

**Research Support:**
- Finding 1: We already have a working contract pattern (OpenAPI standard)
- Finding 3: External users get embedded contracts (already achieved)
- Finding 4: Standards-based coordination fits our scale
- Finding 6: Contract changes are already coordinated via process

---

## Requirements Impact

**Requirements Addressed:**
- FR-SC-1: Contract ownership designation ✅
- FR-SC-2: Spec owner update responsibility ✅
- FR-SC-3: Standards documentation location ✅
- FR-SC-4: Standards pattern extension ✅

**Requirements Validated:**
- NFR-SC-1: Standalone usability with embedded contracts ✅
- NFR-SC-2: Process-based coordination ✅
- NFR-SC-3: Ownership matrix documentation ✅

**Constraints Satisfied:**
- C-SC-1: No external dependencies for standalone ✅
- C-SC-2: No complex contract infrastructure ✅

---

## Implementation Notes

### What We DON'T Need

1. ❌ Central `admin/contracts/` directory
2. ❌ Published contract packages
3. ❌ Schema registry
4. ❌ Automated sync mechanisms
5. ❌ Consumer-driven contract testing

### What We DO Need

1. ✅ Document command-distribution standard (follow OpenAPI pattern)
2. ✅ Keep OpenAPI spec in work-prod (current location)
3. ✅ Keep commands in dev-infra templates (current location)
4. ✅ Use process standards for coordination

### New Standard to Create

Create `admin/planning/standards/command-distribution/` following the OpenAPI standard pattern:
- README.md (overview)
- ownership-matrix.md
- process-requirements.md
- compliance-checklist.md

---

## References

- [Research: Shared Contracts and Business Logic](../../research/four-arm-architecture/research-shared-contracts.md)
- [OpenAPI Source of Truth Standard](../../planning/standards/openapi-source-of-truth/README.md)
- [Requirements Document](../../research/four-arm-architecture/requirements.md)
- [work-prod OpenAPI spec](https://github.com/grimm00/work-prod/blob/main/backend/openapi.yaml)

---

**Last Updated:** 2025-12-31

