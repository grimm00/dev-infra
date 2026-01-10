# CI/CD Planning Hub

**Purpose:** Central hub for all CI/CD related planning and documentation  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-12-30

---

## 🎯 Overview

This directory contains planning documentation for CI/CD improvements, workflows, and automation enhancements for dev-infra.

---

## 📋 Classification Guidelines

**When creating CI/CD work, use this guide to determine the appropriate structure:**

| Classification | Criteria | Structure | Example |
|----------------|----------|-----------|---------|
| **Fix** | < 1 hour effort | Single file or bundled with release | Template sync drift (PR #57) |
| | Single PR | Track in release notes | CI git configuration (PR #47) |
| | Resolves existing bug/failure | No dedicated hub needed | |
| | No new capability | | |
| **Improvement** | > 1 hour effort | Full hub directory | Multi-environment testing |
| | New capability added | Multiple phase files | Template generation automation |
| | May span multiple PRs | Transition plan | Release automation v2 |
| | Changes workflows | | |

**Key Principles:**
- **Quick fixes** can be bundled with major releases rather than getting separate PRs
- **Use `/transition-plan`** for structured CI improvements (validated in PR #57)
- **Three-phase pattern** works well for CI fixes: Analysis → Implementation → Verification
- **Document decisions** even for simple fixes to build organizational knowledge

**Reference:** [Template Sync Drift Fix](template-sync-drift-fix/) - Example of a well-documented CI fix using transition-plan workflow.

---

## 📊 Status Documentation

- **[Detailed Status Analysis](STATUS.md)** - Comprehensive analysis of all CI projects, completion status, and next steps

---

## 📋 Active CI Projects

### In Progress

- **[Release Distribution Workflow](release-distribution/README.md)** - Automated distribution package creation

### Active

- **[Command Documentation & Maintenance](command-documentation-maintenance/README.md)** - Track command documentation updates and improvements (✅ Active)

### Planned

- **[CI Structure Improvements](ci-structure-improvements/README.md)** - CI folder organization & classification guidance (🔴 Not Started, 🟡 Medium Priority) ⭐ **NEW**
  - Add fix vs improvement classification
  - Consider bundling with major release
  - Input for broader project restructure

- **[GitHub Release Automation](github-release-automation/README.md)** - Auto-create GitHub Releases from tags (🔴 Not Started, 🔴 High Priority)
  - Discovered in v0.5.0 release
  - Eliminates manual `gh release create` step
  - Effort: LOW (30 minutes)

### Completed

- **[Template Sync Drift Fix](template-sync-drift-fix/README.md)** - Fix template sync drift causing CI failures (✅ Complete - 2025-12-30, PR #57)
  - Synced `status.md` between templates (learning-project → standard-project)
  - Root cause: extra trailing blank line in standard-project version
  - Effort: ~30 min (as estimated)

- **[CI Git Configuration](ci-git-configuration/README.md)** - Configure git identity in CI workflows (✅ Complete - 2025-12-12, PR #47)
  - Added git config to `release-distribution.yml` workflow
  - Ensures git-related tests pass consistently in CI
  - Completed: Phase 1 (identify workflows, update configs, verify)

### Previously Completed

- **➡️ See [Release Automation v2](../features/release-automation-v2/README.md)** - Consolidated release automation improvements (✅ Complete - v0.5.0)
  - Phase 1: Tag Creation Automation ✅
  - Phase 2: Version Reference Automation ✅
  - Phase 3: Template Integration (deferred per ADR-002)

- **[Template Generation Testing Automation](template-generation-testing-automation/README.md)** - Automate template generation testing (✅ Complete - 2025-12-08)
  - Phase 1 complete: Non-interactive mode added (PR #27)
  - Phase 2 complete: Template validation test suite (PR #29)
  - Fixes: PR #28, PR #30
- **[CI/CD Failure Investigation](ci-cd-failure-investigation/README.md)** - Investigate PR #30 CI/CD failures (🔴 Not Started, 🔴 High Priority)
- **[Test Suite Maintenance](test-suite-maintenance/improvement-plan.md)** - Centralize test setup/teardown (🔴 Not Started, 🟡 Medium Priority)
- **[Command Testing Automation](command-testing-automation/README.md)** - Automated testing for cursor commands (🔴 Not Started)
- **[Documentation Validation](documentation-validation/README.md)** - Documentation validation process for docs-only PRs (🔴 Not Started)
- **[CI/CD Improvement Process Enhancements](cicd-improvement-process-enhancements/README.md)** - Enhance CI/CD improvement process based on learnings (🔴 Not Started)

### Completed

- **[Status Tracking Automation](status-tracking-automation/README.md)** - Improved status tracking process ✅ (PR #22, merged 2025-12-08)
- CI/CD optimization and caching
- Security scanning automation

### Completed

- **[Multi-Environment Testing](multi-environment-testing/README.md)** - Automated testing across Ubuntu and macOS ✅ (PR #17, merged 2025-11-18)

---

## 📚 CI/CD Resources

- **[GitHub Actions Documentation](https://docs.github.com/en/actions)**
- **[Our CI/CD Best Practices](../../.cursor/rules/main.mdc)**
- **[Workflow Templates](../../../.github/workflows/)**

---

**Last Updated:** 2025-12-30  
**Status:** 🟠 Active Development
