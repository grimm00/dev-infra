# Research: Managed Project Lifecycle

**Research Topic:** Four-Arm Architecture  
**Question:** What does "managed by dev-infra" mean for different project types?  
**Priority:** 🟡 Medium  
**Status:** 🔴 Not Started  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## 🎯 Research Question

What does "managed by dev-infra" mean for different project types?

**Context:** Not all projects need the same level of sync. Tooling projects (dev-toolkit) may differ from application projects (work-prod). The four arms have different relationships with dev-infra:

| Project | Type | Relationship to dev-infra |
|---------|------|--------------------------|
| work-prod | Application | Generated from template, receives updates |
| proj-cli | Tooling | Generated from template, manages other projects |
| dev-toolkit | Tooling | Independent, installs from dev-infra |
| dev-infra | Infrastructure | Source of truth, not managed |

---

## 🔍 Research Goals

- [ ] Goal 1: Define "managed project" categories and their characteristics
- [ ] Goal 2: Determine which files should sync for each project type
- [ ] Goal 3: Design opt-out mechanism for projects that don't want auto-updates
- [ ] Goal 4: Clarify management model for each of the four arms

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources to investigate:**
- [ ] Review Terraform-style research: `admin/research/terraform-style-project-management/`
- [ ] Review template sync validation: `scripts/validate-template-sync.sh`
- [ ] Web search: Infrastructure-as-Code managed resource patterns
- [ ] Web search: Package manager update strategies
- [ ] Case studies: Renovate, Dependabot, Terraform workspaces

**Sub-questions to address:**
1. Should dev-toolkit be a "managed" project?
2. What files should sync for tooling vs application projects?
3. How to handle projects that don't want auto-updates?
4. Can a project opt out of being managed?

---

## 📊 Project Categories

### Category 1: Application Projects

**Examples:** work-prod

**Characteristics:**
- Generated from standard-project template
- Full documentation structure sync
- Cursor command updates
- May have customizations

**Sync Scope:**
- [ ] `.cursor/commands/` - All workflow commands
- [ ] `docs/maintainers/` structure - Planning documentation
- [ ] `.gitignore` patterns - Standard ignores
- [ ] CI/CD workflows - GitHub Actions

---

### Category 2: Tooling Projects

**Examples:** proj-cli, dev-toolkit

**Characteristics:**
- May or may not use standard template
- Focused on specific tooling purpose
- May have unique structure requirements
- Less documentation sync needed

**Sync Scope:**
- [ ] `.cursor/commands/` - Selected commands only?
- [ ] Project-specific structure - Varies by project

---

### Category 3: Infrastructure (Not Managed)

**Examples:** dev-infra

**Characteristics:**
- Source of truth for templates
- Not managed by itself
- Generates other projects

**Sync Scope:**
- N/A (not managed)

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

- **[Terraform-Style Research](../terraform-style-project-management/README.md)** - State tracking patterns
- **[Shared Contracts](research-shared-contracts.md)** - What contracts sync across projects
- **[Version Coordination](research-version-coordination.md)** - Related to update timing

---

## 🚀 Next Steps

1. Review Terraform-style research for patterns
2. Analyze current template sync approach
3. Document findings and make recommendations

---

**Last Updated:** 2025-12-31

