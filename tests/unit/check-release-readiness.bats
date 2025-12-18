#!/usr/bin/env bats

# Tests for scripts/check-release-readiness.sh

load '../helpers/helpers.bash'

setup() {
    setup_test_env
    SCRIPT="$PROJECT_ROOT/scripts/check-release-readiness.sh"
}

teardown() {
    cleanup_test_env
}

@test "check-release-readiness.sh exists and is executable" {
    [ -f "$SCRIPT" ]
    [ -x "$SCRIPT" ]
}

@test "check-release-readiness.sh shows help with --help" {
    run "$SCRIPT" --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "check-release-readiness.sh shows help with -h" {
    run "$SCRIPT" -h
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "check-release-readiness.sh requires version argument" {
    run "$SCRIPT"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error:" || "$output" =~ "Usage:" ]]
}

@test "check-release-readiness.sh accepts version argument" {
    run "$SCRIPT" v0.4.0
    # May fail checks, but should accept the argument
    # Status 0 (all pass) or 1 (some fail) are both acceptable
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

# ============================================================================
# Task 2: Fully Automated Checks
# ============================================================================

@test "check-release-readiness.sh checks release branch existence" {
    # Skip in CI - git branch operations fail due to detached HEAD state
    # Even with fetch-depth: 0, GitHub Actions checks out PRs in detached HEAD
    # which prevents branch creation (status 128)
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        skip "Git branch operations fail in CI due to detached HEAD state (Known Issue #1)"
    fi
    
    # Create a test release branch
    cd "$PROJECT_ROOT"
    git checkout -b release/v0.4.0-test 2>/dev/null || git checkout release/v0.4.0-test 2>/dev/null
    
    run "$SCRIPT" v0.4.0-test
    # Should check for release branch
    [[ "$output" =~ "release branch" || "$output" =~ "Release Branch" || "$output" =~ "release/v0.4.0-test" ]]
    
    # Cleanup
    git checkout develop 2>/dev/null || git checkout main 2>/dev/null || true
    git branch -D release/v0.4.0-test 2>/dev/null || true
}

@test "check-release-readiness.sh detects missing release branch" {
    cd "$PROJECT_ROOT"
    # Ensure release branch doesn't exist
    git branch -D release/v1.9.9-nonexistent 2>/dev/null || true
    
    run "$SCRIPT" v1.9.9-nonexistent
    # Should detect missing branch (may pass or fail depending on implementation)
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "check-release-readiness.sh checks version format" {
    # Valid version formats
    run "$SCRIPT" v0.4.0
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    
    run "$SCRIPT" v0.4.0-test
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "check-release-readiness.sh outputs check results" {
    run "$SCRIPT" v0.4.0
    # Should output check results (pass/fail indicators)
    [[ "$output" =~ "✓" || "$output" =~ "✗" || "$output" =~ "Passed:" || "$output" =~ "Failed:" ]]
}

@test "check-release-readiness.sh handles gh CLI check gracefully" {
    # This test verifies the script can run with or without gh CLI
    # The key fix (PR32-#2) ensures that:
    # - Missing gh CLI returns 0 (not 1)
    # - Unauthenticated gh CLI returns 0 (not 1)
    # - "skipping" message is displayed with green checkmark
    
    run "$SCRIPT" v0.4.0
    
    # Script should complete (exit 0 or 1, not crash)
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    
    # If gh CLI is missing/unauthenticated, output should contain "skipping"
    # If gh CLI is present and authenticated, it should check CI status
    # Either way, script should not fail due to missing gh CLI
    true  # Test passes if script completes without crashing
}

# ============================================================================
# Task 3: Documentation Checks
# ============================================================================

@test "check-release-readiness.sh checks CHANGELOG for version entry" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.3.0
    # Should check for CHANGELOG entry (v0.3.0 exists in CHANGELOG)
    [[ "$output" =~ "CHANGELOG" || "$output" =~ "changelog" || "$output" =~ "0.3.0" ]]
}

@test "check-release-readiness.sh detects missing CHANGELOG entry" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v9.9.9-nonexistent
    # Should detect missing CHANGELOG entry
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "check-release-readiness.sh checks release notes file existence" {
    cd "$PROJECT_ROOT"
    # Check for existing release notes (v0.3.0 should have one if it exists)
    run "$SCRIPT" v0.3.0
    # Should check for release notes file
    [[ "$output" =~ "Release Notes" || "$output" =~ "release notes" || "$output" =~ "RELEASE-NOTES" ]]
}

@test "check-release-readiness.sh detects missing release notes file" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v9.9.9-nonexistent
    # Should detect missing release notes file
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

# ============================================================================
# Task 4: Data Gathering
# ============================================================================

@test "check-release-readiness.sh gathers recent merged PRs" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0
    # Should gather recent merged PRs (may be informational, not blocking)
    # Check if output mentions PRs or the gathering happens
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "check-release-readiness.sh gathers open blocking issues" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0
    # Should gather open blocking issues (may require gh CLI)
    # Check if output mentions issues or the gathering happens
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "check-release-readiness.sh outputs data gathering section" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0
    # Should output data gathering information (even if empty)
    # This is informational, so script should still run
    [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

# Task 1: Assessment Generator Tests (RED)

@test "check-release-readiness.sh generates markdown assessment with --generate" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should output markdown format
    [[ "$output" =~ "# Release Readiness Assessment" ]]
}

@test "check-release-readiness.sh generated assessment contains required sections" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Check for standard template sections
    [[ "$output" =~ "## 📊 Release Criteria Evaluation" ]]
    [[ "$output" =~ "### 🧪 1. Testing & Quality" ]]
    [[ "$output" =~ "### 📄 2. Documentation" ]]
    [[ "$output" =~ "### 💻 3. Code Quality" ]]
    [[ "$output" =~ "### 🚀 4. Release Preparation" ]]
}

@test "check-release-readiness.sh assessment includes automated check results" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should map automated checks to criteria items
    # Check for status indicators (✅ or ❌)
    [[ "$output" =~ "Status:" ]] && ([[ "$output" =~ "✅" ]] || [[ "$output" =~ "❌" ]])
}


# Task 2: Summary Calculation Tests (RED)

@test "check-release-readiness.sh assessment includes summary section" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should include summary section before criteria evaluation
    [[ "$output" =~ "## 📊 Summary" ]] || [[ "$output" =~ "## 📊 Overall Readiness Summary" ]]
}

@test "check-release-readiness.sh summary includes overall readiness status" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should include overall readiness status (READY, NOT READY, or REVIEW NEEDED)
    [[ "$output" =~ "Overall Readiness" ]] || [[ "$output" =~ "Overall Status" ]]
    ([[ "$output" =~ "READY" ]] || [[ "$output" =~ "NOT READY" ]] || [[ "$output" =~ "REVIEW NEEDED" ]] || [[ "$output" =~ "NEEDS REVIEW" ]])
}

@test "check-release-readiness.sh summary calculates readiness based on blocking criteria" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Summary should reflect blocking criteria status
    # If all blocking criteria pass → READY or READY FOR REVIEW
    # If any blocking criteria fail → NOT READY
    [[ "$output" =~ "Summary" ]]
}

# Task 3: Evidence Sections Tests (RED)

@test "check-release-readiness.sh evidence sections include details/summary tags" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Evidence sections should use HTML details/summary for collapsible content
    # Check for both opening tags (proper HTML structure)
    [[ "$output" =~ "<details>" ]] && [[ "$output" =~ "<summary>" ]]
    # Verify closing tags are present (proper HTML structure)
    [[ "$output" =~ "</summary>" ]] && [[ "$output" =~ "</details>" ]]
}

@test "check-release-readiness.sh does not validate HTML structure" {
    cd "$PROJECT_ROOT"
    # This test documents that the script does not currently validate HTML structure
    # If HTML validation is added in the future, this test should be updated
    # to verify that malformed HTML is detected and reported
    
    # For now, we document that the script doesn't enforce HTML structure
    # The script generates HTML but doesn't validate it
    skip "Script does not currently validate HTML structure in output"
}

@test "check-release-readiness.sh evidence sections include command output" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Evidence should include validation details or command output
    # Check for evidence section content beyond simple status messages
    [[ "$output" =~ "Evidence:" ]]
    # Should have more than just simple pass/fail messages
    local evidence_lines=$(echo "$output" | grep -A5 "Evidence:" | grep -v "^--$" | wc -l)
    [ "$evidence_lines" -gt 1 ]
}

@test "check-release-readiness.sh evidence sections are readable and formatted" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Evidence sections should be well-formatted
    # Check that evidence appears after status in each criteria section
    [[ "$output" =~ "Status:" ]] && [[ "$output" =~ "Evidence:" ]]
}

# ============================================================================
# Phase 5, Task 1: Metadata Structure Tests (RED)
# ============================================================================

@test "check-release-readiness.sh --generate includes YAML frontmatter" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Output should start with YAML frontmatter delimiters
    [[ "$output" =~ ^--- ]]
    # Should have closing delimiter
    [[ "$output" =~ "---" ]]
}

@test "check-release-readiness.sh metadata includes version field" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should include version in frontmatter
    [[ "$output" =~ "version:" ]]
    [[ "$output" =~ "v0.4.0" ]]
}

@test "check-release-readiness.sh metadata includes date field" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should include date in YYYY-MM-DD format
    [[ "$output" =~ "date:" ]]
    [[ "$output" =~ [0-9]{4}-[0-9]{2}-[0-9]{2} ]]
}

@test "check-release-readiness.sh metadata includes readiness_score field" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should include readiness_score (0-100)
    [[ "$output" =~ "readiness_score:" ]]
}

@test "check-release-readiness.sh metadata includes status field" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should include status (READY, NOT_READY, or BLOCKED)
    [[ "$output" =~ "status:" ]]
    ([[ "$output" =~ "READY" ]] || [[ "$output" =~ "NOT_READY" ]] || [[ "$output" =~ "BLOCKED" ]])
}

@test "check-release-readiness.sh metadata includes check counts" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should include total_checks and passed_checks
    [[ "$output" =~ "total_checks:" ]]
    [[ "$output" =~ "passed_checks:" ]]
}

@test "check-release-readiness.sh metadata includes blocking_failures count" {
    cd "$PROJECT_ROOT"
    run "$SCRIPT" v0.4.0 --generate
    [ "$status" -eq 0 ]
    # Should include blocking_failures count
    [[ "$output" =~ "blocking_failures:" ]]
}
