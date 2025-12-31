# Research Summary - Explore Two-Mode Enhancement

**Purpose:** Summary of all research findings  
**Status:** 🔴 Research  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-30

---

## 📋 Research Overview

Research for enhancing the `/explore` command with:
1. Two-mode pattern (Setup + Conduct)
2. Explicit input sources (`start.txt`, reflections, etc.)
3. Topic unification (`--topic [name] --type`)
4. Command improvement organization

**Research Topics:** 6 topics  
**Research Documents:** 6 documents  
**Status:** 🔴 Research

---

## 📊 Research Progress

| # | Topic | Priority | Status |
|---|-------|----------|--------|
| 1 | Command Improvement Organization | 🔴 High | ✅ Complete |
| 2 | Topic Unification Pattern | 🔴 High | 🔴 Not Started |
| 3 | Explore Input Sources | 🔴 High | 🔴 Not Started |
| 4 | Scaffolding Boundaries | 🟡 Medium | 🔴 Not Started |
| 5 | Existing Feature Integration | 🟡 Medium | 🔴 Not Started |
| 6 | Cross-Command Consistency | 🟡 Medium | 🔴 Not Started |

---

## 🔍 Key Findings

### Finding 1: Command Improvements ARE Features (Topic 1)

Per ADR-001 "Template Factory" identity, command improvements that affect template users are **template features**, not internal tooling. Commands ship in templates, making their enhancements part of the product.

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

---

### Finding 2: Commands Directory is for Integration, Not Enhancement (Topic 1)

The existing `admin/planning/commands/` directory is specifically for **command integration** (bringing work-prod commands to dev-infra), NOT for **command enhancement**. Enhancement work belongs in `features/`.

**Source:** [research-command-improvement-organization.md](research-command-improvement-organization.md)

---

### Finding 3: [Pending - Topic 2+]

[To be completed with remaining research topics]

---

## 💡 Key Insights

- [x] Insight 1: **Command improvements are template features** per ADR-001 Template Factory identity
- [x] Insight 2: **Commands directory is for integration, not enhancement** - different purpose
- [x] Insight 3: **Current features structure works** - `transition-plan-two-mode` success validates approach
- [x] Insight 4: **Consolidation reduces duplication** - 4 similar features would benefit from shared structure
- [ ] Insight 5: [Pending - Topic 2+]

---

## 📋 Requirements Summary

**From Topic 1 (Command Improvement Organization):**
- FR-ORG-1: Command improvements MUST be tracked as features (not CI)
- FR-ORG-2: Consolidated hub SHOULD reference related completed features
- NFR-ORG-1: Directory structure MUST align with ADR-001 Template Factory identity

**See:** [requirements.md](requirements.md) for complete requirements document

---

## 🎯 Recommendations

**From Topic 1 (Command Improvement Organization):**
- [x] Recommendation 1: Keep command improvements in `features/` - they're template features per ADR-001
- [x] Recommendation 2: Create consolidated hub `features/command-two-mode-pattern/` to group related work
- [x] Recommendation 3: Preserve completed work where it is, reference from consolidated hub
- [ ] Recommendation 4: [Pending - Topic 2+]

---

## 🚀 Next Steps

1. Conduct research for each topic using `/research explore-two-mode --conduct`
2. Review requirements in `requirements.md`
3. Use `/decision explore-two-mode --from-research` to make decisions
4. Decisions will create ADR documents

---

**Last Updated:** 2025-12-30

