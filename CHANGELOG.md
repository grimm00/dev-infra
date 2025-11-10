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
