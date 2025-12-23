# ADR-003: Add project_type Field

**Status:** Accepted  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23

---

## Context

The current `classification` field in work-prod uses values `primary`, `secondary`, `archive`, `maintenance` which represent **priority/importance**, not **project type**. Research identified that users need to answer "What kind of project is this?" (Work, Personal, Learning, Inactive) - a fundamentally different question than "How important is this project?"

The current mapping script conflates type information:
- Personal, Work, and Apprenti all map to `primary`
- After mapping, 40 "primary" projects include Work, Personal, AND Learning projects mixed together
- Cannot filter by "show me all Work projects" or "show me all Personal projects"

**Related Research:**

- [Research Summary](../../research/project-model-definition/research-summary.md)
- [Classification Enum Research](../../research/project-model-definition/research-classification-enum.md)

**Related Requirements:**

- [Requirements Document](../../research/project-model-definition/requirements.md) - FR-2, FR-2a through FR-2e

---

## Decision

**Decision:** Add a new `project_type` field to the work-prod projects table with enum values `Work`, `Personal`, `Learning`, `Inactive`.

**Schema Addition:**

```python
project_type = db.Column(
    Enum('Work', 'Personal', 'Learning', 'Inactive', name='project_type_enum'),
    nullable=True,  # Start nullable for migration, later make non-null
    index=True
)
```

**Ownership:**

| Arm | Role | Responsibilities |
|-----|------|------------------|
| **work-prod** | Schema Owner | Implements field, migration, API filtering |
| **proj-cli** | Consumer | Updates client to support project_type parameter |

---

## Consequences

### Positive

- **Answers the right question:** "What kind of project is this?"
- **Enables required filtering:** "Show all Work projects", "Show all Personal projects"
- **Supports Learning taxonomy:** Tier 3 `learning_type` field depends on `project_type = 'Learning'`
- **Non-breaking change:** Additive - doesn't modify existing data or functionality
- **Enables metrics:** Work vs Personal time tracking, project counts by type

### Negative

- **Data backfill needed:** Existing 48 projects need `project_type` inferred from heuristics
- **Heuristics imperfect:** Cannot perfectly recover type from conflated "primary" data
- **Two classification fields:** May cause initial confusion (but serves different purposes)

---

## Alternatives Considered

### Alternative 1: Replace classification Values

**Description:** Migrate existing `classification` enum from priority values to type values.

**Pros:**
- Single field
- Clean schema

**Cons:**
- Breaking change to API
- Cannot accurately migrate existing data
- Loses priority dimension entirely

**Why not chosen:** Cannot accurately migrate - 40 "primary" projects have unknown types. Also loses the priority dimension which is still useful.

---

### Alternative 2: Rename classification and Add project_type

**Description:** Rename `classification` to `priority`, then add `project_type` as new field.

**Pros:**
- Clearer field names
- Clean separation of concerns

**Cons:**
- API breaking change (field rename)
- More complex migration
- Requires coordinated client updates

**Why not chosen:** Complexity outweighs benefit. Can rename later as optional cleanup.

---

### Alternative 3: Keep Single Field, Accept Limitations

**Description:** Don't add `project_type`, accept current filtering limitations.

**Pros:**
- No schema change
- No migration needed

**Cons:**
- Cannot answer "what type of project?" question
- Cannot implement Learning taxonomy (Tier 3)
- Cannot provide accurate metrics by project type

**Why not chosen:** Research requirements cannot be met without type classification.

---

## Decision Rationale

**Key Factors:**

1. **Two different questions:** Priority ("How important?") and Type ("What kind?") are distinct dimensions
2. **Data loss already occurred:** Current mapping conflates types - adding new field is only recovery path
3. **Research requirements:** Metrics, filtering, and Learning sub-classification all require type
4. **Non-breaking:** Adding a field is safest migration path

**Research Support:**

- Finding 1: Current and research enums represent DIFFERENT concepts
- Finding 4: Research requires project TYPE classification
- Finding 6: Two-field solution satisfies both current and research requirements

---

## Requirements Impact

**Requirements Implemented:**

- FR-2: Project Type Classification - ✅ Enabled by this ADR
- FR-2a: Project Type Field Addition - ✅ Directly implemented
- FR-2b: Project Type Required for New Projects - 🟡 Enabled (work-prod decision)
- FR-2c: Mapping Script Update - 🟡 Enabled (work-prod task)
- FR-2d: API Filtering by Project Type - 🟡 Enabled (work-prod task)
- FR-2e: Data Backfill - 🟡 Enabled (work-prod task)
- NFR-2: Migration Safety - ✅ Satisfied (additive change)

---

## Implementation Notes

**Migration Strategy:**

1. Add `project_type` as nullable column (Flask-Migrate)
2. Run backfill script with heuristics:
   - `organization = 'DRW'` → `project_type = 'Work'`
   - `path LIKE '%/Learning/%'` → `project_type = 'Learning'`
   - `classification = 'archive'` → `project_type = 'Inactive'`
   - Remaining → `project_type = 'Personal'` (default assumption)
3. Update API to support `project_type` query parameter
4. Update mapping script to populate both fields
5. (Later) Make `project_type` non-nullable for new records

**work-prod Tasks:**

- [ ] Create migration for `project_type` field
- [ ] Implement backfill script
- [ ] Add API filtering support
- [ ] Update OpenAPI spec
- [ ] Update mapping script

---

## References

- [Research Summary](../../research/project-model-definition/research-summary.md)
- [Classification Enum Research](../../research/project-model-definition/research-classification-enum.md)
- [Requirements Document](../../research/project-model-definition/requirements.md)
- [work-prod Project Model](../../../../work-prod/backend/app/models/project.py)

---

**Last Updated:** 2025-12-23

