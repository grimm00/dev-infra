# Command Documentation Update: `/transition-plan` - TDD Task Ordering

**Command:** `/transition-plan`  
**Date:** 2025-12-15  
**Source:** Pre-phase review for Phase 4 (Experimental Template)  
**Status:** ✅ Complete

---

## 📋 Overview

This update enhances the `/transition-plan` command to explicitly enforce TDD task ordering when creating phase documents. This ensures tasks are organized with tests before implementation, avoiding the need for manual reordering during pre-phase reviews.

---

## 🤔 Problem Discovered

During the pre-phase review for Phase 4 (Experimental Template), the review identified that tasks needed to be reordered:

- Original task order from feature plan didn't follow TDD principles
- Pre-phase review recommended reordering: Task 1 → Task 3 → Task 4 → Task 5 → Task 2 → Task 6
- This manual reordering added extra work to the planning phase

**Root Cause:** The `/transition-plan` command mentioned TDD but didn't explicitly guide task ordering to follow the RED → GREEN → REFACTOR pattern.

---

## 🎯 Solution

Enhanced the "Key sections to populate - Tasks" section with explicit TDD task ordering guidance:

### Key Changes

1. **Explicit TDD Ordering Rule:**
   ```markdown
   **TDD Task Ordering (IMPORTANT):** Order tasks following RED → GREEN → REFACTOR:
   1. **Tests first (RED):** Write tests before implementation code
   2. **Implementation second (GREEN):** Write minimum code to pass tests
   3. **Refactor/documentation last:** Clean up and document
   ```

2. **Example Task Order:**
   ```markdown
   - Task 1: Write tests for feature X (RED)
   - Task 2: Implement feature X (GREEN)
   - Task 3: Write tests for feature Y (RED)
   - Task 4: Implement feature Y (GREEN)
   - Task 5: Documentation and cleanup
   ```

3. **Task Ordering Patterns Table:**
   | Phase Type | Task Order | Example |
   |------------|------------|---------|
   | **Code + Tests (TDD)** | Tests → Implementation → Docs | Write tests, implement code, document |
   | **Scripts (TDD)** | Tests → Script → Integration | Write bats tests, create script, integrate |
   | **Documentation Only** | Create → Link → Verify | Create docs, add links, verify links work |
   | **Configuration** | Plan → Implement → Validate | Define config, apply changes, verify |

4. **Decision Guide:**
   - "What needs to exist first for TDD to work?"
   - If tests can be written: Put test tasks BEFORE implementation tasks
   - If no tests apply: Put validation/verification tasks LAST
   - If documentation phase: Put doc creation before linking/integration

---

## 🚀 Impact

- **Future phase documents** will have properly ordered tasks from the start
- **Pre-phase reviews** won't need to recommend task reordering
- **TDD workflow** is more naturally integrated into planning
- **Documentation phases** also have clear guidance for task ordering

---

## 🔗 Related

- **Pre-phase review:** `admin/planning/features/experimental-template/phase-4-review.md`
- **Command file:** `.cursor/commands/transition-plan.md`

---

**Last Updated:** 2025-12-15

