# Project Model Definition - Research Hub

**Purpose:** Research for unified project model across the four-arm ecosystem  
**Status:** 🔴 Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

- **[Research: Tier 1 API Contract](research-tier-1-api-contract.md)** - API contract for proj-cli (High Priority)
- **[Research: Classification Enum](research-classification-enum.md)** - Classification value alignment (High Priority)
- **[Research: Learning Taxonomy](research-learning-taxonomy.md)** - Learning sub-classification (High Priority)
- **[Research: Organization Implementation](research-organization-implementation.md)** - String vs FK (Medium Priority)
- **[Research: Skills Matrix Integration](research-skills-matrix-integration.md)** - Project-skill relationships (Medium Priority)
- **[Research: Analysis Field Requirements](research-analysis-field-requirements.md)** - Analysis service needs (Low Priority)

---

## 🎯 Research Overview

Researching the unified project model that enables proj-cli and work-prod to work together, with a tiered approach:

- **Tier 1:** Core Registry (MVP) - 7 fields ready
- **Tier 2:** Classification & Organization
- **Tier 3:** Learning Sub-Classification
- **Tier 4:** Skills Matrix Integration
- **Tier 5:** Analysis & Metrics

**Research Topics:** 6 topics  
**Status:** 🔴 Research

**Source:** [Project Model Definition Exploration](../../explorations/project-model-definition/README.md)

---

## 📊 Research Status

| Research Topic | Priority | Tier | Status | Document |
|----------------|----------|------|--------|----------|
| Tier 1 API Contract | 🔴 High | 1 | ✅ Complete | [research-tier-1-api-contract.md](research-tier-1-api-contract.md) |
| Classification Enum | 🔴 High | 2 | 🔴 Not Started | [research-classification-enum.md](research-classification-enum.md) |
| Learning Taxonomy | 🔴 High | 3 | 🔴 Not Started | [research-learning-taxonomy.md](research-learning-taxonomy.md) |
| Organization Implementation | 🟡 Medium | 2 | 🔴 Not Started | [research-organization-implementation.md](research-organization-implementation.md) |
| Skills Matrix Integration | 🟡 Medium | 4 | 🔴 Not Started | [research-skills-matrix-integration.md](research-skills-matrix-integration.md) |
| Analysis Field Requirements | 🟢 Low | 5 | 🔴 Not Started | [research-analysis-field-requirements.md](research-analysis-field-requirements.md) |

---

## 🚀 Recommended Research Order

1. **Tier 1 API Contract** - Enables proj-cli work immediately
2. **Classification Enum** - Foundational decision for Tier 2
3. **Learning Taxonomy** - MVP-critical per work-prod research
4. **Organization Implementation** - Can defer, less urgent
5. **Skills Matrix Integration** - Depends on Skills feature
6. **Analysis Field Requirements** - Depends on Analysis service

---

## 🔗 Related Research

- **[work-prod Projects Data Model](../../../work-prod/docs/maintainers/research/data-models/projects-data-model.md)** - Existing comprehensive research
- **[work-prod Learning Taxonomy](../../../work-prod/docs/maintainers/research/data-models/learning-project-taxonomy.md)** - Learning classification details
- **[Work-Prod Integration Research](../work-prod-integration/README.md)** - API integration patterns

---

## 🚀 Next Steps

1. Use `/research project-model-definition --conduct` to research all topics
2. Or use `/research project-model-definition --conduct --topic-num 1` for incremental research
3. After research complete, use `/decision project-model-definition --from-research` to make decisions

---

**Last Updated:** 2025-12-22

