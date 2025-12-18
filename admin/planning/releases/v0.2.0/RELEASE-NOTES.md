# Release Notes - v0.2.0

**Release Date:** 2025-11-12  
**Release Type:** Minor Release  
**Repository:** https://github.com/grimm00/dev-infra

---

## 🎉 Directory Selection & Automated Testing

This release introduces directory selection for project generation, critical cross-platform compatibility fixes, and comprehensive automated testing. Users can now organize projects in their preferred directory structure, and the script works reliably across all Unix-like systems.

---

## ✨ What's New

### 📁 Directory Selection Feature

Choose where your projects are generated! No more navigating to directories before running the script.

**Key Features:**
- **Default Directory** - Automatically uses `$HOME/Projects/` if it exists
- **Custom Paths** - Support for absolute paths, relative paths, and environment variables
- **Environment Variable Expansion** - Use `$HOME`, `$USER`, `$PWD`, or `~` in paths
- **Smart Validation** - Comprehensive checks for directory existence, permissions, and writability
- **Helpful Prompts** - Clear error messages and automatic directory creation prompts
- **Backward Compatible** - Falls back to current directory if default doesn't exist

**Example Usage:**
```bash
# Use default ($HOME/Projects/)
./scripts/new-project.sh
# Press Enter at directory prompt

# Use custom path
./scripts/new-project.sh
# Enter: /Users/username/Projects/custom-location

# Use environment variable
./scripts/new-project.sh
# Enter: $HOME/Projects/my-projects
```

### 🧪 Automated Testing Suite

Comprehensive BATS test suite with 33 tests covering all key functionality.

**Test Coverage:**
- ✅ 24 unit tests for core functions
- ✅ 4 integration tests for path resolution
- ✅ 3 regression tests verifying critical fixes
- ✅ 2 backward compatibility tests
- ✅ All tests passing

**Benefits:**
- Ensures reliability across platforms
- Catches regressions early
- Validates edge cases automatically
- Fast execution (< 5 seconds)

---

## 🐛 Critical Fixes

### Cross-Platform Compatibility (macOS/BSD)

**Issue:** Script failed silently on macOS/BSD systems due to GNU-specific `sed` syntax.

**Fix:** Replaced `sed` with bash parameter expansion for whitespace sanitization.

**Impact:** Script now works correctly on all Unix-like systems (Linux, macOS, BSD).

### Root Directory Handling

**Issue:** Root directory `/` was converted to empty string, causing validation failures.

**Fix:** Added root directory check to preserve `/` during path normalization.

**Impact:** Users can now use root directory as target (edge case, but properly handled).

### Error Handling Improvements

**Issue:** Fragile `set -e` toggling made error handling complex and error-prone.

**Fix:** Refactored to remove `set -e` toggles from functions, isolating error handling in caller.

**Impact:** Cleaner, more maintainable code with better error isolation.

---

## 🔧 Improvements

### Project Name Validation

- **Clear Error Messages** - Users now see helpful messages when project names are invalid
- **Automatic Sanitization** - Option to automatically replace spaces with dashes
- **Better UX** - No more silent reprompts without explanation

### GitHub Integration

- **Authentication Verification** - Checks GitHub CLI authentication before repo creation
- **Account Matching** - Verifies authenticated user matches author name
- **Multiple Account Support** - Handles machines with multiple GitHub accounts

### Path Handling

- **Environment Variable Expansion** - Full support for `$HOME`, `$USER`, `$PWD`, `${VAR}` syntax
- **Tilde Expansion** - Support for `~` in paths
- **Path Normalization** - Consistent handling of trailing slashes and relative paths
- **Comprehensive Validation** - Checks for existence, permissions, and writability

---

## 📦 Distribution Packages

**Available Downloads:**

- `dev-infra-0.2.0.tar.gz` - Clean distribution (Linux/Mac)
- `dev-infra-0.2.0.tar.gz.sha256` - Checksum
- `dev-infra-0.2.0.zip` - Clean distribution (Windows)
- `dev-infra-0.2.0.zip.sha256` - Checksum
- `Source code (zip)` - Full source with internal files
- `Source code (tar.gz)` - Full source with internal files

**Package Contents:**

- ✅ `templates/` - Project templates
- ✅ `scripts/` - Generator and validation tools (with directory selection)
- ✅ `docs/` - User documentation
- ✅ `tests/` - Automated test suite
- ✅ Essential files (README, CHANGELOG, CONTRIBUTING)

---

## 🚀 Quick Start

### Download Distribution Package

```bash
# Download clean package (Linux/Mac)
curl -L https://github.com/grimm00/dev-infra/releases/download/v0.2.0/dev-infra-0.2.0.tar.gz | tar -xz
cd dev-infra-0.2.0

# Or download for Windows
curl -L https://github.com/grimm00/dev-infra/releases/download/v0.2.0/dev-infra-0.2.0.zip -o dev-infra.zip
```

### Create Your Project

```bash
# Generate new project (with directory selection)
./scripts/new-project.sh

# Choose target directory when prompted
# Or press Enter to use default ($HOME/Projects/)
```

### Run Tests

```bash
# Run automated test suite
cd tests
bats new-project.bats
```

---

## 📊 What Changed

### Added
- Directory selection feature with default directory support
- Environment variable expansion in paths (`$HOME`, `$USER`, `$PWD`, `~`)
- Comprehensive path validation and error handling
- Automated testing suite (33 tests)
- Project name validation improvements (space-to-dash replacement)
- GitHub authentication verification
- Test infrastructure and documentation

### Fixed
- Cross-platform compatibility (macOS/BSD sed issue)
- Root directory handling bug
- Silent failure for non-existent paths
- Error handling refactoring (set -e toggling)
- Project name validation UX improvements

### Improved
- Path resolution and normalization
- Error messages and user feedback
- Code maintainability and error isolation
- Test coverage and reliability

---

## 🔄 Migration Guide

### For Existing Users

**No breaking changes!** The script is fully backward compatible.

- Default behavior preserved (falls back to current directory)
- Existing workflows continue to work
- Directory selection is optional - you can still use current directory

### New Features to Try

1. **Use Default Directory:**
   ```bash
   # Create $HOME/Projects/ if it doesn't exist
   # Then run script and press Enter at directory prompt
   ```

2. **Custom Directory:**
   ```bash
   # Run script and enter custom path when prompted
   # Supports: absolute paths, relative paths, env vars, ~
   ```

3. **Run Tests:**
   ```bash
   # Verify everything works
   cd tests && bats new-project.bats
   ```

---

## 🧪 Testing

### Automated Tests

- **33 tests** covering all key functionality
- **All passing** on Linux, macOS, and BSD
- **Fast execution** (< 5 seconds)
- **Comprehensive coverage** of edge cases and regressions

### Manual Testing

- ✅ Directory selection with various path types
- ✅ Default directory behavior
- ✅ Error handling and validation
- ✅ Backward compatibility
- ✅ Cross-platform compatibility

---

## 📚 Documentation

### New Documentation

- **Automated Testing Guide** - `tests/README.md`
- **Test Results** - `admin/planning/features/directory-selection/testing/automated/test-results.md`
- **Deferred Tasks Backlog** - `admin/feedback/deferred-tasks.md`
- **PR Feedback Documentation** - Complete review documentation for PRs #4, #5, #6

### Updated Documentation

- **Feature Documentation** - Complete directory selection feature docs
- **Release Process** - Enhanced with testing requirements
- **Implementation Plans** - Detailed fix documentation

---

## 🙏 Acknowledgments

This release includes fixes and improvements based on feedback from:
- **Sourcery AI** - Code quality and maintainability suggestions
- **Bugbot** - Critical bug detection and analysis
- **Manual Testing** - User experience improvements

---

## 🔮 What's Next

### Planned for Future Releases

- Additional automated test coverage
- CI/CD integration for automated tests
- More path validation edge cases
- Enhanced GitHub integration features

See [Deferred Tasks Backlog](admin/feedback/deferred-tasks.md) for complete list of planned improvements.

---

## 📝 Full Changelog

See [CHANGELOG.md](../../CHANGELOG.md) for complete list of changes.

---

**Download:** [v0.2.0 Release](https://github.com/grimm00/dev-infra/releases/tag/v0.2.0)  
**Documentation:** [README.md](../../README.md)  
**Integration Guide:** [docs/integration/](docs/integration/)

---

**Last Updated:** 2025-11-12  
**Status:** ✅ Ready for Release

