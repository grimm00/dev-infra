# Project Model Definition - Decisions Hub

**Purpose:** Architecture decisions for the unified project model  
**Status:** ✅ Accepted  
**Created:** 2025-12-23  
**Last Updated:** 2025-12-23

---

## 📋 Quick Links

- **[Decisions Summary](decisions-summary.md)** - Summary of all decisions
- **[Research Hub](../../research/project-model-definition/README.md)** - Related research
- **[Requirements](../../research/project-model-definition/requirements.md)** - Requirements document

### ADR Documents

**Tier 1 (API Contract):**
- **[ADR-001: Tier 1 API Contract Validation](adr-001-tier-1-api-validation.md)** - Validate Tier 1 integration readiness
- **[ADR-002: OpenAPI as Single Source of Truth](adr-002-openapi-source-of-truth.md)** - API contract documentation standard

**Tier 2 (Classification):**
- **[ADR-003: Add project_type Field](adr-003-add-project-type-field.md)** - Add new field for project type classification
- **[ADR-004: Keep classification Field](adr-004-keep-classification-field.md)** - Maintain existing field for priority

---

## 🎯 Decisions Overview

Decisions documenting the unified project model across the four-arm architecture, covering API contracts, classification, and ownership.

**Decision Points:** 4 decisions  
**Status:** ✅ Accepted

---

## 📊 Decision Status

| Decision | Owner | Status | ADR |
|----------|-------|--------|-----|
| Tier 1 API Contract Validation | work-prod, proj-cli | ✅ Accepted | [adr-001](adr-001-tier-1-api-validation.md) |
| OpenAPI as Single Source of Truth | work-prod, proj-cli, dev-infra | ✅ Accepted | [adr-002](adr-002-openapi-source-of-truth.md) |
| Add project_type Field | work-prod | ✅ Accepted | [adr-003](adr-003-add-project-type-field.md) |
| Keep classification Field | work-prod | ✅ Accepted | [adr-004](adr-004-keep-classification-field.md) |

---

## 🏢 Ownership Summary

| Arm | Role | Responsibilities |
|-----|------|------------------|
| **work-prod** | Schema Owner | Schema changes, migrations, API updates |
| **proj-cli** | API Consumer | Client updates, filtering support |
| **dev-infra** | Standards | Documents decisions, maintains ADRs |

---

## 🚀 Next Steps

1. ✅ ADR-001 and ADR-002 accepted (Tier 1)
2. ✅ ADR-003 and ADR-004 accepted (Tier 2 - Classification)
3. Continue with Learning Taxonomy decisions (Tier 3)
4. Use `/transition-plan --from-adr` to transition to implementation planning

---

**Last Updated:** 2025-12-23

