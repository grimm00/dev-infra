# Research: Architectural Placement (Four-Arm Question)

**Research Topic:** Template Doc Infrastructure  
**Question:** Where should this tooling live in the four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod)?  
**Status:** 🔴 Research  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13

---

## 🎯 Research Question

Where should the workflow orchestration tooling (doc generation, validation, context gathering, model selection) live within the four-arm architecture? This is a strategic decision that affects versioning, distribution, and how projects consume the tooling.

---

## 🔍 Research Goals

- [ ] Goal 1: Understand the four-arm architecture and each arm's responsibilities
- [ ] Goal 2: Evaluate which arm best fits workflow orchestration tooling
- [ ] Goal 3: Determine distribution mechanism for projects consuming this tooling
- [ ] Goal 4: Analyze versioning implications for template vs tooling changes

---

## 📚 Research Methodology

**Note:** Web search is **allowed and encouraged** for research. Use web search tools to find current information, best practices, documentation, examples, and real-world implementations.

**Sources:**
- [ ] Four-arm architecture research (`admin/research/four-arm-architecture/`)
- [ ] ADR-001: Project Identity (dev-infra = template factory)
- [ ] Dev-toolkit analysis (where does dt-review live?)
- [ ] Proj-cli analysis (project management tooling)
- [ ] Web search: Monorepo vs multi-repo tooling distribution patterns

---

## 🏗️ Four-Arm Architecture Context

**The Arms:**

| Arm | Identity | Purpose |
|-----|----------|---------|
| **dev-infra** | Template Factory | Project templates, template generation |
| **dev-toolkit** | General Tooling | Developer tools, utilities, scripts |
| **proj-cli** | Project Management | Project-specific CLI tools |
| **work-prod** | Production Tooling | Production-focused utilities |

**Key Principle (ADR-001):** Dev-infra's primary identity is "template factory." Internal tooling stays internal. Templates are products, tooling is infrastructure.

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

1. Complete research on four-arm architecture fit
2. Document recommendation for placement
3. Feed into `/decision` phase for ADR creation

---

**Last Updated:** 2026-01-13
