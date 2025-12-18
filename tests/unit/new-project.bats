#!/usr/bin/env bats

# BATS tests for new-project.sh script
# Tests for template generation functionality

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    
    # Set up test directories
    TEST_STANDARD_DIR="$TEST_TMPDIR/test-standard"
    TEST_LEARNING_DIR="$TEST_TMPDIR/test-learning"
    
    # Path to script
    SCRIPT="$PROJECT_ROOT/scripts/new-project.sh"
}

teardown() {
    # cleanup_test_env removes TEST_TMPDIR entirely, which includes all subdirectories
    cleanup_test_env
}

# ============================================================================
# Standard Template Generation Tests
# ============================================================================

@test "new-project: generates standard-project successfully" {
    export PROJECT_NAME="test-standard"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_STANDARD_DIR" ]
    [ -f "$TEST_STANDARD_DIR/README.md" ]
    [ -f "$TEST_STANDARD_DIR/start.txt" ]
}

@test "new-project: validates standard-project type" {
    export PROJECT_NAME="test-standard"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    # Script should accept standard-project without error
}

@test "new-project: standard-project includes all commands" {
    export PROJECT_NAME="test-standard"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    # Check that commands directory exists
    [ -d "$TEST_STANDARD_DIR/.cursor/commands" ]
    # Check for status.md command (previously experimental, now in all templates)
    [ -f "$TEST_STANDARD_DIR/.cursor/commands/status.md" ]
    # Check for other key commands
    [ -f "$TEST_STANDARD_DIR/.cursor/commands/pr.md" ]
    [ -f "$TEST_STANDARD_DIR/.cursor/commands/task-phase.md" ]
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

@test "new-project: standard-project has required structure" {
    export PROJECT_NAME="test-standard"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    [ "$status" -eq 0 ]
    
    # Core directories
    [ -d "$TEST_STANDARD_DIR/.cursor" ]
    [ -d "$TEST_STANDARD_DIR/docs" ]
    [ -d "$TEST_STANDARD_DIR/backend" ]
    [ -d "$TEST_STANDARD_DIR/frontend" ]
}

# ============================================================================
# Learning Template Generation Tests
# ============================================================================

@test "new-project: generates learning-project successfully" {
    export PROJECT_NAME="test-learning"
    export PROJECT_TYPE="learning-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    [ -d "$TEST_LEARNING_DIR" ]
    [ -f "$TEST_LEARNING_DIR/README.md" ]
    [ -f "$TEST_LEARNING_DIR/start.txt" ]
}

@test "new-project: learning-project includes all commands" {
    export PROJECT_NAME="test-learning"
    export PROJECT_TYPE="learning-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    
    [ "$status" -eq 0 ]
    # Check that commands directory exists
    [ -d "$TEST_LEARNING_DIR/.cursor/commands" ]
    # Check for status.md command (now in all templates)
    [ -f "$TEST_LEARNING_DIR/.cursor/commands/status.md" ]
}

@test "new-project: learning-project has stage directories" {
    export PROJECT_NAME="test-learning"
    export PROJECT_TYPE="learning-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    run "$SCRIPT" --non-interactive
    [ "$status" -eq 0 ]
    
    # Learning-specific directories
    [ -d "$TEST_LEARNING_DIR/stage0-fundamentals" ]
    [ -d "$TEST_LEARNING_DIR/practice-apps" ]
    [ -d "$TEST_LEARNING_DIR/reference" ]
}

# ============================================================================
# Help and Non-Interactive Mode Tests
# ============================================================================

@test "new-project: help text shows two template types" {
    run "$SCRIPT" --help
    
    [ "$status" -eq 0 ]
    # Help should mention both template types
    echo "$output" | grep -q "standard-project"
    echo "$output" | grep -q "learning-project"
}

@test "new-project: non-interactive mode works without prompts" {
    export PROJECT_NAME="test-nonint"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_TMPDIR"
    export INIT_GIT="false"
    
    # Run in non-interactive mode with timeout to prevent hanging if interactive
    run timeout 10 "$SCRIPT" --non-interactive
    
    # Should complete successfully without hanging
    [ "$status" -eq 0 ]
    # Output should NOT contain interactive prompts
    ! [[ "$output" == *"Press Enter"* ]]
    ! [[ "$output" == *"Continue?"* ]]
    ! [[ "$output" == *"Are you sure"* ]]
    # Project should be created
    [ -d "$TEST_TMPDIR/test-nonint" ]
}
