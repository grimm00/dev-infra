# Project Model Definition - Exploration Hub

**Purpose:** Establish a unified project model across the ecosystem using a tiered approach  
**Status:** 🟠 Research In Progress  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-23

---

## 📋 Quick Links

- **[Exploration Document](exploration.md)** - Main exploration with tier definitions
- **[Tier 1: Core Registry](tier-1-core-registry.md)** - Detailed Tier 1 field definitions
- **[Research Topics](research-topics.md)** - Questions needing research (3/6 complete)
- **[Research Hub](../../research/project-model-definition/README.md)** - Research documents

---

## 🎯 Overview

This exploration defines what a "project" is across the four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod) using a tiered approach:

| Tier | Scope | Timeline | Status |
|------|-------|----------|--------|
| **Tier 1** | Core Registry (MVP) | Immediate | ✅ Research Complete |
| **Tier 2** | Classification & Organization | Near-term | ✅ Research Complete |
| **Tier 3** | Learning Sub-Classification | Near-term | 🔴 Not Started |
| **Tier 4** | Skills Matrix Integration | Medium-term | 🔴 Not Started |
| **Tier 5** | Analysis & Metrics | Longer-term | 🔴 Not Started |

**Key Insights:**

- 7 fields are already implemented in work-prod and ready for Tier 1
- API contract is complete - proj-cli can integrate immediately
- Classification needs two-field solution (`classification` + `project_type`)
- Organization string field is sufficient (FK deferred until metadata needed)

---

## 🔗 Related Work

- **[Four-Arm Architecture](../four-arm-architecture/README.md)** - Ecosystem context
- **[Work-Prod Analysis Service](../work-prod-analysis-service/README.md)** - Analysis needs
- **[proj-cli Focused Role](../proj-cli-focused-role/README.md)** - CLI scope
- **[work-prod Projects Data Model](../../../../work-prod/docs/maintainers/research/data-models/projects-data-model.md)** - Comprehensive research (1100+ lines)

---

## 📊 Status

**Current Phase:** Research (3/6 topics complete)  
**Next Step:** Continue with Learning Taxonomy research (Topic 4)

---

**Last Updated:** 2025-12-23
