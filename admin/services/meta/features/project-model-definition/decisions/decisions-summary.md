# Decisions Summary - Project Model Definition

**Purpose:** Summary of all decisions made for the unified project model  
**Status:** ✅ Accepted  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23

---

## 📋 Decisions Overview

These decisions document the unified project model across the four-arm architecture, covering:
- **Tier 1:** API contract validation and documentation standards
- **Tier 2:** Classification schema (project_type field addition)

**Decision Points:** 4 decisions  
**Status:** ✅ All Accepted

---

## 🎯 Key Decisions

### Decision 1: Tier 1 API Contract Validation

**Decision:** Proceed with Tier 1 integration - API is complete and ready. No changes needed.

**Status:** ✅ Accepted

**Ownership:**

| Arm | Role |
|-----|------|
| work-prod | API Provider |
| proj-cli | API Consumer |

**ADR:** [adr-001-tier-1-api-validation.md](adr-001-tier-1-api-validation.md)

**Impact:** proj-cli can proceed with Tier 1 operations immediately.

---

### Decision 2: OpenAPI as Single Source of Truth

**Decision:** Use work-prod OpenAPI 3.0.3 specification as the authoritative API contract.

**Status:** ✅ Accepted

**Ownership:**

| Arm | Role |
|-----|------|
| work-prod | Spec Owner (maintains `backend/openapi.yaml`) |
| proj-cli | Spec Consumer |
| dev-infra | Standard Keeper |

**ADR:** [adr-002-openapi-source-of-truth.md](adr-002-openapi-source-of-truth.md)

**Impact:** Establishes clear ownership and process for API contract documentation.

---

### Decision 3: Add project_type Field

**Decision:** Add a new `project_type` field with enum values `Work`, `Personal`, `Learning`, `Inactive`.

**Status:** ✅ Accepted

**Ownership:**

| Arm | Role |
|-----|------|
| work-prod | Schema Owner (implements field, migration) |
| proj-cli | Consumer (updates client filtering) |

**ADR:** [adr-003-add-project-type-field.md](adr-003-add-project-type-field.md)

**Impact:** Enables project type classification - "What kind of project is this?"

---

### Decision 4: Keep classification Field

**Decision:** Keep existing `classification` field as-is for priority. Optional rename to `priority` later.

**Status:** ✅ Accepted

**Ownership:**

| Arm | Role |
|-----|------|
| work-prod | Schema Owner |

**ADR:** [adr-004-keep-classification-field.md](adr-004-keep-classification-field.md)

**Impact:** Maintains backward compatibility, preserves priority dimension.

---

## 🏢 Ownership Matrix

| Decision | work-prod | proj-cli | dev-infra | dev-toolkit |
|----------|-----------|----------|-----------|-------------|
| Tier 1 API Validation | Provider | Consumer | - | - |
| OpenAPI Source of Truth | Owner | Consumer | Standard | - |
| Add project_type Field | Schema Owner | Consumer | - | - |
| Keep classification Field | Schema Owner | - | - | - |

---

## 📋 Requirements Impact

**Requirements Validated by These Decisions:**

| Requirement | Status | Decision |
|-------------|--------|----------|
| FR-1: Tier 1 API Contract | ✅ Validated | ADR-001 |
| FR-1a: Required Fields on Create | ✅ Validated | ADR-001 |
| FR-1b: HTTP Status Code Handling | ✅ Validated | ADR-001 |
| FR-1c: Deduplication Awareness | ✅ Validated | ADR-001 |
| FR-2: Project Type Classification | ✅ Enabled | ADR-003 |
| FR-2a: Project Type Field Addition | ✅ Decided | ADR-003 |
| FR-2b-e: Implementation Tasks | 🟡 work-prod | ADR-003 |
| NFR-1: API Compatibility | ✅ Validated | ADR-001 |
| NFR-1a: OpenAPI as Source of Truth | ✅ Validated | ADR-002 |
| NFR-2: Migration Safety | ✅ Satisfied | ADR-003, ADR-004 |
| NFR-3: Backward Compatibility | ✅ Satisfied | ADR-004 |

**Process Requirements Established:**

- PR-1: work-prod MUST update OpenAPI spec when API changes
- PR-2: API changes without spec updates flagged in code review
- PR-3: proj-cli should validate client against spec on major changes

**Implementation Tasks for work-prod (from ADR-003):**

- [ ] Create migration for `project_type` field
- [ ] Implement backfill script with heuristics
- [ ] Add API filtering support for `project_type`
- [ ] Update OpenAPI spec
- [ ] Update mapping script

**See:** [requirements.md](../../research/project-model-definition/requirements.md) for complete requirements

---

## 🚀 Next Steps

1. ✅ Tier 1 decisions accepted (ADR-001, ADR-002)
2. ✅ Classification decisions accepted (ADR-003, ADR-004)
3. Continue with Learning Taxonomy decisions (add `learning_type` field)
4. Use `/transition-plan --from-adr` to create implementation plans

---

## 📊 Decision Timeline

| Date | Decision | Status |
|------|----------|--------|
| 2025-12-23 | ADR-001: Tier 1 API Validation | ✅ Accepted |
| 2025-12-23 | ADR-002: OpenAPI Source of Truth | ✅ Accepted |
| 2025-12-23 | ADR-003: Add project_type Field | ✅ Accepted |
| 2025-12-23 | ADR-004: Keep classification Field | ✅ Accepted |

---

**Last Updated:** 2025-12-23

