# Research Topics - Project Model Definition

**Purpose:** List of research topics/questions to investigate  
**Status:** 🟠 Research In Progress (4/6 complete)  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-23

---

## 📋 Research Topics

This document lists research topics and questions that need investigation for the project model definition.

---

### Research Topic 1: Classification Enum Alignment

**Question:** Should work-prod migrate from current classification values to research-recommended values?

**Why:** Current enum (`primary`, `secondary`, `archive`, `maintenance`) doesn't align with the taxonomy designed in work-prod research (`Work`, `Personal`, `Learning`, `Inactive`).

**Priority:** High (affects Tier 2)

**Status:** ✅ Complete - See [research-classification-enum.md](../../research/project-model-definition/research-classification-enum.md)

**Key Finding:** The two enums represent **different concepts** - current is priority/importance, research is project type. Recommendation: Add new `project_type` field, keep existing `classification`.

**Sub-questions:**

- Is there existing data using current enum values?
- What's the migration path?
- Do current values map cleanly to new values?
- Impact on proj-cli commands?

**Options:**

1. Keep current values (no change)
2. Migrate to research values (breaking change)
3. Add new values, deprecate old ones (gradual migration)

---

### Research Topic 2: Organization Implementation

**Question:** Should `organization` remain a string field or migrate to FK?

**Why:** String field is simpler but lacks referential integrity. FK enables organization metadata (color, display name, type).

**Priority:** Medium (affects Tier 2)

**Status:** ✅ Complete - See [research-organization-implementation.md](../../research/project-model-definition/research-organization-implementation.md)

**Key Finding:** No organizations table exists. String field is **sufficient** for current needs (only 3 values: DRW, Apprenti, Personal). FK migration deferred until organization metadata is needed.

**Sub-questions:**

- Does work-prod have an organizations table?
- What organization metadata is needed?
- Is referential integrity important for this use case?
- Migration complexity?

**Options:**

1. Keep string (simple, works now) ✅ **RECOMMENDED**
2. Add FK, keep string for backward compatibility
3. Migrate to FK only (breaking change)

---

### Research Topic 3: Tier 1 API Contract

**Question:** What exact API contract does proj-cli need from work-prod for Tier 1?

**Why:** proj-cli needs to know exactly what endpoints and fields are available.

**Priority:** High (enables Tier 1 implementation)

**Status:** ✅ Complete - See [research-tier-1-api-contract.md](../../research/project-model-definition/research-tier-1-api-contract.md)

**Key Finding:** API is **complete and ready**. OpenAPI 3.0.3 spec (691 lines) is authoritative. proj-cli client fully compatible. 7 Tier 1 fields ready to use.

**Sub-questions:**

- What endpoints exist in work-prod?
- What fields are required vs optional on create?
- What fields are returned on list/get?
- Error response format?

**Deliverable:** API contract document for proj-cli team

---

### Research Topic 4: Learning Taxonomy Implementation

**Question:** How should learning sub-classification be implemented?

**Why:** 17 of 59 projects are Learning type - needs sub-classification for meaningful metrics.

**Priority:** High (Tier 3, but marked MVP-critical)

**Status:** ✅ Complete - See [research-learning-taxonomy.md](../../research/project-model-definition/research-learning-taxonomy.md)

**Key Finding:** Three-type taxonomy validated: `work_related`, `personal_dev`, `hybrid`. Work-related learning counts toward work metrics (apprenticeship reality). Hybrid projects visible in both work and personal views. Tier 3 depends on Tier 2 (`project_type`) being implemented first.

**Sub-questions:**

- Are the three learning types sufficient? ✅ Yes - covers all scenarios
- Should learning_type be required for Learning classification? ✅ Yes, only non-NULL when project_type = 'Learning'
- How to handle existing Learning projects without sub-classification? ✅ Migration with path-based heuristics
- UI implications? ✅ Filtering interface and badges designed

**Reference:** [work-prod Learning Project Taxonomy](../../../../work-prod/docs/maintainers/research/data-models/learning-project-taxonomy.md) (429 lines of detailed research)

---

### Research Topic 5: Skills Matrix Integration

**Question:** How should projects connect to the skills matrix?

**Why:** Skills matrix is a key feature - projects need to link to skills.

**Priority:** Medium (Tier 4)

**Status:** 🔴 Not Started

**Sub-questions:**

- JSON `tech_stack` vs junction table vs both?
- How to populate skills from inventory scan?
- Proficiency tracking per project - is it needed?
- How to sync with GitHub language detection?

**Reference:** [work-prod Projects Data Model](../../../../work-prod/docs/maintainers/research/data-models/projects-data-model.md) (Section: Projects-Skills Junction Table)

---

### Research Topic 6: Analysis Field Requirements

**Question:** What fields does the analysis service need?

**Why:** Analysis service (work-prod) needs specific fields to calculate metrics.

**Priority:** Low (Tier 5)

**Status:** 🔴 Not Started

**Sub-questions:**

- What analysis capabilities are planned?
- What fields feed those capabilities?
- Can analysis be computed vs stored?
- How to keep analysis fields up to date?

**Reference:** [Work-Prod Analysis Service Exploration](../work-prod-analysis-service/README.md)

---

## 📊 Priority Matrix

| Topic                       | Priority | Tier | Status         |
| --------------------------- | -------- | ---- | -------------- |
| Tier 1 API Contract         | High     | 1    | ✅ Complete    |
| Classification Enum         | High     | 2    | ✅ Complete    |
| Organization Implementation | Medium   | 2    | ✅ Complete    |
| Learning Taxonomy           | High     | 3    | ✅ Complete    |
| Skills Matrix Integration   | Medium   | 4    | 🔴 Not Started |
| Analysis Field Requirements | Low      | 5    | 🔴 Not Started |

**Recommended Research Order:**

1. ✅ Tier 1 API Contract (enables proj-cli work immediately)
2. ✅ Classification Enum (foundational decision)
3. ✅ Organization Implementation (string field sufficient)
4. ✅ Learning Taxonomy (three-type system validated)
5. Skills Matrix Integration (depends on Skills feature)
6. Analysis Field Requirements (depends on Analysis service)

---

## 🎯 Research Workflow

1. ✅ Used `/research project-model-definition --conduct` to conduct research
2. ✅ Research documents created in `admin/research/project-model-definition/`
3. 🟠 4/6 topics complete
4. ➡️ Next: Skills Matrix Integration (Topic 5)
5. After research complete, use `/decision project-model-definition --from-research` to make decisions

---

## 🔗 Related Research

- **[Project Model Definition Research Hub](../../research/project-model-definition/README.md)** - Research documents
- **[work-prod Projects Data Model](../../../../work-prod/docs/maintainers/research/data-models/projects-data-model.md)** - Comprehensive research (1100+ lines)
- **[work-prod Learning Project Taxonomy](../../../../work-prod/docs/maintainers/research/data-models/learning-project-taxonomy.md)** - Learning classification
- **[Four-Arm Architecture](../four-arm-architecture/README.md)** - Ecosystem context

---

**Last Updated:** 2025-12-23
