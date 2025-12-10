# Phase 4: Process Integration

**Feature:** Release Readiness  
**Phase:** 4  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 3 Complete ✅  
**Estimated:** 5 hours  
**Created:** 2025-12-08  
**Last Updated:** 2025-12-10

---

## 🎯 Overview

Integrate the readiness assessment into the standard release workflow commands. This ensures that readiness is checked at critical points: task execution, PR creation, and final merge.

**Success Definition:**

- `/task-release` runs readiness checks
- `/pr --release` blocks if critical checks fail
- Release workflow automatically generates the assessment artifact

---

## 🥅 Goals

1. Integrate checks into `/task-release`
2. Integrate checks into `/pr --release`
3. Add initial assessment generation to release branch creation
4. Document the new workflow

---

## 🏗️ Tasks

**Note:** "TDD" for Cursor commands = documentation updates + verification steps (commands are markdown files, not executable code). Task 3 involves actual script changes with traditional TDD.

### 1. Integrate with /task-release (~2 hours) ✅

- [x] **DOCUMENT:** Add "Pre-Task Readiness Check" section to `/task-release` command
- [x] **IMPLEMENT:** Add step to run `scripts/check-release-readiness.sh [version]` before tasks
- [x] **VERIFY:** Command guidance updated, ready for manual verification

### 2. Integrate with /pr --release (~2 hours)

- [ ] **DOCUMENT:** Add readiness validation step to `/pr` command's release mode
- [ ] **IMPLEMENT:** Add blocking logic: "If critical checks fail, do not create PR"
- [ ] **VERIFY:** Manual test of command guidance with sample release

### 3. Release Branch Integration (~1 hour)

- [ ] **RED:** Write bats test for release branch creation generating `RELEASE-READINESS.md`
- [ ] **GREEN:** Update release workflow to generate initial assessment on branch creation
- [ ] **REFACTOR:** Clean up output and verify file placement

---

## ✅ Completion Criteria

- [ ] `/task-release` validates readiness
- [ ] `/pr --release` enforces readiness
- [ ] Creating a release branch automatically creates the assessment file
- [ ] Integration is smooth and performant

---

## 📦 Deliverables

- Updated cursor commands (`task-release`, `pr`)
- Updated release scripts

---

## 🔗 Related Documents

- [Feature Plan](../feature-plan.md)
- [Phase 3: Assessment Structure](../phase-3.md)
- [Research: Process Integration](../../../../research/release-readiness/research-process-integration.md)
