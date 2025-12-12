# Dev-Infra Identity & Focus - Decisions Hub

**Purpose:** Architecture decisions for dev-infra identity and focus  
**Status:** 🟡 Proposed  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 📋 Quick Links

- **[Transition Plan](transition-plan.md)** - Implementation plan for all decisions ⭐ **NEW**
- **[Decisions Summary](decisions-summary.md)** - Summary of all decisions
- **[Research Hub](../../research/dev-infra-identity-and-focus/README.md)** - Related research
- **[Requirements](../../research/dev-infra-identity-and-focus/requirements.md)** - 16 FRs, 14 NFRs

### ADR Documents

| ADR | Decision | Status |
|-----|----------|--------|
| [ADR-001](adr-001-project-identity.md) | Dev-infra should be a template factory | ✅ Accepted |
| [ADR-002](adr-002-release-automation-v2-scope.md) | v1.5.0: Internal tooling only | ✅ Accepted |
| [ADR-003](adr-003-command-strategy.md) | Tiered command approach for templates | ✅ Accepted |
| [ADR-004](adr-004-graduation-process.md) | Formal graduation criteria | ✅ Accepted |

---

## 🎯 Decisions Overview

These decisions address the fundamental question: **What should dev-infra be?**

The research revealed that dev-infra has been trying to serve multiple purposes:
1. **Laboratory** - Experimenting with workflow ideas
2. **Factory** - Producing templates for projects
3. **Reference Implementation** - Dogfooding what we build

This creates complexity and confusion. The decisions below resolve this by establishing a clear identity and governance model.

**Decision Points:** 4 decisions  
**Status:** ✅ Accepted

---

## 📊 Decision Status

| Decision | Description | Status | Impact |
|----------|-------------|--------|--------|
| Project Identity | Template factory focus | 🟡 Proposed | Foundational |
| v1.5.0 Scope | Internal tooling only | 🟡 Proposed | Immediate |
| Command Strategy | Tiered approach | 🟡 Proposed | Near-term |
| Graduation Process | Formal criteria | 🟡 Proposed | Process |

---

## 🔗 Related

- **Exploration:** [admin/explorations/dev-infra-identity-and-focus/](../../explorations/dev-infra-identity-and-focus/)
- **Research:** [admin/research/dev-infra-identity-and-focus/](../../research/dev-infra-identity-and-focus/)

---

## 🚀 Next Steps

1. ✅ ~~Review ADR documents~~
2. Approve decisions (mark as Accepted)
3. Follow [Transition Plan](transition-plan.md) to implement:
   - Rescope Release Automation v2
   - Update Cursor rules
   - Add metadata to commands
   - Create graduation checklist

---

**Last Updated:** 2025-12-11

