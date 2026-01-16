# Template Doc Infrastructure - Decisions Hub

**Purpose:** Architecture Decision Records for template-based documentation infrastructure  
**Status:** 🟠 In Progress  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14

---

## 📋 Quick Links

- **[Decisions Summary](decisions-summary.md)** - Summary of all decisions
- **[Research Hub](../../research/template-doc-infrastructure/README.md)** - Related research (7 topics complete)
- **[Requirements](../../research/template-doc-infrastructure/requirements.md)** - 36 FRs, 18 NFRs, 18 Constraints

### ADR Documents

| ADR | Decision | Status | Batch |
|-----|----------|--------|-------|
| [ADR-001](adr-001-architectural-placement.md) | Architectural Placement (Four-Arm) | ✅ Accepted | 1 |
| [ADR-002](adr-002-template-structure-standard.md) | Template Structure Standard | ✅ Accepted | 1 |
| [ADR-003](adr-003-generation-architecture.md) | Generation Architecture | 🔴 Pending | 2 |
| [ADR-004](adr-004-validation-architecture.md) | Validation Architecture | 🔴 Pending | 2 |
| [ADR-005](adr-005-command-integration.md) | Command Integration Pattern | 🔴 Pending | 3 |

---

## 🎯 Decisions Overview

These decisions formalize the findings from 7 completed research topics into actionable architecture decisions. The decisions are organized into batches based on dependencies.

**Decision Points:** 5 ADRs  
**Batches:** 3 implementation phases

---

## 📊 Decision Batching Plan

### Batch 1: Foundation (ADR-001, ADR-002) ✅

**Purpose:** Set boundaries and define what we're building.

| ADR | Decision | Research Source | Dependencies |
|-----|----------|-----------------|--------------|
| ADR-001 | Architectural Placement | Topic 6 | None (foundational) |
| ADR-002 | Template Structure Standard | Topics 1, 5 | ADR-001 (defines where) |

**Why together:** ADR-001 defines *where* things live. ADR-002 defines *what* templates we need. Both are foundational and don't depend on implementation details.

**Effort:** Medium (clear research, mostly formalizing)

---

### Batch 2: Implementation (ADR-003, ADR-004) 🔴

**Purpose:** Define how things work.

| ADR | Decision | Research Source | Dependencies |
|-----|----------|-----------------|--------------|
| ADR-003 | Generation Architecture | Topics 2, 5, 7 | ADR-001, ADR-002 |
| ADR-004 | Validation Architecture | Topic 3 | ADR-002, ADR-003 |

**Why together:** ADR-003 defines *how* templates are rendered. ADR-004 defines *how* compliance is validated. Both are implementation architecture.

**Sub-decisions included:**
- Template format (envsubst) → part of ADR-003
- Model selection config → mentioned in ADR-003 as future enhancement

**Effort:** Medium-High (more technical detail)

---

### Batch 3: Integration (ADR-005) 🔴

**Purpose:** Define how commands use the infrastructure.

| ADR | Decision | Research Source | Dependencies |
|-----|----------|-----------------|--------------|
| ADR-005 | Command Integration | Topic 4 | ADR-003, ADR-004 |

**Why separate:** Depends on all previous ADRs. Defines migration path for 23 commands.

**Effort:** Medium (clear migration path from research)

---

## 🗺️ Decision Dependencies

```
ADR-001 (Placement)
    │
    ▼
ADR-002 (Templates) ────────────────┐
    │                               │
    ▼                               ▼
ADR-003 (Generation) ──────► ADR-004 (Validation)
    │                               │
    └───────────────┬───────────────┘
                    ▼
            ADR-005 (Command Integration)
```

---

## 📋 Requirements Coverage

| ADR | Requirements Covered |
|-----|---------------------|
| ADR-001 | FR-15 through FR-18, NFR-9, NFR-10, C-7 through C-9 |
| ADR-002 | FR-1 through FR-5, FR-34 through FR-36, NFR-1 through NFR-3, NFR-17, NFR-18 |
| ADR-003 | FR-6 through FR-10, FR-31 through FR-33, NFR-4 through NFR-8, C-17, C-18 |
| ADR-004 | FR-19 through FR-25, NFR-11, NFR-12, C-10 through C-12 |
| ADR-005 | FR-26 through FR-30, NFR-13, NFR-14, C-13, C-14 |

**Coverage:** All 36 FRs, 18 NFRs, 18 Constraints addressed

---

## 🚀 Execution Plan

### Phase 1: Create ADR Scaffolds ✅

Create scaffold files for all 5 ADRs with:
- Standard ADR structure
- Context from research
- Decision statement (to be filled)
- Pre-populated alternatives from research

### Phase 2: Fill Batch 1 (Foundation)

1. **ADR-001:** Fill from Topic 6 research (architectural placement)
2. **ADR-002:** Fill from Topics 1 + 5 research (template structure + format)

**Expected output:** Clear boundaries for where things live and what templates we need.

### Phase 3: Fill Batch 2 (Implementation)

3. **ADR-003:** Fill from Topics 2 + 5 + 7 research (generation + format + model selection)
4. **ADR-004:** Fill from Topic 3 research (validation approach)

**Expected output:** Complete implementation architecture.

### Phase 4: Fill Batch 3 (Integration)

5. **ADR-005:** Fill from Topic 4 research (command integration)

**Expected output:** Migration plan for existing commands.

### Phase 5: Finalize

- Create decisions-summary.md
- Update this hub with final statuses
- Commit all ADRs

---

## 🎯 Efficiency Notes

**Why this chunking works:**

1. **Batch 1 is foundational** - Can't decide *how* until we decide *what* and *where*
2. **Batch 2 can be done in parallel** - Generation and validation are independent
3. **Batch 3 depends on all** - Integration needs all architecture defined first

**Time estimate:**
- Scaffolds: 10 min (one-time)
- Batch 1: 15-20 min (research is clear)
- Batch 2: 20-25 min (more detail needed)
- Batch 3: 15 min (migration path clear from research)
- Finalize: 5 min

**Total:** ~65-75 min for all 5 ADRs

---

## 🔗 Related

- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - All 11 findings
- [Requirements](../../research/template-doc-infrastructure/requirements.md) - 36 FRs, 18 NFRs, 18 Constraints
- [Exploration](../../explorations/template-doc-infrastructure/README.md) - Original exploration

---

**Last Updated:** 2026-01-14
