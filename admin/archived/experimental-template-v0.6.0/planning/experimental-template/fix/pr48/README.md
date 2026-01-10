# Fix Tracking - PR #48

**PR:** #48 - feat: Update Generator Script for Experimental Template (Phase 2)  
**Phase:** Phase 2  
**Created:** 2025-12-15  
**Status:** 🟡 Deferred Issues Tracked

---

## Summary

- **Total Comments:** 4 individual + 2 overall
- **CRITICAL/HIGH:** 0 (no blockers)
- **MEDIUM:** 4 deferred
- **LOW:** 2 (1 fixed, 1 deferred)
- **Fixed in PR:** Comment #4 (grammar)

---

## Deferred Issues

### Comment #1 - Strengthen README Disclaimer Test

**Priority:** 🟡 MEDIUM  
**Impact:** 🟡 MEDIUM  
**Effort:** 🟢 LOW

**Issue:** Test assertion too weak - passes if README contains any "experimental" mention.

**Suggested Fix:**
```bash
grep -Ei "Experimental Template|stability is not guaranteed" "$TEST_PROJECT_DIR/README.md"
```

---

### Comment #2 - Verify EXPERIMENTAL.md Content

**Priority:** 🟡 MEDIUM  
**Impact:** 🟡 MEDIUM  
**Effort:** 🟢 LOW

**Issue:** Test only checks file exists, not content.

**Suggested Fix:** Add grep check for key phrase like heading or warning text.

---

### Comment #3 - Test Non-Interactive Warning Skip

**Priority:** 🟡 MEDIUM  
**Impact:** 🟢 LOW  
**Effort:** 🟡 MEDIUM

**Issue:** No test verifies that non-interactive mode skips the stability warning.

**Suggested Fix:** Add test that explicitly checks warning is not shown in non-interactive mode.

---

### Overall #1 - Centralize Template Types

**Priority:** 🟡 MEDIUM  
**Impact:** 🟡 MEDIUM  
**Effort:** 🟡 MEDIUM

**Issue:** Template type handling spread across help text, validation, and menu.

**Suggested Fix:** Create single constant or helper for allowed template types.

---

### Overall #2 - Simplify Test Cleanup

**Priority:** 🟢 LOW  
**Impact:** 🟢 LOW  
**Effort:** 🟢 LOW

**Issue:** Tests have custom `TEST_*_DIR` variables on top of helpers.

**Suggested Fix:** Derive paths from existing helpers, let them handle cleanup.

---

## Related

- **Sourcery Review:** `admin/feedback/sourcery/pr48.md`
- **Phase Plan:** `admin/planning/features/experimental-template/phase-2.md`

---

**Last Updated:** 2025-12-15

