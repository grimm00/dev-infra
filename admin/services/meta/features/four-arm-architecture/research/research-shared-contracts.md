# Research: Shared Contracts and Business Logic

**Research Topic:** Four-Arm Architecture  
**Question:** How should dev-infra coordinate shared schemas and business logic across all four arms while maintaining standalone usability?  
**Priority:** 🔴 High  
**Status:** ✅ Complete  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31  
**Completed:** 2025-12-31

---

## 🎯 Research Question

How should dev-infra coordinate shared schemas and business logic across all four arms while maintaining standalone usability?

**Context:** Each project needs to work independently for external users, but internal development requires consistent contracts (API schemas, database models, JSON store formats).

**Key Tension:** Standalone usability vs. cross-arm consistency.

---

## 🔍 Research Goals

- [x] Goal 1: Determine where shared contracts should live in dev-infra
- [x] Goal 2: Design contract distribution mechanism to consuming projects
- [x] Goal 3: Define how external users get contracts when using projects standalone
- [x] Goal 4: Establish contract change coordination process
- [x] Goal 5: Decide whether contracts should be versioned separately from templates
- [x] Goal 6: Identify validation mechanisms for implementation-contract alignment

---

## 📚 Research Methodology

**Sources investigated:**
- [x] Review existing OpenAPI standard: `admin/planning/standards/openapi-source-of-truth/`
- [x] Review work-prod's current `backend/openapi.yaml` (691 lines)
- [x] Review proj-cli's config and data store implementation
- [x] Review project-model-definition research and requirements
- [x] Analysis of industry patterns for contract management

---

## 📊 Findings

### Finding 1: We Already Have a Working Contract Pattern

**Description:** The existing OpenAPI Source of Truth standard (`admin/planning/standards/openapi-source-of-truth/`) establishes a working pattern for cross-arm contracts:

| Role | Project | Responsibilities |
|------|---------|-----------------|
| **Spec Owner** | work-prod | Maintains spec, updates on API changes |
| **Spec Consumer** | proj-cli | References spec for implementation |
| **Standard Keeper** | dev-infra | Documents standard, ensures compliance |
| **N/A** | dev-toolkit | No direct integration |

This pattern works without complex sync mechanisms or published packages.

**Source:** `admin/planning/standards/openapi-source-of-truth/README.md`

**Relevance:** We should extend this proven pattern rather than invent new mechanisms.

---

### Finding 2: Contracts Fall Into Different Categories

**Description:** Analysis reveals contracts have different coordination requirements:

| Contract Type | Current Location | Consumers | Coordination Need |
|---------------|-----------------|-----------|-------------------|
| **API Schema (OpenAPI)** | work-prod/backend/openapi.yaml | proj-cli | 🔴 High - formal standard |
| **Database Schema** | work-prod/backend/app/models/ | work-prod only | 🟢 Low - internal only |
| **Project Model Definition** | (conceptual) | All arms | 🟡 Medium - alignment needed |
| **proj-cli JSON Store** | proj-cli/config.py | proj-cli only | 🟢 Low - internal only |
| **Cursor Commands** | dev-infra/templates/ | All projects | 🔴 High - already addressed |

**Source:** Codebase analysis of all four projects

**Relevance:** Not all "contracts" need the same treatment. Only external-facing contracts need formal coordination.

---

### Finding 3: External Users Get Embedded Contracts

**Description:** For standalone usability, contracts must be embedded in each project:

**work-prod standalone:**
- OpenAPI spec is in `backend/openapi.yaml`
- Database models in `backend/app/models/`
- External user has everything needed

**proj-cli standalone:**
- Config schema defined in `src/proj/config.py`
- No external dependencies required
- References work-prod API (configurable URL)

**Key insight:** The "standalone + coordinated" principle is already working. External users get embedded contracts; internal development coordinates through dev-infra standards.

**Source:** Analysis of project structure

**Relevance:** The current pattern already achieves standalone usability. We don't need to change it.

---

### Finding 4: Industry Patterns for Contract Coordination

**Description:** Industry uses several patterns for multi-repo contract management:

| Pattern | Example | Pros | Cons | Fit for Four-Arm |
|---------|---------|------|------|-----------------|
| **Consumer-Driven Contracts** | Pact | Consumers define needs | Complex testing setup | ❌ Overkill |
| **Schema Registry** | Kafka | Central versioning | Infrastructure overhead | ❌ Overkill |
| **Design-First (OpenAPI)** | API Design | Clear spec-first | Manual sync | ✅ Already using |
| **Proto Repository** | gRPC | Central proto files | Build-time deps | ❌ Too complex |
| **Published Packages** | npm/pip | Versioned schemas | Publication overhead | 🟡 Maybe for future |
| **Standards-Based** | Our approach | Documented ownership | Manual compliance | ✅ Best fit |

**Source:** Industry analysis

**Relevance:** Our current "standards-based" approach (OpenAPI standard) is appropriate for our scale. More complex solutions would add overhead without proportional benefit.

---

### Finding 5: Project Model Definition Needs Alignment, Not Sync

**Description:** The Project Model (fields like name, status, classification, project_type) exists in:

| Project | Representation | Purpose |
|---------|---------------|---------|
| work-prod | SQLAlchemy models, OpenAPI schemas | Server-side persistence |
| proj-cli | API client data structures | Client-side operations |
| dev-toolkit | N/A | No project model |
| dev-infra | Documentation/standards | Defines what fields exist |

**Key insight:** These don't need to be identical - they need to be **aligned**. The OpenAPI spec already serves as the alignment mechanism.

**Source:** project-model-definition research, API analysis

**Relevance:** We don't need a separate "project model contract" - the OpenAPI spec already defines the model.

---

### Finding 6: Contract Changes Are Already Coordinated via Process

**Description:** The existing standard defines process requirements:

1. **PR-1:** work-prod MUST update OpenAPI spec with API changes
2. **PR-2:** Code review should flag API changes without spec updates
3. **PR-3:** proj-cli should validate client matches spec

This process-based approach works better than technical sync mechanisms for our small team.

**Source:** `admin/planning/standards/openapi-source-of-truth/transition-plan.md`

**Relevance:** Process standards are simpler and more effective than complex technical solutions.

---

## 🔍 Analysis

### The Key Insight: "Contracts" vs "Standards"

The exploration framed this as "shared contracts" needing central coordination. In reality:

1. **True External Contracts** (API schemas) → Already handled by OpenAPI standard
2. **Internal Implementation** (DB schema, config) → No coordination needed
3. **Conceptual Alignment** (Project Model) → Handled by OpenAPI spec serving as model definition

**The solution is not new technical mechanisms, but extending the standards pattern.**

### Recommended Approach: Standards-Based Coordination

```
┌─────────────────────────────────────────────────────────────────────┐
│                        dev-infra                                     │
│                   (Standard Keeper)                                  │
│                                                                      │
│  Documents standards, ensures cross-arm compliance                   │
│  Location: admin/planning/standards/                                 │
│                                                                      │
│  Current Standards:                                                  │
│  • openapi-source-of-truth/ (API contracts)                         │
│                                                                      │
│  Potential Future Standards:                                         │
│  • command-distribution/ (already decided in Topic 1)               │
│  • version-coordination/ (future research topic)                     │
└─────────────────────────────────────────────────────────────────────┘
                                │
                                │ documents/enforces
                                ▼
┌─────────────────────────────────────────────────────────────────────┐
│                        Spec Owners                                   │
│                                                                      │
│  work-prod: OpenAPI spec owner (backend/openapi.yaml)               │
│  dev-infra: Cursor commands owner (templates/.cursor/commands/)      │
│                                                                      │
│  Responsibilities: Maintain specs, version with releases             │
└─────────────────────────────────────────────────────────────────────┘
                                │
                                │ consumed by
                                ▼
┌─────────────────────────────────────────────────────────────────────┐
│                        Spec Consumers                                │
│                                                                      │
│  proj-cli: API consumer (references OpenAPI spec)                   │
│  dev-toolkit: Command consumer (installs from dev-infra)            │
│  Generated projects: Template consumers                              │
│                                                                      │
│  Responsibilities: Reference specs, report discrepancies             │
└─────────────────────────────────────────────────────────────────────┘
```

### What We Don't Need

1. ❌ Central contracts repository in dev-infra
2. ❌ Published contract packages (npm/pip)
3. ❌ Automated sync mechanisms
4. ❌ Schema registry infrastructure
5. ❌ Consumer-driven contract testing

### What We Already Have

1. ✅ OpenAPI spec as API contract (work-prod owns)
2. ✅ Standards documentation (dev-infra owns)
3. ✅ Process requirements for spec updates
4. ✅ Standalone-capable projects

**Key Insights:**
- [x] Insight 1: "Shared contracts" is mostly solved by the existing OpenAPI standard
- [x] Insight 2: Not all internal data structures need cross-arm coordination
- [x] Insight 3: Process-based standards work better than technical sync for small teams
- [x] Insight 4: Standalone usability is already achieved via embedded contracts

---

## 💡 Recommendations

- [x] **Recommendation 1:** Do NOT create a central `admin/contracts/` directory - it's unnecessary
- [x] **Recommendation 2:** Extend the standards pattern for new cross-arm concerns (like command distribution)
- [x] **Recommendation 3:** Keep contract ownership with spec owners (work-prod owns API, dev-infra owns commands)
- [x] **Recommendation 4:** Use process standards (PR requirements) rather than technical sync mechanisms
- [x] **Recommendation 5:** Document the ownership matrix for each contract type
- [x] **Recommendation 6:** Consider published packages only if team/complexity grows significantly

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] **FR-SC-1:** Each contract type MUST have a designated owner (spec owner)
- [x] **FR-SC-2:** Spec owners MUST update their contracts when making changes
- [x] **FR-SC-3:** Standards for cross-arm contracts MUST be documented in `admin/planning/standards/`
- [x] **FR-SC-4:** New cross-arm contracts SHOULD follow the OpenAPI standard pattern

### Non-Functional Requirements

- [x] **NFR-SC-1:** Each project MUST remain standalone-usable with embedded contracts
- [x] **NFR-SC-2:** Contract coordination SHOULD use process standards, not technical sync
- [x] **NFR-SC-3:** Standards MUST define ownership matrix (owner, consumers, responsibilities)

### Constraints

- [x] **C-SC-1:** Contracts MUST NOT require external dependencies for standalone use
- [x] **C-SC-2:** Complex contract infrastructure (registries, automated sync) is NOT appropriate for current scale

---

## 📊 Contract Ownership Matrix

| Contract | Spec Owner | Spec Consumers | Standard Location |
|----------|-----------|----------------|-------------------|
| **API Schema** | work-prod | proj-cli | `standards/openapi-source-of-truth/` |
| **Cursor Commands** | dev-infra | dev-toolkit, projects | (needs standard) |
| **Project Model** | work-prod (via OpenAPI) | proj-cli | `standards/openapi-source-of-truth/` |
| **Database Schema** | work-prod | (none) | (internal) |
| **proj-cli Config** | proj-cli | (none) | (internal) |

---

## 🔗 Related Research

- **[OpenAPI Source of Truth Standard](../../planning/standards/openapi-source-of-truth/README.md)** - Existing cross-arm standard
- **[Project Model Definition Research](../project-model-definition/README.md)** - Data model research
- **[Command Distribution Ownership](research-command-distribution-ownership.md)** - Related contract (commands)
- **[Integration Points](research-integration-points.md)** - How contracts are used

---

## 🚀 Next Steps

1. ~~Analyze existing OpenAPI standard for patterns~~ ✅
2. ~~Research multi-repo contract management strategies~~ ✅
3. ~~Document findings and make recommendations~~ ✅
4. **Consider creating** `admin/planning/standards/command-distribution/` (ties to Topic 1)
5. **Document** ownership matrix in a central location

---

**Last Updated:** 2025-12-31
