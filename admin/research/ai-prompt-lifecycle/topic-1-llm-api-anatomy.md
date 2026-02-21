# Research: LLM API Anatomy and Context Windows

**Research Topic:** AI Prompt Lifecycle  
**Question:** What is the complete structure of an LLM API call, and how do context windows, token limits, and message roles work?  
**Status:** 🔴 Research  
**Created:** 2026-02-20  
**Last Updated:** 2026-02-20

---

## 🎯 Research Question

What is the mechanical reality of how LLM API calls work? Not the marketing abstractions ("just chat with AI") but the actual HTTP request structure, token economics, and context window behavior that determine how our command files get consumed.

---

## 🔍 Research Goals

- [ ] Goal 1: Document the complete anatomy of an Anthropic Messages API call (request structure, message roles, parameters)
- [ ] Goal 2: Understand tokens -- what they are, how text maps to tokens, and how to measure token counts
- [ ] Goal 3: Understand context windows -- hard limits, how input and output share the budget, what happens at the boundary
- [ ] Goal 4: Understand the role of system prompts vs. user/assistant messages -- are they treated differently by the model?
- [ ] Goal 5: Measure token counts for dev-infra's actual content (rules files, command files, typical conversation)

---

## 📚 Research Methodology

**Sources:**
- [ ] Anthropic Messages API documentation
- [ ] Anthropic tokenization documentation
- [ ] OpenAI Chat Completions API (for comparison)
- [ ] Anthropic prompt caching documentation (informed by usage CSV data)
- [ ] Web search: token counting tools and practices
- [ ] Empirical measurement: tokenize our actual rules and command files

---

## 📊 Findings

*To be filled during conduct mode.*

---

## 🔍 Analysis

*To be filled during conduct mode.*

---

## 💡 Recommendations

*To be filled during conduct mode.*

---

## 📋 Requirements Discovered

*To be filled during conduct mode.*

---

## 🚀 Next Steps

1. Conduct this research topic
2. Proceed to Topic 2 (Cursor Prompt Assembly)

---

**Last Updated:** 2026-02-20
