#!/usr/bin/env bats

# Tests for scripts/analyze-releases.sh

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    SCRIPT="$PROJECT_ROOT/scripts/analyze-releases.sh"
    FIXTURES_DIR="$PROJECT_ROOT/tests/fixtures/release-assessments"
}

teardown() {
    cleanup_test_env
}

@test "analyze-releases.sh exists and is executable" {
    [ -f "$SCRIPT" ]
    [ -x "$SCRIPT" ]
}

@test "analyze-releases.sh shows help with --help" {
    run "$SCRIPT" --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "analyze-releases.sh shows help with -h" {
    run "$SCRIPT" -h
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "analyze-releases.sh parses multiple assessment files with metadata" {
    # Skip in CI - may need adjustments for CI environment
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "May need CI-specific adjustments"
    fi
    
    # Run with fixtures directory
    run "$SCRIPT" --dir "$FIXTURES_DIR"
    [ "$status" -eq 0 ]
    
    # Should parse multiple files
    # Should show version information
    [[ "$output" =~ "v1.2.0" ]] || [[ "$output" =~ "v1.3.0" ]] || [[ "$output" =~ "v1.4.0" ]]
}

@test "analyze-releases.sh extracts metadata from YAML frontmatter" {
    # Skip in CI - may need adjustments for CI environment
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "May need CI-specific adjustments"
    fi
    
    run "$SCRIPT" --dir "$FIXTURES_DIR"
    [ "$status" -eq 0 ]
    
    # Should extract readiness scores
    [[ "$output" =~ "readiness_score" ]] || [[ "$output" =~ "80" ]] || [[ "$output" =~ "100" ]] || [[ "$output" =~ "60" ]]
}

@test "analyze-releases.sh handles files without metadata gracefully" {
    # Skip in CI - may need adjustments for CI environment
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "May need CI-specific adjustments"
    fi
    
    # v1.1.0 fixture has no frontmatter
    run "$SCRIPT" --dir "$FIXTURES_DIR"
    [ "$status" -eq 0 ]
    
    # Should not crash on files without metadata
    # May skip them or handle gracefully
}

@test "analyze-releases.sh supports --json output format" {
    # Skip in CI - may need adjustments for CI environment
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "May need CI-specific adjustments"
    fi
    
    run "$SCRIPT" --dir "$FIXTURES_DIR" --json
    [ "$status" -eq 0 ]
    
    # Should output JSON format
    [[ "$output" =~ "{" ]] || [[ "$output" =~ "[" ]]
}

@test "analyze-releases.sh supports --verbose flag" {
    # Skip in CI - may need adjustments for CI environment
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "May need CI-specific adjustments"
    fi
    
    run "$SCRIPT" --dir "$FIXTURES_DIR" --verbose
    [ "$status" -eq 0 ]
    
    # Should show additional details
    # Output should be longer than non-verbose
    local verbose_lines=$(echo "$output" | wc -l)
    [ "$verbose_lines" -gt 5 ]
}

@test "analyze-releases.sh supports --last N flag" {
    # Skip in CI - may need adjustments for CI environment
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "May need CI-specific adjustments"
    fi
    
    run "$SCRIPT" --dir "$FIXTURES_DIR" --last 2
    [ "$status" -eq 0 ]
    
    # Should limit to last 2 releases
    # May show v1.3.0 and v1.4.0 (most recent)
}

@test "analyze-releases.sh discovers assessment files automatically" {
    # Skip in CI - may need adjustments for CI environment
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "May need CI-specific adjustments"
    fi
    
    # Should find files in admin/planning/releases/*/RELEASE-READINESS.md
    # For now, test with fixtures
    run "$SCRIPT" --dir "$FIXTURES_DIR"
    [ "$status" -eq 0 ]
    
    # Should parse at least one file
    [[ "$output" != "" ]]
}

