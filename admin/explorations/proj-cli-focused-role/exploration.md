# proj-cli Focused Role - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 What Are We Exploring?

Clarifying proj-cli's specific responsibilities within the four-arm architecture to ensure clear boundaries with dev-toolkit and work-prod.

---

## 🤔 Why Explore This?

**Problem:** As the terraform-style research progressed, proj-cli's scope expanded to include concepts that may belong elsewhere:
- Global command installation → possibly dev-toolkit
- Project data storage → work-prod
- Template patterns → dev-infra

**Opportunity:** A focused proj-cli is:
- Easier to maintain
- Clearer to users
- Better integrated with sister projects

---

## 💡 proj-cli's Focused Role

### Core Identity

**proj-cli is a project lifecycle management tool.**

It answers the question: "How does my project stay in sync with dev-infra templates?"

### Command Scope

| Command | Purpose | Status |
|---------|---------|--------|
| `proj init` | Initialize project as managed | Planned |
| `proj plan` | Show available updates | Planned |
| `proj apply` | Apply template updates | Planned |
| `proj customize` | Mark file as intentionally modified | Planned |
| `proj state` | Show current state | Planned |
| `proj registry list` | List managed projects | Planned |
| `proj registry sync` | Sync with work-prod | Planned |

### What proj-cli Does NOT Do

| Concern | Why Not | Who Does |
|---------|---------|----------|
| Install global Cursor commands | Developer tooling | dev-toolkit |
| Store project data | Data persistence | work-prod |
| Generate templates | Template source | dev-infra |
| Git workflow utilities | Developer tooling | dev-toolkit |
| Code review extraction | Developer tooling | dev-toolkit |

---

## 🔍 Boundary Definitions

### proj-cli vs dev-toolkit

```
┌─────────────────────────────────────────────────────────────────┐
│                        proj-cli                                  │
│                (Project Lifecycle Management)                    │
│                                                                  │
│  • proj init      → Initialize managed project                  │
│  • proj plan      → Show template updates                       │
│  • proj apply     → Apply updates                               │
│  • proj customize → Mark customizations                         │
│  • proj state     → Show state                                  │
│  • proj registry  → Manage registry                             │
│                                                                  │
│  Focus: .dev-infra.yml state file and template sync             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       dev-toolkit                                │
│                   (Developer Utilities)                          │
│                                                                  │
│  • dt-review       → Extract Sourcery reviews                   │
│  • dt-git-safety   → Git flow safety checks                     │
│  • dt-config       → Configuration management                   │
│  • dt-install-hooks→ Git hooks                                  │
│  • dt-cursor-*     → Cursor command management (proposed)       │
│                                                                  │
│  Focus: Daily developer workflow utilities                       │
└─────────────────────────────────────────────────────────────────┘
```

### proj-cli vs work-prod

```
┌─────────────────────────────────────────────────────────────────┐
│                        proj-cli                                  │
│                      (CLI Client)                                │
│                                                                  │
│  • Reads/writes .dev-infra.yml (local state)                    │
│  • Calls work-prod API for registry operations                  │
│  • Caches registry locally for offline access                   │
│  • Does NOT store persistent project data                       │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ API calls
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        work-prod                                 │
│                      (Data Backend)                              │
│                                                                  │
│  • Stores project registry (SQLite)                             │
│  • Provides REST API                                            │
│  • Source of truth for project metadata                         │
│  • Persists across machines (if deployed)                       │
└─────────────────────────────────────────────────────────────────┘
```

### proj-cli vs dev-infra

```
┌─────────────────────────────────────────────────────────────────┐
│                        dev-infra                                 │
│                   (Template Source)                              │
│                                                                  │
│  • Defines template structure                                   │
│  • Contains canonical Cursor commands                           │
│  • Publishes releases (vX.Y.Z)                                  │
│  • Source of truth for patterns                                 │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ reads templates for comparison
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        proj-cli                                  │
│                   (Sync Manager)                                 │
│                                                                  │
│  • Compares project to template version                         │
│  • Generates diffs                                              │
│  • Applies updates                                              │
│  • Does NOT modify templates                                    │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔍 Key Questions

### Scope Questions

- [ ] Should proj-cli have ANY command installation features?
- [ ] Should `proj init` also install global commands (via dev-toolkit)?
- [ ] Is registry management the right scope for proj-cli?

### Integration Questions

- [ ] Should proj-cli depend on dev-toolkit being installed?
- [ ] Should proj-cli invoke dev-toolkit commands?
- [ ] How does proj-cli discover dev-infra releases?

### User Experience Questions

- [ ] Should users run `proj init` or `dt-cursor-install` first?
- [ ] What's the recommended "getting started" flow?
- [ ] How to minimize cognitive load across four CLIs?

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research proj-cli-focused-role --from-explore proj-cli-focused-role` to conduct research
3. After research, use `/decision proj-cli-focused-role --from-research` to make decisions

---

## 📝 Notes

**User Insight (2025-12-22):**
> "The ability to provide commands that we've developed for Cursor over time seems more like something that would be installed with dev-toolkit."

This confirms:
- proj-cli should NOT handle Cursor command installation
- proj-cli focuses on project state and template sync
- dev-toolkit handles tooling installation

**Implication:** The global command distribution research findings should be transferred to dev-toolkit's roadmap, not proj-cli.

---

**Last Updated:** 2025-12-22


