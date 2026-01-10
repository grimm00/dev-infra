# Worktree Feature Workflow - Research Hub

**Purpose:** Research for refined git worktree workflow with self-contained feature branches  
**Status:** ✅ Complete  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

| Priority  | Topic                           | Document                                                                                   | Status         |
| --------- | ------------------------------- | ------------------------------------------------------------------------------------------ | -------------- |
| 🔴 High   | Worktree Naming Conventions     | [research-worktree-naming-conventions.md](research-worktree-naming-conventions.md)         | ✅ Complete    |
| 🔴 High   | Self-Contained Feature Branches | [research-self-contained-feature-branches.md](research-self-contained-feature-branches.md) | ✅ Complete    |
| 🔴 High   | Phase-Based Review              | [research-phase-based-review.md](research-phase-based-review.md)                           | ✅ Complete    |
| 🟡 Medium | Review Gate Pattern             | [research-review-gate-pattern.md](research-review-gate-pattern.md)                         | ✅ Complete    |
| 🟡 Medium | .sourcery.yaml Configuration    | [research-sourcery-yml-configuration.md](research-sourcery-yml-configuration.md)           | ✅ Complete    |
| 🟡 Medium | Context Switching and Discovery | [research-context-switching-and-discovery.md](research-context-switching-and-discovery.md) | ✅ Complete    |
| 🔴 High   | Incremental Review Strategies   | [research-incremental-review-strategies.md](research-incremental-review-strategies.md)     | ✅ Complete    |

---

## 🎯 Research Overview

This research addresses questions about a refined git worktree workflow:

1. **Naming:** What conventions work best for manually-created worktrees?
2. **Isolation:** What content should live on feature branches vs develop?
3. **Phase Review:** How to maintain early bug detection in self-contained branches?
4. **Review Gate:** How should the review gate workflow function?
5. **Tooling:** How to configure `.sourcery.yaml` for doc-aware PRs?
6. **Discovery:** How to efficiently switch between worktrees?
7. **Incremental Review:** How to get focused reviews on only new changes? (Addendum)

**Research Topics:** 7 topics  
**High Priority:** 4 topics (Naming, Self-Contained, Phase Review, Incremental Review)  
**Status:** ✅ Complete (7/7 complete)

---

## 📊 Research Status

### High Priority (Blocking Decisions)

| Research Topic                  | Status         | Key Finding                                                    |
| ------------------------------- | -------------- | -------------------------------------------------------------- |
| Worktree Naming Conventions     | ✅ Complete    | Directory names mirror branch names (`feat/foo` → `feat-foo`)  |
| Self-Contained Feature Branches | ✅ Complete    | Full isolation - ALL feature docs on feature branch            |
| Phase-Based Review              | ✅ Complete    | Use draft PR for continuous Sourcery feedback                  |
| Incremental Review Strategies   | ✅ Complete    | "Fix before re-review" pattern; 1 PR per feature               |

### Medium Priority

| Research Topic                  | Status      | Key Finding                                  |
| ------------------------------- | ----------- | -------------------------------------------- |
| Review Gate Pattern             | ✅ Complete | Clear "Definition of Done" + holistic review |
| .sourcery.yaml Configuration    | ✅ Complete | Create `.sourcery.yaml` ignoring `admin/**`  |
| Context Switching and Discovery | ✅ Complete | Native tools suffice - don't over-engineer   |

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

1. ✅ ~~Conduct all research topics~~ (All 6 topics complete)
2. Review requirements in `requirements.md`
3. Use `/decision worktree-feature-workflow --from-research` to make decisions

---

**Last Updated:** 2026-01-09
