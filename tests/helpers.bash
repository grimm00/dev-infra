#!/bin/bash

# Test helper functions for new-project.sh testing
# This file provides utilities for testing the new-project.sh script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
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
    
    # Export functions
    export -f expand_env_vars
    export -f validate_target_directory
    export -f validate_project_name
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
mock_gh() {
    local mock_gh_script="$TEST_TMPDIR/mock_gh"
    cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
case "$1" in
    "auth"|"api")
        # Mock successful auth
        if [ "$2" = "status" ] || [ "$2" = "user" ]; then
            echo '{"login":"testuser","name":"Test User"}'
            exit 0
        fi
        ;;
esac
exit 1
MOCKEOF
    chmod +x "$mock_gh_script"
    export PATH="$TEST_TMPDIR:$PATH"
}
