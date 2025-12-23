# Four-Arm Architecture - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 What Are We Exploring?

The interconnected ecosystem of four projects that together provide complete developer infrastructure:

1. **dev-infra** - Template factory and pattern source
2. **dev-toolkit** - Bash CLI utilities for daily development
3. **proj-cli** - Python CLI for project lifecycle management
4. **work-prod** - Flask API backend for centralized data

---

## 🤔 Why Explore This?

**Problem:** As these projects have evolved, their boundaries have become unclear:
- Where should global Cursor command installation live?
- How do the projects communicate?
- What does "managed project" mean?
- How should they coordinate in a workspace?

**Opportunity:** Clear architecture enables:
- Better separation of concerns
- Easier maintenance and evolution
- Clear ownership of features
- Coordinated releases

---

## 🏗️ Architecture Overview

### The Four Arms

```
                         ┌─────────────────────────────────────┐
                         │           dev-infra                 │
                         │     (Template Factory)              │
                         │                                     │
                         │  • Project templates                │
                         │  • Cursor AI commands (source)      │
                         │  • Documentation patterns           │
                         │  • Best practices                   │
                         └──────────────┬──────────────────────┘
                                        │
                                        │ generates
                                        ▼
    ┌───────────────────────────────────────────────────────────────────┐
    │                        Generated Projects                          │
    │                     (work-prod, proj-cli, etc.)                   │
    │                                                                    │
    │   Contains:                                                        │
    │   • .dev-infra.yml (state file)                                   │
    │   • .cursor/commands/ (project-level)                             │
    │   • docs/maintainers/ (planning structure)                        │
    └───────────────────────────────────────────────────────────────────┘
                                        │
           ┌────────────────────────────┼────────────────────────────┐
           │                            │                            │
           ▼                            ▼                            ▼
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│    dev-toolkit      │    │      proj-cli       │    │     work-prod       │
│   (Developer CLI)   │    │  (Project Mgmt)     │    │    (Data API)       │
│                     │    │                     │    │                     │
│ • dt-review         │    │ • proj plan         │    │ • Project registry  │
│ • dt-git-safety     │    │ • proj apply        │    │ • REST API          │
│ • dt-config         │    │ • proj init         │    │ • Central data      │
│ • dt-install-hooks  │    │ • proj registry     │    │ • SQLite backend    │
│                     │    │                     │    │                     │
│ Language: Bash      │    │ Language: Python    │    │ Language: Python    │
│ Install: ~/.dev-    │    │ Install: pip        │    │ Deploy: Server      │
│          toolkit/   │    │                     │    │                     │
└─────────┬───────────┘    └──────────┬──────────┘    └──────────┬──────────┘
          │                           │                          │
          │                           │ API calls                │
          │                           └──────────────────────────┘
          │
          │ installs to
          ▼
    ┌─────────────────────┐
    │ ~/.cursor/commands/ │
    │  (Global Commands)  │
    └─────────────────────┘
```

---

## 💡 Initial Thoughts

### Responsibility Matrix

| Concern | Owner | Rationale |
|---------|-------|-----------|
| Template generation | dev-infra | Source of truth for project structure |
| Cursor command source | dev-infra | Commands are part of template patterns |
| Global command installation | dev-toolkit | Already has installation infrastructure |
| Project-level commands | Each project | Copied from dev-infra templates |
| Project state tracking | proj-cli | Terraform-style plan/apply |
| Project registry | work-prod | Central data store |
| Developer utilities | dev-toolkit | Daily CLI tools |

### Data Flow

```
dev-infra (templates) 
    ──generates──▶ new-project/
                       │
                       ├── .dev-infra.yml (state)
                       │       │
                       │       └──read by──▶ proj-cli
                       │                        │
                       │                        └──API calls──▶ work-prod
                       │
                       └── .cursor/commands/ (project-level)

dev-toolkit
    ──installs──▶ ~/.cursor/commands/ (global)
    ──provides──▶ dt-* commands (developer utilities)
```

### Command Ownership Proposal

| Command Category | Owner | Commands |
|------------------|-------|----------|
| **Developer Utilities** | dev-toolkit | `dt-review`, `dt-git-safety`, `dt-config`, `dt-install-hooks` |
| **Global Cursor Commands** | dev-toolkit | `dt-cursor-install` (NEW - installs from dev-infra) |
| **Project Management** | proj-cli | `proj plan`, `proj apply`, `proj init`, `proj registry` |
| **Template Generation** | dev-infra | `new-project.sh`, `validate-templates.sh` |

---

## 🔍 Key Questions

### Command Distribution

- [ ] Should dev-toolkit install Cursor commands from dev-infra?
- [ ] What's the versioning relationship between dev-toolkit and dev-infra commands?
- [ ] How does dev-toolkit know which version of commands to install?

### Integration Points

- [ ] Should proj-cli depend on dev-toolkit?
- [ ] How does proj-cli discover work-prod API?
- [ ] Should there be a shared configuration?

### Managed Projects

- [ ] Is dev-toolkit a "managed" project?
- [ ] What sync scope makes sense for each project type?
- [ ] Should tooling projects (dev-toolkit, proj-cli) be managed differently?

### Workspace Coordination

- [ ] Should there be workspace-level Cursor rules?
- [ ] How do cross-project commands work?
- [ ] What shared state exists across projects?

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research four-arm-architecture --from-explore four-arm-architecture` to conduct research
3. After research, use `/decision four-arm-architecture --from-research` to make decisions

---

## 📝 Notes

**User Insight (2025-12-22):**
> "The ability to provide commands that we've developed for Cursor over time seems more like something that would be installed with dev-toolkit than be a part of infrastructure management."

This insight suggests:
- dev-infra = source of commands (in templates)
- dev-toolkit = distribution of commands (installation)
- proj-cli = management of projects (state tracking)
- work-prod = storage of data (registry)

**Discovery:** dev-toolkit already has `install.sh` and the `dt-*` command pattern, making it a natural home for `dt-cursor-install` or similar command.

---

**Last Updated:** 2025-12-22

