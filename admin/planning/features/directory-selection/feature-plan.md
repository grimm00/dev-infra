# Directory Selection Feature Plan

**Purpose:** High-level implementation plan for directory selection feature  
**Status:** 🟡 Planned  
**Last Updated:** 2025-11-10

---

## 🎯 Feature Description

Enhance the `new-project.sh` script to allow users to choose the target directory where their project will be generated. This provides flexibility for users to organize their projects in their preferred directory structure while maintaining backward compatibility with the current behavior.

---

## 🔍 User Problem

Currently, `new-project.sh` always creates projects in the current working directory. Users must:
- Navigate to their desired directory before running the script
- Or manually move projects after creation
- Or remember to change directories each time

This is inconvenient and doesn't match common development workflows where projects are organized in a specific directory (e.g., `~/Projects/`).

---

## ✅ Success Criteria

1. **User can specify target directory** - Prompt for directory with clear default
2. **Default directory works** - `$HOME/Projects/` is used as default if it exists
3. **Path flexibility** - Supports absolute paths, relative paths, `~` expansion, and environment variables ($HOME, $USER, $PWD)
4. **Validation** - Comprehensive checks for existence, permissions, and validity
5. **Backward compatibility** - Falls back to current directory if default doesn't exist and user declines creation
6. **Clear feedback** - Shows full project path in summary and next steps
7. **Error handling** - Helpful error messages for common issues
8. **Project name validation** - Clear error messages and automatic space-to-dash replacement
9. **GitHub integration** - Authentication verification and account matching before repo creation

---

## 📋 Implementation Phases

### Phase 1: Directory Selection Prompt
- Add prompt for target directory
- Implement default directory logic (`$HOME/Projects/`)
- Basic validation (existence, writability)
- Handle directory creation prompt
- Environment variable expansion ($HOME, $USER, $PWD)
- Comprehensive error handling

### Phase 2: Path Handling Updates
- Update all functions to use full paths
- Implement path resolution (absolute, relative, `~` expansion, env vars)
- Update function signatures
- Modify all file operations to use absolute paths

### Phase 3: Manual Testing & Enhancements
- Fix silent failure issues
- Improve project name validation with clear error messages
- Add automatic space-to-dash replacement for project names
- Add GitHub authentication verification
- Handle multiple GitHub accounts with user confirmation

### Phase 3: Validation & Testing
- Create comprehensive validation function
- Add edge case handling
- Test all scenarios
- Update documentation

---

## 🔗 Dependencies

- None - This is a standalone enhancement to existing script

---

## ⏱️ Timeline Estimate

- **Phase 1:** 1-2 hours
- **Phase 2:** 2-3 hours
- **Phase 3:** 1-2 hours
- **Total:** 4-7 hours

---

## 📝 Implementation Details

### Default Directory Logic

1. Check if `$HOME/Projects/` exists
2. If exists, use as default
3. If not exists, prompt to create: "Directory $HOME/Projects/ doesn't exist. Create it? [y/N]"
4. If user declines, fallback to current directory (`$PWD`)

### Path Resolution

- Expand `~` to home directory
- Resolve relative paths to absolute
- Normalize path (remove trailing slashes, resolve `..` and `.`)
- Store as absolute path for consistency

### Function Updates

All functions need to accept and use full project paths:
- `validate_project_name(name, target_dir)` → returns full project path
- `copy_template(template_type, full_project_path)`
- `customize_project(full_project_path, project_type, description, author)`
- `init_git_repo(full_project_path)`
- `show_next_steps(full_project_path, project_type)`

---

## 🧪 Testing Considerations

### Test Cases

- Current directory (default fallback)
- Absolute path (`/Users/username/Projects`)
- Relative path (`./subdir`, `../parent-dir`)
- `~` expansion (`~/Projects`)
- Non-existent directory (with creation prompt)
- Directory without write permissions
- Path with spaces
- Path with special characters
- Nested directory creation

---

## 📚 Related Documentation

- **[Status & Next Steps](status-and-next-steps.md)** - Current progress
- **[Phase 1](phase-1-directory-prompt.md)** - Directory prompt implementation
- **[Phase 2](phase-2-path-handling.md)** - Path handling updates
- **[Phase 3](phase-3-validation-testing.md)** - Validation and testing

---

## 🆕 Additional Features (From Manual Testing)

**Project Name Validation:**
- Clear error messages explaining why spaces aren't allowed
- Automatic space-to-dash replacement option
- Better user experience for invalid project names

**GitHub Integration:**
- Authentication verification before repo creation
- Account matching with author name
- Support for multiple GitHub accounts
- Clear feedback on which account will be used

**Error Handling:**
- Comprehensive error messages for all failure cases
- No silent failures
- Actionable error messages with suggestions

---

**Last Updated:** 2025-11-11  
**Status:** 🟠 In Progress  
**Next:** [Status & Next Steps](status-and-next-steps.md)

