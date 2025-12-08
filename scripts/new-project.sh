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
    
    # Check if we're in a non-interactive environment (CI, automated tests, etc.)
    # Check GITHUB_ACTIONS first (GitHub Actions specific)
    # Then check CI (generic CI systems)
    # Then check NON_INTERACTIVE (explicit flag)
    # Then check terminal (fallback)
    # Finally check BATS environment
    if [ -n "$GITHUB_ACTIONS" ] || [ -n "$CI" ] || [ -n "$NON_INTERACTIVE" ] || [ ! -t 0 ] || [ -n "$BATS_RUN_TMPDIR" ]; then
        # Non-interactive: return default value
        case "${default:-n}" in
            [Yy]* ) return 0;;
            * ) return 1;;
        esac
    fi
    
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
            local resolved
            resolved="$(cd "$dir_path" 2>/dev/null && pwd 2>/dev/null)"
            if [ $? -eq 0 ] && [ -n "$resolved" ]; then
                dir_path="$resolved"
            fi
        else
            # Path doesn't exist yet, resolve parent
            local parent_dir=$(dirname "$dir_path")
            if [ -d "$parent_dir" ]; then
                local normalized_parent
                normalized_parent="$(cd "$parent_dir" 2>/dev/null && pwd 2>/dev/null)"
                if [ $? -eq 0 ] && [ -n "$normalized_parent" ]; then
                    dir_path="$normalized_parent/$(basename "$dir_path")"
                fi
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
            # Normalize parent path (resolve symlinks, etc.)
            local normalized_parent
            normalized_parent="$(cd "$parent_dir" 2>/dev/null && pwd 2>/dev/null)"
            if [ $? -eq 0 ] && [ -n "$normalized_parent" ]; then
                dir_path="$normalized_parent/$dir_name"
            fi
        fi
    fi
    
    # Normalize path (remove all trailing slashes, but keep '/' if root)
    while [[ "$dir_path" =~ /$ ]] && [[ "$dir_path" != "/" ]]; do
        dir_path="${dir_path%/}"
    done
    
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
    
    # Check if name contains any whitespace
    if [[ "$name" =~ [[:space:]] ]]; then
        print_error "Project name cannot contain whitespace"
        print_warning "Whitespace characters (spaces, tabs, newlines) are not allowed in project names for compatibility with file systems and URLs"
        
        # In non-interactive mode, fail immediately
        if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
            local sanitized_name
            sanitized_name="${name//[[:space:]]/-}"
            print_error "Sanitized name would be: $sanitized_name"
            return 1
        fi
        
        # Offer to replace all whitespace (spaces, tabs, newlines) with dashes
        # Use bash parameter expansion for cross-platform compatibility (no sed dependency)
        local sanitized_name
        sanitized_name="${name//[[:space:]]/-}"
        if prompt_yes_no "Would you like to use '$sanitized_name' instead?" "y"; then
            name="$sanitized_name"
            print_status "Using sanitized name: $name"
        else
            return 1
        fi
    fi
    
    # Check if name contains only valid characters
    if [[ ! "$name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        print_error "Project name can only contain letters, numbers, hyphens, and underscores"
        print_error "Invalid characters found in: $name"
        return 1
    fi
    
    # Build full project path (normalize to prevent double slashes)
    target_dir="${target_dir%/}"
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
        # Use portable sed -i syntax (works on both GNU and BSD/macOS)
        # On macOS/BSD: sed -i '' requires empty string for no backup
        # On GNU: sed -i works without extension
        if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
            sed -i '' "s/\[Project Name\]/$project_name/g" "$full_project_path/README.md"
            sed -i '' "s/\[Brief description of what this project does\]/$description/g" "$full_project_path/README.md"
            sed -i '' "s/\[Date\]/$current_date/g" "$full_project_path/README.md"
        else
            sed -i "s/\[Project Name\]/$project_name/g" "$full_project_path/README.md"
            sed -i "s/\[Brief description of what this project does\]/$description/g" "$full_project_path/README.md"
            sed -i "s/\[Date\]/$current_date/g" "$full_project_path/README.md"
        fi
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
        # Use portable sed -i syntax (works on both GNU and BSD/macOS)
        if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
            sed -i '' "s/\"name\": \"[^\"]*\"/\"name\": \"$project_name\"/g" "$full_project_path/package.json"
            sed -i '' "s/\"description\": \"[^\"]*\"/\"description\": \"$description\"/g" "$full_project_path/package.json"
        else
            sed -i "s/\"name\": \"[^\"]*\"/\"name\": \"$project_name\"/g" "$full_project_path/package.json"
            sed -i "s/\"description\": \"[^\"]*\"/\"description\": \"$description\"/g" "$full_project_path/package.json"
        fi
    fi
    
    print_success "Project files customized"
}

# Function to verify GitHub authentication
verify_github_auth() {
    local expected_author="$1"
    
    # Check if gh is installed
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) is not installed"
        print_error "Please install it from https://cli.github.com/"
        echo
        print_error "Alternatively, you can manually create a repository on GitHub:"
        echo "1. Go to https://github.com/new"
        echo "2. Fill in the repository name and details."
        echo "3. Click 'Create repository'."
        echo "4. Initialize your local git repository and add the remote:"
        echo "   git init"
        echo "   git remote add origin https://github.com/<your-username>/<repo-name>.git"
        echo "5. Add, commit, and push your code:"
        echo "   git add ."
        echo "   git commit -m 'Initial commit'"
        echo "   git push -u origin main"
        print_error "If you need to authenticate, follow instructions at https://docs.github.com/en/get-started/getting-started-with-git/set-up-git"
        return 1
    fi
    
    # Check if user is authenticated
    if ! gh auth status &>/dev/null; then
        print_error "Not authenticated with GitHub CLI."
        print_error "Troubleshooting steps:"
        print_error "1. Run: gh auth login"
        print_error "2. If you are still unable to authenticate, your token may have expired or your CLI may be misconfigured."
        print_error "   - Try: gh auth refresh"
        print_error "   - Or re-run: gh auth login --with-token"
        print_error "3. For more help, see: https://cli.github.com/manual/gh_auth_login"
        return 1
    fi
    
    # Get current authenticated user
    local current_user
    current_user=$(gh api user --jq .login 2>/dev/null)
    
    if [ -z "$current_user" ]; then
        print_error "Failed to get current GitHub user"
        return 1
    fi
    
    # If author name provided, try to match (case-insensitive)
    if [ -n "$expected_author" ]; then
        local author_lower=$(echo "$expected_author" | tr '[:upper:]' '[:lower:]')
        local user_lower=$(echo "$current_user" | tr '[:upper:]' '[:lower:]')
        
        if [ "$author_lower" != "$user_lower" ]; then
            print_warning "Author name '$expected_author' doesn't match authenticated GitHub user '$current_user'"
            if ! prompt_yes_no "Continue with GitHub user '$current_user'?" "y"; then
                print_error "Repository creation cancelled"
                return 1
            fi
        else
            print_status "GitHub user '$current_user' matches author name"
        fi
    fi
    
    # Show authenticated user info using gh's built-in --jq flag (no jq dependency)
    local github_login
    github_login=$(gh api user --jq '.login // "unknown"' 2>/dev/null)
    if [ -n "$github_login" ] && [ "$github_login" != "unknown" ]; then
        print_status "Authenticated as: $github_login"
    fi
    
    return 0
}

# Function to initialize git repository
init_git_repo() {
    local full_project_path="$1"
    local author="$2"
    local project_name=$(basename "$full_project_path")
    local original_dir=$(pwd)
    local should_init_git
    
    # Check if we should initialize git
    if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
        should_init_git="$INIT_GIT"
    else
        if prompt_yes_no "Initialize git repository?" "y"; then
            should_init_git="true"
        else
            should_init_git="false"
        fi
    fi
    
    if [ "$should_init_git" = "true" ]; then
        print_status "Initializing git repository..."
        
        # Change to project directory with error checking
        if ! cd "$full_project_path"; then
            print_error "Failed to change to project directory: $full_project_path"
            return 1
        fi
        
        git init
        git add .
        git commit -m "Initial commit: $project_name created from dev-infra template"
        
        print_success "Git repository initialized"
        
        # Skip GitHub repository creation in non-interactive mode
        if [ "$NON_INTERACTIVE_MODE" != "true" ]; then
            if prompt_yes_no "Create GitHub repository?" "n"; then
                # Verify GitHub authentication before proceeding
                if ! verify_github_auth "$author"; then
                    print_error "GitHub authentication verification failed"
                    print_error "Skipping repository creation"
                    # Return to original directory (best effort)
                    cd "$original_dir" 2>/dev/null || true
                    return 1
                fi
                
                local repo_name=$(prompt_input "GitHub repository name" "$project_name")
                local repo_description=$(prompt_input "Repository description" "")
                local is_private
                if prompt_yes_no "Make repository private?" "n"; then
                    is_private="--private"
                else
                    is_private="--public"
                fi
                
                print_status "Creating GitHub repository..."
                if gh repo create "$repo_name" --description "$repo_description" $is_private; then
                    local github_user
                    github_user=$(gh api user --jq .login 2>/dev/null)
                    git remote add origin "https://github.com/$github_user/$repo_name.git"
                    git branch -M main
                    git push -u origin main
                    
                    print_success "GitHub repository created and pushed"
                else
                    print_error "Failed to create GitHub repository"
                    print_error "Please check your GitHub CLI authentication and permissions"
                    # Return to original directory (best effort)
                    cd "$original_dir" 2>/dev/null || true
                    return 1
                fi
            fi
        fi
        
        # Return to original directory (best effort)
        cd "$original_dir" 2>/dev/null || true
    fi
}

# Function to show help
show_help() {
    cat << EOF
Usage: $0 [--non-interactive] [--help]

Dev-Infra Project Template Generator
Creates new projects from dev-infra templates

Options:
  --non-interactive    Run in non-interactive mode (reads from environment variables)
  --help, -h          Show this help message

Non-Interactive Mode:
  When --non-interactive flag is used, the script reads inputs from environment variables:
  
  Required:
    PROJECT_NAME         Project name
    PROJECT_TYPE         Template type: standard-project or learning-project
  
  Optional:
    PROJECT_DESCRIPTION  Project description
    INIT_GIT            Initialize git repository: true or false (default: false)
    TARGET_DIR          Target directory (default: \$HOME/Projects or current directory)
    AUTHOR              Author name (default: git config user.name)
  
  Example:
    PROJECT_NAME="my-project" \\
    PROJECT_TYPE="standard-project" \\
    ./scripts/new-project.sh --non-interactive

Exit Codes:
  0  Success
  1  Validation error or general error
  2  Invalid arguments or usage error
EOF
}

# Function to validate non-interactive inputs
validate_non_interactive_inputs() {
    local errors=0
    
    if [[ -z "$PROJECT_NAME" ]]; then
        print_error "PROJECT_NAME environment variable is required in non-interactive mode"
        errors=$((errors + 1))
    fi
    
    if [[ -z "$PROJECT_TYPE" ]]; then
        print_error "PROJECT_TYPE environment variable is required in non-interactive mode"
        errors=$((errors + 1))
    elif [[ "$PROJECT_TYPE" != "standard-project" && "$PROJECT_TYPE" != "learning-project" ]]; then
        print_error "PROJECT_TYPE must be 'standard-project' or 'learning-project', got: $PROJECT_TYPE"
        errors=$((errors + 1))
    fi
    
    if [[ -n "$INIT_GIT" && "$INIT_GIT" != "true" && "$INIT_GIT" != "false" ]]; then
        print_error "INIT_GIT must be 'true' or 'false', got: $INIT_GIT"
        errors=$((errors + 1))
    fi
    
    if [[ $errors -gt 0 ]]; then
        print_error "Validation failed with $errors error(s). Please fix the issues above."
        exit 1
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
        echo "- Review docs/maintainers/planning/README.md for project management"
        echo "- Set up your first feature in docs/maintainers/planning/features/"
        echo "- Configure CI/CD workflows"
    fi
    echo
    echo "Happy coding! 🚀"
}

# Main function
main() {
    # Parse command-line arguments
    NON_INTERACTIVE_MODE="false"
    if [[ "$1" == "--non-interactive" ]]; then
        NON_INTERACTIVE_MODE="true"
        shift  # Remove flag from arguments
    elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
        show_help
        exit 0
    fi
    
    # Fallback to existing detection (maintain backward compatibility)
    if [[ "$NON_INTERACTIVE_MODE" != "true" ]]; then
        if [[ -n "$GITHUB_ACTIONS" || -n "$CI" || -n "$NON_INTERACTIVE" ]]; then
            NON_INTERACTIVE_MODE="true"
        fi
    fi
    
    # Read environment variables if in non-interactive mode
    if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
        PROJECT_NAME="${PROJECT_NAME:-}"
        PROJECT_TYPE="${PROJECT_TYPE:-}"
        PROJECT_DESCRIPTION="${PROJECT_DESCRIPTION:-}"
        INIT_GIT="${INIT_GIT:-false}"
        TARGET_DIR="${TARGET_DIR:-}"
        AUTHOR="${AUTHOR:-$(git config user.name 2>/dev/null || echo '')}"
        
        # Validate inputs early
        validate_non_interactive_inputs
    fi
    
    echo "🚀 Dev-Infra Project Template Generator"
    echo "======================================"
    echo
    
    # Determine default directory
    local DEFAULT_DIR="$HOME/Projects"
    if [ "$NON_INTERACTIVE_MODE" != "true" ]; then
        if [ ! -d "$DEFAULT_DIR" ]; then
            if prompt_yes_no "Directory $DEFAULT_DIR doesn't exist. Create it?" "n"; then
                mkdir -p "$DEFAULT_DIR"
                print_success "Created directory: $DEFAULT_DIR"
            else
                DEFAULT_DIR="$PWD"
                print_status "Using current directory as default"
            fi
        fi
    else
        # In non-interactive mode, use TARGET_DIR if set, otherwise use DEFAULT_DIR
        if [ -n "$TARGET_DIR" ]; then
            DEFAULT_DIR="$TARGET_DIR"
        elif [ ! -d "$DEFAULT_DIR" ]; then
            DEFAULT_DIR="$PWD"
        fi
    fi
    
    # Get target directory first
    echo
    local target_dir
    if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
        target_dir="${TARGET_DIR:-$DEFAULT_DIR}"
        print_status "Using target directory: $target_dir"
    else
        target_dir=$(prompt_input "Target directory (press Enter for $DEFAULT_DIR or enter custom path)" "$DEFAULT_DIR")
    fi
    
    # Validate and resolve target directory
    # Disable set -e around function call to prevent premature exit
    local TARGET_DIR_VAR
    local resolved_dir
    local error_code
    set +e
    resolved_dir=$(validate_target_directory "$target_dir" 2>/dev/null)
    error_code=$?
    set -e
    
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
            TARGET_DIR_VAR="$resolved_dir"
            print_status "Using directory: $TARGET_DIR_VAR"
            ;;
        3)
            # Directory doesn't exist but parent exists and is writable - can be created
            if [ -z "$resolved_dir" ]; then
                print_error "Cannot determine directory path for: $target_dir"
                exit 1
            fi
            if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
                # In non-interactive mode, create directory automatically
                if mkdir -p "$resolved_dir" 2>/dev/null; then
                    TARGET_DIR_VAR="$(cd "$resolved_dir" && pwd)"
                    print_success "Created directory: $TARGET_DIR_VAR"
                else
                    print_error "Failed to create directory: $resolved_dir"
                    exit 1
                fi
            else
                if prompt_yes_no "Directory '$resolved_dir' doesn't exist. Create it?" "n"; then
                    if mkdir -p "$resolved_dir" 2>/dev/null; then
                        TARGET_DIR_VAR="$(cd "$resolved_dir" && pwd)"
                        print_success "Created directory: $TARGET_DIR_VAR"
                    else
                        print_error "Failed to create directory: $resolved_dir"
                        exit 1
                    fi
                else
                    print_error "Cannot proceed without valid directory"
                    exit 1
                fi
            fi
            ;;
        1)
            # Directory doesn't exist and parent doesn't exist or invalid
            # Try to create the full path
            if [ -z "$resolved_dir" ]; then
                print_error "Cannot determine directory path for: $target_dir"
                exit 1
            fi
            if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
                # In non-interactive mode, create directory automatically
                if mkdir -p "$resolved_dir" 2>/dev/null; then
                    if [ -d "$resolved_dir" ]; then
                        TARGET_DIR_VAR="$(cd "$resolved_dir" && pwd)"
                        print_success "Created directory: $TARGET_DIR_VAR"
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
                if prompt_yes_no "Directory '$resolved_dir' doesn't exist. Create it (including parent directories)?" "n"; then
                    if mkdir -p "$resolved_dir" 2>/dev/null; then
                        if [ -d "$resolved_dir" ]; then
                            TARGET_DIR_VAR="$(cd "$resolved_dir" && pwd)"
                            print_success "Created directory: $TARGET_DIR_VAR"
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
    local project_name
    if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
        project_name="$PROJECT_NAME"
        print_status "Using project name: $project_name"
    else
        project_name=$(prompt_input "Project name")
    fi
    
    # Validate project name and get full path
    local full_project_path
    while ! full_project_path=$(validate_project_name "$project_name" "$TARGET_DIR_VAR"); do
        if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
            print_error "Failed to validate project name: $project_name"
            exit 1
        else
            project_name=$(prompt_input "Project name")
        fi
    done
    
    # Extract sanitized project name from full path to ensure consistency
    # This fixes the mismatch where original name with spaces is shown but sanitized name is used
    project_name=$(basename "$full_project_path")
    
    local description
    local author
    if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
        description="${PROJECT_DESCRIPTION:-}"
        author="${AUTHOR:-$(git config user.name 2>/dev/null || echo '')}"
        print_status "Using description: ${description:-<none>}"
        print_status "Using author: ${author:-<none>}"
    else
        description=$(prompt_input "Project description")
        author=$(prompt_input "Author name" "$(git config user.name 2>/dev/null || echo '')")
    fi
    
    # Select project type
    local project_type
    local template_type
    if [ "$NON_INTERACTIVE_MODE" = "true" ]; then
        template_type="$PROJECT_TYPE"
        if [ "$PROJECT_TYPE" = "standard-project" ]; then
            project_type="Standard Project"
        elif [ "$PROJECT_TYPE" = "learning-project" ]; then
            project_type="Learning Project"
        fi
        print_status "Using project type: $project_type"
    else
        echo
        echo "Select project type:"
        echo "1) Standard Project (application, tool, service)"
        echo "2) Learning Project (tutorial, exercises, reference)"
        echo
        
        local project_type_choice
        while true; do
            read -p "Enter choice [1-2]: " project_type_choice
            case $project_type_choice in
                1)
                    project_type="Standard Project"
                    template_type="standard-project"
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
    fi
    
    # Confirm project creation
    echo
    echo "Project Summary:"
    echo "Name: $project_name"
    echo "Location: $full_project_path"
    echo "Type: $project_type"
    echo "Description: $description"
    echo "Author: $author"
    echo
    
    if [ "$NON_INTERACTIVE_MODE" != "true" ]; then
        if ! prompt_yes_no "Create project with these settings?" "y"; then
            print_warning "Project creation cancelled"
            exit 0
        fi
    else
        print_status "Non-interactive mode: proceeding with project creation"
    fi
    
    # Create project
    copy_template "$template_type" "$full_project_path"
    customize_project "$full_project_path" "$project_type" "$description" "$author"
    init_git_repo "$full_project_path" "$author"
    show_next_steps "$full_project_path" "$project_type"
}

# Run main function
main "$@"
