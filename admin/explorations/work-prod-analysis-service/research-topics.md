# Research Topics - Work-Prod Analysis Service

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions about the work-prod analysis service.

---

### Research Topic 1: Initial Analysis Capabilities

**Question:** What analysis capabilities should work-prod provide in the initial release?

**Why:** Need to scope the MVP - can't build everything at once.

**Priority:** High

**Status:** 🔴 Not Started

**Sub-questions:**
- Which capabilities provide the most value with least effort?
- What does the current `proj inv analyze` do that must be preserved?
- What new capabilities are most requested?

**Candidate Capabilities:**
1. Tech stack detection (languages, frameworks)
2. Dependency listing (from manifest files)
3. Activity/staleness metrics (last commit date)
4. Repository size and file counts
5. README presence and quality

---

### Research Topic 2: Analysis Trigger Model

**Question:** How should analysis be triggered - on-demand, automatic, or scheduled?

**Why:** Affects API design, resource usage, and user experience.

**Priority:** High

**Status:** 🔴 Not Started

**Options:**
1. **On-demand:** User explicitly triggers `POST /api/analysis/trigger/{id}`
2. **On-import:** Analysis runs automatically when project is imported
3. **Scheduled:** Background job analyzes projects periodically
4. **Hybrid:** Automatic on import, manual re-analysis available

**Considerations:**
- Analysis may be slow (network calls, file parsing)
- Some projects may not need analysis
- Fresh data vs. resource usage tradeoff

---

### Research Topic 3: Data Access Requirements

**Question:** Should analysis require local file access or work from metadata only?

**Why:** Determines what analysis is possible and where it can run.

**Priority:** High

**Status:** 🔴 Not Started

**Options:**
1. **Local files required:** proj-cli sends file contents/manifests
2. **GitHub API:** work-prod fetches from GitHub directly
3. **Metadata only:** Work from project metadata (URLs, descriptions)
4. **Hybrid:** Use GitHub API when available, metadata otherwise

**Trade-offs:**
- Local files: Rich analysis, but proj-cli must extract data
- GitHub API: Server-side analysis, but rate limits apply
- Metadata only: Limited analysis, but always available

---

### Research Topic 4: Portfolio Analysis

**Question:** What portfolio-level analysis makes sense across all projects?

**Why:** Cross-project insights are valuable but complex to implement.

**Priority:** Medium

**Status:** 🔴 Not Started

**Candidate Features:**
1. Language distribution (pie chart: 40% Python, 30% JS, etc.)
2. Framework usage (how many React vs Vue projects)
3. Dependency overlap (shared dependencies across projects)
4. Staleness overview (which projects need attention)
5. Tech debt indicators (outdated dependencies)

---

### Research Topic 5: Frontend Dashboard

**Question:** Should there be a frontend dashboard for analysis results?

**Why:** Visual presentation may provide more value than CLI output.

**Priority:** Low

**Status:** 🔴 Not Started

**Considerations:**
- work-prod already has a frontend (React)
- Dashboard could show portfolio health at a glance
- Charts and visualizations for analysis data
- May be separate feature/phase

---

### Research Topic 6: API Design

**Question:** What should the analysis API endpoints look like?

**Why:** Good API design enables future extensions and client flexibility.

**Priority:** Medium

**Status:** 🔴 Not Started

**Proposed Endpoints:**
```
POST /api/analysis/trigger/{project_id}  - Trigger analysis
GET  /api/analysis/{project_id}          - Get analysis results
GET  /api/analysis/portfolio             - Portfolio-wide analysis
GET  /api/analysis/health/{project_id}   - Health metrics only
```

**Questions:**
- Should analysis be a sub-resource of projects?
- How to handle async analysis (background jobs)?
- Pagination for portfolio analysis?

---

## 📊 Priority Matrix

| Topic | Priority | Complexity | Dependencies |
|-------|----------|------------|--------------|
| Initial Analysis Capabilities | High | Medium | None |
| Analysis Trigger Model | High | Low | None |
| Data Access Requirements | High | High | Trigger Model |
| Portfolio Analysis | Medium | Medium | Initial Capabilities |
| Frontend Dashboard | Low | High | API Design |
| API Design | Medium | Low | Trigger Model |

**Recommended Research Order:**
1. Initial Analysis Capabilities (scope the MVP)
2. Analysis Trigger Model (affects architecture)
3. Data Access Requirements (determines what's possible)
4. API Design (enables implementation)
5. Portfolio Analysis (extension of initial capabilities)
6. Frontend Dashboard (future phase)

---

## 🎯 Research Workflow

1. Use `/research work-prod-analysis-service --from-explore work-prod-analysis-service` to conduct research
2. Research will create documents in `admin/research/work-prod-analysis-service/`
3. After research complete, use `/decision work-prod-analysis-service --from-research` to make decisions

---

## 🔗 Related Research

- **[Four-Arm Architecture](../four-arm-architecture/README.md)** - Ecosystem context
- **[proj-cli Focused Role](../proj-cli-focused-role/README.md)** - proj-cli scope
- **[Work-prod API](../../../work-prod/docs/maintainers/)** - Current work-prod structure

---

**Last Updated:** 2025-12-22

