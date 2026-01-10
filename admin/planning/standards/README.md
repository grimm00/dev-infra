# Standards Hub

**Purpose:** Central hub for cross-arm standards  
**Status:** ✅ Active  
**Last Updated:** 2025-12-31

---

## 📋 Active Standards

| Standard | Type | Status | Description |
|----------|------|--------|-------------|
| [OpenAPI Source of Truth](openapi-source-of-truth/README.md) | Process | ✅ Active | API spec as single source of truth |
| [Command Distribution](command-distribution/README.md) | Process | ✅ Active | Command ownership and distribution |

---

## 🎯 Standards Overview

Standards document cross-arm coordination patterns and process requirements for the Four-Arm Architecture. Each standard follows a consistent structure:

- **README.md** - Standard overview and ownership matrix
- **Process Requirements** - Rules for spec owners and consumers
- **Compliance Checklist** - PR review items

### Standard Types

| Type | Purpose | Example |
|------|---------|---------|
| **Process** | Defines how teams coordinate | OpenAPI Source of Truth |
| **Technical** | Defines implementation patterns | (Future) |

---

## 🏗️ Creating New Standards

When creating a new standard:

1. Create directory: `admin/planning/standards/[standard-name]/`
2. Create README.md with:
   - Purpose and overview
   - Ownership matrix
   - Process requirements
   - Compliance checklist
3. Link from this hub
4. Reference from relevant ADRs

**Template:** See existing standards for structure examples.

---

## 🔗 Related

- **[ADR Index](../../decisions/README.md)** - Architecture decision records
- **[Four-Arm Architecture ADRs](../../decisions/four-arm-architecture/)** - Cross-arm decisions
- **[Research Hub](../../research/README.md)** - Research documents

---

**Last Updated:** 2025-12-31

