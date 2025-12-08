# Research Topics - Templates Enhancement

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions about template enhancements.

### Research Topic 1: Workflow Automation Commands Integration

**Question:** How should workflow automation commands be integrated into templates? What commands should be included, and how should they be organized?

**Why:** 14 commands have been adapted for dev-infra, and 3 new commands (`/explore`, `/research`, `/decision`) have been created. Templates should include these commands so new projects have workflow automation ready.

**Priority:** High

**Status:** 🔴 Not Started

**Key Questions:**
- Which commands should be included in templates?
- Should all commands be included or a subset?
- How should commands be organized in templates?
- Should commands be in `.cursor/commands/` or another location?
- How should command documentation be structured?

---

### Research Topic 2: CI/CD Improvement Structure in Templates

**Question:** What CI/CD improvement structure should templates include? How should it differ from feature structure?

**Why:** CI/CD improvements have different structure than features (no `status-and-next-steps.md`, different phase organization). Templates should include CI/CD improvement structure so projects can plan CI/CD improvements properly.

**Priority:** High

**Status:** 🔴 Not Started

**Key Questions:**
- What CI/CD improvement structure should templates include?
- How should it differ from feature structure?
- Should templates include CI/CD status tracking template?
- How should CI/CD improvements be documented?
- What directories/files are needed?

---

### Research Topic 3: Exploration/Research/Decision Workflows in Templates

**Question:** How should exploration/research/decision workflows be structured in templates? What directories and files are needed?

**Why:** New commands (`/explore`, `/research`, `/decision`) create exploration/research/decision workflows. Templates should include this structure so projects can use these workflows from the start.

**Priority:** High

**Status:** 🔴 Not Started

**Key Questions:**
- What exploration structure should templates include?
- What research structure should templates include?
- What decision structure should templates include?
- How should these workflows integrate with feature planning?
- What templates/documentation are needed?

---

### Research Topic 4: Requirements Documentation Structure

**Question:** What requirements documentation structure should templates include? Where should requirements be stored?

**Why:** Requirements are discovered during research and inform decisions. Templates should include requirements documentation structure so projects can track requirements properly.

**Priority:** Medium

**Status:** 🔴 Not Started

**Key Questions:**
- Where should requirements be stored? (`research/[topic]/requirements.md`)
- What requirements template/documentation is needed?
- How should requirements integrate with research and decisions?
- What requirements categories are needed (functional, non-functional, constraints, assumptions)?

---

### Research Topic 5: Generator Script Updates

**Question:** How should `new-project.sh` be updated to include new structures? What validation is needed?

**Why:** New structures (commands, CI/CD improvements, exploration/research/decision) need to be included when generating projects. Generator script needs updates to handle new structures.

**Priority:** High

**Status:** 🔴 Not Started

**Key Questions:**
- How should generator script include commands?
- How should generator script create new directory structures?
- What validation is needed for new structures?
- How should script handle template customization?
- What testing is needed?

---

### Research Topic 6: Template Validation Updates

**Question:** How should `validate-templates.sh` be updated to validate new structures? What checks are needed?

**Why:** New structures need validation to ensure templates are correct. Validation script needs updates to check new structures.

**Priority:** Medium

**Status:** 🔴 Not Started

**Key Questions:**
- What validation checks are needed for commands?
- What validation checks are needed for CI/CD structure?
- What validation checks are needed for exploration/research/decision structure?
- What validation checks are needed for requirements?
- How should validation be organized?

---

### Research Topic 7: Other Template Enhancements

**Question:** What other enhancements are needed in templates? What's missing or could be improved?

**Why:** Templates should evolve based on dev-infra learnings. There may be other enhancements needed beyond commands and structures.

**Priority:** Low

**Status:** 🔴 Not Started

**Key Questions:**
- What other enhancements are needed?
- What documentation improvements are needed?
- What process improvements are needed?
- What examples or guides are needed?
- What best practices should be encoded?

---

## 🎯 Research Workflow

1. Use `/research templates-enhancement --from-explore templates-enhancement` to conduct research
2. Research will create documents in `admin/research/templates-enhancement/`
3. After research complete, use `/decision templates-enhancement --from-research` to make decisions

**Note:** Exploration is located at `admin/explorations/templates-enhancement/` (same level as `admin/research/`)

---

**Last Updated:** 2025-12-07

