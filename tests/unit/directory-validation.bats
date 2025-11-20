#!/usr/bin/env bats

# BATS tests for directory validation functionality
# Tests for validate_target_directory() function

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Directory Validation and Path Resolution
# ============================================================================

@test "directory_validation: accepts existing writable directory" {
    local test_dir="$TEST_TMPDIR/existing"
    mkdir -p "$test_dir"
    
    run validate_target_directory "$test_dir"
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

@test "directory_validation: rejects empty path" {
    run validate_target_directory ""
    [ "$status" -eq 1 ]
}

@test "directory_validation: detects non-writable directory" {
    local test_dir="$TEST_TMPDIR/nowrite"
    mkdir -p "$test_dir"
    
    # Try to make directory non-writable
    # In some environments (like Docker containers), chmod -w might not work
    # or the directory might still be writable due to parent permissions
    if chmod -w "$test_dir" 2>/dev/null; then
        # Verify it's actually non-writable
        if [ -w "$test_dir" ]; then
            skip "Directory still writable after chmod -w (parent permissions or container environment)"
        fi
        
        run validate_target_directory "$test_dir"
        [ "$status" -eq 2 ]
        [ "$output" = "$test_dir" ]
        
        # Restore permissions for cleanup
        chmod +w "$test_dir" 2>/dev/null || true
    else
        skip "Cannot make directory non-writable on this system"
    fi
}

@test "directory_validation: accepts non-existent but creatable directory" {
    local parent_dir="$TEST_TMPDIR/parent"
    local test_dir="$parent_dir/newdir"
    mkdir -p "$parent_dir"
    
    run validate_target_directory "$test_dir"
    [ "$status" -eq 3 ]
    [ "$output" = "$test_dir" ]
}

@test "directory_validation: handles absolute paths" {
    local test_dir="$TEST_TMPDIR/absolute"
    mkdir -p "$test_dir"
    
    run validate_target_directory "$test_dir"
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

@test "directory_validation: handles relative paths" {
    local test_dir="$TEST_TMPDIR/relative"
    mkdir -p "$test_dir"
    cd "$TEST_TMPDIR"
    
    run validate_target_directory "relative"
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

@test "directory_validation: handles environment variables in path" {
    local test_dir="$TEST_HOME/envtest"
    mkdir -p "$test_dir"
    
    run validate_target_directory "\$HOME/envtest"
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

@test "directory_validation: preserves root directory /" {
    # This tests the fix for root directory bug
    run validate_target_directory "/" 2>/dev/null
    
    # Should return /, not empty string (the key fix)
    [ "$output" = "/" ]
    [ -n "$output" ]  # Most important: should not be empty
}

@test "directory_validation: normalizes trailing slashes" {
    local test_dir="$TEST_TMPDIR/trailing"
    mkdir -p "$test_dir"
    
    run validate_target_directory "$test_dir///"
    [ "$status" -eq 0 ]
    [ "$output" = "$test_dir" ]
}

@test "directory_validation: rejects path when parent doesn't exist" {
    local test_dir="$TEST_TMPDIR/nonexistent/parent/newdir"
    
    run validate_target_directory "$test_dir"
    [ "$status" -eq 1 ]
    [ -n "$output" ]  # Should still return path
}

