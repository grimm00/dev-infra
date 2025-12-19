# Research Topics - Work-prod Integration

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-19

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions about work-prod API integration and local registry.

---

### Research Topic 1: Work-prod Auth Model

**Question:** How does work-prod API authentication work? Can dev-infra have its own "account"?

**Sub-questions:**
- What authentication mechanisms does work-prod support? (API key, OAuth, etc.)
- Can we create a dedicated "dev-infra" account/identity?
- How are API credentials stored and managed?
- Is there a service account pattern?

**Why:** Need to understand how dev-infra will authenticate before designing integration.

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 2: Work-prod Project Model

**Question:** What fields does work-prod use for projects? How do we map dev-infra projects?

**Sub-questions:**
- What's the work-prod project data model/schema?
- Which fields are required vs optional?
- How do we map dev-infra metadata to work-prod fields?
- Can we store custom metadata (template type, version)?

**Why:** Need to understand work-prod's project model to design registration workflow.

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 3: Local Registry Format

**Question:** What storage format for local registry? JSON vs SQLite vs other?

**Sub-questions:**
- What operations do we need? (list, filter, search, update)
- How many projects will realistically be tracked? (10s? 100s?)
- Do we need complex queries or just simple lookups?
- What dependencies are acceptable?

**Why:** Storage format affects implementation complexity and capabilities.

**Priority:** 🔴 High

**Status:** 🔴 Not Started

---

### Research Topic 4: Sync Strategy

**Question:** How should local registry sync with work-prod? Push on create? Periodic? Manual?

**Sub-questions:**
- When should projects be registered with work-prod? (on create, on push, manually)
- How to handle conflicts between local and remote?
- Should sync be automatic or explicit?
- What's the source of truth? (local, remote, or per-project `.dev-infra.yml`)

**Why:** Sync strategy affects UX and reliability of the tracking system.

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 5: Offline Support

**Question:** How to handle projects when work-prod is unavailable?

**Sub-questions:**
- Can all operations work offline with local registry only?
- How to queue work-prod registrations for later sync?
- What's the degradation strategy when API is unavailable?
- Should work-prod integration be optional?

**Why:** Dev-infra must work without network; work-prod is enhancement not requirement.

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 6: Multi-machine Sync

**Question:** How to sync local registries across machines via work-prod?

**Sub-questions:**
- Can work-prod serve as source of truth for project list?
- How to handle projects that exist on one machine but not another?
- Should `dev-infra list` show all work-prod projects or just local?
- Is there a "clone from work-prod" workflow?

**Why:** One of the main benefits of work-prod integration is cross-machine visibility.

**Priority:** 🟢 Low

**Status:** 🔴 Not Started

---

## 📊 Research Priority Summary

| Priority | Topics |
|----------|--------|
| 🔴 High | Work-prod Auth Model, Work-prod Project Model, Local Registry Format |
| 🟡 Medium | Sync Strategy, Offline Support |
| 🟢 Low | Multi-machine Sync |

---

## 🎯 Research Workflow

1. Use `/research work-prod-integration --from-explore work-prod-integration` to conduct research
2. Research will create documents in `admin/research/work-prod-integration/`
3. After research complete, use `/decision work-prod-integration --from-research` to make decisions

---

## 🔗 Related

- [Template Metadata Research](../../research/template-metadata/README.md) - Per-project metadata
- [Dev-Infra Identity Exploration](../dev-infra-identity-and-focus/exploration.md) - Four scenarios context

---

**Last Updated:** 2025-12-19

