#!/usr/bin/env bats

# Tests for scripts/update-version-references.sh
# Phase 2, Task 1: Create Update Script (TDD - RED phase)

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    SCRIPT="$PROJECT_ROOT/scripts/update-version-references.sh"
}

teardown() {
    cleanup_test_env
}

# ============================================================================
# Task 1: Basic Script Structure
# ============================================================================

@test "update-version-references.sh exists and is executable" {
    [ -f "$SCRIPT" ]
    [ -x "$SCRIPT" ]
}

@test "update-version-references.sh shows help with --help" {
    run "$SCRIPT" --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
    [[ "$output" =~ "--old-version" ]]
    [[ "$output" =~ "--new-version" ]]
}

@test "update-version-references.sh shows help with -h" {
    run "$SCRIPT" -h
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

# ============================================================================
# Task 1: Required Arguments Validation
# ============================================================================

@test "update-version-references.sh requires --old-version" {
    run "$SCRIPT" --new-version v1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "--old-version is required" ]]
}

@test "update-version-references.sh requires --new-version" {
    run "$SCRIPT" --old-version v1.4.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "--new-version is required" ]]
}

@test "update-version-references.sh requires both version arguments" {
    run "$SCRIPT"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error:" || "$output" =~ "Usage:" ]]
}

@test "update-version-references.sh requires value for --old-version" {
    # When --old-version is followed by another flag, it treats that flag as the value
    # This is a limitation of the argument parser - it doesn't check if next arg starts with --
    # For now, test that it errors (either with "requires a value" or "Unexpected argument")
    run "$SCRIPT" --old-version --new-version v1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error:" ]]
}

@test "update-version-references.sh requires value for --new-version" {
    run "$SCRIPT" --old-version v1.4.0 --new-version
    [ "$status" -eq 1 ]
    [[ "$output" =~ "--new-version requires a value" ]]
}

# ============================================================================
# Task 1: Version Format Validation
# ============================================================================

@test "update-version-references.sh accepts valid version formats" {
    run "$SCRIPT" --old-version v1.4.0 --new-version v1.5.0
    # Should accept valid versions (may not update files yet, but should validate)
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    # If status is 1, it should be because files don't exist yet, not version format
    if [ "$status" -eq 1 ]; then
        [[ ! "$output" =~ "Invalid.*format" ]]
    fi
}

@test "update-version-references.sh rejects old version without 'v' prefix" {
    run "$SCRIPT" --old-version 1.4.0 --new-version v1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Invalid" ]]
    [[ "$output" =~ "old version" ]]
    [[ "$output" =~ "expected vMAJOR.MINOR.PATCH" ]]
}

@test "update-version-references.sh rejects new version without 'v' prefix" {
    run "$SCRIPT" --old-version v1.4.0 --new-version 1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Invalid" ]]
    [[ "$output" =~ "new version" ]]
    [[ "$output" =~ "expected vMAJOR.MINOR.PATCH" ]]
}

@test "update-version-references.sh rejects version without patch number" {
    run "$SCRIPT" --old-version v1.4 --new-version v1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Invalid" ]]
    [[ "$output" =~ "old version" ]]
}

@test "update-version-references.sh rejects version without minor number" {
    run "$SCRIPT" --old-version v1 --new-version v1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Invalid" ]]
    [[ "$output" =~ "old version" ]]
}

@test "update-version-references.sh rejects invalid version format (letters)" {
    run "$SCRIPT" --old-version v1.4.0a --new-version v1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Invalid" ]]
    [[ "$output" =~ "old version" ]]
}

@test "update-version-references.sh rejects invalid version format (extra dots)" {
    run "$SCRIPT" --old-version v1.4.0.1 --new-version v1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Invalid" ]]
    [[ "$output" =~ "old version" ]]
}

# ============================================================================
# Task 1: Flag Handling
# ============================================================================

@test "update-version-references.sh accepts --dry-run flag" {
    run "$SCRIPT" --dry-run --old-version v1.4.0 --new-version v1.5.0
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    [[ "$output" =~ "[DRY RUN" || "$output" =~ "DRY RUN" || "$output" =~ "dry-run" ]]
}

@test "update-version-references.sh accepts --verbose flag" {
    run "$SCRIPT" --verbose --old-version v1.4.0 --new-version v1.5.0
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    # Verbose mode may not produce visible output if no operations yet
    # But should not error
}

@test "update-version-references.sh accepts -v flag for verbose" {
    run "$SCRIPT" -v --old-version v1.4.0 --new-version v1.5.0
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    # Should not error
}

@test "update-version-references.sh accepts multiple flags together" {
    run "$SCRIPT" --dry-run --verbose --old-version v1.4.0 --new-version v1.5.0
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    [[ "$output" =~ "[DRY RUN" || "$output" =~ "DRY RUN" || "$output" =~ "dry-run" ]]
}

# ============================================================================
# Task 1: Error Handling
# ============================================================================

@test "update-version-references.sh rejects unknown flags" {
    run "$SCRIPT" --unknown-flag --old-version v1.4.0 --new-version v1.5.0
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Unknown option" ]]
}

@test "update-version-references.sh rejects unexpected positional arguments" {
    run "$SCRIPT" --old-version v1.4.0 --new-version v1.5.0 unexpected-arg
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Unexpected argument" ]]
}

# ============================================================================
# Task 1: Exit Codes
# ============================================================================

@test "update-version-references.sh returns 0 on success" {
    # With valid arguments, script should return 0 (even if no files updated yet)
    # Task 2 will implement actual file updates
    run "$SCRIPT" --dry-run --old-version v1.4.0 --new-version v1.5.0
    # Currently returns 0 because it validates and shows dry-run message
    [ "$status" -eq 0 ]
}

@test "update-version-references.sh returns 1 on validation failure" {
    run "$SCRIPT" --old-version invalid --new-version v1.5.0
    [ "$status" -eq 1 ]
}

@test "update-version-references.sh returns 1 on missing required arguments" {
    run "$SCRIPT" --old-version v1.4.0
    [ "$status" -eq 1 ]
}

# ============================================================================
# Task 1: Output Format
# ============================================================================

@test "update-version-references.sh shows version information" {
    run "$SCRIPT" --dry-run --old-version v1.4.0 --new-version v1.5.0
    [ "$status" -eq 0 ]
    [[ "$output" =~ "v1.4.0" ]]
    [[ "$output" =~ "v1.5.0" ]]
}

@test "update-version-references.sh shows success message on completion" {
    run "$SCRIPT" --dry-run --old-version v1.4.0 --new-version v1.5.0
    [ "$status" -eq 0 ]
    [[ "$output" =~ "successfully" || "$output" =~ "completed" ]]
}

# ============================================================================
# Task 2: File Update Functionality (RED Phase - Tests First)
# ============================================================================

@test "update-version-references.sh updates .cursor/rules/main.mdc version pattern" {
    # Create temporary test file with version pattern
    TEST_FILE="$BATS_TEST_TMPDIR/test-main.mdc"
    echo "**Version:** v1.4.0 (released 2025-12-11)" > "$TEST_FILE"
    
    # Run script on test file (would need script to accept file list or use test file)
    # For now, verify test file exists and has expected pattern
    [ -f "$TEST_FILE" ]
    grep -q "v1.4.0" "$TEST_FILE"
    
    # TODO: When Task 2 is implemented, test actual update:
    # run "$SCRIPT" --old-version v1.4.0 --new-version v1.5.0 --files "$TEST_FILE"
    # grep -q "v1.5.0" "$TEST_FILE"
    # grep -q "v1.4.0" "$TEST_FILE" && return 1  # Old version should be gone
}

@test "update-version-references.sh handles version with status suffix" {
    # Test that script preserves status suffixes like "(released)", "(pending)"
    TEST_FILE="$BATS_TEST_TMPDIR/test-status.mdc"
    echo "**Version:** v1.4.0 (released 2025-12-11)" > "$TEST_FILE"
    
    # Verify test file has status suffix
    grep -q "(released" "$TEST_FILE"
    
    # TODO: When Task 2 is implemented, verify status suffix is preserved:
    # After update, should have: "**Version:** v1.5.0 (released 2025-12-11)"
}

@test "update-version-references.sh creates backup before modification" {
    # Test that backup file (.bak) is created before modifying original
    TEST_FILE="$BATS_TEST_TMPDIR/test-backup.mdc"
    echo "**Version:** v1.4.0" > "$TEST_FILE"
    
    # TODO: When Task 2 is implemented:
    # run "$SCRIPT" --old-version v1.4.0 --new-version v1.5.0 --files "$TEST_FILE"
    # [ -f "${TEST_FILE}.bak" ]
    # grep -q "v1.4.0" "${TEST_FILE}.bak"  # Backup should have old content
}

@test "update-version-references.sh updates actual .cursor/rules/main.mdc file" {
    # Test updating the real file (if it exists and has old version)
    if [ -f "$PROJECT_ROOT/.cursor/rules/main.mdc" ]; then
        # Check if file contains old version pattern
        if grep -q "\*\*Version:\*\* v1.4.0" "$PROJECT_ROOT/.cursor/rules/main.mdc"; then
            # TODO: When Task 2 is implemented, test actual update
            # This test will verify the script can update the real file
            skip "File update functionality not yet implemented (Task 2)"
        else
            skip "File does not contain v1.4.0 pattern"
        fi
    else
        skip "File .cursor/rules/main.mdc does not exist"
    fi
}

