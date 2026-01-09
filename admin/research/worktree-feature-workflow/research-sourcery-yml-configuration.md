# Research: sourcery.yml Configuration

**Research Topic:** Worktree Feature Workflow  
**Question:** How should sourcery.yml be configured to support this workflow?  
**Status:** 🔴 Research  
**Priority:** 🟡 Medium  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

How should sourcery.yml be configured to support this workflow?

**Sub-questions:**
- What paths should be ignored? (`admin/**`, `docs/maintainers/**`, others?)
- Does ignoring docs affect Sourcery's code analysis?
- Should this be in templates or dev-infra only?
- Does a sourcery.yml already exist?

---

## 🔍 Research Goals

- [ ] Goal 1: Determine optimal ignore patterns for documentation
- [ ] Goal 2: Verify impact on code analysis quality
- [ ] Goal 3: Decide template inclusion strategy
- [ ] Goal 4: Check existing configuration

---

## 💡 Pre-Research Insights

**Problem:**
> Sourcery reviews docs in PRs, creating noise when docs are committed with code.

**Proposed solution:**
```yaml
# .sourcery.yaml
ignore:
  - admin/**
  - docs/maintainers/**
```

**Expected benefit:**
> Docs can be committed to feature branch without PR review noise.
> Clean code reviews focused on implementation.

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources:**
- [ ] Sourcery documentation (official)
- [ ] Check existing `.sourcery.yaml` in repo
- [ ] Community patterns for mixed repos
- [ ] Web search: sourcery yaml configuration ignore

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

## 🚀 Next Steps

1. Conduct research using web search
2. Fill in findings
3. Update summary and requirements

---

**Last Updated:** 2026-01-09
