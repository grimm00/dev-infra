# Explore Two-Mode Enhancement - Research Hub

**Purpose:** Research for enhancing `/explore` command with two-mode pattern, input sources, and topic unification  
**Status:** ✅ Research Complete  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-09

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

| #   | Research Topic                   | Priority  | Status      | Document                                                                                     |
| --- | -------------------------------- | --------- | ----------- | -------------------------------------------------------------------------------------------- |
| 1   | Command Improvement Organization | 🔴 High   | ✅ Complete | [research-command-improvement-organization.md](research-command-improvement-organization.md) |
| 2   | Topic Unification Pattern        | 🔴 High   | ✅ Complete | [research-topic-unification-pattern.md](research-topic-unification-pattern.md)               |
| 3   | Explore Input Sources            | 🔴 High   | ✅ Complete | [research-explore-input-sources.md](research-explore-input-sources.md)                       |
| 4   | Scaffolding Boundaries           | 🟡 Medium | ✅ Complete | [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)                     |
| 5   | Existing Feature Integration     | 🟡 Medium | ✅ Complete | [research-existing-feature-integration.md](research-existing-feature-integration.md)         |
| 6   | Cross-Command Consistency        | 🟡 Medium | ✅ Complete | [research-cross-command-consistency.md](research-cross-command-consistency.md)               |

### Related Documents

- **[Exploration](../../explorations/explore-two-mode/README.md)** - Source exploration
- **[/explore Command](../../../.cursor/commands/explore.md)** - Current implementation
- **[/research Command](../../../.cursor/commands/research.md)** - Two-mode pattern reference
- **[/transition-plan Command](../../../.cursor/commands/transition-plan.md)** - Two-mode pattern reference

### Related Research

- **[Four-Arm Architecture Research](../four-arm-architecture/)** - Ecosystem context (3/6 topics complete)

---

## 🎯 Research Overview

This research supports enhancing the `/explore` command with three interconnected improvements:

1. **Two-Mode Pattern** - Setup + Conduct modes (like `/research` and `/transition-plan`)
2. **Explicit Input Sources** - Accept raw text, `start.txt`, reflections, worktree files
3. **Topic Unification** - Standardize `--topic [name] --type` vocabulary

Additionally: 4. **Command Improvement Organization** - Consolidate `*-two-mode` features

**Research Topics:** 6 topics (3 High, 3 Medium priority)  
**Status:** ✅ All Complete

---

## 📊 Key Findings

1. **Command improvements are template features** per ADR-001 Template Factory identity
2. **"Topic" = name, "Type" = category** - standardize vocabulary
3. **/explore uniquely handles unstructured input** - two-mode as "thought organizer"
4. **ADR-002 scaffolding pattern applies** - ~60-80 lines setup, ~200-300 conduct
5. **Use `--conduct` flag** for `/explore` (matches `/research` semantics)
6. **Existing feature plan is valid** - update with expanded scope after decisions

---

## 🚀 Next Steps

1. ✅ All 6 research topics complete
2. Use `/decision explore-two-mode --from-research` to make decisions
3. After decisions, update existing feature plan with expanded scope
4. Use `/transition-plan --from-adr` to create implementation plan

---

**Last Updated:** 2026-01-09
