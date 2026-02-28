# Release Process

**Purpose:** Standardized release process for dev-infra  
**Status:** ✅ Active  
**Last Updated:** 2025-12-11

---

## 🎯 Overview

This document defines the standardized release process for dev-infra, ensuring consistent, professional releases while avoiding the feature+release conflation that occurred in v0.1.0.

### Key Principles
1. **Separation of Concerns** - Features developed separately from release preparation
2. **External Reviews** - All release branches require external review
3. **Documentation** - Complete documentation of review decisions
4. **Quality Assurance** - Validation and testing at each stage

---

## 📋 Standard Release Process (v0.1.1+)

### Phase 1: Feature Development (on develop)

**Goal:** Build up features over time on develop branch

**Process:**
1. Create feature branches from `develop`
2. Develop and test features
3. Create PR from feature branch to `develop`
4. External review (Sourcery, etc.)
5. Merge feature to `develop` after approval
6. Repeat for multiple features

**Example:**
```bash
# Create feature branch
git checkout develop
git pull origin develop
git checkout -b feat/new-template-type

# Develop feature
# ... make changes ...

# Create PR for review
git push origin feat/new-template-type
gh pr create --base develop --head feat/new-template-type --title "feat: Add CLI template type"

# After review and approval, merge to develop
git checkout develop
git merge --no-ff feat/new-template-type
git push origin develop
```

### Phase 2: Release Preparation (on release/vX.Y.Z)

**Goal:** Prepare release with minimal, focused changes

**Process:**
1. Create release branch from `develop`
2. **Only** make release-specific changes:
   - Update CHANGELOG version
   - Update version numbers in files
   - Create release notes
   - Fix critical bugs found in testing
   - Update documentation for release
3. **Do not** add new features on release branch
4. Keep release branch focused and minimal

**Example:**
```bash
# Create release branch
git checkout develop
git pull origin develop
git checkout -b release/v0.1.1

# Make ONLY release-specific changes
# - Update CHANGELOG.md version
# - Update README.md version
# - Create release notes
# - Fix critical bugs only

# Commit release changes
git add .
git commit -m "docs: Prepare v0.1.1 release

- Update CHANGELOG from 0.1.0 to 0.1.1
- Update version numbers in documentation
- Create release notes
- Fix critical bug in template validation"
```

### Phase 3: Release Finalization

**Goal:** Complete external review and finalize release

**Process:**
1. Create PR from release branch to `main`
2. External reviews (Sourcery, etc.)
3. Document review in `admin/feedback/`
4. Address critical feedback only
5. Defer non-critical items to next release

**Example:**
```bash
# Push release branch
git push origin release/v0.1.1

# Create PR for review
gh pr create --base main --head release/v0.1.1 --title "Release v0.1.1: New template types and improvements"

# Document review in admin/feedback/sourcery/pr02.md
# Address only critical feedback
# Defer medium/low priority items to v0.2.0
```

### Phase 4: Release Merge

**Goal:** Complete release following Git Flow

**Process:**
1. Merge release branch to `main` (via PR merge)
2. **Tag created automatically** - GitHub Actions workflow creates and pushes tag
3. GitHub release published automatically (triggered by tag)
4. Merge release branch back to `develop`
5. Delete release branch

**Note:** As of v0.5.0, tag creation is automated via `.github/workflows/create-release-tag.yml`. When a release PR is merged to `main`, the workflow automatically:
1. Extracts the version from the branch name (`release/vX.Y.Z`)
2. Creates and pushes an annotated tag
3. Creates a GitHub Release (uses curated `RELEASE-NOTES.md` when available, falls back to auto-generated notes)
4. Triggers the release distribution workflow (builds packages, uploads assets)

**Example:**
```bash
# Merge release PR to main (via GitHub UI or CLI)
# After PR merge, the workflow automatically:
# 1. Extracts version from branch (release/v0.1.1 → v0.1.1)
# 2. Creates annotated tag: git tag -a v0.1.1 -m "Release v0.1.1..."
# 3. Pushes tag: git push origin v0.1.1
# 4. Triggers release-distribution workflow

# If manual tag/release creation needed (fallback):
git checkout main
git pull origin main
git tag -a v0.1.1 -m "Release v0.1.1: New template types and improvements"
git push origin v0.1.1
gh release create v0.1.1 \
  --title "Release v0.1.1" \
  --notes-file admin/planning/releases/v0.1.1/RELEASE-NOTES.md

# Merge back to develop
git checkout develop
git pull origin develop
git merge --no-ff release/v0.1.1 -m "Merge release v0.1.1 back to develop"
git push origin develop

# Clean up
git branch -d release/v0.1.1
git push origin --delete release/v0.1.1
```

### Phase 5: Automated Distribution (GitHub Actions)

**Goal:** Automatically create and distribute clean release packages

**Automatic Process:**

When you create a GitHub release:
1. GitHub Action triggers automatically
2. Creates clean distribution package (excludes admin/, .cursor/, start.txt)
3. Validates package structure
4. Generates SHA256 checksums
5. Uploads both `.tar.gz` and `.zip` to release assets
6. Available within minutes of publishing release

**Available Downloads:**
- `dev-infra-X.Y.Z.tar.gz` - Clean distribution (Linux/Mac)
- `dev-infra-X.Y.Z.tar.gz.sha256` - Checksum
- `dev-infra-X.Y.Z.zip` - Clean distribution (Windows)
- `dev-infra-X.Y.Z.zip.sha256` - Checksum
- `Source code (zip)` - Full source with internal files
- `Source code (tar.gz)` - Full source with internal files

**No Manual Steps Required!**

The workflow automatically:
- Excludes internal development files
- Includes only user-facing content
- Validates package structure
- Generates security checksums
- Uploads to GitHub release

---

## ⚠️ Special Cases

### Initial Release (v0.1.0)

**What Happened:**
- All features created during release prep (no prior develop history)
- Release branch contained all templates + release prep
- This was a special case for initial setup

**Documentation:**
- Documented as special case in release notes
- Established process for future releases
- Created this process document

### Hotfix Releases (v1.0.1, v1.1.1)

**Process:**
1. Create hotfix branch from `main`
2. Fix critical bug only
3. Update version and changelog
4. Create PR to `main`
5. External review
6. Merge to `main` and tag
7. Merge back to `develop`

**Example:**
```bash
# Create hotfix branch
git checkout main
git pull origin main
git checkout -b hotfix/v1.0.1

# Fix critical bug only
# ... make minimal fix ...

# Update version
# ... update CHANGELOG.md ...

# Create PR and merge
git push origin hotfix/v1.0.1
gh pr create --base main --head hotfix/v1.0.1 --title "hotfix: Fix critical template validation bug"
```

---

## 📋 Release Checklist Template

### Pre-Release (Feature Development)
- [ ] Features developed on feature branches
- [ ] Features reviewed and merged to develop
- [ ] Features tested and validated
- [ ] Documentation updated for new features

### Release Preparation
- [ ] Create release branch from develop
- [ ] Update CHANGELOG version
- [ ] Update version numbers in files
- [ ] Create release notes
- [ ] Fix critical bugs only
- [ ] Update documentation for release
- [ ] Run validation tests
- [ ] Commit release changes

### External Review
- [ ] Create PR from release branch to main
- [ ] Sourcery review completed
- [ ] Review documented in admin/feedback/
- [ ] Priority matrix filled out
- [ ] Critical feedback addressed
- [ ] Non-critical items deferred

### Release Finalization
- [ ] PR approved and merged to main
- [ ] Release tagged on main
- [ ] GitHub release created
- [ ] Release branch merged back to develop
- [ ] Release branch deleted
- [ ] Release documentation updated

---

## 🎯 Best Practices

### Feature Development
- **Small, focused features** - Easier to review and test
- **Complete documentation** - Document new features thoroughly
- **Test before merge** - Validate features before merging to develop
- **External reviews** - Use Sourcery for all feature PRs

### Release Preparation
- **Minimal changes** - Only release-specific changes on release branch
- **No new features** - Features should be on develop first
- **Critical bugs only** - Fix only critical issues found during release prep
- **Documentation updates** - Update docs for release, not new features

### External Reviews
- **Document everything** - Fill out priority matrix completely
- **Address critical only** - Don't let perfect be the enemy of good
- **Defer appropriately** - Move non-critical items to next release
- **Learn from feedback** - Use reviews to improve process

### Release Management
- **Follow Git Flow** - Use proper branching and merging
- **Tag properly** - Use semantic versioning and descriptive tags
- **Document releases** - Complete release notes and documentation
- **Clean up** - Delete release branches after merge

---

## 📊 Release Metrics

### Quality Metrics
- **Validation Pass Rate** - 100% of templates pass validation
- **Review Coverage** - All releases have external review
- **Bug Rate** - Track bugs found post-release
- **User Satisfaction** - Gather feedback on releases

### Process Metrics
- **Release Frequency** - Target quarterly releases
- **Feature Velocity** - Features per release
- **Review Time** - Time from PR to merge
- **Hotfix Rate** - Frequency of hotfix releases

---

## 🔄 Continuous Improvement

### Process Refinement
- **Retrospectives** - Review each release process
- **Feedback Integration** - Incorporate user feedback
- **Tool Updates** - Update tools and automation
- **Documentation Updates** - Keep process docs current

### Learning from v0.1.0
- **Feature+Release Conflation** - Avoid mixing feature development with release prep
- **External Review Integration** - Properly document and track reviews
- **Process Documentation** - Create clear process for future releases
- **Quality Gates** - Establish clear quality criteria

---

## 📚 Related Documentation

- **[Release v0.1.0](../v0.1.0/README.md)** - Initial release documentation
- **[Sourcery Review Process](../../feedback/sourcery/README.md)** - External review process
- **[Git Flow Guidelines](../../../.cursor/rules/main.mdc)** - Git Flow best practices

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Active  
**Next:** [Release v0.1.1 Planning](../v0.1.1/README.md)
