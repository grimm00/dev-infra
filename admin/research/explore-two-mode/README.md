# Explore Two-Mode Enhancement - Research Hub

**Purpose:** Research for enhancing `/explore` command with two-mode pattern, input sources, and topic unification  
**Status:** ⏸️ Paused (awaiting four-arm-architecture)  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-31

---

## ⚠️ Research Pivot Notice

**Status:** This research is **paused** pending completion of [Four-Arm Architecture](../../explorations/four-arm-architecture/) research.

**Why the pivot?**

During Topic 1 research, we identified that dev-infra is not just a "template factory" but the **standard setter** for the entire four-arm architecture ecosystem:

| Project         | Role                 | Relationship                                 |
| --------------- | -------------------- | -------------------------------------------- |
| **dev-infra**   | Standard setter      | Source of truth for patterns, commands, docs |
| **dev-toolkit** | Utility distribution | Installs dev-infra commands globally         |
| **proj-cli**    | Lifecycle management | Uses dev-infra patterns                      |
| **work-prod**   | Data backend         | Uses dev-infra template structure            |

This foundational context affects how we approach:

- **Topic 2 (Topic Unification)** - Need to understand cross-project command patterns
- **Topic 3 (Input Sources)** - Need to understand how projects share state
- **Topic 6 (Cross-Command Consistency)** - Need to understand inter-project coordination

**Resume after:** Complete `/research four-arm-architecture` and `/decision four-arm-architecture`

**Insight captured during pivot:** `/explore` uniquely accepts unstructured "raw thoughts" input, making two-mode valuable as a "thought organizer" → see [research-explore-input-sources.md](research-explore-input-sources.md)

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

| #   | Research Topic                   | Priority  | Status         | Document                                                                                     |
| --- | -------------------------------- | --------- | -------------- | -------------------------------------------------------------------------------------------- |
| 1   | Command Improvement Organization | 🔴 High   | ✅ Complete    | [research-command-improvement-organization.md](research-command-improvement-organization.md) |
| 2   | Topic Unification Pattern        | 🔴 High   | 🔴 Not Started | [research-topic-unification-pattern.md](research-topic-unification-pattern.md)               |
| 3   | Explore Input Sources            | 🔴 High   | 🔴 Not Started | [research-explore-input-sources.md](research-explore-input-sources.md)                       |
| 4   | Scaffolding Boundaries           | 🟡 Medium | 🔴 Not Started | [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)                     |
| 5   | Existing Feature Integration     | 🟡 Medium | 🔴 Not Started | [research-existing-feature-integration.md](research-existing-feature-integration.md)         |
| 6   | Cross-Command Consistency        | 🟡 Medium | 🔴 Not Started | [research-cross-command-consistency.md](research-cross-command-consistency.md)               |

### Related Documents

- **[Exploration](../../explorations/explore-two-mode/README.md)** - Source exploration
- **[/explore Command](../../../.cursor/commands/explore.md)** - Current implementation
- **[/research Command](../../../.cursor/commands/research.md)** - Two-mode pattern reference
- **[/transition-plan Command](../../../.cursor/commands/transition-plan.md)** - Two-mode pattern reference

### Dependencies

- **[Four-Arm Architecture Exploration](../../explorations/four-arm-architecture/)** - ⚠️ **BLOCKING** - Foundational context for command patterns across ecosystem

---

## 🎯 Research Overview

This research supports enhancing the `/explore` command with three interconnected improvements:

1. **Two-Mode Pattern** - Setup + Conduct modes (like `/research` and `/transition-plan`)
2. **Explicit Input Sources** - Accept `start.txt`, reflections, and other sources
3. **Topic Unification** - Generalize `--topic [name] --type` pattern across commands

Additionally: 4. **Command Improvement Organization** - Consolidate `*-two-mode` features

**Research Topics:** 6 topics (3 High, 3 Medium priority)  
**Status:** 🔴 Research

---

## 📊 Research Status

| Research Topic                   | Priority  | Status         | Document                                                                                     |
| -------------------------------- | --------- | -------------- | -------------------------------------------------------------------------------------------- |
| Command Improvement Organization | 🔴 High   | ✅ Complete    | [research-command-improvement-organization.md](research-command-improvement-organization.md) |
| Topic Unification Pattern        | 🔴 High   | 🔴 Not Started | [research-topic-unification-pattern.md](research-topic-unification-pattern.md)               |
| Explore Input Sources            | 🔴 High   | 🔴 Not Started | [research-explore-input-sources.md](research-explore-input-sources.md)                       |
| Scaffolding Boundaries           | 🟡 Medium | 🔴 Not Started | [research-scaffolding-boundaries.md](research-scaffolding-boundaries.md)                     |
| Existing Feature Integration     | 🟡 Medium | 🔴 Not Started | [research-existing-feature-integration.md](research-existing-feature-integration.md)         |
| Cross-Command Consistency        | 🟡 Medium | 🔴 Not Started | [research-cross-command-consistency.md](research-cross-command-consistency.md)               |

---

## 🚀 Next Steps

**⏸️ PAUSED** - Complete four-arm architecture research first:

1. ~~Use `/research explore-two-mode --conduct --topic-num 1` to research Command Improvement Organization~~ ✅ Complete
2. **PIVOT:** `/research four-arm-architecture --from-explore four-arm-architecture` (setup)
3. **PIVOT:** `/research four-arm-architecture --conduct` (conduct all topics)
4. **PIVOT:** `/decision four-arm-architecture --from-research` (make decisions)
5. **RESUME:** Continue explore-two-mode topics 2-6 with refined context
6. Review requirements in `requirements.md`
7. Use `/decision explore-two-mode --from-research` to make decisions

---

**Last Updated:** 2025-12-31
