# Release Notes - v1.5.0

**Version:** v1.5.0  
**Release Date:** 2025-12-XX  
**Status:** 🔴 Draft - Needs Review

---

## 🎉 Highlights

v1.5.0 is an **internal-only release** focused on automating release workflows. This release delivers **Release Automation v2**, a two-phase enhancement that eliminates manual steps from the release process.

**Key improvements:**
- ⚡ **Automatic tag creation** when release PRs merge
- 🔄 **Automated version updates** across codebase
- ⏱️ **10-15 minutes saved per release**
- ✅ **42 new tests** for version automation

This release embodies dev-infra's identity as a **"template factory"** (ADR-001) - we build and refine internal tooling, then graduate proven features to templates when they're stable and ready.

---

## ✨ New Features

### Release Automation v2 (Internal Only)

**Phase 1: Automatic Tag Creation** (PR #44)

Release tags are now created automatically when release PRs merge to `main`. No more manual `git tag` commands!

**How it works:**
1. Merge release PR to `main`
2. GitHub Actions extracts version from branch name (`release/v1.5.0`)
3. Creates annotated tag with release message
4. Pushes tag to origin
5. Triggers release distribution workflow automatically

**Benefits:**
- Eliminates manual tag creation step
- Ensures consistent tag format
- Reduces human error
- Triggers distribution automatically

**Workflow:** `.github/workflows/create-release-tag.yml`

**Example:**
```yaml
# Automatic tag creation on release PR merge
on:
  pull_request:
    types: [closed]
    branches:
      - main

# Creates tag: v1.5.0
# Message: "Release v1.5.0\n\nSee CHANGELOG.md for full release details."
```

---

**Phase 2: Version Reference Automation** (PR #45)

Version numbers are now updated automatically across the codebase during releases. No more hunting for version strings!

**What it updates:**
- `.cursor/rules/main.mdc` - AI rules version
- `README.md` - Version badges (if exist)
- `package.json` - Package version (if exists)

**Features:**
- 🔍 Validates version formats (vX.Y.Z)
- 💾 Backup and restore on failure
- 🔄 Rollback if update fails
- 🧪 Dry-run mode for safe previews
- ✅ Post-update validation
- 📊 Color-coded output

**Script:** `scripts/update-version-references.sh`

**Example:**
```bash
# Update version references from v1.4.0 to v1.5.0
./scripts/update-version-references.sh --old-version v1.4.0 --new-version v1.5.0

# Dry-run to preview changes
./scripts/update-version-references.sh --old-version v1.4.0 --new-version v1.5.0 --dry-run

# Verbose output for debugging
./scripts/update-version-references.sh --old-version v1.4.0 --new-version v1.5.0 --verbose
```

**Test Coverage:** 42 comprehensive tests validating argument parsing, version validation, file updates, dry-run mode, and error handling.

---

## 🔧 Improvements

**Release Process**
- Tag creation now automated (eliminates manual step)
- Version updates now automated (eliminates manual find/replace)
- Release readiness tools integrated into workflow
- Process documentation updated with automation details

**Workflow Integration**
- `/release-finalize` command integrated with version update script
- GitHub Actions workflow for tag creation
- Automatic trigger of release distribution after tagging

**Documentation**
- Created `.github/workflows/README.md` hub
- Documented tag creation workflow
- Created `docs/VERSION-REFERENCES.md` guide
- Updated release process documentation
- Captured Phase 1 learnings

---

## 🏭 Template Factory Identity

This release reinforces dev-infra's identity as a **"template factory"** (ADR-001, ADR-002, ADR-003, ADR-004):

**What This Means:**
- Internal tooling stays internal (like Release Automation v2)
- Features must graduate before templatization
- Templates are products, not reflections of internal process
- Quality over quantity for template features

**Release Automation v2 Scope:**
- ✅ **Phase 1:** Tag Creation Automation (internal only)
- ✅ **Phase 2:** Version Reference Automation (internal only)
- ⏸️ **Phase 3:** Template Integration (deferred per ADR-002)

Phase 3 requires graduation criteria to be met before template integration. This ensures templates receive only stable, proven features.

---

## 📚 Documentation

- **Command Documentation:** Created `/release-prep`, `/release-finalize`, `/post-release`, `/address-review` commands
- **Workflow Documentation:** Created `.github/workflows/README.md` hub
- **Version References:** Created `docs/VERSION-REFERENCES.md` guide
- **Learning Capture:** Phase 1 learnings documented
- **Fix Tracking:** Deferred issues tracked (7 total: 2 from PR #44, 5 from PR #45)
- **Identity ADRs:** 4 ADRs documenting template factory identity and graduation process

---

## ⚠️ Breaking Changes

None in this release.

---

## 🔄 Migration Guide

No migration required. All changes are internal tooling enhancements.

**For Release Maintainers:**

Starting with v1.5.0, the release process includes automated steps:

1. **Tag Creation:** Automatic when release PR merges to main
   - No manual `git tag` needed
   - Workflow creates and pushes tag
   - Triggers distribution automatically

2. **Version Updates:** Run script during release finalization
   ```bash
   ./scripts/update-version-references.sh --old-version v1.4.0 --new-version v1.5.0
   ```
   - Updates AI rules, README badges, package.json
   - Use `--dry-run` to preview changes first
   - Integrated with `/release-finalize` command

---

## 📊 Statistics

| Metric | Value |
|--------|-------|
| PRs Merged | 2 |
| Commits | ~30 |
| Tests Added | 42 |
| Scripts Added | 1 |
| Workflows Added | 1 |
| Documentation Files | 5+ |
| ADRs Created | 4 |
| Time Saved per Release | 10-15 minutes |
| Manual Steps Eliminated | 2 |

---

## 🐛 Bug Fixes

- **package.json Update Bug** (PR #45, Sourcery #1) - Fixed grep check to use bare semver for package.json
- **Documentation Typo** (PR #45, Sourcery #6) - Fixed missing dot in `.cursor/rules/main.mdc` path

---

## 🔍 Known Issues & Deferred Items

**Deferred Issues (All MEDIUM priority):**

**From PR #44 (2 issues):**
- Manual dispatch workflow support
- Tag existence check before creation

**From PR #45 (5 issues):**
- Placeholder tests need full integration tests
- Test exit codes too permissive
- Missing rollback/restore tests
- Tests depend on real repo state
- Argument parser robustness

All deferred issues are documented in `admin/planning/features/release-automation-v2/fix/` and tracked for opportunistic handling.

---

## 🙏 Acknowledgments

Thanks to the dev-infra team for refining the release process and establishing clear identity principles!

Special recognition for the thoughtful ADR process that formalized our "template factory" identity.

---

## 🔗 Links

**Full Changelog:** [v1.4.0...v1.5.0](https://github.com/grimm00/dev-infra/compare/v1.4.0...v1.5.0)

**Related Documentation:**
- [Release Automation v2 Feature Plan](../../features/release-automation-v2/feature-plan.md)
- [Version References Guide](../../../docs/VERSION-REFERENCES.md)
- [Workflows README](../../../.github/workflows/README.md)
- [ADR-001: Project Identity](../../decisions/dev-infra-identity-and-focus/adr-001-project-identity.md)
- [ADR-002: Scope Decisions](../../decisions/dev-infra-identity-and-focus/adr-002-scope-decisions.md)

---

**Next Release:** v1.6.0 (Considerations: Experimental template, command branch workflow)

