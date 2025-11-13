#!/usr/bin/env bats

# BATS tests for new-project.sh
# Tests organized by behavior/specification

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
# Path Expansion and Resolution
# ============================================================================

@test "path_expansion: expands \$HOME" {
    local result
    result=$(expand_env_vars "\$HOME/test")
    [ "$result" = "$HOME/test" ]
}

@test "path_expansion: expands \$USER" {
    local result
    result=$(expand_env_vars "\$USER/test")
    [ "$result" = "$USER/test" ]
}

@test "path_expansion: expands \$PWD" {
    local result
    result=$(expand_env_vars "\$PWD/test")
    [ "$result" = "$PWD/test" ]
}

@test "path_expansion: expands ~ to home" {
    local result
    result=$(expand_env_vars "~/test")
    [ "$result" = "$HOME/test" ]
}

@test "path_expansion: expands \${HOME} syntax" {
    local result
    result=$(expand_env_vars "\${HOME}/test")
    [ "$result" = "$HOME/test" ]
}

@test "path_expansion: expands \${USER} syntax" {
    local result
    result=$(expand_env_vars "\${USER}/test")
    [ "$result" = "$USER/test" ]
}

@test "path_expansion: expands \${PWD} syntax" {
    local result
    result=$(expand_env_vars "\${PWD}/test")
    [ "$result" = "$PWD/test" ]
}

@test "path_expansion: handles mixed variables" {
    local result
    result=$(expand_env_vars "\$HOME/\$USER/\${PWD}/test")
    [ "$result" = "$HOME/$USER/$PWD/test" ]
}

@test "path_expansion: handles empty path" {
    local result
    result=$(expand_env_vars "")
    [ -z "$result" ]
}

# ============================================================================
# Directory Validation and Path Resolution
# ============================================================================

@test "directory_validation: accepts existing writable directory" {
    local test_dir="$TEST_TMPDIR/existing"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    set +e
    result=$(validate_target_directory "$test_dir")
    exit_code=$?
    set -e
    
    [ $exit_code -eq 0 ]
    [ "$result" = "$test_dir" ]
}

@test "directory_validation: rejects empty path" {
    local result
    local exit_code
    set +e
    result=$(validate_target_directory "")
    exit_code=$?
    set -e
    
    [ $exit_code -eq 1 ]
}

@test "directory_validation: detects non-writable directory" {
    local test_dir="$TEST_TMPDIR/nowrite"
    mkdir -p "$test_dir"
    chmod -w "$test_dir" 2>/dev/null || skip "Cannot test non-writable directory on this system"
    
    local result
    local exit_code
    set +e
    result=$(validate_target_directory "$test_dir")
    exit_code=$?
    set -e
    
    [ $exit_code -eq 2 ]
    [ "$result" = "$test_dir" ]
}

@test "directory_validation: accepts non-existent but creatable directory" {
    local parent_dir="$TEST_TMPDIR/parent"
    local test_dir="$parent_dir/newdir"
    mkdir -p "$parent_dir"
    
    local result
    local exit_code
    set +e
    result=$(validate_target_directory "$test_dir")
    exit_code=$?
    set -e
    
    [ $exit_code -eq 3 ]
    [ "$result" = "$test_dir" ]
}

@test "directory_validation: handles absolute paths" {
    local test_dir="$TEST_TMPDIR/absolute"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "$test_dir")
    
    [ "$result" = "$test_dir" ]
}

@test "directory_validation: handles relative paths" {
    local test_dir="$TEST_TMPDIR/relative"
    mkdir -p "$test_dir"
    cd "$TEST_TMPDIR"
    
    local result
    result=$(validate_target_directory "relative")
    
    [ "$result" = "$test_dir" ]
}

@test "directory_validation: handles environment variables in path" {
    local test_dir="$TEST_HOME/envtest"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "\$HOME/envtest")
    
    [ "$result" = "$test_dir" ]
}

@test "directory_validation: preserves root directory /" {
    # This tests the fix for root directory bug
    local result
    local exit_code
    set +e
    result=$(validate_target_directory "/" 2>/dev/null)
    exit_code=$?
    set -e
    
    # Should return the root directory, not empty string
    [ "$result" = "/" ]
    [ -n "$result" ]  # Most important: should not be empty
}

@test "directory_validation: normalizes trailing slashes" {
    local test_dir="$TEST_TMPDIR/trailing"
    mkdir -p "$test_dir"
    
    local result
    result=$(validate_target_directory "$test_dir///")
    
    [ "$result" = "$test_dir" ]
}

@test "directory_validation: rejects path when parent doesn't exist" {
    local test_dir="$TEST_TMPDIR/nonexistent/parent/newdir"
    
    local result
    local exit_code
    set +e
    result=$(validate_target_directory "$test_dir")
    exit_code=$?
    set -e
    
    [ $exit_code -eq 1 ]
    [ -n "$result" ]  # Should still return path
}

# ============================================================================
# Project Name Validation
# ============================================================================

@test "project_name_validation: accepts valid project name" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    set +e
    result=$(validate_project_name "test-project" "$test_dir" 2>/dev/null)
    exit_code=$?
    set -e
    
    [ $exit_code -eq 0 ]
    [ "$result" = "$test_dir/test-project" ]
}

@test "project_name_validation: rejects empty name" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    set +e
    result=$(validate_project_name "" "$test_dir" 2>/dev/null)
    exit_code=$?
    set -e
    
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

@test "project_name_validation: detects names with spaces" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    set +e
    result=$(validate_project_name "test project" "$test_dir" 2>/dev/null)
    exit_code=$?
    set -e
    
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

@test "project_name_validation: rejects invalid characters" {
    local test_dir="$TEST_TMPDIR/projects"
    mkdir -p "$test_dir"
    
    local result
    local exit_code
    set +e
    result=$(validate_project_name "test@project" "$test_dir" 2>/dev/null)
    exit_code=$?
    set -e
    
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

@test "project_name_validation: detects existing directory" {
    local test_dir="$TEST_TMPDIR/projects"
    local existing_dir="$test_dir/existing"
    mkdir -p "$existing_dir"
    
    local result
    local exit_code
    set +e
    result=$(validate_project_name "existing" "$test_dir" 2>/dev/null)
    exit_code=$?
    set -e
    
    [ $exit_code -ne 0 ]
    [ -z "$result" ]
}

# ============================================================================
# Template Operations
# ============================================================================

@test "template_operations: copies standard-project template successfully" {
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
    [ -n "$git_root" ]
    
    local project_dir="$TEST_TMPDIR/test-project"
    local exit_code
    set +e
    copy_template "standard-project" "$project_dir"
    exit_code=$?
    set -e
    
    [ $exit_code -eq 0 ]
    [ -d "$project_dir" ]
    [ -f "$project_dir/README.md" ]
    [ -f "$project_dir/.gitignore" ]
}

@test "template_operations: copies learning-project template successfully" {
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
    [ -n "$git_root" ]
    
    local project_dir="$TEST_TMPDIR/test-learning"
    local exit_code
    set +e
    copy_template "learning-project" "$project_dir"
    exit_code=$?
    set -e
    
    [ $exit_code -eq 0 ]
    [ -d "$project_dir" ]
    [ -f "$project_dir/README.md" ]
}

@test "template_operations: returns error for non-existent template" {
    local project_dir="$TEST_TMPDIR/test-nonexistent"
    local exit_code
    set +e
    copy_template "nonexistent-template" "$project_dir"
    exit_code=$?
    set -e
    
    [ $exit_code -ne 0 ]
    [ ! -d "$project_dir" ]
}

@test "template_operations: verifies .gitignore exists after copy" {
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
    [ -n "$git_root" ]
    
    local project_dir="$TEST_TMPDIR/test-gitignore"
    local exit_code
    set +e
    copy_template "standard-project" "$project_dir"
    exit_code=$?
    set -e
    
    # Should succeed and have .gitignore
    [ $exit_code -eq 0 ]
    [ -f "$project_dir/.gitignore" ]
}

# ============================================================================
# File Customization (sed portability)
# ============================================================================

@test "file_customization: sed -i works on macOS/BSD with empty string" {
    # Test the macOS/BSD syntax: sed -i ''
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
        local test_file="$TEST_TMPDIR/test_readme.md"
        echo "[Project Name]" > "$test_file"
        echo "[Brief description of what this project does]" >> "$test_file"
        echo "[Date]" >> "$test_file"
        
        local project_dir="$TEST_TMPDIR/test-customize"
        mkdir -p "$project_dir"
        cp "$test_file" "$project_dir/README.md"
        
        customize_project "$project_dir" "Regular Project" "A test project" "Test Author" "2025-01-27"
        
        local content=$(cat "$project_dir/README.md")
        [[ "$content" == *"test-customize"* ]]
        [[ "$content" == *"A test project"* ]]
        [[ "$content" == *"2025-01-27"* ]]
        [ ! -f "$project_dir/README.md.bak" ]  # Should not create backup file
    else
        skip "Not on macOS/BSD"
    fi
}

@test "file_customization: sed -i works on GNU/Linux without extension" {
    # Test the GNU/Linux syntax: sed -i
    if [[ "$OSTYPE" != "darwin"* ]] && [[ "$OSTYPE" != "freebsd"* ]]; then
        local test_file="$TEST_TMPDIR/test_readme.md"
        echo "[Project Name]" > "$test_file"
        echo "[Brief description of what this project does]" >> "$test_file"
        echo "[Date]" >> "$test_file"
        
        local project_dir="$TEST_TMPDIR/test-customize"
        mkdir -p "$project_dir"
        cp "$test_file" "$project_dir/README.md"
        
        customize_project "$project_dir" "Regular Project" "A test project" "Test Author" "2025-01-27"
        
        local content=$(cat "$project_dir/README.md")
        [[ "$content" == *"test-customize"* ]]
        [[ "$content" == *"A test project"* ]]
        [[ "$content" == *"2025-01-27"* ]]
    else
        skip "Not on GNU/Linux"
    fi
}

@test "file_customization: OSTYPE detection works correctly" {
    # Test that our OSTYPE detection logic works
    local test_file="$TEST_TMPDIR/test_readme.md"
    echo "test content" > "$test_file"
    
    local project_dir="$TEST_TMPDIR/test-ostype"
    mkdir -p "$project_dir"
    cp "$test_file" "$project_dir/README.md"
    
    # Simulate the logic from customize_project
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
        sed -i '' "s/test/TEST/" "$project_dir/README.md"
    else
        sed -i "s/test/TEST/" "$project_dir/README.md"
    fi
    
    [ "$(cat "$project_dir/README.md")" = "TEST content" ]
    [ ! -f "$project_dir/README.md.bak" ]  # Should not create backup file
}

@test "file_customization: multiple replacements work" {
    # Test multiple sed -i operations (like in customize_project)
    local test_file="$TEST_TMPDIR/test_readme.md"
    echo "[Project Name]" > "$test_file"
    echo "[Brief description of what this project does]" >> "$test_file"
    echo "[Date]" >> "$test_file"
    
    local project_dir="$TEST_TMPDIR/test-multiple"
    mkdir -p "$project_dir"
    cp "$test_file" "$project_dir/README.md"
    
    local project_name="test-project"
    local description="A test project"
    local current_date="2025-01-27"
    
    customize_project "$project_dir" "Regular Project" "$description" "Test Author" "$current_date"
    
    local content=$(cat "$project_dir/README.md")
    [[ "$content" == *"test-multiple"* ]]
    [[ "$content" == *"A test project"* ]]
    [[ "$content" == *"2025-01-27"* ]]
    [ ! -f "$project_dir/README.md.bak" ]  # Should not create backup file
}

@test "file_customization: updates README.md with project name" {
    local project_dir="$TEST_TMPDIR/test-readme"
    mkdir -p "$project_dir"
    echo "[Project Name]" > "$project_dir/README.md"
    echo "[Brief description of what this project does]" >> "$project_dir/README.md"
    echo "[Date]" >> "$project_dir/README.md"
    
    customize_project "$project_dir" "Regular Project" "Test description" "Test Author" "2025-01-27"
    
    local content=$(cat "$project_dir/README.md")
    [[ "$content" == *"test-readme"* ]]
    [[ "$content" != *"[Project Name]"* ]]
}

@test "file_customization: updates README.md with description" {
    local project_dir="$TEST_TMPDIR/test-desc"
    mkdir -p "$project_dir"
    echo "[Project Name]" > "$project_dir/README.md"
    echo "[Brief description of what this project does]" >> "$project_dir/README.md"
    echo "[Date]" >> "$project_dir/README.md"
    
    customize_project "$project_dir" "Regular Project" "My test description" "Test Author" "2025-01-27"
    
    local content=$(cat "$project_dir/README.md")
    [[ "$content" == *"My test description"* ]]
    [[ "$content" != *"[Brief description of what this project does]"* ]]
}

@test "file_customization: updates README.md with date" {
    local project_dir="$TEST_TMPDIR/test-date"
    mkdir -p "$project_dir"
    echo "[Project Name]" > "$project_dir/README.md"
    echo "[Brief description of what this project does]" >> "$project_dir/README.md"
    echo "[Date]" >> "$project_dir/README.md"
    
    customize_project "$project_dir" "Regular Project" "Test description" "Test Author" "2025-01-27"
    
    local content=$(cat "$project_dir/README.md")
    [[ "$content" == *"2025-01-27"* ]]
    [[ "$content" != *"[Date]"* ]]
}

@test "file_customization: handles missing README.md gracefully" {
    local project_dir="$TEST_TMPDIR/test-no-readme"
    mkdir -p "$project_dir"
    # No README.md file
    
    local exit_code
    set +e
    customize_project "$project_dir" "Regular Project" "Test description" "Test Author" "2025-01-27"
    exit_code=$?
    set -e
    
    # Should succeed even without README.md
    [ $exit_code -eq 0 ]
}

@test "file_customization: updates package.json if exists" {
    local project_dir="$TEST_TMPDIR/test-package"
    mkdir -p "$project_dir"
    echo '{"name": "old-name", "description": "old description"}' > "$project_dir/package.json"
    
    customize_project "$project_dir" "Regular Project" "New description" "Test Author" "2025-01-27"
    
    local content=$(cat "$project_dir/package.json")
    [[ "$content" == *"test-package"* ]]
    [[ "$content" == *"New description"* ]]
}

# ============================================================================
# GitHub Authentication
# ============================================================================

@test "github_auth: returns error when gh CLI not installed" {
    # Temporarily remove gh from PATH
    local original_path="$PATH"
    export PATH="/nonexistent:$PATH"
    
    local exit_code
    set +e
    verify_github_auth "testuser"
    exit_code=$?
    set -e
    
    export PATH="$original_path"
    
    [ $exit_code -ne 0 ]
}

@test "github_auth: returns error when not authenticated" {
    # Mock gh to return auth failure
    local mock_gh_script="$TEST_TMPDIR/mock_gh"
    cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
if [ "$1" = "auth" ] && [ "$2" = "status" ]; then
    exit 1  # Not authenticated
fi
exit 1
MOCKEOF
    chmod +x "$mock_gh_script"
    export PATH="$TEST_TMPDIR:$PATH"
    
    local exit_code
    set +e
    verify_github_auth "testuser"
    exit_code=$?
    set -e
    
    [ $exit_code -ne 0 ]
}

@test "github_auth: succeeds when authenticated and user matches" {
    # Mock gh to return successful auth with matching user
    local mock_gh_script="$TEST_TMPDIR/gh"
    cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
if [ "$1" = "auth" ] && [ "$2" = "status" ]; then
    exit 0  # Authenticated
fi
if [ "$1" = "api" ] && [ "$2" = "user" ]; then
    # Handle --jq flag: output JSON that jq can parse, or just the value
    if [ "$3" = "--jq" ] && [ "$4" = ".login" ]; then
        echo "testuser"
    else
        echo '{"login":"testuser"}'
    fi
    exit 0
fi
exit 1
MOCKEOF
    chmod +x "$mock_gh_script"
    export PATH="$TEST_TMPDIR:$PATH"
    # Clear command cache so mock is found
    hash -r 2>/dev/null || true
    
    local exit_code
    set +e
    verify_github_auth "testuser"
    exit_code=$?
    set -e
    
    [ $exit_code -eq 0 ]
}

@test "github_auth: returns mismatch when user doesn't match" {
    # Mock gh to return different user
    local mock_gh_script="$TEST_TMPDIR/gh"
    cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
if [ "$1" = "auth" ] && [ "$2" = "status" ]; then
    exit 0  # Authenticated
fi
if [ "$1" = "api" ] && [ "$2" = "user" ]; then
    # Handle --jq flag: output JSON that jq can parse, or just the value
    if [ "$3" = "--jq" ] && [ "$4" = ".login" ]; then
        echo "otheruser"
    else
        echo '{"login":"otheruser"}'
    fi
    exit 0
fi
exit 1
MOCKEOF
    chmod +x "$mock_gh_script"
    export PATH="$TEST_TMPDIR:$PATH"
    hash -r 2>/dev/null || true
    
    local exit_code
    set +e
    verify_github_auth "testuser"
    exit_code=$?
    set -e
    
    # Should return mismatch code (2)
    [ $exit_code -eq 2 ]
}

@test "github_auth: succeeds when no expected author provided" {
    # Mock gh to return successful auth
    local mock_gh_script="$TEST_TMPDIR/gh"
    cat > "$mock_gh_script" << 'MOCKEOF'
#!/bin/bash
if [ "$1" = "auth" ] && [ "$2" = "status" ]; then
    exit 0  # Authenticated
fi
if [ "$1" = "api" ] && [ "$2" = "user" ]; then
    # Handle --jq flag: output JSON that jq can parse, or just the value
    if [ "$3" = "--jq" ] && [ "$4" = ".login" ]; then
        echo "anyuser"
    else
        echo '{"login":"anyuser"}'
    fi
    exit 0
fi
exit 1
MOCKEOF
    chmod +x "$mock_gh_script"
    export PATH="$TEST_TMPDIR:$PATH"
    hash -r 2>/dev/null || true
    
    local exit_code
    set +e
    verify_github_auth ""
    exit_code=$?
    set -e
    
    [ $exit_code -eq 0 ]
}

# ============================================================================
# Git Repository Operations
# ============================================================================

@test "git_operations: initializes git repository successfully" {
    local project_dir="$TEST_TMPDIR/test-git"
    mkdir -p "$project_dir"
    echo "test file" > "$project_dir/test.txt"
    
    if ! command -v git &> /dev/null; then
        skip "Git not available"
    fi
    
    local exit_code
    set +e
    init_git_repo "$project_dir" "Test Author"
    exit_code=$?
    set -e
    
    [ $exit_code -eq 0 ]
    [ -d "$project_dir/.git" ]
}

@test "git_operations: creates initial commit" {
    local project_dir="$TEST_TMPDIR/test-commit"
    mkdir -p "$project_dir"
    echo "test file" > "$project_dir/test.txt"
    
    if ! command -v git &> /dev/null; then
        skip "Git not available"
    fi
    
    local exit_code
    set +e
    init_git_repo "$project_dir" "Test Author"
    exit_code=$?
    set -e
    
    [ $exit_code -eq 0 ]
    
    # Check that commit was created
    cd "$project_dir"
    local commit_count=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    [ "$commit_count" -eq 1 ]
}

@test "git_operations: handles cd failure gracefully" {
    local project_dir="$TEST_TMPDIR/nonexistent/project"
    # Directory doesn't exist, so cd will fail
    
    local exit_code
    set +e
    init_git_repo "$project_dir" "Test Author"
    exit_code=$?
    set -e
    
    [ $exit_code -ne 0 ]
}

@test "git_operations: returns to original directory" {
    local original_dir=$(pwd)
    local project_dir="$TEST_TMPDIR/test-return"
    mkdir -p "$project_dir"
    echo "test" > "$project_dir/test.txt"
    
    if ! command -v git &> /dev/null; then
        skip "Git not available"
    fi
    
    local exit_code
    set +e
    init_git_repo "$project_dir" "Test Author"
    exit_code=$?
    set -e
    
    # Should return to original directory (best effort)
    [ "$(pwd)" = "$original_dir" ] || [ $exit_code -ne 0 ]
}

# ============================================================================
# User Experience (Next Steps)
# ============================================================================

@test "user_experience: displays project name in next steps" {
    local project_dir="$TEST_TMPDIR/test-steps"
    mkdir -p "$project_dir"
    
    local output
    output=$(show_next_steps "$project_dir" "Regular Project")
    
    [[ "$output" == *"test-steps"* ]]
}

@test "user_experience: displays project path in next steps" {
    local project_dir="$TEST_TMPDIR/test-path"
    mkdir -p "$project_dir"
    
    local output
    output=$(show_next_steps "$project_dir" "Regular Project")
    
    [[ "$output" == *"$project_dir"* ]]
}

@test "user_experience: displays next steps instructions" {
    local project_dir="$TEST_TMPDIR/test-instructions"
    mkdir -p "$project_dir"
    
    local output
    output=$(show_next_steps "$project_dir" "Regular Project")
    
    [[ "$output" == *"Next steps"* ]]
    [[ "$output" == *"cd"* ]]
}

@test "user_experience: displays learning project specific instructions" {
    local project_dir="$TEST_TMPDIR/test-learning"
    mkdir -p "$project_dir"
    
    local output
    output=$(show_next_steps "$project_dir" "Learning Project")
    
    [[ "$output" == *"stage0-fundamentals"* ]]
}

@test "user_experience: displays regular project specific instructions" {
    local project_dir="$TEST_TMPDIR/test-regular"
    mkdir -p "$project_dir"
    
    local output
    output=$(show_next_steps "$project_dir" "Regular Project")
    
    [[ "$output" == *"admin/planning"* ]] || [[ "$output" == *"project management"* ]]
}

# ============================================================================
# Integration Tests: End-to-End Scenarios
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
# Regression Tests: Historical Bug Fixes
# ============================================================================

@test "regression: root directory fix preserves /" {
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
