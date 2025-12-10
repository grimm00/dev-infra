#!/usr/bin/env bats

# BATS tests for GitHub authentication functionality
# Tests for verify_github_auth() function

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# GitHub Authentication
# ============================================================================

@test "github_auth: returns error when gh CLI not installed" {
    mock_gh "not_installed"
    
    run verify_github_auth "testuser"
    [ "$status" -ne 0 ]
}

@test "github_auth: returns error when not authenticated" {
    mock_gh "failure"
    
    run verify_github_auth "testuser"
    [ "$status" -ne 0 ]
}

@test "github_auth: succeeds when authenticated and user matches" {
    mock_gh "success" "testuser"
    
    run verify_github_auth "testuser"
    [ "$status" -eq 0 ]
}

@test "github_auth: returns mismatch when user doesn't match" {
    mock_gh "mismatch"
    
    run verify_github_auth "testuser"
    # Should return mismatch code (2)
    [ "$status" -eq 2 ]
}

@test "github_auth: succeeds when no expected author provided" {
    mock_gh "success" "anyuser"
    
    run verify_github_auth ""
    [ "$status" -eq 0 ]
}

@test "github_auth: handles unexpected gh CLI error" {
    # Mock gh to return unexpected error code for 'auth status' command
    mock_gh() {
        if [ "$1" = "auth" ] && [ "$2" = "status" ]; then
            echo "Unexpected error: network timeout" >&2
            return 42  # Unusual error code
        fi
        # Fall back to default mock behavior for other commands
        command gh "$@"
    }
    export -f mock_gh
    
    # Use mock_gh for gh command
    GH_CMD=mock_gh run verify_github_auth "testuser"
    
    # Function returns 1 for any gh CLI error (doesn't propagate exact code)
    # This test verifies that unexpected errors are handled gracefully
    [ "$status" -eq 1 ]
}

