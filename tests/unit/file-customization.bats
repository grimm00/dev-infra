#!/usr/bin/env bats

# BATS tests for file customization functionality
# Tests for customize_project() function and sed portability

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
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
    
    run customize_project "$project_dir" "Regular Project" "Test description" "Test Author" "2025-01-27"
    
    # Should succeed even without README.md
    [ "$status" -eq 0 ]
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

@test "file_customization: preserves package.json additional fields" {
    local project_dir="$TEST_TMPDIR/test-package-fields"
    mkdir -p "$project_dir"
    
    # Create package.json with additional fields
    cat > "$project_dir/package.json" << 'EOF'
{
  "name": "{{PROJECT_NAME}}",
  "description": "{{PROJECT_DESCRIPTION}}",
  "scripts": {
    "test": "jest",
    "build": "webpack"
  },
  "dependencies": {
    "lodash": "^4.17.21"
  }
}
EOF
    
    customize_project "$project_dir" "Regular Project" "My description" "Test Author" "2025-01-27"
    
    # Verify additional fields preserved (check that scripts and dependencies still exist)
    local content=$(cat "$project_dir/package.json")
    [[ "$content" == *"test-package-fields"* ]]
    [[ "$content" == *"My description"* ]]
    [[ "$content" == *"scripts"* ]]
    [[ "$content" == *"dependencies"* ]]
    [[ "$content" == *"jest"* ]]
    [[ "$content" == *"lodash"* ]]
    
    # If jq is available, verify JSON structure
    if command -v jq >/dev/null 2>&1; then
        run jq -e '.scripts.test' "$project_dir/package.json"
        [ "$status" -eq 0 ]
        [ "$output" = '"jest"' ]
        
        run jq -e '.dependencies.lodash' "$project_dir/package.json"
        [ "$status" -eq 0 ]
    fi
}

