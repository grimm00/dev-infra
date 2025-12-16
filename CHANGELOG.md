# Changelog

All notable changes to dev-infra will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.5.0] - 2025-12-12

### Added

**Release Automation v2 (Internal Only)**

This release focuses on internal tooling to streamline the release process. Per ADR-002 (Template Factory identity), these improvements remain dev-infra-only and are not included in templates.

- **Automatic Tag Creation (Phase 1)** - GitHub Actions workflow automatically creates release tags when release PRs merge to main (PR #44)
  - Workflow: `.github/workflows/create-release-tag.yml`
  - Triggers on release PR merge to main
  - Extracts version from branch name
  - Creates annotated tag with release message
  - Pushes tag to trigger release distribution
  - Supports dry-run mode for testing
  - Updated release process documentation
  - Updated workflows README with tag creation details
  - Marked v1.4.0 retrospective action items as complete

- **Version Reference Automation (Phase 2)** - Script to automatically update version references across codebase during releases (PR #45)
  - Script: `scripts/update-version-references.sh`
  - Updates `.cursor/rules/main.mdc` (AI rules)
  - Updates `README.md` badges (if exist)
  - Updates `package.json` version (if exists)
  - Validation and error handling with rollback
  - Dry-run mode for safe previews
  - Comprehensive test suite (42 tests)
  - Documentation: `docs/VERSION-REFERENCES.md`
  - Integrated with `/release-finalize` command

### Changed

**Identity and Focus**

- **Template Factory Identity** - Formalized dev-infra's identity as a "template factory" with clear graduation criteria for template features (ADR-001, ADR-002, ADR-003, ADR-004)
  - Work classification (template features vs internal tooling vs CI/CD)
  - Graduation process for template features
  - Template integration criteria
  - Release Automation v2 Phase 3 deferred (template integration)
  - Updated Cursor rules and documentation
  - Implemented transition plan

### Documentation

- **Command Documentation** - Created command integration workflows
  - `/release-prep` - Streamlined release preparation
  - `/release-finalize` - Release finalization tasks
  - `/post-release` - Post-release documentation
  - `/address-review` - Address pre-phase review findings

- **Release Process** - Updated release process documentation
  - Tag creation now automated via GitHub Actions
  - Version reference updates automated via script
  - Release readiness tools integrated

- **Workflows Documentation** - Created `.github/workflows/README.md` hub
  - Documented all active workflows
  - Detailed tag creation workflow
  - Workflow dependencies diagram

- **Learning Capture** - Captured Phase 1 learnings
  - Release Automation v2 Phase 1 learnings documented
  - Feature-specific learnings hub created
  - Time investment and metrics tracked

- **Post-Merge Documentation** - Updated feature status after PR merges
  - Phase 1 marked complete with PR reference
  - Phase 2 marked complete with PR reference
  - Deferred issues tracked (2 from PR #44, 5 from PR #45)
  - Fix tracking system established

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

## [1.4.0] - 2025-12-11

### Added

- **Release Readiness Feature** - Complete release assessment and automation system

  - Standardized release criteria (`admin/planning/releases/standard-criteria.md`)
  - Assessment template with YAML frontmatter
  - `scripts/check-release-readiness.sh` - Automated readiness validation and assessment generation
  - `scripts/create-release-branch.sh` - Release branch creation helper with dry-run mode
  - `scripts/analyze-releases.sh` - Historical release analysis with trend tracking
  - Integration with `/task-release` and `/pr --release` commands
  - 48 new tests for release readiness scripts

- **Templates Enhancement** - Improved templates with commands and workflows (PR #23-26)

  - CI/CD Improvement Structure for templates
  - Exploration/Research/Decision workflows
  - Status tracking automation in commands
  - Feature-based planning improvements

- **Command Adaptation Template** - Pattern for adapting commands across projects (PR #21)

  - Adaptation pattern documentation
  - Template for command creation
  - Checklist for command integration

- **Template Generation Testing Automation** - Comprehensive CI/CD testing (PR #27, #29)

  - Non-interactive mode (`--non-interactive` flag) for CI environments
  - Template validation test suite (94+ tests total)
  - Multi-platform testing (Ubuntu + macOS)

- **New Cursor Commands**
  - `/release-prep` - Orchestrate release preparation workflow
  - `/release-finalize` - Finalize release documents and merge CHANGELOG
  - `/post-release` - Post-release cleanup and historical tracking
  - `/pre-phase-review` - Review phase plans before implementation
  - `/address-review` - Address gaps from pre-phase review
  - `/reflect` - Project reflection with cross-phase learnings
  - `/explore` - Exploration workflow for new ideas
  - `/research` - Research workflow for investigation
  - `/decision` - ADR creation workflow
  - `/transition-plan` - Planning from artifacts/ADRs
  - Enhanced `/task-release` with readiness check integration
  - Enhanced `/pr --release` with readiness validation and `--force` option

### Changed

- **Cursor Rules** - Updated with release readiness patterns and learnings
  - Added TDD for bash scripts section
  - Added script flag conventions (--dry-run, --force, --verbose, --json)
  - Added pre-phase review workflow
  - Updated command integration status (15+ commands complete)

- **Test Suite** - Expanded from ~46 tests to 94+ tests
  - Release readiness tests (48 new tests)
  - Template validation improvements
  - CI/CD environment handling

### Fixed

- **CI/CD Git Operations** - Fixed branch detection in CI environment (PR #40)
  - Full git clone for branch operations
  - Skip conditions for CI-problematic tests

- **Script Improvements** - Multiple script enhancements (PR #37)
  - Return code documentation
  - Whitespace trimming
  - Authentication warning improvements
  - Operator precedence fixes

- **Test Improvements** - Enhanced test coverage and assertions (PR #38, #39)
  - Edge case coverage
  - Assertion precision improvements
  - CI environment handling

- **Empty Directory Tracking** - Fixed Git not tracking empty directories (PR #31)
  - Added `.gitkeep` files to stage directories in learning template

- **Documentation Accuracy** - Fixed documentation inconsistencies (PR #28)

### Documentation

- **Release Process** - Comprehensive release workflow documentation
  - Transition plans
  - Release readiness assessments
  - Standard criteria documentation

- **Reflection Documents** - Project learnings and patterns
  - Release Readiness reflection with cross-phase learnings
  - Templates Enhancement reflection
  - Template Generation Testing Automation reflection

- **Command Documentation** - 15+ command markdown files
  - Complete workflow documentation
  - Examples and common scenarios
  - Integration guides

### Security

- No security changes in this release.

---

## [1.6.0] - 2025-12-15

### Added

- **Experimental Project Template** - New template type for testing evolving commands (PR #48, #49)

  - `templates/experimental-project/` - Same structure as standard-project with additional features
  - Includes `/status` as example Evolving tier command
  - Stability indicators (🟢 Stable, 🟠 Evolving, 🔴 Deprecated)
  - `docs/EXPERIMENTAL.md` - Experimental features documentation
  - `docs/STABILITY-LEVELS.md` - Stability level definitions
  - `docs/GRADUATION-CHECKLIST.md` - Graduation criteria based on ADR-004
  - GitHub issue template for experimental feedback

- **CI Drift Detection** - Automated validation to keep templates in sync (PR #49)

  - `scripts/validate-template-sync.sh` - Compares shared files between templates
  - `scripts/template-sync-manifest.txt` - Machine-readable list of shared files
  - CI integration in `.github/workflows/test.yml`
  - `docs/TEMPLATE-SYNC.md` - Comprehensive sync documentation
  - 10 comprehensive bats tests

- **Generator Script Updates** - Support for experimental template (PR #48)

  - Added `experimental-project` as third template type
  - Interactive menu with ⚠️ stability warning
  - `[y/N]` confirmation for experimental selection
  - Non-interactive mode skips warning for CI/automation
  - 8 new tests for experimental template generation

- **Stability Indicators** - Documentation for command maturity levels (Phase 4)

  - Three-tier system: 🟢 Stable, 🟠 Evolving, 🔴 Deprecated
  - Graduation checklist based on ADR-004 criteria
  - Feedback collection via GitHub issue templates
  - Stability section in template README

### Fixed

- **Test Assertion Improvements** - Strengthened test assertions across test suites (PR #50, #51)

  - More specific assertions (exact phrases vs keywords)
  - Added edge case tests for template sync
  - Fixed TDD placeholder assertions
  - Improved non-interactive mode testing
  - 8 tests improved total

- **Quick Wins Batch** - Various code quality improvements (PR #52)

  - POSIX-compatible string comparison in `new-project.sh`
  - Grammar fixes in documentation
  - Removed redundant test cleanup code
  - 4 issues fixed total

### Changed

- **Test Count** - Expanded from 94+ tests to 110+ tests

  - Generator script tests: 8 new
  - Template sync tests: 10 new
  - Test assertion improvements: 8 enhanced

- **Cursor Rules** - Updated with experimental template patterns

  - Added experimental template structure
  - Added stability indicators documentation
  - Added template sync validation section
  - Updated Bats TDD best practices

### CI/CD

- **CI Git Configuration** - Fixed git identity in CI workflows (PR #47)

  - Configured git user.name and user.email in test workflow
  - Enables commits in CI environment
  - Required for scripts that perform git operations

- **Template Sync Validation** - Added to CI pipeline

  - Validates shared files stay in sync
  - Fails CI on template drift
  - Clear error messages with fix instructions

### Security

- No security changes in this release.

---

## [1.5.0] - 2025-12-12

### Added

**Release Automation v2 (Internal Only)**

This release focuses on internal tooling to streamline the release process. Per ADR-002 (Template Factory identity), these improvements remain dev-infra-only and are not included in templates.

- **Automatic Tag Creation (Phase 1)** - GitHub Actions workflow automatically creates release tags when release PRs merge to main (PR #44)
  - Workflow: `.github/workflows/create-release-tag.yml`
  - Triggers on release PR merge to main
  - Extracts version from branch name
  - Creates annotated tag with release message
  - Pushes tag to trigger release distribution
  - Supports dry-run mode for testing
  - Updated release process documentation
  - Updated workflows README with tag creation details
  - Marked v1.4.0 retrospective action items as complete

- **Version Reference Automation (Phase 2)** - Script to automatically update version references across codebase during releases (PR #45)
  - Script: `scripts/update-version-references.sh`
  - Updates `.cursor/rules/main.mdc` (AI rules)
  - Updates `README.md` badges (if exist)
  - Updates `package.json` version (if exists)
  - Validation and error handling with rollback
  - Dry-run mode for safe previews
  - Comprehensive test suite (42 tests)
  - Documentation: `docs/VERSION-REFERENCES.md`
  - Integrated with `/release-finalize` command

### Changed

**Identity and Focus**

- **Template Factory Identity** - Formalized dev-infra's identity as a "template factory" with clear graduation criteria for template features (ADR-001, ADR-002, ADR-003, ADR-004)
  - Work classification (template features vs internal tooling vs CI/CD)
  - Graduation process for template features
  - Template integration criteria
  - Release Automation v2 Phase 3 deferred (template integration)
  - Updated Cursor rules and documentation
  - Implemented transition plan

### Documentation

- **Command Documentation** - Created command integration workflows
  - `/release-prep` - Streamlined release preparation
  - `/release-finalize` - Release finalization tasks
  - `/post-release` - Post-release documentation
  - `/address-review` - Address pre-phase review findings

- **Release Process** - Updated release process documentation
  - Tag creation now automated via GitHub Actions
  - Version reference updates automated via script
  - Release readiness tools integrated

### Security

- No security changes in this release.

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

### 1.6.0 (2025-12-15)

- **Experimental Project Template** - New template type for testing evolving commands
- CI drift detection with `validate-template-sync.sh`
- Stability indicators (🟢 Stable, 🟠 Evolving, 🔴 Deprecated)
- Generator script updated for 3 template types
- Test suite expanded to 110+ tests
- 8 cross-PR fix batches completed (28 issues)

### 1.5.0 (2025-12-12)

- **Release Automation v2 (Internal Only)** - Automated tag creation and version updates
- Phase 1: Automatic Tag Creation via GitHub Actions
- Phase 2: Version Reference Automation script
- Template Factory identity formalized (ADR-001 through ADR-004)

### 1.4.0 (2025-12-11)

- **Release Readiness System** - Complete release assessment and automation
- 3 new scripts for release validation, branch creation, and historical analysis
- 15+ new Cursor commands for workflow automation
- Template enhancements with CI/CD improvements
- Test suite expanded to 94+ tests (48 new tests)
- Command documentation maintenance system
- Comprehensive reflection and exploration workflows

### 1.3.0 (2025-11-18)

- **Multi-Environment Testing** - Automated CI/CD testing on Ubuntu + macOS
- Docker test images for consistent test environments
- 63 tests (expanded from 33)
- Comprehensive status documentation

### 1.2.0 (2025-11-12)

- **Directory Selection Feature** - Choose target directory for project generation
- Automated testing suite (33 tests)
- Project name validation improvements
- GitHub authentication verification
- Cross-platform compatibility fixes

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

**Last Updated:** 2025-12-11  
**Status:** ✅ Active  
**Next:** [Template Usage Guide](docs/TEMPLATE-USAGE.md)
