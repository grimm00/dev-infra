# Worktree Feature Workflow - Phase 2: Template Updates

**Phase:** 2 - Template Updates  
**Duration:** ~30 minutes  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** Phase 1 complete

---

## 📋 Overview

Add `.sourcery.yaml` to both project templates and update the template sync manifest.

**Success Definition:** Both templates have `.sourcery.yaml` and it's tracked in sync manifest.

---

## 🎯 Goals

1. **Add to standard-project** - Copy .sourcery.yaml to standard-project template
2. **Add to learning-project** - Copy .sourcery.yaml to learning-project template
3. **Update sync manifest** - Add .sourcery.yaml to template-sync-manifest.txt

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan worktree-feature-workflow --expand --phase 2` to add detailed tasks.

### Task Categories

- [ ] **Standard Template** - Add .sourcery.yaml to standard-project
- [ ] **Learning Template** - Add .sourcery.yaml to learning-project
- [ ] **Sync Manifest** - Update manifest to track .sourcery.yaml
- [ ] **Verification** - Run template sync validation

---

## ✅ Completion Criteria

- [ ] `templates/standard-project/.sourcery.yaml` exists
- [ ] `templates/learning-project/.sourcery.yaml` exists
- [ ] Files have correct ignore patterns for template structure
- [ ] `scripts/template-sync-manifest.txt` includes `.sourcery.yaml`
- [ ] Template sync validation passes

---

## 📦 Deliverables

- `templates/standard-project/.sourcery.yaml`
- `templates/learning-project/.sourcery.yaml`
- Updated `scripts/template-sync-manifest.txt`

---

## 🔗 Dependencies

### Prerequisites

- Phase 1 complete (provides .sourcery.yaml reference)

### Blocks

- Phase 3 (Command Updates)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 1](phase-1.md)
- [Next Phase: Phase 3](phase-3.md)
- [ADR-004: Sourcery Configuration](../../decisions/worktree-feature-workflow/adr-004-sourcery-configuration.md)

---

**Last Updated:** 2026-01-09  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan worktree-feature-workflow --expand --phase 2`
