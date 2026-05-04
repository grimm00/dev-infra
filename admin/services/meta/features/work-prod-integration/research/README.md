# Work-prod Integration - Research Hub

**Purpose:** Research work-prod API integration and local registry for project tracking  
**Status:** ✅ Complete  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-23

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings ⭐
- **[Requirements](requirements.md)** - 21 FRs, 8 NFRs discovered

### Research Documents

| Priority | Topic | Document | Status |
|----------|-------|----------|--------|
| 🔴 High | Auth Model | [research-auth-model.md](research-auth-model.md) | ✅ Complete |
| 🔴 High | Project Model | [research-project-model.md](research-project-model.md) | ⚠️ Superseded |
| 🔴 High | Local Registry Format | [research-local-registry-format.md](research-local-registry-format.md) | ✅ Complete |
| 🟡 Medium | Sync Strategy | [research-sync-strategy.md](research-sync-strategy.md) | ✅ Complete |
| 🟡 Medium | Offline Support | [research-offline-support.md](research-offline-support.md) | ✅ Complete |
| 🟢 Low | Multi-machine Sync | [research-multi-machine-sync.md](research-multi-machine-sync.md) | ✅ Complete |

---

## ⚠️ Superseded Research

| Topic | Superseded By | Reason |
|-------|---------------|--------|
| Project Model | [project-model-definition](../project-model-definition/README.md) | Audited actual work-prod implementation vs assumptions |

**Note:** The `research-project-model.md` in this directory was based on assumptions about work-prod's API. The [Project Model Definition Research](../project-model-definition/README.md) now provides authoritative information based on actual work-prod implementation audit.

**For authoritative schema/API information, see:**
- [Tier 1 API Contract](../project-model-definition/research-tier-1-api-contract.md) - Complete API documentation
- [Classification Enum](../project-model-definition/research-classification-enum.md) - Two-field solution

---

## 🎯 Research Overview

This research investigated how dev-infra can:

1. **Integrate with work-prod API** - Register and track projects using work-prod's standard project model
2. **Maintain local registry** - Keep a central index of all dev-infra managed projects locally

**Research Topics:** 6 topics (1 superseded)  
**Source:** [Work-prod Integration Exploration](../../explorations/work-prod-integration/exploration.md)  
**Status:** ✅ Complete

**Scope Clarification:** This research remains authoritative for:
- Authentication model (API key pattern)
- Local registry format (`~/.dev-infra/registry.json`)
- Sync strategy (manual push/pull)
- Offline support
- Multi-machine sync

For project schema and API contract details, see [Project Model Definition Research](../project-model-definition/README.md).

---

## 📊 Key Decisions

| Question | Answer |
|----------|--------|
| Authentication | API key (user's personal key) |
| Local Registry Format | JSON at `~/.dev-infra/registry.json` |
| Sync Strategy | Manual push/pull (git-like model) |
| Offline Support | All core ops offline; work-prod optional |
| Work-prod Role | Metadata index, not file storage |

---

## 🚀 Next Steps

1. Use `/decision work-prod-integration --from-research` to create ADR
2. Implement local registry first (no work-prod dependency)
3. Add work-prod integration as enhancement

---

## 🔗 Related

- [Work-prod Integration Exploration](../../explorations/work-prod-integration/exploration.md)
- [Project Model Definition Research](../project-model-definition/README.md) - Authoritative schema/API contract
- [Template Metadata Research](../template-metadata/README.md) - Per-project metadata (complements this)
- [Dev-Infra Identity Exploration](../../explorations/dev-infra-identity-and-focus/exploration.md)

---

**Last Updated:** 2025-12-23
