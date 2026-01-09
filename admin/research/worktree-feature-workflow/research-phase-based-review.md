# Research: Phase-Based Review in Self-Contained Workflow

**Research Topic:** Worktree Feature Workflow  
**Question:** How do we maintain early bug detection (via Sourcery reviews) in a self-contained feature branch workflow?  
**Status:** 🔴 Research  
**Priority:** 🔴 High  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

How do we maintain early bug detection (via Sourcery reviews) in a self-contained feature branch workflow?

**Sub-questions:**
- Should we still create phase-based PRs? If so, to what?
- Can Sourcery CLI be used locally for early feedback?
- Do draft PRs provide a middle ground?
- How do we balance isolation with early feedback?
- What's the review workflow during feature development?

---

## 🔍 Research Goals

- [ ] Goal 1: Understand current phase-based review workflow value
- [ ] Goal 2: Identify options for early feedback in self-contained branches
- [ ] Goal 3: Evaluate trade-offs of each approach
- [ ] Goal 4: Recommend a workflow that preserves early bug detection

---

## 💡 Pre-Research Context

**Current Workflow (Phase-Based PRs via transition-plan):**
```
develop → feat/feature
  └── Phase 1 → PR → Sourcery Review → Fix → Merge to develop
  └── Phase 2 → PR → Sourcery Review → Fix → Merge to develop
  └── etc.
```

**Benefits of current workflow:**
- Early bug detection at each phase
- Incremental review (smaller PRs)
- Issues caught before they compound

**Tension with self-contained branches:**
- If all docs are on feature branch, merging to develop defeats isolation
- But waiting until the end loses early feedback value

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research.

**Sources:**
- [ ] Current dev-infra workflow documentation
- [ ] Sourcery CLI documentation
- [ ] GitHub draft PR patterns
- [ ] Web search: feature branch review strategies

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
