#!/usr/bin/env bats

# BATS tests for end-to-end integration scenarios
# Tests that verify multiple functions working together

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Integration Tests: End-to-End Scenarios
# ============================================================================

@test "integration: absolute path resolution end-to-end" {
    local test_dir="$TEST_TMPDIR/integration/absolute"
    mkdir -p "$test_dir"
    
    run validate_target_directory "$test_dir"
    
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
    [ -d "$output" ]
}

@test "integration: relative path resolution end-to-end" {
    local test_dir="$TEST_TMPDIR/integration/relative"
    mkdir -p "$test_dir"
    cd "$TEST_TMPDIR/integration"
    
    run validate_target_directory "relative"
    
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

@test "integration: environment variable expansion in path" {
    local test_dir="$TEST_HOME/integration/env"
    mkdir -p "$test_dir"
    
    run validate_target_directory "\$HOME/integration/env"
    
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

@test "integration: tilde expansion in path" {
    local test_dir="$TEST_HOME/integration/tilde"
    mkdir -p "$test_dir"
    
    run validate_target_directory "~/integration/tilde"
    
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

