# Release Notes - v0.3.0

**Release Date:** 2025-11-18  
**Release Type:** Minor Release  
**Repository:** https://github.com/grimm00/dev-infra

---

## 🎉 Multi-Environment Testing & CI/CD Improvements

This release introduces comprehensive automated testing across Ubuntu and macOS, Docker-based test environments for consistency, and significant improvements to CI/CD infrastructure. All tests now run automatically on every PR, ensuring cross-platform compatibility and code quality.

---

## ✨ What's New

### 🧪 Multi-Environment Testing Workflow

Automated CI/CD testing that runs on every pull request and push, ensuring your code works across platforms.

**Key Features:**
- **Automated Testing** - Tests run automatically on every PR and push
- **Multi-Platform Validation** - Tests run on both Ubuntu and macOS
- **Fast Feedback** - Quick checks run in ~15 seconds with Docker
- **Smart Filtering** - Skips tests for docs/admin-only changes
- **Draft PR Support** - Full tests only run when PR is ready for review
- **Release Integration** - Tests must pass before release distribution
- **Comprehensive Coverage** - All 63 tests passing (1 skipped - interactive smoke test)

**Benefits:**
- Catch cross-platform issues before merge
- Ensure code quality automatically
- Fast developer feedback
- Prevents regressions
- Professional CI/CD pipeline

### 🐳 Docker Test Images

Custom Docker images for consistent, fast test execution on Ubuntu.

**Key Features:**
- **Pre-Built Images** - BATS, git, bash, and all required tools pre-installed
- **Consistent Environment** - Same tool versions across all runs
- **Faster Execution** - ~15 seconds faster per run (no installation time)
- **Reproducible** - Tagged images for known-good versions
- **Self-Contained** - Workflow builds image before tests run

**Image Tags:**
- `latest` - Current image (updated after successful test runs)
- `stable` - Last verified working image
- `verified-{sha}` - Specific commit's verified image
- `{branch}-{sha}` - Branch-specific commit image

**Benefits:**
- Consistent test results
- Faster CI execution
- Reproducible test environments
- Easy debugging with tagged images

### 📊 Comprehensive Status Documentation

Complete status tracking and analysis for all CI and feature projects.

**Key Features:**
- **Executive Summary** - Quick status overview table
- **Detailed Analysis** - CI projects and features status
- **Discrepancy Tracking** - Identifies and documents status conflicts
- **Implementation Verification** - Git history-based verification
- **Actionable Recommendations** - Clear next steps for resolution

**Benefits:**
- Clear visibility into project status
- Easy identification of incomplete work
- Historical documentation of decisions
- Better project management

---

## 🔧 Improvements

### Test Workflow Structure

- **Better Organization** - Split full-tests matrix into separate jobs (full-tests-ubuntu, full-tests-macos)
- **Clearer Separation** - Each platform has its own job for better clarity
- **Improved Error Messages** - More specific error reporting per platform

### Docker Image Tagging

- **Simplified Tagging** - Replaced complex docker/metadata-action with reliable shell script
- **Reproducible Tags** - Always tag with commit SHA for exact version tracking
- **Branch Support** - Branch-specific tags for feature branches
- **Latest Tagging** - Automatic latest tag for main/develop branches

---

## 🐛 Critical Fixes

### Workflow YAML Syntax Errors

**Issue:** Invalid YAML syntax in workflow files causing validation failures.

**Fixes:**
- Fixed `container: null` issue in test.yml (split into separate jobs)
- Fixed invalid Docker tag format in build-test-image.yml
- Added concurrency control to build-test-image.yml
- Added timeout to build-test-image.yml

**Impact:** Workflows now validate correctly and run reliably.

### Test Failures in Docker Containers

**Issue:** Multiple test failures in Docker container environment.

**Fixes:**
- **Git Operations** - Added git config setup in test helpers
- **Template Operations** - Aligned test helpers with actual script behavior
- **Directory Validation** - Improved container environment handling
- **Path Resolution** - Fixed PROJECT_ROOT calculation in test helpers

**Impact:** All 63 tests now passing consistently in both Docker and native environments.

### Prompt Non-Interactive Detection

**Issue:** `prompt_yes_no` function hanging in CI environments.

**Fix:** Improved CI environment detection with multiple fallbacks:
- GITHUB_ACTIONS environment variable check
- NON_INTERACTIVE explicit flag support
- Improved detection logic priority
- Better terminal detection

**Impact:** Script works correctly in all environments (interactive, CI, automated tests).

---

## 🔒 Security & Reliability

### Workflow Reliability Improvements

- **Error Handling** - Added `|| exit 1` to all critical commands
- **Verification Steps** - Verify installations after completion
- **Concurrency Control** - Prevent duplicate runs and conflicts
- **Timeout Limits** - Prevent hung workflows from running indefinitely

**Impact:** More reliable CI/CD pipeline with better error detection and recovery.

---

## 📦 Distribution Packages

**Available Downloads:**

- `dev-infra-0.3.0.tar.gz` - Clean distribution (Linux/Mac)
- `dev-infra-0.3.0.tar.gz.sha256` - Checksum
- `dev-infra-0.3.0.zip` - Clean distribution (Windows)
- `dev-infra-0.3.0.zip.sha256` - Checksum
- `Source code (zip)` - Full source with internal files
- `Source code (tar.gz)` - Full source with internal files

**Package Contents:**

- ✅ `templates/` - Project templates
- ✅ `scripts/` - Generator and validation tools
- ✅ `docs/` - User documentation
- ✅ `tests/` - Automated test suite (63 tests)
- ✅ Essential files (README, CHANGELOG, CONTRIBUTING)

**Enhanced Distribution:**

- ✅ Release changelog automatically merged from release folder
- ✅ Admin changelog merged for transparency
- ✅ Validated package structure
- ✅ SHA256 checksums for security

---

## 🚀 Quick Start

### Download Distribution Package

```bash
# Download clean package (Linux/Mac)
curl -L https://github.com/grimm00/dev-infra/releases/download/v0.3.0/dev-infra-0.3.0.tar.gz | tar -xz
cd dev-infra-0.3.0

# Or download for Windows
curl -L https://github.com/grimm00/dev-infra/releases/download/v0.3.0/dev-infra-0.3.0.zip -o dev-infra.zip

# Verify checksum (Linux/Mac)
curl -L https://github.com/grimm00/dev-infra/releases/download/v0.3.0/dev-infra-0.3.0.tar.gz.sha256 -o dev-infra-0.3.0.tar.gz.sha256
sha256sum -c dev-infra-0.3.0.tar.gz.sha256
```

### Create Your Project

```bash
# Generate new project
./scripts/new-project.sh

# Choose target directory when prompted
# Or press Enter to use default ($HOME/Projects/)
```

### Run Tests Locally

```bash
# Install BATS (if not already installed)
# Ubuntu/Debian:
sudo apt-get install bats

# macOS:
brew install bats-core

# Run all tests
bats --recursive tests/

# Or run specific test suites
bats tests/unit/
bats tests/integration/
```

---

## 📊 What Changed

### Added
- Multi-environment testing workflow (Ubuntu + macOS)
- Docker test images for consistent Ubuntu environment
- Image tagging strategy (latest, stable, verified-{sha})
- Comprehensive status documentation
- Release changelog merge from release folders
- Concurrency control and timeout limits
- Path filtering and draft PR filtering

### Changed
- Test workflow structure (split into separate jobs)
- Docker image tagging (simplified and more reliable)
- Workflow organization and error handling

### Fixed
- Workflow YAML syntax errors
- Git operations test failures in containers
- Template operations test alignment
- Directory validation test robustness
- Prompt non-interactive detection
- Docker tag format issues

### Security
- Improved workflow error handling
- Enhanced verification steps
- Better concurrency control
- Timeout limits for reliability

---

## 🔄 Migration Guide

### For Existing Users

**No breaking changes!** All existing functionality preserved.

- Script behavior unchanged
- Templates unchanged
- Existing workflows continue to work
- All improvements are additive

### New CI/CD Features

If you're using dev-infra templates in your projects, you can now benefit from:

1. **Automated Testing** - Tests run automatically on PRs
2. **Cross-Platform Validation** - Ensures compatibility
3. **Fast Feedback** - Quick checks for rapid iteration

### For Contributors

- Tests now run automatically on all PRs
- Both Ubuntu and macOS environments tested
- Docker images available for local testing
- Status documentation for project visibility

---

## 🧪 Testing

### Automated Tests

- **63 tests** covering all key functionality
- **All passing** on Ubuntu (Docker) and macOS
- **Fast execution** (~15 seconds for quick checks)
- **Comprehensive coverage** of edge cases and regressions

### Test Infrastructure

- **BATS Framework** - Bash Automated Testing System
- **Docker Images** - Consistent Ubuntu test environment
- **Multi-Platform** - Ubuntu and macOS validation
- **CI/CD Integration** - Automatic testing on PRs

---

## 📚 Documentation

### New Documentation

- **Multi-Environment Testing Workflow** - `admin/planning/ci/multi-environment-testing/`
- **Status Documentation** - `admin/planning/status-report.md`, `ci/STATUS.md`, `features/STATUS.md`
- **Docker Images Research** - `admin/research/ci-cd-workflow-improvements/ghcr-docker-images.md`
- **Fix Documentation** - Comprehensive fix documentation for all issues resolved

### Updated Documentation

- **CI Planning Hub** - Updated with multi-environment testing completion
- **Features Planning Hub** - Updated with status tracking
- **Release Process** - Enhanced with changelog merge from release folders
- **Workflow Documentation** - Complete workflow specifications

---

## 🙏 Acknowledgments

This release includes improvements based on:

- **GitHub Actions** - CI/CD platform and workflow execution
- **Docker** - Container platform for consistent environments
- **BATS** - Bash Automated Testing System
- **Community Feedback** - Testing and validation improvements

---

## 🔮 What's Next

### Planned for Future Releases

- Windows support for multi-environment testing
- Additional test coverage
- Performance optimizations
- Enhanced Docker image features
- More CI/CD workflow improvements

See [Status Documentation](admin/planning/status-report.md) for complete project status and planned work.

---

## 📝 Full Changelog

See [CHANGELOG.md](../../../CHANGELOG.md) for complete list of changes.

---

**Download:** [v0.3.0 Release](https://github.com/grimm00/dev-infra/releases/tag/v0.3.0)  
**Documentation:** [README.md](../../../README.md)  
**Integration Guide:** [docs/integration/](../../../docs/integration/)  
**CI/CD Documentation:** [admin/planning/ci/](../../../admin/planning/ci/)

---

**Last Updated:** 2025-11-18  
**Status:** ✅ Ready for Release

