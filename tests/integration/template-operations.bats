#!/usr/bin/env bats

# BATS tests for template operations
# Tests for copy_template() function

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Template Operations
# ============================================================================

@test "template_operations: copies standard-project template successfully" {
    # Note: copy_template uses PROJECT_ROOT fallback if git rev-parse fails
    # This works in Docker containers where git context may not be available
    local project_dir="$TEST_TMPDIR/test-project"
    run copy_template "standard-project" "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -d "$project_dir" ]
    [ -f "$project_dir/README.md" ]
    [ -f "$project_dir/.gitignore" ]
}

@test "template_operations: copies learning-project template successfully" {
    # Note: copy_template uses PROJECT_ROOT fallback if git rev-parse fails
    local project_dir="$TEST_TMPDIR/test-learning"
    run copy_template "learning-project" "$project_dir"
    
    [ "$status" -eq 0 ]
    [ -d "$project_dir" ]
    [ -f "$project_dir/README.md" ]
}

@test "template_operations: returns error for non-existent template" {
    local project_dir="$TEST_TMPDIR/test-nonexistent"
    run copy_template "nonexistent-template" "$project_dir"
    
    [ "$status" -ne 0 ]
    [ ! -d "$project_dir" ]
}

@test "template_operations: verifies .gitignore exists after copy" {
    # Note: copy_template uses PROJECT_ROOT fallback if git rev-parse fails
    local project_dir="$TEST_TMPDIR/test-gitignore"
    run copy_template "standard-project" "$project_dir"
    
    # Should succeed and have .gitignore
    [ "$status" -eq 0 ]
    [ -f "$project_dir/.gitignore" ]
}

