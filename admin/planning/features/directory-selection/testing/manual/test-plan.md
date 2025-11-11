# Manual Testing Plan

**Purpose:** Detailed manual testing plan for directory selection feature  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-11-11

---

## 🎯 Testing Objectives

1. Validate directory selection prompt works correctly
2. Verify path resolution handles all path types
3. Test error handling and user feedback
4. Validate project name validation improvements
5. Test GitHub authentication verification
6. Verify end-to-end project creation flow

---

## 📋 Test Scenarios

### Scenario 1: Default Directory

**Objective:** Verify default directory logic works correctly

**Steps:**
1. Run script with `$HOME/Projects/` existing
2. Press Enter at directory prompt
3. Verify default is used

**Expected:**
- Default directory shown in prompt
- Project created in `$HOME/Projects/`

**Status:** ✅ Passed

---

### Scenario 2: Default Directory Doesn't Exist

**Objective:** Verify default directory creation prompt

**Steps:**
1. Temporarily rename `$HOME/Projects/`
2. Run script
3. Verify creation prompt appears
4. Test both yes and no responses

**Expected:**
- Prompt to create default directory
- Falls back to current directory if declined
- Creates directory if accepted

**Status:** ✅ Passed

---

### Scenario 3: Custom Absolute Path

**Objective:** Verify absolute path handling

**Steps:**
1. Enter absolute path (e.g., `/Users/username/custom/path`)
2. Test with existing and non-existent paths
3. Verify path resolution

**Expected:**
- Path resolved correctly
- Non-existent paths prompt for creation
- Full path shown in summary

**Status:** ✅ Passed

---

### Scenario 4: Custom Relative Path

**Objective:** Verify relative path handling

**Steps:**
1. Enter relative path (e.g., `./subdir` or `../parent`)
2. Verify path resolution to absolute
3. Test with non-existent paths

**Expected:**
- Relative paths resolved to absolute
- Correct location for project creation

**Status:** ✅ Passed

---

### Scenario 5: Environment Variable Expansion

**Objective:** Verify environment variable expansion

**Steps:**
1. Enter path with `$HOME` (e.g., `$HOME/Projects/custom`)
2. Enter path with `$USER`
3. Enter path with `$PWD`
4. Test both `$VAR` and `${VAR}` syntax

**Expected:**
- All environment variables expanded correctly
- Paths resolved properly

**Status:** ✅ Passed

---

### Scenario 6: Project Name with Spaces

**Objective:** Verify project name validation improvements

**Steps:**
1. Enter project name with spaces
2. Verify error message explains why spaces aren't allowed
3. Test space-to-dash replacement option
4. Verify sanitized name is used if accepted

**Expected:**
- Clear error message about spaces
- Option to replace with dashes
- Sanitized name used if accepted

**Status:** ✅ Passed

---

### Scenario 7: GitHub Authentication Verification

**Objective:** Verify GitHub auth verification

**Steps:**
1. Run script with author name
2. Choose to create GitHub repository
3. Verify auth check runs
4. Test with matching and non-matching author names
5. Test with multiple GitHub accounts

**Expected:**
- Auth verification runs before repo creation
- Warning if author doesn't match GitHub user
- User confirmation for mismatches
- Correct account used for repo creation

**Status:** ✅ Passed

---

### Scenario 8: Error Handling

**Objective:** Verify comprehensive error handling

**Steps:**
1. Test non-existent paths
2. Test non-writable directories
3. Test invalid project names
4. Test GitHub auth failures

**Expected:**
- No silent failures
- Clear error messages
- Actionable suggestions

**Status:** ✅ Passed

---

### Scenario 9: End-to-End Flow

**Objective:** Verify complete project creation flow

**Steps:**
1. Run script with custom directory
2. Enter project name
3. Select project type
4. Initialize git repository
5. Create GitHub repository (optional)
6. Verify project structure

**Expected:**
- All steps complete successfully
- Project created in correct location
- All files customized correctly
- Git and GitHub integration work

**Status:** 🟠 In Progress

---

## 📝 Test Results

See [results.md](results.md) for detailed test results.

---

## 🔗 Related Documentation

- **[Manual Testing Hub](README.md)** - Manual testing overview
- **[Test Results](results.md)** - Detailed test results
- **[Testing Fixes](../../fix/README.md)** - Issues found and fixes

---

**Last Updated:** 2025-11-11  
**Status:** 🟠 In Progress

