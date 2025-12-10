#!/usr/bin/env bash

# analyze-releases.sh
# Analyzes historical release readiness assessments and reports metrics
#
# Usage: ./scripts/analyze-releases.sh [options]
# Example: ./scripts/analyze-releases.sh
# Example: ./scripts/analyze-releases.sh --json --last 5

set -euo pipefail

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
    if [ "$VERBOSE" = "true" ]; then
        echo -e "${BLUE}ℹ️  $1${NC}" >&2
    fi
}

print_error() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
}

# Show usage
show_usage() {
    cat << EOF
Usage: $(basename "$0") [options]

Analyzes historical release readiness assessments and reports metrics.

Options:
  --dir DIR          Directory containing assessment files (default: auto-discover)
  --last N           Show only last N releases (default: all)
  --json             Output results in JSON format
  --verbose, -v      Verbose output
  --help, -h         Show this help message

Examples:
  $(basename "$0")
  $(basename "$0") --json
  $(basename "$0") --last 5
  $(basename "$0") --dir tests/fixtures/release-assessments
  $(basename "$0") --json --last 3 --verbose

Default behavior:
  - Discovers assessment files from: admin/planning/releases/*/RELEASE-READINESS.md
  - Parses YAML frontmatter metadata
  - Outputs text table with metrics
EOF
}

# Parse arguments
VERBOSE=false
JSON_OUTPUT=false
LAST_N=""
ASSESSMENT_DIR=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
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
        --last)
            LAST_N="$2"
            shift 2
            ;;
        --dir)
            ASSESSMENT_DIR="$2"
            shift 2
            ;;
        -*)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
        *)
            print_error "Unexpected argument: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Discover assessment files
discover_assessments() {
    local search_dir=""
    local files=()
    
    if [ -n "$ASSESSMENT_DIR" ]; then
        # Use provided directory
        search_dir="$ASSESSMENT_DIR"
        print_info "Using provided directory: $search_dir" >&2
    else
        # Auto-discover from admin/planning/releases
        search_dir="$PROJECT_ROOT/admin/planning/releases"
        print_info "Auto-discovering assessments from: $search_dir" >&2
    fi
    
    if [ ! -d "$search_dir" ]; then
        print_error "Directory not found: $search_dir" >&2
        return 1
    fi
    
    # Find RELEASE-READINESS.md files
    if [ -n "$ASSESSMENT_DIR" ]; then
        # For fixtures, look for any .md files
        while IFS= read -r -d '' file; do
            files+=("$file")
        done < <(find "$search_dir" -maxdepth 1 -name "*.md" -type f -print0 2>/dev/null | sort -rz)
    else
        # For real assessments, look in version subdirectories
        while IFS= read -r -d '' file; do
            files+=("$file")
        done < <(find "$search_dir" -name "RELEASE-READINESS.md" -type f -print0 2>/dev/null | sort -rz)
    fi
    
    # Limit to last N if specified
    if [ -n "$LAST_N" ] && [ "$LAST_N" -gt 0 ] && [ "$LAST_N" -gt 0 ]; then
        files=("${files[@]:0:$LAST_N}")
        print_info "Limited to last $LAST_N releases" >&2
    fi
    
    # Output files to stdout (info messages already went to stderr)
    printf '%s\n' "${files[@]}"
}

# Parse YAML frontmatter from file
parse_frontmatter() {
    local file="$1"
    
    if [ ! -f "$file" ]; then
        return 1
    fi
    
    # Check if file starts with --- (YAML frontmatter)
    if ! head -n 1 "$file" | grep -q "^---$"; then
        # No frontmatter, return empty
        return 0
    fi
    
    # Extract frontmatter section (between --- and ---)
    local in_frontmatter=false
    local frontmatter=""
    
    while IFS= read -r line; do
        if [[ "$line" =~ ^---$ ]]; then
            if [ "$in_frontmatter" = false ]; then
                in_frontmatter=true
            else
                break
            fi
        elif [ "$in_frontmatter" = true ]; then
            frontmatter+="$line"$'\n'
        fi
    done < "$file"
    
    # Parse key-value pairs
    local version=""
    local date=""
    local readiness_score=""
    local blocking_failures=""
    local total_checks=""
    local passed_checks=""
    local warnings=""
    local status=""
    
    while IFS= read -r line; do
        if [[ "$line" =~ ^([^:]+):[[:space:]]*(.+)$ ]]; then
            local key="${BASH_REMATCH[1]}"
            local value="${BASH_REMATCH[2]}"
            
            case "$key" in
                version)
                    version="$value"
                    ;;
                date)
                    date="$value"
                    ;;
                readiness_score)
                    readiness_score="$value"
                    ;;
                blocking_failures)
                    blocking_failures="$value"
                    ;;
                total_checks)
                    total_checks="$value"
                    ;;
                passed_checks)
                    passed_checks="$value"
                    ;;
                warnings)
                    warnings="$value"
                    ;;
                status)
                    status="$value"
                    ;;
            esac
        fi
    done <<< "$frontmatter"
    
    # Output as tab-separated values for easy parsing
    echo -e "${version}\t${date}\t${readiness_score}\t${blocking_failures}\t${total_checks}\t${passed_checks}\t${warnings}\t${status}"
}

# Calculate metrics from parsed data
calculate_metrics() {
    local data=("$@")
    local total_score=0
    local count=0
    
    for line in "${data[@]}"; do
        if [ -z "$line" ]; then
            continue
        fi
        
        IFS=$'\t' read -r version date score failures total pass warn status <<< "$line"
        
        if [ -z "$version" ] || [ -z "$score" ]; then
            continue
        fi
        
        total_score=$((total_score + score))
        count=$((count + 1))
    done
    
    if [ $count -eq 0 ]; then
        echo "0"
        return
    fi
    
    # Calculate average (integer division)
    local avg=$((total_score / count))
    echo "$avg"
}

# Format output as text table
format_text_table() {
    local data=("$@")
    
    echo ""
    echo "=========================================="
    echo "  Release Readiness Analysis"
    echo "=========================================="
    echo ""
    printf "%-12s %-12s %-6s %-4s %-6s %-6s %-4s %-10s\n" "Version" "Date" "Score" "Fail" "Total" "Pass" "Warn" "Status"
    echo "------------------------------------------"
    
    for line in "${data[@]}"; do
        if [ -z "$line" ]; then
            continue
        fi
        
        IFS=$'\t' read -r version date score failures total pass warn status <<< "$line"
        
        if [ -z "$version" ]; then
            continue
        fi
        
        printf "%-12s %-12s %-6s %-4s %-6s %-6s %-4s %-10s\n" \
            "$version" "$date" "$score" "$failures" "$total" "$pass" "$warn" "$status"
    done
    
    echo ""
    
    # Add metrics section
    local avg_score
    avg_score=$(calculate_metrics "${data[@]}")
    local count=${#data[@]}
    
    # Calculate trend (comparing two most recent releases)
    # Data is sorted newest first, so compare data[0] (newest) to data[1] (previous)
    local trend=""
    if [ $count -ge 2 ]; then
        local newest_score
        local previous_score
        newest_score=$(echo "${data[0]}" | cut -f3)
        previous_score=$(echo "${data[1]}" | cut -f3)
        
        if [ -n "$newest_score" ] && [ -n "$previous_score" ]; then
            local diff=$((newest_score - previous_score))
            if [ $diff -gt 0 ]; then
                trend="📈 Improving (+$diff)"
            elif [ $diff -lt 0 ]; then
                trend="📉 Declining ($diff)"
            else
                trend="➡️  Stable (no change)"
            fi
        fi
    fi
    
    echo "=========================================="
    echo "  Summary Metrics"
    echo "=========================================="
    echo ""
    printf "%-25s %s\n" "Total Releases Analyzed:" "$count"
    printf "%-25s %s\n" "Average Readiness Score:" "$avg_score"
    if [ -n "$trend" ]; then
        printf "%-25s %s\n" "Trend:" "$trend"
    fi
    echo ""
}

# Format output as JSON
format_json() {
    local data=("$@")
    
    echo "{"
    echo "  \"releases\": ["
    
    local first=true
    for line in "${data[@]}"; do
        if [ -z "$line" ]; then
            continue
        fi
        
        IFS=$'\t' read -r version date score failures total pass warn status <<< "$line"
        
        if [ -z "$version" ]; then
            continue
        fi
        
        if [ "$first" = true ]; then
            first=false
        else
            echo ","
        fi
        
        echo "    {"
        echo "      \"version\": \"$version\","
        echo "      \"date\": \"$date\","
        echo "      \"readiness_score\": $score,"
        echo "      \"blocking_failures\": $failures,"
        echo "      \"total_checks\": $total,"
        echo "      \"passed_checks\": $pass,"
        echo "      \"warnings\": $warn,"
        echo "      \"status\": \"$status\""
        echo -n "    }"
    done
    
    echo ""
    echo "  ],"
    
    # Add metrics section
    local avg_score
    avg_score=$(calculate_metrics "${data[@]}")
    local count=${#data[@]}
    
    echo "  \"metrics\": {"
    echo "    \"total_releases\": $count,"
    echo "    \"average_readiness_score\": $avg_score"
    echo "  }"
    echo "}"
}

# Main function
main() {
    print_info "Starting release readiness analysis..."
    
    # Discover assessment files (info messages go to stderr, files to stdout)
    local assessment_files
    # Redirect stderr to /dev/null for info messages, capture stdout for files
    assessment_files=$(discover_assessments 2>/dev/null)
    
    if [ -z "$assessment_files" ]; then
        print_error "No assessment files found"
        exit 1
    fi
    
    # Parse each file
    local parsed_data=()
    local file_count=0
    
    while IFS= read -r file; do
        if [ -z "$file" ]; then
            continue
        fi
        
        print_info "Parsing: $file"
        
        local parsed
        parsed=$(parse_frontmatter "$file" || true)
        
        # Check if parsed data has version (first field)
        local version_field
        version_field=$(echo "$parsed" | cut -f1)
        
        if [ -n "$parsed" ] && [ -n "$version_field" ]; then
            parsed_data+=("$parsed")
            file_count=$((file_count + 1))
        else
            print_info "Skipping file without metadata: $file"
        fi
    done <<< "$assessment_files"
    
    if [ $file_count -eq 0 ]; then
        print_error "No valid assessment files with metadata found"
        exit 1
    fi
    
    print_info "Parsed $file_count assessment file(s)"
    
    # Format output
    if [ "$JSON_OUTPUT" = "true" ]; then
        format_json "${parsed_data[@]}"
    else
        format_text_table "${parsed_data[@]}"
    fi
}

# Run main
main "$@"

