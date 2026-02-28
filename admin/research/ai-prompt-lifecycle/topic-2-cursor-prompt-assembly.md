# Research: Cursor IDE Prompt Assembly

**Research Topic:** AI Prompt Lifecycle  
**Question:** How does Cursor assemble the full prompt when a user invokes a command, and how are rules, commands, open files, and conversation history prioritized?  
**Status:** 🔴 Research  
**Created:** 2026-02-20  
**Last Updated:** 2026-02-20

---

## 🎯 Research Question

When a user types a message (or invokes a command) in Cursor, what exactly gets assembled into the API request? How are `.cursor/rules/` files, `.cursor/commands/` files, open file context, conversation history, and Cursor's own system instructions combined? What happens when the total exceeds the context window?

---

## 🔍 Research Goals

- [ ] Goal 1: Document the full prompt assembly pipeline (what gets included, in what order)
- [ ] Goal 2: Understand the injection mechanism for rules (.mdc) vs. commands (.md)
- [ ] Goal 3: Understand how Cursor manages the context budget (truncation, summarization, priority)
- [ ] Goal 4: Understand differences between Chat mode, Agent mode, and command invocation
- [ ] Goal 5: Cross-reference first-person observations from the exploration with documented behavior

---

## 📚 Research Methodology

**Sources:**
- [ ] Cursor documentation (docs.cursor.com)
- [ ] Cursor changelog and blog posts
- [ ] Cursor community forums
- [ ] First-person model observations (from exploration)
- [ ] Web search: Cursor prompt assembly, context management
- [ ] Cursor GitHub (open-source components if any)

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

1. Conduct this research topic (after Topic 1)
2. Proceed to Topic 3 (Command Effectiveness)

---

**Last Updated:** 2026-02-20
