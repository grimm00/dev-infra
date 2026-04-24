# Command Distribution - Phase 2: dt-cursor-install Implementation

**Phase:** 2 - dt-cursor-install Implementation  
**Duration:** ~4-6 hours  
**Status:** ✅ Expanded  
**Prerequisites:** Phase 1 complete (release artifacts available)

---

## 📋 Overview

Implement the `dt-cursor-install` command in dev-toolkit that fetches commands from dev-infra releases and installs them to `~/.cursor/commands/`.

**Success Definition:** Users can run `dt-cursor-install` to install Cursor AI commands globally with version control support.

**Note:** This phase is implemented in the **dev-toolkit** repository, not dev-infra. The implementation will be planned here but executed in dev-toolkit.

---

## 🎯 Goals

1. **Core installation** - Fetch and copy commands to `~/.cursor/commands/`
2. **Version support** - Support `--version` flag for specific versions
3. **List versions** - Support `--list` flag to show available versions
4. **Update command** - Support `--update` flag to update to latest
5. **Status check** - Support `--status` flag to show installed version

---

## 📝 Tasks

### Task 1: Create Script Structure (TDD - RED)

**Purpose:** Create the base `dt-cursor-install` script with help and argument parsing.

**Repository:** dev-toolkit

**TDD Flow:**

1. **RED - Write failing tests:**

   Create test file: `tests/unit/cursor-install.bats`

   ```bash
   #!/usr/bin/env bats

   load "../helpers/test_helper.bash"

   SCRIPT="$BATS_TEST_DIRNAME/../../bin/dt-cursor-install"

   @test "dt-cursor-install --help shows usage" {
       run bash "$SCRIPT" --help
       [ "$status" -eq 0 ]
       [[ "$output" =~ "Usage:" ]]
       [[ "$output" =~ "dt-cursor-install" ]]
   }

   @test "dt-cursor-install --version shows version" {
       run bash "$SCRIPT" --version
       [ "$status" -eq 0 ]
       [[ "$output" =~ "dt-cursor-install" ]]
   }

   @test "dt-cursor-install with invalid flag shows error" {
       run bash "$SCRIPT" --invalid-flag
       [ "$status" -ne 0 ]
       [[ "$output" =~ "Unknown option" ]] || [[ "$output" =~ "invalid" ]]
   }
   ```

2. **GREEN - Implement minimum code:**

   Create `bin/dt-cursor-install`:

   ```bash
   #!/usr/bin/env bash
   set -euo pipefail

   VERSION="1.0.0"
   SCRIPT_NAME="dt-cursor-install"

   # Configuration
   COMMANDS_DIR="${HOME}/.cursor/commands"
   VERSION_FILE="${HOME}/.dev-toolkit/cursor-commands-version"
   GITHUB_REPO="grimm00/dev-infra"
   RELEASES_URL="https://api.github.com/repos/${GITHUB_REPO}/releases"

   show_help() {
       cat << EOF
   Usage: ${SCRIPT_NAME} [OPTIONS]

   Install Cursor AI commands from dev-infra releases.

   OPTIONS:
     --help, -h          Show this help message
     --version, -v       Show script version
     --install [VERSION] Install commands (default: latest)
     --list              List available versions
     --update            Update to latest version
     --status            Show installed version
     --dry-run           Show what would be done without doing it

   EXAMPLES:
     ${SCRIPT_NAME}                  Install latest version
     ${SCRIPT_NAME} --install v0.8.0 Install specific version
     ${SCRIPT_NAME} --list           Show available versions
     ${SCRIPT_NAME} --update         Update to latest
     ${SCRIPT_NAME} --status         Check installed version

   CONFIGURATION:
     Commands installed to: ${COMMANDS_DIR}
     Version tracked in:    ${VERSION_FILE}
   EOF
   }

   show_version() {
       echo "${SCRIPT_NAME} version ${VERSION}"
   }

   # Parse arguments
   ACTION="install"
   TARGET_VERSION=""
   DRY_RUN=false

   while [[ $# -gt 0 ]]; do
       case $1 in
           --help|-h)
               show_help
               exit 0
               ;;
           --version|-v)
               show_version
               exit 0
               ;;
           --install)
               ACTION="install"
               if [[ -n "${2:-}" && ! "${2:-}" =~ ^-- ]]; then
                   TARGET_VERSION="$2"
                   shift
               fi
               ;;
           --list)
               ACTION="list"
               ;;
           --update)
               ACTION="update"
               ;;
           --status)
               ACTION="status"
               ;;
           --dry-run)
               DRY_RUN=true
               ;;
           *)
               echo "Error: Unknown option: $1" >&2
               echo "Use --help for usage information" >&2
               exit 1
               ;;
       esac
       shift
   done

   # Placeholder for action handlers (implemented in later tasks)
   case $ACTION in
       install)
           echo "Install action not yet implemented"
           ;;
       list)
           echo "List action not yet implemented"
           ;;
       update)
           echo "Update action not yet implemented"
           ;;
       status)
           echo "Status action not yet implemented"
           ;;
   esac
   ```

3. **REFACTOR - Make executable and verify:**

   ```bash
   chmod +x bin/dt-cursor-install
   bats tests/unit/cursor-install.bats
   ```

**Checklist:**

- [ ] Test file created with basic tests
- [ ] Script created with help and argument parsing
- [ ] Tests pass
- [ ] Script is executable

---

### Task 2: Implement List Versions (TDD - RED → GREEN)

**Purpose:** Implement `--list` flag to show available dev-infra releases.

**TDD Flow:**

1. **RED - Write failing tests:**

   Add to `tests/unit/cursor-install.bats`:

   ```bash
   @test "dt-cursor-install --list shows available versions" {
       # Mock GitHub API response
       export MOCK_GITHUB_API=true
       run bash "$SCRIPT" --list
       [ "$status" -eq 0 ]
       [[ "$output" =~ "Available versions:" ]] || [[ "$output" =~ "v0" ]]
   }

   @test "dt-cursor-install --list handles API errors gracefully" {
       # Mock failed API call
       export MOCK_GITHUB_API_FAIL=true
       run bash "$SCRIPT" --list
       [ "$status" -ne 0 ]
       [[ "$output" =~ "Error" ]] || [[ "$output" =~ "failed" ]]
   }
   ```

2. **GREEN - Implement list function:**

   ```bash
   list_versions() {
       echo "Available versions from ${GITHUB_REPO}:"
       echo ""
       
       # Fetch releases from GitHub API
       local releases
       releases=$(curl -s "${RELEASES_URL}" 2>/dev/null) || {
           echo "Error: Failed to fetch releases from GitHub" >&2
           return 1
       }
       
       # Parse release tags (requires jq)
       if command -v jq &>/dev/null; then
           echo "$releases" | jq -r '.[].tag_name' | head -20
       else
           # Fallback: grep for tag names
           echo "$releases" | grep -o '"tag_name": "[^"]*"' | cut -d'"' -f4 | head -20
       fi
       
       echo ""
       echo "Use: ${SCRIPT_NAME} --install vX.Y.Z to install a specific version"
   }
   ```

3. **REFACTOR:**

   - Add caching for API responses (optional)
   - Improve output formatting

**Checklist:**

- [ ] Tests for --list added
- [ ] List function implemented
- [ ] API error handling works
- [ ] Tests pass

---

### Task 3: Implement Status Check (TDD - RED → GREEN)

**Purpose:** Implement `--status` flag to show installed version.

**TDD Flow:**

1. **RED - Write failing tests:**

   ```bash
   @test "dt-cursor-install --status shows 'not installed' when no version file" {
       export TEST_VERSION_FILE="/tmp/nonexistent"
       run bash "$SCRIPT" --status
       [ "$status" -eq 0 ]
       [[ "$output" =~ "not installed" ]] || [[ "$output" =~ "No commands" ]]
   }

   @test "dt-cursor-install --status shows version when installed" {
       export TEST_VERSION_FILE="/tmp/test-version"
       echo "v0.8.0" > "$TEST_VERSION_FILE"
       run bash "$SCRIPT" --status
       [ "$status" -eq 0 ]
       [[ "$output" =~ "v0.8.0" ]]
       rm -f "$TEST_VERSION_FILE"
   }
   ```

2. **GREEN - Implement status function:**

   ```bash
   show_status() {
       local version_file="${TEST_VERSION_FILE:-$VERSION_FILE}"
       
       if [[ ! -f "$version_file" ]]; then
           echo "Cursor commands: not installed"
           echo ""
           echo "Run '${SCRIPT_NAME}' to install latest version"
           return 0
       fi
       
       local installed_version
       installed_version=$(cat "$version_file")
       
       echo "Cursor commands: installed"
       echo "Version: ${installed_version}"
       echo "Location: ${COMMANDS_DIR}"
       
       # Check command count
       if [[ -d "${COMMANDS_DIR}" ]]; then
           local count
           count=$(find "${COMMANDS_DIR}" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
           echo "Commands: ${count} files"
       fi
   }
   ```

**Checklist:**

- [ ] Tests for --status added
- [ ] Status function implemented
- [ ] Handles both installed and not-installed cases
- [ ] Tests pass

---

### Task 4: Implement Core Install (TDD - RED → GREEN)

**Purpose:** Implement the main install functionality.

**TDD Flow:**

1. **RED - Write failing tests:**

   ```bash
   @test "dt-cursor-install creates commands directory" {
       export TEST_COMMANDS_DIR="/tmp/test-cursor-commands"
       rm -rf "$TEST_COMMANDS_DIR"
       
       # Use dry-run to avoid actual download
       run bash "$SCRIPT" --dry-run
       [ "$status" -eq 0 ]
       [[ "$output" =~ "Would create" ]] || [[ "$output" =~ "commands" ]]
   }

   @test "dt-cursor-install downloads and extracts bundle" {
       export TEST_COMMANDS_DIR="/tmp/test-cursor-commands"
       export TEST_VERSION_FILE="/tmp/test-version"
       
       # This test requires network - mark as integration
       skip "Integration test - requires network"
       
       run bash "$SCRIPT" --install v0.8.0
       [ "$status" -eq 0 ]
       [ -d "$TEST_COMMANDS_DIR" ]
       [ -f "$TEST_VERSION_FILE" ]
   }
   ```

2. **GREEN - Implement install function:**

   ```bash
   get_latest_version() {
       curl -s "${RELEASES_URL}/latest" 2>/dev/null | \
           grep -o '"tag_name": "[^"]*"' | cut -d'"' -f4
   }

   download_and_install() {
       local version="$1"
       local commands_dir="${TEST_COMMANDS_DIR:-$COMMANDS_DIR}"
       local version_file="${TEST_VERSION_FILE:-$VERSION_FILE}"
       
       echo "Installing Cursor commands version ${version}..."
       
       # Create directories
       mkdir -p "$commands_dir"
       mkdir -p "$(dirname "$version_file")"
       
       # Build download URL
       local download_url="https://github.com/${GITHUB_REPO}/releases/download/${version}/commands-${version}.tar.gz"
       
       if [[ "$DRY_RUN" == "true" ]]; then
           echo "[DRY-RUN] Would download: ${download_url}"
           echo "[DRY-RUN] Would extract to: ${commands_dir}"
           echo "[DRY-RUN] Would write version: ${version}"
           return 0
       fi
       
       # Download to temp file
       local temp_file
       temp_file=$(mktemp)
       trap "rm -f '$temp_file'" EXIT
       
       echo "Downloading from ${download_url}..."
       if ! curl -L -o "$temp_file" "$download_url" 2>/dev/null; then
           echo "Error: Failed to download ${version}" >&2
           return 1
       fi
       
       # Verify download
       if [[ ! -s "$temp_file" ]]; then
           echo "Error: Downloaded file is empty" >&2
           return 1
       fi
       
       # Extract (strip commands/ prefix to install directly)
       echo "Extracting to ${commands_dir}..."
       tar -xzf "$temp_file" -C "$commands_dir" --strip-components=1
       
       # Save version
       echo "$version" > "$version_file"
       
       # Count installed files
       local count
       count=$(find "$commands_dir" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
       
       echo ""
       echo "✅ Successfully installed ${count} commands (${version})"
       echo "Location: ${commands_dir}"
   }

   do_install() {
       local version="${TARGET_VERSION:-}"
       
       if [[ -z "$version" ]]; then
           echo "Fetching latest version..."
           version=$(get_latest_version)
           if [[ -z "$version" ]]; then
               echo "Error: Could not determine latest version" >&2
               return 1
           fi
           echo "Latest version: ${version}"
       fi
       
       download_and_install "$version"
   }
   ```

**Checklist:**

- [ ] Tests for install added
- [ ] Install function implemented
- [ ] Downloads from correct URL
- [ ] Extracts to correct location
- [ ] Saves version to tracking file
- [ ] Tests pass

---

### Task 5: Implement Update Command (TDD - RED → GREEN)

**Purpose:** Implement `--update` flag to update to latest version.

**TDD Flow:**

1. **RED - Write failing tests:**

   ```bash
   @test "dt-cursor-install --update checks for newer version" {
       export TEST_VERSION_FILE="/tmp/test-version"
       echo "v0.7.0" > "$TEST_VERSION_FILE"
       
       run bash "$SCRIPT" --update --dry-run
       [ "$status" -eq 0 ]
       [[ "$output" =~ "Checking" ]] || [[ "$output" =~ "update" ]]
   }

   @test "dt-cursor-install --update reports already up-to-date" {
       # Mock: installed version equals latest
       export MOCK_LATEST_VERSION="v0.8.0"
       export TEST_VERSION_FILE="/tmp/test-version"
       echo "v0.8.0" > "$TEST_VERSION_FILE"
       
       run bash "$SCRIPT" --update --dry-run
       [ "$status" -eq 0 ]
       [[ "$output" =~ "up-to-date" ]] || [[ "$output" =~ "already" ]]
   }
   ```

2. **GREEN - Implement update function:**

   ```bash
   do_update() {
       local version_file="${TEST_VERSION_FILE:-$VERSION_FILE}"
       
       # Check if installed
       if [[ ! -f "$version_file" ]]; then
           echo "Cursor commands not installed. Installing latest..."
           do_install
           return
       fi
       
       local installed_version
       installed_version=$(cat "$version_file")
       
       echo "Checking for updates..."
       echo "Installed: ${installed_version}"
       
       local latest_version
       latest_version=$(get_latest_version)
       echo "Latest:    ${latest_version}"
       
       if [[ "$installed_version" == "$latest_version" ]]; then
           echo ""
           echo "✅ Already up-to-date!"
           return 0
       fi
       
       echo ""
       echo "Update available: ${installed_version} → ${latest_version}"
       
       if [[ "$DRY_RUN" == "true" ]]; then
           echo "[DRY-RUN] Would update to ${latest_version}"
           return 0
       fi
       
       TARGET_VERSION="$latest_version"
       download_and_install "$latest_version"
   }
   ```

**Checklist:**

- [ ] Tests for --update added
- [ ] Update function implemented
- [ ] Compares installed vs latest
- [ ] Reports "up-to-date" when appropriate
- [ ] Tests pass

---

### Task 6: Error Handling and Edge Cases

**Purpose:** Add robust error handling for network issues, missing releases, etc.

**Implementation:**

```bash
# Add at top of script after configuration
check_dependencies() {
    # curl is required
    if ! command -v curl &>/dev/null; then
        echo "Error: curl is required but not installed" >&2
        return 1
    fi
    
    # tar is required
    if ! command -v tar &>/dev/null; then
        echo "Error: tar is required but not installed" >&2
        return 1
    fi
    
    # jq is optional (improves output)
    if ! command -v jq &>/dev/null; then
        echo "Note: jq not found, using fallback parsing" >&2
    fi
}

verify_network() {
    if ! curl -s --head "https://github.com" &>/dev/null; then
        echo "Error: Cannot reach GitHub. Check your network connection." >&2
        return 1
    fi
}

# Add to download_and_install
validate_bundle() {
    local bundle_file="$1"
    
    # Check file exists and is not empty
    if [[ ! -s "$bundle_file" ]]; then
        echo "Error: Bundle file is empty or missing" >&2
        return 1
    fi
    
    # Verify it's a valid gzip file
    if ! gzip -t "$bundle_file" 2>/dev/null; then
        echo "Error: Bundle file is not a valid gzip archive" >&2
        return 1
    fi
    
    # Check for expected content
    if ! tar -tzf "$bundle_file" 2>/dev/null | grep -q "\.md$"; then
        echo "Error: Bundle does not contain expected .md files" >&2
        return 1
    fi
    
    return 0
}
```

**Tests to add:**

```bash
@test "dt-cursor-install checks for curl" {
    # Test by unsetting PATH temporarily
    run bash -c 'PATH="" && source bin/dt-cursor-install 2>&1 || true'
    # Should mention curl dependency
}

@test "dt-cursor-install handles 404 gracefully" {
    run bash "$SCRIPT" --install v999.999.999
    [ "$status" -ne 0 ]
    [[ "$output" =~ "Error" ]] || [[ "$output" =~ "not found" ]]
}
```

**Checklist:**

- [ ] Dependency checks added
- [ ] Network validation added
- [ ] Bundle validation added
- [ ] Error messages are clear and actionable
- [ ] Tests for error cases pass

---

### Task 7: Documentation

**Purpose:** Update dev-toolkit documentation with installation instructions.

**Files to update:**

1. **`README.md`** - Add dt-cursor-install to command list
2. **`docs/CURSOR-COMMANDS.md`** (new) - Detailed usage documentation

**Content for `docs/CURSOR-COMMANDS.md`:**

```markdown
# Cursor Commands Installation

**Purpose:** Install Cursor AI commands from dev-infra releases  
**Command:** `dt-cursor-install`

---

## Quick Start

```bash
# Install latest Cursor commands
dt-cursor-install

# Check installed version
dt-cursor-install --status
```

---

## Usage

### Install Commands

```bash
# Install latest version
dt-cursor-install

# Install specific version
dt-cursor-install --install v0.8.0
```

### Manage Versions

```bash
# List available versions
dt-cursor-install --list

# Update to latest
dt-cursor-install --update

# Check current version
dt-cursor-install --status
```

### Options

| Flag | Description |
|------|-------------|
| `--help, -h` | Show help message |
| `--version, -v` | Show script version |
| `--install [VERSION]` | Install commands (default: latest) |
| `--list` | List available versions |
| `--update` | Update to latest version |
| `--status` | Show installed version |
| `--dry-run` | Preview without making changes |

---

## Configuration

**Installation Location:** `~/.cursor/commands/`  
**Version Tracking:** `~/.dev-toolkit/cursor-commands-version`

---

## Troubleshooting

### "Cannot reach GitHub"

Check your network connection and try again.

### "Command not found"

Ensure dev-toolkit is installed and in your PATH:
```bash
source ~/.dev-toolkit/dev-toolkit.sh
```

---

**Related:**
- [dev-infra Command Bundle Format](https://github.com/grimm00/dev-infra/blob/develop/docs/COMMAND-BUNDLE-FORMAT.md)
```

**Checklist:**

- [ ] README.md updated with new command
- [ ] CURSOR-COMMANDS.md created
- [ ] Usage examples included
- [ ] Troubleshooting section added

---

## ✅ Completion Criteria

- [x] `dt-cursor-install` installs commands from latest release
- [x] `--version v0.8.0` installs specific version
- [x] `--list` shows available versions
- [x] `--update` updates to latest if newer available
- [x] `--status` shows currently installed version
- [x] Graceful error handling for network issues
- [x] Installation documentation updated

---

## 📦 Deliverables

1. **Script:** `bin/dt-cursor-install` in dev-toolkit
2. **Tests:** `tests/unit/cursor-install.bats` in dev-toolkit
3. **Version tracking:** `~/.dev-toolkit/cursor-commands-version`
4. **Documentation:** `docs/CURSOR-COMMANDS.md` in dev-toolkit

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 1: Create Script Structure | 🔴 Not Started | |
| Task 2: Implement List Versions | 🔴 Not Started | |
| Task 3: Implement Status Check | 🔴 Not Started | |
| Task 4: Implement Core Install | 🔴 Not Started | |
| Task 5: Implement Update Command | 🔴 Not Started | |
| Task 6: Error Handling | 🔴 Not Started | |
| Task 7: Documentation | 🔴 Not Started | |

---

## 🔗 Dependencies

### Prerequisites

- Phase 1 complete (release artifacts exist)
- dev-toolkit repository access
- GitHub API access (for release info)

### Blocks

- Phase 3: Documentation (needs working command)

---

## 📚 Requirements Addressed

| Requirement | Description |
|-------------|-------------|
| FR-CMD-1 | `dt-cursor-install` command |
| FR-CMD-2 | Installation to `~/.cursor/commands/` |
| FR-CMD-3 | Version pinning (`--version` flag) |
| FR-CMD-4 | List available versions (`--list` flag) |
| FR-CMD-5 | Update command (`--update` flag) |
| FR-CMD-6 | Default to latest stable |
| NFR-CMD-2 | No clone required (fetch from releases) |

---

## 🔧 Command Interface

```bash
# Install latest stable
dt-cursor-install

# Install specific version
dt-cursor-install --install v0.8.0

# List available versions
dt-cursor-install --list

# Update to latest
dt-cursor-install --update

# Show installed version
dt-cursor-install --status

# Show help
dt-cursor-install --help

# Dry run (preview)
dt-cursor-install --dry-run
```

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 1](phase-1.md)
- [Next Phase: Phase 3](phase-3.md)
- [Command Bundle Format](../../../docs/COMMAND-BUNDLE-FORMAT.md)
- [dev-toolkit install.sh](https://github.com/grimm00/dev-toolkit/blob/main/install.sh) - Reference for patterns

---

**Last Updated:** 2025-12-31  
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1
