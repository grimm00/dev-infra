# Research: Essential Fields

**Research Topic:** Template Metadata System  
**Question:** What information is essential vs nice-to-have in project metadata?  
**Status:** ✅ Complete  
**Created:** 2025-12-18  
**Last Updated:** 2025-12-18

---

## 🎯 Research Question

What fields/information should the metadata file contain? What's essential for sync to work vs nice-to-have for enhanced features?

---

## 🔍 Research Goals

- [x] Goal 1: Identify minimum fields needed for sync functionality
- [x] Goal 2: Identify fields that would enable enhanced features
- [x] Goal 3: Review what similar tools include in their metadata
- [x] Goal 4: Categorize fields by priority (essential, recommended, optional)

---

## 📚 Research Methodology

**Approach:** Analyze sync requirements and research similar tools.

**Sources:**
- [x] Web search: Project scaffolding metadata patterns
- [x] Case studies: Yeoman, Dublin Core metadata standards
- [x] Internal analysis: What we need for each scenario

---

## 📊 Findings

### Finding 1: Dublin Core Defines Universal Metadata Fields

The Dublin Core Metadata Element Set defines 15 elements for resource description, widely adopted across industries. Relevant fields for dev-infra include: Title, Creator, Date, Format, Identifier, and Version.

**Source:** Dublin Core Metadata Initiative, egovstandards.gov.in

**Relevance:** Provides industry-standard vocabulary for essential metadata fields.

---

### Finding 2: Version and Template Type are Minimum for Sync

For sync to work at its most basic, we need:
1. **Template type** - To know which template's files to compare against
2. **Version** - To know what version was used (for compatibility checks)

Without these two fields, sync cannot determine what files should exist or what updates are available.

**Source:** Internal analysis of sync requirements

**Relevance:** These are the absolute minimum fields for sync functionality.

---

### Finding 3: Timestamps Enable Update Tracking

Fields like `created` and `last_sync` enable:
- Knowing how old a project is
- Knowing when it was last synced
- Calculating time since last update

These aren't strictly required but significantly improve sync UX.

**Source:** Industry best practices for metadata

**Relevance:** Enhances user experience and enables better sync decisions.

---

### Finding 4: Sync Rules Need Project-Specific Configuration

Different projects may have different sync needs:
- Some files should always sync (commands, gitignore updates)
- Some files should prompt before syncing (structure changes)
- Some files should never sync (project-specific code, customized configs)

This suggests a `sync` section with configurable rules.

**Source:** Analysis of sync system requirements

**Relevance:** Enables customization preservation during sync.

---

### Finding 5: Customization Tracking Prevents Accidental Overwrites

Recording intentional customizations (deleted files, modified configs) prevents sync from restoring things the user intentionally changed.

**Source:** Analysis of customization preservation problem

**Relevance:** Critical for user trust in sync system.

---

## 🔍 Analysis

**Field Categorization:**

| Category | Field | Purpose | Required for Sync? |
|----------|-------|---------|-------------------|
| Essential | `template` | Which template was used | ✅ Yes |
| Essential | `version` | Dev-infra version at generation | ✅ Yes |
| Recommended | `created` | When project was generated | No, but helpful |
| Recommended | `last_sync` | When project was last synced | No, but helpful |
| Optional | `sync.always` | Files that always sync | No, has defaults |
| Optional | `sync.ask` | Files that prompt before sync | No, has defaults |
| Optional | `sync.never` | Files that never sync | No, has defaults |
| Optional | `customizations` | User's intentional changes | No, can be detected |
| Optional | `project_name` | Project display name | No, informational |

**Key Insights:**
- [x] Insight 1: Only 2 fields (template, version) are truly essential for basic sync
- [x] Insight 2: Timestamps and sync rules significantly improve UX
- [x] Insight 3: Start minimal, add fields as features require them
- [x] Insight 4: Customization tracking can be automatic rather than manual

---

## 💡 Recommendations

- [x] **Recommendation 1:** Start with minimal essential fields only

  ```yaml
  # .dev-infra.yml - Minimum viable
  template: standard-project
  version: 0.7.0
  created: 2025-12-18
  ```

- [x] **Recommendation 2:** Add sync configuration when sync feature is built

  ```yaml
  # .dev-infra.yml - With sync config (v2)
  template: standard-project
  version: 0.7.0
  created: 2025-12-18
  last_sync: 2025-12-18
  
  sync:
    always:
      - .cursor/commands/
      - .gitignore
    ask:
      - docs/maintainers/planning/
    never:
      - README.md
      - backend/
      - frontend/
  ```

- [x] **Recommendation 3:** Defer customization tracking until needed
  - Can be computed by diffing against template
  - Only add explicit tracking if computed approach proves inadequate

---

## 📋 Requirements Discovered

- [x] FR-3: Metadata must include template type (standard-project, learning-project)
- [x] FR-4: Metadata must include dev-infra version used for generation
- [x] FR-5: Metadata should include creation timestamp
- [x] FR-6: Metadata should support sync rule configuration (future)
- [x] NFR-3: Metadata schema must be extensible for future fields
- [x] NFR-4: Essential fields should fit in under 5 lines for simplicity

---

## 🚀 Next Steps

1. Define v1 schema with essential fields only
2. Plan v2 schema with sync configuration when sync feature is implemented

---

**Last Updated:** 2025-12-18
