# Research: Drift Detection

**Research Topic:** Terraform-Style Project Management  
**Question:** How to detect when projects have diverged from their template?  
**Status:** 🔴 Research  
**Priority:** Medium  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 Research Question

How to detect when projects have diverged from their template? What drift detection mechanism identifies projects needing attention?

---

## 🔍 Research Goals

- [ ] Goal 1: Research Terraform drift detection patterns
- [ ] Goal 2: Evaluate file comparison strategies (hash, git, content-diff)
- [ ] Goal 3: Define what constitutes "intentional" vs "unintentional" drift
- [ ] Goal 4: Design reporting mechanism for drift

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources:**
- [ ] Terraform refresh and drift detection
- [ ] Web search: Configuration drift detection tools
- [ ] Web search: File synchronization algorithms
- [ ] Git-based change tracking patterns

---

## 🔍 Sub-questions

From exploration:
- File-level or content-level comparison?
- How to distinguish intentional changes from drift?
- Should drift be reported or just logged?
- How to handle files that should never sync?
- Performance considerations for large projects?

**Options to explore:**
1. **Hash-based:** Compare file hashes to template
2. **Git-based:** Track changes since last sync commit
3. **Content-diff:** Semantic comparison of file contents
4. **Manifest-based:** Only check files listed in sync manifest

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

1. Research Terraform drift detection
2. Evaluate comparison algorithms
3. Design drift reporting format

---

**Last Updated:** 2025-12-22

