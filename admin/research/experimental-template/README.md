# Experimental Template - Research Hub

**Purpose:** Research for experimental template implementation options  
**Status:** ✅ Complete  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12  
**Completed:** 2025-12-12  
**Source:** [Exploration](../../explorations/experimental-template/)

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

- **[Research: User Demand](research-user-demand.md)** - Do users want experimental commands? (✅ Complete)
- **[Research: Implementation Approach](research-implementation-approach.md)** - Separate template vs flag vs addon (✅ Complete)
- **[Research: Stability Communication](research-stability-communication.md)** - How to communicate stability levels (✅ Complete)
- **[Research: Sync Strategy](research-sync-strategy.md)** - Keeping experimental in sync with standard (✅ Complete)
- **[Research: Graduation Path](research-graduation-path.md)** - How commands move to standard (✅ Complete)

---

## 🎯 Research Overview

Investigate options for creating an experimental template that provides access to evolving/bleeding-edge commands not yet stable enough for the standard template.

**Research Topics:** 5 topics  
**Status:** ✅ Complete

**Context:**
- ADR-003 established command tiers (Essential, Valuable, Advanced, Evolving)
- Standard templates should have stable commands only
- Power users may want access to latest features
- Need clear graduation path from experimental → standard

---

## 📊 Research Status

| Research Topic | Priority | Status | Document |
|----------------|----------|--------|----------|
| User Demand | 🔴 High | ✅ Complete | [research-user-demand.md](research-user-demand.md) |
| Implementation Approach | 🔴 High | ✅ Complete | [research-implementation-approach.md](research-implementation-approach.md) |
| Stability Communication | 🟡 Medium | ✅ Complete | [research-stability-communication.md](research-stability-communication.md) |
| Sync Strategy | 🟡 Medium | ✅ Complete | [research-sync-strategy.md](research-sync-strategy.md) |
| Graduation Path | 🟡 Medium | ✅ Complete | [research-graduation-path.md](research-graduation-path.md) |

---

## 🚀 Next Steps

1. Complete research documents for each topic
2. Review requirements in `requirements.md`
3. Use `/decision experimental-template --from-research` to make decisions

---

## 🔗 Related

- **Exploration:** [admin/explorations/experimental-template/](../../explorations/experimental-template/)
- **ADR-003:** Command Tiers (Essential, Valuable, Advanced, Evolving)
- **Template Architecture Exploration:** [admin/explorations/template-architecture/](../../explorations/template-architecture/)

---

**Last Updated:** 2025-12-12

