# Project Model Definition - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 What Are We Exploring?

Establishing a **unified understanding of what a "project" is** across the four-arm architecture:

- **work-prod:** Defines the schema (source of truth)
- **proj-cli:** Consumes the schema via API
- **dev-infra:** Tracks template metadata
- **dev-toolkit:** No direct project model interaction

---

## 🤔 Why Explore This?

### Current Fragmentation

The project model exists in multiple places with different definitions:

| Location                              | Status      | Fields     | Problem                            |
| ------------------------------------- | ----------- | ---------- | ---------------------------------- |
| `work-prod/project.py`                | Implemented | 10 fields  | Minimal, missing learning taxonomy |
| `work-prod/projects-data-model.md`    | Research    | 15+ fields | Not implemented                    |
| `dev-infra/research-project-model.md` | Speculative | Guesses    | Uses "likely" language             |
| `proj-cli`                            | Consumer    | Unknown    | Needs to know what to use          |

### The Solution: Tiered Approach

Rather than trying to implement everything at once:

1. **Confirm what's ready** - Audit existing work-prod fields
2. **Define Tier 1** - Minimum viable project model
3. **Roadmap the rest** - Group advanced features by scope/timeline

---

## 📊 Current work-prod Implementation Audit

**Source:** `work-prod/backend/app/models/project.py`

### Fields Already Implemented

| Field            | Type        | Tier | Status    | Notes                               |
| ---------------- | ----------- | ---- | --------- | ----------------------------------- |
| `id`             | Integer     | 1    | ✅ Ready  | Auto-increment PK                   |
| `name`           | String(200) | 1    | ✅ Ready  | Required, indexed                   |
| `path`           | String(500) | 1    | ✅ Ready  | Unique, optional (local filesystem) |
| `description`    | Text        | 1    | ✅ Ready  | Optional                            |
| `remote_url`     | String(500) | 1    | ✅ Ready  | Optional (GitHub URL)               |
| `created_at`     | DateTime    | 1    | ✅ Ready  | Auto-populated                      |
| `updated_at`     | DateTime    | 1    | ✅ Ready  | Auto-updated                        |
| `organization`   | String(100) | 2    | ⚠️ Review | String vs FK decision needed        |
| `classification` | Enum        | 2    | ⚠️ Review | Values differ from research         |
| `status`         | Enum        | 2    | ✅ Ready  | active/paused/completed/cancelled   |

### Gap: Classification Enum Mismatch

**Current Implementation:**

```python
classification = Enum('primary', 'secondary', 'archive', 'maintenance')
```

**Research Recommendation:**

```python
classification = Enum('Work', 'Personal', 'Learning', 'Inactive')
```

**Decision Needed:** Which classification system to use?

### Gap: Organization as String

**Current Implementation:**

```python
organization = db.Column(db.String(100), nullable=True)
```

**Research Recommendation:**

```python
organization_id = db.Column(db.Integer, db.ForeignKey('organizations.id'))
```

**Decision Needed:** Keep string (simpler) or migrate to FK (more robust)?

---

## 🏗️ Tiered Approach

### Tier 1: Core Registry (MVP)

**Scope:** Minimum fields for proj-cli and work-prod to work together  
**Timeline:** Immediate  
**Status:** 7 fields ready, 0 changes needed

**Fields:**

- `id` - Unique identifier
- `name` - Project display name
- `path` - Local filesystem path (optional)
- `description` - Project description (optional)
- `remote_url` - GitHub/GitLab URL (optional)
- `created_at` - Record creation timestamp
- `updated_at` - Last modification timestamp

**Use Cases Supported:**

- `proj create "My Project"` - Create project record
- `proj list` - List all projects
- `proj get <id>` - Get project details
- `proj inv export api` - Push inventory to registry

**See:** [tier-1-core-registry.md](tier-1-core-registry.md) for detailed field definitions.

---

### Tier 2: Classification and Organization

**Scope:** Project categorization and filtering  
**Timeline:** Near-term  
**Status:** Fields exist but need alignment

**Fields:**

- `classification` - Work/Personal/Learning/Inactive (needs enum update)
- `organization` - DRW/Apprenti/Personal (FK vs string decision)
- `status` - active/paused/completed/cancelled (ready)

**Use Cases Supported:**

- Filter projects by type (work vs personal)
- Filter projects by organization
- Track project lifecycle status

**Decisions Needed:**

1. Reconcile classification enum values
2. Decide organization implementation (string vs FK)

---

### Tier 3: Learning Sub-Classification

**Scope:** Learning project taxonomy  
**Timeline:** Near-term  
**Status:** Not yet implemented

**Fields:**

- `learning_type` - work_related/personal_dev/hybrid
- `learning_context` - Free-form description of learning goals
- `learning_status` - exploring/active_learning/completed/paused

**Use Cases Supported:**

- Distinguish work-related learning from personal hobbies
- Track learning progress separately from project status
- Accurate time allocation between work and personal

**Reference:** [work-prod Learning Project Taxonomy](../../../../work-prod/docs/maintainers/research/data-models/learning-project-taxonomy.md)

**Note:** Marked as MVP-critical in work-prod research (17 of 59 projects are Learning).

---

### Tier 4: Skills Matrix Integration

**Scope:** Project-to-skill relationships  
**Timeline:** Medium-term  
**Status:** Not yet implemented

**Fields:**

- `tech_stack` - JSON array for quick access (["Python", "Flask", "React"])
- `projects_skills` - Junction table with proficiency tracking

**Junction Table Schema:**

```sql
projects_skills (
    project_id INTEGER,
    skill_id INTEGER,
    proficiency_used TEXT,  -- beginner/intermediate/advanced/expert
    is_primary_skill BOOLEAN,
    hours_spent INTEGER,
    PRIMARY KEY (project_id, skill_id)
)
```

**Use Cases Supported:**

- "What projects use Python?"
- "What skills does this project use?"
- Skills matrix visualization
- Tech stack portfolio analysis

---

### Tier 5: Analysis and Metrics

**Scope:** Advanced analysis capabilities  
**Timeline:** Longer-term  
**Status:** Not yet implemented

**Fields:**

- `last_worked_on` - Last git commit or file modification
- `project_size` - Lines of code or file count
- `is_favorite` - User can star projects
- `notes` - Free-form notes

**Additional Analysis (in work-prod service):**

- Health metrics
- Activity indicators
- Staleness detection
- Dependency analysis

**Reference:** [Work-Prod Analysis Service Exploration](../work-prod-analysis-service/README.md)

---

## 🔍 Key Decisions

### Decision 1: Tier 1 Field Confirmation

**Question:** Are the 7 Tier 1 fields sufficient for MVP?

**Proposed Answer:** Yes. `id`, `name`, `path`, `description`, `remote_url`, `created_at`, `updated_at` support all basic registry operations.

---

### Decision 2: Classification Enum Values

**Question:** Which classification system to use?

**Options:**

1. Keep current: `primary`, `secondary`, `archive`, `maintenance`
2. Adopt research: `Work`, `Personal`, `Learning`, `Inactive`
3. Hybrid: Map current to new

**Recommendation:** Adopt research values - they're more intuitive and support learning taxonomy.

---

### Decision 3: Organization Implementation

**Question:** String field or FK to organizations table?

**Options:**

1. Keep string: Simpler, no migration needed
2. Migrate to FK: More robust, supports organization metadata

**Recommendation:** Keep string for now (Tier 2), plan FK migration for later.

---

### Decision 4: Field Ownership

**Question:** Which project defines the schema?

**Answer:** work-prod is the source of truth. proj-cli consumes the API.

---

## 🚀 Next Steps

1. Confirm Tier 1 fields are sufficient
2. Decide on classification enum values
3. Decide on organization implementation
4. Create ADR if architectural decisions needed
5. Implement Tier 1 in proj-cli (already works with current work-prod)

---

## 📝 Notes

**User Insight (2025-12-22):**

> "There needs to be a deep discussion about what a project is and what useful information can be gleamed from its attributes. This means we may need to develop a full model. We need fields that will be helpful in both project management and analysis, especially for our skills matrix."

This exploration addresses that by:

1. Auditing what exists (not guessing)
2. Tiering features by priority
3. Connecting to skills matrix (Tier 4)
4. Supporting analysis use cases (Tier 5)

---

**Last Updated:** 2025-12-22

