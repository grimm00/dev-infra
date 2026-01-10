# OpenAPI as Single Source of Truth - Transition Plan

**Standard:** OpenAPI as Single Source of Truth  
**Source ADR:** [ADR-002](../../../decisions/project-model-definition/adr-002-openapi-source-of-truth.md)  
**Status:** ✅ Active  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23  
**Type:** Process Standard

---

## 📋 Transition Overview

This transition plan establishes the process standard from ADR-002 across all project arms.

**Transition Type:** Process Standard (not feature implementation)

**Key Principle:** The work-prod OpenAPI specification is the authoritative contract. No code changes needed - this formalizes existing practices.

---

## 🎯 Transition Goals

From ADR-002:
- Establish single source of truth for API contract documentation
- Define ownership responsibilities for each arm
- Create process requirements for maintaining spec accuracy
- Enable tooling support (validation, code generation, documentation)

---

## 🏢 Ownership Assignments

### work-prod (Spec Owner)

**Role:** Owns and maintains the OpenAPI specification

**Responsibilities:**

| Responsibility | Description | Priority |
|----------------|-------------|----------|
| Spec Maintenance | Update `backend/openapi.yaml` when API changes | High |
| Documentation | Include request/response examples | High |
| Error Responses | Document all error responses | High |
| Version Control | Bump spec version on changes | Medium |
| Code Review | Flag PRs that change API without spec updates | High |

**Guidelines:**

1. Update `backend/openapi.yaml` in **same PR** as API changes
2. Include request/response examples for new endpoints
3. Document error responses for all operations
4. Use semantic versioning in spec `info.version`
5. Review PRs for spec compliance before merge

**Location:** `work-prod/backend/openapi.yaml`

---

### proj-cli (Spec Consumer)

**Role:** Consumes the OpenAPI specification for client implementation

**Responsibilities:**

| Responsibility | Description | Priority |
|----------------|-------------|----------|
| Spec Reference | Use spec as implementation guide | High |
| Behavior Validation | Validate client matches spec | Medium |
| Discrepancy Reporting | Report spec issues to work-prod | High |
| Major Change Review | Review spec on major updates | Medium |

**Guidelines:**

1. Reference `work-prod/backend/openapi.yaml` for client implementation
2. Validate client behavior matches spec
3. Report spec discrepancies as issues to work-prod
4. Review spec changes when updating client

**Integration Pattern:**

```bash
# Reference the spec (cross-repo)
cat ~/Projects/work-prod/backend/openapi.yaml

# Or fetch via raw GitHub URL when needed
curl https://raw.githubusercontent.com/.../openapi.yaml
```

---

### dev-infra (Standard Keeper)

**Role:** Documents and enforces the standard across arms

**Responsibilities:**

| Responsibility | Description | Priority |
|----------------|-------------|----------|
| Standard Documentation | Maintain this standard documentation | High |
| Compliance Guidance | Provide guidance on standard compliance | Medium |
| Cross-Arm Coordination | Coordinate standard adoption | Medium |
| ADR Maintenance | Keep ADR-002 current | Low |

**Guidelines:**

1. Maintain standard documentation in `admin/planning/standards/`
2. Update standard if process changes
3. Coordinate with work-prod and proj-cli on compliance
4. Reference this standard in other planning documents

---

### dev-toolkit (N/A)

**Role:** No direct involvement

**Rationale:** dev-toolkit is shell-only tooling with no direct API integration. If dev-toolkit adds API features in future, it would become a Spec Consumer like proj-cli.

---

## 📋 Process Requirements

### PR-1: Spec Updates with API Changes

**Owner:** work-prod  
**Priority:** High  
**Status:** ✅ Active

**Rule:** work-prod MUST update `backend/openapi.yaml` when API changes.

**Enforcement:**
- Code review checklist item
- PR template reminder
- CI validation (optional future enhancement)

---

### PR-2: Code Review Enforcement

**Owner:** work-prod  
**Priority:** High  
**Status:** ✅ Active

**Rule:** API changes without spec updates should be flagged in code review.

**Implementation:**
- Add to PR review checklist
- Reviewer responsibility to verify

---

### PR-3: Client Validation

**Owner:** proj-cli  
**Priority:** Medium  
**Status:** ✅ Active

**Rule:** proj-cli should validate client behavior against spec on major changes.

**Implementation:**
- Manual validation on major updates
- Integration tests reference expected behavior

---

## 📊 Requirements Traceability

| Requirement | Status | Owner |
|-------------|--------|-------|
| NFR-1a: OpenAPI as Source of Truth | ✅ VALIDATED | work-prod |

---

## ✅ Adoption Checklist

**No code changes required** - this standard formalizes existing practices.

### work-prod Adoption

- [x] OpenAPI spec exists (`backend/openapi.yaml`)
- [x] Spec is comprehensive (691 lines)
- [x] Spec follows OpenAPI 3.0.3 standard
- [ ] PR template updated with spec reminder (optional)
- [ ] Review checklist includes spec verification (optional)

### proj-cli Adoption

- [x] Client references spec for implementation
- [ ] Document spec reference in development guide (optional)
- [ ] Add spec discrepancy reporting process (optional)

### dev-infra Adoption

- [x] Standard documented (this file)
- [x] ADR-002 created
- [x] Ownership assigned

---

## 🚀 Next Steps

**Immediate (No action required):**
- Standard is already in practice
- This documentation formalizes existing behavior

**Optional Enhancements:**

1. **work-prod:** Add PR template reminder for spec updates
2. **proj-cli:** Add spec reference to development guide
3. **Future:** Add CI validation for spec/implementation sync

---

## 🔗 Related Documents

- [Standard Hub](README.md)
- [ADR-002: OpenAPI as Single Source of Truth](../../../decisions/project-model-definition/adr-002-openapi-source-of-truth.md)
- [Requirements](../../../research/project-model-definition/requirements.md)
- [work-prod OpenAPI Spec](../../../../../work-prod/backend/openapi.yaml)

---

**Last Updated:** 2025-12-23


