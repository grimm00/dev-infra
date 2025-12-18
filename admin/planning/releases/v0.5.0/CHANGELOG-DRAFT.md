# CHANGELOG Draft - v0.5.0

**Draft Created:** 2025-12-12  
**Status:** 🔴 Draft - Needs Review

---

## [0.5.0] - 2025-12-XX

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
  - Marked v0.4.0 retrospective action items as complete

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

## PRs Included

| PR | Title | Merged |
|----|-------|--------|
| #45 | feat: Version Reference Automation (Phase 2) | 2025-12-12 |
| #44 | feat: automate release tag creation (Phase 1) | 2025-12-11 |

---

## Statistics

**Development Activity:**
- PRs Merged: 2
- Commits: ~30 (feature + docs)
- Tests Added: 42 (Phase 2)
- Scripts Added: 1 (update-version-references.sh)
- Workflows Added: 1 (create-release-tag.yml)
- Documentation Files: 5+ (including learnings, fix tracking)

**Impact:**
- Release process: 2 manual steps automated
- Tag creation: Now automatic on PR merge
- Version updates: Now automatic via script
- Time saved per release: ~10-15 minutes

---

## Review Checklist

- [ ] All PRs listed (Phase 1 & 2)
- [ ] Categorization correct (Added/Changed/Documentation)
- [ ] Descriptions accurate
- [ ] Breaking changes noted (none)
- [ ] Statistics complete
- [ ] Internal-only scope noted
- [ ] Ready to merge into CHANGELOG.md

---

**Notes:**

- This is an internal-only release (Phase 3 deferred)
- Focus on automation and efficiency
- No template changes in this release
- Phase 3 (Template Integration) deferred per ADR-002

