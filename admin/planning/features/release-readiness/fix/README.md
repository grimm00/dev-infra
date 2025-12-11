# Release Readiness - Fix Tracking

**Purpose:** Fix plans and tracking for Release Readiness feature  
**Status:** ✅ Active  
**Last Updated:** 2025-12-09

---

## 📋 Quick Links

### Fix Batches

- **[PR #32 Fixes](pr32/README.md)** - Fixes from PR #32 Sourcery review (🟠 In Progress)
- **[PR #35 Fixes](pr35/README.md)** - Fixes from PR #35 Sourcery review (🟡 Deferred)
- **[PR #41 Fixes](pr41/README.md)** - Fixes from PR #41 Sourcery review (🟡 Deferred)
- **[PR #42 Fixes](pr42/README.md)** - Fixes from PR #42 Sourcery review (🟡 Deferred)

---

## 📊 Summary

**Total PRs:** 4  
**Total Batches:** 3 (PR #32) + 5 deferred (PR #35) + 5 deferred (PR #41) + 9 deferred (PR #42)  
**Status:** 🟠 In Progress

**Priority Breakdown:**
- 🟠 HIGH: 2 issues (1 fixed)
- 🟡 MEDIUM: 8 issues (1 fixed)
- 🟢 LOW: 12 issues

---

## 🔴 Active PRs

### PR #32 - Release Readiness Phase 1 & 2

- **Status:** 🟠 In Progress (2/3 batches complete)
- **Batches:** 3 batches
  - batch-high-low-01 (1 issue) - ✅ Complete (2025-12-09)
  - batch-high-medium-01 (1 issue) - Can defer
  - batch-medium-low-01 (1 issue) - ✅ Complete (2025-12-09)
- **File:** [pr32/README.md](pr32/README.md)

**Issues:**
- PR32-#2: gh CLI skipped check bug (🟠 HIGH, 🟡 MEDIUM, 🟢 LOW) - ✅ **Fixed**
- PR32-#3: Label filtering bug (🟠 HIGH, 🟡 MEDIUM, 🟡 MEDIUM) - Can defer
- PR32-#6: Phase 1 checklist unchecked (🟡 MEDIUM, 🟢 LOW, 🟢 LOW) - ✅ **Fixed**

---

### PR #35 - Release Readiness Phase 3

- **Status:** 🟡 Deferred (all MEDIUM/LOW priority)
- **Issues:** 5 deferred issues
  - PR35-#1: Shell `&&`/`||` precedence bug (🟠 HIGH) - ⏸️ Deferred (edge case)
  - PR35-#2: Test coverage gap (🟡 MEDIUM) - 🟡 Deferred
  - PR35-#3: HTML tag assertions (🟢 LOW) - 🟢 Document for future
  - PR35-Overall-1: Duplicate function (🟡 MEDIUM) - 🟡 Deferred
  - PR35-Overall-2: Array refactoring (🟢 LOW) - 🟢 Document for future
- **File:** [pr35/README.md](pr35/README.md)

**Note:** All issues from PR #35 are MEDIUM/LOW priority and tracked in `admin/feedback/deferred-tasks.md` (Tasks 23-27).

---

### PR #41 - Release Readiness Phase 4

- **Status:** 🟡 Deferred (all MEDIUM/LOW priority)
- **Issues:** 5 deferred issues
  - PR41-#1: Git repository check (🟡 MEDIUM) - 🟡 Deferred
  - PR41-#2: Dry-run banner messaging (🟢 LOW) - 🟢 Document for future
  - PR41-#3: Non-dry-run test coverage (🟡 MEDIUM) - 🟡 Deferred
  - PR41-Overall-1: Dry-run simulation messaging (🟢 LOW) - Same as #2
  - PR41-Overall-2: Argument order flexibility (🟢 LOW) - 🟢 Document for future
- **File:** [pr41/README.md](pr41/README.md)

**Note:** All issues from PR #41 are MEDIUM/LOW priority and tracked in `admin/feedback/deferred-tasks.md` (Tasks 39-43).

---

### PR #42 - Release Readiness Phase 5

- **Status:** 🟡 Deferred (all MEDIUM/LOW priority)
- **Issues:** 9 deferred issues
  - PR42-#1: Input validation for --last flag (🟡 MEDIUM) - Bug risk
  - PR42-#2: Verbose logging suppression (🟢 LOW) - UX polish
  - PR42-#3: Tests skipped in CI (🟡 MEDIUM) - Testing gap
  - PR42-#4: Backward compat assertions (🟢 LOW) - Test quality
  - PR42-#5: JSON test assertions (🟡 MEDIUM) - Test quality
  - PR42-#6: Metrics test assertions (🟡 MEDIUM) - Test quality
  - PR42-#7: --last N edge case tests (🟢 LOW) - Test quality
  - PR42-#8: Grammar typo in docs (🟢 LOW) - Documentation
  - PR42-Overall-1: Same as #1, plus duplicate check
  - PR42-Overall-2: Variable dependency refactoring (🟢 LOW)
- **File:** [pr42/README.md](pr42/README.md)

**Note:** All issues from PR #42 are MEDIUM/LOW priority and tracked in `admin/feedback/deferred-tasks.md` (Tasks 44-52).

---

**Last Updated:** 2025-12-10

