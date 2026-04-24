# Phase 1: Directory Selection Prompt

**Purpose:** Add directory selection prompt with default directory logic  
**Status:** 🟡 Planned  
**Last Updated:** 2025-11-10

---

## 🎯 Phase Overview

This phase adds the directory selection prompt to the `main()` function, implements the default directory logic (`$HOME/Projects/`), and provides basic validation for the target directory.

---

## 📋 Implementation Tasks

### Task 1: Create Directory Validation Function

**Location:** `scripts/new-project.sh`

**New Function:** `validate_target_directory()`

**Purpose:** Validate target directory exists, is writable, and can be used

**Implementation:**
```bash
validate_target_directory() {
    local dir_path="$1"
    
    # Expand ~ to home directory
    dir_path="${dir_path/#\~/$HOME}"
    
    # Resolve to absolute path
    if [[ ! "$dir_path" =~ ^/ ]]; then
        dir_path="$(cd "$dir_path" 2>/dev/null && pwd || echo "$(pwd)/$dir_path")"
    fi
    
    # Check if directory exists
    if [ ! -d "$dir_path" ]; then
        return 1  # Directory doesn't exist
    fi
    
    # Check if directory is writable
    if [ ! -w "$dir_path" ]; then
        return 2  # Directory not writable
    fi
    
    echo "$dir_path"
    return 0
}
```

### Task 2: Add Default Directory Logic

**Location:** `scripts/new-project.sh` - `main()` function

**Logic:**
1. Check if `$HOME/Projects/` exists
2. If exists, set as default
3. If not exists, prompt to create: "Directory $HOME/Projects/ doesn't exist. Create it? [y/N]"
4. If user declines, fallback to current directory (`$PWD`)

**Implementation:**
```bash
# Determine default directory
DEFAULT_DIR="$HOME/Projects"
if [ ! -d "$DEFAULT_DIR" ]; then
    if prompt_yes_no "Directory $DEFAULT_DIR doesn't exist. Create it?" "n"; then
        mkdir -p "$DEFAULT_DIR"
        print_success "Created directory: $DEFAULT_DIR"
    else
        DEFAULT_DIR="$PWD"
        print_status "Using current directory as default"
    fi
fi
```

### Task 3: Add Directory Prompt

**Location:** `scripts/new-project.sh` - `main()` function, after project name prompt

**Prompt:**
```bash
local target_dir=$(prompt_input "Target directory (press Enter for $DEFAULT_DIR or enter custom path)" "$DEFAULT_DIR")
```

**Clarification:** Make it clear users can enter any path (absolute or relative)

### Task 4: Validate and Resolve Directory

**Location:** `scripts/new-project.sh` - `main()` function, after directory prompt

**Implementation:**
```bash
# Validate and resolve target directory
local resolved_dir
if resolved_dir=$(validate_target_directory "$target_dir"); then
    TARGET_DIR="$resolved_dir"
else
    local error_code=$?
    case $error_code in
        1)
            if prompt_yes_no "Directory '$target_dir' doesn't exist. Create it?" "n"; then
                mkdir -p "$target_dir"
                TARGET_DIR="$(cd "$target_dir" && pwd)"
                print_success "Created directory: $TARGET_DIR"
            else
                print_error "Cannot proceed without valid directory"
                return 1
            fi
            ;;
        2)
            print_error "Directory '$target_dir' is not writable"
            return 1
            ;;
        *)
            print_error "Invalid directory: $target_dir"
            return 1
            ;;
    esac
fi
```

---

## 🧪 Testing

### Test Cases

1. **Default directory exists:**
   - `$HOME/Projects/` exists
   - Press Enter → uses `$HOME/Projects/`

2. **Default directory doesn't exist:**
   - `$HOME/Projects/` doesn't exist
   - Prompt to create → yes → creates and uses
   - Prompt to create → no → uses current directory

3. **Custom absolute path:**
   - Enter `/Users/username/custom/path`
   - Validates and uses path

4. **Custom relative path:**
   - Enter `./subdir` or `../parent`
   - Resolves to absolute path

5. **Tilde expansion:**
   - Enter `~/Projects/custom`
   - Expands to `$HOME/Projects/custom`

6. **Non-existent directory:**
   - Enter non-existent path
   - Prompts to create
   - Creates if confirmed

7. **Non-writable directory:**
   - Enter directory without write permissions
   - Shows error message

---

## 📝 Code Changes Summary

**Files Modified:**
- `scripts/new-project.sh`

**New Functions:**
- `validate_target_directory()` - Validates and resolves directory path

**Modified Functions:**
- `main()` - Adds directory selection prompt and logic

**New Variables:**
- `TARGET_DIR` - Stores resolved absolute path to target directory
- `DEFAULT_DIR` - Stores default directory path

---

## ✅ Acceptance Criteria

- [ ] User can press Enter to use default directory
- [ ] Default directory logic works (`$HOME/Projects/` or current directory)
- [ ] User can enter custom absolute path
- [ ] User can enter custom relative path
- [ ] Tilde expansion works (`~` → `$HOME`)
- [ ] Non-existent directories prompt for creation
- [ ] Non-writable directories show clear error
- [ ] All paths are resolved to absolute paths
- [ ] Clear error messages for all failure cases

---

## 🔗 Related Documents

- **[Feature Plan](feature-plan.md)** - Overall feature plan
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress
- **[Phase 2](phase-2-path-handling.md)** - Next phase

---

**Last Updated:** 2025-11-10  
**Status:** 🟡 Planned  
**Next:** [Phase 2: Path Handling Updates](phase-2-path-handling.md)

