# Research: Project vs Global Scope

**Research Topic:** Global Command Distribution  
**Question:** When should commands be installed globally vs at project level?  
**Status:** 🔴 Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 Research Question

When should users install commands globally (`~/.cursor/commands/`) vs at project level (`.cursor/commands/`)? How do workspace contexts affect this decision?

**User Insight (2025-12-22):**
> "It may be helpful to include a flag for projects if we're in a workspace context or we want to be extra careful. Most likely, someone in the project directory would trust that the IDE knows where to apply it to."

---

## 🔍 Research Goals

- [ ] Goal 1: Define use cases for global vs project installation
- [ ] Goal 2: Understand workspace context implications
- [ ] Goal 3: Determine default behavior (global or project)
- [ ] Goal 4: Design flag interface (`--global` vs `--project`)

---

## 📚 Research Methodology

**Sources:**
- [ ] Web search: How other tools handle global vs local scope
- [ ] Workspace behavior research (multi-project contexts)
- [ ] User trust model analysis
- [ ] Command override behavior documentation

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

**Validated Behavior:**
- Global commands at `~/.cursor/commands/` work as fallback
- Project commands at `.cursor/commands/` override global
- Agent is unaware of global when project version exists

**Open Questions:**
- Should `--global` be the default?
- Should workspace users prefer project-level for isolation?
- How to communicate the override behavior to users?

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

1. [Next action]
2. [Next action]

---

**Last Updated:** 2025-12-22


