# Research Topics - proj-cli Focused Role

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Research Topics

This document lists research topics and questions that need investigation to clarify proj-cli's focused role within the four-arm architecture.

---

### Research Topic 1: Scope Boundaries

**Question:** What specific features should proj-cli include or exclude?

**Why:** Clear scope prevents feature creep and ensures proj-cli does one thing well.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Should proj-cli have ANY command installation features?
- Is registry management the right scope?
- Should project health checks be included?
- What about project statistics/analytics?

**Proposed Scope:**
- IN: init, plan, apply, customize, state, registry
- OUT: command installation, git utilities, code review

---

### Research Topic 2: dev-toolkit Integration

**Question:** How should proj-cli integrate with dev-toolkit?

**Why:** Users may expect these tools to work together seamlessly.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Should proj-cli depend on dev-toolkit being installed?
- Should `proj init` invoke `dt-cursor-install` automatically?
- Should there be a shared configuration?
- How to handle when dev-toolkit is not installed?

**Options:**
1. **Independent:** proj-cli works without dev-toolkit
2. **Recommended:** proj-cli suggests dev-toolkit but doesn't require
3. **Required:** proj-cli depends on dev-toolkit

---

### Research Topic 3: Getting Started Flow

**Question:** What's the recommended "getting started" flow for new users?

**Why:** Four CLI tools (dev-infra scripts, dev-toolkit, proj-cli, work-prod API) could be confusing.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- Which tool should users install first?
- What's the minimum setup for each use case?
- How to guide users through the ecosystem?
- Should there be a unified "bootstrap" command?

**Possible Flows:**
```
Flow A: Project-First
  1. dev-infra: new-project.sh
  2. proj-cli: proj init
  3. dev-toolkit: dt-cursor-install (optional)

Flow B: Toolkit-First
  1. dev-toolkit: install.sh
  2. dt-cursor-install (gets commands)
  3. proj-cli: proj init (for project management)

Flow C: Unified
  1. Single bootstrap script handles all
```

---

### Research Topic 4: Command Transfer

**Question:** Which commands from terraform-style research belong in dev-toolkit vs proj-cli?

**Why:** The terraform-style research proposed commands that may be better suited for dev-toolkit.

**Priority:** Medium

**Status:** 🔴 Not Started

**Review from terraform-style research:**
- `proj plan` → proj-cli (project state)
- `proj apply` → proj-cli (project state)
- `proj customize` → proj-cli (project state)
- `proj registry` → proj-cli (registry management)
- Command installation → dev-toolkit (tooling)

---

### Research Topic 5: work-prod API Integration

**Question:** How should proj-cli integrate with the work-prod API?

**Why:** proj-cli needs work-prod for registry operations, but should work offline too.

**Priority:** Low

**Status:** 🔴 Not Started

**Sub-questions:**
- What's the authentication model?
- How to handle offline scenarios?
- Should registry be optional?
- What metadata does proj-cli need from work-prod?

---

## 📊 Priority Matrix

| Topic | Priority | Complexity | Dependencies |
|-------|----------|------------|--------------|
| Scope Boundaries | High | Low | Four-arm architecture |
| dev-toolkit Integration | High | Medium | Four-arm architecture |
| Getting Started Flow | Medium | Low | All four projects |
| Command Transfer | Medium | Low | Terraform-style research |
| work-prod API Integration | Low | Medium | work-prod API |

**Recommended Research Order:**
1. Scope Boundaries (foundational)
2. dev-toolkit Integration (affects implementation)
3. Command Transfer (clarifies terraform-style work)
4. Getting Started Flow (user experience)
5. work-prod API Integration (can defer)

---

## 🎯 Research Workflow

1. Use `/research proj-cli-focused-role --from-explore proj-cli-focused-role` to conduct research
2. Research will create documents in `admin/research/proj-cli-focused-role/`
3. After research complete, use `/decision proj-cli-focused-role --from-research` to make decisions

---

## 🔗 Related Research

- **[Four-Arm Architecture](../four-arm-architecture/README.md)** - Ecosystem context
- **[Terraform-Style Project Management](../terraform-style-project-management/README.md)** - Command definitions
- **[Global Command Distribution](../../research/global-command-distribution/README.md)** - May transfer to dev-toolkit

---

**Last Updated:** 2025-12-22

