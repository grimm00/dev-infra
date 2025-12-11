#!/usr/bin/env bats

# Generation Success Tests
# Validates that template generation succeeds for both template types

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
# Standard Project Generation Success Tests
# ============================================================================

@test "generation-success: standard-project generation succeeds" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/test-standard" ]
    [ -f "$TEST_DIR/test-standard/README.md" ]
    [ -f "$TEST_DIR/test-standard/start.txt" ]
    [ -f "$TEST_DIR/test-standard/.gitignore" ]
}

@test "generation-success: standard-project non-interactive mode works" {
    export PROJECT_NAME="test-noninteractive"
    export PROJECT_TYPE="standard-project"
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/test-noninteractive" ]
    [ -f "$TEST_DIR/test-noninteractive/README.md" ]
}

@test "generation-success: standard-project environment variables work" {
    export PROJECT_NAME="test-env-vars"
    export PROJECT_TYPE="standard-project"
    export PROJECT_DESCRIPTION="Test description from env"
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/test-env-vars" ]
    [ -f "$TEST_DIR/test-env-vars/README.md" ]
    
    # Verify description was used (check if it appears in start.txt or README)
    [ -f "$TEST_DIR/test-env-vars/start.txt" ]
}

@test "generation-success: standard-project generated structure is valid" {
    generate_test_project "test-structure" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-structure"
    
    # Verify essential structure exists
    [ -d "$project_dir/backend" ]
    [ -d "$project_dir/frontend" ]
    [ -d "$project_dir/tests" ]
    [ -d "$project_dir/scripts" ]
    [ -d "$project_dir/docs" ]
    [ -d "$project_dir/docs/maintainers" ]
    
    # Verify essential files exist
    [ -f "$project_dir/README.md" ]
    [ -f "$project_dir/start.txt" ]
    [ -f "$project_dir/.gitignore" ]
}

# ============================================================================
# Learning Project Generation Success Tests
# ============================================================================

@test "generation-success: learning-project generation succeeds" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/test-learning" ]
    [ -f "$TEST_DIR/test-learning/README.md" ]
    [ -f "$TEST_DIR/test-learning/start.txt" ]
}

@test "generation-success: learning-project non-interactive mode works" {
    export PROJECT_NAME="test-learning-noninteractive"
    export PROJECT_TYPE="learning-project"
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/test-learning-noninteractive" ]
    [ -f "$TEST_DIR/test-learning-noninteractive/README.md" ]
}

@test "generation-success: learning-project environment variables work" {
    export PROJECT_NAME="test-learning-env"
    export PROJECT_TYPE="learning-project"
    export PROJECT_DESCRIPTION="Learning test description"
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/test-learning-env" ]
    [ -f "$TEST_DIR/test-learning-env/README.md" ]
    [ -f "$TEST_DIR/test-learning-env/start.txt" ]
}

@test "generation-success: learning-project generated structure is valid" {
    generate_test_project "test-learning-structure" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning-structure"
    
    # Verify essential structure exists
    [ -d "$project_dir/docs" ]
    [ -d "$project_dir/practice-apps" ]
    [ -d "$project_dir/reference" ]
    [ -d "$project_dir/stage0-fundamentals" ]
    [ -d "$project_dir/stage1-topic" ]
    [ -d "$project_dir/stage2-topic" ]
    [ -d "$project_dir/stage3-topic" ]
    [ -d "$project_dir/docs/maintainers" ]
    
    # Verify essential files exist
    [ -f "$project_dir/README.md" ]
    [ -f "$project_dir/start.txt" ]
}

# ============================================================================
# Error Handling Tests
# ============================================================================

@test "generation-success: fails with missing PROJECT_NAME" {
    unset PROJECT_NAME
    export PROJECT_TYPE="standard-project"
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    [ "$status" -ne 0 ]
}

@test "generation-success: fails with missing PROJECT_TYPE" {
    export PROJECT_NAME="test-missing-type"
    unset PROJECT_TYPE
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    [ "$status" -ne 0 ]
}

@test "generation-success: fails with invalid PROJECT_TYPE" {
    export PROJECT_NAME="test-invalid-type"
    export PROJECT_TYPE="invalid-type"
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    [ "$status" -ne 0 ]
}

@test "generation-success: fails with invalid INIT_GIT value" {
    export PROJECT_NAME="test-invalid-git"
    export PROJECT_TYPE="standard-project"
    export INIT_GIT="maybe"
    export TARGET_DIR="$TEST_DIR"
    
    run "$NEW_PROJECT_SCRIPT" --non-interactive
    
    [ "$status" -ne 0 ]
}

# ============================================================================
# Multiple Generation Tests
# ============================================================================

@test "generation-success: can generate multiple projects sequentially" {
    # Generate first project
    generate_test_project "project-one" "standard-project"
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/project-one" ]
    
    # Generate second project
    generate_test_project "project-two" "learning-project"
    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/project-two" ]
    
    # Verify both projects exist
    [ -d "$TEST_DIR/project-one" ]
    [ -d "$TEST_DIR/project-two" ]
    [ -f "$TEST_DIR/project-one/README.md" ]
    [ -f "$TEST_DIR/project-two/README.md" ]
}

# ============================================================================
# Git Initialization Tests
# ============================================================================

@test "generation-success: standard-project git initialization works" {
    generate_test_project "test-standard-git" "standard-project" "$TEST_DIR" "true"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard-git"
    
    # Verify project was created
    [ -d "$project_dir" ]
    [ -f "$project_dir/README.md" ]
    
    # Verify git was initialized
    [ -d "$project_dir/.git" ]
    
    # Verify default branch exists (check git branch output)
    run git -C "$project_dir" branch --show-current
    [ "$status" -eq 0 ]
    # Default branch should be "main" or "master" (depending on git config)
    [[ "$output" =~ ^(main|master)$ ]]
}

@test "generation-success: learning-project git initialization works" {
    generate_test_project "test-learning-git" "learning-project" "$TEST_DIR" "true"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning-git"
    
    # Verify project was created
    [ -d "$project_dir" ]
    [ -f "$project_dir/README.md" ]
    
    # Verify git was initialized
    [ -d "$project_dir/.git" ]
    
    # Verify default branch exists (check git branch output)
    run git -C "$project_dir" branch --show-current
    [ "$status" -eq 0 ]
    # Default branch should be "main" or "master" (depending on git config)
    [[ "$output" =~ ^(main|master)$ ]]
}
