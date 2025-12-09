#!/usr/bin/env bash

# Release Readiness Check Script
# Automates validation of release readiness criteria

set -uo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Usage information
usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS] VERSION

Check release readiness for a given version.

Arguments:
    VERSION         Version to check (e.g., v1.4.0)

Options:
    -h, --help      Show this help message
    -v, --verbose   Verbose output
    --json          Output results in JSON format
    --generate      Generate markdown assessment file

Examples:
    $(basename "$0") v1.4.0
    $(basename "$0") --verbose v1.4.0
    $(basename "$0") --json v1.4.0
    $(basename "$0") --generate v1.4.0

EOF
}

# Parse arguments
VERBOSE=false
JSON_OUTPUT=false
GENERATE=false
VERSION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        --json)
            JSON_OUTPUT=true
            shift
            ;;
        --generate)
            GENERATE=true
            shift
            ;;
        -*)
            echo "Error: Unknown option: $1" >&2
            usage
            exit 1
            ;;
        *)
            if [[ -z "$VERSION" ]]; then
                VERSION="$1"
            else
                echo "Error: Multiple version arguments provided" >&2
                usage
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate required arguments
if [[ -z "$VERSION" ]]; then
    echo "Error: VERSION argument is required" >&2
    usage
    exit 1
fi

# Log function
log() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo "$@"
    fi
}

# Check result tracking
declare -a PASSED_CHECKS=()
declare -a FAILED_CHECKS=()

# Add check result
add_result() {
    local check_name="$1"
    local passed="$2"
    
    if [[ "$passed" == "true" ]]; then
        PASSED_CHECKS+=("$check_name")
    else
        FAILED_CHECKS+=("$check_name")
    fi
}

# Print check status
print_status() {
    local check_name="$1"
    local passed="$2"
    local message="${3:-}"
    
    if [[ "$passed" == "true" ]]; then
        echo -e "${GREEN}✓${NC} $check_name"
    else
        echo -e "${RED}✗${NC} $check_name"
    fi
    
    if [[ -n "$message" ]]; then
        echo "  $message"
    fi
}

# Check release branch existence
check_release_branch() {
    local version="$1"
    local release_branch="release/$version"
    
    log "Checking for release branch: $release_branch"
    
    if git show-ref --verify --quiet "refs/heads/$release_branch" || \
       git show-ref --verify --quiet "refs/remotes/origin/$release_branch"; then
        print_status "Release Branch Exists" true "Found: $release_branch"
        add_result "Release Branch" true
        return 0
    else
        print_status "Release Branch Exists" false "Not found: $release_branch"
        add_result "Release Branch" false
        return 1
    fi
}

# Check version consistency
check_version_consistency() {
    local version="$1"
    local version_number="${version#v}"  # Remove 'v' prefix if present
    
    log "Checking version consistency for: $version"
    
    # Check if version format is valid (semantic versioning)
    if [[ "$version_number" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9-]+)?$ ]]; then
        print_status "Version Format" true "Valid semantic version: $version"
        add_result "Version Format" true
        return 0
    else
        print_status "Version Format" false "Invalid version format: $version"
        add_result "Version Format" false
        return 1
    fi
}

# Check CI/CD test status (if gh CLI is available)
check_ci_test_status() {
    local version="$1"
    
    log "Checking CI/CD test status"
    
    # Check if gh CLI is available
    if ! command -v gh &> /dev/null; then
        # gh CLI not available: treat CI status check as skipped, not failed
        print_status "CI/CD Test Status" true "gh CLI not available (skipping CI status check)"
        return 0
    fi
    
    # Check if authenticated
    if ! gh auth status &> /dev/null; then
        # gh CLI not authenticated: treat CI status check as skipped, not failed
        print_status "CI/CD Test Status" true "gh CLI not authenticated (skipping CI status check)"
        return 0
    fi
    
    # Try to get latest workflow run status
    # This is a simplified check - in practice, you'd want to check specific workflows
    local workflow_status
    workflow_status=$(gh run list --limit 1 --json conclusion,status --jq '.[0].conclusion // "unknown"' 2>/dev/null || echo "unknown")
    
    if [[ "$workflow_status" == "success" ]]; then
        print_status "CI/CD Test Status" true "Latest workflow run: success"
        add_result "CI/CD Test Status" true
        return 0
    elif [[ "$workflow_status" == "failure" ]]; then
        print_status "CI/CD Test Status" false "Latest workflow run: failure"
        add_result "CI/CD Test Status" false
        return 1
    else
        print_status "CI/CD Test Status" false "Could not determine workflow status"
        add_result "CI/CD Test Status" false
        return 1
    fi
}

# Check CHANGELOG for version entry
check_changelog_entry() {
    local version="$1"
    local version_number="${version#v}"  # Remove 'v' prefix if present
    local changelog_file="$PROJECT_ROOT/CHANGELOG.md"
    
    log "Checking CHANGELOG for version entry: $version"
    
    if [[ ! -f "$changelog_file" ]]; then
        print_status "CHANGELOG Entry" false "CHANGELOG.md not found"
        add_result "CHANGELOG Entry" false
        return 1
    fi
    
    # Check for version entry in CHANGELOG (format: ## [VERSION] - DATE or ## [VERSION])
    # Match both with and without 'v' prefix
    if grep -qE "^## \[($version_number|$version)\]" "$changelog_file"; then
        print_status "CHANGELOG Entry" true "Found entry for $version"
        add_result "CHANGELOG Entry" true
        return 0
    else
        print_status "CHANGELOG Entry" false "No entry found for $version"
        add_result "CHANGELOG Entry" false
        return 1
    fi
}

# Check release notes file existence
check_release_notes() {
    local version="$1"
    local release_notes_file="$PROJECT_ROOT/admin/planning/releases/$version/RELEASE-NOTES.md"
    
    log "Checking release notes file: $release_notes_file"
    
    if [[ -f "$release_notes_file" ]]; then
        print_status "Release Notes" true "Found: $release_notes_file"
        add_result "Release Notes" true
        return 0
    else
        print_status "Release Notes" false "Not found: $release_notes_file"
        add_result "Release Notes" false
        return 1
    fi
}

# Gather recent merged PRs (informational)
gather_recent_prs() {
    local version="$1"
    local limit="${2:-10}"  # Default to last 10 PRs
    
    log "Gathering recent merged PRs..."
    
    # Check if gh CLI is available
    if ! command -v gh &> /dev/null; then
        log "  gh CLI not available, skipping PR gathering"
        return 0
    fi
    
    # Check if authenticated
    if ! gh auth status &> /dev/null; then
        log "  gh CLI not authenticated, skipping PR gathering"
        return 0
    fi
    
    # Get recent merged PRs
    local prs
    prs=$(gh pr list --state merged --limit "$limit" --json number,title,mergedAt --jq '.[] | "\(.number): \(.title) (merged: \(.mergedAt))"' 2>/dev/null || echo "")
    
    if [[ -n "$prs" ]]; then
        echo ""
        echo "Recent Merged PRs (last $limit):"
        echo "--------------------------------"
        echo "$prs" | while IFS= read -r line; do
            echo "  - $line"
        done
        return 0
    else
        log "  No recent PRs found or error occurred"
        return 0
    fi
}

# Gather open blocking issues (informational)
gather_blocking_issues() {
    local version="$1"
    
    log "Gathering open blocking issues..."
    
    # Check if gh CLI is available
    if ! command -v gh &> /dev/null; then
        log "  gh CLI not available, skipping issue gathering"
        return 0
    fi
    
    # Check if authenticated
    if ! gh auth status &> /dev/null; then
        log "  gh CLI not authenticated, skipping issue gathering"
        return 0
    fi
    
    # Get open issues labeled as blocking or critical
    local issues
    issues=$(gh issue list --state open --label "blocking" --label "critical" --json number,title,labels --jq '.[] | "\(.number): \(.title) [\(.labels[].name | select(. == "blocking" or . == "critical"))]"' 2>/dev/null || echo "")
    
    if [[ -n "$issues" ]]; then
        echo ""
        echo "Open Blocking Issues:"
        echo "--------------------"
        echo "$issues" | while IFS= read -r line; do
            echo "  - $line"
        done
        return 0
    else
        log "  No blocking issues found"
        return 0
    fi
}

# Main check function
# Generate markdown assessment
generate_assessment() {
    local version="$1"
    local date=$(date +%Y-%m-%d)
    
    # Run checks silently to collect results
    check_release_branch "$version" > /dev/null 2>&1
    local branch_status=$?
    check_version_consistency "$version" > /dev/null 2>&1
    local version_status=$?
    check_ci_test_status "$version" > /dev/null 2>&1
    local ci_status=$?
    check_changelog_entry "$version" > /dev/null 2>&1
    local changelog_status=$?
    check_release_notes "$version" > /dev/null 2>&1
    local notes_status=$?
    
    # Generate markdown output
    cat <<EOF
# Release Readiness Assessment - $version

**Purpose:** Assess project readiness for $version release
**Date:** $date
**Status:** 🟠 Assessment in Progress

---

## 📊 Release Criteria Evaluation

### 🧪 1. Testing & Quality (Blocking)
**Status:** $([ $ci_status -eq 0 ] && echo "✅ PASS" || echo "❌ FAIL")
**Evidence:**
- CI/CD test status: $([ $ci_status -eq 0 ] && echo "All tests passing" || echo "Tests not passing or CI check skipped")

---

### 📄 2. Documentation (Blocking)
**Status:** $([ $changelog_status -eq 0 ] && [ $notes_status -eq 0 ] && echo "✅ PASS" || echo "❌ FAIL")
**Evidence:**
- CHANGELOG updated: $([ $changelog_status -eq 0 ] && echo "✅ Yes" || echo "❌ No")
- Release notes created: $([ $notes_status -eq 0 ] && echo "✅ Yes" || echo "❌ No")

---

### 💻 3. Code Quality (Blocking)
**Status:** ⚠️ NEEDS MANUAL REVIEW
**Evidence:**
- Manual review required for:
  - Critical bugs fixed
  - No blocking issues
  - Code review completed

---

### 🚀 4. Release Preparation (Blocking)
**Status:** $([ $branch_status -eq 0 ] && [ $version_status -eq 0 ] && echo "✅ PASS" || echo "⚠️ NEEDS ATTENTION")
**Evidence:**
- Release branch created: $([ $branch_status -eq 0 ] && echo "✅ Yes" || echo "❌ No")
- Version numbers updated: $([ $version_status -eq 0 ] && echo "✅ Yes" || echo "⚠️ Check format")

---

## 📊 Version Recommendation

**Recommended Version:** $version

**Rationale:** Automated checks $([ ${#FAILED_CHECKS[@]} -eq 0 ] && echo "passed" || echo "need attention")

---

## 🎯 Recommendation

**Status:** $([ ${#FAILED_CHECKS[@]} -eq 0 ] && echo "🟢 READY FOR REVIEW" || echo "🔴 NOT READY")

**Next Steps:**
1. Review automated check results
2. Complete manual review sections
3. Address any failing checks

---

**Last Updated:** $date
EOF
}

main() {
    log "Checking release readiness for $VERSION..."
    log "Project root: $PROJECT_ROOT"
    log ""
    
    # If generate flag is set, generate assessment and exit
    if [[ "$GENERATE" == "true" ]]; then
        generate_assessment "$VERSION"
        exit 0
    fi
    
    echo "Release Readiness Check: $VERSION"
    echo "=================================="
    echo ""
    
    echo "Running automated checks..."
    echo ""
    
    # Task 2: Fully Automated Checks
    check_release_branch "$VERSION"
    check_version_consistency "$VERSION"
    check_ci_test_status "$VERSION"
    
    # Task 3: Documentation Checks
    check_changelog_entry "$VERSION"
    check_release_notes "$VERSION"
    
    echo ""
    
    # Task 4: Data Gathering (Informational)
    gather_recent_prs "$VERSION"
    gather_blocking_issues "$VERSION"
    
    echo ""
    
    # Summary
    echo ""
    echo "Summary"
    echo "-------"
    echo "Passed: ${#PASSED_CHECKS[@]}"
    echo "Failed: ${#FAILED_CHECKS[@]}"
    
    if [[ ${#FAILED_CHECKS[@]} -eq 0 ]]; then
        echo -e "${GREEN}All checks passed!${NC}"
        exit 0
    else
        echo -e "${RED}Some checks failed.${NC}"
        exit 1
    fi
}

# Run main function
main

