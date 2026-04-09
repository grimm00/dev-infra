# Agentic Workflow Modernization - Research Hub

**Purpose:** Research for modernizing dev-infra's workflow architecture (rules, skills, commands, AGENTS.md)
**Status:** 🔴 Research
**Created:** 2026-03-25
**Last Updated:** 2026-03-25

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research

### Research Documents

- **[Topic 1: Auto-Detection vs Explicit Invocation](topic-1-auto-detection.md)** - Gates all other decisions
- **[Topic 2: Three-Layer Redistribution Criteria](topic-2-redistribution-criteria.md)** - Sorting rubric for rules/skills/commands
- **[Topic 3: Command-to-Skill Conversion Mechanics](topic-3-conversion-mechanics.md)** - Practical conversion design
- **[Topic 4: Templates as Structural Schemas](topic-4-structural-schemas.md)** - Living structural contracts
- **[Topic 5: Cross-Platform Portability](topic-5-cross-platform-portability.md)** - Cursor vs Claude Code behavioral gaps
- **[Topic 6: Dual-Distribution Workflow](topic-6-dual-distribution.md)** - Templates + marketplace sync
- **[Topic 7: Conversation as Orchestration](topic-7-conversation-orchestration.md)** - Chat as pipeline (also a spike)
- **[Topic 8: Behavioral Contracts in Skills](topic-8-behavioral-contracts.md)** - Skill descriptions that hold
- **[Topic 9: AGENTS.md Portability](topic-9-agents-md-portability.md)** - ✅ Spiked
- **[Topic 10: Roadmap Layer Scope](topic-10-roadmap-layer.md)** - Deferred design question

---

## 🎯 Research Overview

This research investigates how dev-infra's 26+ commands, 3 always-applied rule files, and template system should be redistributed across the emerging four-layer model: AGENTS.md (portable conventions), platform-specific rules (`.mdc` / `CLAUDE.md`), skills (SKILL.md, portable procedural + behavioral workflows), and commands (simple triggers).

Two spikes have already been completed and inform this research:
- **Spike A:** AGENTS.md portability -- Partially Validated (Claude Code doesn't read AGENTS.md; four-layer model adjusted)
- **Spike B:** Command-to-skill conversion -- Validated (two archetypes: procedural vs behavioral; behavioral contracts compress and clarify)

**Research Topics:** 10 (Topics 9 and 10 are low-effort: 9 is spiked, 10 is deferred design)
**Active Research:** Topics 1-8
**Status:** 🔴 Research

---

## 📊 Research Status

| Topic | Priority | Status | Document |
|-------|----------|--------|----------|
| 1: Auto-Detection vs Explicit | High (GATE) | ✅ Complete | [topic-1-auto-detection.md](topic-1-auto-detection.md) |
| 2: Redistribution Criteria | High | ✅ Complete | [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) |
| 3: Conversion Mechanics | High | ✅ Complete | [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) |
| 4: Structural Schemas | Medium-High | ✅ Complete | [topic-4-structural-schemas.md](topic-4-structural-schemas.md) |
| 5: Cross-Platform Portability | Medium | ✅ Complete | [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) |
| 6: Dual-Distribution Workflow | Medium | ✅ Complete | [topic-6-dual-distribution.md](topic-6-dual-distribution.md) |
| 7: Conversation Orchestration | Medium-High | ✅ Complete | [topic-7-conversation-orchestration.md](topic-7-conversation-orchestration.md) |
| 8: Behavioral Contracts | Medium | 🔴 Not Started | [topic-8-behavioral-contracts.md](topic-8-behavioral-contracts.md) |
| 9: AGENTS.md Portability | High | ✅ Spiked | [topic-9-agents-md-portability.md](topic-9-agents-md-portability.md) |
| 10: Roadmap Layer Scope | Low | 🟡 Deferred | [topic-10-roadmap-layer.md](topic-10-roadmap-layer.md) |

---

## 🔗 Related Artifacts

- **Exploration:** `admin/explorations/agentic-workflow-modernization/exploration.md`
- **Research Topics:** `admin/explorations/agentic-workflow-modernization/research-topics.md`
- **Spike Learnings:** `admin/explorations/agentic-workflow-modernization/spike-learnings.md`
- **Draft Discuss Skill:** `admin/explorations/agentic-workflow-modernization/spike/discuss-skill/SKILL.md`
- **Narrative:** `admin/narratives/agentic-workflow-modernization/narrative.md`

---

## 🚀 Next Steps

1. ~~Conduct Topic 1 (auto-detection)~~ ✅ Complete
2. ~~Conduct Topic 2 (redistribution rubric)~~ ✅ Complete
3. ~~Conduct Topic 3 (conversion mechanics)~~ ✅ Complete -- **NOTE: FR-7 superseded by FR-10**
4. ~~Conduct Topic 5 (cross-platform portability)~~ ✅ Complete -- **NOTE: Topic 3 Finding 9 corrected (disable-model-invocation IS cross-platform)**
5. ~~Conduct Topic 6 (dual-distribution)~~ ✅ Complete -- **template-first authoring, publish script, C-3 audience split**
6. ~~Conduct Topic 7 (conversation orchestration)~~ ✅ Complete -- **conversational model validated, breakover criteria defined**
7. Conduct Topic 8 (behavioral contracts)
8. Run `--consolidate` after all topics complete

---

**Last Updated:** 2026-04-09

