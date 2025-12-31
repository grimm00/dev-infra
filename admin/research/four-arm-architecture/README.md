# Four-Arm Architecture - Research Hub

**Purpose:** Research the interconnected ecosystem of dev-infra, dev-toolkit, proj-cli, and work-prod  
**Status:** 🟠 Research (1/6 complete)  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

| # | Research Topic | Priority | Status | Document |
|---|----------------|----------|--------|----------|
| 1 | Command Distribution Ownership | 🔴 High | ✅ Complete | [research-command-distribution-ownership.md](research-command-distribution-ownership.md) |
| 2 | Shared Contracts and Business Logic | 🔴 High | 🔴 Not Started | [research-shared-contracts.md](research-shared-contracts.md) |
| 3 | Integration Points and Data Flow | 🔴 High | 🔴 Not Started | [research-integration-points.md](research-integration-points.md) |
| 4 | Managed Project Lifecycle | 🟡 Medium | 🔴 Not Started | [research-managed-project-lifecycle.md](research-managed-project-lifecycle.md) |
| 5 | Version Coordination | 🟡 Medium | 🔴 Not Started | [research-version-coordination.md](research-version-coordination.md) |
| 6 | Workspace-Level Coordination | 🟢 Low | 🔴 Not Started | [research-workspace-coordination.md](research-workspace-coordination.md) |

---

## 🎯 Research Overview

This research investigates how four interconnected projects should work together as a unified developer infrastructure ecosystem:

| Project | Language | Primary Purpose |
|---------|----------|-----------------|
| **dev-infra** | N/A | Templates, patterns, Cursor AI commands, shared contracts |
| **dev-toolkit** | Bash | Developer CLI utilities (`dt-*` commands) |
| **proj-cli** | Python | Project management (`proj` commands) |
| **work-prod** | Python/Flask | Data API backend |

**Key Design Principle:** Each project can stand alone for external users, but shared business logic (schemas, contracts, models) is coordinated through dev-infra.

---

## 🔗 Related Research

- **[Global Command Distribution](../global-command-distribution/README.md)** - Prior command installation research
- **[Terraform-Style Project Management](../terraform-style-project-management/README.md)** - State tracking and sync patterns
- **[Work-prod Integration](../work-prod-integration/README.md)** - API and registry integration
- **[Project Model Definition](../project-model-definition/README.md)** - Project data model research

---

## 📊 Research Dependencies

```
Command Distribution Ownership
        │
        ├─────────────────────────┐
        ▼                         ▼
Shared Contracts ──────► Integration Points
        │                         │
        ├─────────────────────────┤
        ▼                         ▼
Managed Project Lifecycle    Version Coordination
                                  │
                                  ▼
                      Workspace Coordination
```

**Recommended Research Order:**
1. Command Distribution Ownership (informs dev-toolkit roadmap)
2. Shared Contracts (foundational - affects all integration decisions)
3. Integration Points (architectural foundation, builds on contracts)
4. Managed Project Lifecycle (clarifies proj-cli scope)
5. Version Coordination (release planning)
6. Workspace Coordination (nice-to-have)

---

## 🔍 Source Exploration

**From:** [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/README.md)

**Research Topics Source:** [research-topics.md](../../explorations/four-arm-architecture/research-topics.md)

---

## 🚀 Next Steps

1. Use `/research four-arm-architecture --conduct --topic-num 1` to research topic 1
2. Or use `/research four-arm-architecture --conduct` to research all topics
3. After research complete, use `/decision four-arm-architecture --from-research` to make decisions

---

**Last Updated:** 2025-12-31

