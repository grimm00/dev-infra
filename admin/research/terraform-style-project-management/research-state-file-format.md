# Research: State File Format

**Research Topic:** Terraform-Style Project Management  
**Question:** What should `.dev-infra.yml` contain and how should it be structured?  
**Status:** 🔴 Research  
**Priority:** High  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

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

- [ ] Goal 1: Define additional fields needed beyond template-metadata (sync history, customizations)
- [ ] Goal 2: Research how Terraform's tfstate tracks resources and changes
- [ ] Goal 3: Determine minimum viable state for plan/apply workflow
- [ ] Goal 4: Design schema for tracking intentional customizations

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources:**
- [ ] Template Metadata research findings
- [ ] Terraform tfstate documentation and structure
- [ ] Web search: State file patterns in infrastructure-as-code tools
- [ ] Web search: YAML schema design best practices

---

## 🔍 Sub-questions

From exploration:
- What's the minimum viable state information?
- How to track sync history?
- How to record intentional customizations?
- Should it be `.dev-infra.yml`, `.dev-infra.json`, or something else?
- How does this relate to existing Template Metadata research?

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

- [ ] Requirement 1: [Description]
- [ ] Requirement 2: [Description]

---

## 🚀 Next Steps

1. Review template-metadata research findings
2. Research Terraform tfstate structure
3. Design extended schema for sync/customization tracking

---

**Last Updated:** 2025-12-22

