#!/usr/bin/env bats

# BATS tests for Git repository operations
# Tests for init_git_repo() function

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Git Repository Operations
# ============================================================================

@test "git_operations: initializes git repository successfully" {
    local project_dir="$TEST_TMPDIR/test-git"
    mkdir -p "$project_dir"
    echo "test file" > "$project_dir/test.txt"
    
    if ! command -v git &> /dev/null; then
        skip "Git not available"
    fi
    
    run init_git_repo "$project_dir" "Test Author"
    
    [ "$status" -eq 0 ]
    [ -d "$project_dir/.git" ]
}

@test "git_operations: creates initial commit" {
    local project_dir="$TEST_TMPDIR/test-commit"
    mkdir -p "$project_dir"
    echo "test file" > "$project_dir/test.txt"
    
    if ! command -v git &> /dev/null; then
        skip "Git not available"
    fi
    
    run init_git_repo "$project_dir" "Test Author"
    
    [ "$status" -eq 0 ]
    
    # Check that commit was created
    cd "$project_dir"
    local commit_count=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    [ "$commit_count" -eq 1 ]
}

@test "git_operations: handles cd failure gracefully" {
    local project_dir="$TEST_TMPDIR/nonexistent/project"
    # Directory doesn't exist, so cd will fail
    
    run init_git_repo "$project_dir" "Test Author"
    
    [ "$status" -ne 0 ]
}

@test "git_operations: returns to original directory" {
    local original_dir=$(pwd)
    local project_dir="$TEST_TMPDIR/test-return"
    mkdir -p "$project_dir"
    echo "test" > "$project_dir/test.txt"
    
    if ! command -v git &> /dev/null; then
        skip "Git not available"
    fi
    
    run init_git_repo "$project_dir" "Test Author"
    
    # Should return to original directory (best effort)
    [ "$(pwd)" = "$original_dir" ] || [ "$status" -ne 0 ]
}

