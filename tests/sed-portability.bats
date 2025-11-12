#!/usr/bin/env bats

# BATS tests for sed -i portability fix (PR #7)
# Tests that sed -i works correctly on macOS/BSD and GNU/Linux

setup() {
    export TEST_TMPDIR=$(mktemp -d)
    export TEST_FILE="$TEST_TMPDIR/test_file.txt"
}

teardown() {
    if [ -n "$TEST_TMPDIR" ] && [ -d "$TEST_TMPDIR" ]; then
        rm -rf "$TEST_TMPDIR"
    fi
}

@test "sed -i: works on macOS/BSD with empty string" {
    # Test the macOS/BSD syntax: sed -i ''
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
        echo "original text" > "$TEST_FILE"
        sed -i '' "s/original/changed/" "$TEST_FILE"
        
        [ "$(cat "$TEST_FILE")" = "changed text" ]
        [ ! -f "$TEST_FILE.bak" ]  # Should not create backup file
    else
        skip "Not on macOS/BSD"
    fi
}

@test "sed -i: works on GNU/Linux without extension" {
    # Test the GNU/Linux syntax: sed -i
    if [[ "$OSTYPE" != "darwin"* ]] && [[ "$OSTYPE" != "freebsd"* ]]; then
        echo "original text" > "$TEST_FILE"
        sed -i "s/original/changed/" "$TEST_FILE"
        
        [ "$(cat "$TEST_FILE")" = "changed text" ]
    else
        skip "Not on GNU/Linux"
    fi
}

@test "sed -i: OSTYPE detection works correctly" {
    # Test that our OSTYPE detection logic works
    echo "test content" > "$TEST_FILE"
    
    # Simulate the logic from customize_project
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
        sed -i '' "s/test/TEST/" "$TEST_FILE"
    else
        sed -i "s/test/TEST/" "$TEST_FILE"
    fi
    
    [ "$(cat "$TEST_FILE")" = "TEST content" ]
    [ ! -f "$TEST_FILE.bak" ]  # Should not create backup file
}

@test "sed -i: multiple replacements work" {
    # Test multiple sed -i operations (like in customize_project)
    echo "[Project Name]" > "$TEST_FILE"
    echo "[Brief description of what this project does]" >> "$TEST_FILE"
    echo "[Date]" >> "$TEST_FILE"
    
    local project_name="test-project"
    local description="A test project"
    local current_date="2025-11-12"
    
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
        sed -i '' "s/\[Project Name\]/$project_name/g" "$TEST_FILE"
        sed -i '' "s/\[Brief description of what this project does\]/$description/g" "$TEST_FILE"
        sed -i '' "s/\[Date\]/$current_date/g" "$TEST_FILE"
    else
        sed -i "s/\[Project Name\]/$project_name/g" "$TEST_FILE"
        sed -i "s/\[Brief description of what this project does\]/$description/g" "$TEST_FILE"
        sed -i "s/\[Date\]/$current_date/g" "$TEST_FILE"
    fi
    
    local content=$(cat "$TEST_FILE")
    [[ "$content" == *"test-project"* ]]
    [[ "$content" == *"A test project"* ]]
    [[ "$content" == *"2025-11-12"* ]]
    [ ! -f "$TEST_FILE.bak" ]  # Should not create backup file
}

