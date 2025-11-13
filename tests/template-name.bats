#!/usr/bin/env bats

# BATS tests for template name changes (regular-project → standard-project)
# Tests template path resolution and validation

load 'helpers.bash'

setup() {
    setup_test_env
    # Get the project root for template path resolution
    # BATS copies test files to temp dir, so we need to find project root differently
    # Try to find git root, or use a known path
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
    if [ -n "$git_root" ] && [ -d "$git_root/templates" ]; then
        export TEMPLATES_DIR="$git_root/templates"
    else
        # Fallback: assume we're in the project and templates is at ../templates from tests/
        # This works when running from project root
        local test_dir="$(dirname "${BASH_SOURCE[0]}")"
        # If test_dir is in a temp location, try to find actual project
        if [[ "$test_dir" == *"/bats-run-"* ]]; then
            # BATS temp directory - need to find actual project
            # Look for templates in common locations or use environment
            if [ -n "$DEV_INFRA_DIR" ] && [ -d "$DEV_INFRA_DIR/templates" ]; then
                export TEMPLATES_DIR="$DEV_INFRA_DIR/templates"
            else
                # Last resort: try to find from current working directory
                local cwd="$(pwd)"
                if [ -d "$cwd/templates" ]; then
                    export TEMPLATES_DIR="$(cd "$cwd/templates" && pwd)"
                else
                    echo "ERROR: Cannot find templates directory" >&2
                    export TEMPLATES_DIR=""
                fi
            fi
        else
            # Normal test execution - calculate from test file
            local project_root="$(cd "$test_dir/.." && pwd)"
            export TEMPLATES_DIR="$project_root/templates"
        fi
    fi
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Template Path Resolution Tests
# ============================================================================

@test "template_path: standard-project template directory exists" {
    # Test that standard-project template exists (after Phase 1 rename)
    [ -d "$TEMPLATES_DIR/standard-project" ]
}

@test "template_path: regular-project template directory does not exist" {
    # Test that old regular-project template is gone
    [ ! -d "$TEMPLATES_DIR/regular-project" ]
}

@test "template_path: standard-project has required structure" {
    # Test that standard-project has docs/maintainers structure
    [ -d "$TEMPLATES_DIR/standard-project/docs/maintainers" ]
    [ -f "$TEMPLATES_DIR/standard-project/docs/maintainers/README.md" ]
}

@test "template_path: standard-project does not have admin directory" {
    # Test that admin/ was removed (restructured to docs/maintainers/)
    [ ! -d "$TEMPLATES_DIR/standard-project/admin" ]
}

@test "template_path: learning-project still exists" {
    # Test that learning-project template still exists
    [ -d "$TEMPLATES_DIR/learning-project" ]
}

@test "template_path: learning-project has docs/maintainers structure" {
    # Test that learning-project was also restructured
    [ -d "$TEMPLATES_DIR/learning-project/docs/maintainers" ]
    [ -f "$TEMPLATES_DIR/learning-project/docs/maintainers/README.md" ]
}

@test "template_path: learning-project does not have admin directory" {
    # Test that admin/ was removed from learning-project
    [ ! -d "$TEMPLATES_DIR/learning-project/admin" ]
}

# ============================================================================
# Template Path Building Tests
# ============================================================================

@test "template_path_build: standard-project path resolves correctly" {
    # Test that template path building logic would work with standard-project
    local template_type="standard-project"
    local expected_path="$TEMPLATES_DIR/$template_type"
    
    [ -d "$expected_path" ]
    [ "$expected_path" = "$TEMPLATES_DIR/standard-project" ]
}

@test "template_path_build: invalid template name fails" {
    # Test that invalid template names are detected
    local template_type="nonexistent-template"
    local template_path="$TEMPLATES_DIR/$template_type"
    
    [ ! -d "$template_path" ]
}

# ============================================================================
# Template Structure Validation Tests
# ============================================================================

@test "template_structure: standard-project has essential files" {
    # Test that standard-project has all essential template files
    local template_dir="$TEMPLATES_DIR/standard-project"
    
    [ -f "$template_dir/README.md" ]
    [ -f "$template_dir/start.txt" ]
    [ -f "$template_dir/.gitignore" ]
    [ -d "$template_dir/docs" ]
    [ -d "$template_dir/docs/maintainers" ]
}

@test "template_structure: standard-project maintainers has hub structure" {
    # Test that maintainers directory follows hub-and-spoke pattern
    local maintainers_dir="$TEMPLATES_DIR/standard-project/docs/maintainers"
    
    [ -f "$maintainers_dir/README.md" ]
    [ -d "$maintainers_dir/planning" ]
    [ -d "$maintainers_dir/decisions" ]
    [ -d "$maintainers_dir/feedback" ]
    [ -d "$maintainers_dir/archived" ]
}

@test "template_structure: learning-project maintainers has hub structure" {
    # Test that learning-project maintainers follows hub-and-spoke pattern
    local maintainers_dir="$TEMPLATES_DIR/learning-project/docs/maintainers"
    
    [ -f "$maintainers_dir/README.md" ]
    [ -d "$maintainers_dir/planning" ]
    [ -d "$maintainers_dir/notes" ]
    [ -d "$maintainers_dir/research" ]
}

