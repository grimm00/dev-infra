# Phase 1: Tag Creation Automation

**Phase:** 1 of 3  
**Status:** 🟡 Planned  
**Priority:** 🔴 High  
**Effort:** 2-4 hours  
**Dependencies:** None

---

## 🎯 Goal

Create GitHub Actions workflow to automatically create and push tags when release PRs are merged to main. This eliminates the last manual step in the release workflow.

---

## 📋 Current State

- Tag creation requires manual `git tag -a v1.X.0 -m "..."` and `git push origin v1.X.0`
- Must be done after PR merge, before release workflow triggers
- Risk of forgetting, typos, or inconsistent formatting
- Breaks automation flow at critical point

---

## 🎯 Target State

- Tags automatically created when release PRs merge to main
- Version extracted from branch name (`release/v1.X.0` → `v1.X.0`)
- Consistent tag format and annotations
- Triggers existing release distribution workflow automatically

---

## 📅 Tasks

### Task 1: Create Workflow File

**File:** `.github/workflows/create-release-tag.yml`

- [ ] Create workflow file with appropriate name/description
- [ ] Add trigger: `pull_request: types: [closed]` on main
- [ ] Add conditions: PR merged AND head ref matches `release/*`
- [ ] Set up job permissions for tag creation

**Estimated:** 30 minutes

---

### Task 2: Implement Version Extraction

- [ ] Extract version from PR head ref (branch name)
- [ ] Parse `release/v1.X.0` → `v1.X.0`
- [ ] Validate version format (must be `vMAJOR.MINOR.PATCH`)
- [ ] Fail with clear error if format invalid
- [ ] Store version in output variable

**Code:**
```yaml
- name: Extract version from branch
  id: version
  run: |
    BRANCH_NAME="${{ github.head_ref }}"
    VERSION="${BRANCH_NAME#release/}"
    
    # Validate format
    if [[ ! "$VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      echo "::error::Invalid version format: $VERSION"
      exit 1
    fi
    
    echo "version=$VERSION" >> $GITHUB_OUTPUT
```

**Estimated:** 1 hour

---

### Task 3: Create Annotated Tag

- [ ] Create annotated tag with version
- [ ] Include summary in annotation
- [ ] Reference CHANGELOG.md for full details

**Code:**
```yaml
- name: Create annotated tag
  run: |
    VERSION="${{ steps.version.outputs.version }}"
    git tag -a "$VERSION" -m "Release $VERSION

    See CHANGELOG.md for full release details."
```

**Estimated:** 30 minutes

---

### Task 4: Push Tag

- [ ] Push tag to origin
- [ ] Verify release workflow triggers
- [ ] Handle push failures gracefully

**Code:**
```yaml
- name: Push tag
  run: |
    git push origin "${{ steps.version.outputs.version }}"
```

**Estimated:** 15 minutes

---

### Task 5: Add Dry-Run Mode

- [ ] Add `workflow_dispatch` trigger for manual testing
- [ ] Add `dry-run` input parameter
- [ ] Skip tag push in dry-run mode
- [ ] Output what would be done

**Code:**
```yaml
on:
  workflow_dispatch:
    inputs:
      dry_run:
        description: 'Dry run (no tag creation)'
        type: boolean
        default: false
```

**Estimated:** 45 minutes

---

### Task 6: Update Documentation

- [ ] Update release process docs
- [ ] Update `/post-release` command (note tags are automatic)
- [ ] Add workflow to `.github/workflows/README.md` (if exists)
- [ ] Update v1.4.0 retrospective action items (mark complete)

**Estimated:** 30 minutes

---

## ✅ Definition of Done

- [ ] Workflow file created and tested
- [ ] Version extraction handles all edge cases
- [ ] Tags created with correct format and annotation
- [ ] Dry-run mode works
- [ ] Documentation updated
- [ ] Tested with mock release PR
- [ ] Workflow merged to develop (ready for v1.5.0)

---

## 🧪 Testing Plan

### Unit Testing

| Test Case | Input | Expected |
|-----------|-------|----------|
| Valid version | `release/v1.5.0` | Extract `v1.5.0` |
| Valid version | `release/v2.0.0` | Extract `v2.0.0` |
| Invalid branch | `feat/something` | Skip (not release) |
| Invalid format | `release/1.5.0` | Error (no 'v') |
| Invalid format | `release/v1.5` | Error (no patch) |

### Integration Testing

1. **Dry-Run Test:**
   - Trigger workflow with dry-run
   - Verify no tag created
   - Verify output shows what would happen

2. **Full Test (on develop/test branch):**
   - Create test release PR
   - Merge to test branch
   - Verify tag created
   - Verify format correct

3. **v1.5.0 Release:**
   - First real use of automation
   - Verify end-to-end flow

---

## 📝 Notes

**Workflow Trigger:**
- Only triggers on PRs merged (not just closed)
- Only triggers on release branches (not feat/fix)
- Uses existing GITHUB_TOKEN (no additional permissions needed)

**Tag Annotation:**
- Keep simple - reference CHANGELOG for details
- Consider reading summary from RELEASE-NOTES.md (future enhancement)

---

**Migrated From:** `admin/planning/ci/tag-creation-automation/improvement-plan.md`  
**Last Updated:** 2025-12-11

