# Template Doc Infrastructure - Research Hub

**Purpose:** Research for template-based documentation infrastructure  
**Status:** 🟡 Research (High-Priority Complete)  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings ⭐
- **[Requirements](requirements.md)** - 14 FRs, 8 NFRs, 6 Constraints discovered

### Research Documents

| Priority | Topic | Document | Status |
|----------|-------|----------|--------|
| 🔴 High | Template Inventory & Structure | [research-template-inventory.md](research-template-inventory.md) | ✅ Complete |
| 🔴 High | Generation Script Architecture | [research-generation-architecture.md](research-generation-architecture.md) | ✅ Complete |
| 🟡 Medium | Validation Approach | [research-validation-approach.md](research-validation-approach.md) | 🔴 Not Started |
| 🟡 Medium | Command Integration | [research-command-integration.md](research-command-integration.md) | 🔴 Not Started |
| 🟢 Low | Template Format | [research-template-format.md](research-template-format.md) | 🔴 Not Started |

---

## 🎯 Research Overview

This research addresses how to build template-based documentation infrastructure that ensures consistent doc structure across all workflows (`/explore`, `/research`, `/decision`, `/handoff`, `/task-phase`, `/fix`).

**Key Questions:**
1. ✅ What doc types need templates and what structure should each have?
2. ✅ How should generation scripts be structured?
3. How should validation work?
4. How do templates integrate with existing commands?
5. What format should templates use?

**Research Topics:** 5 topics  
**High Priority Complete:** 2/2 topics ✅  
**Status:** 🟡 Research (ready for decision phase)

---

## 📊 Research Status

### High Priority (Complete) ✅

| Research Topic | Status | Key Finding |
|----------------|--------|-------------|
| Template Inventory & Structure | ✅ Complete | 17 doc types, 5 common patterns |
| Generation Script Architecture | ✅ Complete | Shared library + sed-based templates |

### Medium Priority (Not Started)

| Research Topic | Status | Key Finding |
|----------------|--------|-------------|
| Validation Approach | 🔴 Not Started | - |
| Command Integration | 🔴 Not Started | - |

### Low Priority (Not Started)

| Research Topic | Status | Key Finding |
|----------------|--------|-------------|
| Template Format | 🔴 Not Started | - |

---

## 💡 Key Findings

### From Topic 1: Template Inventory

- **17 doc types** identified across 6 workflows
- **5 common patterns** should be standardized (status header, quick links, status tables, next steps, related links)
- **Hub-and-spoke** is the universal organization pattern
- **Two-mode generation** (scaffolding + expansion) is the emerging standard

### From Topic 2: Generation Architecture

- **Shared library pattern** recommended (DRY, maintainable)
- **Template files** stored separately from scripts
- **sed-based variable expansion** (simple, no dependencies)
- **Hybrid integration** - scripts generate base, AI customizes
- **Validation as important as generation**

---

## 🔗 Related

- **[Exploration](../../explorations/template-doc-infrastructure/README.md)** - Source exploration
- **[Handoff Command Exploration](../../explorations/handoff-command/README.md)** - Related exploration (will use template infrastructure)

---

## 🚀 Next Steps

1. ✅ ~~Conduct research on high-priority topics (Topics 1-2)~~
2. Review [research-summary.md](research-summary.md) and [requirements.md](requirements.md)
3. Use `/decision template-doc-infrastructure --from-research` to make decisions
4. Decisions will create ADR documents for template architecture

**Note:** Medium and low-priority topics (3-5) can be researched during implementation if needed. High-priority findings are sufficient for architectural decisions.

---

**Last Updated:** 2026-01-13
