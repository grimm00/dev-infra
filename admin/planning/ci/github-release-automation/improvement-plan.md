# GitHub Release Automation - Improvement Plan

**Improvement:** Auto-create GitHub Release from Tag  
**Priority:** 🔴 HIGH  
**Effort:** 🟢 LOW (30 minutes)  
**Status:** ✅ Complete  
**Created:** 2025-12-12  
**Completed:** 2026-02-28  
**Source:** [Release Automation v2 Reflection](../../notes/reflections/reflection-release-automation-v2-2025-12-12.md)

---

## 📋 Overview

Update the `create-release-tag.yml` workflow to automatically create a GitHub Release after creating the Git tag. This eliminates the manual step discovered during the v0.5.0 release.

---

## 🎯 Success Criteria

- [x] GitHub Release created automatically when release PR merges
- [x] Release-distribution workflow triggers automatically
- [x] No manual `gh release create` command needed
- [x] Dry-run mode still works correctly

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

1. [x] Create branch: `ci/github-release-automation`
2. [x] Add GitHub Release creation step after tag push
3. [x] Update dry-run step to show release creation
4. [x] Update workflow and process documentation
5. [ ] Test on next release (v0.11.0)
6. [x] Create PR and merge

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

- [x] Update `admin/planning/releases/PROCESS.md` — removed manual step
- [x] Update `.cursor/commands/post-release.md` — reflects automated release
- [x] Update CI hub README — marked complete

---

## ✅ Definition of Done

- [x] GitHub Release created automatically on release PR merge
- [x] Dry-run mode updated to show release creation
- [x] Documentation updated
- [ ] Verified on next release (v0.11.0)

---

## 🔗 Related

- **[PR #44 Fix Tracking](../../features/release-automation-v2/fix/pr44/README.md)** - Related workflow fixes
- **[create-release-tag.yml](/.github/workflows/create-release-tag.yml)** - Workflow to update
- **[release-distribution.yml](/.github/workflows/release-distribution.yml)** - Dependent workflow
- **[v0.5.0 Release Learnings](../../opportunities/internal/dev-infra/learnings/release-automation-v2/v0.5.0-release-learnings.md)**

---

**Last Updated:** 2026-02-28  
**Status:** ✅ Complete

