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

# Function to validate project name
validate_project_name() {
    local name="$1"
    
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
    
    # Check if directory already exists
    if [ -d "$name" ]; then
        print_error "Directory '$name' already exists"
        return 1
    fi
    
    return 0
}

# Function to copy template
copy_template() {
    local template_type="$1"
    local project_name="$2"
    local template_dir="$DEV_INFRA_DIR/templates/$template_type"
    
    print_status "Copying $template_type template..."
    
    if [ ! -d "$template_dir" ]; then
        print_error "Template directory not found: $template_dir"
        return 1
    fi
    
    # Copy template including hidden files
    cp -r "$template_dir" "$project_name"
    
    # Verify important files were copied
    if [ ! -f "$project_name/.gitignore" ]; then
        print_warning ".gitignore not found - template may need updating"
    fi
    
    print_success "Template copied successfully"
}

# Function to customize project files
customize_project() {
    local project_name="$1"
    local project_type="$2"
    local description="$3"
    local author="$4"
    local current_date=$(date +"%Y-%m-%d")
    
    print_status "Customizing project files..."
    
    # Update README.md
    if [ -f "$project_name/README.md" ]; then
        sed -i.bak "s/\[Project Name\]/$project_name/g" "$project_name/README.md"
        sed -i.bak "s/\[Brief description of what this project does\]/$description/g" "$project_name/README.md"
        sed -i.bak "s/\[Date\]/$current_date/g" "$project_name/README.md"
        rm "$project_name/README.md.bak"
    fi
    
    # Update start.txt
    if [ -f "$project_name/start.txt" ]; then
        cat > "$project_name/start.txt" << EOF
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
    if [ -f "$project_name/package.json" ]; then
        sed -i.bak "s/\"name\": \"[^\"]*\"/\"name\": \"$project_name\"/g" "$project_name/package.json"
        sed -i.bak "s/\"description\": \"[^\"]*\"/\"description\": \"$description\"/g" "$project_name/package.json"
        rm "$project_name/package.json.bak"
    fi
    
    print_success "Project files customized"
}

# Function to initialize git repository
init_git_repo() {
    local project_name="$1"
    
    if prompt_yes_no "Initialize git repository?" "y"; then
        print_status "Initializing git repository..."
        
        cd "$project_name"
        git init
        git add .
        git commit -m "Initial commit: $project_name created from dev-infra template"
        
        print_success "Git repository initialized"
        
        if prompt_yes_no "Create GitHub repository?" "n"; then
            local repo_name=$(prompt_input "GitHub repository name" "$project_name")
            local repo_description=$(prompt_input "Repository description" "$description")
            local is_private=$(prompt_yes_no "Make repository private?" "n")
            
            local gh_args=""
            if [ "$is_private" = true ]; then
                gh_args="--private"
            else
                gh_args="--public"
            fi
            
            print_status "Creating GitHub repository..."
            gh repo create "$repo_name" --description "$repo_description" $gh_args
            
            git remote add origin "https://github.com/$(gh api user --jq .login)/$repo_name.git"
            git branch -M main
            git push -u origin main
            
            print_success "GitHub repository created and pushed"
        fi
        
        cd ..
    fi
}

# Function to show next steps
show_next_steps() {
    local project_name="$1"
    local project_type="$2"
    
    echo
    print_success "Project '$project_name' created successfully!"
    echo
    echo "Next steps:"
    echo "1. cd $project_name"
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
    
    # Get project information
    local project_name=$(prompt_input "Project name")
    while ! validate_project_name "$project_name"; do
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
    echo "Type: $project_type"
    echo "Description: $description"
    echo "Author: $author"
    echo
    
    if ! prompt_yes_no "Create project with these settings?" "y"; then
        print_warning "Project creation cancelled"
        exit 0
    fi
    
    # Create project
    copy_template "$template_type" "$project_name"
    customize_project "$project_name" "$project_type" "$description" "$author"
    init_git_repo "$project_name"
    show_next_steps "$project_name" "$project_type"
}

# Run main function
main "$@"
