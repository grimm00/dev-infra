#!/usr/bin/env bats

# BATS tests for new-project.sh script
# Tests for experimental template generation functionality

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    
    # Set up test directories
    TEST_PROJECT_DIR="$TEST_TMPDIR/test-experimental"
    TEST_STANDARD_DIR="$TEST_TMPDIR/test-standard"
    TEST_LEARNING_DIR="$TEST_TMPDIR/test-learning"
    
    # Path to script
    SCRIPT="$PROJECT_ROOT/scripts/new-project.sh"
}

teardown() {
    cleanup_test_env
    
    # Clean up test project directories
    rm -rf "$TEST_PROJECT_DIR" 2>/dev/null || true
    rm -rf "$TEST_STANDARD_DIR" 2>/dev/null || true
    rm -rf "$TEST_LEARNING_DIR" 2>/dev/null || true
}

# ============================================================================
# Experimental Template Generation Tests
# ============================================================================

@test "new-project: generates experimental-project successfully" {
    export PROJECT_NAME="test-experimental"
    export PROJECT_TYPE="experimental-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_PROJECT_DIR" ]
    [ -f "$TEST_PROJECT_DIR/README.md" ]
    [ -f "$TEST_PROJECT_DIR/start.txt" ]
}

@test "new-project: validates experimental-project type" {
    export PROJECT_NAME="test-experimental"
    export PROJECT_TYPE="experimental-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    # Script should accept experimental-project without error
}

@test "new-project: experimental-project includes EXPERIMENTAL.md" {
    export PROJECT_NAME="test-experimental"
    export PROJECT_TYPE="experimental-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    [ -f "$TEST_PROJECT_DIR/docs/EXPERIMENTAL.md" ]
    # Verify key content exists
    grep -q "Experimental Commands" "$TEST_PROJECT_DIR/docs/EXPERIMENTAL.md" || \
    grep -q "experimental" "$TEST_PROJECT_DIR/docs/EXPERIMENTAL.md"
}

@test "new-project: experimental-project includes evolving commands" {
    export PROJECT_NAME="test-experimental"
    export PROJECT_TYPE="experimental-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    # Check that experimental commands directory exists
    [ -d "$TEST_PROJECT_DIR/.cursor/commands" ]
    # Check for at least one evolving command (status.md should exist)
    [ -f "$TEST_PROJECT_DIR/.cursor/commands/status.md" ]
}

@test "new-project: experimental-project README includes stability disclaimer" {
    export PROJECT_NAME="test-experimental"
    export PROJECT_TYPE="experimental-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    # Check README contains specific experimental template disclaimer
    grep -q "## ⚠️ Experimental Template" "$TEST_PROJECT_DIR/README.md"
    # Verify stability levels section exists
    grep -q "### Stability Levels" "$TEST_PROJECT_DIR/README.md"
}

@test "new-project: rejects invalid template type" {
    export PROJECT_NAME="test-invalid"
    export PROJECT_TYPE="invalid-template"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -ne 0 ]
    # Should error on invalid template type
}

@test "new-project: experimental-project has same structure as standard-project" {
    # Generate both templates
    export PROJECT_NAME="test-standard"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    run "$SCRIPT" --non-interactive
    [ "$status" -eq 0 ]
    
    export PROJECT_NAME="test-experimental"
    export PROJECT_TYPE="experimental-project"
    run "$SCRIPT" --non-interactive
    [ "$status" -eq 0 ]
    
    # Both should have core directories
    [ -d "$TEST_STANDARD_DIR/.cursor" ]
    [ -d "$TEST_STANDARD_DIR/docs" ]
    [ -d "$TEST_STANDARD_DIR/backend" ]
    [ -d "$TEST_STANDARD_DIR/frontend" ]
    
    [ -d "$TEST_PROJECT_DIR/.cursor" ]
    [ -d "$TEST_PROJECT_DIR/docs" ]
    [ -d "$TEST_PROJECT_DIR/backend" ]
    [ -d "$TEST_PROJECT_DIR/frontend" ]
}

@test "new-project: help text includes experimental-project" {
    run "$SCRIPT" --help
    
    [ "$status" -eq 0 ]
    # Help should mention experimental-project
    echo "$output" | grep -q "experimental-project" || \
    echo "$output" | grep -q "experimental"
}

