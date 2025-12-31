# Requirements - Four-Arm Architecture

**Source:** Research on Four-Arm Architecture  
**Status:** Draft  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## 📋 Overview

This document captures requirements discovered during research on the four-arm architecture - how dev-infra, dev-toolkit, proj-cli, and work-prod should work together.

**Research Source:** [research-summary.md](research-summary.md)

**Key Design Principle:** Each project can stand alone for external users, but shared business logic is coordinated through dev-infra.

---

## ✅ Functional Requirements

### FR-1: [Pending - Command Distribution]

**Description:** [To be determined from research]

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** High

**Status:** 🔴 Pending Research

---

### FR-2: [Pending - Shared Contracts]

**Description:** [To be determined from research]

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** High

**Status:** 🔴 Pending Research

---

### FR-3: [Pending - Integration Points]

**Description:** [To be determined from research]

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** 🔴 Pending Research

---

## 🎯 Non-Functional Requirements

### NFR-1: Standalone Usability

**Description:** Each of the four projects MUST be usable independently by external users without requiring the other projects.

**Source:** [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/exploration.md)

**Priority:** High

**Status:** ✅ Confirmed (from exploration)

---

### NFR-2: Internal Consistency

**Description:** For internal development, shared business logic (schemas, contracts, models) MUST be coordinated through dev-infra.

**Source:** [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/exploration.md)

**Priority:** High

**Status:** ✅ Confirmed (from exploration)

---

### NFR-3: [Pending - Version Coordination]

**Description:** [To be determined from research]

**Source:** [research-version-coordination.md](research-version-coordination.md)

**Priority:** Medium

**Status:** 🔴 Pending Research

---

## ⚠️ Constraints

### C-1: Existing Infrastructure

**Description:** Solutions must work with existing infrastructure:
- dev-toolkit has established `install.sh` and `dt-*` command pattern
- work-prod has established OpenAPI spec (`backend/openapi.yaml`)
- proj-cli is in active development

**Source:** Exploration analysis

---

### C-2: Multi-Repository Structure

**Description:** The four projects exist in separate Git repositories and must remain so. Monorepo is not an option.

**Source:** Current architecture

---

## 💭 Assumptions

### A-1: Primary User is Internal

**Description:** The primary user of the four-arm coordination is the internal developer (author). External users interact with individual projects standalone.

**Source:** [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/exploration.md)

---

### A-2: OpenAPI Standard is Established

**Description:** The `admin/planning/standards/openapi-source-of-truth/` establishes a pattern that can be extended to other contracts.

**Source:** [OpenAPI Source of Truth Standard](../../planning/standards/openapi-source-of-truth/README.md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/README.md)

---

## 🚀 Next Steps

1. Complete research to fill in pending requirements
2. Review and prioritize requirements
3. Use `/decision four-arm-architecture --from-research` to make decisions
4. Decisions may refine requirements

---

**Last Updated:** 2025-12-31

