#!/usr/bin/env bats

# BATS tests for new-project.sh
# Tests directory selection feature functions

load 'helpers.bash'

setup() {
    # Setup test environment before each test
    # This also defines the test functions
    setup_test_env
}

teardown() {
    # Cleanup after each test
    cleanup_test_env
}

# ============================================================================
# Unit Tests: expand_env_vars()
# ============================================================================

@test "expand_env_vars: expands \$HOME" {
    local result
    result=$(expand_env_vars "\$HOME/test")
    [ "$result" = "$HOME/test" ]
}

@test "expand_env_vars: expands \$USER" {
    local result
    result=$(expand_env_vars "\$USER/test")
    [ "$result" = "$USER/test" ]
}

@test "expand_env_vars: expands \$PWD" {
    local result
    result=$(expand_env_vars "\$PWD/test")
    [ "$result" = "$PWD/test" ]
}

@test "expand_env_vars: expands ~ to home" {
    local result
    result=$(expand_env_vars "~/test")
    [ "$result" = "$HOME/test" ]
}

@test "expand_env_vars: expands \${HOME} syntax" {
    local result
    result=$(expand_env_vars "\${HOME}/test")
    [ "$result" = "$HOME/test" ]
}

@test "expand_env_vars: expands \${USER} syntax" {
    local result
    result=$(expand_env_vars "\${USER}/test")
    [ "$result" = "$USER/test" ]
}

@test "expand_env_vars: expands \${PWD} syntax" {
    local result
    result=$(expand_env_vars "\${PWD}/test")
    [ "$result" = "$PWD/test" ]
}

@test "expand_env_vars: handles mixed variables" {
    local result
    result=$(expand_env_vars "\$HOME/\$USER/\${PWD}/test")
    [ "$result" = "$HOME/$USER/$PWD/test" ]
}

@test "expand_env_vars: handles empty path" {
    local result
    result=$(expand_env_vars "")
    [ -z "$result" ]
}

# ============================================================================
# Unit Tests: validate_target_directory()
# ============================================================================

@test "validate_target_directory: returns 0 for existing writable directory" {
    local test_dir="$TEST_TMPDIR/existing"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    result=$(validate_target_directory "$test_dir")
    exit_code=$?
    
    [ $exit_code -eq 0 ]
    [ "$result" = "$test_dir" ]
}

@test "validate_target_directory: returns 1 for empty path" {
    local result
    local exit_code
    result=$(validate_target_directory "")
    exit_code=$?
    
    [ $exit_code -eq 1 ]
}

@test "validate_target_directory: returns 2 for non-writable directory" {
    local test_dir="$TEST_TMPDIR/nowrite"
    mkdir -p "$test_dir"
    chmod -w "$test_dir" 2>/dev/null || skip "Cannot test non-writable directory on this system"
    
    local result
    local exit_code
    result=$(validate_target_directory "$test_dir")
    exit_code=$?
    
    [ $exit_code -eq 2 ]
    [ "$result" = "$test_dir" ]
}

@test "validate_target_directory: returns 3 for non-existent but creatable directory" {
    local parent_dir="$TEST_TMPDIR/parent"
    local test_dir="$parent_dir/newdir"
    mkdir -p "$parent_dir"
    
    local result
    local exit_code
    result=$(validate_target_directory "$test_dir")
    exit_code=$?
    
    [ $exit_code -eq 3 ]
    [ "$result" = "$test_dir" ]
}

@test "validate_target_directory: handles absolute paths" {
    local test_dir="$TEST_TMPDIR/absolute"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "$test_dir")
    
    [ "$result" = "$test_dir" ]
}

@test "validate_target_directory: handles relative paths" {
    local test_dir="$TEST_TMPDIR/relative"
    mkdir -p "$test_dir"
    cd "$TEST_TMPDIR"
    
    local result
    result=$(validate_target_directory "relative")
    
    [ "$result" = "$test_dir" ]
}

@test "validate_target_directory: handles environment variables in path" {
    local test_dir="$TEST_HOME/envtest"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "\$HOME/envtest")
    
    [ "$result" = "$test_dir" ]
}

@test "validate_target_directory: preserves root directory /" {
    # This tests the fix for root directory bug
    local result
    local exit_code
    result=$(validate_target_directory "/" 2>/dev/null)
    exit_code=$?
    
    # Should return the root directory, not empty string
    [ "$result" = "/" ]
    [ -n "$result" ]  # Most important: should not be empty
}

@test "validate_target_directory: normalizes trailing slashes" {
    local test_dir="$TEST_TMPDIR/trailing"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "$test_dir///")
    
    [ "$result" = "$test_dir" ]
}

@test "validate_target_directory: returns 1 when parent doesn't exist" {
    local test_dir="$TEST_TMPDIR/nonexistent/parent/newdir"
    
    local result
    local exit_code
    result=$(validate_target_directory "$test_dir")
    exit_code=$?
    
    [ $exit_code -eq 1 ]
    [ -n "$result" ]  # Should still return path
}

# ============================================================================
# Unit Tests: validate_project_name()
# ============================================================================

@test "validate_project_name: accepts valid project name" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    result=$(validate_project_name "test-project" "$test_dir" 2>/dev/null)
    exit_code=$?
    
    [ $exit_code -eq 0 ]
    [ "$result" = "$test_dir/test-project" ]
}

@test "validate_project_name: rejects empty name" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    result=$(validate_project_name "" "$test_dir" 2>/dev/null)
    exit_code=$?
    
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

@test "validate_project_name: detects names with spaces" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    result=$(validate_project_name "test project" "$test_dir" 2>/dev/null)
    exit_code=$?
    
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

@test "validate_project_name: rejects invalid characters" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    result=$(validate_project_name "test@project" "$test_dir" 2>/dev/null)
    exit_code=$?
    
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

@test "validate_project_name: detects existing directory" {
    local test_dir="$TEST_TMPDIR/projects"
    local existing_dir="$test_dir/existing"
    mkdir -p "$existing_dir"
    
    local result
    local exit_code
    result=$(validate_project_name "existing" "$test_dir" 2>/dev/null)
    exit_code=$?
    
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

# ============================================================================
# Integration Tests: Path Resolution
# ============================================================================

@test "integration: absolute path resolution end-to-end" {
    local test_dir="$TEST_TMPDIR/integration/absolute"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "$test_dir")
    
    [ "$result" = "$test_dir" ]
    [ -d "$result" ]
}

@test "integration: relative path resolution end-to-end" {
    local test_dir="$TEST_TMPDIR/integration/relative"
    mkdir -p "$test_dir"
    cd "$TEST_TMPDIR/integration"
    
    local result
    result=$(validate_target_directory "relative")
    
    [ "$result" = "$test_dir" ]
}

@test "integration: environment variable expansion in path" {
    local test_dir="$TEST_HOME/integration/env"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "\$HOME/integration/env")
    
    [ "$result" = "$test_dir" ]
}

@test "integration: tilde expansion in path" {
    local test_dir="$TEST_HOME/integration/tilde"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "~/integration/tilde")
    
    [ "$result" = "$test_dir" ]
}

# ============================================================================
# Regression Tests: Fix Verification
# ============================================================================

@test "regression: root directory fix - preserves /" {
    # This verifies the fix for PR #6 bug where / became empty string
    local result
    local exit_code
    set +e  # Don't fail on command substitution
    result=$(validate_target_directory "/" 2>/dev/null)
    exit_code=$?
    set -e
    
    # Should return /, not empty string (the key fix)
    [ "$result" = "/" ]
    [ -n "$result" ]
    # Exit code may be 0 (writable) or 2 (not writable), but result should be /
}

@test "regression: cross-platform sed fix - bash expansion works" {
    # This verifies the fix for PR #6 where sed was replaced with bash expansion
    # We test that space detection works (bash expansion is used internally)
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    # The function should detect spaces
    # We can't easily test the interactive part, but we can verify detection
    local result
    local exit_code
    set +e  # Don't fail on command substitution
    result=$(validate_project_name "test project" "$test_dir" 2>/dev/null)
    exit_code=$?
    set -e
    
    # Should detect spaces (non-zero exit)
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

@test "regression: silent failure fix - non-existent paths return error" {
    # This verifies the fix where non-existent paths failed silently
    local test_dir="$TEST_TMPDIR/nonexistent/path"
    
    local result
    local exit_code
    set +e  # Don't fail on command substitution
    result=$(validate_target_directory "$test_dir" 2>/dev/null)
    exit_code=$?
    set -e
    
    # Should return error code, not fail silently
    [ $exit_code -ne 0 ]
    [ -n "$result" ]  # Should still return path for caller
}

# ============================================================================
# Backward Compatibility Tests
# ============================================================================

@test "backward_compat: script works from any directory" {
    # Test that path resolution works regardless of current directory
    local test_dir="$TEST_TMPDIR/backward"
    mkdir -p "$test_dir"
    
    # Change to different directory
    cd "$TEST_TMPDIR"
    
    local result
    result=$(validate_target_directory "$test_dir")
    
    [ "$result" = "$test_dir" ]
}

@test "backward_compat: relative paths resolve correctly" {
    # Test that relative paths work as expected
    local test_dir="$TEST_TMPDIR/backward/relative"
    mkdir -p "$test_dir"
    cd "$TEST_TMPDIR/backward"
    
    local result
    result=$(validate_target_directory "relative")
    
    [ "$result" = "$test_dir" ]
}

