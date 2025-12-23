# Requirements - Project Model Definition

**Source:** Research on project model definition  
**Status:** Draft  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-23

---

## 📋 Overview

This document captures requirements discovered during research on the unified project model.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Tier 1 API Contract ✅ VALIDATED

**Description:** proj-cli must be able to create, list, get, update, and delete projects using the work-prod API with Tier 1 fields.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** High

**Status:** ✅ Validated - API already complete, no changes needed

**Details:**
- Only `name` field is required on create
- All CRUD operations implemented
- Bulk import via `/projects/import` ready
- Query filtering supported (status, organization, classification, search)

---

### FR-1a: Required Fields on Create

**Description:** proj-cli must send `name` field when creating projects (only required field).

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** High

**Status:** ✅ Validated

---

### FR-1b: HTTP Status Code Handling

**Description:** proj-cli must handle all HTTP status codes returned by work-prod: 200, 201, 204, 400, 404, 409, 500.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** High

**Status:** ✅ Validated - Already implemented via APIError, BackendConnectionError, TimeoutError

---

### FR-1c: Deduplication Awareness

**Description:** proj-cli `import_projects` must be aware that work-prod deduplicates by `remote_url`.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** Medium

**Status:** ✅ Validated

---

### FR-2: Classification Support

**Description:** Projects must be classifiable as Work, Personal, Learning, or Inactive.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** 🔴 Pending Research

---

### FR-3: Learning Sub-Classification

**Description:** Learning projects must have sub-classification (work_related, personal_dev, hybrid).

**Source:** [research-learning-taxonomy.md](research-learning-taxonomy.md)

**Priority:** High

**Status:** 🔴 Pending Research

---

### FR-4: Organization Association

**Description:** Projects should be associatable with organizations (DRW, Apprenti, Personal).

**Source:** [research-organization-implementation.md](research-organization-implementation.md)

**Priority:** Medium

**Status:** 🔴 Pending Research

---

### FR-5: Skills Integration

**Description:** Projects should link to skills for tech stack tracking.

**Source:** [research-skills-matrix-integration.md](research-skills-matrix-integration.md)

**Priority:** Medium

**Status:** 🔴 Pending Research

---

### FR-6: Analysis Field Support

**Description:** Projects should have fields to support analysis capabilities.

**Source:** [research-analysis-field-requirements.md](research-analysis-field-requirements.md)

**Priority:** Low

**Status:** 🔴 Pending Research

---

## 🎯 Non-Functional Requirements

### NFR-1: API Compatibility ✅ VALIDATED

**Description:** proj-cli and work-prod must use compatible API contracts.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** High

**Status:** ✅ Validated - Full compatibility confirmed

---

### NFR-1a: OpenAPI as Source of Truth

**Description:** work-prod OpenAPI specification must be updated when API changes (single source of truth).

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** High

**Status:** ✅ Validated

---

### NFR-1b: Configurable API URL

**Description:** proj-cli must support configurable `api_url` for different environments.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** Medium

**Status:** ✅ Validated - Already implemented via `PROJ_API_URL` env var and config file

---

### NFR-2: Migration Safety

**Description:** Schema changes must not break existing data.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** 🔴 Pending Research

---

### NFR-3: Backward Compatibility

**Description:** API changes should maintain backward compatibility where possible.

**Source:** Multiple research documents

**Priority:** Medium

**Status:** 🔴 Pending Research

---

## ⚠️ Constraints

### C-1: Existing Implementation

**Description:** work-prod already has a project model with 10 fields - changes must be incremental.

**Source:** [Project Model Definition Exploration](../../explorations/project-model-definition/exploration.md)

---

### C-2: Tier Dependencies

**Description:** Higher tiers depend on lower tiers being complete.

**Source:** [Project Model Definition Exploration](../../explorations/project-model-definition/exploration.md)

---

### C-3: Classification Enum Already in Use

**Description:** work-prod uses `primary`, `secondary`, `archive`, `maintenance` - change requires migration.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

---

## 💭 Assumptions

### A-1: Tier 1 Fields Are Ready ✅ CONFIRMED

**Description:** The 7 Tier 1 fields in work-prod are ready to use without modification.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Confirmed:** Yes - id, name, path, description, remote_url, created_at, updated_at all ready.

---

### A-2: work-prod Is Source of Truth

**Description:** work-prod defines the project schema; proj-cli consumes it.

**Source:** [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/exploration.md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Project Model Definition Exploration](../../explorations/project-model-definition/README.md)

---

## 🚀 Next Steps

1. ✅ Tier 1 API Contract requirements validated
2. ➡️ Continue research to validate/refine remaining requirements
3. After research: `/decision project-model-definition --from-research`
4. Decisions may refine requirements

---

**Last Updated:** 2025-12-23
