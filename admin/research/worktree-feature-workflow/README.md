# Worktree Feature Workflow - Research Hub

**Purpose:** Research for refined git worktree workflow with self-contained feature branches  
**Status:** 🟠 In Progress  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

| Priority | Topic | Document | Status |
|----------|-------|----------|--------|
| 🔴 High | Worktree Naming Conventions | [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md) | ✅ Complete |
| 🔴 High | Self-Contained Feature Branches | [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md) | 🔴 Not Started |
| 🟡 Medium | Review Gate Pattern | [research-review-gate-pattern.md](research-review-gate-pattern.md) | ✅ Complete |
| 🟡 Medium | sourcery.yml Configuration | [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md) | 🔴 Not Started |
| 🟡 Medium | Context Switching and Discovery | [research-context-switching-and-discovery.md](research-context-switching-and-discovery.md) | 🔴 Not Started |

---

## 🎯 Research Overview

This research addresses questions about a refined git worktree workflow:

1. **Naming:** What conventions work best for manually-created worktrees?
2. **Isolation:** What content should live on feature branches vs develop?
3. **Review:** How should the review gate workflow function?
4. **Tooling:** How to configure sourcery.yml for doc-aware PRs?
5. **Discovery:** How to efficiently switch between worktrees?

**Research Topics:** 5 topics  
**High Priority:** 2 topics (Naming, Self-Contained)  
**Status:** 🟠 In Progress (2/5 complete)

---

## 📊 Research Status

### High Priority (Blocking Decisions)

| Research Topic | Status | Key Finding |
|----------------|--------|-------------|
| Worktree Naming Conventions | ✅ Complete | Directory names mirror branch names (`feat/foo` → `feat-foo`) |
| Self-Contained Feature Branches | 🔴 Not Started | - |

### Medium Priority

| Research Topic | Status | Key Finding |
|----------------|--------|-------------|
| Review Gate Pattern | ✅ Complete | Clear "Definition of Done" + holistic review |
| sourcery.yml Configuration | 🔴 Not Started | - |
| Context Switching and Discovery | 🔴 Not Started | - |

---

## 💡 Session Insights (Pre-Research)

These insights were captured during exploration and inform the research:

**Worktree Location:**
> `worktrees/` directory (project-relative) avoids Cursor confirmation prompts that `.cursor/worktrees/` triggers.

**Context Switching:**
> Per-window focus is optimal for work. Window titles become primary identifiers.
> Commands could output `cursor /path/to/worktree` for easy opening.

---

## 🚀 Next Steps

1. Conduct research for each topic using `/research worktree-feature-workflow --conduct`
2. High priority topics first (Naming, Self-Contained)
3. Review requirements in `requirements.md`
4. Use `/decision worktree-feature-workflow --from-research` to make decisions

---

**Last Updated:** 2026-01-09
