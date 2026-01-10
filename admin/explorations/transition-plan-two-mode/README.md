# Transition-Plan Two-Mode Pattern - Exploration Hub

**Purpose:** Explore redesigning `/transition-plan` command with setup + expand modes  
**Status:** 🔴 Exploration  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29

---

## 📋 Quick Links

- **[Exploration Document](exploration.md)** - Main exploration document
- **[Research Topics](research-topics.md)** - Research questions to investigate
- **[Source Opportunity](../../planning/opportunities/internal/dev-infra/improvements/transition-plan-two-mode-pattern.md)** - Original opportunity document

---

## 🎯 Overview

Redesigning the `/transition-plan` command to follow a two-mode pattern (like `/research`):

1. **Setup Mode (default):** Creates scaffolding (transition-plan.md, phase-N.md headers)
2. **Expand Mode (`--expand`):** Fills in detail with TDD task ordering

**Why This Matters:**

- **First fully-utilized global command** - Installed to `~/.cursor/commands/` per v4 global command discovery
- **Follows proven pattern** - Same as `/research` + `--conduct`
- **Addresses real problems** - Variable output, inconsistent TDD ordering, no human review opportunity

---

## 📊 Status

**Current Phase:** Exploration  
**Next Step:** Conduct research on topics identified in research-topics.md

---

## 🔗 Related Context

- **[Dev-Infra Identity v4](../dev-infra-identity-and-focus/exploration.md)** - Global command discovery
- **[ADR-001: Commands as Guides](../../decisions/command-simplification/adr-001-commands-as-guides.md)** - Command philosophy
- **[Current transition-plan.md](../../../.cursor/commands/transition-plan.md)** - Existing command (1096 lines)

---

**Last Updated:** 2025-12-29


