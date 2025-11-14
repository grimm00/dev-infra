#!/usr/bin/env bats

# BATS tests for regression verification
# Tests that verify historical bug fixes remain fixed

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Regression Tests: Historical Bug Fixes
# ============================================================================

@test "regression: root directory fix preserves /" {
    # This verifies the fix for PR #6 bug where / became empty string
    run validate_target_directory "/" 2>/dev/null
    
    # Should return /, not empty string (the key fix)
    [ "$output" = "/" ]
    [ -n "$output" ]
}

@test "regression: cross-platform sed fix - bash expansion works" {
    # This verifies the fix for PR #6 where sed was replaced with bash expansion
    # We test that space detection works (bash expansion is used internally)
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    # The function should detect spaces
    # We can't easily test the interactive part, but we can verify detection
    run validate_project_name "test project" "$test_dir" 2>/dev/null
    
    # Should detect spaces (non-zero exit)
    [ "$status" -ne 0 ]
    [ -z "$output" ]
}

@test "regression: silent failure fix - non-existent paths return error" {
    # This verifies the fix where non-existent paths failed silently
    local test_dir="$TEST_TMPDIR/nonexistent/path"
    
    run validate_target_directory "$test_dir" 2>/dev/null
    
    # Should return error code, not fail silently
    [ "$status" -ne 0 ]
    [ -n "$output" ]  # Should still return path for caller
}

