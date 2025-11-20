#!/usr/bin/env bats

# BATS tests for template structure validation
# Tests that verify template paths and structure

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Template Structure Tests (TDD for standard-project)
# ============================================================================

@test "template_structure: standard-project template path resolves correctly" {
    # Test that template path building works with standard-project
    # This verifies the script change from regular-project to standard-project
    # Use git root to find templates (works in BATS temp directories)
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
    if [ -z "$git_root" ]; then
        # Fallback: try current directory
        local cwd="$(pwd)"
        if [ -d "$cwd/templates" ]; then
            git_root="$cwd"
        fi
    fi
    
    [ -n "$git_root" ]
    local templates_dir="$git_root/templates"
    
    # Verify standard-project exists (after Phase 1 rename)
    [ -d "$templates_dir/standard-project" ]
    
    # Verify template path that script would build
    local template_type="standard-project"
    local expected_template_dir="$templates_dir/$template_type"
    [ -d "$expected_template_dir" ]
}

@test "template_structure: regular-project template no longer exists" {
    # Test that old regular-project template is gone
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
    local templates_dir="$git_root/templates"
    
    # Verify regular-project does not exist
    [ ! -d "$templates_dir/regular-project" ]
}

@test "template_structure: both template types available" {
    # Test that both standard-project and learning-project templates exist
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
    local templates_dir="$git_root/templates"
    
    [ -d "$templates_dir/standard-project" ]
    [ -d "$templates_dir/learning-project" ]
}

