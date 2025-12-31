# Command Distribution - Standard Hub

**Purpose:** Establish dev-infra as source owner and dev-toolkit as distribution owner for Cursor AI commands  
**Status:** ✅ Active (Standard Established)  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31  
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

**Last Updated:** 2025-12-31

