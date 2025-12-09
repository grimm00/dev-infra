# Fix Batch: pr32-batch-high-medium-01

**PR:** #32 - Release Readiness Phase 1 & 2 Complete  
**Priority:** 🟠 HIGH  
**Effort:** 🟡 MEDIUM  
**Status:** 🔴 Not Started  
**Created:** 2025-12-09  
**Source:** Sourcery review of PR #32

---

## 📋 Overview

This batch addresses HIGH priority, MEDIUM effort issues from PR #32 Sourcery review. This issue involves restructuring the gh issue query logic to correctly find "blocking OR critical" issues.

**Decision:** This can be deferred if data gathering is not yet critical. The bug affects data gathering accuracy but doesn't break core functionality.

---

## 🎯 Issues in This Batch

### Issue PR32-#3: Label filtering bug (AND vs OR)

**Location:** `scripts/check-release-readiness.sh:305`

**Priority:** 🟠 HIGH  
**Impact:** 🟡 MEDIUM  
**Effort:** 🟡 MEDIUM

**Description:**
Using multiple `--label` flags with `gh issue list` selects issues that have BOTH labels (AND logic), not issues with either label (OR logic). This means the script won't correctly find all "blocking OR critical" issues.

**Current Behavior:**
```bash
gh issue list --state open --label "blocking" --label "critical" --json number,title,labels --jq '...'
```

This only finds issues that have BOTH "blocking" AND "critical" labels.

**Expected Behavior:**
Should find issues that have "blocking" OR "critical" label (or both).

**Fix Options:**

**Option 1: Separate calls (simpler, more readable)**
```bash
# Get issues with "blocking" label
blocking_issues=$(gh issue list --state open --label "blocking" --json number,title --jq '.[] | "#\(.number): \(.title)"' 2>/dev/null || echo "")

# Get issues with "critical" label
critical_issues=$(gh issue list --state open --label "critical" --json number,title --jq '.[] | "#\(.number): \(.title)"' 2>/dev/null || echo "")

# Combine and deduplicate
all_issues=$(echo -e "$blocking_issues\n$critical_issues" | sort -u | grep -v '^$')
```

**Option 2: Use search API (more complex, handles OR logic)**
```bash
gh search issues --state open --repo $(gh repo view --json nameWithOwner -q .nameWithOwner) "label:blocking OR label:critical" --json number,title --jq '.[] | "#\(.number): \(.title)"'
```

**Option 3: Get all issues with labels and filter in jq**
```bash
gh issue list --state open --json number,title,labels --jq '.[] | select(.labels[]?.name == "blocking" or .labels[]?.name == "critical") | "#\(.number): \(.title)"'
```

**Recommendation:** Option 1 (separate calls) is simplest and most maintainable.

**Testing:**
- Create test issues with "blocking" label only
- Create test issues with "critical" label only
- Create test issues with both labels
- Verify script finds all of them
- Verify no duplicates in output

---

## 📝 Implementation Plan

### Step 1: Refactor gather_blocking_issues function

**File:** `scripts/check-release-readiness.sh`

**Change:** Replace current implementation with separate calls approach (Option 1)

**Before:**
```bash
gather_blocking_issues() {
    log "Gathering open blocking issues"
    
    # ... (auth checks) ...
    
    echo ""
    echo "Open Blocking/Critical Issues:"
    echo "------------------------------"
    gh issue list --state open --label "blocking,critical" --json number,title,url --jq '.[] | "- #\(.number): \(.title) (\(.url))"' || echo "  No open blocking/critical issues found."
    echo ""
    add_result "Open Blocking Issues" true
    return 0
}
```

**After:**
```bash
gather_blocking_issues() {
    log "Gathering open blocking issues"
    
    if ! command -v gh &> /dev/null; then
        print_status "Open Blocking Issues" false "gh CLI not available (skipping data gathering)"
        add_result "Open Blocking Issues" false
        return 1
    fi
    
    if ! gh auth status &> /dev/null; then
        print_status "Open Blocking Issues" false "gh CLI not authenticated (skipping data gathering)"
        add_result "Open Blocking Issues" false
        return 1
    fi
    
    echo ""
    echo "Open Blocking/Critical Issues:"
    echo "------------------------------"
    
    # Get issues with "blocking" label
    local blocking_issues
    blocking_issues=$(gh issue list --state open --label "blocking" --json number,title,url --jq '.[] | "- #\(.number): \(.title) (\(.url))"' 2>/dev/null || echo "")
    
    # Get issues with "critical" label
    local critical_issues
    critical_issues=$(gh issue list --state open --label "critical" --json number,title,url --jq '.[] | "- #\(.number): \(.title) (\(.url))"' 2>/dev/null || echo "")
    
    # Combine and display (will have duplicates if issue has both labels, but that's okay for display)
    if [[ -n "$blocking_issues" ]]; then
        echo "$blocking_issues"
    fi
    if [[ -n "$critical_issues" ]]; then
        echo "$critical_issues"
    fi
    if [[ -z "$blocking_issues" && -z "$critical_issues" ]]; then
        echo "  No open blocking/critical issues found."
    fi
    
    echo ""
    add_result "Open Blocking Issues" true
    return 0
}
```

### Step 2: Consider deduplication (optional enhancement)

If duplicates are a concern (issues with both labels showing twice), add deduplication:

```bash
# Combine and deduplicate
local all_issues
all_issues=$(echo -e "${blocking_issues}\n${critical_issues}" | sort -u | grep -v '^$')

if [[ -n "$all_issues" ]]; then
    echo "$all_issues"
else
    echo "  No open blocking/critical issues found."
fi
```

### Step 3: Update tests (if tests exist for this function)

**File:** `tests/unit/check-release-readiness.bats`

**Consider adding:**
- Test with mocked gh CLI returning "blocking" labeled issue
- Test with mocked gh CLI returning "critical" labeled issue
- Verify both are included in output

---

## ✅ Definition of Done

- [x] Issue extracted from Sourcery review
- [x] Fix plan documented
- [ ] Implementation option chosen (recommend Option 1)
- [ ] Fix implemented
- [ ] Tests updated (if applicable)
- [ ] Script correctly finds "blocking" labeled issues
- [ ] Script correctly finds "critical" labeled issues
- [ ] Script finds issues with both labels (no duplicates if dedup added)
- [ ] All existing tests still pass
- [ ] Fix validated locally
- [ ] Changes committed
- [ ] Ready for PR (or marked as deferred)

---

## 🔗 Related

- **Sourcery Review:** `admin/feedback/sourcery/pr32.md`
- **Script:** `scripts/check-release-readiness.sh`
- **Tests:** `tests/unit/check-release-readiness.bats`
- **Original PR:** #32

---

**Decision Point:** Can this be deferred?
- **YES, if:** Data gathering for blocking/critical issues is not yet critical for release readiness workflow
- **NO, if:** This data gathering is actively being used and accuracy is important

**Recommendation:** Defer to a future PR since data gathering is informational, not blocking. Fix batch-high-low-01 (Comment #2) should be fixed first as it causes false failures.

---

**Last Updated:** 2025-12-09

