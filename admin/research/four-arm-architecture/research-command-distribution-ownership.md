# Research: Command Distribution Ownership

**Research Topic:** Four-Arm Architecture  
**Question:** Where should global Cursor command installation live - dev-infra or dev-toolkit?  
**Priority:** 🔴 High  
**Status:** 🔴 Not Started  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## 🎯 Research Question

Where should global Cursor command installation live - dev-infra or dev-toolkit?

**Context:** The "Global Command Distribution" research assumed dev-infra would handle installation. With dev-toolkit's existing install infrastructure (`install.sh`, `dt-*` command pattern), this needs reconsideration.

---

## 🔍 Research Goals

- [ ] Goal 1: Evaluate dev-toolkit's existing installation infrastructure for command distribution
- [ ] Goal 2: Determine the optimal ownership model for command source vs. distribution
- [ ] Goal 3: Design versioning relationship between dev-toolkit and dev-infra commands
- [ ] Goal 4: Decide whether to create a `dt-cursor-install` command

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research to find current patterns, best practices, and real-world implementations.

**Sources to investigate:**
- [ ] Review dev-toolkit's current `install.sh` implementation
- [ ] Review dev-infra's current command source structure
- [ ] Web search: CLI tool distribution patterns (homebrew, npm, pip)
- [ ] Web search: Plugin/command distribution models in developer tools
- [ ] Case studies: VS Code extensions, Oh My Zsh plugins, dotfiles managers

**Sub-questions to address:**
1. Does dev-toolkit's `install.sh` pattern fit command installation?
2. Should dev-toolkit pull commands from dev-infra releases?
3. How to handle versioning between the two?
4. Should there be a `dt-cursor-install` command?

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

## 🔗 Related Research

- **[Global Command Distribution](../global-command-distribution/README.md)** - Prior research on command distribution
- **[Integration Points](research-integration-points.md)** - How projects communicate

---

## 🚀 Next Steps

1. Conduct web research on distribution patterns
2. Review dev-toolkit's installation infrastructure
3. Document findings and make recommendations

---

**Last Updated:** 2025-12-31

