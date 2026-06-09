#!/usr/bin/env bats

# Graceful degradation: generated projects work without skills installed (NFR-BNDL-1).

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    if [[ -n "$BATS_RUN_TMPDIR" ]]; then
        TEST_DIR="$BATS_RUN_TMPDIR/graceful-degradation-$$"
    else
        TEST_DIR=$(mktemp -d)
    fi
    mkdir -p "$TEST_DIR"
    export TEST_DIR
    export PROJECT_NAME="graceful-test"
    export PROJECT_TYPE="standard-project"
    export PROJECT_DESCRIPTION="Graceful degradation test project"
    export INIT_GIT="false"
    export TARGET_DIR="$TEST_DIR"
    export NEW_PROJECT_SCRIPT="$PROJECT_ROOT/scripts/new-project.sh"
}

teardown() {
    if [[ -n "$TEST_DIR" && -d "$TEST_DIR" ]]; then
        rm -rf "$TEST_DIR"
    fi
    cleanup_test_env
}

@test "graceful-degradation: new-project.sh succeeds without skills installed" {
    run "$NEW_PROJECT_SCRIPT" --non-interactive

    [ "$status" -eq 0 ]
    [ -d "$TEST_DIR/graceful-test" ]
}

@test "graceful-degradation: generated project ships expected_skills manifest" {
    run "$NEW_PROJECT_SCRIPT" --non-interactive

    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/graceful-test/.dev-infra.yml" ]
    run grep -q 'expected_skills:' "$TEST_DIR/graceful-test/.dev-infra.yml"
    [ "$status" -eq 0 ]
    run grep -q 'explore' "$TEST_DIR/graceful-test/.dev-infra.yml"
    [ "$status" -eq 0 ]
}

@test "graceful-degradation: generated project has no bundled skills or commands" {
    run "$NEW_PROJECT_SCRIPT" --non-interactive

    [ "$status" -eq 0 ]
    [ ! -d "$TEST_DIR/graceful-test/.claude/skills" ]
    [ ! -d "$TEST_DIR/graceful-test/.cursor/commands" ]
}

@test "graceful-degradation: README orients agents without installed skills" {
    run "$NEW_PROJECT_SCRIPT" --non-interactive

    [ "$status" -eq 0 ]
    run grep -qi 'without skills' "$TEST_DIR/graceful-test/README.md"
    [ "$status" -eq 0 ]
}
