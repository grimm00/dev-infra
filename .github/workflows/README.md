# GitHub Actions Workflows

**Purpose:** Automated CI/CD workflows for dev-infra  
**Last Updated:** 2025-12-11

---

## 🎯 Overview

This directory contains GitHub Actions workflows that automate testing, release distribution, and tag creation for the dev-infra project.

---

## 📋 Active Workflows

### `test.yml` - Run Tests

**Trigger:**
- Push to `main` or `develop` (excluding docs/admin changes)
- Pull requests to `main` or `develop`

**Jobs:**
1. **build-image** - Build and push Docker test image to GHCR
2. **quick-checks** - Fast unit test validation (Ubuntu only)
3. **full-tests** - Complete test suite (Ubuntu + macOS matrix)

**Features:**
- Concurrency control (prevents duplicate runs)
- Path filtering (skip docs/admin/markdown changes)
- Draft PR filtering (skip full validation for drafts)
- Multi-platform testing (Ubuntu + macOS)
- Docker-based test environment

**Duration:** ~10-30 minutes

---

### `create-release-tag.yml` - Create Release Tag

**Trigger:**
- Pull request closed (merged to `main` from `release/*` branch)
- Manual dispatch (with dry-run option)

**Jobs:**
1. **create-tag** - Extract version, create and push annotated tag

**Features:**
- Automatic version extraction from branch name (`release/vX.Y.Z` → `vX.Y.Z`)
- Version format validation (`vMAJOR.MINOR.PATCH`)
- Annotated tag creation with release message
- Dry-run mode for testing
- Triggers release distribution workflow

**Duration:** ~1-2 minutes

**Introduced:** v0.5.0 (Phase 1 of Release Automation v2)

**Example:**
```yaml
# When PR from release/v0.5.0 is merged to main:
# 1. Workflow extracts version: v0.5.0
# 2. Creates annotated tag: git tag -a v0.5.0 -m "Release v0.5.0..."
# 3. Pushes tag: git push origin v0.5.0
# 4. Triggers release-distribution.yml
```

---

### `release-distribution.yml` - Create Release Distribution

**Trigger:**
- GitHub release published

**Jobs:**
1. **quick-checks** - Fast validation
2. **full-tests** - Complete test suite (Ubuntu + macOS)
3. **create-distribution** - Create and upload distribution packages

**Features:**
- Full test suite before distribution
- Merge release and admin changelogs
- Create distribution packages (tar.gz and zip)
- Validate package structure
- Generate SHA256 checksums
- Upload to GitHub release

**Duration:** ~20-30 minutes

**Artifacts:**
- `dev-infra-X.Y.Z.tar.gz`
- `dev-infra-X.Y.Z.zip`
- SHA256 checksum files

---

### `build-test-image.yml` - Build Test Image

**Trigger:**
- Schedule: Daily at 00:00 UTC
- Manual dispatch
- Dockerfile changes

**Jobs:**
1. **build-and-push** - Build and push Docker test image to GHCR

**Features:**
- Scheduled daily builds
- Cached layers for faster builds
- Tagged with commit SHA and `latest`

**Duration:** ~5-10 minutes

---

## 🔄 Workflow Dependencies

```
┌──────────────────────────────────────────────────┐
│  Feature Development (feat/* branches)           │
└─────────────────┬────────────────────────────────┘
                  │
                  ▼
            test.yml (on PR)
                  │
                  ▼
          Merge to develop
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│  Release Preparation (release/* branch)         │
└─────────────────┬───────────────────────────────┘
                  │
                  ▼
            test.yml (on PR)
                  │
                  ▼
        Merge to main (release PR)
                  │
                  ▼
      create-release-tag.yml ◄── Automatic tag creation
                  │
                  ▼
          Tag created (vX.Y.Z)
                  │
                  ▼
       GitHub release published
                  │
                  ▼
    release-distribution.yml ◄── Package creation
                  │
                  ▼
    Distribution packages uploaded
```

---

## 🧪 Testing Workflows

### Local Testing

**Test workflow syntax:**
```bash
# Install actionlint
brew install actionlint  # macOS
# or
sudo apt install actionlint  # Ubuntu

# Validate workflows
actionlint .github/workflows/*.yml
```

**Test with act (optional):**
```bash
# Install act
brew install act  # macOS

# Test workflow locally
act -j quick-checks
```

### Dry-Run Testing

**create-release-tag.yml:**
```bash
# Trigger manually with dry-run mode
gh workflow run create-release-tag.yml -f dry_run=true
```

---

## 📝 Workflow Configuration

### Secrets Required

| Secret | Usage | Source |
|--------|-------|--------|
| `GITHUB_TOKEN` | Default token for API access | Auto-provided by GitHub |
| `PAT_TOKEN` | Personal access token (optional) | User-created (for release uploads) |

### Permissions

Each workflow declares required permissions:
- `contents: read` - Read repository contents
- `contents: write` - Create tags, upload releases
- `packages: write` - Push Docker images to GHCR

---

## 🔧 Maintenance

### Adding New Workflows

1. Create workflow file: `.github/workflows/[name].yml`
2. Test locally with actionlint
3. Document in this README
4. Test with dry-run mode (if applicable)
5. Monitor first production run

### Modifying Existing Workflows

1. Update workflow file
2. Test syntax with actionlint
3. Update documentation in this README
4. Test with dry-run mode (if applicable)
5. Monitor first production run

### Debugging Failed Workflows

1. Check workflow run logs in GitHub Actions UI
2. Review job annotations for errors
3. Test locally with act (if applicable)
4. Check workflow syntax with actionlint
5. Verify secrets and permissions

---

## 📚 Related Documentation

- **[Release Process](../../admin/planning/releases/PROCESS.md)** - Full release process documentation
- **[Multi-Environment Testing](../../admin/planning/ci/multi-environment-testing/)** - Testing workflow details
- **[Release Distribution](../../admin/planning/ci/release-distribution/)** - Distribution workflow details
- **[Release Automation v2](../../admin/planning/features/release-automation-v2/)** - Tag creation automation feature

---

**Last Updated:** 2025-12-11  
**Workflows:** 4 active  
**Next:** Phase 2 - Version Reference Automation (v0.5.0)

