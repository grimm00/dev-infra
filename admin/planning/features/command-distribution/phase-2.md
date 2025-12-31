# Command Distribution - Phase 2: dt-cursor-install Implementation

**Phase:** 2 - dt-cursor-install Implementation  
**Duration:** ~4-6 hours  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** Phase 1 complete (release artifacts available)

---

## 📋 Overview

Implement the `dt-cursor-install` command in dev-toolkit that fetches commands from dev-infra releases and installs them to `~/.cursor/commands/`.

**Success Definition:** Users can run `dt-cursor-install` to install Cursor AI commands globally with version control support.

---

## 🎯 Goals

1. **Core installation** - Fetch and copy commands to `~/.cursor/commands/`
2. **Version support** - Support `--version` flag for specific versions
3. **List versions** - Support `--list` flag to show available versions
4. **Update command** - Support `--update` flag to update to latest
5. **Status check** - Support `--status` flag to show installed version

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan command-distribution --expand --phase 2` to add detailed TDD tasks.

### Task Categories

- [ ] **Core Script** - Create `bin/dt-cursor-install` with basic structure
- [ ] **Fetch Logic** - Download release artifact from GitHub
- [ ] **Install Logic** - Extract and copy to `~/.cursor/commands/`
- [ ] **Version Flags** - Implement `--version`, `--list`, `--update`, `--status`
- [ ] **Version Tracking** - Track installed version for update detection
- [ ] **Error Handling** - Handle network errors, missing releases, etc.
- [ ] **Documentation** - Update installation docs

---

## ✅ Completion Criteria

- [ ] `dt-cursor-install` installs commands from latest release
- [ ] `--version v0.8.0` installs specific version
- [ ] `--list` shows available versions
- [ ] `--update` updates to latest if newer available
- [ ] `--status` shows currently installed version
- [ ] Graceful error handling for network issues
- [ ] Installation documentation updated

---

## 📦 Deliverables

- `bin/dt-cursor-install` script
- Version tracking file (`~/.dev-toolkit/cursor-commands-version`)
- Updated installation documentation

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
dt-cursor-install --version v0.8.0

# List available versions
dt-cursor-install --list

# Update to latest
dt-cursor-install --update

# Show installed version
dt-cursor-install --status

# Show help
dt-cursor-install --help
```

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 1](phase-1.md)
- [Next Phase: Phase 3](phase-3.md)
- [dev-toolkit install.sh](https://github.com/grimm00/dev-toolkit/blob/main/install.sh) - Reference for patterns

---

**Last Updated:** 2025-12-31  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan command-distribution --expand --phase 2`

