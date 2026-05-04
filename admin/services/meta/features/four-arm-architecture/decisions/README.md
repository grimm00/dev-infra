# Four-Arm Architecture - Decisions Hub

**Purpose:** Architecture decisions for the four-arm developer infrastructure ecosystem  
**Status:** ✅ Accepted  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## 📋 Quick Links

- **[Decisions Summary](decisions-summary.md)** - Summary of all decisions
- **[Research Hub](../../research/four-arm-architecture/README.md)** - Related research
- **[Requirements](../../research/four-arm-architecture/requirements.md)** - Requirements document
- **[Exploration](../../explorations/four-arm-architecture/README.md)** - Original exploration

### ADR Documents

| ADR | Decision | Status |
|-----|----------|--------|
| **[ADR-001](adr-001-command-distribution-ownership.md)** | Command Distribution Ownership | ✅ Accepted |
| **[ADR-002](adr-002-contract-coordination-strategy.md)** | Contract Coordination Strategy | ✅ Accepted |
| **[ADR-003](adr-003-integration-architecture.md)** | Integration Architecture | ✅ Accepted |

---

## 🎯 Decisions Overview

These decisions establish how the four interconnected projects (dev-infra, dev-toolkit, proj-cli, work-prod) should work together as a unified ecosystem while maintaining standalone usability.

**Key Design Principle:** Each project can stand alone for external users, but shared business logic is coordinated through dev-infra.

**Decision Points:** 3 decisions  
**Status:** ✅ All Accepted

---

## 🏗️ Architecture Context

| Project | Language | Primary Purpose |
|---------|----------|-----------------|
| **dev-infra** | N/A | Templates, patterns, Cursor AI commands, shared contracts |
| **dev-toolkit** | Bash | Developer CLI utilities (`dt-*` commands) |
| **proj-cli** | Python | Project management (`proj` commands) |
| **work-prod** | Python/Flask | Data API backend |

---

## 📊 Decision Summary

### ADR-001: Command Distribution Ownership

**Decision:** dev-infra remains source owner, dev-toolkit becomes distribution owner via `dt-cursor-install`.

**Impact:** New command in dev-toolkit, release artifact changes in dev-infra.

---

### ADR-002: Contract Coordination Strategy

**Decision:** Use standards-based coordination (extending OpenAPI pattern), not technical sync mechanisms.

**Impact:** No new infrastructure needed, document additional standards as needed.

---

### ADR-003: Integration Architecture

**Decision:** Hybrid integration model - API for data, files for installation, per-tool configuration.

**Impact:** No shared configuration, all integrations optional.

---

## 🚀 Next Steps

1. ~~Review ADR documents~~ ✅
2. ~~Approve decisions~~ ✅
3. Use `/transition-plan --from-adr` to transition to implementation planning
4. Implement `dt-cursor-install` in dev-toolkit
5. Document command-distribution standard in dev-infra

---

**Last Updated:** 2025-12-31

