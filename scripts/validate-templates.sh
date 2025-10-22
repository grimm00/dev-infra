#!/bin/bash

# validate-templates.sh - Automated template validation script
# Validates template structure, documentation, and consistency

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

# Validation results
VALIDATION_ERRORS=0
VALIDATION_WARNINGS=0
VALIDATION_SUCCESS=0

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
    ((VALIDATION_SUCCESS++))
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
    ((VALIDATION_WARNINGS++))
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    ((VALIDATION_ERRORS++))
}

# Function to check if file exists
check_file() {
    local file="$1"
    local description="$2"
    
    if [ -f "$file" ]; then
        print_success "$description found: $file"
        return 0
    else
        print_error "$description missing: $file"
        return 1
    fi
}

# Function to check if directory exists
check_directory() {
    local dir="$1"
    local description="$2"
    
    if [ -d "$dir" ]; then
        print_success "$description found: $dir"
        return 0
    else
        print_error "$description missing: $dir"
        return 1
    fi
}

# Function to check if README.md exists in directory
check_readme_hub() {
    local dir="$1"
    local description="$2"
    
    if [ -f "$dir/README.md" ]; then
        print_success "$description hub found: $dir/README.md"
        return 0
    else
        print_error "$description hub missing: $dir/README.md"
        return 1
    fi
}

# Function to validate template structure
validate_template() {
    local template_type="$1"
    local template_dir="$DEV_INFRA_DIR/templates/$template_type"
    
    print_status "Validating $template_type template..."
    
    if [ ! -d "$template_dir" ]; then
        print_error "Template directory not found: $template_dir"
        return 1
    fi
    
    local template_errors=0
    
    # Check required files
    check_file "$template_dir/README.md" "Main README hub" || ((template_errors++))
    check_file "$template_dir/start.txt" "Start template" || ((template_errors++))
    check_file "$template_dir/.gitignore" "Git ignore file" || ((template_errors++))
    check_file "$template_dir/.dockerignore" "Docker ignore file" || ((template_errors++))
    
    # Check required directories
    check_directory "$template_dir/admin" "Admin directory" || ((template_errors++))
    
    # Check admin structure
    if [ -d "$template_dir/admin" ]; then
        check_readme_hub "$template_dir/admin" "Admin" || ((template_errors++))
        check_directory "$template_dir/admin/planning" "Admin planning" || ((template_errors++))
        
        if [ -d "$template_dir/admin/planning" ]; then
            check_readme_hub "$template_dir/admin/planning" "Planning" || ((template_errors++))
            check_directory "$template_dir/admin/planning/features" "Features planning" || ((template_errors++))
            
            if [ -d "$template_dir/admin/planning/features" ]; then
                check_readme_hub "$template_dir/admin/planning/features" "Features" || ((template_errors++))
            fi
        fi
    fi
    
    # Template-specific checks
    if [ "$template_type" = "regular-project" ]; then
        validate_regular_template "$template_dir" || ((template_errors++))
    elif [ "$template_type" = "learning-project" ]; then
        validate_learning_template "$template_dir" || ((template_errors++))
    fi
    
    if [ $template_errors -eq 0 ]; then
        print_success "$template_type template validation passed"
        return 0
    else
        print_error "$template_type template validation failed with $template_errors errors"
        return 1
    fi
}

# Function to validate regular project template
validate_regular_template() {
    local template_dir="$1"
    local errors=0
    
    print_status "Validating regular project template structure..."
    
    # Check required directories
    check_directory "$template_dir/backend" "Backend directory" || ((errors++))
    check_directory "$template_dir/frontend" "Frontend directory" || ((errors++))
    check_directory "$template_dir/tests" "Tests directory" || ((errors++))
    check_directory "$template_dir/scripts" "Scripts directory" || ((errors++))
    check_directory "$template_dir/docs" "Docs directory" || ((errors++))
    
    # Check backend structure
    if [ -d "$template_dir/backend" ]; then
        check_readme_hub "$template_dir/backend" "Backend" || ((errors++))
        check_directory "$template_dir/backend/instance" "Backend instance" || ((errors++))
    fi
    
    # Check frontend structure
    if [ -d "$template_dir/frontend" ]; then
        check_readme_hub "$template_dir/frontend" "Frontend" || ((errors++))
    fi
    
    # Check tests structure
    if [ -d "$template_dir/tests" ]; then
        check_readme_hub "$template_dir/tests" "Tests" || ((errors++))
    fi
    
    # Check scripts structure
    if [ -d "$template_dir/scripts" ]; then
        check_readme_hub "$template_dir/scripts" "Scripts" || ((errors++))
    fi
    
    # Check docs structure
    if [ -d "$template_dir/docs" ]; then
        check_readme_hub "$template_dir/docs" "Docs" || ((errors++))
    fi
    
    # Check CI/CD
    check_directory "$template_dir/.github" "GitHub directory" || ((errors++))
    if [ -d "$template_dir/.github" ]; then
        check_directory "$template_dir/.github/workflows" "GitHub workflows" || ((errors++))
        if [ -d "$template_dir/.github/workflows" ]; then
            check_file "$template_dir/.github/workflows/ci.yml" "CI workflow" || ((errors++))
        fi
    fi
    
    return $errors
}

# Function to validate learning project template
validate_learning_template() {
    local template_dir="$1"
    local errors=0
    
    print_status "Validating learning project template structure..."
    
    # Check required directories
    check_directory "$template_dir/stage0-fundamentals" "Stage 0 fundamentals" || ((errors++))
    check_directory "$template_dir/reference" "Reference directory" || ((errors++))
    check_directory "$template_dir/practice-apps" "Practice apps directory" || ((errors++))
    
    # Check stage structure
    if [ -d "$template_dir/stage0-fundamentals" ]; then
        check_readme_hub "$template_dir/stage0-fundamentals" "Stage 0" || ((errors++))
    fi
    
    # Check reference structure
    if [ -d "$template_dir/reference" ]; then
        check_readme_hub "$template_dir/reference" "Reference" || ((errors++))
    fi
    
    # Check practice apps structure
    if [ -d "$template_dir/practice-apps" ]; then
        check_readme_hub "$template_dir/practice-apps" "Practice apps" || ((errors++))
    fi
    
    # Check for stage directories (should have at least one)
    local stage_count=$(find "$template_dir" -maxdepth 1 -type d -name "stage*-*" | wc -l)
    if [ $stage_count -gt 0 ]; then
        print_success "Found $stage_count stage directories"
    else
        print_warning "No stage directories found (stage1-topic, stage2-topic, etc.)"
    fi
    
    return $errors
}

# Function to validate documentation
validate_documentation() {
    print_status "Validating documentation structure..."
    
    local doc_errors=0
    
    # Check docs directory
    check_directory "$DEV_INFRA_DIR/docs" "Documentation directory" || ((doc_errors++))
    
    if [ -d "$DEV_INFRA_DIR/docs" ]; then
        # Check required documentation files
        check_file "$DEV_INFRA_DIR/docs/README.md" "Documentation hub" || ((doc_errors++))
        check_file "$DEV_INFRA_DIR/docs/TEMPLATE-USAGE.md" "Template usage guide" || ((doc_errors++))
        check_file "$DEV_INFRA_DIR/docs/PROJECT-TYPES.md" "Project types guide" || ((doc_errors++))
        check_file "$DEV_INFRA_DIR/docs/TEMPLATE-FILES.md" "Template files guide" || ((doc_errors++))
        check_file "$DEV_INFRA_DIR/docs/BEST-PRACTICES.md" "Best practices guide" || ((doc_errors++))
        check_file "$DEV_INFRA_DIR/docs/CUSTOMIZATION.md" "Customization guide" || ((doc_errors++))
    fi
    
    return $doc_errors
}

# Function to validate scripts
validate_scripts() {
    print_status "Validating scripts..."
    
    local script_errors=0
    
    # Check scripts directory
    check_directory "$DEV_INFRA_DIR/scripts" "Scripts directory" || ((script_errors++))
    
    if [ -d "$DEV_INFRA_DIR/scripts" ]; then
        # Check required scripts
        check_file "$DEV_INFRA_DIR/scripts/new-project.sh" "Project generator script" || ((script_errors++))
        
        # Check if scripts are executable
        if [ -f "$DEV_INFRA_DIR/scripts/new-project.sh" ]; then
            if [ -x "$DEV_INFRA_DIR/scripts/new-project.sh" ]; then
                print_success "Project generator script is executable"
            else
                print_error "Project generator script is not executable"
                ((script_errors++))
            fi
        fi
    fi
    
    return $script_errors
}

# Function to validate root files
validate_root_files() {
    print_status "Validating root files..."
    
    local root_errors=0
    
    # Check required root files
    check_file "$DEV_INFRA_DIR/README.md" "Main README" || ((root_errors++))
    check_file "$DEV_INFRA_DIR/CONTRIBUTING.md" "Contributing guide" || ((root_errors++))
    check_file "$DEV_INFRA_DIR/CHANGELOG.md" "Changelog" || ((root_errors++))
    check_file "$DEV_INFRA_DIR/.gitignore" "Root gitignore" || ((root_errors++))
    check_file "$DEV_INFRA_DIR/start.txt" "Start template" || ((root_errors++))
    
    # Check Cursor rules
    check_file "$DEV_INFRA_DIR/.cursor/rules/main.mdc" "Cursor rules" || ((root_errors++))
    
    return $root_errors
}

# Function to check for broken links in README files
check_readme_links() {
    print_status "Checking README links..."
    
    local link_errors=0
    
    # Find all README.md files
    local readme_files=$(find "$DEV_INFRA_DIR" -name "README.md" -type f)
    
    for readme in $readme_files; do
        print_status "Checking links in: $readme"
        
        # Extract markdown links (basic check)
        local links=$(grep -o '\[[^]]*\]([^)]*)' "$readme" 2>/dev/null || true)
        
        if [ -n "$links" ]; then
            while IFS= read -r link; do
                # Extract the file path from the link
                local file_path=$(echo "$link" | sed 's/.*(\([^)]*\)).*/\1/')
                
                # Skip external links
                if [[ "$file_path" =~ ^https?:// ]]; then
                    continue
                fi
                
                # Skip anchor links
                if [[ "$file_path" =~ ^# ]]; then
                    continue
                fi
                
                # Check if the linked file exists
                local full_path="$DEV_INFRA_DIR/$(dirname "$readme")/$file_path"
                if [ ! -f "$full_path" ] && [ ! -d "$full_path" ]; then
                    print_warning "Broken link in $readme: $link"
                    ((link_errors++))
                fi
            done <<< "$links"
        fi
    done
    
    if [ $link_errors -eq 0 ]; then
        print_success "No broken links found in README files"
    else
        print_warning "Found $link_errors broken links in README files"
    fi
    
    return $link_errors
}

# Function to generate validation report
generate_report() {
    echo
    echo "=========================================="
    echo "VALIDATION REPORT"
    echo "=========================================="
    echo
    
    echo "✅ Successes: $VALIDATION_SUCCESS"
    echo "⚠️  Warnings: $VALIDATION_WARNINGS"
    echo "❌ Errors: $VALIDATION_ERRORS"
    echo
    
    if [ $VALIDATION_ERRORS -eq 0 ]; then
        if [ $VALIDATION_WARNINGS -eq 0 ]; then
            print_success "All validations passed! Templates are ready to use."
            return 0
        else
            print_warning "Validation completed with warnings. Templates are functional but may need attention."
            return 0
        fi
    else
        print_error "Validation failed with $VALIDATION_ERRORS errors. Please fix issues before using templates."
        return 1
    fi
}

# Main validation function
main() {
    echo "🔍 Dev-Infra Template Validation"
    echo "================================"
    echo
    
    # Validate templates
    validate_template "regular-project"
    validate_template "learning-project"
    
    # Validate documentation
    validate_documentation
    
    # Validate scripts
    validate_scripts
    
    # Validate root files
    validate_root_files
    
    # Check README links
    check_readme_links
    
    # Generate report
    generate_report
}

# Run main function
main "$@"
