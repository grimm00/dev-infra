# Experimental Template Archive (v0.6.0)

**Feature:** Experimental Project Template  
**Created:** v0.6.0 (2025-12-15)  
**Removed:** v0.7.0 (2025-12-18)  
**Status:** 📦 Archived

---

## 📋 Overview

The experimental template was a third project template type designed to provide a staging ground for testing new commands before graduating them to the standard template.

**Key Features (when active):**
- Same structure as standard-project with additional features
- Stability indicators (🟢 Stable, 🟠 Evolving, 🔴 Deprecated)
- Graduation checklist based on ADR-004
- `/status` command as example evolving command

---

## 🗂️ Contents

| Directory | Contents |
|-----------|----------|
| `planning/` | Feature plans, phase documents, status tracking |
| `explorations/` | Initial exploration and research topics |
| `research/` | Detailed research on implementation approaches |
| `decisions/` | ADRs for the experimental template feature |

---

## ❓ Why Archived

**Decision:** [ADR-001: Commands as Guides](../../decisions/command-simplification/adr-001-commands-as-guides.md)

The command simplification effort determined that:
1. Commands are AI guidance, not CLI tools
2. Internal projects don't need graduation gates
3. The graduation process was over-engineering
4. All templates should have all commands

**Result:** The experimental template was merged into the standard template, and all commands are now available to all templates.

---

## 🔗 Related

- [ADR-001: Commands as Guides](../../decisions/command-simplification/adr-001-commands-as-guides.md)
- [v0.6.0 Release Notes](../../planning/releases/v0.6.0/RELEASE-NOTES.md) - When experimental was added
- [v0.7.0 Release Notes](../../planning/releases/v0.7.0/RELEASE-NOTES.md) - When experimental was removed

---

**Archived:** 2025-12-18

