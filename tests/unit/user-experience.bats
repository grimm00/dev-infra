#!/usr/bin/env bats

# BATS tests for user experience and next steps
# Tests for show_next_steps() function

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# User Experience (Next Steps)
# ============================================================================

@test "user_experience: displays project name in next steps" {
    local project_dir="$TEST_TMPDIR/test-steps"
    mkdir -p "$project_dir"
    
    run show_next_steps "$project_dir" "Regular Project"
    
    [[ "$output" == *"test-steps"* ]]
}

@test "user_experience: displays project path in next steps" {
    local project_dir="$TEST_TMPDIR/test-path"
    mkdir -p "$project_dir"
    
    run show_next_steps "$project_dir" "Regular Project"
    
    [[ "$output" == *"$project_dir"* ]]
}

@test "user_experience: displays next steps instructions" {
    local project_dir="$TEST_TMPDIR/test-instructions"
    mkdir -p "$project_dir"
    
    run show_next_steps "$project_dir" "Regular Project"
    
    [[ "$output" == *"Next steps"* ]]
    [[ "$output" == *"cd"* ]]
}

@test "user_experience: displays learning project specific instructions" {
    local project_dir="$TEST_TMPDIR/test-learning"
    mkdir -p "$project_dir"
    
    run show_next_steps "$project_dir" "Learning Project"
    
    [[ "$output" == *"stage0-fundamentals"* ]]
}

@test "user_experience: displays regular project specific instructions" {
    local project_dir="$TEST_TMPDIR/test-regular"
    mkdir -p "$project_dir"
    
    run show_next_steps "$project_dir" "Regular Project"
    
    [[ "$output" == *"admin/planning"* ]] || [[ "$output" == *"project management"* ]]
}

