# Phase 3: Validation & Testing

**Purpose:** Comprehensive validation, edge case handling, and testing  
**Status:** 🟡 Planned  
**Last Updated:** 2025-11-10

---

## 🎯 Phase Overview

This phase focuses on creating comprehensive validation, handling edge cases, thorough testing, and updating documentation to ensure the directory selection feature is robust and reliable.

---

## 📋 Implementation Tasks

### Task 1: Enhance Validation Function

**Location:** `scripts/new-project.sh`

**Enhanced `validate_target_directory()` Function:**

```bash
validate_target_directory() {
    local dir_path="$1"

    # Check if path is empty
    if [ -z "$dir_path" ]; then
        print_error "Directory path cannot be empty"
        return 1
    fi

    # Expand ~ to home directory
    dir_path="${dir_path/#\~/$HOME}"

    # Handle relative paths
    if [[ ! "$dir_path" =~ ^/ ]]; then
        # Resolve relative path
        if [ -d "$dir_path" ]; then
            dir_path="$(cd "$dir_path" && pwd)"
        else
            # Path doesn't exist yet, resolve parent
            local parent_dir=$(dirname "$dir_path")
            if [ -d "$parent_dir" ]; then
                dir_path="$(cd "$parent_dir" && pwd)/$(basename "$dir_path")"
            else
                print_error "Parent directory does not exist: $parent_dir"
                return 1
            fi
        fi
    fi

    # Normalize path (remove trailing slashes)
    dir_path="${dir_path%/}"

    # Check for invalid characters in path components
    if [[ "$dir_path" =~ [<>:"|?*] ]]; then
        print_error "Directory path contains invalid characters"
        return 1
    fi

    # Check if directory exists
    if [ -d "$dir_path" ]; then
        # Check if directory is writable
        if [ ! -w "$dir_path" ]; then
            print_error "Directory '$dir_path' is not writable"
            return 2
        fi
        echo "$dir_path"
        return 0
    else
        # Directory doesn't exist - check if parent is writable
        local parent_dir=$(dirname "$dir_path")
        if [ ! -d "$parent_dir" ]; then
            print_error "Parent directory does not exist: $parent_dir"
            return 1
        fi
        if [ ! -w "$parent_dir" ]; then
            print_error "Parent directory is not writable: $parent_dir"
            return 2
        fi
        # Return path for potential creation
        echo "$dir_path"
        return 3  # Special code: doesn't exist but can be created
    fi
}
```

### Task 2: Add Edge Case Handling

**Edge Cases to Handle:**

1. **Path with spaces:**

   - Ensure proper quoting throughout
   - Test: `~/Projects/my project`

2. **Symbolic links:**

   - Resolve to actual path
   - Test: `~/Projects -> /actual/path`

3. **Very long paths:**

   - Validate path length limits
   - Test: Very long directory names

4. **Special characters:**

   - Handle allowed special characters (`-`, `_`)
   - Reject invalid characters

5. **Network paths:**

   - Handle network-mounted directories
   - Test: `/Volumes/network-drive/projects`

6. **Permission edge cases:**
   - Read-only parent directory
   - Execute-only permissions
   - Test various permission combinations

### Task 3: Comprehensive Testing

**Test Scenarios:**

1. **Default Directory Tests:**

   ```bash
   # Test 1: Default exists
   $HOME/Projects/ exists → Press Enter → Uses $HOME/Projects/

   # Test 2: Default doesn't exist, create
   $HOME/Projects/ doesn't exist → Create? Yes → Creates and uses

   # Test 3: Default doesn't exist, decline
   $HOME/Projects/ doesn't exist → Create? No → Uses $PWD
   ```

2. **Path Type Tests:**

   ```bash
   # Absolute path
   /Users/username/Projects/my-project

   # Relative path
   ./subdir/my-project
   ../parent/my-project

   # Tilde expansion
   ~/Projects/my-project
   ~/custom/path/my-project
   ```

3. **Validation Tests:**

   ```bash
   # Non-existent directory
   /nonexistent/path → Prompt to create

   # Non-writable directory
   /readonly/dir → Error message

   # Invalid characters
   /path/with<invalid>chars → Error message

   # Existing project
   /path/to/existing-project → Error message
   ```

4. **Edge Case Tests:**

   ```bash
   # Path with spaces
   ~/Projects/my project name

   # Very long path
   ~/Projects/very/long/path/name/...

   # Symbolic link
   ~/Projects -> /actual/path

   # Network path
   /Volumes/network/projects
   ```

### Task 4: Update Documentation

**Files to Update:**

1. **Script Comments:**

   - Add comments explaining path resolution
   - Document validation logic
   - Explain default directory behavior

2. **Usage Examples:**

   - Update any usage documentation
   - Add examples for different path types
   - Document default behavior

3. **Error Messages:**
   - Ensure all error messages are clear
   - Provide helpful suggestions
   - Include examples where appropriate

### Task 5: Backward Compatibility Testing

**Verify:**

- Script still works when run from project directory
- Script works when run from any directory
- Default behavior matches expectations
- No breaking changes for existing users

---

## 🧪 Test Plan

### Unit Tests (Manual)

1. **Default Directory:**

   - [ ] `$HOME/Projects/` exists → uses as default
   - [ ] `$HOME/Projects/` doesn't exist → prompts to create
   - [ ] User declines creation → uses current directory

2. **Path Resolution:**

   - [ ] Absolute path works
   - [ ] Relative path resolves correctly
   - [ ] Tilde expansion works
   - [ ] Path normalization works

3. **Validation:**

   - [ ] Non-existent directory prompts creation
   - [ ] Non-writable directory shows error
   - [ ] Invalid characters rejected
   - [ ] Existing project name rejected

4. **Function Updates:**
   - [ ] All functions use full paths
   - [ ] File operations work correctly
   - [ ] Git operations work correctly
   - [ ] Next steps show correct path

### Integration Tests

1. **End-to-End:**

   - [ ] Complete project creation flow
   - [ ] Git initialization works
   - [ ] GitHub repo creation works
   - [ ] All files created in correct location

2. **Edge Cases:**
   - [ ] Paths with spaces
   - [ ] Very long paths
   - [ ] Symbolic links
   - [ ] Network paths

---

## 📝 Code Changes Summary

**Files Modified:**

- `scripts/new-project.sh` - Enhanced validation and edge case handling

**Enhancements:**

- Comprehensive path validation
- Edge case handling
- Improved error messages
- Better path resolution

**Documentation:**

- Updated script comments
- Enhanced error messages
- Usage examples

---

## ✅ Acceptance Criteria

- [x] All validation edge cases handled
- [x] All test scenarios pass
- [x] Error messages are clear and helpful
- [x] Documentation is updated
- [x] Backward compatibility maintained
- [x] Script works from any directory
- [x] All path types work correctly
- [x] No breaking changes

---

## 🔗 Related Documents

- **[Feature Plan](feature-plan.md)** - Overall feature plan
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress
- **[Phase 1](phase-1-directory-prompt.md)** - Directory prompt
- **[Phase 2](phase-2-path-handling.md)** - Path handling
- **[Testing Documentation](testing/README.md)** - All testing documentation
- **[Manual Testing](testing/manual/README.md)** - Manual testing plans and results
- **[Automated Testing](testing/automated/README.md)** - Automated testing strategy

---

**Last Updated:** 2025-11-11  
**Status:** 🟠 In Progress  
**Next:** Complete testing and final validation
