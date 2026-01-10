# ADR-001: Command Distribution Ownership

**Status:** ✅ Accepted  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## Context

The Four-Arm Architecture includes Cursor AI commands that need to be distributed to users. Currently, commands exist in dev-infra templates, but there's no mechanism for installing them globally.

**The question:** Who should own the commands (source) and who should distribute them (installation)?

**Related Research:**
- [Research: Command Distribution Ownership](../../research/four-arm-architecture/research-command-distribution-ownership.md)
- [Research Summary](../../research/four-arm-architecture/research-summary.md)

**Related Requirements:**
- FR-CMD-1 through FR-CMD-6 (Command Distribution functional requirements)
- NFR-CMD-1 through NFR-CMD-3 (Command Distribution non-functional requirements)
- C-CMD-1, C-CMD-2 (Command Distribution constraints)

---

## Decision

**dev-infra remains the source owner of all Cursor AI commands. dev-toolkit becomes the distribution owner via a new `dt-cursor-install` command.**

### Ownership Model

| Role | Project | Responsibility |
|------|---------|----------------|
| **Source Owner** | dev-infra | Maintains command content, versions commands with releases |
| **Distribution Owner** | dev-toolkit | Provides `dt-cursor-install`, handles installation mechanics |

### Implementation

1. **dev-infra** continues to maintain commands in `templates/standard-project/.cursor/commands/`
2. **dev-infra** includes commands in GitHub release artifacts (e.g., `commands-v0.8.0.tar.gz`)
3. **dev-toolkit** provides new `dt-cursor-install` command
4. **`dt-cursor-install`** fetches commands from dev-infra releases and copies to `~/.cursor/commands/`

### Command Interface

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
```

---

## Consequences

### Positive

- **Clear separation of concerns:** Source ownership (content) vs distribution ownership (mechanics)
- **Leverages existing infrastructure:** dev-toolkit already has mature `install.sh` and `dt-*` pattern
- **Versioned commands:** Commands tied to dev-infra releases, clear version tracking
- **Industry standard:** Follows established pattern (npm/brew/cargo separate packages from content)
- **User intuition:** "I installed dev-toolkit, it gives me tools including command installation"

### Negative

- **Cross-repo coordination:** Release process requires dev-infra releases before dev-toolkit can distribute
- **Implementation work:** New `dt-cursor-install` command needs to be built
- **Release artifacts:** dev-infra CI needs to produce command bundles

---

## Alternatives Considered

### Alternative 1: Commands in dev-toolkit

**Description:** Move command source from dev-infra to dev-toolkit.

**Pros:**
- Single repository for distribution and source
- Simpler release process

**Cons:**
- Violates dev-infra's identity as "Template Factory"
- Commands are part of template patterns, not developer utilities
- Duplicates content management

**Why not chosen:** Commands are template artifacts, not developer utilities. dev-infra is the appropriate source owner.

---

### Alternative 2: Separate commands repository

**Description:** Create dedicated `cursor-commands` repository.

**Pros:**
- Clean separation
- Independent versioning

**Cons:**
- Yet another repository to maintain
- Fragments the ecosystem unnecessarily
- Commands are integral to templates, not separate

**Why not chosen:** Adds unnecessary complexity. Commands are part of template patterns.

---

### Alternative 3: Installation script in dev-infra

**Description:** Add `install-commands.sh` to dev-infra.

**Pros:**
- Single source for commands and installation
- No cross-repo dependency

**Cons:**
- dev-infra becomes distribution mechanism (not its role)
- Violates "Template Factory" identity
- Users must clone dev-infra to install

**Why not chosen:** dev-infra should remain focused on being the source of patterns, not distribution.

---

## Decision Rationale

**Key Factors:**

1. **Identity preservation:** dev-infra is "Template Factory" (source of patterns), dev-toolkit is "Developer Utilities" (tools for developers)
2. **Existing infrastructure:** dev-toolkit has proven installation infrastructure (`install.sh`, `dt-*` pattern)
3. **User expectations:** When users install dev-toolkit, they expect to get tools that help them work
4. **Industry pattern:** Source/distribution separation is established practice (npm packages vs npm CLI)

**Research Support:**
- Finding 2: dev-toolkit already has mature installation infrastructure
- Finding 3: Industry standard separates source ownership from distribution
- Finding 5: User intuition aligned with this pattern

---

## Requirements Impact

**Requirements Addressed:**
- FR-CMD-1: `dt-cursor-install` command ✅
- FR-CMD-2: Installation to `~/.cursor/commands/` ✅
- FR-CMD-3: Version pinning ✅
- FR-CMD-4: List available versions ✅
- FR-CMD-5: Update command ✅
- FR-CMD-6: Default to latest stable ✅

**Requirements Validated:**
- NFR-CMD-2: No clone required (fetch from releases)
- NFR-CMD-3: Release artifacts needed

**Constraints Satisfied:**
- C-CMD-1: No command duplication (source in dev-infra only)
- C-CMD-2: No content modification (dev-toolkit copies as-is)

---

## Implementation Notes

### Phase 1: dev-infra Changes

1. Update release workflow to include command bundle artifact
2. Document command distribution in release notes

### Phase 2: dev-toolkit Changes

1. Implement `dt-cursor-install` command
2. Add to installation documentation
3. Test with dev-infra releases

### Phase 3: Documentation

1. Create `admin/planning/standards/command-distribution/` standard
2. Update user documentation

---

## References

- [Research: Command Distribution Ownership](../../research/four-arm-architecture/research-command-distribution-ownership.md)
- [Requirements Document](../../research/four-arm-architecture/requirements.md)
- [dev-toolkit install.sh](https://github.com/grimm00/dev-toolkit/blob/main/install.sh)
- [Global Command Distribution Research](../../research/global-command-distribution/README.md)

---

**Last Updated:** 2025-12-31

