# Research Topics - Template Architecture

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions.

---

### Research Topic 1: Real-World Project Types

**Question:** What types of projects do developers commonly create, and which don't fit the frontend/backend pattern?

**Why:** Understanding actual use cases helps determine which template types are needed.

**Areas to Investigate:**
- API-only services (no frontend)
- CLI tools and utilities
- Libraries and packages
- Microservices / Multi-service architectures
- Mobile apps (native, React Native, Flutter)
- Desktop apps (Electron, Tauri)
- Serverless functions
- Data pipelines / ETL jobs
- Monorepos with multiple projects

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 2: Existing Template Systems

**Question:** How do popular template/scaffolding systems handle project variety?

**Why:** Learn from existing solutions to avoid reinventing the wheel.

**Systems to Research:**
- **Cookiecutter** - Python project templates
- **Yeoman** - Web project generators
- **create-react-app / create-next-app** - React scaffolding
- **cargo new / go mod init** - Language-specific project init
- **Nx / Turborepo** - Monorepo tools
- **Projen** - Project generation as code
- **Hygen** - Code generation

**Key Questions:**
- How do they handle different project types?
- Do they use composition, specialization, or configuration?
- What's their maintenance model?
- What patterns have proven successful?

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 3: Directory Structure Patterns

**Question:** What directory structure patterns are common across different project types?

**Why:** Understanding common patterns helps design flexible yet opinionated templates.

**Patterns to Research:**
- **Layered:** `src/controllers/`, `src/services/`, `src/models/`
- **Feature-based:** `src/auth/`, `src/projects/`, `src/billing/`
- **Package-based:** `packages/api/`, `packages/web/`, `packages/shared/`
- **Domain-driven:** `src/domain/`, `src/application/`, `src/infrastructure/`
- **Flat:** Everything in `src/` with conventions
- **Workspace:** `apps/`, `libs/`, `tools/`

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 4: Configuration vs Convention

**Question:** What's the right balance between configurable templates and opinionated defaults?

**Why:** Too much configuration = analysis paralysis; too little = inflexible.

**Areas to Investigate:**
- What decisions should be made at template generation time?
- What should be easily changeable after generation?
- What should be "baked in" (conventions)?
- How do other tools handle this balance?

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 5: Template Maintenance Burden

**Question:** How many templates can be effectively maintained, and what's the DRY strategy?

**Why:** More templates = more maintenance; need sustainable approach.

**Areas to Investigate:**
- How do multi-template projects share common components?
- What's the testing strategy for multiple templates?
- How to keep templates in sync when base changes?
- What's the documentation burden?

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 6: Minimum Viable Template Set

**Question:** What's the minimum set of templates needed to cover most use cases?

**Why:** Avoid template proliferation while still serving common needs.

**Hypothesis to Test:**
```
Templates needed:
1. full-stack-web (current standard-project)
2. api-service (backend only)
3. cli-tool (command-line app)
4. library (reusable package)
5. learning-project (already exists)
```

**Questions:**
- Does this cover 80%+ of use cases?
- Are there gaps that would leave users stranded?
- Is 5 templates too many or too few?

**Priority:** 🟠 Medium-High

**Status:** 🔴 Not Started

---

## 🎯 Research Workflow

1. Use `/research template-architecture --from-explore template-architecture` to conduct research
2. Research will create documents in `admin/research/template-architecture/`
3. After research complete, use `/decision template-architecture --from-research` to make decisions

---

## 📊 Priority Summary

| Topic | Priority | Status |
|-------|----------|--------|
| Real-World Project Types | 🔴 High | 🔴 Not Started |
| Existing Template Systems | 🔴 High | 🔴 Not Started |
| Directory Structure Patterns | 🟡 Medium | 🔴 Not Started |
| Configuration vs Convention | 🟡 Medium | 🔴 Not Started |
| Template Maintenance Burden | 🟡 Medium | 🔴 Not Started |
| Minimum Viable Template Set | 🟠 Medium-High | 🔴 Not Started |

---

**Last Updated:** 2025-12-12

