#!/usr/bin/env bats

# Tests for scripts/create-release-branch.sh

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    SCRIPT="$PROJECT_ROOT/scripts/create-release-branch.sh"
}

teardown() {
    cleanup_test_env
}

@test "create-release-branch.sh exists and is executable" {
    [ -f "$SCRIPT" ]
    [ -x "$SCRIPT" ]
}

@test "create-release-branch.sh shows help with --help" {
    run "$SCRIPT" --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "create-release-branch.sh shows help with -h" {
    run "$SCRIPT" -h
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "create-release-branch.sh requires version argument" {
    run "$SCRIPT"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error:" || "$output" =~ "Usage:" ]]
}

@test "create-release-branch.sh validates version format" {
    run "$SCRIPT" "invalid-version"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "version" || "$output" =~ "format" ]]
}

@test "create-release-branch.sh accepts valid version format" {
    # Skip in CI - git operations may fail
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "Git branch operations may fail in CI"
    fi
    
    run "$SCRIPT" v1.5.0 --dry-run
    [ "$status" -eq 0 ]
}

@test "create-release-branch.sh generates RELEASE-READINESS.md" {
    # Skip in CI - git operations may fail
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "Git branch operations may fail in CI"
    fi
    
    # Create a test directory structure
    local test_releases="$TEST_TMPDIR/releases/v1.5.0"
    mkdir -p "$test_releases"
    
    # Run with --dry-run to see what would be created
    run "$SCRIPT" v1.5.0 --dry-run
    [ "$status" -eq 0 ]
    
    # Should mention generating RELEASE-READINESS.md
    [[ "$output" =~ "RELEASE-READINESS" || "$output" =~ "assessment" ]]
}

@test "create-release-branch.sh creates release directory if missing" {
    # Skip in CI - git operations may fail
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "Git branch operations may fail in CI"
    fi
    
    run "$SCRIPT" v1.5.0 --dry-run
    [ "$status" -eq 0 ]
    
    # Should mention creating directory
    [[ "$output" =~ "creat" || "$output" =~ "director" ]]
}

