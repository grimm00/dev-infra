# Command Bundle Format

**Purpose:** Documents the format of command bundles distributed with dev-infra releases  
**Consumer:** dev-toolkit `dt-cursor-install` command  
**Last Updated:** 2025-12-31

---

## 📋 Overview

Each dev-infra release includes a command bundle that can be downloaded and installed separately from the full distribution package. This enables lightweight installation of Cursor AI commands without downloading the full templates.

---

## 📦 Bundle Artifacts

| Artifact | Format | Size | Contents |
|----------|--------|------|----------|
| `commands-vX.Y.Z.tar.gz` | gzipped tarball | ~74KB | Cursor AI command files |
| `commands-vX.Y.Z.tar.gz.sha256` | text | ~100B | SHA256 checksum for verification |

---

## 🏗️ Bundle Structure

```
commands-vX.Y.Z.tar.gz
└── commands/
    ├── VERSION              # Metadata file
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

**Note:** The archive extracts to a `commands/` directory at the root. There is no version prefix in the directory name - the version is only in the archive filename.

---

## 📄 VERSION File Format

The `VERSION` file contains metadata about the bundle:

```
VERSION=X.Y.Z
DATE=YYYY-MM-DD
COMMANDS=N
```

| Field | Description | Example |
|-------|-------------|---------|
| `VERSION` | dev-infra release version | `0.8.0` |
| `DATE` | Bundle creation date (UTC) | `2025-12-31` |
| `COMMANDS` | Number of command files | `19` |

---

## 🔗 Download URLs

**Latest Release:**

```
https://github.com/grimm00/dev-infra/releases/latest/download/commands-vX.Y.Z.tar.gz
```

**Specific Version:**

```
https://github.com/grimm00/dev-infra/releases/download/vX.Y.Z/commands-vX.Y.Z.tar.gz
```

**Examples:**

```bash
# Download v0.8.0 commands
curl -L -o commands.tar.gz \
  https://github.com/grimm00/dev-infra/releases/download/v0.8.0/commands-v0.8.0.tar.gz

# Download checksum
curl -L -o commands.tar.gz.sha256 \
  https://github.com/grimm00/dev-infra/releases/download/v0.8.0/commands-v0.8.0.tar.gz.sha256
```

---

## 📥 Installation

### Manual Installation

Commands should be extracted to `~/.cursor/commands/`:

```bash
# Download
VERSION="0.8.0"
curl -L -o commands.tar.gz \
  "https://github.com/grimm00/dev-infra/releases/download/v${VERSION}/commands-v${VERSION}.tar.gz"

# Create directory if it doesn't exist
mkdir -p ~/.cursor/commands

# Extract (strip the commands/ prefix to install directly to ~/.cursor/commands/)
tar -xzf commands.tar.gz -C ~/.cursor --strip-components=1

# Verify
ls ~/.cursor/commands/
```

### Using dt-cursor-install (Recommended)

Once dev-toolkit's `dt-cursor-install` is available:

```bash
# Install latest
dt-cursor-install

# Install specific version
dt-cursor-install --version v0.8.0

# Check installed version
dt-cursor-install --status
```

---

## ✅ Checksum Verification

Always verify downloads using the SHA256 checksum:

```bash
# Download bundle and checksum (keeping original filenames)
VERSION="0.8.0"
curl -L -o "commands-v${VERSION}.tar.gz" \
  "https://github.com/grimm00/dev-infra/releases/download/v${VERSION}/commands-v${VERSION}.tar.gz"
curl -L -o "commands-v${VERSION}.tar.gz.sha256" \
  "https://github.com/grimm00/dev-infra/releases/download/v${VERSION}/commands-v${VERSION}.tar.gz.sha256"

# Verify (Linux)
sha256sum -c "commands-v${VERSION}.tar.gz.sha256"

# Verify (macOS)
shasum -a 256 -c "commands-v${VERSION}.tar.gz.sha256"
```

**Expected output:**

```
commands-v0.8.0.tar.gz: OK
```

---

## 🔄 Versioning

Command bundles are versioned with dev-infra releases:

- Commands are sourced from `templates/standard-project/.cursor/commands/`
- Bundle version matches the dev-infra release version
- All command files are updated together (no individual command versioning)

**Version Compatibility:**

| dev-infra Version | Command Bundle | Notes |
|-------------------|----------------|-------|
| v0.8.0+ | `commands-vX.Y.Z.tar.gz` | First release with command bundles |
| v0.7.x and earlier | N/A | Commands only in full distribution |

---

## 📚 Related Documentation

- **[ADR-001: Command Distribution Ownership](../admin/services/meta/features/four-arm-architecture/decisions/adr-001-command-distribution-ownership.md)** - Architecture decision
- **[Command Distribution Standard](../admin/planning/standards/command-distribution/README.md)** - Process standard
- **[Global Commands Guide](GLOBAL-COMMANDS.md)** - User guide for global commands
- **[Template Usage](TEMPLATE-USAGE.md)** - How to use dev-infra templates

---

## 🔧 For Implementers

### Creating the Bundle (CI Workflow)

The bundle is created by the `release-distribution.yml` workflow:

1. Copy commands from `templates/standard-project/.cursor/commands/*.md`
2. Create `VERSION` metadata file
3. Create tarball with `commands/` directory at root
4. Generate SHA256 checksum
5. Upload to GitHub release

### Validation Checks

The workflow validates:

- `commands/` directory exists in archive
- `VERSION` file is present
- Key commands exist (`pr.md`, `task-phase.md`, `reflect.md`, `explore.md`)
- At least 19 command files are included

---

**Last Updated:** 2025-12-31  
**Status:** ✅ Active

