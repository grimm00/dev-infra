# Dev-Infra Identity & Focus - Exploration Hub

**Purpose:** Define dev-infra's identity and focus areas for future development  
**Status:** 🟠 Active Exploration (v4)  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-22

---

## 📋 Quick Links

- **[Exploration Document](exploration.md)** - Main exploration with six scenarios
- **[Research Topics](research-topics.md)** - Research questions to investigate
- **[proj-cli Architecture Exploration](https://github.com/grimm00/proj-cli/blob/develop/docs/maintainers/planning/explorations/proj-cli-architecture/exploration.md)** - Related: CLI integration design

---

## 🎯 Overview

This exploration defines what dev-infra should be and what problems it should solve.

### v4 Focus (2025-12-22) — Global Commands Discovery 🎉

**Key Discovery:** Cursor supports global commands from `~/.cursor/commands/`!

**Research Complete (2025-12-22):**

| Feature | Status | Notes |
|---------|--------|-------|
| Global commands | ✅ Works | `~/.cursor/commands/` loaded |
| Project override | ✅ Works | Project commands take priority |
| Clean isolation | ✅ Works | Agent unaware of global when project exists |
| Global rules | ❌ Not Supported | `~/.cursor/rules/` NOT loaded |

**Architecture Confirmed:**

| Level | Commands | Rules |
|-------|----------|-------|
| Global (`~/.cursor/`) | ✅ Fallback | ❌ Not supported |
| Project (`.cursor/`) | ✅ Override | ✅ Required |

**Implication:** Templates may no longer need embedded commands — users can install globally from dev-infra. Rules must remain per-project.

### v3 Focus (2025-12-22)

**Key Insight:** proj-cli should be the unified CLI; dev-infra is the "template layer."

Rather than building CLI tooling into dev-infra, we extend proj-cli with:
- `proj new [name]` - Create project from dev-infra template
- `proj sync` - Sync template updates to existing projects
- Local registry at `~/.dev-infra/registry.json`

**Research Topic 6 (CLI vs Script) is now RESOLVED:** Use proj-cli.

### v2 Focus (2025-12-18)

After completing v0.7.0 (Command Simplification), we have new clarity:

**Key Insight:** There are no external users yet. Dev-infra serves its creator, and learnings from project creation inform template improvements.

**New Direction:** Infrastructure management for six scenarios:

| Scenario | Status | Description |
|----------|--------|-------------|
| New Projects | ✅ Supported | Generate from templates |
| External Sync | 🔴 Not Supported | Adopt dev-infra in existing projects |
| Update Sync | ⚠️ Partial | Push template updates to projects |
| Template Tagging | 🔴 Not Supported | Metadata for project identification |
| proj-cli Integration | 🔴 Exploring | Unified CLI via proj-cli (v3) |
| Global Commands | ✅ Validated | Install commands to `~/.cursor/commands/` (NEW v4) |

---

## 📊 Status

**Current Phase:** v4 Exploration  
**Previous Phases:**
- v1 Exploration → ADR-001 (Commands as Guides)
- v2 Exploration → Four scenarios defined
- v3 Exploration → proj-cli integration concept
**Next Step:** Research global command distribution architecture

---

## 🔗 Related

### In This Project

- [ADR-001: Commands as Guides](../../decisions/command-simplification/adr-001-commands-as-guides.md) - Result of v1 exploration
- [ADR-001: Project Identity](../../decisions/dev-infra-identity-and-focus/adr-001-project-identity.md) - Template Factory identity
- [Template Metadata Research](../../research/template-metadata/README.md) - Metadata format research
- [Work-Prod Integration Research](../../research/work-prod-integration/README.md) - Local registry research

### In proj-cli

- [proj-cli Architecture Exploration](https://github.com/grimm00/proj-cli/blob/develop/docs/maintainers/planning/explorations/proj-cli-architecture/exploration.md) - CLI integration design
- [ADR-0007: Unified CLI Architecture](https://github.com/grimm00/proj-cli/blob/develop/docs/maintainers/decisions/ADR-0007-unified-cli-architecture.md) - Existing proj-cli architecture

---

**Last Updated:** 2025-12-22
