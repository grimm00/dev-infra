# CHANGELOG Draft - v1.6.0

**Draft Created:** 2025-12-15  
**Status:** 🔴 Draft - Needs Review

---

## [1.6.0] - 2025-12-XX

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

---

## PRs Included (since v1.5.0)

| PR | Title | Merged |
|----|-------|--------|
| #52 | fix: Quick Wins Rounds 2 & 3 | 2025-12-15 |
| #51 | fix: Test Assertion Improvements - MEDIUM Effort | 2025-12-15 |
| #50 | fix: Test Assertion Improvements | 2025-12-15 |
| #49 | feat: Add CI Drift Detection (Phase 3) | 2025-12-15 |
| #48 | feat: Update Generator Script for Experimental Template (Phase 2) | 2025-12-15 |
| #47 | ci: Configure Git Identity in CI Workflows | 2025-12-12 |

---

## Note: v1.5.0 CHANGELOG

⚠️ The v1.5.0 CHANGELOG entries were updated on the release branch but not merged back to develop. These entries should be included when merging this release.

**v1.5.0 Features (already released 2025-12-12):**
- Release Automation v2 (Internal Only)
  - Phase 1: Automatic Tag Creation
  - Phase 2: Version Reference Automation

---

## Review Checklist

- [ ] All PRs listed
- [ ] Categorization correct (Added/Fixed/Changed/CI)
- [ ] Descriptions accurate
- [ ] Breaking changes noted (none in this release)
- [ ] v1.5.0 entries included
- [ ] Ready to merge into CHANGELOG.md

