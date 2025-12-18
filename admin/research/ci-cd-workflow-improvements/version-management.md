# Version Management Approach Research

**Purpose:** Evaluate version management approaches for dev-infra project  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This document compares version management approaches for dev-infra:
- Current tag-based approach
- `.version` file approach (from reference example)
- Workflow-based versioning
- Semantic versioning automation

---

## 📋 Current State

### Current Approach: Tag-Based Versioning

**Version Storage:**
- Version in `README.md`: `**Version:** v0.2.0`
- Release tags: `v0.1.0`, `v0.1.1`, `v0.2.0`
- No `.version` file

**Version Extraction:**
- Release workflow extracts version from tag: `github.event.release.tag_name`
- Handles tags with or without 'v' prefix
- Used for distribution package naming

**Version Updates:**
- Manual: Update `README.md` when creating release
- Tags created manually via GitHub releases
- No automated version bumping

**Pros:**
- ✅ Simple and straightforward
- ✅ Single source of truth (GitHub tags)
- ✅ No file to manage
- ✅ Works well for current workflow

**Cons:**
- ❌ Manual version updates in README
- ❌ No automated version bumping
- ❌ Version may drift from tag
- ❌ Requires manual synchronization

---

## 🔍 Option 1: `.version` File Approach

### Approach

**Reference:** `cdwilson-docker-build-and-push.yaml` example

**Structure:**
- `.version` file in repository root
- Contains version string: `0.2.0` (no 'v' prefix)
- Workflow reads version from file
- Automated version bumping based on conventional commits

**Implementation:**
```bash
# .version file
0.2.0

# Workflow reads version
VERSION=$(cat .version | tr -d '\n')

# Automated bumping (from reference example)
# Analyzes commit messages for feat/fix
# Bumps minor for feat, patch for fix
```

### Pros

✅ **Single Source of Truth** - Version in one file  
✅ **Automated Bumping** - Can auto-increment based on commits  
✅ **Easy to Read** - Simple file, easy to parse  
✅ **Version Control** - Tracked in git, version history  
✅ **CI/CD Integration** - Easy to use in workflows  

### Cons

❌ **File Management** - Need to maintain `.version` file  
❌ **Sync Risk** - May drift from tags if not careful  
❌ **Complexity** - Requires automated bumping logic  
❌ **Commit Loops** - Risk of infinite loops if not careful  

### Effort Estimate

- **Initial Setup:** 🟡 Medium (2-3 hours)
- **Maintenance:** 🟡 Medium (monitor for drift, handle edge cases)
- **Testing:** 🟡 Medium (test bumping logic)

---

## 🔍 Option 2: Workflow-Based Versioning

### Approach

**Structure:**
- No `.version` file
- Version derived from git tags in workflow
- README updated automatically by workflow
- Tags are single source of truth

**Implementation:**
```yaml
# Workflow extracts version from tag
TAG_NAME="${{ github.event.release.tag_name }}"
VERSION="${TAG_NAME#v}"  # Remove 'v' prefix

# Update README automatically
sed -i "s/\*\*Version:\*\* v.*/\*\*Version:\*\* v${VERSION}/" README.md
git add README.md
git commit -m "chore: update version to ${VERSION}"
git push
```

### Pros

✅ **Single Source of Truth** - Tags are authoritative  
✅ **No File Management** - No `.version` file to maintain  
✅ **Automatic Sync** - README updated from tag  
✅ **Simple** - Minimal complexity  

### Cons

❌ **Tag Dependency** - Requires tag to exist  
❌ **Workflow Complexity** - Need to update README in workflow  
❌ **Commit on Release** - Creates commit during release  
❌ **Manual Tagging** - Still requires manual tag creation  

### Effort Estimate

- **Initial Setup:** 🟢 Low (1-2 hours)
- **Maintenance:** 🟢 Low (minimal)
- **Testing:** 🟢 Low (test README update)

---

## 🔍 Option 3: Hybrid Approach

### Approach

**Structure:**
- `.version` file for development
- Tags for releases
- Workflow syncs `.version` to tag on release
- Automated bumping during development

**Implementation:**
```yaml
# Development: Auto-bump .version based on commits
# Release: Sync .version to tag, update README
```

### Pros

✅ **Best of Both** - Development convenience + release clarity  
✅ **Automated Bumping** - During development  
✅ **Tag Sync** - Version synced to tag on release  
✅ **Flexible** - Can use either approach  

### Cons

❌ **Complexity** - Most complex approach  
❌ **Sync Risk** - Need to ensure .version and tags stay in sync  
❌ **Maintenance** - Higher maintenance burden  

### Effort Estimate

- **Initial Setup:** 🟠 High (4-5 hours)
- **Maintenance:** 🟡 Medium (monitor sync)
- **Testing:** 🟠 High (test both workflows)

---

## 📊 Comparison Matrix

| Criteria | Current (Tag-Based) | .version File | Workflow-Based | Hybrid |
|----------|-------------------|---------------|----------------|--------|
| **Simplicity** | ✅ High | 🟡 Medium | ✅ High | ❌ Low |
| **Automation** | ❌ None | ✅ High | 🟡 Medium | ✅ High |
| **Single Source** | ✅ Tags | ✅ File | ✅ Tags | ❌ Both |
| **Maintenance** | ✅ Low | 🟡 Medium | ✅ Low | ❌ High |
| **Sync Risk** | 🟡 Medium | 🟡 Medium | ✅ Low | ❌ High |
| **CI/CD Integration** | ✅ Easy | ✅ Easy | ✅ Easy | 🟡 Medium |

---

## 🎯 Recommendation

### Recommended: **Keep Current Approach (Tag-Based) with Minor Enhancement**

**Rationale:**

1. **Current Approach Works Well**
   - Simple and straightforward
   - Tags are clear single source of truth
   - No file management overhead
   - Works with existing release workflow

2. **Minor Enhancement: Auto-Update README**
   - Add workflow step to update README.md from tag
   - Eliminates manual README update
   - Keeps approach simple

3. **No Need for Complex Automation**
   - dev-infra doesn't have frequent releases
   - Manual version control is acceptable
   - Automated bumping adds complexity without clear benefit

4. **Future Consideration**
   - If release frequency increases, consider `.version` file
   - If automated bumping becomes valuable, add it later
   - Current approach is sufficient for now

### Implementation: Workflow-Based README Update

**Enhancement to `release-distribution.yml`:**

```yaml
- name: Update README version
  run: |
    TAG_NAME="${{ github.event.release.tag_name }}"
    VERSION="${TAG_NAME#v}"
    
    # Update README.md version line
    sed -i "s/\*\*Version:\*\* v[0-9.]*/**Version:** v${VERSION}/" README.md
    
    # Commit and push (if not already done)
    git config user.name "github-actions[bot]"
    git config user.email "github-actions[bot]@users.noreply.github.com"
    git add README.md
    git commit -m "chore: update version to ${VERSION}" || exit 0
    git push || exit 0
```

**Benefits:**
- ✅ Eliminates manual README update
- ✅ Keeps tags as single source of truth
- ✅ Minimal complexity
- ✅ No new files to manage

---

## 🔧 Alternative: `.version` File (If Needed Later)

### When to Consider

**Triggers for `.version` File Approach:**
- Release frequency increases significantly
- Need for automated version bumping
- Multiple version numbers to manage
- Complex versioning requirements

**Implementation (If Needed):**

1. **Create `.version` file:**
   ```bash
   echo "0.2.0" > .version
   ```

2. **Update workflow to read from file:**
   ```yaml
   - name: Get version
     run: |
       VERSION=$(cat .version | tr -d '\n')
       echo "version=${VERSION}" >> $GITHUB_OUTPUT
   ```

3. **Add automated bumping (optional):**
   - Analyze conventional commits
   - Bump version automatically
   - Commit updated `.version` file

---

## 📝 Semantic Versioning

### Current Practice

**Version Format:** `vMAJOR.MINOR.PATCH`
- `v0.1.0` - Initial release
- `v0.1.1` - Minor release (new features)
- `v0.2.0` - Minor release (new features)
- `v2.0.0` - Major release (breaking changes)

**Version Bumping:**
- Manual decision based on changes
- No automated bumping
- Semantic versioning principles followed

### Automated Bumping (Future)

**If Implementing `.version` File Approach:**

**Conventional Commits:**
- `feat:` → Bump MINOR (0.2.0 → 0.3.0)
- `fix:` → Bump PATCH (0.2.0 → 1.2.1)
- `BREAKING CHANGE:` → Bump MAJOR (0.2.0 → 2.0.0)

**Implementation (from reference example):**
```javascript
// Analyze commits
let hasFeat = false;
let hasFix = false;

for (const commit of commits.data) {
    const message = commit.commit.message.toLowerCase();
    if (message.startsWith('feat:')) {
        hasFeat = true;
    }
    if (message.startsWith('fix:')) {
        hasFix = true;
    }
}

// Bump version
if (hasFeat) {
    newVersion = `${major}.${minor + 1}.0`;
} else if (hasFix) {
    newVersion = `${major}.${minor}.${patch + 1}`;
}
```

**Recommendation:**
- **Current:** Manual versioning is sufficient
- **Future:** Consider automated bumping if release frequency increases

---

## 🎯 Summary

### Current Approach

- ✅ **Tag-based versioning** - Simple and effective
- ✅ **Manual README update** - Minor inconvenience
- ✅ **Works well** - No immediate need to change

### Recommended Enhancement

- **Add workflow-based README update** - Eliminates manual step
- **Keep tags as single source of truth** - Simple and clear
- **No `.version` file needed** - Current approach is sufficient

### Future Considerations

- **If release frequency increases:** Consider `.version` file
- **If automated bumping needed:** Add conventional commit analysis
- **If complexity grows:** Evaluate hybrid approach

### Priority

- **High:** Add workflow-based README update (low effort, high value)
- **Low:** Implement `.version` file (defer until needed)
- **Low:** Add automated bumping (defer until needed)

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Research Complete

