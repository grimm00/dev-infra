# Work-prod Integration - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-19

---

## 🎯 What Are We Exploring?

How dev-infra can integrate with work-prod API and maintain its own project registry for tracking dev-infra managed projects.

### Two Components

1. **Work-prod API Integration**
   - Register projects with work-prod using standard project model
   - Authenticate as dev-infra "account" (not custom field)
   - Query and manage projects via API

2. **Local Data Store**
   - Central registry of ALL dev-infra managed projects
   - Complement to per-project `.dev-infra.yml` metadata
   - Enable: list all projects, bulk sync, status dashboard

---

## 🤔 Why Explore This?

### Problems to Solve

1. **No central view** - Currently no way to see all dev-infra projects at once
2. **Per-project only** - `.dev-infra.yml` is local to each repo
3. **No cross-machine visibility** - Projects on one machine invisible to others
4. **Manual tracking** - Must remember where projects are

### Opportunities

1. **Unified project list** - `dev-infra list` shows all managed projects
2. **Cloud backup** - Work-prod API provides remote registry
3. **Sync enablement** - Know which projects need updates
4. **Dashboard potential** - Project status across all projects

---

## 💡 Initial Thoughts

### Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                        User                              │
└─────────────────────────┬───────────────────────────────┘
                          │
                          │ Creates and Manages Projects with
                          ▼
┌─────────────────────────────────────────────────────────┐
│                   Dev-Infra CLI                          │
│                                                          │
│  • Creates Project From Templates with optional Git init │
│  • Syncs Existing Dev-Infra Projects with newest        │
│    settings/guides                                       │
│  • Provides standardization for non-Dev-Infra Projects  │
└─────────────────────────┬───────────────────────────────┘
            │             │             │
            │             │             │
    Uploads │     Keeps   │    Reads/   │
   projects │    Track of │    Writes   │
         to │   Projects  │             │
            │      with   │             │
            ▼             ▼             ▼
    ┌───────────┐  ┌─────────────┐  ┌───────────────┐
    │ GitHub    │  │ Work-prod   │  │ Local         │
    │ CLI       │  │ API         │  │ Registry      │
    │           │  │             │  │               │
    │ Creates   │  │ • API key   │  │ ~/.dev-infra/ │
    │ GitHub    │  │ • Project   │  │ registry.json │
    │ Repo      │  │   tracking  │  │               │
    └───────────┘  └─────────────┘  └───────────────┘
```

### Work-prod Integration Insight

**Original thought:** Ask work-prod to add a "dev-infra" field to filter projects.

**Better approach:** Authenticate to work-prod as a dev-infra "account" and use standard project fields. This way:
- No changes needed to work-prod schema
- Dev-infra manages its own projects like any other user
- Projects are visible in work-prod ecosystem
- Standard API, standard fields

### Local Registry Concept

The local registry complements per-project metadata:

| Layer | Location | Purpose |
|-------|----------|---------|
| Per-project | `.dev-infra.yml` | Template type, version, sync rules |
| Local central | `~/.dev-infra/registry.json` | Index of all projects on this machine |
| Remote | work-prod API | Cloud registry, cross-machine sync |

### Storage Format Candidates

| Format | Pros | Cons |
|--------|------|------|
| JSON | Simple, human-readable, no deps | No querying, grows unwieldy |
| SQLite | Queryable, single file, mature | Requires sqlite3 binary |
| CSV | Human-readable, spreadsheet compat | Limited structure |
| YAML | Human-editable, comments | Needs yq for parsing |

**Likely choice:** JSON for simplicity, or SQLite if querying becomes important.

---

## 🔍 Key Questions

- [ ] Question 1: How does work-prod API authentication work? API key? OAuth?
- [ ] Question 2: What's work-prod's project model? What fields are available?
- [ ] Question 3: What storage format for local registry? JSON vs SQLite?
- [ ] Question 4: Where should local registry live? `~/.dev-infra/`?
- [ ] Question 5: How should local and work-prod registries sync?
- [ ] Question 6: How to handle offline scenarios (work-prod unavailable)?

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research work-prod-integration --from-explore work-prod-integration` to conduct research
3. After research, use `/decision work-prod-integration --from-research` to make decisions

---

## 📝 Notes

### Relationship to Other Work

- **Template Metadata Research** - Defines `.dev-infra.yml` (per-project)
- **Dev-Infra Identity Exploration** - Defines the four scenarios this supports
- **This Exploration** - Defines central tracking (local + remote)

### Out of Scope (for now)

- Actual work-prod API implementation
- Full CLI design for `dev-infra` command
- Multi-user scenarios (still single user for now)

### Open Questions for Work-prod Team

If pursuing work-prod integration:
1. Can we have a dedicated "dev-infra" account?
2. What's the project registration workflow?
3. Is there a batch API for syncing multiple projects?

---

**Last Updated:** 2025-12-19

