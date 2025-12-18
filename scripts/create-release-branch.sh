#!/bin/bash

# create-release-branch.sh
# Creates a release branch and generates initial RELEASE-READINESS.md assessment
#
# Usage: ./scripts/create-release-branch.sh <version> [options]
# Example: ./scripts/create-release-branch.sh v0.5.0
#
# Options:
#   --dry-run     Show what would be done without making changes
#   --help, -h    Show this help message

set -e

# Script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
}

# Show usage
show_usage() {
    cat << EOF
Usage: $(basename "$0") <version> [options]

Creates a release branch from develop and generates initial RELEASE-READINESS.md assessment.

Arguments:
  version     Version to release (e.g., v0.5.0)

Options:
  --dry-run   Show what would be done without making changes
  --help, -h  Show this help message

Examples:
  $(basename "$0") v0.5.0
  $(basename "$0") v0.5.0 --dry-run

Process:
  1. Validates version format (vX.Y.Z)
  2. Ensures on develop branch and up-to-date
  3. Creates release branch (release/vX.Y.Z)
  4. Creates release directory structure if needed
  5. Generates initial RELEASE-READINESS.md assessment
EOF
}

# Validate version format
validate_version() {
    local version="$1"
    
    # Must start with 'v' followed by semantic version
    if [[ ! "$version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9.-]+)?$ ]]; then
        print_error "Invalid version format: $version"
        echo "Expected format: vX.Y.Z (e.g., v0.5.0) or vX.Y.Z-suffix (e.g., v0.5.0-rc1)"
        return 1
    fi
    
    return 0
}

# Main function
main() {
    local version=""
    local dry_run=false
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help|-h)
                show_usage
                exit 0
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            -*)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
            *)
                if [ -z "$version" ]; then
                    version="$1"
                else
                    print_error "Unexpected argument: $1"
                    show_usage
                    exit 1
                fi
                shift
                ;;
        esac
    done
    
    # Require version argument
    if [ -z "$version" ]; then
        print_error "Version argument required"
        show_usage
        exit 1
    fi
    
    # Validate version format
    if ! validate_version "$version"; then
        exit 1
    fi
    
    local release_branch="release/$version"
    local release_dir="$PROJECT_ROOT/admin/planning/releases/$version"
    local readiness_file="$release_dir/RELEASE-READINESS.md"
    
    echo ""
    echo "=========================================="
    echo "  Create Release Branch: $version"
    echo "=========================================="
    echo ""
    
    if $dry_run; then
        print_warning "DRY RUN MODE - No changes will be made"
        echo ""
    fi
    
    # Step 1: Validate version format
    print_success "Version format valid: $version"
    
    # Step 2: Check current branch
    print_info "Checking current branch..."
    local current_branch
    current_branch=$(git branch --show-current 2>/dev/null || echo "unknown")
    
    if $dry_run; then
        print_info "Would ensure on develop branch (current: $current_branch)"
    else
        if [ "$current_branch" != "develop" ]; then
            print_warning "Not on develop branch (current: $current_branch)"
            print_info "Switching to develop..."
            git checkout develop
            git pull origin develop
        else
            print_success "On develop branch"
        fi
    fi
    
    # Step 3: Check if release branch already exists
    print_info "Checking if release branch exists..."
    if git show-ref --verify --quiet "refs/heads/$release_branch" 2>/dev/null; then
        print_error "Release branch already exists: $release_branch"
        exit 1
    fi
    if git show-ref --verify --quiet "refs/remotes/origin/$release_branch" 2>/dev/null; then
        print_error "Release branch already exists on remote: origin/$release_branch"
        exit 1
    fi
    print_success "Release branch does not exist yet"
    
    # Step 4: Create release branch
    print_info "Creating release branch: $release_branch"
    if $dry_run; then
        print_info "Would create branch: $release_branch"
    else
        git checkout -b "$release_branch"
        print_success "Created branch: $release_branch"
    fi
    
    # Step 5: Create release directory if needed
    print_info "Checking release directory..."
    if [ ! -d "$release_dir" ]; then
        print_info "Creating release directory: $release_dir"
        if $dry_run; then
            print_info "Would create directory: $release_dir"
        else
            mkdir -p "$release_dir"
            print_success "Created directory: $release_dir"
        fi
    else
        print_success "Release directory exists: $release_dir"
    fi
    
    # Step 6: Generate initial RELEASE-READINESS.md
    print_info "Generating initial assessment: RELEASE-READINESS.md"
    if $dry_run; then
        print_info "Would generate: $readiness_file"
        print_info "Using: $SCRIPT_DIR/check-release-readiness.sh $version --generate"
    else
        if [ -f "$SCRIPT_DIR/check-release-readiness.sh" ]; then
            "$SCRIPT_DIR/check-release-readiness.sh" "$version" --generate > "$readiness_file"
            print_success "Generated: $readiness_file"
        else
            print_warning "check-release-readiness.sh not found, creating placeholder"
            cat > "$readiness_file" << EOF
# Release Readiness Assessment: $version

**Version:** $version  
**Date:** $(date +%Y-%m-%d)  
**Status:** 🔴 Not Started

---

## Summary

Release readiness assessment not yet generated. Run:

\`\`\`bash
./scripts/check-release-readiness.sh $version --generate > admin/planning/releases/$version/RELEASE-READINESS.md
\`\`\`

---

**Generated:** $(date)
EOF
            print_success "Created placeholder: $readiness_file"
        fi
    fi
    
    # Summary
    echo ""
    echo "=========================================="
    echo "  Release Branch Created Successfully"
    echo "=========================================="
    echo ""
    if $dry_run; then
        print_info "DRY RUN - Would have done:"
        echo "  1. Created branch: $release_branch"
        echo "  2. Created directory: $release_dir"
        echo "  3. Generated: $readiness_file"
    else
        print_success "Branch: $release_branch"
        print_success "Directory: $release_dir"
        print_success "Assessment: $readiness_file"
    fi
    echo ""
    echo "Next steps:"
    echo "  1. Review RELEASE-READINESS.md for blocking issues"
    echo "  2. Make release-specific changes (CHANGELOG, version, etc.)"
    echo "  3. Run: ./scripts/check-release-readiness.sh $version"
    echo "  4. Create PR when ready: /pr --release $version"
    echo ""
}

# Run main
main "$@"

