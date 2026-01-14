# Research: Cursor CLI Programmatic Invocation & Model Selection

**Research Topic:** Template Doc Infrastructure  
**Question:** How should scripts invoke Cursor programmatically with model selection based on task type?  
**Status:** 🔴 Research  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13

---

## 🎯 Research Question

How can workflow orchestration scripts invoke Cursor (or other AI tools) programmatically, passing context and selecting optimal models based on task type? This enables the full hybrid architecture where scripts handle structure/context and AI handles creative content.

---

## 🔍 Research Goals

- [ ] Goal 1: Investigate Cursor CLI capabilities for agent invocation
- [ ] Goal 2: Determine how to pass context (files, manifests) to AI via CLI
- [ ] Goal 3: Determine how to select models via CLI flags or configuration
- [ ] Goal 4: Prototype script → Cursor → output flow
- [ ] Goal 5: Design model selection configuration for task types

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research. Use web search tools to find current information, best practices, documentation, examples, and real-world implementations.

**Sources:**
- [ ] Cursor documentation (CLI capabilities)
- [ ] Web search: "Cursor IDE CLI agent invocation"
- [ ] Web search: "Cursor API programmatic model selection"
- [ ] Alternative tools: Aider, Continue, other AI coding tools
- [ ] Shell scripting patterns for AI tool integration

---

## 🎯 Model Selection Context

**From Discussion - Task Type → Model Mapping:**

| Task Type | Model | Reasoning |
|-----------|-------|-----------|
| explore, research, decision | claude-opus-4 | Deep thinking, analysis |
| naming, creative | gemini-2.5-pro | Divergent creativity |
| pr, post-pr, release-prep | claude-sonnet-4 | Structured, routine |
| task-phase, implement | composer-1 | Code implementation |

**Desired Flow:**

```
scripts/workflow.sh explore my-topic --conduct
    → Script determines task type: "explore"
    → Script selects model: claude-opus-4
    → Script gathers context (git state, related files, etc.)
    → Script generates structure (templates)
    → Script invokes Cursor with:
        - Model selection
        - Context manifest
        - Targeted prompt
    → AI fills in creative content
    → Script validates output
```

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

1. Investigate Cursor CLI capabilities
2. Prototype simple script → AI → output flow
3. Document findings for decision phase

---

**Last Updated:** 2026-01-13
