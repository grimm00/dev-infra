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
    # Create a mock gh that returns an unexpected error code
    local mock_gh_script="$TEST_TMPDIR/gh"
    cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
echo "Unexpected error: network timeout" >&2
exit 42  # Unusual error code
MOCKEOF
    chmod +x "$mock_gh_script"
    export PATH="$TEST_TMPDIR:$PATH"
    hash -r 2>/dev/null || true
    
    run verify_github_auth "testuser"
    # Should handle the error gracefully (return non-zero)
    [ "$status" -ne 0 ]
}

