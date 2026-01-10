# Worktree Feature Workflow - Phase 3: Command Updates

**Phase:** 3 - Command Updates  
**Duration:** ~1 hour  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** Phase 2 complete

---

## 📋 Overview

Update the `/pr` command to support the `--draft` flag for creating initial draft PRs.

**Success Definition:** `/pr --draft` creates draft PRs for continuous Sourcery feedback.

---

## 🎯 Goals

1. **Add --draft flag** - Update /pr command to support draft PR creation
2. **Add --ready flag** - Mark draft PR as ready for review
3. **Add --review flag** - Trigger Sourcery review on draft PR (manual trigger required!)
4. **Document workflow** - Add draft PR workflow to command documentation
5. **Update usage examples** - Show draft PR usage patterns

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan worktree-feature-workflow --expand --phase 3` to add detailed tasks.

### Task Categories

- [ ] **Command Update** - Add --draft, --ready, --review flags to /pr command
- [ ] **Draft Workflow** - Document draft PR creation workflow
- [ ] **Review Trigger** - Document Sourcery review trigger (manual: `@sourcery-ai review`)
- [ ] **Examples** - Add draft PR usage examples
- [ ] **Verification** - Test commands with new flags

---

## ✅ Completion Criteria

- [ ] `/pr` command supports `--draft` flag (creates draft PR)
- [ ] `/pr` command supports `--ready` flag (marks draft as ready)
- [ ] `/pr` command supports `--review` flag (triggers Sourcery via comment)
- [ ] Draft PR workflow documented in command
- [ ] Sourcery manual trigger documented (`@sourcery-ai review`)
- [ ] Usage examples show draft PR pattern
- [ ] Command integrates with ADR-003 workflow

---

## 📦 Deliverables

- Updated `.cursor/commands/pr.md`

---

## 🔗 Dependencies

### Prerequisites

- Phase 2 complete

### Blocks

- Phase 4 (Documentation)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 2](phase-2.md)
- [Next Phase: Phase 4](phase-4.md)
- [ADR-003: Draft PR Review Workflow](../../decisions/worktree-feature-workflow/adr-003-draft-pr-review-workflow.md)

---

**Last Updated:** 2026-01-09  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan worktree-feature-workflow --expand --phase 3`
