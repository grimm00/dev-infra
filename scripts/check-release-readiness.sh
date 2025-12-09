#!/usr/bin/env bash

# Release Readiness Check Script
# Automates validation of release readiness criteria

set -euo pipefail

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

Examples:
    $(basename "$0") v1.4.0
    $(basename "$0") --verbose v1.4.0
    $(basename "$0") --json v1.4.0

EOF
}

# Parse arguments
VERBOSE=false
JSON_OUTPUT=false
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
        print_status "CI/CD Test Status" false "gh CLI not available (skipping)"
        add_result "CI/CD Test Status" false
        return 1
    fi
    
    # Check if authenticated
    if ! gh auth status &> /dev/null; then
        print_status "CI/CD Test Status" false "gh CLI not authenticated (skipping)"
        add_result "CI/CD Test Status" false
        return 1
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

# Main check function
main() {
    log "Checking release readiness for $VERSION..."
    log "Project root: $PROJECT_ROOT"
    log ""
    
    echo "Release Readiness Check: $VERSION"
    echo "=================================="
    echo ""
    
    echo "Running automated checks..."
    echo ""
    
    # Task 2: Fully Automated Checks
    check_release_branch "$VERSION"
    check_version_consistency "$VERSION"
    check_ci_test_status "$VERSION"
    
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

