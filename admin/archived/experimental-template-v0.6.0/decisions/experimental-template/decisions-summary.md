# Decisions Summary - Experimental Template

**Purpose:** Summary of all decisions made  
**Status:** 🟡 Proposed  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12

---

## 📋 Decisions Overview

Decisions regarding the creation and implementation of an experimental template that exposes Evolving tier commands to template users.

**Decision Points:** 2 decisions  
**Status:** 🟡 Proposed

---

## 🎯 Key Decisions

### Decision 1: Create Experimental Template

**Decision:** Create an experimental template (`experimental-project/`) that includes Evolving tier commands.

**Rationale:**
- Team projects specifically want access to experimental commands
- ~15% user segment wants experimental features
- Template factory identity supports multiple template products
- Early feedback improves command quality before graduation

**Status:** 🟡 Proposed

**ADR:** [adr-001-experimental-template-creation.md](adr-001-experimental-template-creation.md)

---

### Decision 2: Use Separate Template Approach

**Decision:** Implement as a separate template directory (`templates/experimental-project/`) with CI drift detection for shared files.

**Rationale:**
- Aligns with existing multi-template pattern
- Minimal generator script changes required
- Clear user experience (explicit template choice)
- Sync challenge manageable with CI automation

**Status:** 🟡 Proposed

**ADR:** [adr-002-implementation-approach.md](adr-002-implementation-approach.md)

---

## 📋 Requirements Impact

These decisions address the following requirements:

| Requirement | Status | Notes |
|-------------|--------|-------|
| FR-1: Template Generation | ✅ Addressed | New template directory |
| FR-2: Generator Script Update | ✅ Addressed | Add template type option |
| FR-4: CI Drift Detection | ✅ Addressed | Validate shared file sync |
| NFR-1: Maintainability | ✅ Addressed | CI-assisted sync |
| NFR-2: User Experience | ✅ Addressed | Clear template choice |
| NFR-3: Explicit Opt-In | ✅ Addressed | Separate template = explicit |
| NFR-4: Cross-Platform | ✅ Addressed | No symlinks |

**See:** [requirements.md](../../research/experimental-template/requirements.md) for complete requirements

---

## 📊 Implementation Phases

Based on research recommendations:

| Phase | Focus | Priority | Effort |
|-------|-------|----------|--------|
| 1 | Create experimental template directory | High | Medium |
| 2 | Update generator script | High | Low |
| 3 | Add CI drift detection | Medium | Low |
| 4 | Add stability indicators | Medium | Low |
| 5 | Create graduation checklist | Low | Low |

---

## 🚀 Next Steps

1. ✅ Decisions documented
2. Review and approve ADRs
3. Use `/transition-plan --from-adr adr-001-experimental-template-creation.md` to create feature plan
4. Implementation follows transition plan

---

## 🔗 Related

- **Research:** [admin/research/experimental-template/](../../research/experimental-template/)
- **Exploration:** [admin/explorations/experimental-template/](../../explorations/experimental-template/)
- **Requirements:** [requirements.md](../../research/experimental-template/requirements.md)

---

**Last Updated:** 2025-12-12

