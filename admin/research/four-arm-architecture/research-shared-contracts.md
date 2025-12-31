# Research: Shared Contracts and Business Logic

**Research Topic:** Four-Arm Architecture  
**Question:** How should dev-infra coordinate shared schemas and business logic across all four arms while maintaining standalone usability?  
**Priority:** 🔴 High  
**Status:** 🔴 Not Started  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## 🎯 Research Question

How should dev-infra coordinate shared schemas and business logic across all four arms while maintaining standalone usability?

**Context:** Each project needs to work independently for external users, but internal development requires consistent contracts (API schemas, database models, JSON store formats).

**Key Tension:** Standalone usability vs. cross-arm consistency.

---

## 🔍 Research Goals

- [ ] Goal 1: Determine where shared contracts should live in dev-infra
- [ ] Goal 2: Design contract distribution mechanism to consuming projects
- [ ] Goal 3: Define how external users get contracts when using projects standalone
- [ ] Goal 4: Establish contract change coordination process
- [ ] Goal 5: Decide whether contracts should be versioned separately from templates
- [ ] Goal 6: Identify validation mechanisms for implementation-contract alignment

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources to investigate:**
- [ ] Review existing OpenAPI standard: `admin/planning/standards/openapi-source-of-truth/`
- [ ] Review work-prod's current `backend/openapi.yaml` (691 lines)
- [ ] Web search: Schema-first API development patterns
- [ ] Web search: Multi-repo contract management strategies
- [ ] Web search: Database schema version control patterns
- [ ] Case studies: Protobuf/gRPC, JSON Schema, OpenAPI in multi-service architectures

**Sub-questions to address:**
1. Where should shared contracts live in dev-infra? (`admin/contracts/`, templates, elsewhere?)
2. How are contracts distributed to consuming projects?
3. How do external users get contracts when using a project standalone?
4. How are contract changes coordinated across arms?
5. Should contracts be versioned separately from templates?
6. What validation ensures implementations match contracts?

**Contracts to consider:**
| Contract | Current Location | Owner |
|----------|-----------------|-------|
| work-prod API Schema | work-prod/backend/openapi.yaml | work-prod |
| work-prod Database Schema | work-prod/backend/app/models/ | work-prod |
| proj-cli JSON Store Schema | (not defined) | proj-cli |
| Project Model Definition | (not defined) | TBD |

---

## 📊 Options to Explore

### Option 1: Embedded Contracts

Each project has its own copy of contracts.

**Pros:**
- Simple implementation
- Full standalone capability
- No external dependencies

**Cons:**
- Drift risk between projects
- Difficult to coordinate changes
- Duplication

---

### Option 2: Shared Source

dev-infra holds canonical contracts, projects sync.

**Pros:**
- Single source of truth
- Coordinated changes
- Clear ownership

**Cons:**
- Sync complexity
- Build-time dependency
- May break standalone use

---

### Option 3: Published Contracts

dev-infra publishes contracts as versioned artifacts.

**Pros:**
- Versioned contracts
- Can be consumed independently
- Clear upgrade path

**Cons:**
- Publication overhead
- Version management complexity
- Additional release process

---

### Option 4: Hybrid Approach

Different strategies for different contract types.

**Pros:**
- Optimized per-contract
- Flexibility
- Can evolve over time

**Cons:**
- More complex to understand
- Multiple patterns to maintain

---

## 📊 Findings

### Finding 1: [Title]

[Description of finding]

**Source:** [Source reference]

**Relevance:** [Why this finding matters]

---

### Finding 2: [Title]

[Description of finding]

**Source:** [Source reference]

**Relevance:** [Why this finding matters]

---

## 🔍 Analysis

[Analysis of findings]

**Key Insights:**
- [ ] Insight 1: [Description]
- [ ] Insight 2: [Description]

---

## 💡 Recommendations

- [ ] Recommendation 1: [Description]
- [ ] Recommendation 2: [Description]

---

## 📋 Requirements Discovered

[Any requirements discovered during this research]

- [ ] Requirement 1: [Description]
- [ ] Requirement 2: [Description]

---

## 🔗 Related Research

- **[OpenAPI Source of Truth Standard](../../planning/standards/openapi-source-of-truth/README.md)** - Existing cross-arm standard
- **[Project Model Definition Research](../project-model-definition/README.md)** - Data model research
- **[Integration Points](research-integration-points.md)** - Related to how contracts are used

---

## 🚀 Next Steps

1. Analyze existing OpenAPI standard for patterns
2. Research multi-repo contract management strategies
3. Document findings and make recommendations

---

**Last Updated:** 2025-12-31

