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

