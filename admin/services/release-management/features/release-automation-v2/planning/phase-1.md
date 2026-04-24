# Phase 1: Tag Creation Automation

**Phase:** 1 of 3  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Completed:** 2025-12-11  
**Merged:** PR #44 (2025-12-11)  
**Last Updated:** 2025-12-11  
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

- [x] Create workflow file with appropriate name/description
- [x] Add trigger: `pull_request: types: [closed]` on main
- [x] Add conditions: PR merged AND head ref matches `release/*`
- [x] Set up job permissions for tag creation

**Estimated:** 30 minutes

---

### Task 2: Implement Version Extraction

- [x] Extract version from PR head ref (branch name)
- [x] Parse `release/v1.X.0` → `v1.X.0`
- [x] Validate version format (must be `vMAJOR.MINOR.PATCH`)
- [x] Fail with clear error if format invalid
- [x] Store version in output variable

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

- [x] Create annotated tag with version
- [x] Include summary in annotation
- [x] Reference CHANGELOG.md for full details

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

- [x] Push tag to origin
- [x] Verify release workflow triggers (noted in output)
- [x] Handle push failures gracefully (git push will fail if tag exists)

**Code:**

```yaml
- name: Push tag
  run: |
    git push origin "${{ steps.version.outputs.version }}"
```

**Estimated:** 15 minutes

---

### Task 5: Add Dry-Run Mode

- [x] Add `workflow_dispatch` trigger for manual testing
- [x] Add `dry-run` input parameter
- [x] Skip tag push in dry-run mode
- [x] Output what would be done

**Code:**

```yaml
on:
  workflow_dispatch:
    inputs:
      dry_run:
        description: "Dry run (no tag creation)"
        type: boolean
        default: false
```

**Estimated:** 45 minutes

---

### Task 6: Update Documentation

- [x] Update release process docs
- [x] Update `/post-release` command (note tags are automatic)
- [x] Add workflow to `.github/workflows/README.md` (created)
- [x] Update v0.4.0 retrospective action items (mark complete)

**Estimated:** 30 minutes

---

## ✅ Definition of Done

- [x] Workflow file created and tested
- [x] Version extraction handles all edge cases
- [x] Tags created with correct format and annotation
- [x] Dry-run mode works
- [x] Documentation updated
- [ ] Tested with mock release PR (to be tested in PR validation)
- [ ] Workflow merged to develop (ready for v0.5.0) (pending PR)

---

## 🧪 Testing Plan

### Unit Testing

| Test Case      | Input            | Expected           |
| -------------- | ---------------- | ------------------ |
| Valid version  | `release/v0.5.0` | Extract `v0.5.0`   |
| Valid version  | `release/v2.0.0` | Extract `v2.0.0`   |
| Invalid branch | `feat/something` | Skip (not release) |
| Invalid format | `release/0.5.0`  | Error (no 'v')     |
| Invalid format | `release/v1.5`   | Error (no patch)   |

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

3. **v0.5.0 Release:**
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
