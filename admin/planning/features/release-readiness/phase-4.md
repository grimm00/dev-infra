# Phase 4: Process Integration

**Feature:** Release Readiness  
**Phase:** 4  
**Status:** 🔴 Not Started  
**Prerequisites:** Phase 3 Complete  
**Created:** 2025-12-08  
**Last Updated:** 2025-12-08

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

### 1. Integrate with /task-release (TDD)

- [ ] **RED:** Write test ensuring `/task-release` calls the readiness check
- [ ] **GREEN:** Update `/task-release` command to invoke validation script
- [ ] **REFACTOR:** Improve user feedback during checks

### 2. Integrate with /pr --release (TDD)

- [ ] **RED:** Write test ensuring `/pr --release` fails if blocking criteria are unmet
- [ ] **GREEN:** Update `/pr` command logic to run checks before creation
- [ ] **REFACTOR:** Add override flag if needed

### 3. Release Branch Integration (TDD)

- [ ] **RED:** Write test for release branch creation hook
- [ ] **GREEN:** Update release branch creation script to generate initial `RELEASE-READINESS.md`
- [ ] **REFACTOR:** Clean up output

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

