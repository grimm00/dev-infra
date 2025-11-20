#!/usr/bin/env bats

# BATS tests for backward compatibility
# Tests that verify the script works from various contexts

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Backward Compatibility Tests
# ============================================================================

@test "backward_compat: script works from any directory" {
    # Test that path resolution works regardless of current directory
    local test_dir="$TEST_TMPDIR/backward"
    mkdir -p "$test_dir"
    
    # Change to different directory
    cd "$TEST_TMPDIR"
    
    run validate_target_directory "$test_dir"
    
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

@test "backward_compat: relative paths resolve correctly" {
    # Test that relative paths work as expected
    local test_dir="$TEST_TMPDIR/backward/relative"
    mkdir -p "$test_dir"
    cd "$TEST_TMPDIR/backward"
    
    run validate_target_directory "relative"
    
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

