# OpenAPI as Single Source of Truth - Standard Hub

**Purpose:** Establish OpenAPI specification as authoritative API contract  
**Status:** ✅ Active (Standard Established)  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23  
**Type:** Process Standard

---

## 📋 Quick Links

- **[Transition Plan](transition-plan.md)** - Standard adoption plan
- **[ADR-002](../../../decisions/project-model-definition/adr-002-openapi-source-of-truth.md)** - Decision record

### Related Requirements

- **[Requirements](../../../research/project-model-definition/requirements.md)** - NFR-1a: OpenAPI as Source of Truth

---

## 🎯 Standard Overview

The work-prod OpenAPI 3.0.3 specification (`backend/openapi.yaml`) is the **single source of truth** for all API contract documentation in the ecosystem.

**This is a process standard, not a feature** - it establishes guidelines for how API changes are documented and communicated across arms.

---

## 🏢 Ownership Matrix

| Arm | Role | Responsibilities |
|-----|------|------------------|
| **work-prod** | Spec Owner | Maintains `backend/openapi.yaml`, updates on API changes |
| **proj-cli** | Spec Consumer | References spec for client implementation, reports discrepancies |
| **dev-infra** | Standard Keeper | Documents standard, ensures compliance across arms |
| **dev-toolkit** | N/A | No direct API integration (shell-only tooling) |

---

## ✅ Process Requirements

### PR-1: Spec Updates with API Changes

**Owner:** work-prod  
**Rule:** MUST update `backend/openapi.yaml` in same PR as API changes

### PR-2: Code Review Enforcement

**Owner:** work-prod  
**Rule:** API changes without spec updates should be flagged in code review

### PR-3: Client Validation

**Owner:** proj-cli  
**Rule:** Should validate client behavior against spec on major changes

---

## 📊 Compliance Checklist

**For work-prod PRs with API changes:**

- [ ] OpenAPI spec updated with new/changed endpoints
- [ ] Request/response examples included
- [ ] Error responses documented
- [ ] Spec version bumped (if applicable)

**For proj-cli PRs with API integration:**

- [ ] Client behavior matches OpenAPI spec
- [ ] Error handling matches documented responses
- [ ] Discrepancies reported as issues

---

## 🔗 Reference

- **OpenAPI Spec:** `work-prod/backend/openapi.yaml` (691 lines, comprehensive)
- **Spec Version:** OpenAPI 3.0.3
- **API Base URL:** `http://localhost:5000/api`

---

**Last Updated:** 2025-12-23

