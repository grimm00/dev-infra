# Command Distribution - Phase 1: dev-infra Release Artifacts

**Phase:** 1 - dev-infra Release Artifacts  
**Duration:** ~2-3 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** None (first phase)

---

## 📋 Overview

Enable dev-infra GitHub releases to include downloadable command bundles that dev-toolkit can fetch for installation.

**Success Definition:** Release workflow creates `commands-vX.Y.Z.tar.gz` artifact downloadable from GitHub releases.

---

## 🎯 Goals

1. **Understand release workflow** - Review current `.github/workflows/` release configuration
2. **Create command bundle** - Package commands from `templates/standard-project/.cursor/commands/`
3. **Include in releases** - Attach bundle as release artifact

---

## 📝 Tasks

### Task 1: Analyze Current Release Workflow

**Purpose:** Understand the existing release process before modifying it.

**Current State (from analysis):**

The release workflow (`release-distribution.yml`) already:
- Triggers on `release: published` event
- Creates `dev-infra-X.Y.Z.tar.gz` and `.zip` packages
- Includes `templates/` directory (which contains commands)
- Validates packages and generates checksums
- Uploads to GitHub release

**Key Findings:**

| Component | Location | Notes |
|-----------|----------|-------|
| Release trigger | `create-release-tag.yml` | Creates tag from `release/*` branch |
| Distribution | `release-distribution.yml` | Creates packages on release publish |
| Commands source | `templates/standard-project/.cursor/commands/` | 19 command files |
| Current packages | `dev-infra-X.Y.Z.{tar.gz,zip}` | Contains full templates |

**What Needs to Change:**

- Add a **separate** `commands-vX.Y.Z.tar.gz` bundle containing ONLY the command files
- This allows `dt-cursor-install` to download just commands (~50KB) vs full package (~200KB+)

**Checklist:**
- [x] Review `release-distribution.yml`
- [x] Review `create-release-tag.yml`
- [x] Identify command source location
- [x] Determine bundle strategy

---

### Task 2: Design Command Bundle Format

**Purpose:** Define the format and structure of the command bundle.

**Bundle Specification:**

```
commands-vX.Y.Z.tar.gz
└── commands/
    ├── cursor-rules.md
    ├── decision.md
    ├── explore.md
    ├── fix-implement.md
    ├── fix-plan.md
    ├── fix-review.md
    ├── int-opp.md
    ├── post-pr.md
    ├── pr-validation.md
    ├── pr.md
    ├── pre-phase-review.md
    ├── reflect.md
    ├── reflection-artifacts.md
    ├── research.md
    ├── status.md
    ├── task-improvement.md
    ├── task-phase.md
    ├── task-release.md
    └── transition-plan.md
```

**Design Decisions:**

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Archive format | `.tar.gz` | Standard, cross-platform, smaller than zip |
| Root directory | `commands/` | Clear intent, easy extraction |
| File naming | Original names | No version suffix in filenames (version in archive name) |
| Checksums | Yes (SHA256) | Verify download integrity |

**Bundle Metadata (optional future enhancement):**

Could include a `VERSION` file in the bundle:
```
VERSION=0.8.0
DATE=2025-12-31
COMMANDS=19
```

**Checklist:**
- [ ] Bundle format documented
- [ ] Directory structure defined
- [ ] Naming convention established

---

### Task 3: Update Release Workflow

**Purpose:** Modify `release-distribution.yml` to create and upload command bundle.

**Implementation Steps:**

1. Add command bundle creation step after existing distribution creation
2. Add validation step for command bundle
3. Add checksum generation for command bundle
4. Add upload for command bundle

**Workflow Changes:**

Add these steps to `.github/workflows/release-distribution.yml` in the `create-distribution` job:

```yaml
      - name: Create command bundle
        run: |
          VERSION="${{ steps.get_version.outputs.version }}"
          COMMANDS_PACKAGE="commands-v${VERSION}"
          
          # Create commands directory structure
          mkdir -p "${COMMANDS_PACKAGE}/commands"
          
          # Copy command files from standard-project template
          cp templates/standard-project/.cursor/commands/*.md "${COMMANDS_PACKAGE}/commands/"
          
          # Create VERSION file for metadata
          echo "VERSION=${VERSION}" > "${COMMANDS_PACKAGE}/commands/VERSION"
          echo "DATE=$(date -u +%Y-%m-%d)" >> "${COMMANDS_PACKAGE}/commands/VERSION"
          echo "COMMANDS=$(ls -1 ${COMMANDS_PACKAGE}/commands/*.md | wc -l)" >> "${COMMANDS_PACKAGE}/commands/VERSION"
          
          # Create tarball
          tar -czf "${COMMANDS_PACKAGE}.tar.gz" -C "${COMMANDS_PACKAGE}" commands/
          
          echo "✅ Command bundle created"
          ls -lh "${COMMANDS_PACKAGE}.tar.gz"

      - name: Validate command bundle
        run: |
          VERSION="${{ steps.get_version.outputs.version }}"
          COMMANDS_PACKAGE="commands-v${VERSION}"
          
          echo "Validating command bundle..."
          
          # Extract to test
          TEST_DIR="/tmp/test-commands"
          mkdir -p "${TEST_DIR}"
          tar -xzf "${COMMANDS_PACKAGE}.tar.gz" -C "${TEST_DIR}"
          
          # Check required files exist
          echo "Checking command files..."
          [ -d "${TEST_DIR}/commands" ] || { echo "❌ Missing commands/"; exit 1; }
          
          # Check key commands exist
          for cmd in pr.md task-phase.md reflect.md explore.md; do
            [ -f "${TEST_DIR}/commands/${cmd}" ] || { echo "❌ Missing ${cmd}"; exit 1; }
          done
          
          # Count commands (should be 19+)
          CMD_COUNT=$(ls -1 "${TEST_DIR}/commands/"*.md 2>/dev/null | wc -l)
          echo "Found ${CMD_COUNT} command files"
          [ "$CMD_COUNT" -ge 19 ] || { echo "❌ Expected at least 19 commands, found ${CMD_COUNT}"; exit 1; }
          
          echo "✅ Command bundle validation passed"
          rm -rf "${TEST_DIR}"
```

**Update checksum generation step:**

```yaml
      - name: Generate checksums
        run: |
          PACKAGE_NAME="${{ steps.get_version.outputs.package_name }}"
          VERSION="${{ steps.get_version.outputs.version }}"
          
          echo "Generating checksums..."
          sha256sum "${PACKAGE_NAME}.tar.gz" > "${PACKAGE_NAME}.tar.gz.sha256"
          sha256sum "${PACKAGE_NAME}.zip" > "${PACKAGE_NAME}.zip.sha256"
          sha256sum "commands-v${VERSION}.tar.gz" > "commands-v${VERSION}.tar.gz.sha256"
          
          echo "✅ Checksums generated"
          cat "${PACKAGE_NAME}.tar.gz.sha256"
          cat "${PACKAGE_NAME}.zip.sha256"
          cat "commands-v${VERSION}.tar.gz.sha256"
```

**Update upload step:**

```yaml
      - name: Upload distribution to release
        run: |
          PACKAGE_NAME="dev-infra-${{ steps.get_version.outputs.version }}"
          VERSION="${{ steps.get_version.outputs.version }}"
          TAG_NAME="${{ github.event.release.tag_name }}"
          
          TOKEN="${{ secrets.PAT_TOKEN || secrets.GITHUB_TOKEN }}"
          
          gh release upload "$TAG_NAME" \
            "${PACKAGE_NAME}.tar.gz" \
            "${PACKAGE_NAME}.tar.gz.sha256" \
            "${PACKAGE_NAME}.zip" \
            "${PACKAGE_NAME}.zip.sha256" \
            "commands-v${VERSION}.tar.gz" \
            "commands-v${VERSION}.tar.gz.sha256" \
            --clobber \
            --repo "${{ github.repository }}"
        env:
          GITHUB_TOKEN: ${{ secrets.PAT_TOKEN || secrets.GITHUB_TOKEN }}
```

**Checklist:**
- [ ] Command bundle creation step added
- [ ] Validation step added
- [ ] Checksum generation updated
- [ ] Upload step updated
- [ ] Workflow syntax validated

---

### Task 4: Test Workflow Changes

**Purpose:** Verify the workflow changes work correctly before merging.

**Testing Strategy:**

Since CI workflows can only be fully tested on release events, use this approach:

1. **Local Testing (commands bundle script):**
   ```bash
   # Test bundle creation locally
   cd /Users/cdwilson/Projects/dev-infra
   
   VERSION="test"
   COMMANDS_PACKAGE="commands-v${VERSION}"
   
   mkdir -p "${COMMANDS_PACKAGE}/commands"
   cp templates/standard-project/.cursor/commands/*.md "${COMMANDS_PACKAGE}/commands/"
   
   # Create VERSION file
   echo "VERSION=${VERSION}" > "${COMMANDS_PACKAGE}/commands/VERSION"
   echo "DATE=$(date -u +%Y-%m-%d)" >> "${COMMANDS_PACKAGE}/commands/VERSION"
   echo "COMMANDS=$(ls -1 ${COMMANDS_PACKAGE}/commands/*.md | wc -l)" >> "${COMMANDS_PACKAGE}/commands/VERSION"
   
   tar -czf "${COMMANDS_PACKAGE}.tar.gz" -C "${COMMANDS_PACKAGE}" commands/
   
   # Verify
   tar -tzf "${COMMANDS_PACKAGE}.tar.gz"
   
   # Cleanup
   rm -rf "${COMMANDS_PACKAGE}" "${COMMANDS_PACKAGE}.tar.gz"
   ```

2. **Workflow Syntax Validation:**
   ```bash
   # Use act or GitHub's workflow linter
   # Or just push to a branch and check GitHub Actions tab for syntax errors
   ```

3. **Integration Test (on next release):**
   - Create a test release (e.g., `v0.8.0-rc.1`)
   - Verify `commands-v0.8.0-rc.1.tar.gz` is created
   - Download and verify contents
   - Delete test release if needed

**Checklist:**
- [ ] Local bundle creation tested
- [ ] Workflow syntax validated
- [ ] Integration test planned

---

### Task 5: Document Artifact Format

**Purpose:** Document the command bundle format for consumers (dev-toolkit).

**Documentation Location:** Create `docs/COMMAND-BUNDLE-FORMAT.md`

**Content:**

```markdown
# Command Bundle Format

**Purpose:** Documents the format of command bundles distributed with dev-infra releases.  
**Consumer:** dev-toolkit `dt-cursor-install` command  
**Last Updated:** 2025-12-31

---

## Bundle Format

Each dev-infra release includes a command bundle:

| Artifact | Format | Contents |
|----------|--------|----------|
| `commands-vX.Y.Z.tar.gz` | gzipped tarball | Cursor AI command files |
| `commands-vX.Y.Z.tar.gz.sha256` | checksum | SHA256 hash for verification |

---

## Bundle Structure

\`\`\`
commands-vX.Y.Z.tar.gz
└── commands/
    ├── VERSION           # Metadata file
    ├── cursor-rules.md
    ├── decision.md
    ├── explore.md
    ├── fix-implement.md
    ├── fix-plan.md
    ├── fix-review.md
    ├── int-opp.md
    ├── post-pr.md
    ├── pr-validation.md
    ├── pr.md
    ├── pre-phase-review.md
    ├── reflect.md
    ├── reflection-artifacts.md
    ├── research.md
    ├── status.md
    ├── task-improvement.md
    ├── task-phase.md
    ├── task-release.md
    └── transition-plan.md
\`\`\`

---

## VERSION File Format

\`\`\`
VERSION=X.Y.Z
DATE=YYYY-MM-DD
COMMANDS=N
\`\`\`

---

## Download URL Pattern

\`\`\`
https://github.com/grimm00/dev-infra/releases/download/vX.Y.Z/commands-vX.Y.Z.tar.gz
\`\`\`

---

## Installation

Commands should be extracted to `~/.cursor/commands/`:

\`\`\`bash
# Download
curl -L -o commands.tar.gz https://github.com/grimm00/dev-infra/releases/download/vX.Y.Z/commands-vX.Y.Z.tar.gz

# Extract
mkdir -p ~/.cursor/commands
tar -xzf commands.tar.gz -C ~/.cursor --strip-components=1

# Verify
ls ~/.cursor/commands/
\`\`\`

---

## Checksum Verification

\`\`\`bash
# Download checksum
curl -L -o commands.tar.gz.sha256 https://github.com/grimm00/dev-infra/releases/download/vX.Y.Z/commands-vX.Y.Z.tar.gz.sha256

# Verify
sha256sum -c commands.tar.gz.sha256
\`\`\`
```

**Checklist:**
- [ ] Documentation file created
- [ ] Format documented
- [ ] Download URLs documented
- [ ] Installation instructions included

---

## ✅ Completion Criteria

- [ ] Release workflow updated with command bundle creation
- [ ] `commands-vX.Y.Z.tar.gz` created during release
- [ ] Artifact downloadable from GitHub release page
- [ ] Artifact format documented
- [ ] Local testing completed

---

## 📦 Deliverables

1. **Updated workflow:** `.github/workflows/release-distribution.yml`
2. **Documentation:** `docs/COMMAND-BUNDLE-FORMAT.md`
3. **Tested bundle:** Local test script output

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 1: Analyze Current Workflow | ✅ Complete | Analysis in this document |
| Task 2: Design Bundle Format | 🔴 Not Started | |
| Task 3: Update Release Workflow | 🔴 Not Started | |
| Task 4: Test Workflow Changes | 🔴 Not Started | |
| Task 5: Document Artifact Format | 🔴 Not Started | |

---

## 🔗 Dependencies

### Prerequisites

- None (first phase)

### Blocks

- Phase 2: dt-cursor-install implementation (needs release artifacts)

---

## 📚 Requirements Addressed

| Requirement | Description |
|-------------|-------------|
| NFR-CMD-3 | Release artifacts - dev-infra MUST include commands in releases |

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Next Phase: Phase 2](phase-2.md)
- [Current Release Workflow](../../../../.github/workflows/release-distribution.yml)

---

**Last Updated:** 2025-12-31  
**Status:** 🟠 In Progress  
**Next:** Complete Task 2 (Design Bundle Format)
