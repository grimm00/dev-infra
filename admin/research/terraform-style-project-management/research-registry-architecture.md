# Research: Registry Architecture

**Research Topic:** Terraform-Style Project Management  
**Question:** How should dev-infra track which projects it manages?  
**Status:** ✅ Complete  
**Priority:** High  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22  
**Completed:** 2025-12-22

---

## 🎯 Research Question

How should dev-infra track which projects it manages? What registry architecture enables push updates and portfolio views?

---

## 🔍 Research Goals

- [x] Goal 1: Evaluate local vs GitHub-based vs hybrid registry approaches
- [x] Goal 2: Research multi-machine synchronization patterns
- [x] Goal 3: Determine integration strategy with work-prod API
- [x] Goal 4: Design metadata schema for registry entries

---

## 📚 Research Methodology

**Sources:**
- [x] Terraform Cloud/Enterprise registry patterns
- [x] Web search: Project portfolio management tools
- [x] Web search: GitHub API for repository discovery
- [x] Work-prod integration research findings

---

## 📊 Findings

### Finding 1: Terraform Uses Explicit Registration

Terraform Cloud requires explicit workspace creation:
- Users explicitly add projects to management
- No automatic discovery
- Clear ownership model

**Source:** Terraform Cloud documentation

**Relevance:** Explicit registration is simpler and clearer than auto-discovery.

---

### Finding 2: GitHub API Can Discover by File Presence

GitHub's code search API can find repos containing specific files:
- Search for `.dev-infra.yml` across user/org repos
- Provides automatic discovery without manual registration

**Source:** GitHub code search API documentation

**Relevance:** Enables discovery-based registry without central database.

---

### Finding 3: Local Registry Enables Fast Operations

Local registry (`~/.dev-infra/registry.json`) provides:
- Fast reads without network
- Works offline
- Simple file-based storage

**Source:** XDG directory patterns, local-first tools

**Relevance:** Fast operations are essential for good CLI UX.

---

### Finding 4: Work-prod Already Has Project Model

Work-prod project management system:
- Already tracks projects with metadata
- Has remote_url field for GitHub repos
- Could serve as central registry

**Source:** Work-prod integration research

**Relevance:** Avoid duplication - work-prod could BE the registry.

---

### Finding 5: Hybrid Approach is Common

Many tools use hybrid:
- Local cache for performance
- Remote sync for portability
- Explicit registration for clarity

**Source:** Package manager and cloud sync patterns

**Relevance:** Combine local performance with remote persistence.

---

## 🔍 Analysis

**Option Comparison:**

| Approach | Pros | Cons |
|----------|------|------|
| Local Only | Fast, simple, offline | Not portable, single machine |
| GitHub Discovery | Automatic, no central DB | Requires API access, rate limits |
| Work-prod Integration | Already exists, rich data | Requires API running |
| Hybrid | Best of both | More complexity |

**Recommended: Hybrid with Work-prod**

1. **Local cache:** `~/.dev-infra/registry.json`
   - Fast operations
   - Works offline
   - Synced from work-prod

2. **Work-prod as source of truth:**
   - Project metadata already stored
   - Add `dev_infra_version` field
   - API already implemented

3. **Sync mechanism:**
   - `proj registry sync` - Pull from work-prod
   - Auto-register on `proj init`
   - Optional: GitHub discovery for unregistered

**Key Insights:**
- [x] Insight 1: Work-prod integration provides existing project tracking
- [x] Insight 2: Local cache needed for offline and performance
- [x] Insight 3: Explicit registration is clearer than auto-discovery for V1
- [x] Insight 4: GitHub discovery can be added later as enhancement

---

## 💡 Recommendations

- [x] Recommendation 1: Use work-prod API as primary registry
- [x] Recommendation 2: Local cache at `~/.dev-infra/registry.json` for performance
- [x] Recommendation 3: `proj init` registers project in work-prod
- [x] Recommendation 4: `proj registry sync` syncs local cache from work-prod
- [x] Recommendation 5: Defer GitHub discovery to V2+

**Registry Schema:**

```json
// ~/.dev-infra/registry.json
{
  "version": "1.0.0",
  "last_sync": "2025-12-22T10:00:00Z",
  "projects": [
    {
      "id": 123,
      "name": "work-prod",
      "path": "/Users/cdwilson/Projects/work-prod",
      "remote_url": "https://github.com/user/work-prod",
      "template": "standard-project",
      "dev_infra_version": "0.8.0",
      "last_sync": "2025-12-22"
    }
  ]
}
```

---

## 📋 Requirements Discovered

- [x] FR-15: Local registry cache at XDG-compliant location
- [x] FR-16: `proj init` registers project in work-prod
- [x] FR-17: `proj registry sync` syncs from work-prod
- [x] FR-18: `proj registry list` shows managed projects
- [x] NFR-5: Registry operations must work offline (read from cache)
- [x] C-3: Requires work-prod API to be running for registration

---

## 🚀 Next Steps

1. ✅ Research complete
2. Proceed to Drift Detection research
3. Implementation requires work-prod API extensions

---

**Last Updated:** 2025-12-22
