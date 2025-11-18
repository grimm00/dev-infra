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

