# Research: Registry Architecture

**Research Topic:** Terraform-Style Project Management  
**Question:** How should dev-infra track which projects it manages?  
**Status:** 🔴 Research  
**Priority:** High  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 Research Question

How should dev-infra track which projects it manages? What registry architecture enables push updates and portfolio views?

---

## 🔍 Research Goals

- [ ] Goal 1: Evaluate local vs GitHub-based vs hybrid registry approaches
- [ ] Goal 2: Research multi-machine synchronization patterns
- [ ] Goal 3: Determine integration strategy with work-prod API
- [ ] Goal 4: Design metadata schema for registry entries

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources:**
- [ ] Terraform Cloud/Enterprise registry patterns
- [ ] Web search: Project portfolio management tools
- [ ] Web search: GitHub API for repository discovery
- [ ] Work-prod integration research findings

---

## 🔍 Sub-questions

From exploration:
- Local registry (`~/.dev-infra/registry.json`) vs GitHub-based discovery?
- How to handle projects across multiple machines?
- Should the registry sync with work-prod API?
- How to handle private vs public repos?
- What metadata to store in the registry?

**Options to explore:**
1. **Local-only:** Fast, simple, but not portable
2. **GitHub-based:** Discoverable, but requires API access
3. **Hybrid:** Local cache + GitHub sync
4. **work-prod integration:** Central API for all project tracking

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

1. Research Terraform Cloud registry patterns
2. Evaluate GitHub API capabilities for discovery
3. Design registry schema

---

**Last Updated:** 2025-12-22

