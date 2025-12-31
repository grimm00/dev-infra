# Command Distribution - Feature Hub

**Purpose:** Implement command distribution system from dev-infra to dev-toolkit  
**Status:** 🔴 Not Started  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## 📋 Quick Links

### Planning Documents

- **[Feature Plan](feature-plan.md)** - Overview and success criteria
- **[Transition Plan](transition-plan.md)** - Implementation overview from ADR

### Phase Documents

| Phase | Name | Status | Effort |
|-------|------|--------|--------|
| [Phase 1](phase-1.md) | dev-infra Release Artifacts | ✅ Expanded | ~2-3 hrs |
| [Phase 2](phase-2.md) | dt-cursor-install Implementation | 🔴 Scaffolding | ~4-6 hrs |
| [Phase 3](phase-3.md) | Documentation & Standard | 🔴 Scaffolding | ~2-3 hrs |
| [Phase 4](phase-4.md) | Integration Validation | 🔴 Scaffolding | ~2-3 hrs |

### Related Documents

- **[ADR-001: Command Distribution Ownership](../../../decisions/four-arm-architecture/adr-001-command-distribution-ownership.md)** - Architecture decision
- **[ADR-002: Contract Coordination Strategy](../../../decisions/four-arm-architecture/adr-002-contract-coordination-strategy.md)** - Standards pattern (Phase 3)
- **[ADR-003: Integration Architecture](../../../decisions/four-arm-architecture/adr-003-integration-architecture.md)** - Integration validation (Phase 4)
- **[Requirements](../../../research/four-arm-architecture/requirements.md)** - Related requirements (FR-CMD-*, NFR-IP-*)
- **[Research](../../../research/four-arm-architecture/research-command-distribution-ownership.md)** - Supporting research

---

## 🎯 Overview

Implement the command distribution system that allows Cursor AI commands to be:
- Sourced from dev-infra templates
- Distributed via dev-toolkit's `dt-cursor-install` command
- Installed globally to `~/.cursor/commands/`

**Decision:** dev-infra = source owner, dev-toolkit = distribution owner

This feature addresses all three Four-Arm Architecture ADRs:
- **ADR-001:** Command distribution ownership (Phases 1-2)
- **ADR-002:** Contract coordination via standards (Phase 3)
- **ADR-003:** Integration architecture validation (Phase 4)

---

## 🏗️ Architecture

```
dev-infra (Source Owner)
├── templates/standard-project/.cursor/commands/  ← Command source
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

## ✅ Requirements Addressed

| Requirement | Description | Priority |
|-------------|-------------|----------|
| FR-CMD-1 | `dt-cursor-install` command | High |
| FR-CMD-2 | Installation to `~/.cursor/commands/` | High |
| FR-CMD-3 | Version pinning (`--version` flag) | High |
| FR-CMD-4 | List available versions (`--list` flag) | Medium |
| FR-CMD-5 | Update command (`--update` flag) | Medium |
| FR-CMD-6 | Default to latest stable | Medium |
| NFR-CMD-2 | No clone required | High |
| NFR-CMD-3 | Release artifacts | High |
| NFR-IP-1 | All integrations optional | High |
| NFR-IP-2 | Offline core functionality | High |
| NFR-IP-3 | XDG configuration pattern | Medium |
| NFR-IP-4 | No runtime dependencies | High |

---

## 📊 Progress

| Metric | Value |
|--------|-------|
| Total Phases | 4 |
| Completed | 0 |
| In Progress | 0 |
| Estimated Total | 10-15 hrs |

---

## 🚀 Next Steps

1. **Review scaffolding** - Verify phase breakdown is correct
2. **Expand phases** - Run `/transition-plan command-distribution --expand --phase N`
3. **Implement Phase 1** - dev-infra release artifacts

---

**Last Updated:** 2025-12-31
