# Implementation Plan: PR04 Feedback Fixes

**Purpose:** Plan for implementing fixes from PR04 code review feedback  
**Status:** 🟡 Planned  
**Last Updated:** 2025-11-11

---

## 🎯 Overview

This document outlines the implementation plan for addressing critical and high-priority issues identified in PR04 code review feedback from Sourcery and Bugbot.

---

## 🔴 Critical Issues (Must Fix)

### Fix 1: Project Name Mismatch

**Issue:** When project name with spaces is sanitized, summary shows original name but project uses sanitized name.

**Location:** `scripts/new-project.sh` - `validate_project_name()` and `main()` function

**Current Behavior:**
- User enters "my project"
- `validate_project_name()` sanitizes to "my-project" and returns full path
- `main()` still uses original "my project" in summary
- Project created as "my-project" but summary shows "my project"

**Solution:**
1. Update `validate_project_name()` to return both sanitized name and full path
2. Or update `main()` to extract project name from full path using `basename`
3. Use sanitized name in project summary

**Implementation:**
```bash
# Option 1: Return sanitized name from validate_project_name
# Modify function to echo both name and path, or use separate return

# Option 2: Extract from path (simpler)
local project_name=$(basename "$full_project_path")
```

**Files to Modify:**
- `scripts/new-project.sh` - `main()` function around line 567-621

**Effort:** 🟢 LOW  
**Priority:** 🔴 CRITICAL

---

### Fix 2: Missing jq Dependency

**Issue:** `verify_github_auth()` uses `jq` without checking if it's installed, causing script failure.

**Location:** `scripts/new-project.sh:362` - `verify_github_auth()` function

**Current Code:**
```bash
user_info=$(gh api user --jq '{name: .name, login: .login, email: .email}' 2>/dev/null)
if [ -n "$user_info" ]; then
    print_status "Authenticated as: $(echo "$user_info" | jq -r '.login // "unknown"')"
fi
```

**Solution:**
Use `gh`'s built-in `--jq` flag directly instead of piping through `jq`.

**Implementation:**
```bash
# Replace:
print_status "Authenticated as: $(echo "$user_info" | jq -r '.login // "unknown"')"

# With:
local github_login
github_login=$(gh api user --jq '.login // "unknown"' 2>/dev/null)
if [ -n "$github_login" ]; then
    print_status "Authenticated as: $github_login"
fi
```

**Files to Modify:**
- `scripts/new-project.sh` - `verify_github_auth()` function around line 359-363

**Effort:** 🟢 LOW  
**Priority:** 🔴 CRITICAL

---

## 🟠 High Priority Issues (Should Fix)

### Fix 3: GitHub CLI Fallback

**Issue:** No fallback guidance when GitHub CLI is not installed.

**Location:** `scripts/new-project.sh:319-324` - `verify_github_auth()` function

**Solution:**
Add manual repository creation instructions when `gh` is not available.

**Implementation:**
Add detailed instructions after error message:
- Link to GitHub CLI installation
- Manual repository creation steps
- Git commands for manual setup

**Effort:** 🟡 MEDIUM  
**Priority:** 🟠 HIGH

---

### Fix 4: Auth Troubleshooting

**Issue:** Authentication check doesn't provide troubleshooting guidance.

**Location:** `scripts/new-project.sh:326-331` - `verify_github_auth()` function

**Solution:**
Add troubleshooting steps for authentication failures:
- Refresh token command
- Re-authenticate instructions
- Help documentation links

**Effort:** 🟡 MEDIUM  
**Priority:** 🟠 HIGH

---

### Fix 5: Error Visibility

**Issue:** Suppressing errors from `gh repo create` hides useful debugging information.

**Location:** `scripts/new-project.sh:404` - `init_git_repo()` function

**Solution:**
Remove `2>/dev/null` from `gh repo create` to show errors to users.

**Implementation:**
```bash
# Change from:
if gh repo create "$repo_name" --description "$repo_description" $is_private 2>/dev/null; then

# To:
if gh repo create "$repo_name" --description "$repo_description" $is_private; then
```

**Effort:** 🟢 LOW  
**Priority:** 🟠 HIGH

---

## 🟡 Medium Priority Issues (Nice to Have)

### Fix 6: Trailing Slash Removal

**Issue:** Only removes one trailing slash, doesn't handle multiple slashes like `/foo/bar///`.

**Location:** `scripts/new-project.sh:136` - `validate_target_directory()` function

**Solution:**
Use pattern that removes all trailing slashes:
```bash
# Change from:
dir_path="${dir_path%/}"

# To:
while [[ "$dir_path" =~ /$ ]]; do
    dir_path="${dir_path%/}"
done
# Or use parameter expansion:
dir_path="${dir_path%%+(/)}"
```

**Effort:** 🟢 LOW  
**Priority:** 🟡 MEDIUM

---

### Fix 7: Whitespace Sanitization

**Issue:** Only replaces spaces, not tabs or newlines.

**Location:** `scripts/new-project.sh:176-187` - `validate_project_name()` function

**Solution:**
Replace all whitespace characters using `sed`:
```bash
# Change from:
local sanitized_name="${name// /-}"

# To:
local sanitized_name
sanitized_name=$(echo "$name" | sed 's/[[:space:]]\+/-/g')
```

**Effort:** 🟢 LOW  
**Priority:** 🟡 MEDIUM

---

### Fix 8: Path Concatenation

**Issue:** Concatenation may result in double slashes.

**Location:** `scripts/new-project.sh:199` - `validate_project_name()` function

**Solution:**
Normalize path concatenation:
```bash
# Change from:
local full_path="$target_dir/$name"

# To:
# Remove trailing slash from target_dir, add single slash
target_dir="${target_dir%/}"
local full_path="$target_dir/$name"
```

**Effort:** 🟢 LOW  
**Priority:** 🟡 MEDIUM

---

## 📋 Implementation Order

### Phase 1: Critical Fixes (Must Do)
1. ✅ Fix 1: Project Name Mismatch - Complete
2. ✅ Fix 2: Missing jq Dependency - Complete

### Phase 2: High Priority Fixes (Should Do)
3. ✅ Fix 5: Error Visibility - Complete
4. ✅ Fix 3: GitHub CLI Fallback - Complete
5. ✅ Fix 4: Auth Troubleshooting - Complete

### Phase 3: Medium Priority Fixes (Nice to Have)
6. ✅ Fix 6: Trailing Slash Removal - Complete
7. ✅ Fix 7: Whitespace Sanitization - Complete
8. ✅ Fix 8: Path Concatenation - Complete

**All fixes implemented!**

---

## 🧪 Testing Plan

After each fix:
1. Test the specific scenario that was broken
2. Verify fix doesn't break existing functionality
3. Update test results documentation

### Test Cases for Critical Fixes

**Fix 1 - Project Name Mismatch:**
- Enter project name with spaces
- Verify sanitized name appears in summary
- Verify project created with sanitized name

**Fix 2 - Missing jq Dependency:**
- Test on system without `jq` installed
- Verify script doesn't fail
- Verify GitHub auth still works

---

## 📝 Notes

- All critical fixes should be implemented before next release
- High priority fixes significantly improve UX
- Medium priority fixes are edge cases but improve robustness
- Consider batching fixes by priority for easier review

---

## 🔗 Related Documentation

- **[PR04 Sourcery Review](../../../feedback/sourcery/pr04.md)** - Full Sourcery review
- **[PR04 Bugbot Review](../../../feedback/bugbot/pr04.md)** - Bugbot issues
- **[Fix README](README.md)** - Overview of all fixes

---

**Last Updated:** 2025-11-11  
**Status:** ✅ Complete  
**Implementation:** All 8 fixes implemented in commit [to be added]

