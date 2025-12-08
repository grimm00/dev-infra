#!/bin/bash

# Template Validation Test Helpers
# Shared helper functions for template validation tests

# Generate a test project using non-interactive mode
# Usage: generate_test_project <project-name> <project-type> [target-dir]
# Note: This function sets environment variables and runs the script
# The generated project will be at: $TARGET_DIR/$project_name
# Requires: PROJECT_ROOT (from helpers.bash), TEST_DIR (from setup())
generate_test_project() {
    local project_name="$1"
    local project_type="$2"
    local target_dir="${3:-$TEST_DIR}"
    
    # Ensure PROJECT_ROOT is set (from helpers.bash)
    if [[ -z "$PROJECT_ROOT" ]]; then
        echo "Error: PROJECT_ROOT not set" >&2
        return 1
    fi
    
    # Ensure TEST_DIR is set (from setup())
    if [[ -z "$TEST_DIR" ]]; then
        echo "Error: TEST_DIR not set" >&2
        return 1
    fi
    
    # Set NEW_PROJECT_SCRIPT if not already set
    local script_path="${NEW_PROJECT_SCRIPT:-$PROJECT_ROOT/scripts/new-project.sh}"
    
    # Verify script exists
    if [[ ! -f "$script_path" ]]; then
        echo "Error: Script not found: $script_path" >&2
        return 1
    fi
    
    export PROJECT_NAME="$project_name"
    export PROJECT_TYPE="$project_type"
    export TARGET_DIR="$target_dir"
    export INIT_GIT="false"
    
    # Run the script
    run "$script_path" --non-interactive
    
    # Restore default test variables (for subsequent tests)
    export PROJECT_NAME="test-project"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_DIR"
    
    # Return status code for test assertions
    # Note: $status is set by bats 'run' command
    return "$status"
}

# Validate that a file exists in a generated project
# Usage: validate_file_exists <project-dir> <file-path>
validate_file_exists() {
    local project_dir="$1"
    local file_path="$2"
    local full_path="$project_dir/$file_path"
    
    if [[ ! -f "$full_path" ]]; then
        echo "File not found: $full_path"
        return 1
    fi
    return 0
}

# Validate that a directory exists in a generated project
# Usage: validate_directory_exists <project-dir> <dir-path>
validate_directory_exists() {
    local project_dir="$1"
    local dir_path="$2"
    local full_path="$project_dir/$dir_path"
    
    if [[ ! -d "$full_path" ]]; then
        echo "Directory not found: $full_path"
        return 1
    fi
    return 0
}

