# Phase 4: Process Integration

**Feature:** Release Readiness  
**Phase:** 4  
**Status:** ✅ Complete  
**Prerequisites:** Phase 3 Complete ✅  
**Estimated:** 5 hours  
**Actual:** ~2 hours  
**Created:** 2025-12-08  
**Completed:** 2025-12-10

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

### 2. Integrate with /pr --release (~2 hours) ✅

- [x] **DOCUMENT:** Add readiness validation step to `/pr` command's release mode
- [x] **IMPLEMENT:** Add blocking logic: "If critical checks fail, do not create PR"
- [x] **IMPLEMENT:** Add `--force` option to override blocking checks
- [x] **VERIFY:** Command guidance updated, ready for manual verification

### 3. Release Branch Integration (~1 hour) ✅

- [x] **RED:** Write bats test for release branch creation generating `RELEASE-READINESS.md`
- [x] **GREEN:** Create `scripts/create-release-branch.sh` with assessment generation
- [x] **REFACTOR:** Clean colored output and clear next steps

---

## ✅ Completion Criteria

- [x] `/task-release` validates readiness
- [x] `/pr --release` enforces readiness
- [x] Creating a release branch automatically creates the assessment file
- [x] Integration is smooth and performant

---

## 📦 Deliverables

- Updated cursor commands (`task-release`, `pr`) ✅
- New script: `scripts/create-release-branch.sh` ✅
- New tests: `tests/unit/create-release-branch.bats` (8 tests) ✅

---

## 🔗 Related Documents

- [Feature Plan](../feature-plan.md)
- [Phase 3: Assessment Structure](../phase-3.md)
- [Research: Process Integration](../../../../research/release-readiness/research-process-integration.md)
