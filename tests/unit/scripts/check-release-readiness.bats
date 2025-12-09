#!/usr/bin/env bats

# Tests for scripts/check-release-readiness.sh

setup() {
    # Get the directory of this test file
    TEST_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" && pwd)"
    PROJECT_ROOT="$(cd "$TEST_DIR/../../.." && pwd)"
    SCRIPT="$PROJECT_ROOT/scripts/check-release-readiness.sh"
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

