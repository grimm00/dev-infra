# Phase 2: Path Handling Updates

**Purpose:** Update all functions to use full project paths instead of relative paths  
**Status:** 🟡 Planned  
**Last Updated:** 2025-11-10

---

## 🎯 Phase Overview

This phase updates all functions in `new-project.sh` to accept and use full absolute paths for project operations, ensuring consistent path handling throughout the script.

---

## 📋 Implementation Tasks

### Task 1: Update `validate_project_name()`

**Current Signature:**
```bash
validate_project_name() {
    local name="$1"
    # Checks if directory exists in current directory
}
```

**New Signature:**
```bash
validate_project_name() {
    local name="$1"
    local target_dir="$2"
    
    # Build full project path
    local full_path="$target_dir/$name"
    
    # Check if name is empty
    if [ -z "$name" ]; then
        print_error "Project name cannot be empty"
        return 1
    fi
    
    # Check if name contains only valid characters
    if [[ ! "$name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        print_error "Project name can only contain letters, numbers, hyphens, and underscores"
        return 1
    fi
    
    # Check if directory already exists in target location
    if [ -d "$full_path" ]; then
        print_error "Directory '$full_path' already exists"
        return 1
    fi
    
    echo "$full_path"
    return 0
}
```

**Changes:**
- Accept `target_dir` parameter
- Build full project path
- Check existence in target directory, not current directory
- Return full path instead of just name

### Task 2: Update `copy_template()`

**Current Signature:**
```bash
copy_template() {
    local template_type="$1"
    local project_name="$2"
    # Copies to relative path
}
```

**New Signature:**
```bash
copy_template() {
    local template_type="$1"
    local full_project_path="$2"
    local template_dir="$DEV_INFRA_DIR/templates/$template_type"
    
    print_status "Copying $template_type template..."
    
    if [ ! -d "$template_dir" ]; then
        print_error "Template directory not found: $template_dir"
        return 1
    fi
    
    # Copy template including hidden files
    cp -r "$template_dir" "$full_project_path"
    
    # Verify important files were copied
    if [ ! -f "$full_project_path/.gitignore" ]; then
        print_warning ".gitignore not found - template may need updating"
    fi
    
    print_success "Template copied successfully"
}
```

**Changes:**
- Accept `full_project_path` instead of `project_name`
- Use absolute path for copying
- Update verification to use full path

### Task 3: Update `customize_project()`

**Current Signature:**
```bash
customize_project() {
    local project_name="$1"
    # Uses relative path for file operations
}
```

**New Signature:**
```bash
customize_project() {
    local full_project_path="$1"
    local project_type="$2"
    local description="$3"
    local author="$4"
    local current_date=$(date +"%Y-%m-%d")
    
    # Extract project name from path
    local project_name=$(basename "$full_project_path")
    
    print_status "Customizing project files..."
    
    # Update README.md using full path
    if [ -f "$full_project_path/README.md" ]; then
        sed -i.bak "s/\[Project Name\]/$project_name/g" "$full_project_path/README.md"
        # ... rest of customization
    fi
    
    # Similar updates for other files using full_project_path
}
```

**Changes:**
- Accept `full_project_path` as first parameter
- Extract project name from path using `basename`
- Update all file operations to use full path
- Update all `sed` commands to use full path

### Task 4: Update `init_git_repo()`

**Current Signature:**
```bash
init_git_repo() {
    local project_name="$1"
    # Changes to relative directory
}
```

**New Signature:**
```bash
init_git_repo() {
    local full_project_path="$1"
    local project_name=$(basename "$full_project_path")
    
    if prompt_yes_no "Initialize git repository?" "y"; then
        print_status "Initializing git repository..."
        
        cd "$full_project_path"
        git init
        git add .
        git commit -m "Initial commit: $project_name created from dev-infra template"
        
        print_success "Git repository initialized"
        
        # GitHub repo creation logic using full_project_path
        # ...
        
        # Return to original directory
        cd - > /dev/null
    fi
}
```

**Changes:**
- Accept `full_project_path` instead of `project_name`
- Extract project name from path
- Use absolute path for `cd`
- Return to original directory after operations

### Task 5: Update `show_next_steps()`

**Current Signature:**
```bash
show_next_steps() {
    local project_name="$1"
    # Shows relative path in instructions
}
```

**New Signature:**
```bash
show_next_steps() {
    local full_project_path="$1"
    local project_type="$2"
    local project_name=$(basename "$full_project_path")
    
    echo
    print_success "Project '$project_name' created successfully!"
    echo
    echo "Next steps:"
    echo "1. cd $full_project_path"
    echo "2. Review and customize start.txt"
    # ... rest of next steps using full_project_path
}
```

**Changes:**
- Accept `full_project_path` instead of `project_name`
- Extract project name from path
- Display full path in "cd" instruction
- Use full path in all instructions

### Task 6: Update `main()` Function

**Changes:**
- Call `validate_project_name()` with `TARGET_DIR` parameter
- Store returned full path in `FULL_PROJECT_PATH`
- Pass `FULL_PROJECT_PATH` to all functions
- Update project summary to show full path

**Example:**
```bash
# Get project name and validate
local project_name=$(prompt_input "Project name")
local full_project_path
while ! full_project_path=$(validate_project_name "$project_name" "$TARGET_DIR"); do
    project_name=$(prompt_input "Project name")
done

# Update project summary
echo "Project Summary:"
echo "Name: $project_name"
echo "Location: $full_project_path"
# ...

# Create project using full path
copy_template "$template_type" "$full_project_path"
customize_project "$full_project_path" "$project_type" "$description" "$author"
init_git_repo "$full_project_path"
show_next_steps "$full_project_path" "$project_type"
```

---

## 🧪 Testing

### Test Cases

1. **Absolute path:**
   - Target: `/Users/username/Projects/my-project`
   - Verify all operations use full path

2. **Relative path:**
   - Target: `./subdir/my-project`
   - Verify path is resolved to absolute

3. **Default directory:**
   - Target: `$HOME/Projects/my-project`
   - Verify full path is used

4. **Nested directories:**
   - Target: `$HOME/Projects/workspace/my-project`
   - Verify all operations work correctly

---

## 📝 Code Changes Summary

**Files Modified:**
- `scripts/new-project.sh`

**Functions Updated:**
- `validate_project_name()` - Accepts target_dir, returns full path
- `copy_template()` - Uses full_project_path
- `customize_project()` - Uses full_project_path
- `init_git_repo()` - Uses full_project_path
- `show_next_steps()` - Uses full_project_path
- `main()` - Passes full paths to all functions

**New Variables:**
- `FULL_PROJECT_PATH` - Stores complete absolute path to project

---

## ✅ Acceptance Criteria

- [ ] All functions accept full project paths
- [ ] All file operations use absolute paths
- [ ] Path resolution works for all path types
- [ ] Project summary shows full path
- [ ] Next steps show correct full path
- [ ] Git operations work with full paths
- [ ] No relative path assumptions remain
- [ ] Script works from any directory

---

## 🔗 Related Documents

- **[Feature Plan](feature-plan.md)** - Overall feature plan
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress
- **[Phase 1](phase-1-directory-prompt.md)** - Previous phase
- **[Phase 3](phase-3-validation-testing.md)** - Next phase

---

**Last Updated:** 2025-11-10  
**Status:** 🟡 Planned  
**Next:** [Phase 3: Validation & Testing](phase-3-validation-testing.md)

