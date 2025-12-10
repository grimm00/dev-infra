#!/usr/bin/env bats

# BATS tests for path expansion functionality
# Tests for expand_env_vars() function

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Path Expansion and Resolution
# ============================================================================

@test "path_expansion: expands \$HOME" {
    run expand_env_vars "\$HOME/test"
    [ "$status" -eq 0 ]
    [ "$output" = "$HOME/test" ]
}

@test "path_expansion: expands \$USER" {
    run expand_env_vars "\$USER/test"
    [ "$status" -eq 0 ]
    [ "$output" = "$USER/test" ]
}

@test "path_expansion: expands \$PWD" {
    run expand_env_vars "\$PWD/test"
    [ "$status" -eq 0 ]
    [ "$output" = "$PWD/test" ]
}

@test "path_expansion: expands ~ to home" {
    run expand_env_vars "~/test"
    [ "$status" -eq 0 ]
    [ "$output" = "$HOME/test" ]
}

@test "path_expansion: expands \${HOME} syntax" {
    run expand_env_vars "\${HOME}/test"
    [ "$status" -eq 0 ]
    [ "$output" = "$HOME/test" ]
}

@test "path_expansion: expands \${USER} syntax" {
    run expand_env_vars "\${USER}/test"
    [ "$status" -eq 0 ]
    [ "$output" = "$USER/test" ]
}

@test "path_expansion: expands \${PWD} syntax" {
    run expand_env_vars "\${PWD}/test"
    [ "$status" -eq 0 ]
    [ "$output" = "$PWD/test" ]
}

@test "path_expansion: handles mixed variables" {
    run expand_env_vars "\$HOME/\$USER/\${PWD}/test"
    [ "$status" -eq 0 ]
    [ "$output" = "$HOME/$USER/$PWD/test" ]
}

@test "path_expansion: handles empty path" {
    run expand_env_vars ""
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "path_expansion: handles undefined environment variables" {
    # Ensure variable is undefined
    unset UNDEFINED_VAR 2>/dev/null || true
    
    # Test with undefined variable in path
    local path_with_undefined="/home/\$UNDEFINED_VAR/projects"
    run expand_env_vars "$path_with_undefined"
    
    # Should handle gracefully - either expand to literal or return error
    # Current implementation expands undefined vars to empty string
    [ "$status" -eq 0 ]
    # Result should contain the literal path (undefined var becomes empty)
    [[ "$output" == *"/home/"* ]] || [[ "$output" == *"/projects"* ]]
}

