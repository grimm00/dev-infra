# Research: Organization Implementation

**Research Topic:** Project Model Definition  
**Question:** Should `organization` remain a string field or migrate to FK?  
**Status:** ✅ Complete  
**Priority:** 🟡 Medium (Tier 2)  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-23

---

## 🎯 Research Question

Should `organization` remain a string field or migrate to a foreign key relationship?

**Current Implementation:**

```python
organization = db.Column(db.String(100), nullable=True, index=True)
```

**Research Recommendation:**

```python
organization_id = db.Column(db.Integer, db.ForeignKey('organizations.id'))
```

---

## 🔍 Research Goals

- [x] Goal 1: Determine if work-prod has an organizations table
- [x] Goal 2: Identify organization metadata requirements
- [x] Goal 3: Evaluate benefits of FK vs string
- [x] Goal 4: Assess migration complexity

---

## 📚 Research Methodology

**Approach:** Audit work-prod implementation and evaluate options.

**Sources:**

- [x] work-prod database schema (`backend/app/models/project.py`)
- [x] work-prod migrations (`backend/migrations/versions/`)
- [x] work-prod projects-data-model.md research
- [x] Existing data audit (`scripts/projects.json`)
- [x] Mapping script (`scripts/map_inventory_to_projects.py`)

---

## 📊 Findings

### Finding 1: No Organizations Table Exists

The `work-prod` database only has a `projects` table. There is no `organizations` table, despite the research document recommending one.

**Database models found:**

- `backend/app/models/project.py` - Only model file
- `backend/app/models/__init__.py` - No other models imported

**Migrations:**

- `879b388fb5ae_add_projects_table.py` - Initial projects table
- `377f1471283c_add_organization_classification_status_.py` - Added org/classification as strings

**Source:** `work-prod/backend/app/models/`, `work-prod/backend/migrations/versions/`

**Relevance:** FK approach requires creating Organizations table first, which is additional work.

---

### Finding 2: String Field Currently Works

The current string implementation is functional:

```python
organization = db.Column(db.String(100), nullable=True, index=True)
```

**Usage in API:**

- Supports filtering by organization
- Included in project list/get responses
- Updatable via PATCH endpoint

**Source:** `work-prod/backend/app/models/project.py`, `work-prod/backend/openapi.yaml`

**Relevance:** No immediate need to change - current approach is working.

---

### Finding 3: Limited Organization Values in Use

Audit of existing data (`scripts/projects.json`) shows only one organization value is currently used:

| Organization | Count |
| ------------ | ----- |
| DRW          | 18    |
| (null)       | 35    |

The `map_inventory_to_projects.py` script maps classifications to organizations:

```python
def extract_organization(classification):
    if classification == 'Work (DRW)':
        return 'DRW'
    elif classification == 'Apprenti':
        return 'Apprenti'
    return None
```

**Expected values:** `DRW`, `Apprenti`, `Personal` (3 total)

**Source:** `work-prod/scripts/projects.json`, `work-prod/scripts/map_inventory_to_projects.py`

**Relevance:** With only 3 known values, string field is manageable. Typo risk is low.

---

### Finding 4: Research Document Recommended FK

The `projects-data-model.md` research document (1100+ lines) recommended FK with organizations table:

```sql
CREATE TABLE organizations (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,  -- 'DRW', 'Apprenti', 'Personal'
    display_name TEXT,  -- 'DRW Trading', 'Apprenti/WTIA', 'Personal Projects'
    type TEXT,  -- 'employer_host', 'employer', 'personal'
    color TEXT,  -- UI color code
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

**Rationale for FK:**

- Referential integrity enforced
- Organization metadata (logo, color, description)
- Prevents typos
- Supports future expansion

**Source:** `work-prod/docs/maintainers/research/data-models/projects-data-model.md`

**Relevance:** The recommendation was made but NOT implemented. This was a conscious deferral.

---

### Finding 5: Migration Would Be Straightforward

If FK is desired, migration path is clear:

1. Create `organizations` table
2. Seed with initial data (DRW, Apprenti, Personal)
3. Add `organization_id` FK column to projects
4. Migrate existing string data to FK references
5. (Optional) Drop old `organization` string column

**Complexity:** Medium - requires data migration and API changes

**Source:** SQLAlchemy migration patterns, Flask-Migrate documentation

**Relevance:** Migration is feasible but adds implementation overhead.

---

## 🔍 Analysis

**Key Insights:**

- [x] Insight 1: **FK approach is ideal long-term** but was consciously deferred
- [x] Insight 2: **String approach is working** for current needs
- [x] Insight 3: **Only 3 organization values** expected, limiting typo risk
- [x] Insight 4: **No immediate pain point** - no bugs or data issues from string approach
- [x] Insight 5: **Metadata needs are minimal** - color/description not currently needed

**Options:**

1. Keep string (simple, works now)
2. Add FK, keep string for backward compatibility
3. Migrate to FK only (breaking change)

**Trade-offs:**

| Option          | Pros                                  | Cons                                |
| --------------- | ------------------------------------- | ----------------------------------- |
| Keep String     | Simple, no migration, already working | No referential integrity, typo risk |
| Add FK + String | Both benefits, gradual migration      | Data duplication, complexity        |
| Migrate to FK   | Integrity, metadata, clean design     | Migration required, API changes     |

**Decision Matrix:**

| Factor                | String                 | FK           |
| --------------------- | ---------------------- | ------------ |
| Implementation effort | ✅ None                | 🟡 Medium    |
| Current functionality | ✅ Working             | N/A          |
| Data integrity        | 🟡 Low risk (3 values) | ✅ Enforced  |
| Metadata support      | ❌ None                | ✅ Full      |
| Future scalability    | 🟡 Limited             | ✅ Excellent |

---

## 💡 Recommendations

- [x] Recommendation 1: **Keep string field for now** - No immediate need to change
- [x] Recommendation 2: **Defer FK migration to Tier 4+** - When organization metadata is needed
- [x] Recommendation 3: **Validate organization values in API** - Add enum validation for known values
- [x] Recommendation 4: **Document planned migration path** - For future reference

**Rationale:** The string approach is working, has low risk with only 3 known values, and migration to FK can be done when there's a concrete need for organization metadata (colors, logos, etc.).

---

## 📋 Requirements Discovered

- [x] FR-3a: Organization field may remain a string for Tier 2 (no FK required)
- [x] FR-3b: Organization values should be validated (enum-like validation in API)
- [x] FR-3c: Supported organization values: `DRW`, `Apprenti`, `Personal`, `null`
- [x] NFR-3: Organization migration to FK should be deferred until metadata is needed
- [x] C-4: No organizations table exists; creation is optional enhancement

---

## 🚀 Next Steps

1. ✅ Research complete
2. Continue with other research topics
3. When organization metadata is needed, revisit FK approach

---

**Last Updated:** 2025-12-23
