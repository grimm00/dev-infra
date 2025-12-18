#!/usr/bin/env bats

# BATS tests for validate-template-sync.sh script
# Tests for template synchronization validation

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    
    # Path to script
    SCRIPT="$PROJECT_ROOT/scripts/validate-template-sync.sh"
    
    # Path to manifest
    MANIFEST="$PROJECT_ROOT/scripts/template-sync-manifest.txt"
    
    # Test template directories
    TEST_STANDARD_DIR="$TEST_TMPDIR/standard-project"
    TEST_LEARNING_DIR="$TEST_TMPDIR/learning-project"
    
    # Create test template directories
    mkdir -p "$TEST_STANDARD_DIR"
    mkdir -p "$TEST_LEARNING_DIR"
    
    # Create test manifest
    mkdir -p "$TEST_TMPDIR/scripts"
    echo "# Test manifest" > "$TEST_TMPDIR/scripts/template-sync-manifest.txt"
    echo "test-file.txt" >> "$TEST_TMPDIR/scripts/template-sync-manifest.txt"
    echo "test-dir/" >> "$TEST_TMPDIR/scripts/template-sync-manifest.txt"
}

teardown() {
    cleanup_test_env
    
    # Clean up test directories
    rm -rf "$TEST_STANDARD_DIR" 2>/dev/null || true
    rm -rf "$TEST_LEARNING_DIR" 2>/dev/null || true
    rm -rf "$TEST_TMPDIR/scripts" 2>/dev/null || true
}

# ============================================================================
# Basic Functionality Tests
# ============================================================================

@test "validate-template-sync: passes when templates are in sync" {
    # Setup: Create identical files in both templates
    echo "identical content" > "$TEST_STANDARD_DIR/test-file.txt"
    echo "identical content" > "$TEST_LEARNING_DIR/test-file.txt"
    
    mkdir -p "$TEST_STANDARD_DIR/test-dir"
    mkdir -p "$TEST_LEARNING_DIR/test-dir"
    echo "dir content" > "$TEST_STANDARD_DIR/test-dir/file.txt"
    echo "dir content" > "$TEST_LEARNING_DIR/test-dir/file.txt"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Templates in sync = success (no drift)
    [ "$status" -eq 0 ]
}

@test "validate-template-sync: fails when shared file differs" {
    # Setup: Create different content in one template
    echo "content version 1" > "$TEST_STANDARD_DIR/test-file.txt"
    echo "content version 2" > "$TEST_LEARNING_DIR/test-file.txt"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # File differences detected = failure (drift detected)
    [ "$status" -ne 0 ]
}

@test "validate-template-sync: ignores template-specific files" {
    # Setup: Create template-specific file (not in manifest)
    echo "learning content" > "$TEST_LEARNING_DIR/learning-only.txt"
    
    # Create identical shared files
    echo "shared content" > "$TEST_STANDARD_DIR/test-file.txt"
    echo "shared content" > "$TEST_LEARNING_DIR/test-file.txt"
    
    # Create identical shared directories (required by manifest)
    mkdir -p "$TEST_STANDARD_DIR/test-dir"
    mkdir -p "$TEST_LEARNING_DIR/test-dir"
    echo "dir content" > "$TEST_STANDARD_DIR/test-dir/file.txt"
    echo "dir content" > "$TEST_LEARNING_DIR/test-dir/file.txt"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Template-specific files ignored = success (no drift)
    [ "$status" -eq 0 ]
}

# ============================================================================
# Edge Case Tests
# ============================================================================

@test "validate-template-sync: handles empty manifest gracefully" {
    # Setup: Create empty manifest
    echo "" > "$TEST_TMPDIR/scripts/template-sync-manifest.txt"
    
    # Run script with empty manifest
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Empty manifest should succeed (no files to check = no drift)
    [ "$status" -eq 0 ]
    # Verify output indicates successful validation
    [[ "$output" == *"Template sync validation PASSED"* ]] || \
    [[ "$output" == *"All shared files are in sync"* ]]
}

@test "validate-template-sync: handles missing template directory" {
    # Setup: Remove one template directory
    rm -rf "$TEST_LEARNING_DIR"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Missing template directory = failure (error condition)
    [ "$status" -ne 0 ]
}

@test "validate-template-sync: handles missing manifest file" {
    # Setup: Remove manifest
    rm -f "$TEST_TMPDIR/scripts/template-sync-manifest.txt"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Missing manifest file = failure (error condition)
    [ "$status" -ne 0 ]
}

@test "validate-template-sync: handles whitespace-only differences" {
    # Setup: Create files with only whitespace differences
    echo "content" > "$TEST_STANDARD_DIR/test-file.txt"
    echo -e "content\n" > "$TEST_LEARNING_DIR/test-file.txt"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Whitespace differences detected = failure (drift detected)
    [ "$status" -ne 0 ]
}

@test "validate-template-sync: handles directory differences" {
    # Setup: Create directories with different files
    mkdir -p "$TEST_STANDARD_DIR/test-dir"
    mkdir -p "$TEST_LEARNING_DIR/test-dir"
    echo "file1" > "$TEST_STANDARD_DIR/test-dir/file.txt"
    echo "file2" > "$TEST_LEARNING_DIR/test-dir/file.txt"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Directory differences detected = failure (drift detected)
    [ "$status" -ne 0 ]
}

@test "validate-template-sync: handles comments in manifest" {
    # Setup: Create manifest with comments
    cat > "$TEST_TMPDIR/scripts/template-sync-manifest.txt" <<EOF
# This is a comment
test-file.txt
# Another comment
test-dir/
EOF
    
    # Create identical files and directories
    echo "content" > "$TEST_STANDARD_DIR/test-file.txt"
    echo "content" > "$TEST_LEARNING_DIR/test-file.txt"
    mkdir -p "$TEST_STANDARD_DIR/test-dir"
    mkdir -p "$TEST_LEARNING_DIR/test-dir"
    echo "dir content" > "$TEST_STANDARD_DIR/test-dir/file.txt"
    echo "dir content" > "$TEST_LEARNING_DIR/test-dir/file.txt"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Comments ignored, files validated = success (no drift)
    [ "$status" -eq 0 ]
}

@test "validate-template-sync: detects file missing in learning" {
    # Setup: File exists in standard but not learning
    echo "content" > "$TEST_STANDARD_DIR/test-file.txt"
    # (don't create in learning)
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Should fail - drift detected (file missing in learning)
    [ "$status" -ne 0 ]
    [[ "$output" == *"missing"* ]] || [[ "$output" == *"DRIFT"* ]] || \
    [[ "$output" == *"test-file.txt"* ]]
}

@test "validate-template-sync: detects file missing in standard" {
    # Setup: File exists in learning but not standard
    echo "content" > "$TEST_LEARNING_DIR/test-file.txt"
    # (don't create in standard)
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Should fail - drift detected (file missing in standard)
    [ "$status" -ne 0 ]
    [[ "$output" == *"missing"* ]] || [[ "$output" == *"DRIFT"* ]] || \
    [[ "$output" == *"test-file.txt"* ]]
}

@test "validate-template-sync: detects directory missing in learning" {
    # Setup: Directory exists in standard but not learning
    mkdir -p "$TEST_STANDARD_DIR/test-dir"
    echo "file" > "$TEST_STANDARD_DIR/test-dir/file.txt"
    # (don't create in learning)
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Should fail - drift detected (directory missing in learning)
    [ "$status" -ne 0 ]
    [[ "$output" == *"missing"* ]] || [[ "$output" == *"DRIFT"* ]] || \
    [[ "$output" == *"test-dir"* ]]
}

@test "validate-template-sync: outputs clear error messages" {
    # Setup: Create different content
    echo "content1" > "$TEST_STANDARD_DIR/test-file.txt"
    echo "content2" > "$TEST_LEARNING_DIR/test-file.txt"
    
    # Run script with test directories
    cd "$TEST_TMPDIR"
    STANDARD_DIR="$TEST_STANDARD_DIR" LEARNING_DIR="$TEST_LEARNING_DIR" \
    MANIFEST="$TEST_TMPDIR/scripts/template-sync-manifest.txt" \
    run bash "$SCRIPT" 2>&1
    
    # Assert specific exit status (drift detected = failure)
    [ "$status" -ne 0 ]
    # Verify output contains drift detection message
    [[ "$output" == *"DRIFT DETECTED"* ]] || \
    [[ "$output" == *"Template sync validation FAILED"* ]]
}
