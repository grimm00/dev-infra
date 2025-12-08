#!/usr/bin/env bats

# File Presence Tests
# Validates that all required files exist in generated projects

load '../../helpers/helpers.bash'
load 'template-validation-helpers'

# ============================================================================
# Test Setup and Teardown
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
# Standard Project File Presence Tests
# ============================================================================

@test "file-presence: standard-project root files exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Root level files
    validate_file_exists "$project_dir" "README.md"
    validate_file_exists "$project_dir" "start.txt"
    validate_file_exists "$project_dir" ".gitignore"
}

@test "file-presence: standard-project directory structure exists" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Required directories
    validate_directory_exists "$project_dir" "backend"
    validate_directory_exists "$project_dir" "frontend"
    validate_directory_exists "$project_dir" "tests"
    validate_directory_exists "$project_dir" "scripts"
    validate_directory_exists "$project_dir" "docs"
    validate_directory_exists "$project_dir" "docs/maintainers"
}

@test "file-presence: standard-project backend files exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Backend directory files
    validate_file_exists "$project_dir" "backend/README.md"
    validate_directory_exists "$project_dir" "backend/instance"
}

@test "file-presence: standard-project frontend files exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Frontend directory files
    validate_file_exists "$project_dir" "frontend/README.md"
}

@test "file-presence: standard-project tests files exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Tests directory files
    validate_file_exists "$project_dir" "tests/README.md"
}

@test "file-presence: standard-project scripts files exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Scripts directory files
    validate_file_exists "$project_dir" "scripts/README.md"
}

@test "file-presence: standard-project docs structure exists" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Docs maintainers structure
    validate_file_exists "$project_dir" "docs/maintainers/README.md"
    validate_directory_exists "$project_dir" "docs/maintainers/planning"
    validate_directory_exists "$project_dir" "docs/maintainers/planning/features"
    validate_directory_exists "$project_dir" "docs/maintainers/planning/ci"
    validate_directory_exists "$project_dir" "docs/maintainers/decisions"
    validate_directory_exists "$project_dir" "docs/maintainers/research"
}

@test "file-presence: standard-project planning hub files exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Planning hub files
    validate_file_exists "$project_dir" "docs/maintainers/planning/README.md"
    validate_file_exists "$project_dir" "docs/maintainers/planning/features/README.md"
    validate_file_exists "$project_dir" "docs/maintainers/planning/ci/README.md"
}

@test "file-presence: standard-project workflow guides exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Workflow guide files
    validate_file_exists "$project_dir" "docs/maintainers/WORKFLOW-OVERVIEW.md"
    validate_file_exists "$project_dir" "docs/maintainers/WORKFLOW-FEATURE-DEVELOPMENT.md"
    validate_file_exists "$project_dir" "docs/maintainers/WORKFLOW-EXPLORATION-RESEARCH-DECISION.md"
    validate_file_exists "$project_dir" "docs/maintainers/WORKFLOW-CICD-IMPROVEMENT.md"
}

@test "file-presence: standard-project example files exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Example files
    validate_file_exists "$project_dir" "docs/maintainers/examples/example-exploration.md"
    validate_file_exists "$project_dir" "docs/maintainers/examples/example-research.md"
    validate_file_exists "$project_dir" "docs/maintainers/examples/example-adr.md"
    validate_file_exists "$project_dir" "docs/maintainers/examples/example-feature-plan.md"
}

# ============================================================================
# Learning Project File Presence Tests
# ============================================================================

@test "file-presence: learning-project root files exist" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Root level files
    validate_file_exists "$project_dir" "README.md"
    validate_file_exists "$project_dir" "start.txt"
}

@test "file-presence: learning-project directory structure exists" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Required directories
    validate_directory_exists "$project_dir" "docs"
    validate_directory_exists "$project_dir" "practice-apps"
    validate_directory_exists "$project_dir" "reference"
    validate_directory_exists "$project_dir" "stage0-fundamentals"
    validate_directory_exists "$project_dir" "stage1-topic"
    validate_directory_exists "$project_dir" "stage2-topic"
    validate_directory_exists "$project_dir" "stage3-topic"
}

@test "file-presence: learning-project stage files exist" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Stage directory files
    validate_file_exists "$project_dir" "stage0-fundamentals/README.md"
}

@test "file-presence: learning-project practice-apps files exist" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Practice apps directory files
    validate_file_exists "$project_dir" "practice-apps/README.md"
}

@test "file-presence: learning-project reference files exist" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Reference directory files
    validate_file_exists "$project_dir" "reference/README.md"
}

@test "file-presence: learning-project docs structure exists" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Docs maintainers structure
    validate_file_exists "$project_dir" "docs/maintainers/README.md"
    validate_directory_exists "$project_dir" "docs/maintainers/planning"
    validate_directory_exists "$project_dir" "docs/maintainers/planning/features"
    validate_directory_exists "$project_dir" "docs/maintainers/planning/ci"
    validate_directory_exists "$project_dir" "docs/maintainers/decisions"
    validate_directory_exists "$project_dir" "docs/maintainers/research"
}

@test "file-presence: learning-project planning hub files exist" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Planning hub files
    validate_file_exists "$project_dir" "docs/maintainers/planning/README.md"
    validate_file_exists "$project_dir" "docs/maintainers/planning/features/README.md"
    validate_file_exists "$project_dir" "docs/maintainers/planning/ci/README.md"
}

@test "file-presence: learning-project workflow guides exist" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Workflow guide files
    validate_file_exists "$project_dir" "docs/maintainers/WORKFLOW-OVERVIEW.md"
    validate_file_exists "$project_dir" "docs/maintainers/WORKFLOW-FEATURE-DEVELOPMENT.md"
    validate_file_exists "$project_dir" "docs/maintainers/WORKFLOW-EXPLORATION-RESEARCH-DECISION.md"
    validate_file_exists "$project_dir" "docs/maintainers/WORKFLOW-CICD-IMPROVEMENT.md"
}

@test "file-presence: learning-project example files exist" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Example files
    validate_file_exists "$project_dir" "docs/maintainers/examples/example-exploration.md"
    validate_file_exists "$project_dir" "docs/maintainers/examples/example-research.md"
    validate_file_exists "$project_dir" "docs/maintainers/examples/example-adr.md"
    validate_file_exists "$project_dir" "docs/maintainers/examples/example-feature-plan.md"
}

# ============================================================================
# File Permissions Tests
# ============================================================================

@test "file-presence: standard-project files are readable" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Check that key files are readable
    [ -r "$project_dir/README.md" ]
    [ -r "$project_dir/start.txt" ]
    [ -r "$project_dir/.gitignore" ]
    [ -r "$project_dir/backend/README.md" ]
    [ -r "$project_dir/frontend/README.md" ]
}

@test "file-presence: learning-project files are readable" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Check that key files are readable
    [ -r "$project_dir/README.md" ]
    [ -r "$project_dir/start.txt" ]
    [ -r "$project_dir/stage0-fundamentals/README.md" ]
    [ -r "$project_dir/practice-apps/README.md" ]
    [ -r "$project_dir/reference/README.md" ]
}
