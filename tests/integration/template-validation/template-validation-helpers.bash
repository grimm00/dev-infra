#!/bin/bash

# Template Validation Test Helpers
# Shared helper functions for template validation tests

# Generate a test project using non-interactive mode
# Usage: generate_test_project <project-name> <project-type> [target-dir]
# Note: This function sets environment variables and runs the script
# The generated project will be at: $TARGET_DIR/$project_name
# Requires: PROJECT_ROOT (from helpers.bash), TEST_DIR (from setup())
generate_test_project() {
    local project_name="$1"
    local project_type="$2"
    local target_dir="${3:-$TEST_DIR}"
    
    # Ensure PROJECT_ROOT is set (from helpers.bash)
    if [[ -z "$PROJECT_ROOT" ]]; then
        echo "Error: PROJECT_ROOT not set" >&2
        return 1
    fi
    
    # Ensure TEST_DIR is set (from setup())
    if [[ -z "$TEST_DIR" ]]; then
        echo "Error: TEST_DIR not set" >&2
        return 1
    fi
    
    # Set NEW_PROJECT_SCRIPT if not already set
    local script_path="${NEW_PROJECT_SCRIPT:-$PROJECT_ROOT/scripts/new-project.sh}"
    
    # Verify script exists
    if [[ ! -f "$script_path" ]]; then
        echo "Error: Script not found: $script_path" >&2
        return 1
    fi
    
    export PROJECT_NAME="$project_name"
    export PROJECT_TYPE="$project_type"
    export TARGET_DIR="$target_dir"
    export INIT_GIT="false"
    
    # Run the script
    run "$script_path" --non-interactive
    
    # Restore default test variables (for subsequent tests)
    export PROJECT_NAME="test-project"
    export PROJECT_TYPE="standard-project"
    export TARGET_DIR="$TEST_DIR"
    
    # Return status code for test assertions
    # Note: $status is set by bats 'run' command
    return "$status"
}

# Validate that a file exists in a generated project
# Usage: validate_file_exists <project-dir> <file-path>
validate_file_exists() {
    local project_dir="$1"
    local file_path="$2"
    local full_path="$project_dir/$file_path"
    
    if [[ ! -f "$full_path" ]]; then
        echo "File not found: $full_path"
        return 1
    fi
    return 0
}

# Validate that a directory exists in a generated project
# Usage: validate_directory_exists <project-dir> <dir-path>
validate_directory_exists() {
    local project_dir="$1"
    local dir_path="$2"
    local full_path="$project_dir/$dir_path"
    
    if [[ ! -d "$full_path" ]]; then
        echo "Directory not found: $full_path"
        return 1
    fi
    return 0
}

# Validate markdown links in a file
# Usage: validate_markdown_links <file-path> <base-dir>
# Returns: 0 if all links valid, 1 if any broken links found
# Outputs: Error messages for broken links
validate_markdown_links() {
    local file_path="$1"
    local base_dir="$2"
    local file_dir=$(dirname "$file_path")
    local broken_links=0
    
    # Check if file exists
    if [[ ! -f "$file_path" ]]; then
        echo "File not found: $file_path"
        return 1
    fi
    
    # Extract markdown links using grep
    # Pattern: [text](link)
    local links=$(grep -oE '\[([^\]]+)\]\(([^)]+)\)' "$file_path" 2>/dev/null || true)
    
    if [[ -z "$links" ]]; then
        # No links found, which is fine
        return 0
    fi
    
    # Process each link
    while IFS= read -r link; do
        # Extract link target (everything between parentheses)
        local link_target=$(echo "$link" | sed -E 's/.*\(([^)]+)\).*/\1/')
        
        # Skip external links (http/https)
        if [[ "$link_target" =~ ^https?:// ]]; then
            continue
        fi
        
        # Skip anchor links (starting with #)
        if [[ "$link_target" =~ ^# ]]; then
            continue
        fi
        
        # Skip mailto links
        if [[ "$link_target" =~ ^mailto: ]]; then
            continue
        fi
        
        # Resolve relative path
        # Remove leading ./ if present
        link_target="${link_target#./}"
        
        # Build full path relative to file location
        local full_link_path
        if [[ "$link_target" =~ ^/ ]]; then
            # Absolute path from project root
            full_link_path="$base_dir$link_target"
        else
            # Relative path from file location
            full_link_path="$file_dir/$link_target"
        fi
        
        # Normalize path (remove .. and .)
        full_link_path=$(cd "$(dirname "$full_link_path")" 2>/dev/null && pwd)/$(basename "$full_link_path") 2>/dev/null || echo "$full_link_path"
        
        # Check if target exists (file or directory)
        if [[ ! -f "$full_link_path" ]] && [[ ! -d "$full_link_path" ]]; then
            echo "Broken link in $file_path: $link -> $link_target (resolved to: $full_link_path)"
            ((broken_links++))
        fi
    done <<< "$links"
    
    return $broken_links
}

# Validate all markdown links in a project
# Usage: validate_all_markdown_links <project-dir>
# Returns: 0 if all links valid, 1 if any broken links found
validate_all_markdown_links() {
    local project_dir="$1"
    local total_broken=0
    
    # Find all markdown files
    local markdown_files=$(find "$project_dir" -name "*.md" -type f 2>/dev/null || true)
    
    if [[ -z "$markdown_files" ]]; then
        echo "No markdown files found in $project_dir"
        return 1
    fi
    
    # Validate links in each markdown file
    while IFS= read -r md_file; do
        local broken=$(validate_markdown_links "$md_file" "$project_dir" 2>&1 | wc -l)
        if [[ $broken -gt 0 ]]; then
            validate_markdown_links "$md_file" "$project_dir" >&2
            ((total_broken += broken))
        fi
    done <<< "$markdown_files"
    
    return $total_broken
}

