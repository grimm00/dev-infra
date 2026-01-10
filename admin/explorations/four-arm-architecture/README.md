# Four-Arm Architecture - Exploration Hub

**Purpose:** Explore the interconnected ecosystem of dev-infra, dev-toolkit, proj-cli, and work-prod  
**Status:** 🔴 Exploration  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-31

---

## 📋 Quick Links

- **[Exploration Document](exploration.md)** - Main exploration with architecture diagrams
- **[Research Topics](research-topics.md)** - Research questions to investigate (6 topics)

---

## 🎯 Overview

This exploration maps the relationship between four interconnected projects that form a complete developer infrastructure ecosystem:

| Project | Language | Primary Purpose |
|---------|----------|-----------------|
| **dev-infra** | N/A | Templates, patterns, Cursor AI commands, **shared contracts** |
| **dev-toolkit** | Bash | Developer CLI utilities (`dt-*` commands) |
| **proj-cli** | Python | Project management (`proj` commands) |
| **work-prod** | Python/Flask | Data API backend |

**Key Design Principle:** Each project can stand alone for external users, but shared business logic (schemas, contracts, models) is coordinated through dev-infra.

---

## 🔗 Related Work

This exploration builds on:

- **[Terraform-Style Project Management](../terraform-style-project-management/README.md)** - proj-cli's plan/apply role
- **[Global Command Distribution](../../research/global-command-distribution/README.md)** - Command installation (may move to dev-toolkit)
- **[Dev-Infra Identity v4](../dev-infra-identity-and-focus/README.md)** - "Command Hub" concept needs revision
- **[OpenAPI Source of Truth Standard](../../planning/standards/openapi-source-of-truth/README.md)** - Existing cross-arm contract pattern

---

## 📊 Status

**Current Phase:** Exploration  
**Next Step:** Conduct research on 6 topics identified in research-topics.md

**Research Priority:**
1. Command Distribution Ownership (High)
2. Shared Contracts and Business Logic (High) ← NEW
3. Integration Points and Data Flow (High)
4. Managed Project Lifecycle (Medium)
5. Version Coordination (Medium)
6. Workspace-Level Coordination (Low)

---

**Last Updated:** 2025-12-31


