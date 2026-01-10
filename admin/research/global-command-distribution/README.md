# Global Command Distribution - Research Hub

**Purpose:** Research for distributing dev-infra commands globally via `~/.cursor/commands/`  
**Status:** 🟡 Research  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

- **[Installation Methods](research-installation-methods.md)** - How to install commands (script, proj-cli, manual)
- **[Version Management](research-version-management.md)** - How to version and track global commands
- **[Project vs Global Scope](research-project-vs-global-scope.md)** - When to use project vs global, workspace context
- **[Update Strategy](research-update-strategy.md)** - How to handle command updates

---

## 🎯 Research Overview

This research addresses how dev-infra should distribute commands globally now that we've validated Cursor supports `~/.cursor/commands/`.

**Validated Facts (from exploration):**
- ✅ Global commands work from `~/.cursor/commands/`
- ✅ Project commands override global (clean isolation)
- ❌ Global rules do NOT work (`~/.cursor/rules/` not loaded)

**Research Topics:** 4 topics  
**Status:** 🟡 Research

---

## 📊 Research Status

| Research Topic | Priority | Status | Document |
|----------------|----------|--------|----------|
| Installation Methods | 🔴 High | 🔴 Not Started | [research-installation-methods.md](research-installation-methods.md) |
| Version Management | 🟠 Medium | 🔴 Not Started | [research-version-management.md](research-version-management.md) |
| Project vs Global Scope | 🔴 High | 🔴 Not Started | [research-project-vs-global-scope.md](research-project-vs-global-scope.md) |
| Update Strategy | 🟠 Medium | 🔴 Not Started | [research-update-strategy.md](research-update-strategy.md) |

---

## 🔗 Related

- **[Exploration: Dev-Infra Identity v4](../../explorations/dev-infra-identity-and-focus/README.md)** - Source exploration
- **[Research Topic 7](../../explorations/dev-infra-identity-and-focus/research-topics.md#research-topic-7-global-command-distribution-v4--researched)** - Research topic definition

---

## 🚀 Next Steps

1. Complete research documents for each topic
2. Review requirements in `requirements.md`
3. Use `/decision global-command-distribution --from-research` to make decisions

---

**Last Updated:** 2025-12-22



