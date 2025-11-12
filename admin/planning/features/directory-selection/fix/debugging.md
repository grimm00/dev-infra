# Debugging: Script Exit Issue

**Purpose:** Document investigation of script exiting when entering non-existent directory  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-11-11

---

## 🐛 Issue Description

**Problem:** Script exits silently when user enters a non-existent directory path.

**Steps to Reproduce:**
1. Run `./scripts/new-project.sh`
2. Enter a non-existent directory (e.g., `/Users/cdwilson/boom` or `testdir`)
3. Script exits without prompting to create directory

**Expected Behavior:**
- Script should prompt: "Directory 'X' doesn't exist. Create it?"
- User can choose to create directory or cancel

**Actual Behavior:**
- Script exits immediately without any prompt or error message

---

## 🔍 Investigation Steps

### Step 1: Verify Function Returns Correctly

**Test:** Check if `validate_target_directory` returns proper error codes

**Findings:**
- [ ] Function returns path correctly
- [ ] Function returns error code 3 for non-existent directory with existing parent
- [ ] Function returns error code 1 for non-existent directory with non-existent parent

---

### Step 2: Check set -e Impact

**Test:** Verify `set -e` behavior in function

**Current Implementation:**
- `set +e` at start of function
- `set -e` before each return

**Potential Issues:**
- [ ] Commands between `set +e` and `set -e` might still cause issues
- [ ] Command substitution `$(...)` might be affected differently
- [ ] Need to check if `set -e` state persists after function call

---

### Step 3: Test Command Substitution

**Test:** Check if command substitution is causing exit

**Code:**
```bash
resolved_dir=$(validate_target_directory "$target_dir" 2>/dev/null)
local error_code=$?
```

**Potential Issues:**
- [ ] Command substitution might exit if function fails
- [ ] `2>/dev/null` might hide important errors
- [ ] Error code capture might not work correctly

---

### Step 4: Test Case Statement

**Test:** Verify case statement handles all error codes

**Current Cases:**
- `0` - Directory exists and writable
- `3` - Directory doesn't exist, parent exists and writable
- `1` - Directory doesn't exist, parent doesn't exist
- `2` - Directory/parent not writable
- `*` - Default case (exits)

**Potential Issues:**
- [ ] Default case might be catching unexpected error codes
- [ ] Error code might not be what we expect

---

### Step 5: Test Path Resolution

**Test:** Verify path resolution works for different scenarios

**Scenarios to Test:**
- [ ] Absolute path, parent exists, directory doesn't exist
- [ ] Absolute path, parent doesn't exist, directory doesn't exist
- [ ] Relative path, parent exists, directory doesn't exist
- [ ] Relative path, parent doesn't exist, directory doesn't exist
- [ ] Path with environment variables

---

## 📝 Test Results

### Test 1: Basic Function Call

**Command:**
```bash
validate_target_directory "/Users/cdwilson/boom"
```

**Result:**
- [ ] Path returned: `_____________`
- [ ] Error code: `_____`
- [ ] Expected: Path `/Users/cdwilson/boom`, code `3`

---

### Test 2: Command Substitution

**Command:**
```bash
resolved_dir=$(validate_target_directory "/Users/cdwilson/boom" 2>/dev/null)
echo "Path: $resolved_dir"
echo "Code: $?"
```

**Result:**
- [ ] Path captured: `_____________`
- [ ] Error code: `_____`
- [ ] Script continues: Yes/No

---

### Test 3: Command Substitution with set -e

**Issue Found:** Command substitution with `set -e` enabled can cause script to exit if function fails.

**Solution:** Disable `set -e` around the command substitution call.

**Code:**
```bash
set +e
resolved_dir=$(validate_target_directory "$target_dir" 2>/dev/null)
error_code=$?
set -e
```

---

### Test 4: Full Script Execution

**Command:**
```bash
echo "/Users/cdwilson/boom" | ./scripts/new-project.sh
```

**Result:**
- [ ] Script exits: Yes/No
- [ ] Error message shown: Yes/No
- [ ] Prompt shown: Yes/No

---

## 🔧 Potential Fixes

### Fix 1: Remove set -e from Function

**Approach:** Don't re-enable `set -e` in function, let caller handle it

**Pros:**
- Simpler logic
- No state management

**Cons:**
- Need to ensure caller handles errors

---

### Fix 2: Use Explicit Error Handling

**Approach:** Wrap function call in error handling

**Code:**
```bash
set +e
resolved_dir=$(validate_target_directory "$target_dir" 2>/dev/null)
error_code=$?
set -e
```

**Pros:**
- Explicit control
- Clear error handling

**Cons:**
- More verbose

---

### Fix 3: Return Error Codes Differently

**Approach:** Use global variable or file for error code

**Pros:**
- Avoids command substitution issues

**Cons:**
- Less clean
- More complex

---

## 📊 Debugging Log

**2025-11-11:**
- Issue identified: Script exits when entering non-existent directory
- Root cause: `set -e` in main script causes command substitution to exit on function failure
- Fix 1: Disable `set -e` in function - Not sufficient (command substitution still affected)
- Fix 2: Disable `set -e` around command substitution call - Applied
- Fix 3: Improve path normalization error handling - Applied
- Manual testing: ✅ Working correctly after fixes
- Status: ✅ Resolved - Ready for automated testing

---

## 🔗 Related Documentation

- **[Implementation Plan](implementation-plan.md)** - Overall fix plan
- **[Fix README](README.md)** - Overview of fixes

---

## ✅ Resolution Summary

**Final Fix:** Disable `set -e` around command substitution call in main function

**Iterations:**
1. **First attempt:** Disable `set -e` only in function - Insufficient
2. **Second attempt:** Improve path normalization error handling - Partial fix
3. **Final fix:** Disable `set -e` around command substitution call - ✅ Success

**Key Learning:** When using `set -e`, command substitution `$(...)` will cause script exit if the function returns non-zero, even if those are expected error codes. Must disable `set -e` around the call site.

**Commits:**
- `8490c15` - Disable set -e for entire validate_target_directory function
- `ca50669` - Disable set -e around validate_target_directory call (final fix)

---

**Last Updated:** 2025-11-11  
**Status:** ✅ Resolved

