# Command Distribution - Phase 3: Documentation & Standard

**Phase:** 3 - Documentation & Standard  
**Duration:** ~2-3 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 1 complete (release artifacts available)

**Note:** This phase can run in parallel with Phase 2 since it only requires the artifacts format (Phase 1), not the working command (Phase 2). Tasks 1-3 can be done now; Task 4 may need minor updates after Phase 2 is complete.

---

## 📋 Overview

Document the command distribution pattern as a cross-arm standard following the OpenAPI Source of Truth pattern, and update user-facing documentation.

**Success Definition:** Command distribution documented as a standard with ownership matrix, process requirements, and user documentation updated.

---

## 🎯 Goals

1. **Create standard** - Document command distribution in `admin/planning/standards/`
2. **Follow pattern** - Use OpenAPI standard as template (ownership matrix, process requirements)
3. **Update docs** - Update user documentation for global commands

---

## 📝 Tasks

### Task 1: Create Standard Directory Structure

**Purpose:** Create the standard directory and hub README following the OpenAPI pattern.

**Location:** `admin/planning/standards/command-distribution/`

**Process:**

1. **Create directory:**
   ```bash
   mkdir -p admin/planning/standards/command-distribution
   ```

2. **Create README.md (hub):**

   **File:** `admin/planning/standards/command-distribution/README.md`

   ```markdown
   # Command Distribution - Standard Hub

   **Purpose:** Establish dev-infra as source owner and dev-toolkit as distribution owner for Cursor AI commands  
   **Status:** ✅ Active (Standard Established)  
   **Created:** YYYY-MM-DD  
   **Last Updated:** YYYY-MM-DD  
   **Type:** Process Standard

   ---

   ## 📋 Quick Links

   - **[ADR-001](../../../decisions/four-arm-architecture/adr-001-command-distribution-ownership.md)** - Decision record (ownership)
   - **[ADR-002](../../../decisions/four-arm-architecture/adr-002-contract-coordination-strategy.md)** - Decision record (coordination)
   - **[Command Bundle Format](../../../../docs/COMMAND-BUNDLE-FORMAT.md)** - Bundle specification

   ### Related Requirements

   - **[Requirements](../../../research/four-arm-architecture/requirements.md)** - FR-CMD-*, NFR-CMD-*, C-CMD-*

   ---

   ## 🎯 Standard Overview

   Cursor AI commands are authored and maintained in dev-infra templates, then distributed to users via dev-toolkit's `dt-cursor-install` command.

   **This is a process standard** - it establishes guidelines for how command updates are handled and distributed across the ecosystem.

   ---

   ## 🏢 Ownership Matrix

   | Arm | Role | Responsibilities |
   |-----|------|------------------|
   | **dev-infra** | Source Owner | Maintains commands in `templates/standard-project/.cursor/commands/`, releases as bundles |
   | **dev-toolkit** | Distribution Owner | Provides `dt-cursor-install` command, fetches from dev-infra releases |
   | **Generated Projects** | Template Consumers | Receive commands at project creation time |
   | **proj-cli** | N/A | No direct involvement in command distribution |
   | **work-prod** | N/A | No direct involvement in command distribution |

   ---

   ## 🔄 Distribution Model

   ```
   dev-infra (Source Owner)
   ├── templates/standard-project/.cursor/commands/  ← Command source (19 commands)
   └── GitHub Releases
       └── commands-vX.Y.Z.tar.gz  ← Release artifact

   dev-toolkit (Distribution Owner)
   └── bin/dt-cursor-install  ← Installation command
       ├── Fetches from dev-infra releases
       └── Copies to ~/.cursor/commands/

   User Machine
   └── ~/.cursor/commands/  ← Installed commands (global)
   ```

   ---

   ## ✅ Process Requirements

   ### PR-1: Command Updates in dev-infra

   **Owner:** dev-infra  
   **Rule:** Command updates MUST be made in `templates/standard-project/.cursor/commands/`

   **Rationale:** Commands live in templates so generated projects get them automatically. The bundle is created from this source during release.

   ### PR-2: Release Bundle Generation

   **Owner:** dev-infra (via CI/CD)  
   **Rule:** Release workflow MUST generate `commands-vX.Y.Z.tar.gz` bundle

   **Rationale:** Separate bundle allows lightweight installation without full template download.

   ### PR-3: Template Sync

   **Owner:** dev-infra  
   **Rule:** Commands MUST be synced between `standard-project` and `learning-project` templates

   **Rationale:** All templates provide the same command set (per ADR-001: Commands as Guides).

   ### PR-4: Distribution Stability

   **Owner:** dev-toolkit  
   **Rule:** `dt-cursor-install` MUST support version pinning and graceful degradation

   **Rationale:** Users should be able to install specific versions and handle network failures gracefully.

   ---

   ## 📊 Compliance Checklist

   **For dev-infra PRs with command changes:**

   - [ ] Commands updated in `templates/standard-project/.cursor/commands/`
   - [ ] Commands synced to `templates/learning-project/.cursor/commands/`
   - [ ] Template sync validation passes in CI
   - [ ] Release notes mention command changes

   **For dev-infra releases:**

   - [ ] `commands-vX.Y.Z.tar.gz` bundle created
   - [ ] Bundle contains VERSION metadata file
   - [ ] SHA256 checksum generated
   - [ ] Bundle validated (19+ commands, key files present)

   **For dev-toolkit PRs with dt-cursor-install:**

   - [ ] `--version` flag works for specific versions
   - [ ] `--list` shows available versions
   - [ ] `--status` shows installed version
   - [ ] Network errors handled gracefully

   ---

   ## 🚫 Constraints

   ### C-CMD-1: No Command Duplication

   Commands MUST NOT be duplicated across projects. dev-infra is the single source.

   **Rationale:** Prevents drift and maintenance burden.

   ### C-CMD-2: No Content Modification

   `dt-cursor-install` MUST NOT modify command content during installation.

   **Rationale:** Ensures consistency between source and installed commands.

   ---

   ## 🔗 Reference

   - **Command Source:** `dev-infra/templates/standard-project/.cursor/commands/`
   - **Bundle Format:** `commands-vX.Y.Z.tar.gz` (see [Bundle Format](../../../../docs/COMMAND-BUNDLE-FORMAT.md))
   - **Install Command:** `dt-cursor-install` (dev-toolkit)
   - **Global Install Location:** `~/.cursor/commands/`

   ---

   **Last Updated:** YYYY-MM-DD
   ```

3. **Verify structure:**
   ```bash
   ls -la admin/planning/standards/command-distribution/
   # Should show README.md
   ```

**Checklist:**

- [ ] Directory created
- [ ] README.md created with full content
- [ ] Ownership matrix documented
- [ ] Process requirements defined
- [ ] Compliance checklist included
- [ ] Constraints documented

---

### Task 2: Update Standards Hub

**Purpose:** Link the new standard from the main standards README.

**File:** `admin/planning/standards/README.md`

**Process:**

1. **Check if standards hub exists:**
   ```bash
   ls admin/planning/standards/README.md
   ```

2. **If exists, add entry for command-distribution:**

   ```markdown
   ## 📋 Active Standards

   | Standard | Type | Status | Description |
   |----------|------|--------|-------------|
   | [OpenAPI Source of Truth](openapi-source-of-truth/README.md) | Process | ✅ Active | API spec as single source of truth |
   | [Command Distribution](command-distribution/README.md) | Process | ✅ Active | Command ownership and distribution |
   ```

3. **If not exists, create hub:**

   ```markdown
   # Standards Hub

   **Purpose:** Central hub for cross-arm standards  
   **Status:** ✅ Active  
   **Last Updated:** YYYY-MM-DD

   ---

   ## 📋 Active Standards

   | Standard | Type | Status | Description |
   |----------|------|--------|-------------|
   | [OpenAPI Source of Truth](openapi-source-of-truth/README.md) | Process | ✅ Active | API spec as single source of truth |
   | [Command Distribution](command-distribution/README.md) | Process | ✅ Active | Command ownership and distribution |

   ---

   ## 🎯 Standards Overview

   Standards document cross-arm coordination patterns and process requirements. Each standard follows a consistent structure:

   - **README.md** - Standard overview and ownership matrix
   - **Process Requirements** - Rules for spec owners and consumers
   - **Compliance Checklist** - PR review items

   ---

   ## 🔗 Related

   - [ADR Index](../../decisions/README.md) - Architecture decision records
   - [Four-Arm Architecture ADRs](../../decisions/four-arm-architecture/) - Cross-arm decisions

   ---

   **Last Updated:** YYYY-MM-DD
   ```

**Checklist:**

- [ ] Standards hub exists (or created)
- [ ] Command-distribution standard linked
- [ ] Status shown as Active

---

### Task 3: Update Global Commands Guide

**Purpose:** Update user documentation with command distribution information.

**File:** `docs/GLOBAL-COMMANDS.md`

**Process:**

1. **Read current file:**
   ```bash
   cat docs/GLOBAL-COMMANDS.md
   ```

2. **Update/add installation section:**

   Add or update the following content:

   ```markdown
   ## Installation

   ### Using dt-cursor-install (Recommended)

   If you have dev-toolkit installed:

   ```bash
   # Install latest commands
   dt-cursor-install

   # Install specific version
   dt-cursor-install --install v0.8.0

   # Check installed version
   dt-cursor-install --status

   # Update to latest
   dt-cursor-install --update

   # List available versions
   dt-cursor-install --list
   ```

   ### Manual Installation

   Download and extract from dev-infra releases:

   ```bash
   # Download specific version
   VERSION="0.8.0"
   curl -L -o "commands-v${VERSION}.tar.gz" \
     "https://github.com/grimm00/dev-infra/releases/download/v${VERSION}/commands-v${VERSION}.tar.gz"

   # Create directory
   mkdir -p ~/.cursor/commands

   # Extract
   tar -xzf "commands-v${VERSION}.tar.gz" -C ~/.cursor --strip-components=1

   # Verify
   ls ~/.cursor/commands/
   ```

   ### From Template (Project Creation)

   When creating a new project with dev-infra templates:

   ```bash
   ./scripts/new-project.sh my-project
   ```

   Commands are automatically included in `.cursor/commands/`.

   ---

   ## Version Tracking

   Installed version is tracked in `~/.dev-toolkit/cursor-commands-version`.

   ```bash
   # Check installed version
   cat ~/.dev-toolkit/cursor-commands-version
   ```

   ---

   ## Updating Commands

   ```bash
   # Check for updates
   dt-cursor-install --status

   # Update to latest
   dt-cursor-install --update
   ```

   ---
   ```

3. **Verify links work:**
   - Check that referenced files exist
   - Verify download URLs are correct format

**Checklist:**

- [ ] GLOBAL-COMMANDS.md updated
- [ ] Installation methods documented (dt-cursor-install, manual, template)
- [ ] Version tracking explained
- [ ] Update process documented
- [ ] Links verified

---

### Task 4: Update Related Documentation

**Purpose:** Add cross-references to related documentation.

**Files to update:**

1. **docs/README.md** - Ensure Global Commands guide is linked
2. **COMMAND-BUNDLE-FORMAT.md** - Link to standard

**Process:**

1. **Verify docs/README.md has link:**
   - Should already have link from Phase 1
   - If not, add to appropriate section

2. **Update COMMAND-BUNDLE-FORMAT.md:**

   Add reference to standard:

   ```markdown
   ## 📚 Related Documentation

   - **[ADR-001: Command Distribution Ownership](../admin/decisions/four-arm-architecture/adr-001-command-distribution-ownership.md)** - Architecture decision
   - **[Command Distribution Standard](../admin/planning/standards/command-distribution/README.md)** - Process standard
   - **[Global Commands Guide](GLOBAL-COMMANDS.md)** - User guide for global commands
   - **[Template Usage](TEMPLATE-USAGE.md)** - How to use dev-infra templates
   ```

3. **Update feature hub (README.md):**

   Link to new standard from feature planning:

   ```markdown
   ### Related Standards

   - **[Command Distribution Standard](../../../standards/command-distribution/README.md)** - Process standard (Phase 3 deliverable)
   ```

**Checklist:**

- [ ] docs/README.md verified
- [ ] COMMAND-BUNDLE-FORMAT.md updated with standard link
- [ ] Feature hub updated with standard link

---

### Task 5: Verification and Commit

**Purpose:** Verify all documentation is correct and commit changes.

**Process:**

1. **Verify all files created:**
   ```bash
   ls admin/planning/standards/command-distribution/
   ls admin/planning/standards/README.md
   cat docs/GLOBAL-COMMANDS.md | head -50
   ```

2. **Check for broken links:**
   ```bash
   # Verify linked files exist
   ls admin/decisions/four-arm-architecture/adr-001-command-distribution-ownership.md
   ls admin/decisions/four-arm-architecture/adr-002-contract-coordination-strategy.md
   ls docs/COMMAND-BUNDLE-FORMAT.md
   ```

3. **Commit changes:**
   ```bash
   git add admin/planning/standards/command-distribution/
   git add admin/planning/standards/README.md
   git add docs/GLOBAL-COMMANDS.md
   git add docs/COMMAND-BUNDLE-FORMAT.md
   git add admin/planning/features/command-distribution/README.md

   git commit -m "docs(standards): create command-distribution standard

   Create command distribution standard following OpenAPI pattern:
   - admin/planning/standards/command-distribution/README.md
   - Ownership matrix (dev-infra source, dev-toolkit distribution)
   - Process requirements (PR-1 through PR-4)
   - Compliance checklist

   Update related documentation:
   - docs/GLOBAL-COMMANDS.md - Installation methods
   - docs/COMMAND-BUNDLE-FORMAT.md - Link to standard
   - admin/planning/standards/README.md - Standards hub

   Addresses ADR-002 requirement to document command-distribution standard."
   ```

4. **Push to develop:**
   ```bash
   git push origin develop
   ```

**Checklist:**

- [ ] All files verified
- [ ] No broken links
- [ ] Changes committed
- [ ] Pushed to develop

---

## ✅ Completion Criteria

- [x] Standard directory created with README.md
- [x] Ownership matrix documented (dev-infra = source, dev-toolkit = distribution)
- [x] Process requirements defined (PR-1 through PR-4)
- [x] Compliance checklist included
- [x] User documentation updated (GLOBAL-COMMANDS.md)
- [x] Standard linked from main standards README
- [x] Cross-references added

---

## 📦 Deliverables

1. **Standard Hub:** `admin/planning/standards/command-distribution/README.md`
2. **Standards Index:** Updated `admin/planning/standards/README.md`
3. **User Guide:** Updated `docs/GLOBAL-COMMANDS.md`
4. **Cross-references:** Updated related documentation

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 1: Create Standard Directory | 🔴 Not Started | |
| Task 2: Update Standards Hub | 🔴 Not Started | |
| Task 3: Update Global Commands Guide | 🔴 Not Started | Can parallel with Phase 2 |
| Task 4: Update Related Documentation | 🔴 Not Started | |
| Task 5: Verification and Commit | 🔴 Not Started | |

---

## 🔗 Dependencies

### Prerequisites

- Phase 1 complete (release artifacts format defined)
- Note: Phase 2 NOT required - can run in parallel

### Blocks

- Phase 4: Integration Validation (needs command distribution standard documented)

---

## 📚 Requirements Addressed

| Requirement | Description |
|-------------|-------------|
| FR-SC-4 | Standards pattern extension - New contracts follow OpenAPI pattern |
| C-CMD-1 | No command duplication (documented in standard) |
| C-CMD-2 | No content modification (documented in standard) |

---

## 🏗️ Standard Structure

Following the OpenAPI Source of Truth pattern:

```
admin/planning/standards/command-distribution/
└── README.md              # Standard overview (includes ownership matrix, process requirements)
```

### Ownership Matrix (documented in README)

| Role | Project | Responsibility |
|------|---------|----------------|
| Source Owner | dev-infra | Maintains commands in templates |
| Distribution Owner | dev-toolkit | Provides `dt-cursor-install` |
| N/A | proj-cli | No direct involvement |
| N/A | work-prod | No direct involvement |

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 2](phase-2.md)
- [Next Phase: Phase 4](phase-4.md)
- [OpenAPI Standard](../../standards/openapi-source-of-truth/README.md) - Pattern to follow
- [ADR-002: Contract Coordination Strategy](../../../decisions/four-arm-architecture/adr-002-contract-coordination-strategy.md) - Requires this standard

---

**Last Updated:** 2025-12-31  
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1 (can run in parallel with Phase 2)
