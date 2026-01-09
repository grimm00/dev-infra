# Feature Transition Plan - Worktree Feature Workflow

**Feature:** Worktree Feature Workflow  
**Status:** 🔴 Not Started  
**Created:** 2026-01-09  
**Source:** [Decisions Hub](../../decisions/worktree-feature-workflow/README.md)  
**Type:** Feature

---

## Overview

Implement a refined git worktree workflow for feature development based on 4 accepted Architecture Decision Records (ADRs). This workflow provides:

1. Consistent worktree naming aligned with branch names
2. Self-contained feature branches with all documentation
3. Draft PR workflow for continuous Sourcery feedback
4. Sourcery configuration to reduce documentation noise

---

## Transition Goals

From the decisions summary:

- **ADR-001:** Add `worktrees/` to `.gitignore`, establish naming convention
- **ADR-002:** Document self-contained branch pattern (already being used!)
- **ADR-003:** Update `/pr` command with `--draft` flag support
- **ADR-004:** Create `.sourcery.yaml` and add to templates

---

## Pre-Transition Checklist

- [x] Research complete (6 topics)
- [x] Decisions made (4 ADRs)
- [x] Requirements documented (22 FRs, 12 NFRs)
- [ ] Phase scaffolding reviewed
- [ ] Phases expanded with detail

---

## Implementation Phases

### Phase 1: Configuration (~30 min)

**Goal:** Set up `.gitignore` and `.sourcery.yaml` in dev-infra root.

**Deliverables:**
- `worktrees/` and `tmp/` added to `.gitignore`
- `.sourcery.yaml` created with ignore patterns

**Requirements Addressed:**
- FR-3: Gitignore Configuration
- FR-14: Create .sourcery.yaml
- FR-15: Sourcery Ignore admin/**

**Phase Document:** [phase-1.md](phase-1.md)

---

### Phase 2: Template Updates (~30 min)

**Goal:** Add `.sourcery.yaml` to both templates and update sync manifest.

**Deliverables:**
- `templates/standard-project/.sourcery.yaml`
- `templates/learning-project/.sourcery.yaml`
- Updated `scripts/template-sync-manifest.txt`

**Requirements Addressed:**
- FR-16: Include in Templates
- FR-17: Add to Template Sync Manifest

**Phase Document:** [phase-2.md](phase-2.md)

---

### Phase 3: Command Updates (~1 hour)

**Goal:** Update `/pr` command to support `--draft` flag.

**Deliverables:**
- Updated `.cursor/commands/pr.md` with draft PR support
- Draft PR workflow documentation

**Requirements Addressed:**
- FR-22: /pr Command Draft Support
- FR-20: Open Draft PR After First Commit
- FR-21: Draft PRs for Early Feedback

**Phase Document:** [phase-3.md](phase-3.md)

---

### Phase 4: Documentation (~1 hour)

**Goal:** Document the complete worktree feature workflow.

**Deliverables:**
- New `docs/WORKTREE-WORKFLOW.md` guide
- Updated command documentation
- Update cursor rules with new workflow

**Requirements Addressed:**
- FR-1 to FR-4: Naming conventions
- FR-8 to FR-13: Self-contained branch pattern
- NFR documentation

**Phase Document:** [phase-4.md](phase-4.md)

---

## Post-Transition

- [ ] All phases complete
- [ ] Draft PR created (dogfooding!)
- [ ] Documentation updated
- [ ] Workflow validated through this feature
- [ ] Ready for merge to develop

---

## Definition of Done

- [ ] All 4 phases complete
- [ ] `.gitignore` updated
- [ ] `.sourcery.yaml` created
- [ ] Templates updated
- [ ] `/pr` command supports `--draft`
- [ ] Workflow documented
- [ ] Feature merged to develop

---

## Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| Research complete | ✅ | 6 topics completed |
| ADRs accepted | ✅ | 4 ADRs created |
| Requirements documented | ✅ | 22 FRs, 12 NFRs |

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| Template sync drift | Add to manifest, CI validates |
| Sourcery config breaks analysis | Research confirmed no impact |
| Draft PR workflow confusing | Document clearly, dogfood first |

---

**Last Updated:** 2026-01-09
