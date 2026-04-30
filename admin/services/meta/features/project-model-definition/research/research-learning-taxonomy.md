# Research: Learning Taxonomy Implementation

**Research Topic:** Project Model Definition  
**Question:** How should learning sub-classification be implemented?  
**Status:** ✅ Complete  
**Priority:** 🔴 High (Tier 3, MVP-critical)  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-23  
**Completed:** 2025-12-23

---

## 🎯 Research Question

How should learning sub-classification be implemented?

**Context:** 17 of 59 projects (29%) are Learning type. Without sub-classification, the system cannot:
- Distinguish work-required learning from personal hobbies
- Accurately track work vs personal time allocation
- Provide meaningful metrics

---

## 🔍 Research Goals

- [x] Goal 1: Review existing work-prod learning taxonomy research
- [x] Goal 2: Validate three learning types are sufficient
- [x] Goal 3: Determine implementation approach
- [x] Goal 4: Plan migration for existing data

---

## 📚 Research Methodology

**Approach:** Review existing research, validate with user needs.

**Sources:**
- [x] work-prod Learning Project Taxonomy (429 lines) - PRIMARY SOURCE
- [x] work-prod projects-data-model.md
- [x] User requirements for learning tracking
- [x] Schema alignment with classification enum research

**Reference:** [work-prod Learning Project Taxonomy](../../../../work-prod/docs/maintainers/research/data-models/learning-project-taxonomy.md)

---

## 📊 Findings

### Finding 1: Three-Tier Classification System Proposed

The work-prod research proposes three learning types to sub-classify the 17 Learning projects:

| Learning Type | Description | Estimated Count |
| ------------- | ----------- | --------------- |
| `work_related` | Job-required skills, career development, company technologies | 8-10 projects |
| `personal_dev` | Hobby projects, non-work skills, academic learning for personal interest | 5-7 projects |
| `hybrid` | Portfolio projects, open-source contributions serving both purposes | 2-3 projects |

**Source:** work-prod Learning Project Taxonomy, lines 29-63

**Relevance:** This taxonomy directly addresses the user insight: *"While there are organizational buckets, some 'Learning' projects are work-related while others are personal development. I request ideas about how this can also be separated."*

---

### Finding 2: Schema Design Already Documented

The work-prod research proposes three fields for learning sub-classification:

```sql
-- Learning sub-classification (NULL for non-Learning projects)
learning_type VARCHAR(20) NULL,
  -- Values: 'work_related' | 'personal_dev' | 'hybrid' | NULL

-- Free-form learning goals/context
learning_context TEXT NULL,
  -- Examples: "Learning Python for data analysis at work"

-- Learning status (optional, for Phase 4)
learning_status VARCHAR(20) NULL,
  -- Values: 'exploring' | 'active_learning' | 'completed' | 'paused' | NULL
```

**Source:** work-prod Learning Project Taxonomy, lines 69-89

**Relevance:** Schema design is ready for implementation. Only `learning_type` is MVP-critical; `learning_context` and `learning_status` are enhancements.

---

### Finding 3: Key Design Decisions Resolved

Three design decisions were analyzed and resolved:

**Decision 1: Work-Related Learning Counts as Work Time (RECOMMENDED)**
- Work-related learning IS work (especially in apprenticeship context)
- Filter: `(classification = 'Work') OR (classification = 'Learning' AND learning_type = 'work_related')`
- Accurately represents work commitment

**Decision 2: Hybrid Projects Show in Both Views (RECOMMENDED)**
- Show in work view AND personal view with "🔀 Hybrid" badge
- Filter work view: `learning_type IN ('work_related', 'hybrid')`
- Filter personal view: `learning_type IN ('personal_dev', 'hybrid')`

**Decision 3: Manual Re-classification for MVP (RECOMMENDED)**
- When projects transition (personal → work-related), user manually updates
- Simple, transparent, sufficient for MVP
- Auto-suggest can be added in Phase 4

**Source:** work-prod Learning Project Taxonomy, lines 123-224

**Relevance:** These decisions align with the two-field solution from classification enum research - learning_type complements project_type.

---

### Finding 4: Data Migration Strategy Documented

Four-step migration for existing 17 Learning projects:

1. **Initial Import:** Import with `learning_type = NULL`
2. **Interactive Classification:** Extend `classify-projects.py` to prompt for sub-classification
3. **Seed Common Patterns:** Pre-populate based on project names/paths
4. **Bulk Update:** Apply user classifications, validate all Learning projects have `learning_type != NULL`

**Pattern Examples:**
- Path contains `~/Learning/python-for-work` → Suggest `work_related`
- Path contains `~/Learning/game-dev-tutorial` → Suggest `personal_dev`
- Name contains "portfolio" → Suggest `hybrid`

**Source:** work-prod Learning Project Taxonomy, lines 226-265

**Relevance:** Migration approach is well-defined and can be implemented with the mapping script.

---

### Finding 5: UI/UX and Metrics Integration Designed

**Filtering Interface:**
```
[All Projects ▼]
  ├── All Projects (59)
  ├── Work (20)
  ├── Personal (16)
  ├── Learning (17)
  │   ├── Work-Related Learning (10)
  │   ├── Personal Development (5)
  │   └── Hybrid (2)
  └── Inactive (6)
```

**Work Hours Calculation:**
```sql
SELECT SUM(time_spent) 
FROM time_entries te
JOIN projects p ON te.project_id = p.id
WHERE p.classification = 'Work'
   OR (p.classification = 'Learning' AND p.learning_type IN ('work_related', 'hybrid'))
```

**Source:** work-prod Learning Project Taxonomy, lines 267-389

**Relevance:** UI/UX design is ready for frontend implementation. Metrics calculations account for learning sub-types.

---

### Finding 6: Integration with Project Type Field

With the Classification Enum research finding that `project_type` should be added, learning taxonomy integrates as follows:

| project_type | learning_type | Description |
| ------------ | ------------- | ----------- |
| `Work` | `NULL` | Pure work project |
| `Personal` | `NULL` | Pure personal project |
| `Learning` | `work_related` | Learning for job/career |
| `Learning` | `personal_dev` | Learning for personal interest |
| `Learning` | `hybrid` | Learning for both purposes |
| `Inactive` | `NULL` or varies | Archived project |

**Constraint:** `learning_type` should only be non-NULL when `project_type = 'Learning'`.

**Relevance:** Learning taxonomy is a Tier 3 extension that depends on Tier 2 `project_type` being implemented.

---

## 🔍 Analysis

The work-prod learning taxonomy research is comprehensive (429 lines) and covers all aspects of implementation:

1. **Problem Statement:** Clearly identifies why sub-classification is needed
2. **Taxonomy Design:** Three types that cover all scenarios
3. **Schema Design:** Ready-to-implement SQL fields
4. **Design Decisions:** Three key decisions resolved with rationale
5. **Migration Strategy:** Step-by-step approach for existing data
6. **UI/UX Design:** Filtering interface and card designs
7. **Metrics Integration:** Calculations that account for learning types

**Key Insights:**
- [x] Insight 1: Three learning types (work_related, personal_dev, hybrid) are sufficient and cover all scenarios
- [x] Insight 2: Work-related learning should count toward work metrics (apprenticeship reality)
- [x] Insight 3: Hybrid projects need visibility in both work and personal views
- [x] Insight 4: `learning_type` depends on `project_type` (Tier 3 depends on Tier 2)
- [x] Insight 5: Migration can leverage path patterns to seed likely classifications

**Validation:** The proposed taxonomy directly addresses the user insight and provides clear separation between work-related and personal development learning.

---

## 💡 Recommendations

- [x] Recommendation 1: **Adopt three-type taxonomy** - `work_related`, `personal_dev`, `hybrid`
- [x] Recommendation 2: **Implement `learning_type` field** - Add to projects table with constraint
- [x] Recommendation 3: **Work-related learning counts as work** - Include in work metrics
- [x] Recommendation 4: **Hybrid shows in both views** - With clear "Hybrid" indicator
- [x] Recommendation 5: **Manual re-classification for MVP** - Defer auto-suggest to Phase 4
- [x] Recommendation 6: **Defer `learning_status` to Phase 4** - Not MVP-critical
- [x] Recommendation 7: **Use path-based heuristics for migration** - Seed likely classifications

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] FR-3: Learning projects must have sub-classification (work_related, personal_dev, hybrid)
- [x] FR-3a: `learning_type` field must be added to projects table
- [x] FR-3b: `learning_type` should only be non-NULL when `project_type = 'Learning'`
- [x] FR-3c: Work-related learning must be included in work metrics/views
- [x] FR-3d: Hybrid projects must appear in both work and personal views
- [x] FR-3e: API must support filtering by `learning_type` parameter
- [x] FR-3f: Mapping script must prompt for learning sub-classification

### Non-Functional Requirements

- [x] NFR-4: Learning taxonomy depends on project_type being implemented (Tier 3 depends on Tier 2)
- [x] NFR-5: UI must clearly indicate learning type with badges/labels

### Deferred to Phase 4

- [ ] FR-DEF-1: `learning_status` field (exploring, active_learning, completed, paused)
- [ ] FR-DEF-2: `learning_context` field (free-form description)
- [ ] FR-DEF-3: Auto-suggest re-classification when projects transition

---

## 🚀 Next Steps

1. ✅ Review existing work-prod learning taxonomy research
2. ✅ Validate learning types meet user needs
3. ✅ Plan implementation approach
4. ➡️ Implement after Tier 2 (`project_type`) is complete
5. ➡️ Continue with Skills Matrix Integration research (Topic 5)

---

**Last Updated:** 2025-12-23
