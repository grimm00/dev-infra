# Research: Work-prod Project Model

> **⚠️ SUPERSEDED**
>
> This research was based on **assumptions** about work-prod's API. It has been superseded by the [Project Model Definition Research](../project-model-definition/README.md), which audited the **actual work-prod implementation**.
>
> **For authoritative information, see:**
> - [Tier 1 API Contract](../project-model-definition/research-tier-1-api-contract.md) - Complete API documentation (691-line OpenAPI spec)
> - [Classification Enum](../project-model-definition/research-classification-enum.md) - Two-field solution for project types
>
> This document is retained for historical reference only.

---

**Research Topic:** Work-prod Integration  
**Question:** What fields does work-prod use for projects? How do we map dev-infra projects?  
**Status:** ⚠️ Superseded  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-23  
**Superseded By:** [project-model-definition/research-tier-1-api-contract.md](../project-model-definition/research-tier-1-api-contract.md)

---

## 🎯 Research Question

What fields does work-prod use for projects? How do we map dev-infra projects?

---

## 🔍 Research Goals

- [x] Goal 1: Document work-prod's project data model/schema (assumed)
- [x] Goal 2: Identify required vs optional fields
- [x] Goal 3: Design mapping from dev-infra metadata to work-prod fields
- [x] Goal 4: Determine if custom metadata can be stored (template type, version)

---

## 📚 Research Methodology

**Approach:** Design project model based on work-prod needs and dev-infra metadata.

**Sources:**

- [x] Dev-infra metadata fields (from template-metadata research)
- [x] Common project registry patterns
- [x] Internal analysis of what work-prod likely needs

---

## 📊 Findings

### Finding 1: Assumed Work-prod Project Model

Based on typical project registries, work-prod likely has these fields:

```
Project {
  id: string          // Unique identifier
  name: string        // Project name
  description: string // Project description
  path: string        // Local filesystem path
  repository: string  // Git repository URL (optional)
  status: string      // Active, Archived, etc.
  created_at: date
  updated_at: date
  metadata: object    // Custom fields (flexible)
}
```

**Source:** Industry patterns for project registries

**Relevance:** Need to confirm with actual work-prod API.

---

### Finding 2: Dev-infra Metadata to Map

From template-metadata research, dev-infra tracks:

```yaml
# .dev-infra.yml
template: standard-project
version: 0.7.0
created: 2025-12-19
```

**Source:** [Template Metadata Research](../template-metadata/README.md)

**Relevance:** These fields need to map to work-prod project model.

---

### Finding 3: Proposed Field Mapping

| Dev-infra Field | Work-prod Field | Notes |
|-----------------|-----------------|-------|
| Project name | `name` | From directory name or prompt |
| Project path | `path` | Absolute path to project |
| `template` | `metadata.template` | Custom metadata |
| `version` | `metadata.dev_infra_version` | Custom metadata |
| `created` | `created_at` | Generation date |
| Git remote | `repository` | If git initialized |

**Source:** Internal analysis

**Relevance:** Defines the integration contract.

---

### Finding 4: Custom Metadata Support is Key

For the mapping to work, work-prod must support:

1. A `metadata` or `custom_fields` object for arbitrary data
2. Ability to filter/query by metadata fields

Without this, dev-infra can't distinguish its projects from others.

**Alternative:** Use a naming convention or tag (e.g., `tags: ["dev-infra"]`)

**Source:** Internal analysis

**Relevance:** Critical for the integration design.

---

## 🔍 Analysis

**Key Insights:**

- [x] Insight 1: Work-prod needs flexible metadata field for dev-infra data
- [x] Insight 2: Mapping is straightforward if metadata support exists
- [x] Insight 3: Tags/naming convention is fallback if no metadata support
- [x] Insight 4: Git remote URL is valuable for identifying projects

---

## 💡 Recommendations

- [x] Recommendation 1: Confirm work-prod has metadata/custom_fields support
- [x] Recommendation 2: Store template type and version in metadata
- [x] Recommendation 3: Use git remote as secondary identifier
- [x] Recommendation 4: Add "dev-infra" tag for easy filtering

---

## 📋 Requirements Discovered

- [x] FR-4: Map dev-infra projects to work-prod project model
- [x] FR-5: Store template type in work-prod metadata
- [x] FR-6: Store dev-infra version in work-prod metadata
- [x] FR-7: Tag projects with "dev-infra" for filtering
- [x] NFR-2: Mapping should be lossless (no data lost in translation)

---

## 🚀 Next Steps

1. ~~Confirm work-prod project model with actual API~~ → See [project-model-definition research](../project-model-definition/README.md)
2. ~~Verify metadata/custom_fields support~~ → Superseded
3. ~~Implement registration logic~~ → Superseded

---

**Last Updated:** 2025-12-23
