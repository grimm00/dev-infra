# Research Summary - Project Model Definition

**Purpose:** Summary of all research findings  
**Status:** 🟠 In Progress  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-23

---

## 📋 Research Overview

Research to establish a unified project model across the four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod) using a tiered approach.

**Research Topics:** 6 topics  
**Research Documents:** 6 documents  
**Status:** 🟠 In Progress (4/6 complete)

---

## 🔍 Key Findings

### Finding 1: Tier 1 API Contract is Complete

The work-prod API and proj-cli client are **fully aligned** and ready for integration. OpenAPI 3.0.3 specification provides authoritative contract documentation. All CRUD operations plus bulk import are implemented.

**Key Discovery:** No API changes needed for Tier 1 - integration can proceed immediately.

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

---

### Finding 2: 7 Fields Ready for Tier 1

The work-prod project model has 10 fields, with 7 immediately usable for Tier 1:

- `id`, `name`, `path`, `description`, `remote_url`, `created_at`, `updated_at`

3 fields need Tier 2 research for alignment:

- `status`, `organization`, `classification`

**Source:** [research-tier-1-api-contract.md](research-tier-1-api-contract.md)

---

### Finding 3: Classification Enum is PRIORITY, Not TYPE

**Critical Discovery:** Current `classification` enum represents **priority/importance** (`primary`, `secondary`, `archive`, `maintenance`), NOT **project type** (`Work`, `Personal`, `Learning`, `Inactive`).

These are two different dimensions that both need to exist:

- **Priority:** How important is this project?
- **Type:** What kind of project is this?

**Key Discovery:** Need to ADD `project_type` field - don't migrate `classification`.

**Source:** [research-classification-enum.md](research-classification-enum.md)

---

### Finding 4: Data Loss Already Occurred

The current mapping script conflates Work, Personal, and Apprenti all to `primary` classification. 40 of 48 projects are `primary` with no way to distinguish their actual type.

**Impact:** Cannot answer "show me all Work projects" with current schema.

**Source:** [research-classification-enum.md](research-classification-enum.md)

---

### Finding 5: Organization String Field is Sufficient

No organizations table exists in work-prod, and the string field (`organization`) is working fine. Only 3 values expected: `DRW`, `Apprenti`, `Personal`.

**Key Discovery:** FK migration is optional enhancement - defer until organization metadata (colors, logos) is needed.

**Current usage:** 18 projects have "DRW", 35 have null.

**Source:** [research-organization-implementation.md](research-organization-implementation.md)

---

### Finding 6: Three-Type Learning Taxonomy Validated

17 Learning projects (29% of total) need sub-classification. Three types are sufficient:

| Learning Type  | Description             | Estimated Count |
| -------------- | ----------------------- | --------------- |
| `work_related` | Job/career learning     | 8-10            |
| `personal_dev` | Hobby/interest learning | 5-7             |
| `hybrid`       | Serves both purposes    | 2-3             |

**Key Discovery:** Work-related learning should count toward work metrics (apprenticeship reality). Hybrid projects need visibility in both work and personal views.

**Implementation:** Add `learning_type` field (Tier 3), depends on `project_type` (Tier 2).

**Source:** [research-learning-taxonomy.md](research-learning-taxonomy.md)

---

## 💡 Key Insights

- [x] Insight 1: **API already complete** - Both work-prod and proj-cli are implementation-ready
- [x] Insight 2: **OpenAPI spec is authoritative** - 691-line specification documents full contract
- [x] Insight 3: **Deduplication uses `remote_url`** - Bulk import skips duplicates by remote URL
- [x] Insight 4: **Two-field solution needed** - Keep `classification` (priority), add `project_type` (type)
- [x] Insight 5: **`maintenance` value unused** - Never used in 48 projects
- [x] Insight 6: **String organization works** - FK is optional, defer until metadata needed
- [x] Insight 7: **Three learning types sufficient** - work_related, personal_dev, hybrid cover all scenarios
- [x] Insight 8: **Work learning = work time** - Include work-related learning in work metrics
- [x] Insight 9: **Tier 3 depends on Tier 2** - Learning taxonomy requires project_type first

---

## 📋 Requirements Summary

**From Tier 1 API Contract Research:**

- REQ-1: proj-cli must send `name` on create (only required field)
- REQ-2: proj-cli must handle all HTTP status codes
- REQ-3: proj-cli must be aware of `remote_url` deduplication
- REQ-4: proj-cli must support configurable `api_url`
- REQ-5: work-prod OpenAPI spec must be updated when API changes

**From Classification Enum Research:**

- REQ-6: work-prod must add `project_type` field (`Work`, `Personal`, `Learning`, `Inactive`)
- REQ-7: `project_type` should be required for new projects
- REQ-8: Mapping script must populate BOTH `classification` AND `project_type`
- REQ-9: API must support filtering by `project_type`
- REQ-10: Existing data must be backfilled with inferred `project_type` values

**From Organization Implementation Research:**

- REQ-11: Organization field may remain a string (no FK required for Tier 2)
- REQ-12: Organization values should be validated (DRW, Apprenti, Personal, null)
- REQ-13: Organization FK migration deferred until metadata is needed

**From Learning Taxonomy Research:**

- REQ-14: Add `learning_type` field (work_related, personal_dev, hybrid)
- REQ-15: `learning_type` only non-NULL when `project_type = 'Learning'`
- REQ-16: Work-related learning included in work metrics/views
- REQ-17: Hybrid projects visible in both work and personal views
- REQ-18: API filtering by `learning_type` parameter
- REQ-19: Mapping script prompts for learning sub-classification

**See:** [requirements.md](requirements.md) for complete requirements document

---

## 🎯 Recommendations

- [x] Recommendation 1: **Proceed with Tier 1 integration immediately** - No blockers
- [x] Recommendation 2: **Use OpenAPI spec as single source of truth**
- [x] Recommendation 3: **Add `project_type` field** - Don't migrate classification
- [x] Recommendation 4: **Keep `classification` as-is** - Rename to `priority` later if desired
- [x] Recommendation 5: **Backfill existing data** - Use heuristics (organization, path)
- [x] Recommendation 6: **Keep organization as string** - Defer FK to Tier 4+
- [x] Recommendation 7: **Adopt three-type learning taxonomy** - work_related, personal_dev, hybrid
- [x] Recommendation 8: **Work-related learning counts as work** - Include in work metrics
- [x] Recommendation 9: **Hybrid shows in both views** - With clear indicator
- [x] Recommendation 10: **Defer learning_status to Phase 4** - Not MVP-critical

---

## 📊 Research Status

| Topic                       | Priority  | Status         |
| --------------------------- | --------- | -------------- |
| Tier 1 API Contract         | 🔴 High   | ✅ Complete    |
| Classification Enum         | 🔴 High   | ✅ Complete    |
| Organization Implementation | 🟡 Medium | ✅ Complete    |
| Learning Taxonomy           | 🔴 High   | ✅ Complete    |
| Skills Matrix Integration   | 🟡 Medium | 🔴 Not Started |
| Analysis Field Requirements | 🟢 Low    | 🔴 Not Started |

---

## 🚀 Next Steps

1. ✅ Complete Tier 1 API Contract research
2. ✅ Complete Classification Enum research
3. ✅ Complete Organization Implementation research
4. ✅ Complete Learning Taxonomy research
5. ➡️ Continue with Skills Matrix Integration research (Topic 5)
6. After all research complete: `/decision project-model-definition --from-research`

---

**Last Updated:** 2025-12-23
