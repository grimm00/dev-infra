# Research Topics - Command Branch Workflow

**Purpose:** List of research topics/questions to investigate  
**Status:** 🔴 Pending Research  
**Created:** 2025-12-10  
**Last Updated:** 2025-12-10

---

## 📋 Research Topics

This document lists research topics and questions that need investigation before making decisions.

### Research Topic 1: Branch Pattern Integration

**Question:** How would `cmd/*` branches integrate with existing Git Flow and CI workflows?

**Why:** Need to ensure the new branch pattern doesn't conflict with existing patterns (`feat/*`, `fix/*`, `docs/*`, `chore/*`) and works with CI.

**Areas to investigate:**

- Branch protection rules implications
- CI workflow triggers (which workflows run on `cmd/*`?)
- Merge strategy (direct-merge like `docs/*` or PR-required like `feat/*`?)
- Template integration (should this be added to workflow.mdc rules?)

**Priority:** 🟠 High

**Status:** 🔴 Not Started

---

### Research Topic 2: Documentation-Only vs Code Changes

**Question:** How should the workflow differentiate between docs-only command updates and code-affecting changes?

**Why:** Docs-only changes can merge directly; code changes may need PRs and reviews.

**Areas to investigate:**

- What constitutes a "code-affecting" command change?
- Should command tests be required for code changes?
- How to auto-detect the change type?
- Integration with command testing automation CI/CD improvement

**Priority:** 🟠 High

**Status:** 🔴 Not Started

---

### Research Topic 3: Tracking Document Automation

**Question:** What should the auto-generated tracking document include?

**Why:** Reduce manual work while maintaining useful tracking.

**Areas to investigate:**

- Current tracking document format analysis
- What fields can be auto-populated?
- Template structure for different change types (new/fix/enhance)
- Integration with README update

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 4: New Command Development Workflow

**Question:** Should new commands go through feature planning or just command tracking?

**Why:** New commands may need more structure (phases, ADR) vs. simple tracking.

**Areas to investigate:**

- When is feature planning appropriate for commands?
- Should there be a "command feature" template?
- How to handle multi-phase command development?
- Integration with `/explore` → `/research` → `/decision` workflow

**Priority:** 🟡 Medium

**Status:** 🔴 Not Started

---

### Research Topic 5: Template Integration

**Question:** Should this workflow be included in the dev-infra template for other projects?

**Why:** Other projects using dev-infra templates may benefit from command management.

**Areas to investigate:**

- Relevance to standard-project vs. learning-project templates
- Required directory structure additions
- Documentation needs
- Optional vs. default inclusion

**Priority:** 🟢 Low

**Status:** 🔴 Not Started

---

### Research Topic 6: Review Process for Commands

**Question:** Should command changes have a review step similar to Sourcery for PRs?

**Why:** Command quality and consistency matter; some validation may be valuable.

**Areas to investigate:**

- What would a "command review" validate?
- Manual review vs. automated checks?
- Integration with existing PR validation workflow
- Checklist for command quality

**Priority:** 🟢 Low

**Status:** 🔴 Not Started

---

## 🎯 Research Workflow

1. Use `/research command-branch-workflow --from-explore command-branch-workflow` to conduct research
2. Research will create documents in `admin/research/command-branch-workflow/`
3. After research complete, use `/decision command-branch-workflow --from-research` to make decisions

---

## 📊 Quick Reference

| Topic | Priority | Status | Blocking? |
|-------|----------|--------|-----------|
| Branch Pattern Integration | 🟠 High | 🔴 Not Started | Yes |
| Docs-Only vs Code Changes | 🟠 High | 🔴 Not Started | Yes |
| Tracking Doc Automation | 🟡 Medium | 🔴 Not Started | No |
| New Command Development | 🟡 Medium | 🔴 Not Started | No |
| Template Integration | 🟢 Low | 🔴 Not Started | No |
| Review Process | 🟢 Low | 🔴 Not Started | No |

---

**Last Updated:** 2025-12-10

