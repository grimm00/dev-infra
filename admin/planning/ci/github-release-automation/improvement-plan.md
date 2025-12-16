# GitHub Release Automation - Improvement Plan

**Improvement:** Auto-create GitHub Release from Tag  
**Priority:** 🔴 HIGH  
**Effort:** 🟢 LOW (30 minutes)  
**Status:** 🔴 Not Started  
**Created:** 2025-12-12  
**Source:** [Release Automation v2 Reflection](../../notes/reflections/reflection-release-automation-v2-2025-12-12.md)

---

## 📋 Overview

Update the `create-release-tag.yml` workflow to automatically create a GitHub Release after creating the Git tag. This eliminates the manual step discovered during the v1.5.0 release.

---

## 🎯 Success Criteria

- [ ] GitHub Release created automatically when release PR merges
- [ ] Release-distribution workflow triggers automatically
- [ ] No manual `gh release create` command needed
- [ ] Dry-run mode still works correctly

---

## 💡 Implementation

### Code Changes

**File:** `.github/workflows/create-release-tag.yml`

**Add after "Push tag" step:**

```yaml
- name: Create GitHub Release
  if: ${{ github.event.inputs.dry_run != 'true' }}
  env:
    GH_TOKEN: ${{ github.token }}
  run: |
    VERSION="${{ steps.version.outputs.version }}"
    gh release create "$VERSION" \
      --title "Release $VERSION" \
      --generate-notes
    echo "✅ Created GitHub Release for $VERSION"
    echo "::notice::This will trigger the release-distribution workflow"
```

**Update dry-run step to show release creation:**

```yaml
- name: Dry-run mode (no tag creation)
  if: ${{ github.event.inputs.dry_run == 'true' }}
  run: |
    VERSION="${{ steps.version.outputs.version }}"
    echo "::notice::DRY RUN MODE - Tag and Release would be created:"
    echo "Tag: $VERSION"
    echo "Release Title: Release $VERSION"
    echo "Release Notes: Auto-generated from commit history"
```

---

## 📅 Implementation Steps

1. [ ] Create fix branch: `fix/github-release-auto-create`
2. [ ] Add GitHub Release creation step after tag push
3. [ ] Update dry-run step to show release creation
4. [ ] Update workflow README documentation
5. [ ] Test with dry-run on a test branch
6. [ ] Create PR and merge

---

## 🧪 Testing

**Manual Testing:**
1. Create a test release branch (e.g., `release/v0.0.0-test`)
2. Merge to main (or use workflow_dispatch with dry-run)
3. Verify tag created
4. Verify GitHub Release created
5. Verify release-distribution workflow triggered

**Verification:**
- Check GitHub Releases page for new release
- Check GitHub Actions for release-distribution run

---

## 📚 Documentation Updates

- [ ] Update `.github/workflows/README.md` with release creation details
- [ ] Update `admin/planning/releases/PROCESS.md` if needed
- [ ] Update `.cursor/commands/post-release.md` if needed

---

## ✅ Definition of Done

- [ ] GitHub Release created automatically on release PR merge
- [ ] Dry-run mode updated to show release creation
- [ ] Documentation updated
- [ ] Tested on v1.6.0 release (or earlier test)

---

## 🔗 Related

- **[PR #44 Fix Tracking](../../features/release-automation-v2/fix/pr44/README.md)** - Related workflow fixes
- **[create-release-tag.yml](/.github/workflows/create-release-tag.yml)** - Workflow to update
- **[release-distribution.yml](/.github/workflows/release-distribution.yml)** - Dependent workflow
- **[v1.5.0 Release Learnings](../../opportunities/internal/dev-infra/learnings/release-automation-v2/v1.5.0-release-learnings.md)**

---

**Last Updated:** 2025-12-12  
**Status:** 🔴 Not Started

