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

### FR-2: Project Type Classification ✅ VALIDATED (requires new field)

**Description:** Projects must be classifiable by TYPE as Work, Personal, Learning, or Inactive.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** ✅ Validated - Requires NEW `project_type` field (not migration of `classification`)

**Details:**

- Current `classification` field is PRIORITY, not TYPE
- Add new `project_type` enum: `Work`, `Personal`, `Learning`, `Inactive`
- Keep `classification` as-is (or rename to `priority` later)

---

### FR-2a: Project Type Field Addition

**Description:** work-prod must add `project_type` field with enum values `Work`, `Personal`, `Learning`, `Inactive`.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** 🟡 Validated - Needs Implementation

---

### FR-2b: Project Type Required for New Projects

**Description:** `project_type` should be required (non-nullable) for new projects going forward.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** 🟡 Validated - Needs Implementation

---

### FR-2c: Mapping Script Update

**Description:** Mapping script must populate BOTH `classification` AND `project_type` fields.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** 🟡 Validated - Needs Implementation

---

### FR-2d: API Filtering by Project Type

**Description:** API must support filtering projects by `project_type` parameter.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** 🟡 Validated - Needs Implementation

---

### FR-2e: Data Backfill

**Description:** Existing data must be backfilled with inferred `project_type` values using heuristics.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** Medium

**Status:** 🟡 Validated - Needs Implementation

**Heuristics:**

- `organization = 'DRW'` → `project_type = 'Work'`
- `path LIKE '%/Learning/%'` → `project_type = 'Learning'`
- `classification = 'archive'` → `project_type = 'Inactive'`
- Remaining → `project_type = 'Personal'` (default assumption)

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

### NFR-2: Migration Safety ✅ VALIDATED

**Description:** Schema changes must not break existing data.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** ✅ Validated - Two-field solution avoids breaking changes

**Details:**

- Adding `project_type` is additive (no data loss)
- Keeping `classification` maintains backward compatibility
- Optional rename to `priority` deferred to later release

---

### NFR-3: Backward Compatibility ✅ VALIDATED

**Description:** API changes should maintain backward compatibility where possible.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** Medium

**Status:** ✅ Validated - Two-field solution is non-breaking

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

### C-3: Classification Enum Already in Use ✅ ADDRESSED

**Description:** work-prod uses `primary`, `secondary`, `archive`, `maintenance` - represents PRIORITY not TYPE.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Resolution:** Keep as-is, add new `project_type` field for TYPE classification.

---

### C-4: Data Loss Already Occurred

**Description:** Current mapping conflates Work, Personal, Apprenti to `primary` - type information lost.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Impact:** Backfill will use heuristics but cannot perfectly recover original types.

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

### A-3: Two Dimensions Needed ✅ CONFIRMED

**Description:** Projects need both TYPE (Work/Personal/Learning/Inactive) and PRIORITY (primary/secondary/archive/maintenance).

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Confirmed:** Yes - these answer different questions about projects.

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Project Model Definition Exploration](../../explorations/project-model-definition/README.md)

---

## 🚀 Next Steps

1. ✅ Tier 1 API Contract requirements validated
2. ✅ Classification Enum requirements validated (two-field solution)
3. ➡️ Continue research to validate/refine remaining requirements
4. After research: `/decision project-model-definition --from-research`
5. Decisions may refine requirements

---

**Last Updated:** 2025-12-23
