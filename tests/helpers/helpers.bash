#!/bin/bash

# Test helper functions for new-project.sh testing
# This file provides utilities for testing the new-project.sh script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# PROJECT_ROOT is the parent of tests/ (equivalent to DEV_INFRA_DIR in actual script)
# SCRIPT_DIR is tests/helpers/, so we need to go up two levels: tests/helpers/ -> tests/ -> project root
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPT_PATH="$PROJECT_ROOT/scripts/new-project.sh"

# Extract and define functions directly to avoid sourcing issues
define_test_functions() {
    # Define expand_env_vars function
    expand_env_vars() {
        local path="$1"
        
        # Expand common environment variables
        path="${path//\$HOME/$HOME}"
        path="${path//\$USER/$USER}"
        path="${path//\$PWD/$PWD}"
        # Expand ~ to home
        path="${path/#\~/$HOME}"
        # Handle ${VAR} syntax
        path="${path//\$\{HOME\}/$HOME}"
        path="${path//\$\{USER\}/$USER}"
        path="${path//\$\{PWD\}/$PWD}"
        
        echo "$path"
    }
    
    # Define validate_target_directory function
    validate_target_directory() {
        local dir_path="$1"
        
        # Check if path is empty
        if [ -z "$dir_path" ]; then
            return 1
        fi
        
        # Expand environment variables first
        dir_path=$(expand_env_vars "$dir_path")
        
        # Check if expansion resulted in empty path
        if [ -z "$dir_path" ]; then
            return 1
        fi
        
        # Resolve to absolute path
        if [[ ! "$dir_path" =~ ^/ ]]; then
            # Relative path - try to resolve
            if [ -d "$dir_path" ]; then
                local resolved
                resolved="$(cd "$dir_path" 2>/dev/null && pwd 2>/dev/null)"
                if [ $? -eq 0 ] && [ -n "$resolved" ]; then
                    dir_path="$resolved"
                fi
            else
                # Path doesn't exist yet, resolve parent
                local parent_dir=$(dirname "$dir_path")
                if [ -d "$parent_dir" ]; then
                    local normalized_parent
                    normalized_parent="$(cd "$parent_dir" 2>/dev/null && pwd 2>/dev/null)"
                    if [ $? -eq 0 ] && [ -n "$normalized_parent" ]; then
                        dir_path="$normalized_parent/$(basename "$dir_path")"
                    fi
                else
                    # Parent doesn't exist - build absolute path from current directory
                    dir_path="$(pwd)/$dir_path"
                fi
            fi
        else
            # Absolute path - normalize if parent exists, otherwise keep as-is
            local parent_dir=$(dirname "$dir_path")
            local dir_name=$(basename "$dir_path")
            if [ -d "$parent_dir" ]; then
                # Normalize parent path (resolve symlinks, etc.)
                local normalized_parent
                normalized_parent="$(cd "$parent_dir" 2>/dev/null && pwd 2>/dev/null)"
                if [ $? -eq 0 ] && [ -n "$normalized_parent" ]; then
                    dir_path="$normalized_parent/$dir_name"
                fi
            fi
        fi
        
        # Normalize path (remove all trailing slashes, but keep '/' if root)
        while [[ "$dir_path" =~ /$ ]] && [[ "$dir_path" != "/" ]]; do
            dir_path="${dir_path%/}"
        done
        
        # Check if directory exists
        if [ -d "$dir_path" ]; then
            # Check if directory is writable
            if [ ! -w "$dir_path" ]; then
                echo "$dir_path"
                return 2  # Directory not writable
            fi
            echo "$dir_path"
            return 0
        else
            # Directory doesn't exist - check if parent is writable
            local parent_dir=$(dirname "$dir_path")
            if [ ! -d "$parent_dir" ]; then
                # Parent doesn't exist - return path anyway so caller can try to create full path
                echo "$dir_path"
                return 1  # Parent doesn't exist, but return path for creation attempt
            fi
            if [ ! -w "$parent_dir" ]; then
                echo "$dir_path"
                return 2  # Parent directory not writable
            fi
            # Return path for potential creation
            echo "$dir_path"
            return 3  # Special code: doesn't exist but can be created
        fi
    }
    
    # Define validate_project_name function (simplified for testing)
    validate_project_name() {
        local name="$1"
        local target_dir="$2"
        
        # Check if name is empty
        if [ -z "$name" ]; then
            return 1
        fi
        
        # Check if name contains any whitespace
        if [[ "$name" =~ [[:space:]] ]]; then
            return 1
        fi
        
        # Check if name contains only valid characters
        if [[ ! "$name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
            return 1
        fi
        
        # Build full project path (normalize to prevent double slashes)
        target_dir="${target_dir%/}"
        local full_path="$target_dir/$name"
        
        # Check if directory already exists in target location
        if [ -d "$full_path" ]; then
            return 1
        fi
        
        echo "$full_path"
        return 0
    }
    
    # Define copy_template function (aligned with scripts/new-project.sh)
    copy_template() {
        local template_type="$1"
        local full_project_path="$2"
        # Use PROJECT_ROOT directly (equivalent to DEV_INFRA_DIR in actual script)
        # PROJECT_ROOT is calculated as parent of tests/helpers/ = project root
        local template_dir="$PROJECT_ROOT/templates/$template_type"
        
        if [ ! -d "$template_dir" ]; then
            return 1
        fi
        
        # Copy template directory (matches actual script behavior)
        # cp -r will create $full_project_path as a copy of $template_dir
        # This matches: cp -r "$template_dir" "$full_project_path" in actual script
        cp -r "$template_dir" "$full_project_path"
        
        # Verify important files were copied (matches actual script - only warns, doesn't fail)
        # Actual script: print_warning ".gitignore not found - template may need updating"
        # Test helper: just continue (tests will verify .gitignore exists separately)
        # Note: We don't return 2 here because actual script doesn't fail on missing .gitignore
        
        return 0
    }
    
    # Define customize_project function (simplified for testing - no prompts)
    customize_project() {
        local full_project_path="$1"
        local project_type="$2"
        local description="$3"
        local author="$4"
        local current_date="${5:-$(date +"%Y-%m-%d")}"
        
        # Extract project name from path
        local project_name=$(basename "$full_project_path")
        
        # Update README.md
        if [ -f "$full_project_path/README.md" ]; then
            # Use portable sed -i syntax (works on both GNU and BSD/macOS)
            if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
                sed -i '' "s/\[Project Name\]/$project_name/g" "$full_project_path/README.md"
                sed -i '' "s/\[Brief description of what this project does\]/$description/g" "$full_project_path/README.md"
                sed -i '' "s/\[Date\]/$current_date/g" "$full_project_path/README.md"
            else
                sed -i "s/\[Project Name\]/$project_name/g" "$full_project_path/README.md"
                sed -i "s/\[Brief description of what this project does\]/$description/g" "$full_project_path/README.md"
                sed -i "s/\[Date\]/$current_date/g" "$full_project_path/README.md"
            fi
        fi
        
        # Update start.txt (simplified - just check it exists)
        if [ -f "$full_project_path/start.txt" ]; then
            # In real function, this overwrites with template content
            # For testing, we just verify the file exists
            :
        fi
        
        # Update package.json if it exists
        if [ -f "$full_project_path/package.json" ]; then
            if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
                sed -i '' "s/\"name\": \"[^\"]*\"/\"name\": \"$project_name\"/g" "$full_project_path/package.json"
                sed -i '' "s/\"description\": \"[^\"]*\"/\"description\": \"$description\"/g" "$full_project_path/package.json"
            else
                sed -i "s/\"name\": \"[^\"]*\"/\"name\": \"$project_name\"/g" "$full_project_path/package.json"
                sed -i "s/\"description\": \"[^\"]*\"/\"description\": \"$description\"/g" "$full_project_path/package.json"
            fi
        fi
        
        return 0
    }
    
    # Define verify_github_auth function (simplified for testing)
    verify_github_auth() {
        local expected_author="$1"
        
        # Check if gh is installed (mocked in tests)
        # Clear command cache first to ensure we get the right gh (mock or real)
        hash -r 2>/dev/null || true
        
        # Find gh in PATH, checking each directory in order
        # This ensures we find the mock if it's in PATH before the real gh
        # Check TEST_TMPDIR first (where mocks are placed), then PATH
        local gh_cmd=""
        
        # First check TEST_TMPDIR (where mocks are placed in tests)
        if [ -n "${TEST_TMPDIR:-}" ] && [ -x "${TEST_TMPDIR}/gh" ]; then
            gh_cmd="${TEST_TMPDIR}/gh"
        else
            # Fall back to PATH lookup
            local IFS_SAVE="$IFS"
            local path_expanded="${PATH:-}"
            IFS=":"
            for dir in $path_expanded; do
                # Skip empty directories
                [ -z "$dir" ] && continue
                if [ -x "$dir/gh" ] && [ -f "$dir/gh" ]; then
                    gh_cmd="$dir/gh"
                    break
                fi
            done
            IFS="$IFS_SAVE"
        fi
        
        if [ -z "$gh_cmd" ]; then
            return 1
        fi
        
        # Check if user is authenticated (mocked in tests)
        if ! "$gh_cmd" auth status &>/dev/null; then
            return 1
        fi
        
        # Get current authenticated user (mocked in tests)
        # gh api user --jq .login returns just the login value
        local current_user
        current_user=$("$gh_cmd" api user --jq .login 2>/dev/null || echo "")
        
        if [ -z "$current_user" ]; then
            return 1
        fi
        
        # If author name provided, try to match (case-insensitive)
        if [ -n "$expected_author" ]; then
            local author_lower=$(echo "$expected_author" | tr '[:upper:]' '[:lower:]')
            local user_lower=$(echo "$current_user" | tr '[:upper:]' '[:lower:]')
            
            if [ "$author_lower" != "$user_lower" ]; then
                return 2  # Mismatch
            fi
        fi
        
        return 0
    }
    
    # Define init_git_repo function (simplified for testing - no prompts)
    init_git_repo() {
        local full_project_path="$1"
        local author="$2"
        local project_name=$(basename "$full_project_path")
        local original_dir=$(pwd)
        
        # Ensure git is configured (required for commits)
        # Check if git config is set, if not set it
        if ! git config --global user.name >/dev/null 2>&1; then
            git config --global user.name "Test User" || true
        fi
        if ! git config --global user.email >/dev/null 2>&1; then
            git config --global user.email "test@example.com" || true
        fi
        
        # Change to project directory with error checking
        if ! cd "$full_project_path"; then
            return 1
        fi
        
        # Initialize git (may fail if git not available, but that's ok for tests)
        git init >/dev/null 2>&1 || return 1
        git add . >/dev/null 2>&1 || return 1
        git commit -m "Initial commit: $project_name created from dev-infra template" >/dev/null 2>&1 || return 1
        
        # Return to original directory (best effort)
        cd "$original_dir" 2>/dev/null || true
        
        return 0
    }
    
    # Define show_next_steps function (simplified for testing)
    show_next_steps() {
        local full_project_path="$1"
        local project_type="$2"
        local project_name=$(basename "$full_project_path")
        
        echo "Project '$project_name' created successfully!"
        echo "Next steps:"
        echo "1. cd $full_project_path"
        echo "2. Review and customize start.txt"
        echo "3. Update README.md with project-specific details"
        echo "4. Set up development environment"
        echo "5. Start development!"
        echo
        echo "For $project_type projects:"
        if [ "$project_type" = "Learning Project" ]; then
            echo "- Start with stage0-fundamentals/README.md"
        else
            echo "- Review docs/maintainers/planning/README.md for project management"
        fi
    }
    
    # Export functions
    export -f expand_env_vars
    export -f validate_target_directory
    export -f validate_project_name
    export -f copy_template
    export -f customize_project
    export -f verify_github_auth
    export -f init_git_repo
    export -f show_next_steps
}

# Setup test environment
setup_test_env() {
    export TEST_TMPDIR=$(mktemp -d)
    export TEST_HOME="$TEST_TMPDIR/home"
    export TEST_PROJECTS="$TEST_TMPDIR/projects"
    mkdir -p "$TEST_HOME" "$TEST_PROJECTS"
    
    # Set test environment variables
    export HOME="$TEST_HOME"
    export USER="${USER:-testuser}"
    export PWD="$TEST_TMPDIR"
    
    # Define test functions
    define_test_functions
}

# Cleanup test environment
cleanup_test_env() {
    if [ -n "$TEST_TMPDIR" ] && [ -d "$TEST_TMPDIR" ]; then
        rm -rf "$TEST_TMPDIR"
    fi
}

# Create test directory structure
create_test_dir() {
    local path="$1"
    local writable="${2:-1}"
    
    mkdir -p "$path"
    if [ "$writable" = "0" ]; then
        chmod -w "$path" 2>/dev/null || true
    fi
}

# Mock gh CLI for GitHub auth tests
# Usage: mock_gh [scenario] [username]
# Scenarios: success, failure, mismatch, not_installed
# Default: success with testuser
mock_gh() {
    local scenario="${1:-success}"
    local username="${2:-testuser}"
    local mock_gh_script="$TEST_TMPDIR/gh"
    
    case "$scenario" in
        "not_installed")
            # Remove gh from PATH temporarily
            export PATH="/nonexistent:$PATH"
            hash -r 2>/dev/null || true
            return 0
            ;;
        "failure")
            cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
if [ "$1" = "auth" ] && [ "$2" = "status" ]; then
    exit 1  # Not authenticated
fi
exit 1
MOCKEOF
            ;;
        "mismatch")
            cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
if [ "$1" = "auth" ] && [ "$2" = "status" ]; then
    exit 0  # Authenticated
fi
if [ "$1" = "api" ] && [ "$2" = "user" ]; then
    if [ "$3" = "--jq" ] && [ "$4" = ".login" ]; then
        echo "otheruser"
    else
        echo '{"login":"otheruser"}'
    fi
    exit 0
fi
exit 1
MOCKEOF
            ;;
        "success"|*)
            cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
if [ "$1" = "auth" ] && [ "$2" = "status" ]; then
    exit 0  # Authenticated
fi
if [ "$1" = "api" ] && [ "$2" = "user" ]; then
    if [ "$3" = "--jq" ] && [ "$4" = ".login" ]; then
        echo "USERNAME_PLACEHOLDER"
    else
        echo '{"login":"USERNAME_PLACEHOLDER"}'
    fi
    exit 0
fi
exit 1
MOCKEOF
            # Replace username placeholder (cross-platform sed)
            if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
                sed -i '' "s/USERNAME_PLACEHOLDER/$username/g" "$mock_gh_script"
            else
                sed -i "s/USERNAME_PLACEHOLDER/$username/g" "$mock_gh_script"
            fi
            ;;
    esac
    
    if [ "$scenario" != "not_installed" ]; then
        chmod +x "$mock_gh_script"
        # Ensure PATH includes TEST_TMPDIR at the front
        export PATH="$TEST_TMPDIR:$PATH"
        hash -r 2>/dev/null || true
    fi
}
