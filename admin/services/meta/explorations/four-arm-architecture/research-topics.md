# Research Topics - Four-Arm Architecture

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-31

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions about the four-arm architecture.

---

### Research Topic 1: Command Distribution Ownership

**Question:** Where should global Cursor command installation live - dev-infra or dev-toolkit?

**Why:** The "Global Command Distribution" research assumed dev-infra would handle installation. With dev-toolkit's existing install infrastructure, this needs reconsideration.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Does dev-toolkit's `install.sh` pattern fit command installation?
- Should dev-toolkit pull commands from dev-infra releases?
- How to handle versioning between the two?
- Should there be a `dt-cursor-install` command?

---

### Research Topic 2: Shared Contracts and Business Logic (NEW)

**Question:** How should dev-infra coordinate shared schemas and business logic across all four arms while maintaining standalone usability?

**Why:** Each project needs to work independently for external users, but internal development requires consistent contracts (API schemas, database models, JSON store formats).

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Where should shared contracts live in dev-infra? (`admin/contracts/`, templates, or elsewhere?)
- How are contracts distributed to consuming projects?
- How do external users get contracts when using a project standalone?
- How are contract changes coordinated across arms?
- Should contracts be versioned separately from templates?
- What validation ensures implementations match contracts?

**Contracts to consider:**
1. **work-prod API Schema** - OpenAPI spec (already exists in work-prod)
2. **work-prod Database Schema** - SQLAlchemy models / migration definitions
3. **proj-cli JSON Store Schema** - JSON schema for local data store
4. **Project Model Definition** - Shared data model across all arms

**Options to explore:**
1. **Embedded contracts:** Each project has its own copy (simple, but drift risk)
2. **Shared source:** dev-infra holds canonical contracts, projects sync (coordinated, but complex)
3. **Published contracts:** dev-infra publishes contracts as artifacts (versioned, but overhead)
4. **Hybrid:** Different strategies for different contract types

**Existing pattern:** `admin/planning/standards/openapi-source-of-truth/` establishes work-prod's OpenAPI spec as authoritative - could extend this pattern.

---

### Research Topic 3: Integration Points and Data Flow

**Question:** How should the four projects communicate with each other?

**Why:** Clear integration points enable loose coupling while maintaining functionality.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- API vs file-based communication?
- Should proj-cli depend on dev-toolkit?
- How does dev-toolkit know about dev-infra releases?
- Should there be a shared configuration format?

**Options to explore:**
1. **Independent:** Each project operates standalone
2. **Loosely coupled:** Shared conventions, no direct dependencies
3. **Integrated:** Direct dependencies between projects

---

### Research Topic 4: Managed Project Lifecycle

**Question:** What does "managed by dev-infra" mean for different project types?

**Why:** Not all projects need the same level of sync. Tooling projects (dev-toolkit) may differ from application projects (work-prod).

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- Should dev-toolkit be a "managed" project?
- What files should sync for tooling vs application projects?
- How to handle projects that don't want auto-updates?
- Can a project opt out of being managed?

**Project categories:**
1. **Application projects:** work-prod (full sync)
2. **Tooling projects:** dev-toolkit, proj-cli (minimal sync?)
3. **Infrastructure:** dev-infra itself (not managed)

---

### Research Topic 5: Version Coordination

**Question:** How should versions coordinate across the four projects?

**Why:** Users need to know which versions work together.

**Priority:** Medium

**Status:** 🔴 Not Started

**Sub-questions:**
- Should releases be coordinated?
- How to handle breaking changes in one project?
- Should there be a "compatibility matrix"?
- Is semantic versioning sufficient?

**Options:**
1. **Independent versioning:** Each project versions independently
2. **Coordinated releases:** Major releases align
3. **Unified versioning:** All projects share version (not recommended)

---

### Research Topic 6: Workspace-Level Coordination

**Question:** How should these four projects work together in a Cursor workspace?

**Why:** The user is using a multi-root workspace with all four projects. This enables cross-project coordination.

**Priority:** Low

**Status:** 🔴 Not Started

**Sub-questions:**
- Should there be workspace-level Cursor rules?
- How do cross-project commands work?
- What shared state exists?
- Is there a "meta" project managing the workspace?

**Considerations:**
- Cursor workspace files (`*.code-workspace`)
- Shared rules across projects
- Cross-project navigation

---

## 📊 Priority Matrix

| Topic | Priority | Complexity | Dependencies |
|-------|----------|------------|--------------|
| Command Distribution Ownership | High | Medium | Global Command Distribution research |
| **Shared Contracts (NEW)** | **High** | **High** | **OpenAPI standard, all four projects** |
| Integration Points | High | High | All four projects, Shared Contracts |
| Managed Project Lifecycle | Medium | Medium | Terraform-style research |
| Version Coordination | Medium | Low | None |
| Workspace Coordination | Low | Medium | None |

**Recommended Research Order:**
1. Command Distribution Ownership (informs dev-toolkit roadmap)
2. **Shared Contracts (foundational - affects all integration decisions)**
3. Integration Points (architectural foundation, builds on contracts)
4. Managed Project Lifecycle (clarifies proj-cli scope)
5. Version Coordination (release planning)
6. Workspace Coordination (nice-to-have)

---

## 🎯 Research Workflow

1. Use `/research four-arm-architecture --from-explore four-arm-architecture` to conduct research
2. Research will create documents in `admin/research/four-arm-architecture/`
3. After research complete, use `/decision four-arm-architecture --from-research` to make decisions

---

## 🔗 Related Research

- **[Global Command Distribution](../../research/global-command-distribution/README.md)** - Command installation patterns
- **[Terraform-Style Project Management](../terraform-style-project-management/README.md)** - State tracking and sync
- **[Work-prod Integration](../../research/work-prod-integration/README.md)** - API and registry integration

---

**Last Updated:** 2025-12-31


