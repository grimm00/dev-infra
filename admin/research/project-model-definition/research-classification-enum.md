# Research: Classification Enum Alignment

**Research Topic:** Project Model Definition  
**Question:** Should work-prod migrate from current classification values to research-recommended values?  
**Status:** ✅ Complete  
**Priority:** 🔴 High (Tier 2)  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-23  
**Completed:** 2025-12-23

---

## 🎯 Research Question

Should work-prod migrate from current classification values to research-recommended values?

**Current Implementation:**

```python
classification = Enum('primary', 'secondary', 'archive', 'maintenance')
```

**Research Recommendation:**

```python
classification = Enum('Work', 'Personal', 'Learning', 'Inactive')
```

---

## 🔍 Research Goals

- [x] Goal 1: Understand why current enum values were chosen
- [x] Goal 2: Determine if existing data uses current values
- [x] Goal 3: Evaluate migration complexity
- [x] Goal 4: Recommend path forward

---

## 📚 Research Methodology

**Approach:** Audit implementation history and data, evaluate migration options.

**Sources:**

- [x] work-prod project model (`backend/app/models/project.py`)
- [x] work-prod database migrations (`377f1471283c`)
- [x] work-prod projects-data-model.md research (1100+ lines)
- [x] work-prod mapping script (`map_inventory_to_projects.py`)
- [x] Existing data (`scripts/projects.json`)

---

## 📊 Findings

### Finding 1: Current and Research Enums Represent DIFFERENT Concepts

**Critical Discovery:** The current enum and research enum are not alternative representations of the same concept - they represent fundamentally different dimensions:

| Aspect            | Current Enum                                             | Research Enum                          |
| ----------------- | -------------------------------------------------------- | -------------------------------------- |
| **Concept**       | Priority/Importance                                      | Project Type                           |
| **Values**        | `primary`, `secondary`, `archive`, `maintenance`         | `Work`, `Personal`, `Learning`, `Inactive` |
| **Answers**       | "How important is this project?"                         | "What kind of project is this?"        |
| **Use Case**      | Prioritization, time allocation                          | Categorization, filtering, metrics     |

**Source:** `work-prod/docs/maintainers/research/data-models/projects-data-model.md`, `backend/app/models/project.py`

**Relevance:** This means migration isn't just changing enum values - it's changing the semantic meaning of the field entirely.

---

### Finding 2: Mapping Script Conflates Type Information

The current mapping script (`map_inventory_to_projects.py`) loses project type information:

```python
CLASSIFICATION_MAP = {
    'Personal': 'primary',      # ❌ Loses "Personal" type
    'Work (DRW)': 'primary',    # ❌ Loses "Work" type  
    'Apprenti': 'primary',      # ❌ Loses "Apprenti" type
    'Learning': 'secondary',    # ✅ Preserved (sort of)
    'Inactive/Archived': 'archive',  # ✅ Preserved
}
```

**Problem:** After mapping, you cannot distinguish:
- Is a `primary` project Work, Personal, or Apprenti?
- Is the `primary` DRW project a learning project or a work project?

**Source:** `work-prod/scripts/map_inventory_to_projects.py`, lines 24-32

**Relevance:** This confirms the current schema cannot answer "what type of project is this?" - a core requirement.

---

### Finding 3: Existing Data Distribution

Analysis of `projects.json` (48 projects):

| Classification | Count | Usage |
| -------------- | ----- | ----- |
| `primary` | 40 | Personal, Work, DRW Learning all mixed |
| `secondary` | 6 | Learning projects without organization |
| `archive` | 7 | Inactive/Archived projects |
| `maintenance` | 0 | Never used |

**Key Problem:**
- 40 "primary" projects include Work, Personal, AND Learning projects
- No way to filter "show me all Work projects" or "show me all Personal projects"
- The `organization` field partially helps (DRW vs null) but isn't sufficient

**Source:** `work-prod/scripts/projects.json`

**Relevance:** Data loss has already occurred - current data cannot distinguish project types within "primary".

---

### Finding 4: Research Requires Project TYPE Classification

The research document explicitly requires type classification for:

1. **Metrics Separation:**
   ```
   Work Projects: 20
   Work-Related Learning: 8
   Total Work Context: 28

   Personal Projects: 16
   Personal Development Learning: 7
   Total Personal Context: 23
   ```

2. **Learning Sub-Classification (Tier 3):**
   - `learning_type` field requires knowing if project is `Learning` type first
   - Current schema has no way to identify Learning projects reliably

3. **Filtering:**
   - "Show all Work projects"
   - "Show all Personal projects"
   - "Show all Learning projects"

**Source:** `work-prod/docs/maintainers/research/data-models/projects-data-model.md`, lines 229-262

**Relevance:** The research requirements cannot be met with current enum values.

---

### Finding 5: Migration Complexity Analysis

**Option A: Replace Values (Breaking Change)**

```sql
-- Requires data migration
UPDATE projects SET classification = 'Work' WHERE classification = 'primary' AND organization = 'DRW';
UPDATE projects SET classification = 'Personal' WHERE classification = 'primary' AND organization IS NULL;
-- Problem: Can't determine Learning vs Personal for primary projects!
```

**Complexity:** 🔴 HIGH - Cannot accurately migrate existing data

**Option B: Add New Field, Keep Old (Recommended)**

```sql
ALTER TABLE projects ADD COLUMN project_type TEXT 
    CHECK (project_type IN ('Work', 'Personal', 'Learning', 'Inactive'));
-- Keep classification for backward compatibility (or rename to 'priority')
```

**Complexity:** 🟢 LOW - Additive change, no data loss

**Option C: Rename and Repurpose**

```sql
-- Rename classification to priority
ALTER TABLE projects RENAME COLUMN classification TO priority;
-- Add project_type as new field
ALTER TABLE projects ADD COLUMN project_type TEXT;
```

**Complexity:** 🟡 MEDIUM - Requires API changes and client updates

**Source:** Analysis of current schema and data

**Relevance:** Option B is safest path forward - add `project_type` as new field.

---

### Finding 6: The Two-Field Solution

Based on research, projects need BOTH dimensions:

| Field           | Purpose                  | Values                                     |
| --------------- | ------------------------ | ------------------------------------------ |
| `project_type`  | What kind of project?    | `Work`, `Personal`, `Learning`, `Inactive` |
| `priority`      | How important?           | `primary`, `secondary`, `archive`, `maintenance` |

**Example Usage:**

| Project           | project_type | priority     | Meaning                              |
| ----------------- | ------------ | ------------ | ------------------------------------ |
| work-prod         | Work         | primary      | Primary work project                 |
| pokehub           | Personal     | primary      | Main personal project                |
| containers-learning | Learning   | secondary    | Secondary learning project           |
| B-IT              | Inactive     | archive      | Archived inactive project            |

**Source:** Analysis of research requirements and current schema limitations

**Relevance:** This satisfies both current functionality and research requirements.

---

## 🔍 Analysis

**Key Insights:**

- [x] Insight 1: **Current enum is priority, not type** - The values `primary`, `secondary`, `archive`, `maintenance` describe importance, not project category
- [x] Insight 2: **Data loss already occurred** - Cannot distinguish Work vs Personal vs Learning for "primary" projects
- [x] Insight 3: **Research requires type dimension** - Metrics, filtering, and Learning sub-classification all need type
- [x] Insight 4: **Two-field solution is optimal** - Keep priority (current), add project_type (research)
- [x] Insight 5: **`maintenance` value unused** - Can be deprecated or repurposed

**Migration Options Summary:**

| Option                 | Complexity | Data Loss | API Breaking | Recommendation |
| ---------------------- | ---------- | --------- | ------------ | -------------- |
| Replace Values         | 🔴 High    | Yes       | Yes          | ❌ Not Recommended |
| Add New Field          | 🟢 Low     | No        | No           | ✅ Recommended |
| Rename + Repurpose     | 🟡 Medium  | No        | Yes          | ⚠️ Consider Later |

---

## 💡 Recommendations

- [x] Recommendation 1: **Add `project_type` field** - New enum with `Work`, `Personal`, `Learning`, `Inactive`
- [x] Recommendation 2: **Keep `classification` as-is for now** - Rename to `priority` later if desired
- [x] Recommendation 3: **Update mapping script** - Map inventory types to BOTH fields
- [x] Recommendation 4: **Backfill existing data** - Use organization and path heuristics to infer project_type
- [x] Recommendation 5: **Require `project_type` on new projects** - Make it non-nullable going forward

---

## 📋 Requirements Discovered

- [x] **REQ-1:** work-prod must add `project_type` field with enum `Work`, `Personal`, `Learning`, `Inactive`
- [x] **REQ-2:** `project_type` should be required for new projects (non-nullable with no default)
- [x] **REQ-3:** Mapping script must populate BOTH `classification` AND `project_type`
- [x] **REQ-4:** API must support filtering by `project_type`
- [x] **REQ-5:** Existing data must be backfilled with inferred `project_type` values
- [x] **REQ-6:** Consider renaming `classification` to `priority` in future release for clarity

---

## 📋 Proposed Schema Change

**Tier 2 Schema Addition:**

```python
# Add to Project model
project_type = db.Column(
    Enum('Work', 'Personal', 'Learning', 'Inactive', name='project_type_enum'),
    nullable=True,  # Start nullable for migration, later make non-null
    index=True
)
```

**Migration Strategy:**

1. Add `project_type` as nullable column
2. Run backfill script:
   - `organization = 'DRW'` → `project_type = 'Work'`
   - `path LIKE '%/Learning/%'` → `project_type = 'Learning'`
   - `classification = 'archive'` → `project_type = 'Inactive'`
   - Remaining → `project_type = 'Personal'` (default assumption)
3. Make `project_type` required for new records
4. (Optional) Rename `classification` to `priority` in future release

---

## 🚀 Next Steps

1. ✅ Research complete - two-field solution recommended
2. ➡️ Continue with Learning Taxonomy research (Topic 3) - depends on `project_type = 'Learning'`
3. ➡️ Create ADR for schema change after all research complete

---

**Last Updated:** 2025-12-23
