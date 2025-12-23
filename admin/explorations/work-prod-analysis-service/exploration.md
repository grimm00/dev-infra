# Work-Prod Analysis Service - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 What Are We Exploring?

Moving project analysis capabilities from proj-cli to work-prod, creating a dedicated analysis service that can:

1. Analyze project tech stacks and dependencies
2. Provide health metrics and portfolio insights
3. Support future dashboard/visualization needs
4. Scale analysis independently of CLI releases

---

## 🤔 Why Explore This?

### Current Pain Points

1. **Wrong Location:** Analysis logic in CLI client, but data lives in work-prod
2. **Limited Scope:** Current `proj inv analyze` is basic (~60 lines, just marker detection)
3. **Growing Complexity:** Real analysis needs dependency trees, security scans, metrics
4. **CLI Bloat:** Adding analysis features bloats proj-cli unnecessarily

### Benefits of Separation

1. **Data Locality:** Analysis runs where the data already exists
2. **Independent Evolution:** work-prod can add analysis features without CLI releases
3. **Rich Capabilities:** Backend can do heavy analysis (security, dependencies, metrics)
4. **Dashboard Ready:** Frontend can display analysis results
5. **proj-cli Stays Light:** CLI does discovery + export, nothing more

---

## 💡 Initial Thoughts

### Proposed Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        proj-cli                                  │
│              (Discovery & Export Only)                           │
│                                                                  │
│  proj inv scan github     → Discover GitHub repos               │
│  proj inv scan local      → Discover local projects             │
│  proj inv dedupe          → Clean up inventory                  │
│  proj inv status          → Show inventory stats                │
│  proj inv export api      → Push to work-prod                   │
│                                                                  │
│  ❌ NO ANALYSIS - removed entirely                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ export api (project data)
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        work-prod                                 │
│                   (Data + Analysis Service)                      │
│                                                                  │
│  Storage:                                                        │
│    POST /api/projects/import  ← Receives inventory data         │
│    GET  /api/projects/*       ← Project CRUD                    │
│                                                                  │
│  Analysis (NEW):                                                │
│    POST /api/analysis/trigger/{id}  ← Trigger analysis          │
│    GET  /api/analysis/{id}          ← Get analysis results      │
│    GET  /api/analysis/portfolio     ← Portfolio-wide analysis   │
│    GET  /api/analysis/health/{id}   ← Project health metrics    │
│                                                                  │
│  Analysis Capabilities:                                         │
│    • Tech stack detection (languages, frameworks)               │
│    • Dependency analysis (from package.json, pyproject.toml)    │
│    • Security vulnerability scanning (future)                   │
│    • Code complexity metrics (future)                           │
│    • Activity/staleness indicators                              │
│    • Cross-project dependency mapping                           │
└─────────────────────────────────────────────────────────────────┘
```

### Analysis Data Model

```python
# New tables/models in work-prod

class ProjectAnalysis(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    project_id = db.Column(db.Integer, db.ForeignKey('project.id'))
    
    # Tech stack
    languages = db.Column(db.JSON)      # ["Python", "JavaScript"]
    frameworks = db.Column(db.JSON)     # ["Flask", "React"]
    
    # Dependencies
    dependencies = db.Column(db.JSON)   # {package: version}
    dev_dependencies = db.Column(db.JSON)
    
    # Metrics
    health_score = db.Column(db.Float)  # 0-100
    staleness_days = db.Column(db.Integer)
    
    # Timestamps
    analyzed_at = db.Column(db.DateTime)
    analysis_version = db.Column(db.String(20))
```

### What to Remove from proj-cli

```python
# REMOVE: proj inv analyze command entirely

# Before (in proj-cli/src/proj/commands/inventory.py):
@inv_app.command(name="analyze")
def analyze():
    """Analyze tech stack of inventory projects."""
    # ~60 lines of basic marker detection

# After:
# Command deleted - analysis handled by work-prod
```

### Migration Path

1. **Phase 1:** Build analysis endpoints in work-prod
2. **Phase 2:** Deprecate `proj inv analyze` with message pointing to work-prod
3. **Phase 3:** Remove `proj inv analyze` from proj-cli

---

## 🔍 Key Questions

- [ ] **Q1:** What analysis capabilities should work-prod provide initially?
- [ ] **Q2:** How should analysis be triggered (on-demand vs automatic)?
- [ ] **Q3:** Should analysis require local file access or work from metadata only?
- [ ] **Q4:** How to handle projects without local paths (GitHub-only)?
- [ ] **Q5:** What portfolio-level analysis makes sense?
- [ ] **Q6:** Should there be a frontend dashboard for analysis results?

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research work-prod-analysis-service --from-explore work-prod-analysis-service` to conduct research
3. After research, use `/decision work-prod-analysis-service --from-research` to make decisions

---

## 📝 Notes

**User Insight (2025-12-22):**
> "I feel like its inventory management should be separated from analysis, and maybe an app that does analysis can be an arm of work-prod as opposed to trying to integrate it here (it's already showing that it needs a lot more work)."

This confirms:
- Analysis complexity is growing beyond CLI scope
- work-prod is the natural home for analysis
- proj-cli should focus on discovery and data transport

**Current `proj inv analyze` Limitations:**
- Only detects by file markers (package.json → React)
- No dependency tree analysis
- No security scanning
- No health metrics
- No cross-project analysis

---

**Last Updated:** 2025-12-22

