#!/usr/bin/env bats

# Link Validation Tests
# Validates that markdown links work in generated projects

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
# Standard Project Link Validation Tests
# ============================================================================

@test "link-validation: standard-project README.md links are valid" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    local readme="$project_dir/README.md"
    
    # Validate links in README.md
    run validate_markdown_links "$readme" "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "link-validation: standard-project maintainers README.md links are valid" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    local maintainers_readme="$project_dir/docs/maintainers/README.md"
    
    # Validate links in maintainers README.md
    run validate_markdown_links "$maintainers_readme" "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "link-validation: standard-project planning README.md links are valid" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    local planning_readme="$project_dir/docs/maintainers/planning/README.md"
    
    # Validate links in planning README.md
    run validate_markdown_links "$planning_readme" "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "link-validation: standard-project all markdown links are valid" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    
    # Validate all markdown links in the project
    run validate_all_markdown_links "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

# ============================================================================
# Learning Project Link Validation Tests
# ============================================================================

@test "link-validation: learning-project README.md links are valid" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    local readme="$project_dir/README.md"
    
    # Validate links in README.md
    run validate_markdown_links "$readme" "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "link-validation: learning-project maintainers README.md links are valid" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    local maintainers_readme="$project_dir/docs/maintainers/README.md"
    
    # Validate links in maintainers README.md
    run validate_markdown_links "$maintainers_readme" "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "link-validation: learning-project planning README.md links are valid" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    local planning_readme="$project_dir/docs/maintainers/planning/README.md"
    
    # Validate links in planning README.md
    run validate_markdown_links "$planning_readme" "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "link-validation: learning-project all markdown links are valid" {
    generate_test_project "test-learning" "learning-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-learning"
    
    # Validate all markdown links in the project
    run validate_all_markdown_links "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

# ============================================================================
# Link Validation Edge Cases
# ============================================================================

@test "link-validation: external links are skipped" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    local readme="$project_dir/README.md"
    
    # Check that external links (http/https) are not validated
    # This test verifies the function doesn't fail on external links
    run validate_markdown_links "$readme" "$project_dir"
    
    # Should succeed even if external links are present
    [ "$status" -eq 0 ]
}

@test "link-validation: anchor links are skipped" {
    generate_test_project "test-standard" "standard-project"
    
    [ "$status" -eq 0 ]
    
    local project_dir="$TEST_DIR/test-standard"
    local readme="$project_dir/README.md"
    
    # Check that anchor links (#) are not validated
    # This test verifies the function doesn't fail on anchor links
    run validate_markdown_links "$readme" "$project_dir"
    
    # Should succeed even if anchor links are present
    [ "$status" -eq 0 ]
}
