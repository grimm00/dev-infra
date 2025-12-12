# Experimental Template - Research Hub

**Purpose:** Research for experimental template implementation options  
**Status:** 🟡 Research  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12  
**Source:** [Exploration](../../explorations/experimental-template/)

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

- **[Research: User Demand](research-user-demand.md)** - Do users want experimental commands? (🔴 High)
- **[Research: Implementation Approach](research-implementation-approach.md)** - Separate template vs flag vs addon (🔴 High)
- **[Research: Stability Communication](research-stability-communication.md)** - How to communicate stability levels (🟡 Medium)
- **[Research: Sync Strategy](research-sync-strategy.md)** - Keeping experimental in sync with standard (🟡 Medium)
- **[Research: Graduation Path](research-graduation-path.md)** - How commands move to standard (🟡 Medium)

---

## 🎯 Research Overview

Investigate options for creating an experimental template that provides access to evolving/bleeding-edge commands not yet stable enough for the standard template.

**Research Topics:** 5 topics  
**Status:** 🟡 Research

**Context:**
- ADR-003 established command tiers (Essential, Valuable, Advanced, Evolving)
- Standard templates should have stable commands only
- Power users may want access to latest features
- Need clear graduation path from experimental → standard

---

## 📊 Research Status

| Research Topic | Priority | Status | Document |
|----------------|----------|--------|----------|
| User Demand | 🔴 High | 🔴 Not Started | [research-user-demand.md](research-user-demand.md) |
| Implementation Approach | 🔴 High | 🔴 Not Started | [research-implementation-approach.md](research-implementation-approach.md) |
| Stability Communication | 🟡 Medium | 🔴 Not Started | [research-stability-communication.md](research-stability-communication.md) |
| Sync Strategy | 🟡 Medium | 🔴 Not Started | [research-sync-strategy.md](research-sync-strategy.md) |
| Graduation Path | 🟡 Medium | 🔴 Not Started | [research-graduation-path.md](research-graduation-path.md) |

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

