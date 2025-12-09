# Standard Release Readiness Criteria

**Purpose:** Define standardized criteria for release readiness assessment  
**Status:** ✅ Active  
**Created:** 2025-12-08  
**Last Updated:** 2025-12-08

---

## 📋 Overview

This document defines the standardized criteria used to assess release readiness for dev-infra. These criteria ensure consistency, quality, and reliability across all releases.

**Release Types:**
- **Major (X.0.0):** All criteria apply. Breaking changes allowed but must be documented.
- **Minor (0.X.0):** All criteria apply. Backward compatibility required.
- **Patch (0.0.X):** Focus on testing, fixes, and documentation. No new features required.

---

## 🧪 Testing & Quality (Blocking)

**Goal:** Ensure the release is stable and reliable.

| Criterion | Description | Blocking? | How to Assess |
|-----------|-------------|-----------|---------------|
| **All Tests Passing** | All automated CI/CD tests must pass on all supported platforms. | ✅ **YES** | Check GitHub Actions workflow status. All jobs must be green. |
| **Test Coverage Maintained** | Test coverage should not decrease significantly. New features must have tests. | ✅ **YES** | Verify new code includes tests. Check coverage report if available. |
| **Manual Testing Completed** | For features not fully covered by automation (e.g., CLI interactivity), manual testing must be performed and documented. | ✅ **YES** | perform manual validation steps and document in PR or release assessment. |
| **Cross-Platform Compatibility** | Functionality must work on all supported OSs (Ubuntu, macOS). | ✅ **YES** | Verify CI jobs for `ubuntu-latest` and `macos-latest` are passing. |

---

## 📚 Documentation (Blocking)

**Goal:** Ensure users and maintainers have accurate information.

| Criterion | Description | Blocking? | How to Assess |
|-----------|-------------|-----------|---------------|
| **Documentation Complete** | All new features and changes must be documented in `docs/` or READMEs. | ✅ **YES** | Review `docs/` changes in PRs. Ensure no undocumented features. |
| **CHANGELOG Updated** | `CHANGELOG.md` must include a section for the new version with all notable changes. | ✅ **YES** | Check `CHANGELOG.md` for the new version header and entries. |
| **Release Notes Created** | A dedicated `RELEASE-NOTES.md` file must exist for the release. | ✅ **YES** | Verify file existence in `admin/planning/releases/vX.Y.Z/`. |
| **Documentation Links Valid** | No broken links in documentation. | ✅ **YES** | Run link validation tests or manual check. |

---

## 🛠️ Code Quality (Blocking)

**Goal:** Maintain codebase health and maintainability.

| Criterion | Description | Blocking? | How to Assess |
|-----------|-------------|-----------|---------------|
| **Critical Bugs Fixed** | No known critical bugs (causing crash, data loss, or blocking core workflows) remain. | ✅ **YES** | Check issue tracker and Known Issues registry. |
| **No Blocking Issues** | No open issues marked as "Blocking" for this release. | ✅ **YES** | Review project board / issue tracker. |
| **Code Review Completed** | All changes have passed code review (internal or external/Sourcery). | ✅ **YES** | Verify all merged PRs have approvals. |

---

## 📦 Release Preparation (Blocking)

**Goal:** Ensure release artifacts and processes are ready.

| Criterion | Description | Blocking? | How to Assess |
|-----------|-------------|-----------|---------------|
| **Version Numbers Updated** | Version string in code/scripts must match release version. | ✅ **YES** | Grep for version strings. |
| **Release Branch Created** | A `release/vX.Y.Z` branch exists. | ✅ **YES** | Check git branches. |
| **External Review Completed** | If required (e.g., major release), final external review is done. | ⚠️ **Conditional** | Check release checklist. |

---

## 🔄 Compatibility (Conditional)

**Goal:** Prevent unexpected breakage for users.

| Criterion | Description | Blocking? | How to Assess |
|-----------|-------------|-----------|---------------|
| **Backward Compatibility** | Existing functionality works as expected. No breaking changes for Minor/Patch. | ✅ **YES** (Minor/Patch) | Review changes for breaking modifications. Run regression tests. |
| **Breaking Changes Documented** | If Major release, all breaking changes are clearly documented in Upgrade Guide. | ✅ **YES** (Major) | Check release notes and migration guide. |

---

## ✨ Significant New Functionality (Informational)

**Goal:** justify the release value.

| Criterion | Description | Blocking? | How to Assess |
|-----------|-------------|-----------|---------------|
| **New Features Added** | Release includes valuable new capabilities. | ❌ **NO** | Review feature list. Important for Minor/Major releases. |

---

## 📝 Assessment Definitions

- **Blocking:** The release CANNOT proceed until this criterion is met. Exceptions require explicit sign-off from maintainers.
- **Conditional:** Blocking under specific circumstances (e.g., release type).
- **Informational:** Good to have or tracked for info, but does not stop the release.

---

**Last Updated:** 2025-12-08

