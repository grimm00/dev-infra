# Requirements - Work-prod Integration

**Source:** Research on work-prod API integration and local registry  
**Status:** Final  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-19

---

## 📋 Overview

This document captures requirements discovered during research on work-prod integration.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### Authentication (FR-1 to FR-3)

#### FR-1: API Key Authentication

**Description:** Support API key authentication for work-prod integration.

**Source:** [research-auth-model.md](research-auth-model.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-2: Store API Key in Config File

**Description:** Store API key in local config file (`~/.dev-infra/config.yml`).

**Source:** [research-auth-model.md](research-auth-model.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-3: Environment Variable Override

**Description:** Support `DEV_INFRA_API_KEY` environment variable for CI/automation.

**Source:** [research-auth-model.md](research-auth-model.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### Project Model (FR-4 to FR-7)

#### FR-4: Map to Work-prod Model

**Description:** Map dev-infra projects to work-prod project model.

**Source:** [research-project-model.md](research-project-model.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-5: Store Template Type in Metadata

**Description:** Store template type (standard-project, learning-project) in work-prod metadata.

**Source:** [research-project-model.md](research-project-model.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-6: Store Version in Metadata

**Description:** Store dev-infra version in work-prod metadata.

**Source:** [research-project-model.md](research-project-model.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-7: Tag Projects

**Description:** Tag projects with "dev-infra" for easy filtering.

**Source:** [research-project-model.md](research-project-model.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### Local Registry (FR-8 to FR-10)

#### FR-8: JSON Format

**Description:** Local registry uses JSON format.

**Source:** [research-local-registry-format.md](research-local-registry-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-9: Registry Location

**Description:** Registry stored at `~/.dev-infra/registry.json`.

**Source:** [research-local-registry-format.md](research-local-registry-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-10: Basic Operations

**Description:** Support basic operations: list, add, remove, update.

**Source:** [research-local-registry-format.md](research-local-registry-format.md)

**Priority:** High

**Status:** 🔴 Pending

---

### Sync (FR-11 to FR-14)

#### FR-11: Add on Create

**Description:** Add to local registry automatically on project creation.

**Source:** [research-sync-strategy.md](research-sync-strategy.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-12: Manual Push

**Description:** Manual push command to sync to work-prod (`dev-infra sync push`).

**Source:** [research-sync-strategy.md](research-sync-strategy.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-13: Manual Pull

**Description:** Manual pull command to sync from work-prod (`dev-infra sync pull`).

**Source:** [research-sync-strategy.md](research-sync-strategy.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-14: Conflict Resolution

**Description:** Last-write-wins conflict resolution (local preference).

**Source:** [research-sync-strategy.md](research-sync-strategy.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### Offline Support (FR-15 to FR-17)

#### FR-15: Offline Core Operations

**Description:** All core operations work offline.

**Source:** [research-offline-support.md](research-offline-support.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-16: Optional Integration

**Description:** Work-prod integration is optional (disabled by default).

**Source:** [research-offline-support.md](research-offline-support.md)

**Priority:** High

**Status:** 🔴 Pending

---

#### FR-17: Clear Error Messages

**Description:** Clear error messages for network failures.

**Source:** [research-offline-support.md](research-offline-support.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### Multi-machine (FR-18 to FR-21)

#### FR-18: List Local Default

**Description:** `list` shows local projects by default.

**Source:** [research-multi-machine-sync.md](research-multi-machine-sync.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-19: List All Flag

**Description:** `list --all` shows local + remote projects.

**Source:** [research-multi-machine-sync.md](research-multi-machine-sync.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

#### FR-20: Mark Remote-Only

**Description:** Remote-only projects clearly marked in list.

**Source:** [research-multi-machine-sync.md](research-multi-machine-sync.md)

**Priority:** Low

**Status:** 🔴 Pending

---

#### FR-21: Status Command

**Description:** `status` command shows sync state.

**Source:** [research-multi-machine-sync.md](research-multi-machine-sync.md)

**Priority:** Low

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Credential Security

**Description:** API key should not be stored in per-project files (security).

**Source:** [research-auth-model.md](research-auth-model.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-2: Lossless Mapping

**Description:** Mapping to work-prod should be lossless (no data lost in translation).

**Source:** [research-project-model.md](research-project-model.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-3: Human-Readable Registry

**Description:** Registry readable without special tools (human-readable JSON).

**Source:** [research-local-registry-format.md](research-local-registry-format.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-4: jq Dependency

**Description:** `jq` is acceptable dependency for JSON processing.

**Source:** [research-local-registry-format.md](research-local-registry-format.md)

**Priority:** Low

**Status:** 🔴 Pending

---

### NFR-5: Offline Operations

**Description:** All operations must work offline (work-prod is optional).

**Source:** [research-sync-strategy.md](research-sync-strategy.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-6: No Implicit Network

**Description:** No network calls unless explicitly syncing.

**Source:** [research-offline-support.md](research-offline-support.md)

**Priority:** High

**Status:** 🔴 Pending

---

### NFR-7: Fast Failure

**Description:** Failure should be fast and clear (no hanging).

**Source:** [research-offline-support.md](research-offline-support.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

### NFR-8: Metadata Only Sync

**Description:** Registry sync is metadata only (not file sync).

**Source:** [research-multi-machine-sync.md](research-multi-machine-sync.md)

**Priority:** Medium

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Bash Tooling

**Description:** Dev-infra uses bash scripts. Any storage format must be readable from bash.

**Source:** Dev-infra architecture

---

### C-2: Single User Context

**Description:** Currently single user; can make pragmatic decisions.

**Source:** [Dev-Infra Identity Exploration](../../explorations/dev-infra-identity-and-focus/exploration.md)

---

### C-3: Work-prod Dependency

**Description:** Work-prod API must support custom metadata fields for full integration.

**Source:** [research-project-model.md](research-project-model.md)

---

## 💭 Assumptions

### A-1: Work-prod API Available

**Description:** Work-prod API exists and is accessible for integration.

**Source:** Exploration assumptions

---

### A-2: Metadata Support

**Description:** Work-prod supports custom metadata or tags for project filtering.

**Source:** [research-project-model.md](research-project-model.md)

---

### A-3: Low Project Count

**Description:** Expected project count is 20-50, well within JSON's comfortable range.

**Source:** [research-local-registry-format.md](research-local-registry-format.md)

---

## 📊 Requirements Summary

| Category | Count | High Priority |
|----------|-------|---------------|
| Functional | 21 | 8 |
| Non-Functional | 8 | 4 |
| Constraints | 3 | - |
| Assumptions | 3 | - |

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Documents](README.md)
- [Template Metadata Requirements](../template-metadata/requirements.md)
- [Dev-Infra Identity Exploration](../../explorations/dev-infra-identity-and-focus/exploration.md)

---

## 🚀 Next Steps

1. Use `/decision work-prod-integration --from-research` to make decisions
2. Create ADR documents
3. Transition to feature planning

---

**Last Updated:** 2025-12-19
