# Platform Differences Investigation

**Purpose:** Comprehensive investigation of differences between Ubuntu and macOS testing environments  
**Status:** 🟠 In Progress  
**Last Updated:** 2025-11-17  
**PRs:** #16, #17

---

## 📋 Overview

This document investigates the differences between Ubuntu and macOS testing environments, including tool versions, behavioral differences, timing analysis, and evaluation of Docker-based solutions for consistent testing.

---

## 🔍 Phase 1: Timing and Execution Analysis

### Workflow Run Timing Data

**Run 19445409960 (Created: 2025-11-17T21:38:00Z)**

| Job          | Platform | Started  | Completed | Duration | Install BATS | Run Tests   | Status       |
| ------------ | -------- | -------- | --------- | -------- | ------------ | ----------- | ------------ |
| quick-checks | Ubuntu   | 21:38:05 | 21:38:26  | 21s      | 13s (08→21)  | 2s (21→23)  | ❌ Failed    |
| full-tests   | Ubuntu   | 21:38:04 | 21:38:24  | 20s      | 14s (06→20)  | 3s (20→23)  | ❌ Failed    |
| full-tests   | macOS    | 21:38:05 | 21:38:38  | 33s      | 10s (11→21)  | 12s (22→34) | ⏸️ Cancelled |

**Run 19445359169 (Created: 2025-11-17T21:36:13Z)**

| Job          | Platform | Started  | Completed | Duration | Status       |
| ------------ | -------- | -------- | --------- | -------- | ------------ |
| quick-checks | Ubuntu   | 21:36:17 | 21:36:35  | 18s      | ❌ Failed    |
| full-tests   | Ubuntu   | 21:36:18 | 21:36:41  | 23s      | ❌ Failed    |
| full-tests   | macOS    | 21:36:17 | 21:36:46  | 29s      | ⏸️ Cancelled |

### Key Timing Observations

1. **BATS Installation Times:**

   - Ubuntu: 13-14 seconds (apt-get install)
   - macOS: 10 seconds (brew install)
   - **Finding:** macOS installation is actually faster, likely due to Homebrew caching

2. **Test Execution Times:**

   - Ubuntu: 2-3 seconds (fails quickly)
   - macOS: 12 seconds (runs longer before cancellation)
   - **Finding:** macOS tests actually start running but get cancelled

3. **Concurrency Cancellation:**
   - Runs are triggered ~1:47 apart (21:36:13 → 21:38:00)
   - macOS job from first run cancelled when second run starts
   - **Finding:** Concurrency control cancels in-progress macOS jobs when new commits are pushed

### Cancellation Pattern Analysis

**Root Cause:** The concurrency group `${{ github.workflow }}-${{ github.event.pull_request.number || github.ref }}` cancels all in-progress runs when a new commit is pushed to the same PR branch.

**Impact:**

- macOS jobs take longer to complete (30-33 seconds vs 20-23 seconds for Ubuntu)
- When commits are pushed rapidly (< 2 minutes apart), macOS jobs are cancelled before completion
- Ubuntu jobs complete faster, so they finish before cancellation

**Timeline Example:**

```
21:36:13 - Run 19445359169 starts
21:36:17 - macOS job starts
21:36:46 - macOS job cancelled (29s runtime)
21:38:00 - Run 19445409960 starts (new commit pushed)
         - This cancels the previous run's macOS job
```

---

## 🔧 Phase 2: Tool Version and Behavioral Differences

### BATS Versions

**Ubuntu (apt-get install bats):**

- Package: `bats` (Ubuntu package)
- Version: Typically 1.2.0 or 1.3.0 (varies by Ubuntu version)
- Installation: `sudo apt-get install -y bats`
- Location: `/usr/bin/bats`

**macOS (brew install bats-core):**

- Package: `bats-core` (Homebrew)
- Version: Latest stable (typically 1.8.0+)
- Installation: `brew install bats-core`
- Location: `/opt/homebrew/bin/bats` (Apple Silicon) or `/usr/local/bin/bats` (Intel)

**Potential Differences:**

- Different versions may have different behaviors
- BATS 1.8.0+ has improved features and bug fixes
- Older versions may have platform-specific bugs

### GitHub CLI (`gh`) Behavior

**Ubuntu:**

- Installation: May need manual installation or use of GitHub Actions
- Version: Varies based on installation method
- Behavior: Standard Linux behavior

**macOS:**

- Installation: Often pre-installed or via Homebrew
- Version: May be different from Ubuntu
- Behavior: macOS-specific integrations (e.g., Keychain for auth)

**Our Usage:**

- Tests use `mock_gh()` helper function
- Real `gh` CLI not used in tests
- Mock behavior should be consistent across platforms
- **Finding:** No real `gh` differences affect our tests

### Git Behavior

**Ubuntu:**

- Git version: Typically 2.34+ (varies by Ubuntu version)
- Default config: Minimal
- Behavior: Standard Linux git

**macOS:**

- Git version: Varies (may be older if using system git)
- Default config: May have macOS-specific settings
- Behavior: Generally compatible, but some edge cases differ

**Our Usage:**

- Tests configure git with `git config --global user.name` and `user.email`
- Both platforms should behave identically after configuration
- **Finding:** Git behavior differences unlikely to cause test failures

### Bash/Shell Differences

**Ubuntu:**

- Default shell: Bash (GNU Bash)
- Version: 5.1+ (varies by Ubuntu version)
- Features: Full GNU Bash features

**macOS:**

- Default shell: zsh (since macOS Catalina)
- Bash version: 3.2 (old, for compatibility)
- Features: Limited Bash features (old version)

**Our Usage:**

- Scripts use `#!/bin/bash` shebang
- Tests run in BATS, which uses bash
- macOS GitHub Actions runners use bash for scripts
- **Finding:** Shell differences unlikely to cause issues (both use bash in CI)

### System Utilities Differences

**`sed` Command:**

- Ubuntu: GNU sed (supports `sed -i` without extension)
- macOS: BSD sed (requires `sed -i ''` with empty string)
- **Our Code:** Already handles this with `$OSTYPE` detection
- **Finding:** Properly handled in code

**Other Utilities:**

- `grep`, `awk`, `find`: May have different options
- **Our Usage:** Minimal, mostly standard options
- **Finding:** Unlikely to cause issues

---

## 🔄 Phase 3: Concurrency and Cancellation Analysis

### Current Concurrency Configuration

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.event.pull_request.number || github.ref }}
  cancel-in-progress: true
```

**Behavior:**

- Groups runs by workflow name and PR number (or branch ref)
- Cancels in-progress runs when new commit is pushed
- Saves CI minutes by avoiding duplicate runs

**Problem:**

- macOS jobs take longer to complete
- When commits are pushed rapidly, macOS jobs are cancelled before completion
- Ubuntu jobs complete faster, so they finish before cancellation

### Cancellation Timing Analysis

**Pattern:**

1. Developer pushes commit → workflow starts
2. Ubuntu job completes quickly (20-23 seconds)
3. macOS job still running (takes 30-33 seconds)
4. Developer pushes another commit → new workflow starts
5. Previous workflow's macOS job gets cancelled

**Frequency:**

- Occurs when commits are pushed < 2 minutes apart
- More likely during active development
- Less likely during review/approval phase

### Potential Solutions

1. **Include Commit SHA in Concurrency Group:**

   ```yaml
   group: ${{ github.workflow }}-${{ github.event.pull_request.number || github.ref }}-${{ github.sha }}
   ```

   - **Pros:** Only cancels duplicate runs of same commit
   - **Cons:** May allow more duplicate runs, wasting CI minutes

2. **Remove `cancel-in-progress` for macOS Jobs:**

   - **Pros:** macOS jobs always complete
   - **Cons:** Not possible (concurrency is workflow-level, not job-level)

3. **Optimize macOS Job Speed:**

   - Use Docker image with pre-installed tools
   - Reduce installation time
   - **Pros:** Jobs complete faster, less likely to be cancelled
   - **Cons:** Requires Docker image setup

4. **Accept Cancellation:**
   - Document that rapid commits may cancel macOS tests
   - Rely on Ubuntu tests for fast feedback
   - **Pros:** No changes needed
   - **Cons:** May miss macOS-specific issues

---

## 🐳 Phase 4: GHCR Docker Image Evaluation

### What is GitHub Container Registry (GHCR)?

GitHub Container Registry (GHCR) is GitHub's Docker container registry service. It allows you to:

- Build and store Docker images
- Use images in GitHub Actions workflows
- Share images across repositories
- Version control images with tags

### Benefits of Custom Docker Images for Testing

1. **Consistent Environment:**

   - Same tools and versions across all runs
   - No installation steps needed
   - Faster test execution

2. **Version Control:**

   - Pin specific versions of BATS, git, bash, etc.
   - Reproducible test environments
   - Easy to update when needed

3. **Faster Execution:**

   - No installation time (10-14 seconds saved)
   - Pre-configured environment
   - Cached layers for faster pulls

4. **Cross-Platform Consistency:**
   - Same environment on Ubuntu and macOS (if using Docker on both)
   - Eliminates platform-specific differences
   - Easier debugging

### Drawbacks of Docker Approach

1. **Additional Maintenance:**

   - Need to build and maintain Dockerfile
   - Image build/push workflow required
   - Version management for images

2. **macOS Limitations:**

   - GitHub Actions macOS runners don't support Docker
   - Would need to use Ubuntu-only or find alternative
   - May not solve macOS cancellation issue

3. **Complexity:**

   - More moving parts
   - Image build failures
   - Storage costs (minimal for small images)

4. **Initial Setup:**
   - Dockerfile creation
   - Build workflow setup
   - Testing and validation

### Docker Image Design

**Base Image Options:**

- `ubuntu:latest` - Standard Ubuntu base
- `ubuntu:22.04` - Specific version for stability
- `alpine:latest` - Smaller image size
- `debian:bullseye` - Alternative base

**Tools to Include:**

- BATS (specific version, e.g., 1.8.0)
- Git (latest or specific version)
- Bash (latest)
- GitHub CLI (`gh`) - if needed for real tests
- Other utilities as needed

**Example Dockerfile:**

```dockerfile
FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    bats \
    git \
    bash \
    curl \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install GitHub CLI (if needed)
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
    dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
    chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
    tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt-get update && \
    apt-get install -y gh && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
```

**Build Workflow:**

```yaml
name: Build Test Image

on:
  push:
    branches: [main, develop]
    paths:
      - "Dockerfile.test"
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to GHCR
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          file: ./Dockerfile.test
          push: true
          tags: ghcr.io/${{ github.repository }}/test-image:latest
          cache-from: type=gha
          cache-to: type=gha,mode=max
```

**Usage in Test Workflow:**

```yaml
jobs:
  quick-checks:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/${{ github.repository }}/test-image:latest
    steps:
      - uses: actions/checkout@v4
      - name: Run unit tests
        run: bats --recursive tests/unit/
```

### Recommendation

**For Ubuntu Jobs:**

- ✅ **Recommended:** Use Docker image for consistency and speed
- Saves 10-14 seconds per run
- Ensures consistent tool versions
- Reduces platform-specific issues

**For macOS Jobs:**

- ❌ **Not Recommended:** macOS runners don't support Docker
- Would need alternative approach
- Doesn't solve cancellation issue

**Hybrid Approach:**

- Use Docker for Ubuntu jobs
- Keep current approach for macOS jobs
- Optimize macOS job speed with better caching

---

## 📊 Summary of Findings

### Timing Differences

| Metric            | Ubuntu | macOS  | Difference                    |
| ----------------- | ------ | ------ | ----------------------------- |
| BATS Installation | 13-14s | 10s    | macOS faster                  |
| Test Execution    | 2-3s   | 12s+   | Ubuntu faster (fails quickly) |
| Total Job Time    | 20-23s | 30-33s | macOS 10s slower              |
| Cancellation Risk | Low    | High   | macOS more vulnerable         |

### Tool Version Differences

| Tool     | Ubuntu      | macOS        | Impact                    |
| -------- | ----------- | ------------ | ------------------------- |
| BATS     | 1.2.0-1.3.0 | 1.8.0+       | Low (tests work on both)  |
| Git      | 2.34+       | Varies       | Low (configured in tests) |
| Bash     | 5.1+        | 3.2 (system) | Low (CI uses bash)        |
| `gh` CLI | N/A         | N/A          | None (mocked in tests)    |

### Behavioral Differences

| Area            | Ubuntu | macOS         | Impact                   |
| --------------- | ------ | ------------- | ------------------------ |
| `sed` command   | GNU    | BSD           | ✅ Handled in code       |
| Shell           | Bash   | zsh (default) | Low (CI uses bash)       |
| Package Manager | apt    | Homebrew      | Low (different but work) |

### Root Causes

1. **Cancellation Issue:**

   - macOS jobs take longer to complete
   - Concurrency control cancels in-progress runs
   - Rapid commits cause cancellations

2. **Test Failures:**
   - `prompt_yes_no` detection not working in CI
   - Environment variables not set correctly
   - Fixed in recent commits

### Recommendations

1. **Short-term:**

   - Accept that rapid commits may cancel macOS tests
   - Rely on Ubuntu tests for fast feedback
   - Document cancellation behavior

2. **Medium-term:**

   - Use Docker images for Ubuntu jobs (faster, consistent)
   - Optimize macOS job speed with better caching
   - Consider adjusting concurrency group strategy

3. **Long-term:**
   - Evaluate if macOS testing is necessary
   - Consider alternative testing strategies
   - Monitor cancellation frequency

---

## 🔄 Next Steps

1. ✅ **Docker Image Approach Implemented:**

   - ✅ Created Dockerfile.test
   - ✅ Set up build workflow (build-test-image.yml)
   - ✅ Updated test workflow to use containers
   - ✅ Added image tagging after successful test runs
   - ⏳ Test in separate branch (pending)

2. **Monitor and Optimize:**

   - Monitor execution times (should see ~15s reduction for Ubuntu)
   - Verify all tests pass with Docker containers
   - Monitor cancellation frequency for macOS
   - Consider further optimizations if needed

3. ✅ **Documentation Updated:**
   - ✅ Updated WORKFLOW.md with Docker image details
   - ✅ Documented image tagging strategy
   - ✅ Updated execution time estimates

---

**Status:** 🟠 In Progress  
**Next:** See [Next Steps](next-steps.md) for implementation plan
