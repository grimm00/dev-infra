# CI/CD Improvement Plan - Tag Creation Automation

**Improvement:** Automate Release Tag Creation  
**Priority:** 🔴 High  
**Effort:** Moderate (2-4 hours)  
**Status:** 🟡 Planned  
**Created:** 2025-12-11  
**Source:** reflection-v1.4.0-release-cycle-2025-12-11.md

---

## 📋 Overview

Create GitHub Actions workflow to automatically create and push tags when release PRs are merged to main. This completes the end-to-end release automation by eliminating the last manual step in the release process.

**Current State:**
- Tag creation is manual after PR merge
- Requires manual git operations (`git tag`, `git push`)
- Breaks automation flow at critical point
- Risk of errors or inconsistent formatting

**Desired State:**
- Tags automatically created when release PR merges to main
- Consistent tag format and annotations
- No manual git operations required
- Complete end-to-end release automation

---

## 🎯 Benefits

1. **Completes End-to-End Automation**
   - Eliminates last manual step in release workflow
   - Full automation from `/release-prep` to tag creation
   - Seamless release process

2. **Eliminates Manual Git Operations**
   - No manual `git tag` commands
   - No manual `git push` commands
   - Reduces cognitive load during release

3. **Ensures Consistent Tag Format**
   - Automated format validation
   - Standard annotation format
   - No typos or version errors

4. **Reduces Human Error**
   - No risk of forgetting to create tag
   - No risk of wrong version number
   - No risk of missing annotation

5. **Triggers Release Workflow Automatically**
   - Tag push triggers release distribution
   - GitHub release creation automated
   - Complete release cycle automation

---

## 📅 Implementation Steps

### Step 1: Create Workflow File

**File:** `.github/workflows/create-release-tag.yml`

**Actions:**
1. Create new workflow file
2. Add appropriate name and description
3. Configure trigger conditions
4. Set up job permissions

**Estimated Time:** 30 minutes

---

### Step 2: Configure Trigger

**Trigger:** Release PR merge to main

**Configuration:**
```yaml
name: Create Release Tag

on:
  pull_request:
    types: [closed]
    branches:
      - main
```

**Conditions:**
- Only run when PR is merged (not just closed)
- Only run for PRs targeting main
- Only run for release branches (`release/*` pattern)

**Actions:**
1. Add conditional to check PR was merged
2. Add conditional to check PR head ref matches `release/*`
3. Test trigger with mock PR

**Estimated Time:** 30 minutes

---

### Step 3: Extract Version from PR

**Method:** Parse PR title or branch name

**Options:**
1. **From PR Title:** Extract version from "chore: Release v1.4.0"
2. **From Branch Name:** Extract version from "release/v1.4.0"

**Recommended:** Use branch name (more reliable)

**Implementation:**
```yaml
- name: Extract version from branch
  id: version
  run: |
    BRANCH_NAME="${{ github.head_ref }}"
    VERSION="${BRANCH_NAME#release/}"
    echo "version=$VERSION" >> $GITHUB_OUTPUT
```

**Validation:**
- Check version format matches `v{MAJOR}.{MINOR}.{PATCH}`
- Fail workflow if format invalid

**Actions:**
1. Extract version from branch name
2. Validate version format
3. Store version in output variable
4. Test with different branch names

**Estimated Time:** 1 hour

---

### Step 4: Create Annotated Tag

**Tag Format:** `v{MAJOR}.{MINOR}.{PATCH}`

**Annotation Format:**
```
Release {version}

{Brief summary from release notes}

See CHANGELOG.md for full details.
```

**Implementation:**
```yaml
- name: Create annotated tag
  run: |
    VERSION="${{ steps.version.outputs.version }}"
    git tag -a "$VERSION" -m "Release $VERSION

    {Summary placeholder}

    See CHANGELOG.md for full details."
```

**Actions:**
1. Create annotated tag with version
2. Include release summary in annotation
3. Consider reading summary from RELEASE-NOTES.md
4. Add "See CHANGELOG.md" reference

**Estimated Time:** 1 hour

---

### Step 5: Push Tag to Trigger Release Workflow

**Push Configuration:**
```yaml
- name: Push tag
  run: |
    git push origin "${{ steps.version.outputs.version }}"
```

**Post-Push Actions:**
- Release workflow triggers automatically
- GitHub release created
- Distribution packages generated

**Actions:**
1. Push tag to origin
2. Verify release workflow triggers
3. Monitor release workflow completion
4. Test with actual release PR

**Estimated Time:** 30 minutes

---

### Step 6: Add Dry-Run Testing

**Purpose:** Test workflow without creating actual tags

**Implementation:**
- Add workflow_dispatch trigger for manual testing
- Add `dry-run` input parameter
- Skip tag push when in dry-run mode
- Output what would be done

**Actions:**
1. Add workflow_dispatch trigger
2. Add dry-run input parameter
3. Add conditionals for dry-run mode
4. Test dry-run functionality

**Estimated Time:** 1 hour

---

## ✅ Definition of Done

- [ ] Workflow file created (`.github/workflows/create-release-tag.yml`)
- [ ] Trigger configured (release PR merge to main)
- [ ] Version extraction implemented and tested
- [ ] Annotated tag creation implemented
- [ ] Tag push configured
- [ ] Dry-run mode implemented
- [ ] Tests pass with mock release PR
- [ ] Documentation updated
  - [ ] Workflow documented in `.github/workflows/README.md` (if exists)
  - [ ] Release process docs updated
  - [ ] `/post-release` command docs updated
- [ ] Tested with actual release (v1.5.0 or test release)

---

## 🧪 Testing Plan

### Unit Testing

**Test Cases:**
1. **Version Extraction:**
   - Test with `release/v1.4.0` → Extract `v1.4.0`
   - Test with `release/v2.0.0` → Extract `v2.0.0`
   - Test with `feature/something` → Fail (not release branch)

2. **Version Format Validation:**
   - Test `v1.4.0` → Valid
   - Test `v2.0.0` → Valid
   - Test `1.4.0` → Invalid (no 'v' prefix)
   - Test `v1.4` → Invalid (missing patch)

3. **Tag Creation:**
   - Verify tag created with correct version
   - Verify tag has annotation
   - Verify annotation format correct

---

### Integration Testing

**Test Scenarios:**
1. **Complete Release Flow:**
   - Create test release PR
   - Merge to main
   - Verify workflow triggers
   - Verify tag created
   - Verify tag pushed
   - Verify release workflow triggered

2. **Dry-Run Mode:**
   - Trigger workflow with dry-run
   - Verify no tag created
   - Verify output shows what would be done

3. **Error Handling:**
   - Test with invalid version format
   - Test with non-release branch
   - Test with unmerged PR
   - Verify appropriate error messages

---

## 📝 Documentation Updates

**Files to Update:**

1. **`.github/workflows/README.md`** (if exists)
   - Add entry for create-release-tag workflow
   - Document trigger conditions
   - Document dry-run mode

2. **`admin/planning/releases/PROCESS.md`**
   - Update release process to reflect automation
   - Note that tag creation is now automatic
   - Remove manual tag creation instructions

3. **`.cursor/commands/post-release.md`**
   - Update to note tag creation is automatic
   - Remove validation for tag existence (or make it verification only)
   - Update workflow diagram

4. **`.cursor/commands/pr.md`** (`--release` mode)
   - Note that tag will be created automatically on merge
   - Update workflow diagram

---

## 🔗 Related

**Related Workflows:**
- `.github/workflows/release.yml` - Release distribution (triggered by tag)
- `.github/workflows/test.yml` - CI testing

**Related Commands:**
- `/release-prep` - Release preparation
- `/release-finalize` - Release finalization
- `/pr --release` - Release PR creation
- `/post-release` - Post-release cleanup

**Related Documents:**
- `admin/planning/releases/PROCESS.md` - Release process
- `admin/planning/releases/v1.4.0/retrospective.md` - v1.4.0 lessons learned

---

## 🎯 Success Criteria

**Immediate Success:**
- Workflow creates tags automatically on release PR merge
- Tags have correct format and annotations
- Release workflow triggers successfully
- Zero manual git operations required

**Long-term Success:**
- Used for v1.5.0 release (first automated release)
- Zero tag-related issues in next 3 releases
- Release preparation time reduced by 15-30 minutes
- Release process documentation reflects automation

---

## 📊 Metrics

**Track:**
- Time saved per release (target: 15-30 minutes)
- Tag creation success rate (target: 100%)
- Tag format consistency (target: 100%)
- Release workflow trigger success rate (target: 100%)

---

**Last Updated:** 2025-12-11  
**Status:** 🟡 Planned  
**Next:** Implement workflow file and test with dry-run

