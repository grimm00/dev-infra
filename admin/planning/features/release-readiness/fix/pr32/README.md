# PR 32 Fix Tracking

**PR:** #32 - Release Readiness Phase 1 & 2 Complete  
**Date:** 2025-12-09  
**Status:** 🔴 Not Started  
**Last Updated:** 2025-12-09

---

## 📋 Quick Links

### Fix Batches

- **[batch-high-low-01.md](batch-high-low-01.md)** - HIGH priority, LOW effort (1 issue: gh CLI skipped check bug)
- **[batch-high-medium-01.md](batch-high-medium-01.md)** - HIGH priority, MEDIUM effort (1 issue: label filtering bug - can defer)

---

## 📊 Summary

**Total Issues:** 6 (from Sourcery review)  
**HIGH Priority Issues:** 2  
**Batches Created:** 2 (HIGH priority only, as requested)  
**Status:** 🔴 Not Started

**Priority Breakdown:**
- 🟠 HIGH: 2 issues (Comments #2, #3)
- 🟡 MEDIUM: 4 issues (Comments #1, #4, #5, #6) - Not included in this fix plan

---

## 🟠 HIGH Priority Batches

### Batch high-low-01: gh CLI skipped check bug

- **Status:** 🔴 Not Started
- **Priority:** 🟠 HIGH
- **Effort:** 🟢 LOW
- **Issues:** 1 (PR32-#2)
- **File:** [batch-high-low-01.md](batch-high-low-01.md)
- **Estimated Time:** 15-20 minutes

**Issue:**
- PR32-#2: Missing gh CLI causes false failures (🟠 HIGH, 🟡 MEDIUM impact, 🟢 LOW effort)

**Recommendation:** Fix this NOW before merge - causes false failures in CI environments without gh CLI.

---

### Batch high-medium-01: Label filtering bug

- **Status:** 🔴 Not Started
- **Priority:** 🟠 HIGH
- **Effort:** 🟡 MEDIUM
- **Issues:** 1 (PR32-#3)
- **File:** [batch-high-medium-01.md](batch-high-medium-01.md)
- **Estimated Time:** 30-45 minutes

**Issue:**
- PR32-#3: Label filtering uses AND not OR (🟠 HIGH, 🟡 MEDIUM impact, 🟡 MEDIUM effort)

**Recommendation:** Can DEFER if data gathering not critical yet - affects accuracy but not core functionality.

---

## 🟡 MEDIUM Priority Issues (Not in This Fix Plan)

The following MEDIUM priority issues were identified but not included in this HIGH-priority fix plan:

- **Comment #1:** JSON output flag unused (🟡 MEDIUM, 🟢 LOW)
- **Comment #4:** Missing branch test too permissive (🟡 MEDIUM, 🟢 LOW)
- **Comment #5:** Missing CHANGELOG test vacuous (🟡 MEDIUM, 🟢 LOW)
- **Comment #6:** Phase 1 completion criteria unchecked (🟡 MEDIUM, 🟢 LOW)

**Note:** Comment #6 (Phase 1 checklist) should be fixed quickly as it's trivial, but was marked MEDIUM priority in the review.

---

## 📝 Implementation Recommendation

**For PR #32 merge:**

1. **FIX NOW:** batch-high-low-01 (Comment #2 - gh CLI bug)
   - Prevents false failures
   - Quick fix (15-20 min)
   - High impact on CI reliability

2. **DEFER:** batch-high-medium-01 (Comment #3 - label filtering)
   - Can fix in follow-up PR
   - Data gathering is informational
   - Medium effort

3. **ALSO FIX (if time allows):** Comment #6 (Phase 1 checklist)
   - Quick fix (2 minutes)
   - Improves documentation consistency
   - Was in Sourcery review but marked MEDIUM priority

**Decision:** Fix Comment #2 now, defer Comment #3 to future PR.

---

## 🔗 Related

- **Sourcery Review:** `admin/feedback/sourcery/pr32.md`
- **Original PR:** #32
- **Script:** `scripts/check-release-readiness.sh`
- **Tests:** `tests/unit/check-release-readiness.bats`

---

**Last Updated:** 2025-12-09

