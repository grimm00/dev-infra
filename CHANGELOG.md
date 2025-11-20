# Changelog

All notable changes to dev-infra will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2025-01-27

### Added

- **Regular Project Template** - Complete application/tool/service template

  - Hub-and-spoke documentation pattern
  - Admin directory for project management
  - Feature-based planning structure
  - Backend/frontend separation
  - Centralized testing organization
  - CI/CD workflow templates
  - Automation scripts structure

- **Learning Project Template** - Educational content template

  - Stage-based learning progression
  - Fundamentals before implementation approach
  - Hands-on exercise framework
  - Reference materials organization
  - Practice applications structure
  - Educational content patterns

- **Project Generator Script** - Interactive template instantiation

  - Interactive prompts for project details
  - Template type selection (Regular/Learning)
  - Automatic file customization
  - Git repository initialization
  - GitHub repository creation (optional)
  - Project validation and error handling

- **Cursor IDE Rules** - AI assistant configuration

  - Dev-infra specific guidelines
  - Template structure requirements
  - Git Flow practices
  - CI/CD requirements
  - Testing standards
  - Template maintenance guidelines

- **Comprehensive Documentation**

  - Template Usage Guide
  - Project Types Guide
  - Best Practices Guide
  - Customization Guide
  - Contributing Guidelines

- **Standardized start.txt Template** - Project initialization form
  - Problem statement section
  - Project type selection
  - Scope definition
  - Structure preferences
  - Version control options
  - Tool integrations
  - CI/CD preferences
  - Additional notes section

### Features

- **Hub-and-Spoke Documentation Pattern**

  - README.md hubs with quick links
  - Focused spoke documents
  - Progressive disclosure
  - Consistent navigation

- **Two Project Types**

  - Regular projects for applications/tools/services
  - Learning projects for tutorials/courses/exercises
  - Each optimized for specific use cases

- **Best Practices Integration**

  - Patterns from real projects (Pokehub, dev-toolkit, containers)
  - Proven workflows and structures
  - Flexible adaptation to different needs

- **CI/CD Workflow Templates**

  - Branch-based automation
  - Feature/fix/docs/chore/ci/release branch handling
  - Automated testing and validation
  - External review integration

- **Admin Directory Structure**
  - Planning hub with feature-based organization
  - Feedback integration (Sourcery, Bugbot)
  - Chat logs for AI conversation history
  - Research directory for decision documentation
  - Testing strategies and results

### Documentation

- **Template Examples** - Complete template structures
- **Real Project Examples** - Patterns from actual projects
- **Usage Guides** - Comprehensive how-to documentation
- **Best Practices** - Recommended approaches and patterns
- **Customization Guides** - Advanced configuration options

### Automation

- **Interactive Project Generator** - Automated template instantiation
- **File Customization** - Automatic placeholder replacement
- **Git Integration** - Repository initialization and GitHub creation
- **Validation** - Project name and structure validation

### Examples

- **Hub-and-Spoke Documentation** - Best practices from real projects
- **Project Structures** - Examples from Pokehub, dev-toolkit, containers
- **CI/CD Workflows** - Branch-based automation patterns
- **AI Rules** - Cursor IDE configuration examples

---

## [1.1.0] - 2025-11-10

### Added

- **Automated Release Distribution** - GitHub Actions workflow for clean release packages

  - Automatic creation of distribution packages (tar.gz and zip)
  - Package validation before upload
  - SHA256 checksum generation for security
  - Excludes internal development files (admin/, .cursor/, start.txt)
  - Includes only user-facing content (templates, scripts, docs)
  - Cross-platform support (Linux/Mac/Windows)

- **Release Process Documentation** - Standardized release workflow

  - Complete release process guide
  - Phase-based release preparation
  - External review integration
  - Git Flow adherence

- **CI/CD Planning Structure** - Hub-and-spoke planning for CI features
  - CI planning hub
  - Release distribution planning documentation
  - Implementation plans and testing strategies
  - Design decisions documentation

### Changed

- **Integration Documentation** - Enhanced version-pinned download guide

  - Distribution package download options
  - Checksum verification instructions
  - Updated for automated distribution

- **Release Process** - Established proper Git Flow for releases
  - Separation of feature development and release preparation
  - Clear phase-based workflow
  - External review requirements

### Fixed

- **Version Extraction** - Robust tag parsing in GitHub Actions
  - Handles tags with or without 'v' prefix
  - Prevents workflow failures from tag format issues

### Security

- **Action Pinning** - Pinned third-party GitHub Action to commit SHA
  - Enhanced security by using immutable action versions
  - Prevents supply chain attacks from action updates

---

## [1.2.0] - 2025-11-12

### Added

- **Directory Selection Feature** - Choose target directory for project generation

  - Default directory support (`$HOME/Projects/`)
  - Custom path support (absolute, relative, environment variables)
  - Environment variable expansion (`$HOME`, `$USER`, `$PWD`, `~`, `${VAR}` syntax)
  - Comprehensive path validation (existence, permissions, writability)
  - Automatic directory creation prompts
  - Backward compatible (falls back to current directory)

- **Automated Testing Suite** - Comprehensive BATS test suite

  - 33 tests covering all key functionality
  - Unit tests for core functions (24 tests)
  - Integration tests for path resolution (4 tests)
  - Regression tests for critical fixes (3 tests)
  - Backward compatibility tests (2 tests)
  - All tests passing
  - Fast execution (< 5 seconds)

- **Project Name Validation Improvements**

  - Clear error messages for invalid names
  - Automatic space-to-dash replacement option
  - Better user experience with helpful prompts

- **GitHub Authentication Verification**

  - Checks GitHub CLI authentication before repo creation
  - Verifies authenticated user matches author name
  - Handles multiple GitHub accounts with user confirmation

- **Documentation Enhancements**

  - PR feedback documentation system (PRs #4, #5, #6)
  - Deferred tasks backlog
  - Automated testing documentation
  - Complete feature documentation

### Fixed

- **Cross-Platform Compatibility** - macOS/BSD compatibility fix

  - Replaced GNU-specific `sed` pattern with bash parameter expansion
  - Works correctly on all Unix-like systems (Linux, macOS, BSD)
  - No external dependencies

- **Root Directory Handling** - Fixed root directory bug

  - Root directory `/` no longer converted to empty string
  - Proper handling of edge cases
  - Preserves root directory path correctly

- **Error Handling** - Refactored fragile error handling

  - Removed `set -e` toggles from functions
  - Cleaner, more maintainable code
  - Better error isolation

- **Silent Failure Fix** - Non-existent paths now return proper errors

  - Clear error messages for invalid paths
  - No more silent failures
  - Helpful feedback for users

### Changed

- **Path Resolution** - Enhanced path handling throughout script

  - Robust path normalization
  - Consistent trailing slash handling
  - Better relative path resolution
  - Improved environment variable expansion

- **User Experience** - Improved prompts and feedback

  - Clearer error messages
  - Helpful suggestions for common issues
  - Better validation feedback

---

## [1.3.0] - 2025-11-18

### Added

- **Multi-Environment Testing Workflow** - Automated CI/CD testing across Ubuntu and macOS

  - Automated testing on every PR and push
  - Multi-platform validation (Ubuntu + macOS)
  - Docker images for consistent Ubuntu environment
  - Image tagging strategy (latest, stable, verified-{sha})
  - Concurrency control to prevent duplicate runs
  - Path filtering to skip docs/admin changes
  - Draft PR filtering for better developer experience
  - Timeout limits to prevent hung workflows
  - Integration with release workflow (tests must pass before release)
  - All 63 tests passing (1 skipped - interactive smoke test)

- **Docker Test Images** - Custom Docker images for Ubuntu test jobs

  - Pre-built images with BATS, git, bash, and required tools
  - Consistent tool versions across all runs
  - Faster execution (~15 seconds faster per run)
  - Reproducible test environments with tagged images
  - Self-contained workflow (builds image before tests run)

- **Comprehensive Status Documentation** - Status tracking for all CI and feature projects

  - Executive summary with quick status table
  - Detailed CI projects analysis
  - Detailed features analysis
  - Discrepancy tracking and resolution
  - Implementation verification via git history

### Changed

- **Test Workflow Structure** - Improved workflow organization

  - Split full-tests matrix into separate jobs (full-tests-ubuntu, full-tests-macos)
  - Better job separation and clarity
  - Improved error messages

- **Docker Image Tagging** - Simplified and more reliable tag generation

  - Replaced docker/metadata-action with shell script
  - Always tag with commit SHA for reproducibility
  - Branch-specific tags for feature branches
  - Latest tag for main/develop branches

### Fixed

- **Workflow YAML Syntax Errors** - Resolved invalid YAML in workflow files

  - Fixed container: null issue in test.yml (split into separate jobs)
  - Fixed invalid Docker tag format in build-test-image.yml
  - Added concurrency control to build-test-image.yml
  - Added timeout to build-test-image.yml

- **Git Operations Tests** - Fixed test failures in Docker containers

  - Added git config setup in test helpers
  - Ensured git user.name and user.email are set before commits
  - Fixed git operations test failures in container environment

- **Template Operations Tests** - Aligned test helpers with actual script behavior

  - Fixed PROJECT_ROOT calculation in test helpers
  - Aligned copy_template method with actual script
  - Removed unnecessary git rev-parse dependencies
  - Fixed template path resolution in Docker containers

- **Directory Validation Tests** - Improved container environment handling

  - Added verification that chmod -w actually works
  - Added skip conditions for container environments
  - Improved test robustness in Docker containers

- **Prompt Non-Interactive Detection** - Improved CI environment detection

  - Added GITHUB_ACTIONS environment variable check
  - Added NON_INTERACTIVE explicit flag support
  - Improved detection logic priority
  - Fixed prompt_yes_no function for non-interactive environments

### Security

- **Workflow Reliability** - Improved error handling and validation

  - Added error handling (|| exit 1) to all critical commands
  - Added verification steps after installations
  - Improved concurrency control to prevent conflicts
  - Added timeout limits to prevent hung workflows

---

## [Unreleased]

### Planned

- Template validation and testing
- Advanced customization options
- Integration with more tools
- Community feedback integration
- Performance optimizations
- Additional project types
- Template marketplace
- Automated template updates

### Under Consideration

- CLI tool for template management
- Template versioning system
- Community template sharing
- Advanced CI/CD integrations
- Multi-language support
- Cloud deployment templates

---

## Version History

### 1.1.0 (2025-11-10)

- **Automated Release Distribution** - GitHub Actions workflow creates clean distribution packages automatically
- Automated package validation and checksum generation
- Enhanced release process documentation and Git Flow adherence
- Security improvements (action pinning, robust version extraction)
- CI/CD planning structure with hub-and-spoke documentation

### 1.0.0 (2025-01-27)

- **First Production Release** - Complete dev-infra template system
- Two project templates (Regular, Learning) with full structure
- Interactive project generator with customization
- Comprehensive documentation (6 guides covering all aspects)
- Automated template validation script (20+ checks)
- Hub-and-spoke documentation pattern throughout
- CI/CD workflow templates with branch-based automation
- Cursor IDE rules integration for AI assistance
- Complete .gitignore and .dockerignore files
- Integration guide for dev-toolkit projects
- Professional git setup with version control

---

## Migration Guide

### From Manual Project Setup

1. Use `./scripts/new-project.sh` to generate new projects
2. Follow template structure for existing projects
3. Adopt hub-and-spoke documentation pattern
4. Implement CI/CD workflows from templates
5. Use admin directory for project management

### Template Updates

- Review new template versions
- Update existing projects as needed
- Migrate to new patterns gradually
- Document migration decisions
- Test changes thoroughly

---

## Breaking Changes

### 1.1.0

- No breaking changes

### 1.0.0

- Initial production release - no breaking changes

---

## Deprecations

### 1.1.0

- No deprecations

### 1.0.0

- No deprecations in initial production release

---

## Security

### 1.1.0

- Pinned third-party GitHub Actions to commit SHA for immutability
- SHA256 checksum generation for distribution packages
- Enhanced version extraction to prevent workflow failures

### 1.0.0

- Lightweight security for MVP
- Focus on individual developer workflow
- No community involvement required initially
- Security can be enhanced in future versions

---

## Performance

### 1.0.0

- Fast project generation (< 30 seconds)
- Efficient template copying
- Minimal resource usage
- Optimized for local development

---

## Dependencies

### 1.1.0

- Same as 1.0.0
- GitHub Actions (for automated release distribution)

### 1.0.0

- Bash 4.0+ (for generator script)
- Git 2.0+ (for repository management)
- GitHub CLI (optional, for GitHub integration)
- Standard Unix tools (cp, mkdir, sed, etc.)

---

## Contributors

### 1.0.0

- Initial development and template creation
- Documentation and examples
- Script development and testing
- Best practices integration

---

**Last Updated:** 2025-11-10  
**Status:** ✅ Active  
**Next:** [Template Usage Guide](docs/TEMPLATE-USAGE.md)
