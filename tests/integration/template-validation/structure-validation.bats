#!/usr/bin/env bats

# Structure Validation Tests
# Validates that directory structure matches template structure

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
# Standard Project Structure Validation Tests
# ============================================================================

@test "structure-validation: standard-project root directories exist" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Root level directories
    validate_directory_exists "$project_dir" "backend"
    validate_directory_exists "$project_dir" "frontend"
    validate_directory_exists "$project_dir" "tests"
    validate_directory_exists "$project_dir" "scripts"
    validate_directory_exists "$project_dir" "docs"
}

@test "structure-validation: standard-project backend structure exists" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Backend structure
    validate_directory_exists "$project_dir" "backend"
    validate_directory_exists "$project_dir" "backend/instance"
    validate_file_exists "$project_dir" "backend/README.md"
}

@test "structure-validation: standard-project docs structure exists" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Docs structure
    validate_directory_exists "$project_dir" "docs"
    validate_directory_exists "$project_dir" "docs/maintainers"
    validate_directory_exists "$project_dir" "docs/maintainers/planning"
    validate_directory_exists "$project_dir" "docs/maintainers/planning/features"
    validate_directory_exists "$project_dir" "docs/maintainers/planning/ci"
    validate_directory_exists "$project_dir" "docs/maintainers/decisions"
    validate_directory_exists "$project_dir" "docs/maintainers/research"
    validate_directory_exists "$project_dir" "docs/maintainers/examples"
}

@test "structure-validation: standard-project directory structure matches template" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Verify complete structure matches expected template
    # Required top-level directories
    [ -d "$project_dir/backend" ]
    [ -d "$project_dir/frontend" ]
    [ -d "$project_dir/tests" ]
    [ -d "$project_dir/scripts" ]
    [ -d "$project_dir/docs" ]
    
    # Required maintainers structure
    [ -d "$project_dir/docs/maintainers" ]
    [ -d "$project_dir/docs/maintainers/planning" ]
    [ -d "$project_dir/docs/maintainers/planning/features" ]
    [ -d "$project_dir/docs/maintainers/planning/ci" ]
    [ -d "$project_dir/docs/maintainers/decisions" ]
    [ -d "$project_dir/docs/maintainers/research" ]
    [ -d "$project_dir/docs/maintainers/examples" ]
    
    # Required files
    [ -f "$project_dir/README.md" ]
    [ -f "$project_dir/start.txt" ]
    [ -f "$project_dir/.gitignore" ]
}

@test "structure-validation: standard-project template variables replaced" {
    generate_test_project "my-custom-project" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/my-custom-project"
    local readme="$project_dir/README.md"
    
    # Check that project name was replaced in README.md
    grep -q "my-custom-project" "$readme" || {
        echo "Project name 'my-custom-project' not found in README.md"
        return 1
    }
    
    # Check that [Project Name] placeholder was replaced
    ! grep -q "\[Project Name\]" "$readme" || {
        echo "Placeholder [Project Name] still present in README.md"
        return 1
    }
}

# ============================================================================
# Learning Project Structure Validation Tests
# ============================================================================

@test "structure-validation: learning-project root directories exist" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Root level directories
    validate_directory_exists "$project_dir" "docs"
    validate_directory_exists "$project_dir" "practice-apps"
    validate_directory_exists "$project_dir" "reference"
    validate_directory_exists "$project_dir" "stage0-fundamentals"
    validate_directory_exists "$project_dir" "stage1-topic"
    validate_directory_exists "$project_dir" "stage2-topic"
    validate_directory_exists "$project_dir" "stage3-topic"
}

@test "structure-validation: learning-project stage structure exists" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Stage structure
    validate_directory_exists "$project_dir" "stage0-fundamentals"
    validate_file_exists "$project_dir" "stage0-fundamentals/README.md"
    validate_directory_exists "$project_dir" "stage1-topic"
    validate_directory_exists "$project_dir" "stage2-topic"
    validate_directory_exists "$project_dir" "stage3-topic"
}

@test "structure-validation: learning-project docs structure exists" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Docs structure
    validate_directory_exists "$project_dir" "docs"
    validate_directory_exists "$project_dir" "docs/maintainers"
    validate_directory_exists "$project_dir" "docs/maintainers/planning"
    validate_directory_exists "$project_dir" "docs/maintainers/planning/features"
    validate_directory_exists "$project_dir" "docs/maintainers/planning/ci"
    validate_directory_exists "$project_dir" "docs/maintainers/decisions"
    validate_directory_exists "$project_dir" "docs/maintainers/research"
    validate_directory_exists "$project_dir" "docs/maintainers/examples"
}

@test "structure-validation: learning-project directory structure matches template" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Verify complete structure matches expected template
    # Required top-level directories
    [ -d "$project_dir/docs" ]
    [ -d "$project_dir/practice-apps" ]
    [ -d "$project_dir/reference" ]
    [ -d "$project_dir/stage0-fundamentals" ]
    [ -d "$project_dir/stage1-topic" ]
    [ -d "$project_dir/stage2-topic" ]
    [ -d "$project_dir/stage3-topic" ]
    
    # Required maintainers structure
    [ -d "$project_dir/docs/maintainers" ]
    [ -d "$project_dir/docs/maintainers/planning" ]
    [ -d "$project_dir/docs/maintainers/planning/features" ]
    [ -d "$project_dir/docs/maintainers/planning/ci" ]
    [ -d "$project_dir/docs/maintainers/decisions" ]
    [ -d "$project_dir/docs/maintainers/research" ]
    [ -d "$project_dir/docs/maintainers/examples" ]
    
    # Required files
    [ -f "$project_dir/README.md" ]
    [ -f "$project_dir/start.txt" ]
}

@test "structure-validation: learning-project template variables replaced" {
    generate_test_project "my-learning-project" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/my-learning-project"
    local readme="$project_dir/README.md"
    
    # Check that project name was replaced in README.md
    grep -q "my-learning-project" "$readme" || {
        echo "Project name 'my-learning-project' not found in README.md"
        return 1
    }
    
    # Check that [Learning Project Name] placeholder was replaced
    ! grep -q "\[Learning Project Name\]" "$readme" || {
        echo "Placeholder [Learning Project Name] still present in README.md"
        return 1
    }
}

# ============================================================================
# Structure Comparison Tests
# ============================================================================

@test "structure-validation: standard-project has no learning-project directories" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Verify learning-project specific directories don't exist
    [ ! -d "$project_dir/stage0-fundamentals" ]
    [ ! -d "$project_dir/practice-apps" ]
    [ ! -d "$project_dir/reference" ]
}

@test "structure-validation: learning-project has no standard-project backend/frontend" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Verify standard-project specific directories don't exist
    [ ! -d "$project_dir/backend" ]
    [ ! -d "$project_dir/frontend" ]
}
