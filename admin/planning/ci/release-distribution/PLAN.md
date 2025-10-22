# Release Distribution Workflow - Implementation Plan

**Last Updated:** 2025-01-27

---

## 🎯 Overview

Detailed implementation plan for the automated release distribution workflow.

---

## 🏗️ Architecture

### GitHub Action Workflow

**Trigger:** `on: release: types: [published]`

**Steps:**
1. Checkout code at release tag
2. Extract version from tag
3. Create clean distribution directory
4. Copy user-facing files
5. **Validate package structure**
6. Generate checksums
7. Upload to release

### Distribution Contents

**Include:**
- `templates/` - All project templates
- `scripts/` - All automation scripts
- `docs/` - All user documentation
- `README.md` - Main readme
- `CHANGELOG.md` - Version history
- `CONTRIBUTING.md` - Contribution guide
- `LICENSE` - License file (if exists)

**Exclude:**
- `admin/` - Internal planning
- `.cursor/` - AI rules
- `.github/` - CI workflows
- `start.txt` - Our setup
- `.git/` - Git history
- Hidden files (`.gitignore`, etc.)

---

## 📝 Implementation Details

### 1. GitHub Action Workflow

**File:** `.github/workflows/release-distribution.yml`

**Key Features:**
- Triggers only on release publication
- Uses release tag for checkout
- Creates both tar.gz and zip
- Validates before upload
- Generates SHA256 checksums
- Uploads all artifacts

### 2. Validation Tests

**Must check:**
- ✅ Required directories exist (templates, scripts, docs)
- ✅ Required files exist (README, CHANGELOG)
- ✅ Internal files excluded (admin, .cursor, .github, start.txt)
- ✅ Both templates present (regular-project, learning-project)
- ✅ Key docs present (TEMPLATE-USAGE, INTEGRATION, etc.)
- ⚠️ Optional: Run validation script (may need git)

### 3. Documentation Updates

**Files to update:**
- `admin/planning/releases/PROCESS.md` - Add automated distribution phase
- `docs/integration/version-pinned.md` - Add download options
- `README.md` - Update Quick Start with distribution links

---

## 🧪 Testing Strategy

See [TESTING.md](TESTING.md) for complete testing strategy.

---

## 📦 Deliverables

### CI Implementation
- `.github/workflows/release-distribution.yml` - GitHub Action workflow

### Documentation Updates
- `admin/planning/releases/PROCESS.md` - Updated release process
- `docs/integration/version-pinned.md` - Download options
- `README.md` - Updated Quick Start

### Manual Backfill (v1.0.0)
- Create distribution for v1.0.0 manually
- Upload to existing v1.0.0 release
- Test user download experience

---

## 🔄 Workflow

### Planning Phase (Current)
1. Create planning docs - `docs/release-distribution` branch
2. Review and refine plans
3. Merge directly to develop

### Implementation Phase (Next)
1. Create `ci/release-distribution` branch from develop
2. Implement GitHub Action workflow
3. Update documentation
4. Test locally
5. Create PR to develop
6. External review (Sourcery)
7. Merge after approval

---

## 🎯 Success Metrics

- Workflow runs successfully on release
- Distribution validated before upload
- Both tar.gz and zip available
- Package size ~50% of full source
- User documentation clear
- No manual intervention needed

---

**Status:** 📋 Planning Complete  
**Next:** [Testing Strategy](TESTING.md)
