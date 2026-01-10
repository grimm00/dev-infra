# Worktree Feature Workflow - Decisions Hub

**Purpose:** Architecture decisions for the refined git worktree workflow  
**Status:** ✅ Accepted  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 📋 Quick Links

- **[Decisions Summary](decisions-summary.md)** - Summary of all decisions
- **[Research Hub](../../research/worktree-feature-workflow/README.md)** - Related research
- **[Requirements](../../research/worktree-feature-workflow/requirements.md)** - Requirements document

### ADR Documents

| ADR | Decision | Status |
|-----|----------|--------|
| [ADR-001](adr-001-worktree-location-and-naming.md) | Worktree Location and Naming | ✅ Accepted |
| [ADR-002](adr-002-self-contained-feature-branches.md) | Self-Contained Feature Branches | ✅ Accepted |
| [ADR-003](adr-003-draft-pr-review-workflow.md) | Draft PR Review Workflow | ✅ Accepted |
| [ADR-004](adr-004-sourcery-configuration.md) | Sourcery Configuration | ✅ Accepted |

---

## 🎯 Decisions Overview

These decisions define a refined git worktree workflow for feature development that:
- Uses meaningful worktree naming aligned with branch names
- Keeps all feature-specific documentation on the feature branch
- Uses draft PRs for continuous Sourcery feedback
- Configures Sourcery to ignore process documentation

**Decision Points:** 4 decisions  
**Status:** ✅ All Accepted

---

## 📊 Decision Summary

| # | Decision | Key Choice |
|---|----------|------------|
| 1 | Worktree Location | `worktrees/` directory, names mirror branch names |
| 2 | Self-Contained Branches | ALL feature docs on feature branch |
| 3 | Review Workflow | Draft PR from first commit for continuous feedback |
| 4 | Sourcery Config | Ignore `admin/**` and `tmp/**` |

---

## 🚀 Next Steps

1. ✅ ~~Review ADR documents~~
2. Use `/transition-plan --from-adr` to create implementation plan
3. Implement decisions

---

**Last Updated:** 2026-01-09
