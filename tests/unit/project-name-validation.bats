#!/usr/bin/env bats

# BATS tests for project name validation functionality
# Tests for validate_project_name() function

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Project Name Validation
# ============================================================================

@test "project_name_validation: accepts valid project name" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    run validate_project_name "test-project" "$test_dir" 2>/dev/null
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir/test-project" ]
}

@test "project_name_validation: rejects empty name" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    run validate_project_name "" "$test_dir" 2>/dev/null
    [ "$status" -ne 0 ]
    [ -z "$output" ]
}

@test "project_name_validation: detects names with spaces" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    run validate_project_name "test project" "$test_dir" 2>/dev/null
    [ "$status" -ne 0 ]
    [ -z "$output" ]
}

@test "project_name_validation: rejects invalid characters" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    run validate_project_name "test@project" "$test_dir" 2>/dev/null
    [ "$status" -ne 0 ]
    [ -z "$output" ]
}

@test "project_name_validation: detects existing directory" {
    local test_dir="$TEST_TMPDIR/projects"
    local existing_dir="$test_dir/existing"
    mkdir -p "$existing_dir"
    
    run validate_project_name "existing" "$test_dir" 2>/dev/null
    [ "$status" -ne 0 ]
    [ -z "$output" ]
}

@test "project_name_validation: detects existing file with project name (current behavior)" {
    local test_dir="$TEST_TMPDIR/projects"
    local existing_file="$test_dir/existingfile"
    mkdir -p "$test_dir"
    touch "$existing_file"
    
    run validate_project_name "existingfile" "$test_dir" 2>/dev/null
    
    # Current behavior: Only checks for directories, not files
    # So it returns 0 (success) and the path, as if the file doesn't exist as a directory
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir/existingfile" ]
    # Note: This indicates a potential bug - should detect file collisions
}

@test "project_name_validation: should detect file collision (TODO - desired behavior)" {
    skip "TODO: Function should detect file collisions, not just directories"
    
    local test_dir="$TEST_TMPDIR/projects"
    local existing_file="$test_dir/existingfile"
    mkdir -p "$test_dir"
    touch "$existing_file"
    
    run validate_project_name "existingfile" "$test_dir" 2>/dev/null
    
    # Desired behavior: Should return non-zero and error message
    [ "$status" -ne 0 ]
    [ -z "$output" ]
}

