#!/usr/bin/env bash

# Update Version References Script
# Automates updating version references across the codebase

set -uo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Usage information
usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS] --old-version OLD_VERSION --new-version NEW_VERSION

Update version references across the codebase.

Required Arguments:
    --old-version OLD_VERSION    Old version to replace (e.g., v1.4.0)
    --new-version NEW_VERSION    New version to use (e.g., v1.5.0)

Options:
    -h, --help                   Show this help message
    --dry-run                    Show what would change without modifying files
    -v, --verbose                Verbose output

Examples:
    $(basename "$0") --old-version v1.4.0 --new-version v1.5.0
    $(basename "$0") --dry-run --old-version v1.4.0 --new-version v1.5.0
    $(basename "$0") --verbose --old-version v1.4.0 --new-version v1.5.0

EOF
}

# Print functions
print_error() {
    echo -e "${RED}Error:${NC} $*" >&2
}

print_success() {
    echo -e "${GREEN}✅${NC} $*"
}

print_info() {
    echo -e "${BLUE}ℹ️${NC} $*"
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC} $*"
}

# Parse arguments
DRY_RUN=false
VERBOSE=false
OLD_VERSION=""
NEW_VERSION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        --old-version)
            if [[ -z "${2:-}" ]]; then
                print_error "--old-version requires a value"
                usage
                exit 1
            fi
            OLD_VERSION="$2"
            shift 2
            ;;
        --new-version)
            if [[ -z "${2:-}" ]]; then
                print_error "--new-version requires a value"
                usage
                exit 1
            fi
            NEW_VERSION="$2"
            shift 2
            ;;
        -*)
            print_error "Unknown option: $1"
            usage
            exit 1
            ;;
        *)
            print_error "Unexpected argument: $1"
            usage
            exit 1
            ;;
    esac
done

# Validate required arguments
if [[ -z "$OLD_VERSION" ]]; then
    print_error "--old-version is required"
    usage
    exit 1
fi

if [[ -z "$NEW_VERSION" ]]; then
    print_error "--new-version is required"
    usage
    exit 1
fi

# Validate version formats
# Expected format: vMAJOR.MINOR.PATCH (e.g., v1.4.0)
validate_version_format() {
    local version=$1
    local version_name=$2
    
    if [[ ! "$version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        print_error "Invalid $version_name format: $version (expected vMAJOR.MINOR.PATCH)"
        return 1
    fi
    
    return 0
}

if ! validate_version_format "$OLD_VERSION" "old version"; then
    exit 1
fi

if ! validate_version_format "$NEW_VERSION" "new version"; then
    exit 1
fi

# Log function
log() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo "$@"
    fi
}

# Main execution
main() {
    if [[ "$DRY_RUN" == "true" ]]; then
        print_info "[DRY RUN MODE] No files will be modified"
        echo
    fi
    
    print_info "Updating version references:"
    print_info "  Old version: $OLD_VERSION"
    print_info "  New version: $NEW_VERSION"
    echo
    
    # TODO: Implement file updates in Task 2
    # For now, just validate arguments and show dry-run message
    
    if [[ "$DRY_RUN" == "true" ]]; then
        print_info "[DRY RUN] Would update version references (implementation in Task 2)"
    else
        print_info "Version reference updates will be implemented in Task 2"
    fi
    
    return 0
}

# Run main function
main "$@"
exit_code=$?

if [[ $exit_code -eq 0 ]]; then
    if [[ "$DRY_RUN" == "true" ]]; then
        print_success "Dry-run completed successfully"
    else
        print_success "Version reference update completed successfully"
    fi
else
    print_error "Version reference update failed"
fi

exit $exit_code

