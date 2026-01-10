# Fix Tracking - PR #49

**PR:** #49 - feat: Add CI Drift Detection (Phase 3)  
**Review Date:** 2025-12-15  
**Status:** ✅ HIGH priority fixed, MEDIUM/LOW deferred

---

## Summary

| Priority | Count | Action |
|----------|-------|--------|
| 🔴 CRITICAL | 0 | - |
| 🟠 HIGH | 1 | ✅ Fixed |
| 🟡 MEDIUM | 5 | Deferred |
| 🟢 LOW | 2 | Deferred |

---

## Fixed Issues

### Comment #1: Guard against `set -u` with empty manifest

**Priority:** 🟠 HIGH  
**Status:** ✅ Fixed in commit `390b94e`

**Fix:** Initialize `line` variable before while loop to prevent `set -u` failure with empty manifest.

---

## Deferred Issues

### Comment #2: TDD placeholder assertions

**Priority:** 🟡 MEDIUM  
**Effort:** 🟡 MEDIUM  
**Issue:** Tests still use `[ "$status" -ne 0 ] || [ -f "$SCRIPT" ]` instead of specific assertions.

**Recommendation:** Update tests to assert specific exit codes (0 for success, 1 for drift, etc.)

---

### Comment #3: Test doesn't check output content

**Priority:** 🟡 MEDIUM  
**Effort:** 🟢 LOW  
**Issue:** "outputs clear error messages" test doesn't verify actual output content.

**Recommendation:** Add assertions like `[[ "$output" == *"DRIFT DETECTED"* ]]`

---

### Comment #4: Missing edge case tests

**Priority:** 🟡 MEDIUM  
**Effort:** 🟡 MEDIUM  
**Issue:** No tests for manifest entries that exist in only one template.

**Recommendation:** Add tests for file/dir missing on one side.

---

### Comment #5: Test execution approach

**Priority:** 🟢 LOW  
**Effort:** 🟡 MEDIUM  
**Issue:** Tests use `source` inside `bash -c` instead of direct execution.

**Recommendation:** Consider invoking script directly with `run "$SCRIPT"` after exporting env vars.

---

### Comment #6: Empty manifest behavior undefined

**Priority:** 🟡 MEDIUM  
**Effort:** 🟢 LOW  
**Issue:** Empty manifest test doesn't define what "gracefully" means.

**Recommendation:** Decide if empty manifest is success or error, add concrete assertions.

---

### Overall #2: Better directory drift reporting

**Priority:** 🟢 LOW  
**Effort:** 🟡 MEDIUM  
**Issue:** Directory drift only shows directory path, not which file differs.

**Recommendation:** Include first differing file path or short diff snippet.

---

## Related

- **Sourcery Review:** `admin/feedback/sourcery/pr49.md`
- **Phase Document:** `admin/planning/features/experimental-template/phase-3.md`

---

**Last Updated:** 2025-12-15

