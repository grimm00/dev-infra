#!/usr/bin/env bats

# Template Validation Test Suite
# Main test suite file that includes all test category files

load '../helpers/helpers.bash'

# Load test category files
load 'file-presence'
load 'link-validation'
load 'structure-validation'
load 'generation-success'

# ============================================================================
# Test Suite Setup and Teardown
# ============================================================================

setup() {
    # Create temporary directory for test projects
    # Use BATS_RUN_TMPDIR if available (bats provides this), otherwise use mktemp
    if [[ -n "$BATS_RUN_TMPDIR" ]]; then
        TEST_DIR="$BATS_RUN_TMPDIR/template-validation-$$"
    else
        TEST_DIR=$(mktemp -d)
    fi
    mkdir -p "$TEST_DIR"
    export TEST_DIR
    
    # Set up environment variables for non-interactive mode
    export PROJECT_NAME="test-project"
    export PROJECT_TYPE="standard-project"
    export PROJECT_DESCRIPTION="Test project for template validation"
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    
    # Initialize test project variables
    export TEST_PROJECT_DIR="$TEST_DIR/test-project"
    export TEST_STANDARD_PROJECT_DIR="$TEST_DIR/test-standard-project"
    export TEST_LEARNING_PROJECT_DIR="$TEST_DIR/test-learning-project"
    
    # Path to new-project.sh script
    export NEW_PROJECT_SCRIPT="$PROJECT_ROOT/scripts/new-project.sh"
}

teardown() {
    # Clean up temporary test projects
    if [[ -n "$TEST_DIR" && -d "$TEST_DIR" ]]; then
        rm -rf "$TEST_DIR"
    fi
    
    # Clean up environment variables
    unset TEST_DIR
    unset PROJECT_NAME
    unset PROJECT_TYPE
    unset PROJECT_DESCRIPTION
    unset INIT_GIT
    unset TARGET_DIR
    unset TEST_PROJECT_DIR
    unset TEST_STANDARD_PROJECT_DIR
    unset TEST_LEARNING_PROJECT_DIR
    unset NEW_PROJECT_SCRIPT
}

# ============================================================================
# Helper Functions for Test Categories
# ============================================================================

# Generate a test project using non-interactive mode
# Usage: generate_test_project <project-name> <project-type> [target-dir]
generate_test_project() {
    local project_name="$1"
    local project_type="$2"
    local target_dir="${3:-$TEST_DIR}"
    
    export PROJECT_NAME="$project_name"
    export PROJECT_TYPE="$project_type"
    export TARGET_DIR="$target_dir"
    export INIT_GIT="false"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    # Restore default test variables
    export PROJECT_NAME="test-project"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_DIR"
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

