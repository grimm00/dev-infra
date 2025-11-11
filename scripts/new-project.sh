#!/bin/bash

# new-project.sh - Interactive project template generator
# Creates new projects from dev-infra templates

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEV_INFRA_DIR="$(dirname "$SCRIPT_DIR")"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to prompt for input
prompt_input() {
    local prompt="$1"
    local default="$2"
    local input
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " input
        echo "${input:-$default}"
    else
        read -p "$prompt: " input
        echo "$input"
    fi
}

# Function to prompt for yes/no
prompt_yes_no() {
    local prompt="$1"
    local default="$2"
    local input
    
    while true; do
        if [ -n "$default" ]; then
            read -p "$prompt [y/N]: " input
            input="${input:-$default}"
        else
            read -p "$prompt: " input
        fi
        
        case $input in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to expand environment variables in path
expand_env_vars() {
    local path="$1"
    
    # Expand common environment variables
    path="${path//\$HOME/$HOME}"
    path="${path//\$USER/$USER}"
    path="${path//\$PWD/$PWD}"
    # Expand ~ to home
    path="${path/#\~/$HOME}"
    # Handle ${VAR} syntax
    path="${path//\$\{HOME\}/$HOME}"
    path="${path//\$\{USER\}/$USER}"
    path="${path//\$\{PWD\}/$PWD}"
    
    echo "$path"
}

# Function to validate target directory
validate_target_directory() {
    local dir_path="$1"
    
    # Check if path is empty
    if [ -z "$dir_path" ]; then
        return 1
    fi
    
    # Expand environment variables first
    dir_path=$(expand_env_vars "$dir_path")
    
    # Check if expansion resulted in empty path
    if [ -z "$dir_path" ]; then
        return 1
    fi
    
    # Resolve to absolute path
    if [[ ! "$dir_path" =~ ^/ ]]; then
        # Relative path - try to resolve
        if [ -d "$dir_path" ]; then
            dir_path="$(cd "$dir_path" 2>/dev/null && pwd)"
        else
            # Path doesn't exist yet, resolve parent
            local parent_dir=$(dirname "$dir_path")
            if [ -d "$parent_dir" ]; then
                dir_path="$(cd "$parent_dir" && pwd)/$(basename "$dir_path")"
            else
                # Parent doesn't exist - build absolute path from current directory
                dir_path="$(pwd)/$dir_path"
            fi
        fi
    else
        # Absolute path - normalize if parent exists, otherwise keep as-is
        local parent_dir=$(dirname "$dir_path")
        local dir_name=$(basename "$dir_path")
        if [ -d "$parent_dir" ]; then
            dir_path="$(cd "$parent_dir" && pwd)/$dir_name"
        else
            # Parent doesn't exist - keep path as-is for now (will be created)
            dir_path="$dir_path"
        fi
    fi
    
    # Normalize path (remove trailing slashes)
    dir_path="${dir_path%/}"
    
    # Check if directory exists
    if [ -d "$dir_path" ]; then
        # Check if directory is writable
        if [ ! -w "$dir_path" ]; then
            echo "$dir_path"
            return 2  # Directory not writable
        fi
        echo "$dir_path"
        return 0
    else
        # Directory doesn't exist - check if parent is writable
        local parent_dir=$(dirname "$dir_path")
        if [ ! -d "$parent_dir" ]; then
            # Parent doesn't exist - return path anyway so caller can try to create full path
            echo "$dir_path"
            return 1  # Parent doesn't exist, but return path for creation attempt
        fi
        if [ ! -w "$parent_dir" ]; then
            echo "$dir_path"
            return 2  # Parent directory not writable
        fi
        # Return path for potential creation
        echo "$dir_path"
        return 3  # Special code: doesn't exist but can be created
    fi
}

# Function to validate project name
validate_project_name() {
    local name="$1"
    local target_dir="$2"
    
    # Check if name is empty
    if [ -z "$name" ]; then
        print_error "Project name cannot be empty"
        return 1
    fi
    
    # Check if name contains only valid characters
    if [[ ! "$name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        print_error "Project name can only contain letters, numbers, hyphens, and underscores"
        return 1
    fi
    
    # Build full project path
    local full_path="$target_dir/$name"
    
    # Check if directory already exists in target location
    if [ -d "$full_path" ]; then
        print_error "Directory '$full_path' already exists"
        return 1
    fi
    
    echo "$full_path"
    return 0
}

# Function to copy template
copy_template() {
    local template_type="$1"
    local full_project_path="$2"
    local template_dir="$DEV_INFRA_DIR/templates/$template_type"
    
    print_status "Copying $template_type template..."
    
    if [ ! -d "$template_dir" ]; then
        print_error "Template directory not found: $template_dir"
        return 1
    fi
    
    # Copy template including hidden files
    cp -r "$template_dir" "$full_project_path"
    
    # Verify important files were copied
    if [ ! -f "$full_project_path/.gitignore" ]; then
        print_warning ".gitignore not found - template may need updating"
    fi
    
    print_success "Template copied successfully"
}

# Function to customize project files
customize_project() {
    local full_project_path="$1"
    local project_type="$2"
    local description="$3"
    local author="$4"
    local current_date=$(date +"%Y-%m-%d")
    
    # Extract project name from path
    local project_name=$(basename "$full_project_path")
    
    print_status "Customizing project files..."
    
    # Update README.md
    if [ -f "$full_project_path/README.md" ]; then
        sed -i.bak "s/\[Project Name\]/$project_name/g" "$full_project_path/README.md"
        sed -i.bak "s/\[Brief description of what this project does\]/$description/g" "$full_project_path/README.md"
        sed -i.bak "s/\[Date\]/$current_date/g" "$full_project_path/README.md"
        rm "$full_project_path/README.md.bak"
    fi
    
    # Update start.txt
    if [ -f "$full_project_path/start.txt" ]; then
        cat > "$full_project_path/start.txt" << EOF
# Project Initialization Template

## Problem Statement
$description

## Project Type
- [x] $project_type

## Scope
[Define the scope and boundaries of this project]

## Project Structure Preferences
- [x] Use hub-and-spoke documentation pattern
- [x] Include admin/ directory for project management
- [x] Feature-based planning under admin/planning/features/
- [x] Include fix/ directories under features for troubleshooting
- [x] Add research/ directory for decision-making

## Version Control
- [x] Use Git Flow (main/develop/feature branches)
- [x] Use GitHub CLI for repo management
- [x] Granular CI workflows based on branch types
- [x] PR-based code changes (minimal diffs for rate limiting)

## Tool Integrations
- [ ] Sourcery AI for code review
- [ ] Bugbot for bug detection
- [ ] Dev-toolkit integration (cd ~/Projects/dev-toolkit)
- [x] Cursor IDE with AI rules (.cursor/rules/main.mdc)

## CI/CD Preferences
- [x] Doc-heavy/chore branches can push directly to develop/main
- [x] Code changes require PRs
- [x] Automated testing on feature branches
- [x] External reviews on release branches

## Additional Notes
Created by: $author
Created on: $current_date
Template: $project_type

---
*This template can be customized for each new project. Remove unused sections and add project-specific details.*
EOF
    fi
    
    # Update package.json if it exists
    if [ -f "$full_project_path/package.json" ]; then
        sed -i.bak "s/\"name\": \"[^\"]*\"/\"name\": \"$project_name\"/g" "$full_project_path/package.json"
        sed -i.bak "s/\"description\": \"[^\"]*\"/\"description\": \"$description\"/g" "$full_project_path/package.json"
        rm "$full_project_path/package.json.bak"
    fi
    
    print_success "Project files customized"
}

# Function to initialize git repository
init_git_repo() {
    local full_project_path="$1"
    local project_name=$(basename "$full_project_path")
    local original_dir=$(pwd)
    
    if prompt_yes_no "Initialize git repository?" "y"; then
        print_status "Initializing git repository..."
        
        cd "$full_project_path"
        git init
        git add .
        git commit -m "Initial commit: $project_name created from dev-infra template"
        
        print_success "Git repository initialized"
        
        if prompt_yes_no "Create GitHub repository?" "n"; then
            local repo_name=$(prompt_input "GitHub repository name" "$project_name")
            local repo_description=$(prompt_input "Repository description" "")
            local is_private
            if prompt_yes_no "Make repository private?" "n"; then
                is_private="--private"
            else
                is_private="--public"
            fi
            
            print_status "Creating GitHub repository..."
            gh repo create "$repo_name" --description "$repo_description" $is_private
            
            git remote add origin "https://github.com/$(gh api user --jq .login)/$repo_name.git"
            git branch -M main
            git push -u origin main
            
            print_success "GitHub repository created and pushed"
        fi
        
        cd "$original_dir"
    fi
}

# Function to show next steps
show_next_steps() {
    local full_project_path="$1"
    local project_type="$2"
    local project_name=$(basename "$full_project_path")
    
    echo
    print_success "Project '$project_name' created successfully!"
    echo
    echo "Next steps:"
    echo "1. cd $full_project_path"
    echo "2. Review and customize start.txt"
    echo "3. Update README.md with project-specific details"
    echo "4. Set up development environment"
    echo "5. Start development!"
    echo
    echo "For $project_type projects:"
    if [ "$project_type" = "Learning Project" ]; then
        echo "- Start with stage0-fundamentals/README.md"
        echo "- Follow the learning path in order"
        echo "- Complete exercises as you go"
    else
        echo "- Review admin/planning/README.md for project management"
        echo "- Set up your first feature in admin/planning/features/"
        echo "- Configure CI/CD workflows"
    fi
    echo
    echo "Happy coding! 🚀"
}

# Main function
main() {
    echo "🚀 Dev-Infra Project Template Generator"
    echo "======================================"
    echo
    
    # Determine default directory
    local DEFAULT_DIR="$HOME/Projects"
    if [ ! -d "$DEFAULT_DIR" ]; then
        if prompt_yes_no "Directory $DEFAULT_DIR doesn't exist. Create it?" "n"; then
            mkdir -p "$DEFAULT_DIR"
            print_success "Created directory: $DEFAULT_DIR"
        else
            DEFAULT_DIR="$PWD"
            print_status "Using current directory as default"
        fi
    fi
    
    # Get target directory first
    echo
    local target_dir=$(prompt_input "Target directory (press Enter for $DEFAULT_DIR or enter custom path)" "$DEFAULT_DIR")
    
    # Validate and resolve target directory
    local TARGET_DIR
    local resolved_dir
    resolved_dir=$(validate_target_directory "$target_dir" 2>/dev/null)
    local error_code=$?
    
    # Check if we got a valid path back
    if [ -z "$resolved_dir" ] && [ $error_code -ne 0 ]; then
        print_error "Failed to validate directory: $target_dir"
        print_error "The path may be invalid or inaccessible"
        print_error "Please check the path and try again"
        exit 1
    fi
    
    case $error_code in
        0)
            # Directory exists and is writable
            if [ -z "$resolved_dir" ]; then
                print_error "Validation returned empty path"
                exit 1
            fi
            TARGET_DIR="$resolved_dir"
            print_status "Using directory: $TARGET_DIR"
            ;;
        3)
            # Directory doesn't exist but parent exists and is writable - can be created
            if [ -z "$resolved_dir" ]; then
                print_error "Cannot determine directory path for: $target_dir"
                exit 1
            fi
            if prompt_yes_no "Directory '$resolved_dir' doesn't exist. Create it?" "n"; then
                if mkdir -p "$resolved_dir" 2>/dev/null; then
                    TARGET_DIR="$(cd "$resolved_dir" && pwd)"
                    print_success "Created directory: $TARGET_DIR"
                else
                    print_error "Failed to create directory: $resolved_dir"
                    exit 1
                fi
            else
                print_error "Cannot proceed without valid directory"
                exit 1
            fi
            ;;
        1)
            # Directory doesn't exist and parent doesn't exist or invalid
            # Try to create the full path
            if [ -z "$resolved_dir" ]; then
                print_error "Cannot determine directory path for: $target_dir"
                exit 1
            fi
            if prompt_yes_no "Directory '$resolved_dir' doesn't exist. Create it (including parent directories)?" "n"; then
                if mkdir -p "$resolved_dir" 2>/dev/null; then
                    if [ -d "$resolved_dir" ]; then
                        TARGET_DIR="$(cd "$resolved_dir" && pwd)"
                        print_success "Created directory: $TARGET_DIR"
                    else
                        print_error "Failed to create directory: $resolved_dir"
                        exit 1
                    fi
                else
                    print_error "Failed to create directory: $resolved_dir"
                    print_error "Please check permissions and try again"
                    exit 1
                fi
            else
                print_error "Cannot proceed without valid directory"
                exit 1
            fi
            ;;
        2)
            # Directory not writable
            if [ -z "$resolved_dir" ]; then
                print_error "Directory '$target_dir' is not writable"
            else
                print_error "Directory '$resolved_dir' is not writable"
            fi
            print_error "Please check permissions or choose a different directory"
            exit 1
            ;;
        *)
            print_error "Invalid directory: $target_dir"
            if [ -n "$resolved_dir" ]; then
                print_error "Resolved path: $resolved_dir"
            fi
            print_error "Error code: $error_code"
            exit 1
            ;;
    esac
    
    # Get project information
    echo
    local project_name=$(prompt_input "Project name")
    local full_project_path
    while ! full_project_path=$(validate_project_name "$project_name" "$TARGET_DIR"); do
        project_name=$(prompt_input "Project name")
    done
    
    local description=$(prompt_input "Project description")
    local author=$(prompt_input "Author name" "$(git config user.name 2>/dev/null || echo '')")
    
    # Select project type
    echo
    echo "Select project type:"
    echo "1) Regular Project (application, tool, service)"
    echo "2) Learning Project (tutorial, exercises, reference)"
    echo
    
    local project_type_choice
    while true; do
        read -p "Enter choice [1-2]: " project_type_choice
        case $project_type_choice in
            1)
                project_type="Regular Project"
                template_type="regular-project"
                break
                ;;
            2)
                project_type="Learning Project"
                template_type="learning-project"
                break
                ;;
            *)
                echo "Please enter 1 or 2"
                ;;
        esac
    done
    
    # Confirm project creation
    echo
    echo "Project Summary:"
    echo "Name: $project_name"
    echo "Location: $full_project_path"
    echo "Type: $project_type"
    echo "Description: $description"
    echo "Author: $author"
    echo
    
    if ! prompt_yes_no "Create project with these settings?" "y"; then
        print_warning "Project creation cancelled"
        exit 0
    fi
    
    # Create project
    copy_template "$template_type" "$full_project_path"
    customize_project "$full_project_path" "$project_type" "$description" "$author"
    init_git_repo "$full_project_path"
    show_next_steps "$full_project_path" "$project_type"
}

# Run main function
main "$@"
