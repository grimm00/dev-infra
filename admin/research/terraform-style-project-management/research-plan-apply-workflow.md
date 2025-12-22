# Research: Plan/Apply Workflow

**Research Topic:** Terraform-Style Project Management  
**Question:** How should the plan/apply workflow work in practice?  
**Status:** 🔴 Research  
**Priority:** High  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 Research Question

How should the plan/apply workflow work in practice? What user experience provides safe, predictable, and informative sync operations?

---

## 🔍 Research Goals

- [ ] Goal 1: Research Terraform's plan/apply UX patterns
- [ ] Goal 2: Design diff generation between template and project
- [ ] Goal 3: Determine partial apply strategy (selective file updates)
- [ ] Goal 4: Define commit strategy (auto-commit vs manual)

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources:**
- [ ] Terraform CLI documentation (plan, apply commands)
- [ ] Web search: Infrastructure-as-code diff visualization
- [ ] Web search: Safe deployment patterns with preview
- [ ] Git diff and merge strategies

---

## 🔍 Sub-questions

From exploration:
- How to generate diffs between template and project?
- How to display changes in a readable way?
- How to handle partial applies (some files, not all)?
- Should `apply` create a commit automatically?
- How to handle merge conflicts?

**Terraform patterns to consider:**
- `terraform plan -out=plan.tfplan` (save plan for later apply)
- `terraform apply -target=resource` (selective apply)
- `terraform plan -refresh=false` (skip state refresh)

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

1. Research Terraform plan/apply workflow
2. Design diff generation strategy
3. Define proj-cli command interface

---

**Last Updated:** 2025-12-22

