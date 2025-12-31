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

### Shared Contracts (from Topic 2 - Pending)

#### FR-SC-1: [Pending - Shared Contracts]

**Description:** [To be determined from research]

**Source:** [research-shared-contracts.md](research-shared-contracts.md)

**Priority:** High

**Status:** 🔴 Pending Research

---

### Integration Points (from Topic 3 - Pending)

#### FR-IP-1: [Pending - Integration Points]

**Description:** [To be determined from research]

**Source:** [research-integration-points.md](research-integration-points.md)

**Priority:** High

**Status:** 🔴 Pending Research

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

