#!/usr/bin/env bash

# Validate Template Sync Script
# Validates that shared files are in sync between standard and experimental templates

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

# Default paths (can be overridden by environment variables)
STANDARD_DIR="${STANDARD_DIR:-$PROJECT_ROOT/templates/standard-project}"
EXPERIMENTAL_DIR="${EXPERIMENTAL_DIR:-$PROJECT_ROOT/templates/experimental-project}"
MANIFEST="${MANIFEST:-$PROJECT_ROOT/scripts/template-sync-manifest.txt}"

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

# Check if directories exist
if [[ ! -d "$STANDARD_DIR" ]]; then
    print_error "Standard template directory not found: $STANDARD_DIR"
    exit 1
fi

if [[ ! -d "$EXPERIMENTAL_DIR" ]]; then
    print_error "Experimental template directory not found: $EXPERIMENTAL_DIR"
    exit 1
fi

# Check if manifest exists
if [[ ! -f "$MANIFEST" ]]; then
    print_error "Manifest file not found: $MANIFEST"
    exit 1
fi

# Track drift
DRIFT_DETECTED=false
DRIFT_FILES=()

# Compare two files
compare_file() {
    local file_path="$1"
    local standard_file="$STANDARD_DIR/$file_path"
    local experimental_file="$EXPERIMENTAL_DIR/$file_path"
    
    # Check if both files exist
    if [[ ! -f "$standard_file" ]]; then
        DRIFT_DETECTED=true
        DRIFT_FILES+=("$file_path (missing in standard)")
        return 1
    fi
    
    if [[ ! -f "$experimental_file" ]]; then
        DRIFT_DETECTED=true
        DRIFT_FILES+=("$file_path (missing in experimental)")
        return 1
    fi
    
    # Compare files using diff
    if ! diff -q "$standard_file" "$experimental_file" > /dev/null 2>&1; then
        DRIFT_DETECTED=true
        DRIFT_FILES+=("$file_path")
        return 1
    fi
    
    return 0
}

# Compare directories recursively
compare_directory() {
    local dir_path="$1"
    local standard_dir="$STANDARD_DIR/$dir_path"
    local experimental_dir="$EXPERIMENTAL_DIR/$dir_path"
    
    # Check if both directories exist
    if [[ ! -d "$standard_dir" ]]; then
        DRIFT_DETECTED=true
        DRIFT_FILES+=("$dir_path/ (missing in standard)")
        return 1
    fi
    
    if [[ ! -d "$experimental_dir" ]]; then
        DRIFT_DETECTED=true
        DRIFT_FILES+=("$dir_path/ (missing in experimental)")
        return 1
    fi
    
    # Compare directory contents recursively
    if ! diff -rq "$standard_dir" "$experimental_dir" > /dev/null 2>&1; then
        DRIFT_DETECTED=true
        DRIFT_FILES+=("$dir_path/")
        return 1
    fi
    
    return 0
}

# Main validation
main() {
    print_info "🔍 Validating template sync..."
    echo ""
    
    # Read manifest line by line
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Skip empty lines and comments
        [[ -z "$line" ]] && continue
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        
        # Remove leading/trailing whitespace
        line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        [[ -z "$line" ]] && continue
        
        # Check if it's a directory (ends with /)
        if [[ "$line" =~ /$ ]]; then
            compare_directory "$line"
        else
            compare_file "$line"
        fi
    done < "$MANIFEST"
    
    # Report results
    echo ""
    if [[ "$DRIFT_DETECTED" == true ]]; then
        print_error "DRIFT DETECTED in the following files:"
        echo ""
        for file in "${DRIFT_FILES[@]}"; do
            echo "  - $file"
        done
        echo ""
        print_error "❌ Template sync validation FAILED"
        print_info "Run './scripts/sync-templates.sh' to fix (or manually sync)"
        exit 1
    else
        print_success "Template sync validation PASSED"
        print_info "All shared files are in sync"
        exit 0
    fi
}

# Run main function
main "$@"

