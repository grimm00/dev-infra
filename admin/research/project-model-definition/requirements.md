# Requirements - Project Model Definition

**Source:** Research on project model definition  
**Status:** Draft  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Overview

This document captures requirements discovered during research on the unified project model.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Tier 1 API Contract

**Description:** proj-cli must be able to create, list, get, update, and delete projects using the work-prod API with Tier 1 fields.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Classification Support

**Description:** Projects must be classifiable as Work, Personal, Learning, or Inactive.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-3: Learning Sub-Classification

**Description:** Learning projects must have sub-classification (work_related, personal_dev, hybrid).

**Source:** [research-learning-taxonomy.md](research-learning-taxonomy.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-4: Organization Association

**Description:** Projects should be associatable with organizations (DRW, Apprenti, Personal).

**Source:** [research-organization-implementation.md](research-organization-implementation.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-5: Skills Integration

**Description:** Projects should link to skills for tech stack tracking.

**Source:** [research-skills-matrix-integration.md](research-skills-matrix-integration.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-6: Analysis Field Support

**Description:** Projects should have fields to support analysis capabilities.

**Source:** [research-analysis-field-requirements.md](research-analysis-field-requirements.md)

**Priority:** Low

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: API Compatibility

**Description:** proj-cli and work-prod must use compatible API contracts.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-2: Migration Safety

**Description:** Schema changes must not break existing data.

**Source:** [research-classification-enum.md](research-classification-enum.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-3: Backward Compatibility

**Description:** API changes should maintain backward compatibility where possible.

**Source:** Multiple research documents

**Priority:** Medium

**Status:** 🔴 Pending

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

## 💭 Assumptions

### A-1: Tier 1 Fields Are Ready

**Description:** The 7 Tier 1 fields in work-prod are ready to use without modification.

**Source:** [tier-1-core-registry.md](../../explorations/project-model-definition/tier-1-core-registry.md)

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

1. Complete research to validate/refine requirements
2. Use `/decision project-model-definition --from-research` to make decisions
3. Decisions may refine requirements

---

**Last Updated:** 2025-12-22

