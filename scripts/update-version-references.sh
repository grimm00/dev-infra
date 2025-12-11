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

# Extract version number without 'v' prefix (for package.json)
get_version_number() {
    local version=$1
    echo "${version#v}"  # Remove 'v' prefix
}

# Create backup of file
create_backup() {
    local file=$1
    local backup_file="${file}.bak"
    
    if [[ -f "$file" ]]; then
        cp "$file" "$backup_file"
        log "Created backup: $backup_file"
        return 0
    fi
    return 1
}

# Restore backup
restore_backup() {
    local file=$1
    local backup_file="${file}.bak"
    
    if [[ -f "$backup_file" ]]; then
        mv "$backup_file" "$file"
        print_warning "Restored backup: $file"
        return 0
    fi
    return 1
}

# Update version in file
update_file_version() {
    local file=$1
    local old_version=$2
    local new_version=$3
    local file_type=$4
    
    if [[ ! -f "$file" ]]; then
        log "File not found: $file (skipping)"
        return 0  # Not an error - file may not exist
    fi
    
    # Check if file contains old version
    if ! grep -q "$old_version" "$file"; then
        log "File $file does not contain $old_version (skipping)"
        return 0  # Not an error - version may not be in this file
    fi
    
    # Create backup before modification
    if [[ "$DRY_RUN" != "true" ]]; then
        if ! create_backup "$file"; then
            print_error "Failed to create backup for $file"
            return 1
        fi
    fi
    
    # Perform replacement
    if [[ "$DRY_RUN" == "true" ]]; then
        print_info "[DRY RUN] Would update: $file"
        print_info "  Old: $old_version"
        print_info "  New: $new_version"
        
        # Show matching lines
        local matches=$(grep -n "$old_version" "$file" | head -3)
        if [[ -n "$matches" ]]; then
            print_info "  Matches found:"
            echo "$matches" | while IFS= read -r line; do
                print_info "    $line"
            done
        fi
    else
        # Use sed to replace version
        # Handle different file types
        if [[ "$file_type" == "package.json" ]]; then
            # package.json uses version without 'v' prefix: "version": "1.4.0"
            local old_num=$(get_version_number "$old_version")
            local new_num=$(get_version_number "$new_version")
            # Use temporary file for sed (macOS sed doesn't support -i without extension)
            local temp_file=$(mktemp)
            sed "s/\"version\": \"$old_num\"/\"version\": \"$new_num\"/g" "$file" > "$temp_file"
            mv "$temp_file" "$file"
        else
            # Other files use version with 'v' prefix
            # For main.mdc: **Version:** v1.4.0 (released...) - preserve status suffix
            # Use pattern that matches vX.Y.Z but preserves surrounding text
            local temp_file=$(mktemp)
            # Replace v1.4.0 with v1.5.0, preserving everything else on the line
            sed "s|$old_version|$new_version|g" "$file" > "$temp_file"
            mv "$temp_file" "$file"
        fi
        
        # Verify update succeeded
        if grep -q "$old_version" "$file"; then
            print_error "Update failed: $file still contains $old_version"
            restore_backup "$file"
            return 1
        fi
        
        if ! grep -q "$new_version" "$file"; then
            print_error "Update failed: $file doesn't contain $new_version"
            restore_backup "$file"
            return 1
        fi
        
        print_success "Updated: $file"
    fi
    
    return 0
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
    
    local errors=0
    
    # Task 2: Update known version reference locations
    
    # 1. Update .cursor/rules/main.mdc
    # Pattern: **Version:** vX.Y.Z (with optional status suffix like "(released 2025-12-11)")
    if [[ -f "$PROJECT_ROOT/.cursor/rules/main.mdc" ]]; then
        if ! update_file_version "$PROJECT_ROOT/.cursor/rules/main.mdc" "$OLD_VERSION" "$NEW_VERSION" "main.mdc"; then
            ((errors++))
        fi
    else
        log "File not found: .cursor/rules/main.mdc (skipping)"
    fi
    
    # 2. Update README.md (if version badge exists)
    # Pattern: version-vX.Y.Z or v=X.Y.Z (check if exists first)
    if [[ -f "$PROJECT_ROOT/README.md" ]]; then
        if grep -q "version.*$OLD_VERSION\|$OLD_VERSION.*version" "$PROJECT_ROOT/README.md"; then
            if ! update_file_version "$PROJECT_ROOT/README.md" "$OLD_VERSION" "$NEW_VERSION" "README.md"; then
                ((errors++))
            fi
        else
            log "README.md does not contain version badge (skipping)"
        fi
    fi
    
    # 3. Update package.json (if exists)
    # Pattern: "version": "X.Y.Z" (no 'v' prefix)
    if [[ -f "$PROJECT_ROOT/package.json" ]]; then
        if ! update_file_version "$PROJECT_ROOT/package.json" "$OLD_VERSION" "$NEW_VERSION" "package.json"; then
            ((errors++))
        fi
    else
        log "package.json does not exist (skipping)"
    fi
    
    echo
    
    # Report results
    if [[ $errors -gt 0 ]]; then
        print_error "Failed to update $errors file(s)"
        return 1
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

