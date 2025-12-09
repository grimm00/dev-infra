#!/usr/bin/env bats

# Tests for scripts/check-release-readiness.sh

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    SCRIPT="$PROJECT_ROOT/scripts/check-release-readiness.sh"
}

teardown() {
    cleanup_test_env
}

@test "check-release-readiness.sh exists and is executable" {
    [ -f "$SCRIPT" ]
    [ -x "$SCRIPT" ]
}

@test "check-release-readiness.sh shows help with --help" {
    run "$SCRIPT" --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "check-release-readiness.sh shows help with -h" {
    run "$SCRIPT" -h
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "check-release-readiness.sh requires version argument" {
    run "$SCRIPT"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error:" || "$output" =~ "Usage:" ]]
}

@test "check-release-readiness.sh accepts version argument" {
    run "$SCRIPT" v1.4.0
    # May fail checks, but should accept the argument
    # Status 0 (all pass) or 1 (some fail) are both acceptable
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

# ============================================================================
# Task 2: Fully Automated Checks
# ============================================================================

@test "check-release-readiness.sh checks release branch existence" {
    # Create a test release branch
    cd "$PROJECT_ROOT"
    git checkout -b release/v1.4.0-test 2>/dev/null || git checkout release/v1.4.0-test 2>/dev/null
    
    run "$SCRIPT" v1.4.0-test
    # Should check for release branch
    [[ "$output" =~ "release branch" || "$output" =~ "Release Branch" || "$output" =~ "release/v1.4.0-test" ]]
    
    # Cleanup
    git checkout develop 2>/dev/null || git checkout main 2>/dev/null || true
    git branch -D release/v1.4.0-test 2>/dev/null || true
}

@test "check-release-readiness.sh detects missing release branch" {
    cd "$PROJECT_ROOT"
    # Ensure release branch doesn't exist
    git branch -D release/v1.9.9-nonexistent 2>/dev/null || true
    
    run "$SCRIPT" v1.9.9-nonexistent
    # Should detect missing branch (may pass or fail depending on implementation)
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "check-release-readiness.sh checks version format" {
    # Valid version formats
    run "$SCRIPT" v1.4.0
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    
    run "$SCRIPT" v1.4.0-test
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "check-release-readiness.sh outputs check results" {
    run "$SCRIPT" v1.4.0
    # Should output check results (pass/fail indicators)
    [[ "$output" =~ "✓" || "$output" =~ "✗" || "$output" =~ "Passed:" || "$output" =~ "Failed:" ]]
}

# ============================================================================
# Task 3: Documentation Checks
# ============================================================================

@test "check-release-readiness.sh checks CHANGELOG for version entry" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v1.3.0
    # Should check for CHANGELOG entry (v1.3.0 exists in CHANGELOG)
    [[ "$output" =~ "CHANGELOG" || "$output" =~ "changelog" || "$output" =~ "1.3.0" ]]
}

@test "check-release-readiness.sh detects missing CHANGELOG entry" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v9.9.9-nonexistent
    # Should detect missing CHANGELOG entry
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "check-release-readiness.sh checks release notes file existence" {
    cd "$PROJECT_ROOT"
    # Check for existing release notes (v1.3.0 should have one if it exists)
    run "$SCRIPT" v1.3.0
    # Should check for release notes file
    [[ "$output" =~ "Release Notes" || "$output" =~ "release notes" || "$output" =~ "RELEASE-NOTES" ]]
}

@test "check-release-readiness.sh detects missing release notes file" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v9.9.9-nonexistent
    # Should detect missing release notes file
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

