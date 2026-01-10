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

### Command Distribution (from Topic 1)

#### FR-CMD-1: dt-cursor-install Command

**Description:** dev-toolkit MUST provide a `dt-cursor-install` command for installing Cursor AI commands globally.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** High

**Status:** 🔴 Pending Implementation

---

#### FR-CMD-2: Installation Location

**Description:** `dt-cursor-install` MUST copy commands to `~/.cursor/commands/` directory.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** High

**Status:** 🔴 Pending Implementation

---

#### FR-CMD-3: Version Pinning

**Description:** `dt-cursor-install` MUST support version pinning via `--version` flag to install specific dev-infra release versions.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** High

**Status:** 🔴 Pending Implementation

---

#### FR-CMD-4: List Available Versions

**Description:** `dt-cursor-install` MUST support listing available versions via `--list` flag.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** Medium

**Status:** 🔴 Pending Implementation

---

#### FR-CMD-5: Update Command

**Description:** `dt-cursor-install` MUST support updating to latest via `--update` flag.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** Medium

**Status:** 🔴 Pending Implementation

---

#### FR-CMD-6: Default to Latest Stable

**Description:** `dt-cursor-install` SHOULD default to installing the latest stable dev-infra release when no version is specified.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** Medium

**Status:** 🔴 Pending Implementation

---

### Shared Contracts (from Topic 2)

#### FR-SC-1: Contract Ownership Designation

**Description:** Each contract type MUST have a designated owner (spec owner) who is responsible for maintaining it.

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** High

**Status:** ✅ Validated (already in practice via OpenAPI standard)

---

#### FR-SC-2: Spec Owner Update Responsibility

**Description:** Spec owners MUST update their contracts when making changes to the underlying implementation.

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** High

**Status:** ✅ Validated (PR-1 in OpenAPI standard)

---

#### FR-SC-3: Standards Documentation Location

**Description:** Standards for cross-arm contracts MUST be documented in `admin/planning/standards/`.

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** High

**Status:** ✅ Validated (OpenAPI standard exists there)

---

#### FR-SC-4: Standards Pattern Extension

**Description:** New cross-arm contracts SHOULD follow the OpenAPI standard pattern (ownership matrix, process requirements, compliance checklist).

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** Medium

**Status:** 🟡 Validated - Should create command-distribution standard

---

### Integration Points (from Topic 3)

#### FR-IP-1: proj-cli REST API Communication

**Description:** proj-cli MUST continue using REST API for work-prod communication. The current implementation is well-designed and follows best practices.

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** ✅ Validated (already implemented)

---

#### FR-IP-2: dt-cursor-install Implementation

**Description:** dev-toolkit MUST implement `dt-cursor-install` command for command distribution (ties to Topic 1 requirement).

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** 🔴 Pending Implementation

---

#### FR-IP-3: dt-cursor-install Source Location

**Description:** `dt-cursor-install` MUST read commands from dev-infra repository (not duplicated in dev-toolkit).

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** 🔴 Pending Implementation

---

#### FR-IP-4: Global Command Destination

**Description:** `dt-cursor-install` MUST copy commands to `~/.cursor/commands/` directory.

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** 🔴 Pending Implementation

---

#### FR-IP-5: Version Tracking

**Description:** `dt-cursor-install` SHOULD track installed version for update detection.

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** Medium

**Status:** 🔴 Pending Implementation

---

## 🎯 Non-Functional Requirements

### Core Architecture (from Exploration)

#### NFR-1: Standalone Usability

**Description:** Each of the four projects MUST be usable independently by external users without requiring the other projects.

**Source:** [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/exploration.md)

**Priority:** High

**Status:** ✅ Confirmed (from exploration)

---

#### NFR-2: Internal Consistency

**Description:** For internal development, shared business logic (schemas, contracts, models) MUST be coordinated through dev-infra.

**Source:** [Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/exploration.md)

**Priority:** High

**Status:** ✅ Confirmed (from exploration)

---

### Command Distribution (from Topic 1)

#### NFR-CMD-1: Offline Installation Support

**Description:** Installation MUST work offline if commands are already cached locally.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** Medium

**Status:** 🔴 Pending Implementation

---

#### NFR-CMD-2: No Clone Required

**Description:** Installation MUST NOT require dev-infra repository to be cloned. Commands should be fetchable from GitHub releases.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** High

**Status:** 🔴 Pending Implementation

---

#### NFR-CMD-3: Release Artifacts

**Description:** dev-infra MUST include commands in GitHub releases as downloadable artifacts (e.g., `commands-v0.8.0.tar.gz`).

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

**Priority:** High

**Status:** 🔴 Pending Implementation

---

### Shared Contracts (from Topic 2)

#### NFR-SC-1: Standalone Usability with Embedded Contracts

**Description:** Each project MUST remain standalone-usable with embedded contracts. External users should not need to fetch contracts from other repos.

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** High

**Status:** ✅ Validated (already achieved)

---

#### NFR-SC-2: Process-Based Coordination

**Description:** Contract coordination SHOULD use process standards (PR requirements, code review checklists), not technical sync mechanisms.

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** High

**Status:** ✅ Validated (OpenAPI standard uses this approach)

---

#### NFR-SC-3: Ownership Matrix Documentation

**Description:** Standards MUST define an ownership matrix specifying: spec owner, spec consumers, and responsibilities for each.

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** Medium

**Status:** ✅ Validated (OpenAPI standard has this)

---

### Integration Points (from Topic 3)

#### NFR-IP-1: Optional Integrations

**Description:** All integrations MUST be optional. Tools MUST degrade gracefully when other arms are unavailable.

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** ✅ Validated (already achieved)

---

#### NFR-IP-2: Offline Core Functionality

**Description:** Tools MUST work offline for core functionality. Network is only required for optional integrations.

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** ✅ Validated (already achieved)

---

#### NFR-IP-3: XDG Configuration Pattern

**Description:** Configuration MUST follow XDG Base Directory pattern for consistency with other CLI tools.

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** Medium

**Status:** ✅ Validated (proj-cli implements this)

---

#### NFR-IP-4: No Runtime Dependencies

**Description:** Tools MUST NOT have runtime dependencies between each other. Dependencies are install-time only.

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** ✅ Validated (already achieved)

---

### Version Coordination (from Topic 5 - Pending)

#### NFR-VC-1: [Pending - Version Coordination]

**Description:** [To be determined from research]

**Source:** [research-version-coordination.md](research-version-coordination.md)

**Priority:** Medium

**Status:** 🔴 Pending Research

---

## ⚠️ Constraints

### Core Architecture

#### C-1: Existing Infrastructure

**Description:** Solutions must work with existing infrastructure:
- dev-toolkit has established `install.sh` and `dt-*` command pattern
- work-prod has established OpenAPI spec (`backend/openapi.yaml`)
- proj-cli is in active development

**Source:** Exploration analysis

---

#### C-2: Multi-Repository Structure

**Description:** The four projects exist in separate Git repositories and must remain so. Monorepo is not an option.

**Source:** Current architecture

---

### Command Distribution (from Topic 1)

#### C-CMD-1: No Command Duplication

**Description:** Commands MUST NOT be duplicated across dev-infra and dev-toolkit repositories. dev-infra is the single source of truth.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

---

#### C-CMD-2: No Content Modification

**Description:** dev-toolkit MUST NOT modify command content during installation. Source owner (dev-infra) controls command content.

**Source:** [research-command-distribution-ownership.md](research-command-distribution-ownership.md)

---

### Shared Contracts (from Topic 2)

#### C-SC-1: No External Dependencies for Standalone

**Description:** Contracts MUST NOT require external dependencies for standalone use. Each project must embed its own copy of contracts.

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

---

#### C-SC-2: No Complex Contract Infrastructure

**Description:** Complex contract infrastructure (schema registries, automated sync, consumer-driven contract testing) is NOT appropriate for current scale. Use process-based standards instead.

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

---

### Integration Points (from Topic 3)

#### C-IP-1: No Shared Configuration

**Description:** Shared configuration is NOT appropriate for the Four-Arm Architecture. Each tool should maintain its own configuration. Shared config adds complexity without proportional benefit.

**Source:** [research-integration-points.md](research-integration-points.md)

---

#### C-IP-2: No Direct Tool Dependencies

**Description:** proj-cli and dev-toolkit MUST NOT have direct dependencies on each other. They can both consume from other arms but should not depend on each other.

**Source:** [research-integration-points.md](research-integration-points.md)

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

