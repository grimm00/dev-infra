# Topic 6: Dev-Infra Code Boundary - Research Document

**Purpose:** Determine whether dev-infra should maintain executable scripts for generated projects or limit to specs/templates  
**Status:** 🔴 Not Started  
**Created:** 2026-02-14  
**Last Updated:** 2026-02-14

---

## 📋 Quick Links

- **[Workflow Simplification Research Hub](README.md)** - Parent research hub
- **[Research Topics](../../explorations/workflow-simplification/research-topics.md)** - All 6 topics
- **[Exploration Theme 5](../../explorations/workflow-simplification/exploration.md)** - Dev-infra code boundary theme
- **[Topic 3: Transition Plan Output Format](topic-3-transition-plan-output-format.md)** - Source of tentative requirements

---

## 🎯 Research Goal

**Key Question:** Should dev-infra maintain executable scripts (like `scaffold-feature.sh`) for generated projects, or should all executable logic live in dev-toolkit?

**Context:** Topic 3 research produced requirements (FR-22 through FR-24, NFR-8, C-8, C-9) assuming dev-infra would host a `scaffold-feature.sh` script. This assumption is under question because it crosses the template factory boundary (ADR-001). Resolving this unblocks the decision phase.

---

## 🔍 Methodology

**Suggested Approach:**

- [ ] Review the existing dev-infra ↔ dev-toolkit boundary pattern
- [ ] Assess whether the tiered blueprint can be a manifest/spec
- [ ] Evaluate the gap period -- is "AI follows command spec" sufficient?
- [ ] Determine disposition of FR-22-24, NFR-8, C-8, C-9
- [ ] Consider "temporary scripts become permanent" risk
- [ ] Web search: spec-driven scaffolding patterns in developer tools

---

## 📊 Findings

*To be filled during research conduct.*

---

## 🔍 Analysis

*To be filled during research conduct.*

**Key Insights:**
- [ ] Insight 1: *TBD*
- [ ] Insight 2: *TBD*

---

## 💡 Recommendations

*To be filled during research conduct.*

---

## 📋 Requirements Discovered

*To be filled during research conduct.*

---

## 🔗 Related

- **[Topic 3: Transition Plan Output Format](topic-3-transition-plan-output-format.md)** — Source of tentative requirements
- **[ADR-001: Project Identity](../../decisions/dev-infra-identity-and-focus/adr-001-project-identity.md)** — Template factory identity
- **[Requirements](requirements.md)** — FR-22 through FR-24, NFR-8, C-8, C-9 marked tentative

---

**Last Updated:** 2026-02-14  
**Status:** 🔴 Not Started  
**Next:** Conduct research; resolve tentative requirements
