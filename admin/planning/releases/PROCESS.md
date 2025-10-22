# Release Process

**Purpose:** Standardized release process for dev-infra  
**Status:** ✅ Active  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This document defines the standardized release process for dev-infra, ensuring consistent, professional releases while avoiding the feature+release conflation that occurred in v1.0.0.

### Key Principles
1. **Separation of Concerns** - Features developed separately from release preparation
2. **External Reviews** - All release branches require external review
3. **Documentation** - Complete documentation of review decisions
4. **Quality Assurance** - Validation and testing at each stage

---

## 📋 Standard Release Process (v1.1.0+)

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
git checkout -b release/v1.1.0

# Make ONLY release-specific changes
# - Update CHANGELOG.md version
# - Update README.md version
# - Create release notes
# - Fix critical bugs only

# Commit release changes
git add .
git commit -m "docs: Prepare v1.1.0 release

- Update CHANGELOG from 1.0.0 to 1.1.0
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
git push origin release/v1.1.0

# Create PR for review
gh pr create --base main --head release/v1.1.0 --title "Release v1.1.0: New template types and improvements"

# Document review in admin/feedback/sourcery/pr02.md
# Address only critical feedback
# Defer medium/low priority items to v1.2.0
```

### Phase 4: Release Merge

**Goal:** Complete release following Git Flow

**Process:**
1. Merge release branch to `main` with --no-ff
2. Tag release on `main`
3. Create GitHub release
4. Merge release branch back to `develop`
5. Delete release branch

**Example:**
```bash
# Merge to main
git checkout main
git pull origin main
git merge --no-ff release/v1.1.0 -m "Release v1.1.0"

# Tag release
git tag -a v1.1.0 -m "Release v1.1.0: New template types and improvements"
git push origin main
git push origin v1.1.0

# Create GitHub release
gh release create v1.1.0 \
  --title "v1.1.0 - New Template Types and Improvements" \
  --notes-file admin/planning/releases/v1.1.0/RELEASE-NOTES.md

# Merge back to develop
git checkout develop
git pull origin develop
git merge --no-ff release/v1.1.0 -m "Merge release v1.1.0 back to develop"
git push origin develop

# Clean up
git branch -d release/v1.1.0
git push origin --delete release/v1.1.0
```

---

## ⚠️ Special Cases

### Initial Release (v1.0.0)

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

### Learning from v1.0.0
- **Feature+Release Conflation** - Avoid mixing feature development with release prep
- **External Review Integration** - Properly document and track reviews
- **Process Documentation** - Create clear process for future releases
- **Quality Gates** - Establish clear quality criteria

---

## 📚 Related Documentation

- **[Release v1.0.0](../v1.0.0/README.md)** - Initial release documentation
- **[Sourcery Review Process](../../feedback/sourcery/README.md)** - External review process
- **[Git Flow Guidelines](../../../.cursor/rules/main.mdc)** - Git Flow best practices

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Active  
**Next:** [Release v1.1.0 Planning](../v1.1.0/README.md)
