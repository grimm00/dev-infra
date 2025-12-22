# Research: State File Format

**Research Topic:** Terraform-Style Project Management  
**Question:** What should `.dev-infra.yml` contain and how should it be structured?  
**Status:** ✅ Complete  
**Priority:** High  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22  
**Completed:** 2025-12-22

---

## 🎯 Research Question

What should `.dev-infra.yml` contain and how should it be structured to enable state tracking, sync operations, and customization recording?

---

## 🔗 Related Research

**IMPORTANT:** This topic builds on completed research:

- **[Template Metadata Research](../template-metadata/README.md)** - Already researched:
  - File format decision: YAML (`.dev-infra.yml`)
  - Essential fields: `template`, `version`, `created`
  - Location: Project root (dotfile)
  - Migration strategy: Manual for v1, init command for v2

This research extends template-metadata to address Terraform-specific needs.

---

## 🔍 Research Goals

- [x] Goal 1: Define additional fields needed beyond template-metadata (sync history, customizations)
- [x] Goal 2: Research how Terraform's tfstate tracks resources and changes
- [x] Goal 3: Determine minimum viable state for plan/apply workflow
- [x] Goal 4: Design schema for tracking intentional customizations

---

## 📚 Research Methodology

**Sources:**
- [x] Template Metadata research findings
- [x] Terraform tfstate documentation and structure
- [x] Web search: State file patterns in infrastructure-as-code tools
- [x] Web search: YAML schema design best practices

---

## 📊 Findings

### Finding 1: Terraform State Tracks Resource Metadata + Checksums

Terraform's tfstate is JSON-based and tracks:
- Resource identifiers (type, name, provider)
- Current attribute values
- Dependencies between resources
- Checksums/lineage for state integrity
- Version information for state file format

**Source:** Terraform documentation, IaC best practices research

**Relevance:** We can adapt this for project file tracking - recording which files were synced, their checksums, and when.

---

### Finding 2: Remote State Enables Collaboration

Terraform uses remote backends (S3, Terraform Cloud) for:
- Team collaboration on shared state
- State locking to prevent conflicts
- State versioning for rollback

**Source:** Web search - "state management" in IaC patterns

**Relevance:** For dev-infra, the `.dev-infra.yml` is checked into git, providing similar versioning/collaboration benefits. No need for remote state initially.

---

### Finding 3: Sync Rules Should Follow Ignore Pattern

Template sync tools (like cruft for cookiecutter) use:
- `always` - Always sync these files
- `ask` - Prompt user before syncing
- `never` - Never sync (project customizes these)

This mirrors `.gitignore` patterns users already understand.

**Source:** Template sync tool patterns, IaC reconciliation research

**Relevance:** Our `sync` configuration should use familiar patterns.

---

### Finding 4: Customization Tracking Enables Smart Merging

Recording intentional customizations:
- Which files were modified intentionally
- When and why (optional reason)
- Allows plan/apply to skip or warn on these files

**Source:** Drift detection patterns in IaC

**Relevance:** Essential for conflict resolution during updates.

---

## 🔍 Analysis

Combining template-metadata foundations with Terraform patterns, the state file needs:

**Core Fields (from template-metadata):**
- `template` - Which template type
- `version` - Dev-infra version at creation
- `created` - Creation timestamp

**Extended Fields (new for plan/apply):**
- `last_sync` - When last synced with template
- `sync` - Sync configuration rules
- `customizations` - Tracked intentional changes

**Key Insights:**
- [x] Insight 1: YAML remains the right format (human-readable, supports comments, aligns with template-metadata decision)
- [x] Insight 2: Sync rules should use `always/ask/never` pattern (familiar to users)
- [x] Insight 3: Customizations should record file, date, and optional reason
- [x] Insight 4: State file should stay simple - avoid tracking file checksums (use git for that)

---

## 💡 Recommendations

- [x] Recommendation 1: Extend `.dev-infra.yml` schema to include `last_sync`, `sync`, and `customizations` fields
- [x] Recommendation 2: Keep state file human-readable and editable (not machine-only like tfstate)
- [x] Recommendation 3: Use git history for file-level change tracking rather than embedding checksums

**Recommended Schema (V2):**

```yaml
# .dev-infra.yml - Extended for plan/apply
managed_by: dev-infra
template: standard-project
version: 0.8.0
created: 2025-12-22
last_sync: 2025-12-22

sync:
  always:
    - .cursor/commands/
    - .gitignore
  ask:
    - docs/maintainers/planning/
    - .github/workflows/
  never:
    - README.md
    - backend/
    - frontend/

customizations:
  - file: .cursor/rules/main.mdc
    reason: "Added project-specific rules"
    date: 2025-12-22
```

---

## 📋 Requirements Discovered

- [x] FR-1: State file must include `last_sync` timestamp
- [x] FR-2: State file must support sync rules (always/ask/never)
- [x] FR-3: State file must track intentional customizations
- [x] FR-4: State file must remain human-readable and editable
- [x] NFR-1: State file format must be backward-compatible with template-metadata v1

---

## 🚀 Next Steps

1. ✅ Research complete
2. Proceed to Plan/Apply Workflow research
3. Final schema will be defined in ADR

---

**Last Updated:** 2025-12-22
