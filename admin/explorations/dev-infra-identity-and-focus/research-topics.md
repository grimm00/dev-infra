# Research Topics - Dev-Infra Identity & Focus

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions about dev-infra's identity and focus.

---

### Research Topic 1: Template User Needs

**Question:** What do template users actually need from dev-infra templates?

**Why:** Understanding user needs should drive what gets templatized. We may be over-engineering for our own workflow rather than user needs.

**Sub-questions:**
- What's the minimum viable template?
- Which commands do generated projects actually use?
- What patterns from dev-infra have proven valuable in real projects?

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 2: Command Maintenance Model

**Question:** What's the appropriate maintenance model for AI commands vs traditional code?

**Why:** Commands are guides for agents, not compiled code. They may need different versioning, testing, and maintenance approaches.

**Sub-questions:**
- How do we version AI commands?
- How do we test AI commands?
- Should templates have fewer, more stable commands?
- What's the cost of maintaining 15+ commands vs 5 essential ones?

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 3: Graduation Criteria

**Question:** What criteria should determine when an internal improvement becomes a template feature?

**Why:** Need clear process to prevent premature templatization and reduce scope creep.

**Sub-questions:**
- Time-based criteria (use for N releases before templatizing)?
- Value-based criteria (measurable benefit to users)?
- Stability criteria (no major changes in N weeks)?
- Complexity criteria (simple enough to maintain in templates)?

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 4: Organizational Structure

**Question:** How should we restructure planning to reflect a template-centric identity?

**Why:** Current structure (`features/`, `ci/`, scattered) creates confusion about where things belong.

**Sub-questions:**
- Should we have `internal/` vs `template/` split?
- Should all template-bound work go through `features/`?
- Should CI/CD improvements be subordinate to template goals?
- How do we track internal-only tooling?

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 5: Minimum Viable Tooling

**Question:** What is the minimum dev-infra needs to be an excellent template factory?

**Why:** Helps identify what to cut and what's essential.

**Sub-questions:**
- Which scripts are essential?
- Which commands are essential?
- What documentation is essential?
- What automation is essential vs nice-to-have?

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 6: Release Automation v2 Scope

**Question:** Should v0.5.0's Release Automation v2 proceed as planned, be rescoped, or deferred?

**Why:** This is an immediate decision point that depends on the identity question.

**Options:**
1. **Proceed as planned:** Complete all 3 phases
2. **Rescope:** Focus on Phase 3 (template integration) only
3. **Defer:** Focus on template stability, defer automation improvements
4. **Split:** Internal automation now, template integration later

**Priority:** 🔴 High (blocking v0.5.0 planning)

**Status:** 🔴 Not Started

---

### Research Topic 7: Other Projects' Patterns

**Question:** How do similar meta-projects (template generators, boilerplates) handle this?

**Why:** Learn from how others have solved the laboratory/factory/reference tension.

**Examples to Research:**
- Create React App
- Vue CLI
- Cookiecutter
- Yeoman generators
- GitHub template repositories

**Priority:** 🟢 Low

**Status:** 🔴 Not Started

---

## 🎯 Research Workflow

1. Use `/research [topic] --from-explore dev-infra-identity-and-focus` to conduct research
2. Research will create documents in `admin/research/[topic]/`
3. After research complete, use `/decision [topic] --from-research` to make decisions

---

## 📊 Priority Summary

| Priority | Topics |
|----------|--------|
| 🔴 High | Template User Needs, Command Maintenance, Release Automation v2 Scope |
| 🟡 Medium | Graduation Criteria, Organizational Structure, Minimum Viable Tooling |
| 🟢 Low | Other Projects' Patterns |

---

## 🚀 Recommended Research Order

1. **Template User Needs** - Foundation for all decisions
2. **Release Automation v2 Scope** - Immediate decision needed
3. **Command Maintenance Model** - Affects template command strategy
4. **Graduation Criteria** - Process improvement
5. **Organizational Structure** - Implementation of decisions

---

**Last Updated:** 2025-12-11

