# ADR-004: Keep classification Field

**Status:** Accepted  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23

---

## Context

With ADR-003 adding a new `project_type` field, we need to decide what to do with the existing `classification` field. Options include keeping it as-is, renaming it to `priority`, or removing it entirely.

The current `classification` field with values `primary`, `secondary`, `archive`, `maintenance` represents project priority/importance and is actively used for time allocation decisions.

**Related Research:**

- [Research Summary](../../research/project-model-definition/research-summary.md)
- [Classification Enum Research](../../research/project-model-definition/research-classification-enum.md)

**Related Requirements:**

- [Requirements Document](../../research/project-model-definition/requirements.md) - NFR-2, NFR-3

---

## Decision

**Decision:** Keep the existing `classification` field as-is. Consider renaming to `priority` in a future release for clarity.

**Current Schema (Unchanged):**

```python
classification = db.Column(
    Enum('primary', 'secondary', 'archive', 'maintenance', name='classification_enum'),
    nullable=True,
    default='primary',
    index=True
)
```

**Ownership:**

| Arm | Role | Responsibilities |
|-----|------|------------------|
| **work-prod** | Schema Owner | Maintains field, optional future rename |

---

## Consequences

### Positive

- **Backward compatibility:** No API breaking changes
- **No migration risk:** Existing data and queries unchanged
- **Preserves priority dimension:** Users can still prioritize projects
- **Gradual transition:** Rename can happen later with proper deprecation

### Negative

- **Name confusion:** "classification" doesn't clearly convey "priority"
- **Two classification-like fields:** `classification` and `project_type` may confuse users initially
- **Documentation burden:** Must clearly explain the difference

---

## Alternatives Considered

### Alternative 1: Rename to priority Immediately

**Description:** Rename `classification` to `priority` in the same migration as adding `project_type`.

**Pros:**
- Clearer field names immediately
- Single coordinated change

**Cons:**
- API breaking change
- Requires coordinated proj-cli update
- Additional testing burden
- Risk of bugs in rename migration

**Why not chosen:** Adds unnecessary risk. Additive change (ADR-003) is safer. Rename can happen later.

---

### Alternative 2: Remove classification Field

**Description:** Remove `classification` entirely since `project_type` provides categorization.

**Pros:**
- Simpler schema
- No confusion between fields

**Cons:**
- Loses priority dimension ("How important is this project?")
- Breaking change
- Different semantic meaning than `project_type`

**Why not chosen:** Priority and Type are different dimensions - both are valuable. A project can be Work + primary or Work + secondary.

---

### Alternative 3: Deprecate Now, Remove Later

**Description:** Mark `classification` as deprecated, plan removal in 6 months.

**Pros:**
- Clear migration path
- Forces cleanup

**Cons:**
- Loses priority dimension (if removed)
- Deprecation overhead

**Why not chosen:** The field provides value (priority). No need to deprecate, just optionally rename for clarity.

---

## Decision Rationale

**Key Factors:**

1. **Different dimensions:** Priority and Type answer different questions
2. **Working functionality:** Current classification works for prioritization
3. **Risk minimization:** Keeping field avoids breaking changes
4. **Future flexibility:** Can rename to `priority` later with proper deprecation

**Research Support:**

- Finding 6: Two-field solution - projects need BOTH priority and type
- Recommendation 2: Keep `classification` as-is for now

---

## Requirements Impact

**Requirements Satisfied:**

- NFR-2: Migration Safety - ✅ No data changes needed
- NFR-3: Backward Compatibility - ✅ No API breaking changes

**Future Consideration:**

- Optional: Rename `classification` to `priority` in future release
- If renamed: Deprecate old name, support both for transition period, update clients

---

## Implementation Notes

**Current State:**

- Field remains unchanged
- API continues to work as before
- Filtering by `classification` still supported

**Future Rename (Optional):**

If renaming is desired later:

1. Add `priority` as alias in API (accept both names)
2. Deprecate `classification` parameter name
3. Update clients to use `priority`
4. Remove `classification` alias after transition period
5. Rename column in database (optional, can use alias in ORM)

**Documentation Update:**

- Clearly document that `classification` represents priority, not type
- Explain the difference between `classification` and `project_type`
- Update API documentation in OpenAPI spec

---

## References

- [Research Summary](../../research/project-model-definition/research-summary.md)
- [Classification Enum Research](../../research/project-model-definition/research-classification-enum.md)
- [Requirements Document](../../research/project-model-definition/requirements.md)
- [work-prod Project Model](../../../../work-prod/backend/app/models/project.py)

---

**Last Updated:** 2025-12-23

