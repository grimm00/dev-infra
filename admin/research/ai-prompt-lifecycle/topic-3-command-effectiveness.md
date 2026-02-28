# Research: Command File Effectiveness at Scale

**Research Topic:** AI Prompt Lifecycle  
**Question:** Are long command files (500-1000+ lines) fully consumed by the model, or is there diminishing returns or truncation at certain sizes?  
**Status:** 🔴 Research  
**Created:** 2026-02-20  
**Last Updated:** 2026-02-20

---

## 🎯 Research Question

Dev-infra's command files range from ~100 lines to 1,350+ lines. Does the model's attention degrade across long documents? Is there a "sweet spot" for command length? Would restructuring commands (front-loading critical sections, moving reference material to separate files) improve outcomes?

---

## 🔍 Research Goals

- [ ] Goal 1: Research the "lost in the middle" phenomenon and its relevance to instruction-following
- [ ] Goal 2: Understand Claude-specific long-context attention patterns
- [ ] Goal 3: Measure token counts for dev-infra's actual command files (range, distribution)
- [ ] Goal 4: Identify best practices for structuring long instructions for LLMs
- [ ] Goal 5: Evaluate the tradeoff between comprehensive commands and attention quality

---

## 📚 Research Methodology

**Sources:**
- [ ] "Lost in the Middle" paper (Liu et al., 2023)
- [ ] Anthropic documentation on long-context performance
- [ ] Web search: LLM instruction-following with long prompts
- [ ] Web search: prompt engineering best practices for long instructions
- [ ] Empirical: token counts for all 28 dev-infra command files
- [ ] Usage CSV data: correlate command invocation with token counts

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

1. Conduct this research topic (after Topics 1-2)
2. Proceed to consolidation

---

**Last Updated:** 2026-02-20
