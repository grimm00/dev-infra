# GHCR Docker Images for Testing - Research

**Purpose:** Research and evaluate using GitHub Container Registry (GHCR) Docker images for consistent testing environments  
**Status:** ✅ Complete  
**Last Updated:** 2025-11-17

---

## 🎯 Overview

This document researches the feasibility and benefits of using custom Docker images stored in GitHub Container Registry (GHCR) for testing environments in CI/CD workflows.

---

## 📋 What is GHCR?

GitHub Container Registry (GHCR) is GitHub's Docker container registry service that allows you to:
- Build and store Docker images
- Use images in GitHub Actions workflows
- Share images across repositories and organizations
- Version control images with tags
- Free for public repositories, paid for private

---

## 🔍 Research Questions

1. Can Docker images solve platform consistency issues?
2. What are the costs and benefits?
3. How to implement this in our workflow?
4. Does this solve the macOS cancellation issue?

---

## ✅ Benefits of Custom Docker Images

### 1. Consistent Environment

**Problem Solved:**
- Different tool versions on Ubuntu vs macOS
- Platform-specific behavioral differences
- Installation time variations

**Solution:**
- Same tools and versions in every run
- No installation steps needed
- Identical environment across all test runs

### 2. Faster Execution

**Time Savings:**
- BATS installation: 10-14 seconds saved per run
- Git configuration: Already fast, but no setup needed
- Total: ~15 seconds saved per Ubuntu job

**Impact:**
- Quick-checks: 21s → ~6s (71% faster)
- Full-tests (Ubuntu): 20s → ~5s (75% faster)
- More CI minutes available for other tasks

### 3. Version Control

**Benefits:**
- Pin specific versions of all tools
- Reproducible test environments
- Easy to update when needed
- Rollback capability if issues arise

**Example:**
```dockerfile
# Pin specific versions
RUN apt-get install -y bats=1.8.0 git=2.34.0
```

### 4. Reduced Platform Differences

**Current Issues:**
- Ubuntu uses apt-get, macOS uses Homebrew
- Different default tool versions
- Platform-specific behaviors

**With Docker:**
- Same base image (Ubuntu) for all tests
- Same tool versions everywhere
- Eliminates platform-specific differences

---

## ❌ Limitations and Drawbacks

### 1. macOS Runners Don't Support Docker

**Critical Limitation:**
- GitHub Actions macOS runners don't support Docker containers
- Cannot use Docker images for macOS jobs
- Would need to keep current approach for macOS

**Impact:**
- Doesn't solve macOS cancellation issue
- Still need platform-specific installation
- Hybrid approach required

### 2. Additional Maintenance

**Overhead:**
- Dockerfile creation and maintenance
- Image build workflow setup
- Version management for images
- Testing and validation

**Effort:**
- Initial setup: 2-4 hours
- Ongoing maintenance: Low (only when tools update)

### 3. Storage Costs

**GHCR Storage:**
- Free for public repositories
- 500 MB free for private repositories
- $0.25 per GB/month for additional storage

**Our Images:**
- Estimated size: 200-300 MB
- Well within free tier
- Minimal cost impact

### 4. Build Time

**Image Build:**
- First build: 5-10 minutes
- Subsequent builds: 2-5 minutes (with caching)
- Builds only needed when Dockerfile changes

**Impact:**
- One-time setup cost
- Ongoing builds only when updating tools

---

## 🏗️ Implementation Design

### Dockerfile Structure

**Base Image:**
```dockerfile
FROM ubuntu:22.04
```

**Rationale:**
- Stable, well-maintained
- Good package availability
- Reasonable image size
- Matches GitHub Actions Ubuntu runners

**Tools to Include:**

1. **BATS:**
   ```dockerfile
   RUN apt-get update && \
       apt-get install -y bats && \
       rm -rf /var/lib/apt/lists/*
   ```

2. **Git:**
   ```dockerfile
   RUN apt-get install -y git
   ```

3. **Bash:**
   ```dockerfile
   # Already included in Ubuntu base
   ```

4. **GitHub CLI (Optional):**
   ```dockerfile
   RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
       dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
       chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
       echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
       tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
       apt-get update && \
       apt-get install -y gh && \
       rm -rf /var/lib/apt/lists/*
   ```

**Complete Dockerfile:**
```dockerfile
FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    bats \
    git \
    bash \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
```

### Build Workflow

**File:** `.github/workflows/build-test-image.yml`

```yaml
name: Build Test Image

on:
  push:
    branches: [main, develop]
    paths:
      - 'Dockerfile.test'
      - '.github/workflows/build-test-image.yml'
  workflow_dispatch:
    inputs:
      tag:
        description: 'Image tag (default: latest)'
        required: false
        default: 'latest'

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      
      - name: Log in to GHCR
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ghcr.io/${{ github.repository }}/test-image
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=sha,prefix={{branch}}-
            type=raw,value=latest,enable={{is_default_branch}}
      
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          file: ./Dockerfile.test
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
          platforms: linux/amd64
```

### Usage in Test Workflow

**Updated `.github/workflows/test.yml`:**

```yaml
jobs:
  quick-checks:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/${{ github.repository }}/test-image:latest
      credentials:
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Configure git for tests
        run: |
          git config --global user.name "Test User"
          git config --global user.email "test@example.com"
      
      - name: Run unit tests
        run: bats --recursive tests/unit/ || exit 1
        env:
          CI: true
          NON_INTERACTIVE: true

  full-tests:
    if: ${{ github.event.pull_request.draft == false || github.event_name == 'push' }}
    strategy:
      matrix:
        include:
          - os: ubuntu-latest
            container: ghcr.io/${{ github.repository }}/test-image:latest
          - os: macos-latest
            # No container for macOS (not supported)
    runs-on: ${{ matrix.os }}
    container: ${{ matrix.container }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      # macOS-specific: Install BATS
      - name: Install BATS (macOS only)
        if: matrix.os == 'macos-latest'
        run: |
          brew install bats-core || exit 1
          bats --version || exit 1
      
      - name: Configure git for tests
        run: |
          git config --global user.name "Test User"
          git config --global user.email "test@example.com"
      
      - name: Run all tests
        run: bats --recursive tests/ || exit 1
        env:
          CI: true
          NON_INTERACTIVE: true
```

---

## 📊 Cost-Benefit Analysis

### Benefits

| Benefit | Impact | Value |
|---------|--------|-------|
| Faster execution | 15s saved per Ubuntu job | High |
| Consistent environment | Eliminates version differences | High |
| Reduced maintenance | No installation steps | Medium |
| Version control | Pin tool versions | Medium |

### Costs

| Cost | Impact | Value |
|------|--------|-------|
| Initial setup | 2-4 hours | Medium |
| Ongoing maintenance | Low (only on updates) | Low |
| Storage | Free (within limits) | Low |
| Build time | 2-5 minutes per update | Low |

### ROI

**Time Savings:**
- Per run: 15 seconds
- 10 runs/day: 2.5 minutes/day
- 30 days/month: 75 minutes/month
- **Annual:** ~15 hours saved

**Consistency Benefits:**
- Eliminates platform-specific issues
- Reduces debugging time
- Improves test reliability

**Verdict:** ✅ **Positive ROI** - Benefits outweigh costs

---

## 🎯 Recommendations

### For Ubuntu Jobs

✅ **Recommended:** Use Docker images

**Rationale:**
- Saves 15 seconds per run
- Ensures consistent tool versions
- Reduces platform-specific issues
- Low maintenance overhead

**Implementation:**
- Create `Dockerfile.test`
- Set up build workflow
- Update test workflow to use container
- Test in separate branch

### For macOS Jobs

❌ **Not Recommended:** Cannot use Docker (not supported)

**Rationale:**
- macOS runners don't support Docker
- Must keep current approach
- Doesn't solve cancellation issue

**Alternative:**
- Optimize current installation
- Improve caching
- Accept cancellation behavior

### Hybrid Approach

✅ **Recommended:** Use Docker for Ubuntu, current approach for macOS

**Benefits:**
- Best of both worlds
- Faster Ubuntu tests
- macOS tests still work
- Gradual migration possible

---

## 🔄 Implementation Plan

### Phase 1: Setup (1-2 hours)

1. Create `Dockerfile.test`
2. Set up build workflow
3. Test image build locally
4. Push to GHCR

### Phase 2: Integration (1-2 hours)

1. Update test workflow to use container
2. Test in separate branch
3. Verify all tests pass
4. Compare execution times

### Phase 3: Validation (1 hour)

1. Run full test suite
2. Verify no regressions
3. Document changes
4. Update documentation

### Phase 4: Deployment (30 minutes)

1. Merge to develop
2. Monitor first few runs
3. Verify improvements
4. Document results

**Total Time:** 4-6 hours

---

## 📚 References

- [GitHub Container Registry Documentation](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [Docker Buildx Action](https://github.com/docker/build-push-action)
- [Docker Metadata Action](https://github.com/docker/metadata-action)
- [GitHub Actions Container Jobs](https://docs.github.com/en/actions/using-containerized-services/about-service-containers)

---

## ✅ Conclusion

**Recommendation:** ✅ **Proceed with Docker images for Ubuntu jobs**

**Rationale:**
- Significant time savings (15s per run)
- Improved consistency
- Low maintenance overhead
- Positive ROI

**Limitations:**
- Doesn't solve macOS cancellation issue
- Requires initial setup
- macOS jobs still need current approach

**Next Steps:**
1. Create Dockerfile and build workflow
2. Test in separate branch
3. Integrate into test workflow
4. Monitor and document results

---

**Status:** ✅ Complete  
**Next:** See [Platform Differences Investigation](../planning/ci/multi-environment-testing/fix/platform-differences-investigation.md) for full analysis

