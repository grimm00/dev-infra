# Workflow YAML Syntax Fixes

**Purpose:** Document fixes for YAML syntax errors in workflow files  
**Status:** ✅ Complete  
**Date:** 2025-11-18  
**PR:** #18

---

## 🎯 Overview

Fixed YAML syntax errors and improved workflow reliability in both `build-test-image.yml` and `test.yml` workflows.

---

## 🔍 Issues Identified

### Issue 1: Invalid Docker Tag Format in `build-test-image.yml`

**Error:** `docker/metadata-action` was generating invalid tags like `ghcr.io/repo/test-image:-ca88d09` when branch variables were empty or invalid.

**Root Cause:**
- `type=sha,prefix={{branch}}-` creates tags with empty prefix when `{{branch}}` is undefined
- `docker/metadata-action` doesn't handle PR contexts well
- Complex tag generation logic was error-prone

**Fix Applied:**
- Replaced `docker/metadata-action` with simple shell script tag generation
- Always tag with commit SHA: `ghcr.io/repo/test-image:{sha}`
- Add branch-specific tag for feature branches: `ghcr.io/repo/test-image:{branch}-{sha}`
- Add `latest` tag for main/develop: `ghcr.io/repo/test-image:latest`

**Code Change:**
```yaml
# Before (problematic)
- name: Extract metadata
  id: meta
  uses: docker/metadata-action@v5
  with:
    images: ghcr.io/${{ github.repository }}/test-image
    tags: |
      type=ref,event=branch
      type=sha,prefix={{branch}}-
      type=raw,value=latest,enable={{is_default_branch}}

# After (fixed)
- name: Set image tags
  id: tags
  run: |
    IMAGE="ghcr.io/${{ github.repository }}/test-image"
    SHA="${{ github.sha }}"
    BRANCH="${{ github.ref_name }}"
    
    TAGS="${IMAGE}:${SHA}"
    
    if [ "$BRANCH" != "main" ] && [ "$BRANCH" != "develop" ]; then
      TAGS="${TAGS},${IMAGE}:${BRANCH}-${SHA}"
    fi
    
    if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "develop" ]; then
      TAGS="${TAGS},${IMAGE}:latest"
    fi
    
    echo "tags=${TAGS}" >> $GITHUB_OUTPUT
```

---

### Issue 2: Missing Concurrency Control in `build-test-image.yml`

**Problem:** Multiple builds could run simultaneously for the same branch, wasting CI minutes and causing conflicts.

**Fix Applied:**
```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

**Benefits:**
- Prevents duplicate builds
- Saves CI minutes
- Ensures only latest build runs

---

### Issue 3: Missing Timeout in `build-test-image.yml`

**Problem:** Builds could hang indefinitely if something went wrong.

**Fix Applied:**
```yaml
timeout-minutes: 15
```

**Rationale:** Prevents hung workflows and provides predictable CI times.

---

### Issue 4: Invalid `container: null` in `test.yml`

**Error:** `Incorrect type. Expected "string | number | boolean | object(GitHub Workflow) | array".`

**Root Cause:**
- GitHub Actions doesn't support `container: null` in matrix strategies
- The `container` property must be either:
  - A container object with `image` and `credentials`
  - Omitted entirely (not set to `null`)

**Fix Applied:**
Split the matrix strategy into two separate jobs:
- `full-tests-ubuntu`: Uses Docker container
- `full-tests-macos`: Runs natively (no container)

**Code Change:**
```yaml
# Before (invalid)
strategy:
  matrix:
    include:
      - os: ubuntu-latest
        container: ghcr.io/${{ github.repository }}/test-image:latest
      - os: macos-latest
        container: null
runs-on: ${{ matrix.os }}
container: ${{ matrix.container }}  # ❌ Can't be null

# After (fixed)
full-tests-ubuntu:
  runs-on: ubuntu-latest
  container:
    image: ghcr.io/${{ github.repository }}/test-image:latest
    credentials:
      username: ${{ github.actor }}
      password: ${{ secrets.GITHUB_TOKEN }}

full-tests-macos:
  runs-on: macos-latest
  # No container property (runs natively)
```

**Benefits:**
- Valid YAML syntax
- Clearer job separation
- Easier to maintain
- Better error messages

---

## 📊 Summary of Changes

### `build-test-image.yml`
- ✅ Replaced `docker/metadata-action` with shell script tag generation
- ✅ Added concurrency control
- ✅ Added timeout (15 minutes)
- ✅ Removed unnecessary `labels` output

### `test.yml`
- ✅ Split `full-tests` matrix into `full-tests-ubuntu` and `full-tests-macos` jobs
- ✅ Fixed `container: null` YAML syntax error
- ✅ Updated `tag-image` job dependencies

---

## ✅ Verification

- [x] YAML syntax validated (no linter errors)
- [x] Tag generation logic tested
- [x] Container configuration verified
- [x] Job dependencies updated correctly

---

## 📚 Related Documentation

- **[Docker Image Fixes](docker-image-fixes.md)** - Previous Docker-related fixes
- **[Multi-Environment Testing Planning](../)** - Original workflow design
- **[Workflow Specification](../WORKFLOW.md)** - Complete workflow documentation

---

**Status:** ✅ Complete  
**Next:** Create PR and verify workflows run successfully

