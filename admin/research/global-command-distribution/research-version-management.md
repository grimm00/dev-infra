# Research: Version Management

**Research Topic:** Global Command Distribution  
**Question:** How should global commands be versioned and tracked?  
**Status:** 🔴 Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 Research Question

How should dev-infra version global commands? How do users know which version they have installed? How to handle version compatibility?

---

## 🔍 Research Goals

- [ ] Goal 1: Design version tracking mechanism
- [ ] Goal 2: Determine version check approach
- [ ] Goal 3: Plan compatibility between command versions and dev-infra versions
- [ ] Goal 4: Handle version display in commands

---

## 📚 Research Methodology

**Sources:**
- [ ] Web search: How package managers track versions
- [ ] Review semantic versioning best practices
- [ ] Analyze how VS Code extensions handle versioning
- [ ] Consider `.version` file approach

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

**Proposed Version Tracking:**
```
~/.cursor/commands/
├── .version              # Contains dev-infra version
├── task-phase.md
├── pr.md
└── ...
```

**Open Questions:**
- Should version be in a separate file or embedded in commands?
- How to show "update available" notifications?
- Should commands include their own version header?

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


